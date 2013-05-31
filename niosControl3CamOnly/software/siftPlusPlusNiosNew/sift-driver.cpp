// file:        sift-driver.cpp
// author:      Andrea Vedaldi
// description: SIFT command line utility implementation

// AUTORIGTHS

#include"sift.hpp"
#include<sys/alt_timestamp.h>
#include  "altera_avalon_pio_regs.h"
#include "system.h"
#include<string>
#include<iostream>
#include<iomanip>
#include<fstream>
#include<sstream>
#include<algorithm>
#include <unistd.h>

extern "C" {
#include<getopt.h>
#include<assert.h>
#include<io.h>
#include<stdint.h>
}
#include<memory>

using namespace std ;

/*
GENERAL DATABASE COMMENTS
// The database is stored in bank 2 of SDRAM starting at physical
// address 0x2c0000 (7MB mark). This corresponds to a Nios
// address of 0xf000000. Since Nios stripes alternating blocks of
// the 2nd half of SDRAM into banks 2 and 3, we must skip a block
// of Nios memory to reach the next bank 2 contiguous physical address.
// That is, we store our database ONLY in bank 2, so that it is
// contiguous in the physical address space, but not in the Nios
// address space.
END GENERAL DATABASE COMMENTS
*/

// This struct is used to access the 128 byte descriptors
// stored in our database. Note that the descriptors come first
// before the point and object information. Our database consists
// of 3426 descriptors. We append 256 bytes of 0s to the end of this
// to complete the final block.
// Because of the striping between banks, the database descriptors
// are stored in every other block, 4 descriptors per block.
// We interlace (in Nios addressing) the first part of the database
// descriptors with the descriptors from the captured scene, thus
// placing the scene descriptors in bank 3 and allowing our
// matching hardware acceleration module to access contiguous blocks
// of physical memory.
struct descriptorsTwoBlocks
{
	uint8_t databaseDescriptors[4][128];
	// sceneDescriptors will be unused when we run out of scene descriptors,
	// which will always be much less than the database size
	uint8_t sceneDescriptors[4][128];
};

// This struct is used to access the database information related
// to a descriptor. Note that the first 3 bytes are unused. This
// allows us to store exactly 64 descriptors per block for easy access.
struct databaseDescriptorInfo
{
	uint8_t filler1;
	uint8_t filler2;
	uint8_t filler3;
	uint8_t objectID;
	uint8_t xBig;
	uint8_t xLittle;
	uint8_t yBig;
	uint8_t yLittle;
};

// We store the scene coordinates in the same size struct as
// the database descriptor info so that we can interlace the
// two in Nios memory and access the two sets of data in a similar
// fashion.
struct sceneDescriptorInfo
{
	uint8_t filler1;
	uint8_t filler2;
	uint8_t filler3;
	uint8_t filler4;
	uint8_t uBig;
	uint8_t uLittle;
	uint8_t vBig;
	uint8_t vLittle;
};

// In a similar fashion to the 128-byte descriptors themselves,
// we write the extra info to SDRAM in bank 2, and thus must
// skip every other block. This allows us to write only to bank 2
// when downloading the database to the board, rather than
// coming up with a more complex and time-consuming scheme to
// alternate between banks and interlace the structs with respect
// to Nios accesses.
struct descriptorInfoTwoBlocks
{
	struct databaseDescriptorInfo databaseInfos[64];
	// sceneInfos will be unused when we run out of scene descriptors,
	// which will always be much less than the database size
	struct sceneDescriptorInfo sceneInfos[64];
};

// This function takes an array of 128 floating point numbers representing a descriptor
// and the 0-based number of the current descriptor and stores the descriptor as bytes
// in SDRAM, interleaved with the database descriptors in Nios address space.
void convertAndStoreSceneDescriptor(VL::float_t const* descrPtr, unsigned int descrNum)
{
	unsigned int structNum = descrNum / 4; // which 2 block struct are we storing to?
	unsigned int descrOffset = descrNum % 4; // which scene descriptor index within that block?
	struct descriptorsTwoBlocks* theBlockPtr =
			(struct descriptorsTwoBlocks*)(DATABASE_START) + structNum; // get struct address

	for (int i = 0; i < 128; i++)
	{
		theBlockPtr->sceneDescriptors[descrOffset][i] = uint8_t(VL::float_t(512) * descrPtr[i]);
	} // for
} // convertAndStoreSceneDescriptor()


// This function stores the u, v coordinates for use with Michael's program to SDRAM.
// These coordinates are interleaved in Nios memory with the database info (baseline x,
// y coordinates, object IDs).
void storeSceneDescriptorInfo(VL::float_t x, VL::float_t y, unsigned int descrNum)
{
	// convert float x, y scene points to float u, v training image points
	VL::float_t const MICHAEL_SCALE_FACTOR = 1023.0 / 399.0;
	VL::float_t u = x * MICHAEL_SCALE_FACTOR;
	VL::float_t v = y * MICHAEL_SCALE_FACTOR;

	// round to nearest integer
	unsigned short uRound = (unsigned short)(u + 0.5);
	unsigned short vRound = (unsigned short)(v + 0.5);

	// cap at 1023 (just in case!)
	uRound = (uRound > 1023) ? 1023 : uRound;
	vRound = (vRound > 1023) ? 1023 : vRound;

	unsigned int structNum = descrNum / 64; // which 2 block struct are we storing to?
	unsigned int infoOffset = descrNum % 64; // which scene info index within that block?

	struct descriptorInfoTwoBlocks* theBlockPtr =
			(struct descriptorInfoTwoBlocks*)(DESCRIPTOR_INFO_START) + structNum; // get struct address

	// store the final u, v coordinates in the proper place
	// we store them as 4 bytes so that they're packaged and ready for the UART!
	theBlockPtr->sceneInfos[infoOffset].uBig = (uRound & 0xff00) >> 8;
	theBlockPtr->sceneInfos[infoOffset].uLittle = uRound & 0x00ff;
	theBlockPtr->sceneInfos[infoOffset].vBig = (vRound & 0xff00) >> 8;
	theBlockPtr->sceneInfos[infoOffset].vLittle = (vRound & 0x00ff);
} // storeSceneDescriptorInfo()

// returns the distance squared of the two 128 byte arrays descr1 and descr2.
int distSquared(uint8_t const *descr1, uint8_t const *descr2)
{
    int i, dif, distsq = 0;

    for (i = 0; i < 128; i++)
    {
      dif = (int)descr1[i] - (int)descr2[i];
      distsq += dif * dif;
    } // for

    return distsq;
} // distSquared()

// Given a scene descriptor, match it against the descriptors in the database
// and return the index of the match if found. Otherwise, return -1.
int checkForMatch(uint8_t* sceneDescr)
{
    int dsq, distsq1 = 100000000, distsq2 = 100000000;
    int minkey = -1;

    // Find the two closest matches, and put their squared distances in
    // distsq1 and distsq2.
    for (int databaseDescrNum = 0; databaseDescrNum < NUM_DATABASE_DESCRS; databaseDescrNum++)
    {
			unsigned int databaseStructNum = databaseDescrNum / 4; // which 2 block struct is the current database descriptor in?
			unsigned int databaseDescrOffset = databaseDescrNum % 4; // which database descriptor index within that block?
			// get struct address for current database descriptor
			struct descriptorsTwoBlocks* theDatabasePtr =
					(struct descriptorsTwoBlocks*)(DATABASE_START) + databaseStructNum;

    	dsq = distSquared(theDatabasePtr->databaseDescriptors[databaseDescrOffset], sceneDescr);

    	if (dsq < distsq1)
    	{
    		distsq2 = distsq1;
    		distsq1 = dsq;
    		minkey = databaseDescrNum;
    	} // if
    	else if (dsq < distsq2)
    	{
    		distsq2 = dsq;
    	} // else if
    } // for

    // Check whether closest distance is less than 0.6 of second.
    if (10 * 10 * distsq1 < 7 * 7 * distsq2)
      return minkey;

    return -1;
} // checkForMatch()

void findDatabaseMatches(int numSceneDescrs)
{
	for (int sceneDescrNum = 0; sceneDescrNum < numSceneDescrs; sceneDescrNum++)
	{
		unsigned int sceneStructNum = sceneDescrNum / 4; // which 2 block struct is the current scene descriptor in?
		unsigned int sceneDescrOffset = sceneDescrNum % 4; // which scene descriptor index within that block?
		// get struct address for current scene descriptor
		struct descriptorsTwoBlocks* theScenePtr =
				(struct descriptorsTwoBlocks*)(DATABASE_START) + sceneStructNum;

		int matchIndex = checkForMatch(theScenePtr->sceneDescriptors[sceneDescrOffset]);

		if (matchIndex != -1)
		{
			unsigned int databaseMatchInfoStructNum = matchIndex / 64;
			unsigned int databaseMatchInfoOffset = matchIndex % 64;

			struct descriptorInfoTwoBlocks* theDatabaseInfoPtr =
					(struct descriptorInfoTwoBlocks*)(DESCRIPTOR_INFO_START) + databaseMatchInfoStructNum;

			unsigned int sceneMatchInfoStructNum = sceneDescrNum / 64;
			unsigned int sceneMatchInfoOffset = sceneDescrNum % 64;

			struct descriptorInfoTwoBlocks* theSceneInfoPtr =
					(struct descriptorInfoTwoBlocks*)(DESCRIPTOR_INFO_START) + sceneMatchInfoStructNum;

			uint8_t xBig = theDatabaseInfoPtr->databaseInfos[databaseMatchInfoOffset].xBig;
			uint8_t xLittle = theDatabaseInfoPtr->databaseInfos[databaseMatchInfoOffset].xLittle;
			uint8_t yBig = theDatabaseInfoPtr->databaseInfos[databaseMatchInfoOffset].yBig;
			uint8_t yLittle = theDatabaseInfoPtr->databaseInfos[databaseMatchInfoOffset].yLittle;
			uint8_t objID = theDatabaseInfoPtr->databaseInfos[databaseMatchInfoOffset].objectID;

			uint8_t uBig = theSceneInfoPtr->sceneInfos[sceneMatchInfoOffset].uBig;
			uint8_t uLittle = theSceneInfoPtr->sceneInfos[sceneMatchInfoOffset].uLittle;
			uint8_t vBig = theSceneInfoPtr->sceneInfos[sceneMatchInfoOffset].vBig;
			uint8_t vLittle = theSceneInfoPtr->sceneInfos[sceneMatchInfoOffset].vLittle;

			unsigned short xCoord = (xBig << 8) + xLittle;
			unsigned short yCoord = (yBig << 8) + yLittle;
			unsigned short uCoord = (uBig << 8) + uLittle;
			unsigned short vCoord = (vBig << 8) + vLittle;

			printf("match found (ID = %d): (x, y) = (%d, %d)...(u, v) = (%d, %d)\n", objID, xCoord, yCoord, uCoord, vCoord);
		} // if
	} // for
} // findDatabaseMatches()

/*
int DistSquared(unsigned char *descr1, unsigned char *descr2)
{
    int i, dif, distsq = 0;

    for (i = 0; i < 128; i++) {
      dif = (int) *descr1++ - (int) *descr2++;
      distsq += dif * dif;
    }
    return distsq;
}
*/

/*
int CheckForMatch(uint8_t* descr1, uint8_t* descr2)
{
    int dsq, distsq1 = 100000000, distsq2 = 100000000;
    int minkey = -1;


    // Find the two closest matches, and put their squared distances in
    //   distsq1 and distsq2.

    for (int i = 0; i < NUM_DESCR; i++)
    {
    	dsq = DistSquared(baselineDesc[i], descr1);

    	if (dsq < distsq1) {
    		distsq2 = distsq1;
    		distsq1 = dsq;
    		minkey = i;
    	} else if (dsq < distsq2) {
    		distsq2 = dsq;
    	}
    }

    // Check whether closest distance is less than 0.6 of second.
    if (10 * 10 * distsq1 < 7 * 7 * distsq2)
      return minkey;

    return -1;
}
*/

/*
int FindMatches(VL::float_t *descr_pt, bool useSDRAMdesc)
{
	unsigned char descrBytes[128];


	for (int i = 0; i < 128; i++)
		descrBytes[i] = (unsigned char)(descr_pt[i] * 512);

	return CheckForMatch(descrBytes, 0);
}
*/

void extractImageData(VL::PgmBuffer& buffer)
{
  //VL::pixel_t* im_pt = new VL::pixel_t[IMAGE_WIDTH*IMAGE_HEIGHT];
  VL::pixel_t* im_pt = (VL::pixel_t*)BASE_ADDRESS;
  VL::pixel_t* start = im_pt;
	unsigned int x, y, byteNum, blockNum, offset;
	unsigned short* imgPtr = 0;
	unsigned short intensityVal;
	float maxVal = 0.0;
	float minVal = 1.0;
	float floatIntensity;

  buffer.width  = IMAGE_WIDTH ;
  buffer.height = IMAGE_HEIGHT ;
  buffer.data   = im_pt ;

	for (y = 0; y < IMAGE_HEIGHT; y++)
	{
		for (x = 0; x < IMAGE_WIDTH; x++)
		{
				byteNum = (y*640 + x);
        blockNum = byteNum / 256;
        offset = byteNum % 256;

        // this offset is in terms of shorts (= byte offset / 2)
        // read from the second of the two locations used to store
        //	pixel (x,y)'s data, and write to the first
        imgPtr = (unsigned short*)BASE_ADDRESS + 512*blockNum + offset + 256;

        intensityVal = *(imgPtr) & 0x3ff;
        //intensityValSmall = intensityVal >> 2;

        floatIntensity = intensityVal / 1023.0f;

        if (floatIntensity > maxVal)
        	maxVal = floatIntensity;
        if (floatIntensity < minVal)
        	minVal = floatIntensity;

        *start++ = floatIntensity;
		}
	}

//	VL::pixel_t *end = start;

//	for (start = im_pt; start != end; start++)
//		*start = (*start - minVal) / (maxVal - minVal);

//	cout << "im_pt: " << im_pt << endl;
//	cout << "maxVal: " << maxVal << endl;
//	cout << "minVal: " << minVal << endl;
	//cout << im_pt - SIFT_DATA_START <<endl;

}

// moveImageToVGA
// This function copies a pixel_t image to the correct location
// to be displayed via VGA.
// The pixel_t image does not have to be the full size of the VGA (IMAGE_WIDTH x IMAGE_HEIGHT)
// but can instead be a subregion, defined by imgWidth and imgHeight,
// located on the screen at coordinates (VGAoffsetX, VGAoffsetY).
// The parts of the VGA image that are not part of the pixel_t image
// are set to a default color, set by backgroundBlue and backgroundRed,
// so that although the pixel_t part of the VGA image will be greyscale,
// the border can be any solid color.
// intensityMax and intensityMin set what float values are to be converted to white
// and black, respectively. pixel_t values out of this range are acceptable and will saturate
// to either full white or full black, depending on which side of the boundary they cross.
void moveImageToVGA(VL::pixel_t* imgPtr, float intensityMax, float intensityMin, int imgWidth, int imgHeight, int VGAoffsetX, int VGAoffsetY)
{
	// yellow background
	unsigned short backgroundBlue = 0xf000;
	unsigned short backgroundRed  = 0xffff;

	VL::pixel_t pixelIntensity;
	unsigned short ushortIntensity;

	int x, y, byteNum, blockNum, offset;
	unsigned short *vgaPtr = 0;
	imgPtr += imgWidth * imgHeight;

	// process vga pixels in reverse order,
	// in case VGA was overwritten with the image.
	// We will write to the red parts of all pixels first
	// Then after we will copy those to the blue parts
	for (y = 480-1; y >= 0; y--)
	{
		for (x = 640-1; x >= 0; x--)
		{
			// calculate VGA/SDRAM red pixel address
			byteNum = (y*640 + x);
			blockNum = byteNum / 256;
			offset = byteNum % 256;
			vgaPtr = (unsigned short*)BASE_ADDRESS + 512*blockNum + offset + 256;

			// check if out of bounds of image
			if ( (y < VGAoffsetY) || (y >= VGAoffsetY + imgHeight) ||
					(x < VGAoffsetX) || (x >= VGAoffsetX + imgWidth) )
			{
				// out of bounds, write default background color
				*vgaPtr = backgroundRed;
				continue;
			}

			// if we reach this point, we are in bounds of image
			// read in intensity value
			pixelIntensity = *(--imgPtr);

			// make sure pixel is not over or under saturated
			if (pixelIntensity > intensityMax)
				pixelIntensity = intensityMax ;
			if (pixelIntensity < intensityMin)
				pixelIntensity = intensityMin ;

			// normalize to 1024
			pixelIntensity = 1023.0 * (pixelIntensity - intensityMin) / (intensityMax - intensityMin);

			// round and convert to unsigned short
			ushortIntensity = (unsigned short)(pixelIntensity + 0.5);

			// save red to SDRAM
			*vgaPtr = ((0x001f & ushortIntensity) << 10) | ushortIntensity;
		}
	}


	// Now copy the blue parts
	for (y = 480-1; y >= 0; y--)
	{
		for (x = 640-1; x >= 0; x--)
		{
			// calculate VGA/SDRAM blue pixel address
			byteNum = (y*640 + x);
			blockNum = byteNum / 256;
			offset = byteNum % 256;
			vgaPtr = (unsigned short*)BASE_ADDRESS + 512*blockNum + offset;

			// check if out of bounds of image
			if ( (y < VGAoffsetY) || (y >= VGAoffsetY + imgHeight) ||
					(x < VGAoffsetX) || (x >= VGAoffsetX + imgWidth) )
			{
				// out of bounds, write default background color
				*vgaPtr = backgroundBlue;
				continue;
			}

			// if we reach this point, we are in bounds of image
			// read in intensity value
			ushortIntensity = 0x03ff & * (vgaPtr + 256);

			// copy red to blue in SDRAM
			*vgaPtr = ((0x03e0 & ushortIntensity) << 5) | ushortIntensity;
		}
	}

}
void writePixelAt(int x, int y, unsigned short r, unsigned short g, unsigned short b)
{
	r &= 0x3ff;
	g &= 0x3ff;
	b &= 0x3ff;

	if ((x<0) | (x>=640)) return;
	if ((y<0) | (y>=480)) return;
	int byteNum = (y*640 + x);
	int blockNum = byteNum / 256;
	int offset = byteNum % 256;
	unsigned short *vgaPtr = (unsigned short*)BASE_ADDRESS + 512*blockNum + offset;

	*(vgaPtr + 256) = r + ((g & 0x1F) << 10);
	*vgaPtr = b + ((g & 0x3E) << 10);
}

void writeRedPixelAt(int x, int y)
{
	writePixelAt(x,y,0x3ff,0,0);
}

void drawLine(int x0, int y0, int x1, int y1, unsigned short r, unsigned short g, unsigned short b)
{
	// Bresenham's line algorithm

	int dx = abs(x1-x0);
	int dy = abs(y1-y0);
	int sx, sy, err, e2;
	if (x0 < x1) sx = 1;
	else sx = -1;
	if (y0 < y1) sy = 1;
	else sy = -1;
	err = dx-dy;

	while (true)
	{
		writePixelAt(x0,y0,r,g,b);
		if ((x0 == x1) && (y0 == y1)) break;
		e2 = 2*err;
		if (e2 > -dy)
		{
			err -= dy;
			x0 += sx;
		}
		if (e2 < dx)
		{
			err += dx;
			y0 += sy;
		}
	}
}

void drawCircle(int x0, int y0, int radius, unsigned short r, unsigned short g, unsigned short b)
{
	// Bresenham's circle algorithm
	int f = 1 - radius;
	int ddF_x = 1;
	int ddF_y = -2*radius;
	int x = 0;
	int y = radius;
	writePixelAt(x0,y0+radius,r,g,b);
	writePixelAt(x0,y0-radius,r,g,b);
	writePixelAt(x0+radius,y0,r,g,b);
	writePixelAt(x0-radius,y0,r,g,b);
	while (x < y)
	{
		if (f >= 0)
		{
			y--;
			ddF_y += 2;
			f += ddF_y;
		}
		x++;
		ddF_x += 2;
		f += ddF_x;
		writePixelAt(x0+x,y0+y,r,g,b);
		writePixelAt(x0-x,y0+y,r,g,b);
		writePixelAt(x0+x,y0-y,r,g,b);
		writePixelAt(x0-x,y0-y,r,g,b);
		writePixelAt(x0+y,y0+x,r,g,b);
		writePixelAt(x0-y,y0+x,r,g,b);
		writePixelAt(x0+y,y0-x,r,g,b);
		writePixelAt(x0-y,y0-x,r,g,b);
	}
}

// -------------------------------------------------------------------
//                                                                main
// -------------------------------------------------------------------
int main()
{

	/*
	FILE *fp = fopen("/dev/uart_0", "w");

	if (fp)
	{
		cout << "Connected to UART.\n";
		fprintf(fp, "hello, Ubuntu");
		fclose(fp);
	}
	*/



	/*
	for(unsigned short *s=(unsigned short*)0x800000; s < (unsigned short*)0x1000000; s++)
		*s = 0x0000;
	alt_dcache_flush_all();
	int i;
	unsigned short *s0 = (unsigned short*)(0xfff800);
	for (i = 0, s0=s0; s0 < (unsigned short*)0x1000000; s0++, i++)
	{
		*s0 = 0x3000 + i;
		if (*s0 != (0x2000 + i))
			cout << "error\n";
	}
alt_dcache_flush_all();
	for (i = 0, s0=(unsigned short*)(0xfff800); s0 < (unsigned short*)0x1000000; s0++, i++)
	{
		if (*s0 != (0x3000 + i))
			cout << "error\n";
	}
	cout << "done writing\n";
	exit(1);
*/


	//struct descriptorsTwoBlocks* theStructPtr;

	//theStructPtr = (struct descriptorsTwoBlocks*)0xf00000;
	//cout << sizeof(struct descriptorsTwoBlocks) << endl;
/*
	for (int i = 0; i < 4; i++)
	{
		cout << "database\n";
		for (int j = 0; j < 128; j++)
			printf("%i %d: %x\n", i, j, uint32_t(theStructPtr->databaseDescriptors[i][j]));
		//cout << "scene\n";
		//for (int j = 0; j < 128; j++)
		//	printf("%i %d: %x\n", i, j, uint32_t(theStructPtr->sceneDescriptors[i][j]));
	}
	theStructPtr++;
	for (int i = 0; i < 4; i++)
	{
		cout << "database\n";
		for (int j = 0; j < 128; j++)
			printf("%i %d: %x\n", i, j, uint32_t(theStructPtr->databaseDescriptors[i][j]));
		//cout << "scene\n";
		//for (int j = 0; j < 128; j++)
		//	printf("%i %d: %x\n", i, j, uint32_t(theStructPtr->sceneDescriptors[i][j]));
	}
	*/
	/*struct descriptorInfo* theStructPtr2;
	theStructPtr2 = (struct descriptorInfo*)0xfd6400;
	for (int i = 0; i < 2; i++)
	{
		cout << "object ID: " << uint32_t(theStructPtr2->objectID) << endl;
		cout << "xLittle: " << uint32_t(theStructPtr2->xLittle) << endl;
		cout << "xBig: " << uint32_t(theStructPtr2->xBig) << endl;
		cout << "yLittle: " << uint32_t(theStructPtr2->yLittle) << endl;
		cout << "yBig: " << uint32_t(theStructPtr2->yBig) << endl;
		theStructPtr2++;
	}

	exit(1);
	*/

	// give SDRAM control to Nios
	PROC_CONTROL_ON;

  int    first          = 0 ;
  int    octaves        = 6 ;
  int    levels         = 2 ;
  VL::float_t  threshold      (0.04f / levels / 2.0f) ;
  VL::float_t  edgeThreshold  (10.0f);
  VL::float_t  magnif         (3.0) ;
  int descrNum = 0;
  VL::PgmBuffer buffer ;

  // write red except in the 400x400 window that we will process
  for (int x = 0; x < 640; x++)
  {
	  for (int y = IMAGE_HEIGHT; y < 480; y++)
	  {
		  writePixelAt(x, y, 0x3ff, 0, 0);
	  }
  }
  for (int x = IMAGE_WIDTH; x < 640; x++)
  {
	  for (int y = 0; y < 480; y++)
	  {
		  writePixelAt(x, y, 0x3ff, 0, 0);
	  }
  }

  // relinquish SDRAM control so we can verify that the image fits in
  // the reduced 400x400 frame
  PROC_CONTROL_OFF;
	cout << "displaying for 10 seconds before continuing...";
	usleep(10*1000*1000);
	cout << "done\n";
	PROC_CONTROL_ON;

  // -----------------------------------------------------------------
  //                                            Retrieve input image
  // -----------------------------------------------------------------

	extractImageData(buffer);
      
  // ---------------------------------------------------------------
  //                                            Gaussian scale space
  // ---------------------------------------------------------------

  cout << "siftpp: computing Gaussian scale space\n";
      
  int         O      = octaves ;
  int const   S      = levels ;
  VL::float_t const sigman(.5) ;
  VL::float_t const sigma0(1.6 * powf(2.0f, 1.0f / S)) ;
      
  cout << "siftpp:   number of octaves     : " << O << endl
       << "siftpp:   levels per octave     : " << S
       << endl ;

  // loop over the octaves
  for (int omin = first; omin < O; omin++)
  {
    cout << "siftpp:   current octave        : " << omin << endl;

    // initialize scalespace
    // one octave at a time, 2 levels, start with omin
    VL::Sift sift(buffer.data, buffer.width, buffer.height,
        					sigman, sigma0,
        					1, S,
        					omin, -1, S+1) ;
      
    cout << "siftpp: Gaussian scale space completed\n";

    // -------------------------------------------------------------
    //                                             Run SIFT detector
    // -------------------------------------------------------------

    cout << "siftpp: running detector\n";
	
    sift.detectKeypoints(threshold, edgeThreshold) ;
	
    cout << "siftpp: detector completed with "
         << sift.keypointsEnd() - sift.keypointsBegin()
         << " keypoints\n";

    // -------------------------------------------------------------
    //            Compute orientations and descriptors
    // -------------------------------------------------------------

    // set descriptor options
    sift.setNormalizeDescriptor(1) ;
    sift.setMagnification(magnif) ;

    cout << "siftpp: computing orientations and descriptors..." ;

    for(VL::Sift::KeypointsConstIter iter = sift.keypointsBegin();
	       iter != sift.keypointsEnd(); ++iter)
    {
      // detect orientations
      VL::float_t angles[4];
      int nangles;

      nangles = sift.computeKeypointOrientations(angles, *iter) ;

      // compute descriptors
      for(int a = 0; a < nangles; ++a) {
        // compute descriptor
        VL::float_t floatDescr[128] ;

        // get the descriptor in floating point format
        sift.computeKeypointDescriptor(floatDescr, *iter, angles[a]) ;

        // convert the descriptor to byte format and store in SDRAM
        convertAndStoreSceneDescriptor(floatDescr, descrNum);
        // store descriptor point information
        storeSceneDescriptorInfo(iter->x, iter->y, descrNum);
        // increment the overall descriptor number counter
        descrNum++;

        /*match = FindMatches(descr_pt, 0);

        if (match != -1)
        {
        	cout << "match at " << (iter->ix << iter->o) << ", " << (iter->iy << iter->o) <<endl;;
        }
        */
      } // next angle
    } // next keypoint

    cout << "done\n" ;
	} // next octave

  // now check for matches!
  int numDescrs = descrNum - 1;
  findDatabaseMatches(numDescrs);

  cout << "writing extracted image data to VGA...";
  moveImageToVGA(buffer.data, 1.0, 0.0, buffer.width, buffer.height, 0, 0);
	cout << "siftpp: job completed\n";

	PROC_CONTROL_OFF; // give control back to VGA

  while(1); // loop forever

  return 0 ;
} // main()

/*
 * util.cpp
 *
 */

#include "util.hpp"

using namespace std;

int sendBytesToUART(const uint8_t* data, int n)
{
	FILE* fp = fopen("/dev/uart_0", "w");

	if (fp)
	{
		fwrite(data, 1, n, fp);
		fclose(fp);
		return 0;
	}

	cout << "sendBytesToUART: UART connection failure\n";
	return -1;
}

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



void waitForUserAdvance()
{
	usleep(1*1000*1000); // so we don't get a false switch flip if the user is
	// terrible at flipping the switch

	// read initial value of SW[17]
	unsigned int initialSwitchVal = 	IORD_ALTERA_AVALON_PIO_DATA(FP_RESULT_BASE);

	while (initialSwitchVal == (unsigned int)IORD_ALTERA_AVALON_PIO_DATA(FP_RESULT_BASE))
	{
		// do nothing
	} // while switch is not toggled
}


void extractImageData(VL::PgmBuffer& buffer)
{
  //VL::pixel_t* im_pt = new VL::pixel_t[IMAGE_WIDTH*IMAGE_HEIGHT];
  VL::pixel_t* im_pt = (VL::pixel_t*)SDRAM_0_BASE;
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

	for (y = FRAME_Y_OFFSET; y < IMAGE_HEIGHT + FRAME_Y_OFFSET; y++)
	{
		for (x = FRAME_X_OFFSET; x < IMAGE_WIDTH + FRAME_X_OFFSET; x++)
		{
				byteNum = (y*640 + x);
        blockNum = byteNum / 256;
        offset = byteNum % 256;

        // this offset is in terms of shorts (= byte offset / 2)
        // read from the second of the two locations used to store
        //	pixel (x,y)'s data, and write to the first
        imgPtr = (unsigned short*)SDRAM_0_BASE + 512*blockNum + offset + 256;

        intensityVal = *(imgPtr) & 0x3ff;
        //intensityValSmall = intensityVal >> 2;

        floatIntensity = intensityVal / 1023.0f;

        if (floatIntensity > maxVal)
        	maxVal = floatIntensity;
        if (floatIntensity < minVal)
        	minVal = floatIntensity;

        *start++ = floatIntensity;
		} // for
	} // for

//	VL::pixel_t *end = start;

//	for (start = im_pt; start != end; start++)
//		*start = (*start - minVal) / (maxVal - minVal);

} // extractImageData()


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
			vgaPtr = (unsigned short*)SDRAM_0_BASE + 512*blockNum + offset + 256;

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
			vgaPtr = (unsigned short*)SDRAM_0_BASE + 512*blockNum + offset;

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
	unsigned short *vgaPtr = (unsigned short*)SDRAM_0_BASE + 512*blockNum + offset;

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

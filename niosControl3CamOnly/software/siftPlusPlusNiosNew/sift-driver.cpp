// file:        sift-driver.cpp
// author:      Andrea Vedaldi
// description: SIFT command line utility implementation

// AUTORIGTHS

#include "match.hpp"
#include <iostream>

extern "C"
{
#include<io.h>
#include<unistd.h>
}
using namespace std ;

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

// -------------------------------------------------------------------
//                                                                main
// -------------------------------------------------------------------
int main()
{
	// bytes to send Michael's program when we want to tell it to move on
	const uint8_t advance[9] = {0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11, 0x00};

	// run SIFT...forever!
	while (true)
	{
		// ---------------------------------------------------------------
		//        Camera calibration
		// ---------------------------------------------------------------
		cout << "Beginning calibration.\n";

		// prepare the camera to run and capture, then start it running
		IOWR_ALTERA_AVALON_PIO_DATA(FP_OP_TYPE_BASE, OPCODE_RESET_CAPTURE);
		IOWR_ALTERA_AVALON_PIO_DATA(FP_OP_TYPE_BASE, OPCODE_RESET_RUN);
		IOWR_ALTERA_AVALON_PIO_DATA(FP_OP_TYPE_BASE, OPCODE_RUN);

		// here, we wait until SW[17] is toggled by the user before advancing
		// to the next image
		IOWR_ALTERA_AVALON_PIO_DATA(FP_OP_TYPE_BASE, OPCODE_WAIT_SWITCH);

		// calibration image 1
		waitForUserAdvance();
		sendBytesToUART(advance, 9);
		// calibration image 2
		waitForUserAdvance();
		sendBytesToUART(advance, 9);
		// calibration image 3
		waitForUserAdvance();
		sendBytesToUART(advance, 9);
		// calibration image 4
		waitForUserAdvance();
		sendBytesToUART(advance, 9);
		// calibration image 5
		waitForUserAdvance();
		// wait 2 seconds before sending final advance so that
		// camera is stabilized
		usleep(2*1000*1000);
		cout << "Calibration complete.\n";
		sendBytesToUART(advance, 9);

		// ---------------------------------------------------------------
		//        Capture the image
		// ---------------------------------------------------------------

		cout << "Capturing image.\n";
		// capture effectively happens as soon as we write the opcode
		IOWR_ALTERA_AVALON_PIO_DATA(FP_OP_TYPE_BASE, OPCODE_CAPTURE);

		// ---------------------------------------------------------------
		//        SIFT parameters
		// ---------------------------------------------------------------

		int first = 0;
		int octaves = 6;
		int levels = 2;
		VL::float_t  threshold(0.04f / levels / 2.0f) ;
		VL::float_t  edgeThreshold(10.0f);
		VL::float_t  magnif(3.0);
		VL::float_t const sigman(.5) ;
		VL::float_t const sigma0(1.6 * powf(2.0f, 1.0f / levels)) ;

		int descrNum = 0; // index of the current scene descriptor

		// -----------------------------------------------------------------
		//                                            Retrieve input image
		// -----------------------------------------------------------------

		PROC_CONTROL_ON; // give SDRAM control to Nios

		VL::PgmBuffer buffer;
		extractImageData(buffer);

		// ---------------------------------------------------------------
		//                                            Gaussian scale space
		// ---------------------------------------------------------------

		cout << "siftpp: computing Gaussian scale space\n";

		// loop over the octaves
		for (int omin = first; omin < octaves; omin++)
		{
			cout << "siftpp:   current octave        : " << omin << endl;

			// initialize scalespace
			// one octave at a time, 2 levels, start with omin
			VL::Sift sift(buffer.data, buffer.width, buffer.height,
										sigman, sigma0,
										1, levels,
										omin, -1, levels+1) ;

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
				for(int a = 0; a < nangles; ++a)
				{
					VL::float_t floatDescr[128] ;

					// get the descriptor in floating point format
					sift.computeKeypointDescriptor(floatDescr, *iter, angles[a]) ;

					// convert the descriptor to byte format and store in SDRAM
					convertAndStoreSceneDescriptor(floatDescr, descrNum);
					// store descriptor point information
					storeSceneDescriptorInfo(iter->x, iter->y, descrNum);

					// increment the overall descriptor number counter
					descrNum++;
				} // next angle
			} // next keypoint

			cout << "done\n" ;
		} // next octave

		// -------------------------------------------------------------
		//       Now match the scene descriptors against the database!
		// -------------------------------------------------------------
	
		int numDescrs = descrNum;
		findDatabaseMatches(numDescrs);
	
		// -------------------------------------------------------------
		//       We're done with this image!
		// -------------------------------------------------------------
		sendBytesToUART(advance, 9); // final advance signaling that we're done
		PROC_CONTROL_OFF; // give control back to VGA
		cout << "siftpp: job completed\n";

	} // while true

  return 0 ;
} // main()

// file:        sift-driver.cpp
// author:      Andrea Vedaldi
// description: SIFT command line utility implementation

// AUTORIGTHS

#include"sift.hpp"

#include<string>
#include<iostream>
#include<iomanip>
#include<fstream>
#include<sstream>
#include<algorithm>
#include<bitset>
#include <unistd.h>

extern "C" {
#include<getopt.h>
#include<assert.h>
#include<io.h>
}
#include<memory>

using namespace std ;



/* keypoint list */
typedef vector<pair<VL::Sift::Keypoint,VL::float_t> > Keypoints ;

/* predicate used to order keypoints by increasing scale */
bool cmpKeypoints (Keypoints::value_type const&a,
		   Keypoints::value_type const&b) {
  return a.first.sigma < b.first.sigma ;
}

void extractImageData(VL::PgmBuffer& buffer)
{
  VL::pixel_t* im_pt = (VL::pixel_t*)0x92c000;
  VL::pixel_t* start = im_pt;
	unsigned int x, y, byteNum, blockNum, offset;
	unsigned short* imgPtr = 0;
	unsigned short intensityVal;
	float maxVal = 0.0;
	float minVal = 1.0;
	float floatIntensity;

  buffer.width  = 320 ;
  buffer.height = 240 ;
  buffer.data   = im_pt ;

	for (y = 0; y < 240; y++)
	{
		for (x = 0; x < 320; x++)
		{
				byteNum = (y*320 + x);
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

void replaceImageData()
{
  VL::pixel_t* im_pt = (VL::pixel_t*)BASE_ADDRESS;
	unsigned int x, y, byteNum, blockNum, offset;
	unsigned short *imgPtr = 0;

	for (y = 0; y < 240; y++)
	{
		for (x = 0; x < 320; x++)
		{
				byteNum = (y*640 + x);
        blockNum = byteNum / 256;
        offset = byteNum % 256;

        // this offset is in terms of shorts (= byte offset / 2)
        // read from the second of the two locations used to store
        //	pixel (x,y)'s data, and write to the first
        imgPtr = (unsigned short*)BASE_ADDRESS + 256*blockNum + byteNum;
        *imgPtr = *(imgPtr + 256) = (unsigned short)((*im_pt++ * 255.0f) * 4);
		}
	}

	cout << "im_pt2: " << im_pt << endl;

}
// moveImageToVGA
// This function copies a pixel_t image to the correct location
// to be displayed via VGA.
// The pixel_t image does not have to be the full size of the VGA (640 x 480)
// but can instead be a subregion, defined by imgWidth and imgHeight,
// located on the screen at coordinates (VGAoffsetX, VGAoffsetY).
// The parts of the VGA image that are not part of the pixel_t image
// are set to a default color, set by backgroundBlue and backgroundRed,
// so that although the pixel_t part of the VGA image will be greyscale,
// the border can be any solid color.
// intensityMax and intensityMin set what float values are to be converted to white
// and black, respectively. pixel_t values out of this range are acceptable and will saturate
// to either full white or full black, depending on which side of the boundary they cross.
void moveImageToVGA(VL::pixel_t* imgPtr, float intensityMax, float intensityMin, unsigned int imgWidth, unsigned int imgHeight, unsigned int VGAoffsetX, unsigned int VGAoffsetY)
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
	for (y = 239; y >= 0; y--)
	{
		for (x = 319; x >= 0; x--)
		{
			// calculate VGA/SDRAM red pixel address
			byteNum = (y*320 + x);
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
	for (y = 239; y >= 0; y--)
	{
		for (x = 319; x >= 0; x--)
		{
			// calculate VGA/SDRAM blue pixel address
			byteNum = (y*320 + x);
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
	if ( x < 0 || x > 319 ) return;
	if ( y < 0 || y > 239 ) return;
	r &= 0x3ff;
	g &= 0x3ff;
	b &= 0x3ff;
	int byteNum = (y*320 + x);
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
int
main(int argc, char** argv)
{
	PROC_CONTROL_OFF;
	usleep(10*1000*1000);
	// Switch control to processor
	// Otherwise heap allocations and sdram access
	// will not work properly
	PROC_CONTROL_ON;

	// move heap past camera image in SDRAM. We don't want the image being
	// overwritten or the heap being corrupted
	//VL::pixel_t* OriginalImage = (VL::pixel_t*) new VL::pixel_t[640*480];
/*
	//
	// Code I used to write a test square to VGA part of SDRAM using
	// the moveImageToVGA function and prove that it works
	int i = 100; // square size
	// allocate space for float representation of the image
	VL::pixel_t* floatImage = (VL::pixel_t*) new VL::pixel_t[i*i];
	// set image data, a diagonal gradient
	for (int y = 0; y < i; y++)
		for (int x = 0; x < i; x++)
			*(floatImage + (i*y + x)) = x + y;
	cout << "started writing test image to screen\n";
	moveImageToVGA(floatImage, (float)(2*(i-1)), 0.0, i, i, 50, 50);
	delete [] floatImage;
	PROC_CONTROL_OFF;
	cout << "finished writing test image to screen\n";
	cout << "displaying for 60 seconds before continuing\n";
	usleep(60*1000*1000);
	PROC_CONTROL_ON;
	//
*/

  int    first          = 0 ;
  int    octaves        = 3 ;
  int    levels         = 2 ;
  VL::float_t  threshold      (0.001f / levels / 2.0f) ;
  VL::float_t  edgeThreshold  (10.0f);
  VL::float_t  magnif         (3.0) ;
  int    verbose        = 1 ;

  VL::PgmBuffer buffer ;

  cout << "Hello!\n";
  extractImageData(buffer);

  cout << "siftpp: done extracting floats\n" ;
/*
	cout << "writing extracted image data to VGA...";
	moveImageToVGA(buffer.data, 1.0, 0.0, buffer.width, buffer.height, 80, 60);
	PROC_CONTROL_OFF;
	cout << "done\n";
	cout << "displaying for 10 seconds before continuing...";
	usleep(10*1000*1000);
	PROC_CONTROL_ON;
	cout << "done\n";
*/
  //replaceImageData();
  // -----------------------------------------------------------------
  //                                            Retrieve input image
  // -----------------------------------------------------------------
  // ON NIOS, SUBSTITUTE SDRAM IMAGE READ HERE

  /*
  unsigned int x, y, byteNum, blockNum, offset;
	unsigned short *imgPtr = 0;
	unsigned short intensityVal;
	unsigned char intensityValSmall;

  for (y = 0; y < 480; y++)
  {
    for (x = 0; x < 640; x++)
    {
    	if (y >= 60 && y <= 420 && x >= 80 && x <= 560) {
      byteNum = (y*640 + x);
      blockNum = byteNum / 256;
      offset = byteNum % 256;

      // imgPtr and BASE_ADDRESS are type unsigned char, so
      // 	 this adds a byte offset, which is what we want
      //imgPtr = BASE_ADDRESS + 2*byteNum + 512*blockNum;

      // this offset is in terms of shorts (= byte offset / 2)
      imgPtr = BASE_ADDRESS + 256*blockNum + byteNum;

      intensityVal = *(imgPtr) & 0x3ff;
      intensityValSmall = intensityVal >> 2;


      // write blue to the screen
      if (x % 3 == 0 || y%2 == 0)
      {
      	*(imgPtr) = 0x03ff;
      	*(imgPtr + 256) = 0x0000; // (256 = 512 bytes / 2)

      	//IOWR_16DIRECT(BASE_ADDRESS, 2*byteNum + 512*blockNum, 0x03ff);
      	//IOWR_16DIRECT(BASE_ADDRESS, 2*byteNum + 512*blockNum + 512, 0x0000);
      }
      else
      {
      	*(imgPtr) = 0x0000;
      	*(imgPtr + 256) = 0x03ff; // (256 = 512 bytes / 2)

      	//IOWR_16DIRECT(BASE_ADDRESS, 2*byteNum + 512*blockNum, 0x0000);
        //IOWR_16DIRECT(BASE_ADDRESS, 2*byteNum + 512*blockNum + 512, 0x03ff);
      }

    	}
    } // for each x
  } // for each y

*/


  //verbose && cout
  //      << " read "
  //      << buffer.width  <<" x "
  //      << buffer.height <<" pixels"
  //      << endl ;
      
  // ---------------------------------------------------------------
  //                                            Gaussian scale space
  // ---------------------------------------------------------------
  verbose && cout
        << "siftpp: computing Gaussian scale space" 
        << endl ;
      
  int         O      = octaves ;
  int const   S      = levels ;
  VL::float_t const sigman(.5) ;
  VL::float_t const sigma0(1.6 * powf(2.0f, 1.0f / S)) ;
      
  verbose && cout
        << "siftpp:   number of octaves     : " << O << endl
        << "siftpp:   levels per octave     : " << S
        << endl ;

  for (int omin = first; omin < first+O; omin++)
  {
    cout << "siftpp:   current octave        : " << omin << endl;

    // initialize scalespace
    VL::Sift sift(buffer.data, buffer.width, buffer.height,
        sigman, sigma0,
        1, S,
		    omin, -1, S+1) ;

    cout << "siftpp: done computing scale space\n" ;

    verbose && cout
        << "siftpp: Gaussian scale space completed"
        << endl ;
      

    // -------------------------------------------------------------
    //                                             Run SIFT detector
    // -------------------------------------------------------------
    verbose && cout
          << "siftpp: running detector  "<< endl;
	
    sift.detectKeypoints(threshold, edgeThreshold) ;

    cout << "siftpp: done detecting\n" ;
	
    verbose && cout
          << "siftpp: detector completed with " 
          << sift.keypointsEnd() - sift.keypointsBegin() 
          << " keypoints" 
          << endl ;

    for (VL::Sift::KeypointsConstIter iter = sift.keypointsBegin();
    			iter != sift.keypointsEnd(); ++iter)
    {
    	drawCircle((1 << omin)*iter->ix , (1 << omin)*iter->iy , 5*(2+iter->s),0,0,0x3ff);
    	writeRedPixelAt((1 << omin)*iter->ix , (1 << omin)*iter->iy );
    }
      
    // -------------------------------------------------------------
    //                  Run SIFT orientation detector and descriptor
    // -------------------------------------------------------------
/*
    // set descriptor options
    sift.setNormalizeDescriptor( 1 ) ;
    sift.setMagnification( magnif ) ;

    verbose && cout << "siftpp: computing orientations and descriptors\n" ;
      
    // -------------------------------------------------------------
    //            Run detector, compute orientations and descriptors
    // -------------------------------------------------------------
    for( VL::Sift::KeypointsConstIter iter = sift.keypointsBegin() ;
	       iter != sift.keypointsEnd() ; ++iter ) {
	    
      // detect orientations
      VL::float_t angles [4] ;
      int nangles ;

      nangles = sift.computeKeypointOrientations(angles, *iter) ;
      cout << "siftpp: done computing orientation\n" ;
	    
      // compute descriptors
      for(int a = 0 ; a < nangles ; ++a) {
        // compute descriptor
        VL::float_t descr_pt [128] ;
        sift.computeKeypointDescriptor(descr_pt, *iter, angles[a]) ;
        cout << "siftpp: done computing descriptor\n" ;
      } // next angle
    } // next keypoint

    cout << "siftpp: done computing all orientations and descriptors\n" ;

    */
	} // next octave

	verbose && cout
          << "siftpp: job completed"<<endl ;

	PROC_CONTROL_OFF;

  return 0 ;
} // main()

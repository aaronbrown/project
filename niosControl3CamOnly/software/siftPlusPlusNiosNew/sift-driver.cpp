// file:        sift-driver.cpp
// author:      Andrea Vedaldi
// description: SIFT command line utility implementation

// AUTORIGTHS

// Modified from its original version for the Shape SIFTers' EEC 181 design project.

#include "match.hpp"
#include "database.hpp"
#include <iostream>

extern "C"
{
#include<io.h>
#include<unistd.h>
}
using namespace std ;


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
		// after a manual reset with KEY[0], the camera RUN state machine
		// needs a short delay so that the RUN command is received after
		// the hardware generated reset_n signal goes high again; otherwise
		// the camera will not start running here in the case of a manual
		// reset, and we do not like this behavior.
		usleep(1*1000*1000);
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
		// wait 1 second before sending final advance so that
		// camera is stabilized
		usleep(1*1000*1000);

		cout << "Calibration complete.\n";
		sendBytesToUART(advance, 9);

		// ---------------------------------------------------------------
		//        Capture the image
		// ---------------------------------------------------------------

		cout << "Capturing image.\n";
		// wait 3 seconds to give the camera time to expose the image
		usleep(3*1000*1000);
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
	
		cout << "Matching against database...";

		int numDescrs = descrNum;
		findDatabaseMatches(numDescrs);

		cout << "done\n";
	
		// -------------------------------------------------------------
		//       We're done with this image!
		// -------------------------------------------------------------

		sendBytesToUART(advance, 9); // final advance signaling that we're done
		PROC_CONTROL_OFF; // give control back to VGA
		cout << "siftpp: job completed\n";

	} // while true

  return 0 ;
} // main()

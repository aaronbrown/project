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
	// read initial value of SW[17]
	unsigned int initialSwitchVal = 	IORD_ALTERA_AVALON_PIO_DATA(FP_RESULT_BASE);

	while (initialSwitchVal == (unsigned int)IORD_ALTERA_AVALON_PIO_DATA(FP_RESULT_BASE))
	{
		// do nothing
	} // while switch is not toggled
}

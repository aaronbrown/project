/*
 * util.hpp
 *
 */

#ifndef UTIL_HPP_
#define UTIL_HPP_

#include "sift.hpp"
#include "database.hpp"
#include "altera_avalon_pio_regs.h"
#include "system.h"

extern "C"
{
#include "stdio.h"
#include "stdint.h"
#include "unistd.h"
}


// opcodes for hardware communication
#define OPCODE_EXP 0x00
#define OPCODE_RESET_CAPTURE 0xdd
#define OPCODE_RESET_RUN 0xbb
#define OPCODE_RUN 0xcc
#define OPCODE_WAIT_SWITCH 0xee
#define OPCODE_CAPTURE 0xff


int sendBytesToUART(const uint8_t* data, int n);
void convertAndStoreSceneDescriptor(VL::float_t const* descrPtr, unsigned int descrNum);
void storeSceneDescriptorInfo(VL::float_t x, VL::float_t y, unsigned int descrNum);
void waitForUserAdvance();

void extractImageData(VL::PgmBuffer& buffer);

// the following set of functions were used extensively during testing, but are no longer needed
void moveImageToVGA(VL::pixel_t* imgPtr, float intensityMax, float intensityMin, int imgWidth, int imgHeight, int VGAoffsetX, int VGAoffsetY);
void writePixelAt(int x, int y, unsigned short r, unsigned short g, unsigned short b);
void writeRedPixelAt(int x, int y);
void drawLine(int x0, int y0, int x1, int y1, unsigned short r, unsigned short g, unsigned short b);
void drawCircle(int x0, int y0, int radius, unsigned short r, unsigned short g, unsigned short b);


#endif /* UTIL_HPP_ */

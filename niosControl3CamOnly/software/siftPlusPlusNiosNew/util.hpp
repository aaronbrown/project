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
}

int sendBytesToUART(const uint8_t* data, int n);
void convertAndStoreSceneDescriptor(VL::float_t const* descrPtr, unsigned int descrNum);
void storeSceneDescriptorInfo(VL::float_t x, VL::float_t y, unsigned int descrNum);
void waitForUserAdvance();


#endif /* UTIL_HPP_ */

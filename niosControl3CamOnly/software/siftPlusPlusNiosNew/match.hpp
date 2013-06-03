/*
 * match.hpp
 *
 *  Created on: Jun 1, 2013
 *      Author: Justin
 */

#ifndef MATCH_HPP_
#define MATCH_HPP_

extern "C"
{
#include <stdint.h>
#include <stdio.h>
}
#include "database.hpp"
#include "util.hpp"

int distSquared(uint8_t const *descr1, uint8_t const *descr2);
int checkForMatch(uint8_t* sceneDescr);
void scanAndSendHardwareGeneratedMatches(int numSceneDescrs);
void findDatabaseMatches(int numSceneDescrs);

#endif /* MATCH_HPP_ */

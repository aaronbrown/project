/*
 * match.cpp
 *
 */

#include "match.hpp"

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

			const uint8_t pointData[9] = {objID, xLittle, xBig, yLittle, yBig, uLittle, uBig, vLittle, vBig};
			sendBytesToUART(pointData, 9);

			printf("match found (ID = %d): (x, y) = (%d, %d)...(u, v) = (%d, %d)\n", objID, xCoord, yCoord, uCoord, vCoord);
		} // if
	} // for
} // findDatabaseMatches()

/*
 * database.hpp
 *
 */

#ifndef DATABASE_HPP_
#define DATABASE_HPP_

// database parameters
#define DATABASE_START 0xf00000
#define DESCRIPTOR_INFO_START 0xfd6400
#define NUM_DATABASE_DESCRS 3426

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


struct hardwareMatchIndices
{
	uint16_t filler[256];
	uint16_t matchIndices[256];
};

#endif /* DATABASE_HPP_ */

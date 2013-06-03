module HWAcceleration(
		//	HOST Side
      REF_CLK,
		CLK,
		FIFOCLOCK,
		iStart,
		iSceneDescriptorCount,
		iDatabaseDescriptorCount,
		oDone,
		//	SDRAM Side
        SA,
        BA,
        CS_N,
        CKE,
        RAS_N,
        CAS_N,
        WE_N,
        DQ,
        DQM
        );

		  
`define  ASIZE           23      // total address width of the SDRAM
`define  DSIZE           16      // Width of data bus to SDRAMS
	
		  
		  //	HOST Side
input                      REF_CLK;                //System Clock
input 							CLK;
input 							FIFOCLOCK; 
input 							iStart; 
input 	[11:0]				iSceneDescriptorCount;
input 	[11:0]				iDatabaseDescriptorCount;
output 							oDone; 
//	SDRAM Side
output  [11:0]                  SA;                     //SDRAM address output
output  [1:0]                   BA;                     //SDRAM bank address
output  [1:0]                   CS_N;                   //SDRAM Chip Selects
output                          CKE;                    //SDRAM clock enable
output                          RAS_N;                  //SDRAM Row address Strobe
output                          CAS_N;                  //SDRAM Column address Strobe
output                          WE_N;                   //SDRAM write enable
inout   [`DSIZE-1:0]            DQ;                     //SDRAM data bus
output  [`DSIZE/8-1:0]          DQM;                    //SDRAM data mask lines

reg rStart, rStartDelayed;
always @ (posedge FIFOCLOCK) begin
	rStart <= iStart;
	rStartDelayed <= rStart;
end
wire RESET_N;
assign RESET_N = 1'b1;
wire [15:0] WR1_DATA, RD1_DATA, RD2_DATA;
wire Write1, Write2, Read1, Read2, Reset1, Reset2;
Sdram_Control_4Port	u7	(	//	HOST Side						
						    .REF_CLK(REF_CLK),
						    .RESET_N(RESET_N),
							.CLK(CLK),
							//	FIFO Write Side 1 (for writing results over scene descriptors)
							.WR1_DATA(WR1_DATA),
							.WR1(Write1),
							.WR1_ADDR(22'h3c0000),
							.WR1_MAX_ADDR(22'h3c0000 + 64 * iSceneDescriptorCount),
							.WR1_LENGTH(9'h100),
							.WR1_LOAD(Reset2),
							.WR1_CLK(FIFOCLOCK),
							
							//.WR1_USE(LEDS[8:0]),
/*
							//	FIFO Write Side 2
							.WR2_DATA({1'b0,GaussianConvResult[6:2],GaussianConvResult[11:2]}),
							.WR2(Write),
							.WR2_ADDR(WR2_ADDR),
							.WR2_MAX_ADDR(WR2_MAX_ADDR),
							.WR2_LENGTH(WR2_LENGTH),
							.WR2_LOAD(FifoReset),
							.WR2_CLK(FIFOCLOCK),
*/

							//	FIFO Read Side 1 (DB keypoints)
						   .RD1_DATA(RD1_DATA),
				        	.RD1(Read1),
				        	.RD1_ADDR(22'h2c0000),
							.RD1_MAX_ADDR(22'h2c0000 + 64 * iDatabaseDescriptorCount),
							.RD1_LENGTH(9'h100),
							.RD1_LOAD(Reset1),
							.RD1_CLK(FIFOCLOCK),
							
							//	FIFO Read Side 2 (Scene keypoints)
						    .RD2_DATA(RD2_DATA),
							.RD2(Read2),
							.RD2_ADDR(22'h3c000),
							.RD2_MAX_ADDR(22'h3c0000 + 64 * iSceneDescriptorCount),
							.RD2_LENGTH(9'h100),
				        	.RD2_LOAD(Reset2),
							.RD2_CLK(FIFOCLOCK),
							
							//	SDRAM Side
						    .SA(SA),
						    .BA(BA),
        					.CS_N(CS_N),
        					.CKE(CKE),
        					.RAS_N(RAS_N),
        					.CAS_N(CAS_N),
        					.WE_N(WE_N),
        					.DQ(DQ),
        					.DQM(DQM)
						);
wire iStart_Posedge;
assign iStart_Posedge = (rStart && !rStartDelayed) ? 1'b1 : 1'b0;

MatchAllDescriptors MatchAllDescriptors_inst (
      .iClk(FIFOCLOCK),   // Input clock
      .iDatabaseDescriptor(RD1_DATA), 
      .iSceneDescriptor(RD2_DATA),
		.iDatabaseDescriptorCount(iDatabaseDescriptorCount),
		.iSceneDescriptorCount(iSceneDescriptorCount),
		.iStart(iStart_Posedge),
		.oReadDatabaseDescriptor(Read1),
		.oReadSceneDescriptor(Read2),
		.oResetDatabaseDescriptor(Reset1),
		.oResetSceneDescriptor(Reset2),
		.oDatabaseMatchIndex(WR1_DATA),
		.oWriteDatabaseMatchIndex(Write1),
		.oDone(oDone)
        );

endmodule

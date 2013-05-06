module HWAcceleration(
		//	HOST Side
        REF_CLK,
        RESET_N,
		CLK,
		GO,
		FIFOCLOCK,
		LEDS,
		//	FIFO Write Side 1
        WR1_DATA,
		WR1,
		WR1_ADDR,
		WR1_MAX_ADDR,
		WR1_LENGTH,
		WR1_LOAD,
		WR1_CLK,
		WR1_FULL,
		WR1_USE,
		//	FIFO Write Side 2
        WR2_DATA,
		WR2,
		WR2_ADDR,
		WR2_MAX_ADDR,
		WR2_LENGTH,
		WR2_LOAD,
		WR2_CLK,
		WR2_FULL,
		WR2_USE,
		//	FIFO Read Side 1
        RD1_DATA,
		RD1,
		RD1_ADDR,
		RD1_MAX_ADDR,
		RD1_LENGTH,
		RD1_LOAD,	
		RD1_CLK,
		RD1_EMPTY,
		RD1_USE,
		//	FIFO Read Side 2
        RD2_DATA,
		RD2,
		RD2_ADDR,
		RD2_MAX_ADDR,
		RD2_LENGTH,
		RD2_LOAD,
		RD2_CLK,
		RD2_EMPTY,
		RD2_USE,
		//	SDRAM Side
        SA,
        BA,
        CS_N,
        CKE,
        RAS_N,
        CAS_N,
        WE_N,
        DQ,
        DQM,
        );

		  
`define  ASIZE           23      // total address width of the SDRAM
`define  DSIZE           16      // Width of data bus to SDRAMS
	
		  
		  //	HOST Side
input                           REF_CLK;                //System Clock
input                           RESET_N;                //System Reset
input 							CLK;
input 							GO; // Run through hardware acceleration
input 							FIFOCLOCK; 
output 				[17:0]		LEDS;
//	FIFO Write Side 1
input   [`DSIZE-1:0]            WR1_DATA;               //Data input
input							WR1;					//Write Request
input	[`ASIZE-1:0]			WR1_ADDR;				//Write start address
input	[`ASIZE-1:0]			WR1_MAX_ADDR;			//Write max address
input	[8:0]					WR1_LENGTH;				//Write length
input							WR1_LOAD;				//Write register load & fifo clear
input							WR1_CLK;				//Write fifo clock
output							WR1_FULL;				//Write fifo full
output	[8:0]					WR1_USE;				//Write fifo usedw
//	FIFO Write Side 2
input   [`DSIZE-1:0]            WR2_DATA;               //Data input
input							WR2;					//Write Request
input	[`ASIZE-1:0]			WR2_ADDR;				//Write start address
input	[`ASIZE-1:0]			WR2_MAX_ADDR;			//Write max address
input	[8:0]					WR2_LENGTH;				//Write length
input							WR2_LOAD;				//Write register load & fifo clear
input							WR2_CLK;				//Write fifo clock
output							WR2_FULL;				//Write fifo full
output	[8:0]					WR2_USE;				//Write fifo usedw
//	FIFO Read Side 1
output  [`DSIZE-1:0]            RD1_DATA;               //Data output
input							RD1;					//Read Request
input	[`ASIZE-1:0]			RD1_ADDR;				//Read start address
input	[`ASIZE-1:0]			RD1_MAX_ADDR;			//Read max address
input	[8:0]					RD1_LENGTH;				//Read length
input							RD1_LOAD;				//Read register load & fifo clear
input							RD1_CLK;				//Read fifo clock
output							RD1_EMPTY;				//Read fifo empty
output	[8:0]					RD1_USE;				//Read fifo usedw
//	FIFO Read Side 2
output  [`DSIZE-1:0]            RD2_DATA;               //Data output
input							RD2;					//Read Request
input	[`ASIZE-1:0]			RD2_ADDR;				//Read start address
input	[`ASIZE-1:0]			RD2_MAX_ADDR;			//Read max address
input	[8:0]					RD2_LENGTH;				//Read length
input							RD2_LOAD;				//Read register load & fifo clear
input							RD2_CLK;				//Read fifo clock
output							RD2_EMPTY;				//Read fifo empty
output	[8:0]					RD2_USE;				//Read fifo usedw
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

//	Internal Registers/Wires
//	Controller

reg [31:0] ImageSize = 320*240;
reg [7:0] StartupLatency = 50;
reg [7:0] OperationsLatency = 1;
reg Going = 0;
reg rGO = 0;
assign LEDS[17:0] = Count[17:0];
always @ (posedge FIFOCLOCK) begin
	rGO <= GO;
	if ( rGO == 0 && Count == ImageSize + StartupLatency + OperationsLatency )
		Going <= 0;
	else if ( rGO == 1 && Count == 0 )
		Going <= 1;
	else 
		Going <= Going;
end

reg [31:0] Count = 0;
	
always @ (posedge FIFOCLOCK) begin
	if ( Going == 0 ) 
	Count <= 0;
	else if ( FIFO_HALT == 1 || Count == ImageSize + StartupLatency + OperationsLatency )
	Count <= Count;
	else 
	Count <= Count + 1;
end

wire FifoReset = WR1_LOAD;//( Going == 0 && rGO == 1 );
wire Read;
wire Write;
wire Reset;

assign Read = (!FIFO_HALT)&&((Count < ImageSize + StartupLatency) && (Count >= StartupLatency));
assign Write = (!FIFO_HALT)&&((Count < ImageSize + StartupLatency + OperationsLatency) && (Count >= StartupLatency + OperationsLatency));
assign Reset = ( Count == 0 );

wire [15:0] RD1_DATA;
wire [15:0] RD2_DATA;
wire WRITE_FIFO_FULL;
wire READ_FIFO_EMPTY;
wire FIFO_HALT;
assign FIFO_HALT = WRITE_FIFO_FULL | READ_FIFO_EMPTY;
wire [8:0] RD1_USE;
wire [11:0] GaussianConvResult;
wire [23:0] GaussianConvResultTemp;
assign GaussianConvResultTemp = 12'b000010110111*(Row0Col0+Row0Col2+Row2Col0+Row2Col2)+12'b000111110100*(Row0Col1+Row1Col0+Row1Col2+Row2Col1)+12'b010101001111*Row1Col1;
assign GaussianConvResult = GaussianConvResultTemp[23:12];
// Pixel Registers
reg [11:0] Row0Col0, Row0Col1, Row0Col2;
reg [11:0] Row1Col0, Row1Col1, Row1Col2;
reg [11:0] Row2Col0, Row2Col1, Row2Col2;
always @ (posedge FIFOCLOCK) begin
	if (Read) begin
		Row0Col0 <= Row0Col1;
		Row0Col1 <= Row0Col2;
		Row0Col2 <= LBufOut2;
		Row1Col0 <= Row1Col1;
		Row1Col1 <= Row1Col2;
		Row1Col2 <= LBufOut1;
		Row2Col0 <= Row2Col1;
		Row2Col1 <= Row2Col2;
		Row2Col2 <= RD1_DATA[11:0];
	end else begin
		Row0Col0 <= Row0Col0;
		Row0Col1 <= Row0Col1;
		Row0Col2 <= Row0Col2;
		Row1Col0 <= Row1Col0;
		Row1Col1 <= Row1Col1;
		Row1Col2 <= Row1Col2;
		Row2Col0 <= Row2Col0;
		Row2Col1 <= Row2Col1;
		Row2Col2 <= Row2Col2;
	end
end
wire [11:0] LBufOut1, LBufOut2;
Line_Buffer 	u0	(	.clken(Read),
						.clock(FIFOCLOCK),
						.shiftin(RD1_DATA[11:0]),
						.taps({LBufOut2,LBufOut1}	)
						);
Sdram_Control_4Port	u7	(	//	HOST Side						
						    .REF_CLK(REF_CLK),
						    .RESET_N(RESET_N),
							.CLK(CLK),
							//	FIFO Write Side 1
							.WR1_DATA({1'b0,GaussianConvResult[11:7],GaussianConvResult[11:2]}),
							.WR1(Write),
							.WR1_ADDR(WR1_ADDR),
							.WR1_MAX_ADDR(WR1_MAX_ADDR),
							.WR1_LENGTH(WR1_LENGTH),
							.WR1_LOAD(FifoReset),
							.WR1_CLK(FIFOCLOCK),
							
							.WR1_FULL(WRITE_FIFO_FULL),
							//.WR1_USE(LEDS[8:0]),

							//	FIFO Write Side 2
							.WR2_DATA({1'b0,GaussianConvResult[6:2],GaussianConvResult[11:2]}),
							.WR2(Write),
							.WR2_ADDR(WR2_ADDR),
							.WR2_MAX_ADDR(WR2_MAX_ADDR),
							.WR2_LENGTH(WR2_LENGTH),
							.WR2_LOAD(FifoReset),
							.WR2_CLK(FIFOCLOCK),


							//	FIFO Read Side 1
						    .RD1_DATA(RD1_DATA),
				        	.RD1(Read),
				        	.RD1_ADDR(RD1_ADDR),
							.RD1_MAX_ADDR(RD1_MAX_ADDR),
							.RD1_LENGTH(RD1_LENGTH),
							.RD1_LOAD(FifoReset),
							.RD1_CLK(FIFOCLOCK),
							.RD1_USE(RD1_USE),
							
							//	FIFO Read Side 2
						    .RD2_DATA(RD2_DATA),
							.RD2(Read),
							.RD2_ADDR(RD2_ADDR),
							.RD2_MAX_ADDR(RD2_MAX_ADDR),
							.RD2_LENGTH(RD2_LENGTH),
				        	.RD2_LOAD(FifoReset),
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



endmodule

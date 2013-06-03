// 
// This module determines distance between 2 descriptors.
// There are two 2-byte inputs, one for each descriptor.
// Descriptors are passed in 2 bytes at a time, over 64 clock cycles.
// 
// For continuous operation, follow the waveform below
// iDesc values 1,2,3,...,63,64 refer to the 
// 2-byte pair number of the descriptor
//
//          STARTUP                           REPEAT THIS PART FOR CONTINUOUS OPERATION
//             __    __    __    __           __    __    __    __    __    __    __    __ 
// iClk     __|  |__|  |__|  |__|  |__|  //  |  |__|  |__|  |__|  |__|  |__|  |__|  |__|  |
//                      _____                          _____                               
// iStart   ___________|     |_________  //  _________|     |______________________________
//          ___________ _____ _____ ___      ___ _____ _____ _____ _____ _____ _____ _____
// iDesc    ___??______X__1__X__2__X__3  //  63_X__64_X__1__X__2__X__3__X__4__X__5__X__6__X
//          ___________________________      _______________________________ _____ ________
// oDist    __________max______________  //  ___________max_________________X_DistX___max__
//                                                                           _____         
// oDist_Val___________________________  //  _______________________________|     |________
//
//  
// INTERNAL SIGNALS:
//          ______________ _____ _____        _____ _____ _____ _____ _____ _______________
// Count    ______0_______X__1__X__2__X  //  X__63_X__0__X__1__X__2__X__3__X__4__X__5__X__6



module TwoDescriptorDistance(
      iClk,   // Input clock
      iStart, // Active-high synchronous start signal
		iDesca, // Descriptor 1, 2-byte pair input
		iDescb, // Descriptor 2, 2-byte pair input
		oDist,  // Output distance
		oDist_Valid   // Output distance is valid
        );

		  
input          iClk;
input          iStart;
input  [15:0]  iDesca;
input  [15:0]  iDescb;
output [22:0]  oDist;
output         oDist_Valid;


// Calculation signals
reg  [7:0] minuend1, minuend2;            // the "a" in a - b = c
reg  [7:0] subtrahend1, subtrahend2;      // the "b" in a - b = c
reg  [7:0] difference1, difference2;      // the "c" in a - b = c
reg  [15:0] square1, square2;             // difference squared
reg  [21:0] accumulation1, accumulation2; // sum of squares for a descriptor
wire [15:0] Desc1 = {iDesca[7:0], iDescb[7:0]};
wire [15:0] Desc2 = {iDesca[15:8], iDescb[15:8]};
reg iStartd, iStartdd, iStartddd;
reg Lastd, Lastdd, Lastddd, Lastdddd, Lastddddd;
reg [22:0] Dist;

// output distance if we just finished calculating valid data
assign oDist_Valid = (Lastddddd == 1'b1) ? 1'b1 : 1'b0;
assign oDist = (oDist_Valid) ? Dist : 23'h7fffff;

// Control signals
reg  [5:0] Count = 0;      // counts through the descriptor input
wire Last; // True on input of 64th 2-byte pair

// Control logic
assign Last = (Count == 6'b111111) ? 1'b1 : 1'b0;
always @ (posedge iClk) begin
	if (iStart) begin
		Count <= 6'b1;
	end else begin
		if (Count != 6'b0) Count <= Count + 1;
		else Count <= 1'b0;
	end
end


// delayed start and output signal
always @ (posedge iClk) begin
	Lastddddd <= Lastdddd;
	Lastdddd <= Lastddd;
	Lastddd <= Lastdd;
	Lastdd <= Lastd;
	Lastd <= Last;
	iStartddd <= iStartdd;
	iStartdd <= iStartd;
	iStartd <= iStart;
	Dist <= accumulation1 + accumulation2;
end

// Calculation logic (first half)
always @ (posedge iClk) begin
	if (Desc1[15:8] > Desc1[7:0]) begin
		minuend1 <= Desc1[15:8];
		subtrahend1 <= Desc1[7:0];
	end else begin
		minuend1 <= Desc1[7:0];
		subtrahend1 <= Desc1[15:8];
	end
	difference1 <= minuend1 - subtrahend1;
	square1 <= difference1 * difference1;
	if (iStartddd == 1'b1) accumulation1 <= square1;
	else accumulation1 <= accumulation1 + square1;
end

// Calculation logic (second half)
always @ (posedge iClk) begin
	if (Desc2[15:8] > Desc2[7:0]) begin
		minuend2 <= Desc2[15:8];
		subtrahend2 <= Desc2[7:0];
	end else begin
		minuend2 <= Desc2[7:0];
		subtrahend2 <= Desc2[15:8];
	end
	difference2 <= minuend2 - subtrahend2;
	square2 <= difference2 * difference2;
	if (iStartddd == 1'b1) accumulation2 <= square2;
	else accumulation2 <= accumulation2 + square2;
end

endmodule

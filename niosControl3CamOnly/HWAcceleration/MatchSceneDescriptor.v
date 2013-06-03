// 
// This module determines distance between 2 descriptors.
// There are two 2-byte inputs, one for each descriptor.
// Descriptors are passed in 2 bytes at a time, over 64 clock cycles.
// 
// For continuous operation, follow the waveform below
// iDesc values 1,2,3,...,63,64 refer to the 
// 2-byte pair number of the descriptor
//

//          LOAD SCENE DESCRIPTOR            FINISH LOADING DESCRIPTOR      
//                                           START DB DESCRIPTORS                
//                                           REPEAT FOR ALL DB DESCRIPTORS
//             __    __    __    __           __    __    __    __    __    __    __    __    
// iClk     __|  |__|  |__|  |__|  |__|  //  |  |__|  |__|  |__|  |__|  |__|  |__|  |__|  |__|
//                      _____                                           
// iStartSc ___________|     |_________  //  _________________________________________________
//                                                     _____            
// iStartDa ___________________________  //  _________|     |_________________________________
//          ___________ _____ _____ ___      ___ _____ _____ _____ _____ _____ _____ _____ ___
// iDesc    ___??______X__1__X__2__X__3  //  63_X__64_X__1__X__2__X__3__X__4__X__5__X__6__X__7
//                                                 
// oMatch   ___________________________  //  ___________________________________
//                                                                                 _____
// oMatch_Val__________________________  //  _____________________________________|     |__
//                                           
//                                           
// INTERNAL SIGNALS:                         
//          ___________________________      _______________________________ _____ ___________
// oDist    __________max______________  //  ___________max_________________X_DistX___max_____
//                                                                           _____
// oDist_Val___________________________  //  _______________________________|     |___________




module MatchSceneDescriptor(
      iClk,   // Input clock
      iStartSceneDescriptorLoad, // Active-high synchronous start signal
      iStartDatabaseDescriptorsLoad, // Active-high synchronous start signal
		iDesc, // Descriptor 2-byte pair input
		oMatch, // Output a match
		oMatchIndex, // Output a match
		oMatch_Valid // oMatch is valid
        );

		  
input          iClk;
input          iStartSceneDescriptorLoad;
input          iStartDatabaseDescriptorsLoad;
input  [15:0]  iDesc;
output         oMatch;
output [11:0]  oMatchIndex;
output reg     oMatch_Valid;


wire [22:0] oDist;
wire oDist_Valid;
wire [15:0] FifoInput, FifoOutput;
reg [15:0] ShiftRegister[63:0];
// Calculation signals
reg  [5:0] Count = 0;      // counts through the descriptor input
reg  [5:0] CountScene = 0;
reg [22:0] DistShortest1 = 23'h7fffff; // shortest distance found for this scene descriptor
reg [22:0] DistShortest2 = 23'h7fffff; // second shortest distance found for this scene descriptor
reg [11:0] DistShortestIndex1 = 12'hfff; // index of shortest distance found for this scene descriptor
reg [11:0] DatabaseDescriptorIndex = 12'hfff;
assign oMatch = ({DistShortest1,1'b0} < {1'b0,DistShortest2}) ? 1'b1 : 1'b0; // Match if shortest distance*2 < 2nd shortest distance
assign oMatchIndex = DistShortestIndex1;

reg SceneWasLast = 1'b0;
always @ (posedge iClk) begin
	if (iStartSceneDescriptorLoad) SceneWasLast <= 1'b1;
	else if (iStartDatabaseDescriptorsLoad) SceneWasLast <= 1'b0;
	else SceneWasLast <= SceneWasLast;
end
reg [31:0] iStartSceneDescriptorLoadDelay;
always @ (posedge iClk) iStartSceneDescriptorLoadDelay <= {iStartSceneDescriptorLoadDelay[30:0],iStartSceneDescriptorLoad};
// Calculation logic 
always @ (posedge iClk) begin
	if (iStartSceneDescriptorLoadDelay[31]) begin // start loading database, reset saved stuff
		DistShortest1 <= DistShortest1;
		DistShortest2 <= DistShortest2;
		DistShortestIndex1 <= DistShortestIndex1;
		DatabaseDescriptorIndex <= 12'h0;
		oMatch_Valid <= 1'b0;
	end else if (iStartDatabaseDescriptorsLoad && SceneWasLast) begin
		DistShortest1 <= 23'h7fffff;
		DistShortest2 <= 23'h7fffff;
		DistShortestIndex1 <= 12'hfff;
		DatabaseDescriptorIndex <= DatabaseDescriptorIndex;
		oMatch_Valid <= 1'b0;
	end else if (oDist_Valid) begin
		if (oDist < DistShortest1) begin // new shortest distance
			DistShortest1 <= oDist;
			DistShortest2 <= DistShortest1;
			DistShortestIndex1 <= DatabaseDescriptorIndex;
		end else if (oDist < DistShortest2) begin // new second shortest distance
			DistShortest1 <= DistShortest1;
			DistShortest2 <= oDist;
			DistShortestIndex1 <= DistShortestIndex1;
		end else begin // distance not short enough to record
			DistShortest1 <= DistShortest1;
			DistShortest2 <= DistShortest2;
			DistShortestIndex1 <= DistShortestIndex1;
		end
		DatabaseDescriptorIndex <= DatabaseDescriptorIndex + 1;
		oMatch_Valid <= 1'b1;
	end else begin // nothing interesting is happening, preserve values
		DistShortest1 <= DistShortest1;
		DistShortest2 <= DistShortest2;
		DistShortestIndex1 <= DistShortestIndex1;
		DatabaseDescriptorIndex <= DatabaseDescriptorIndex;
		oMatch_Valid <= 1'b0;
	end
end

TwoDescriptorDistance TwoDescriptorDistance_inst (
      .iClk(iClk),   // Input clock
      .iStart(iStartDatabaseDescriptorsLoad), // Active-high synchronous start signal
		.iDesca(FifoOutput), // Descriptor 1, 2-byte pair input
		.iDescb(iDesc), // Descriptor 2, 2-byte pair input
		.oDist(oDist),   // Output distance
		.oDist_Valid(oDist_Valid) // Distance output is valid
		);

wire Full;
wire SceneDescriptorLoad;
assign SceneDescriptorLoad = (iStartSceneDescriptorLoad || (CountScene != 0)) ? 1'b1 : 1'b0;
assign FifoInput = (SceneDescriptorLoad) ? iDesc : FifoOutput;


always @ (posedge iClk) begin
	if (iStartDatabaseDescriptorsLoad) begin
		Count <= 6'b1;
	end else begin
		if (Count != 6'b0) Count <= Count + 1;
		else Count <= 1'b0;
	end
end

always @ (posedge iClk) begin
	if (iStartSceneDescriptorLoad) begin
		CountScene <= 6'b1;
	end else begin
		if (CountScene != 6'b0) CountScene <= CountScene + 1;
		else CountScene <= 1'b0;
	end
end

	
assign FifoOutput = ShiftRegister[63];
always @ (posedge iClk) begin
	ShiftRegister[0] <= FifoInput;
	ShiftRegister[1] <= ShiftRegister[0];
	ShiftRegister[2] <= ShiftRegister[1];
	ShiftRegister[3] <= ShiftRegister[2];
	ShiftRegister[4] <= ShiftRegister[3];
	ShiftRegister[5] <= ShiftRegister[4];
	ShiftRegister[6] <= ShiftRegister[5];
	ShiftRegister[7] <= ShiftRegister[6];
	ShiftRegister[8] <= ShiftRegister[7];
	ShiftRegister[9] <= ShiftRegister[8];
	ShiftRegister[10] <= ShiftRegister[9];
	ShiftRegister[11] <= ShiftRegister[10];
	ShiftRegister[12] <= ShiftRegister[11];
	ShiftRegister[13] <= ShiftRegister[12];
	ShiftRegister[14] <= ShiftRegister[13];
	ShiftRegister[15] <= ShiftRegister[14];
	ShiftRegister[16] <= ShiftRegister[15];
	ShiftRegister[17] <= ShiftRegister[16];
	ShiftRegister[18] <= ShiftRegister[17];
	ShiftRegister[19] <= ShiftRegister[18];
	ShiftRegister[20] <= ShiftRegister[19];
	ShiftRegister[21] <= ShiftRegister[20];
	ShiftRegister[22] <= ShiftRegister[21];
	ShiftRegister[23] <= ShiftRegister[22];
	ShiftRegister[24] <= ShiftRegister[23];
	ShiftRegister[25] <= ShiftRegister[24];
	ShiftRegister[26] <= ShiftRegister[25];
	ShiftRegister[27] <= ShiftRegister[26];
	ShiftRegister[28] <= ShiftRegister[27];
	ShiftRegister[29] <= ShiftRegister[28];
	ShiftRegister[30] <= ShiftRegister[29];
	ShiftRegister[31] <= ShiftRegister[30];
	ShiftRegister[32] <= ShiftRegister[31];
	ShiftRegister[33] <= ShiftRegister[32];
	ShiftRegister[34] <= ShiftRegister[33];
	ShiftRegister[35] <= ShiftRegister[34];
	ShiftRegister[36] <= ShiftRegister[35];
	ShiftRegister[37] <= ShiftRegister[36];
	ShiftRegister[38] <= ShiftRegister[37];
	ShiftRegister[39] <= ShiftRegister[38];
	ShiftRegister[40] <= ShiftRegister[39];
	ShiftRegister[41] <= ShiftRegister[40];
	ShiftRegister[42] <= ShiftRegister[41];
	ShiftRegister[43] <= ShiftRegister[42];
	ShiftRegister[44] <= ShiftRegister[43];
	ShiftRegister[45] <= ShiftRegister[44];
	ShiftRegister[46] <= ShiftRegister[45];
	ShiftRegister[47] <= ShiftRegister[46];
	ShiftRegister[48] <= ShiftRegister[47];
	ShiftRegister[49] <= ShiftRegister[48];
	ShiftRegister[50] <= ShiftRegister[49];
	ShiftRegister[51] <= ShiftRegister[50];
	ShiftRegister[52] <= ShiftRegister[51];
	ShiftRegister[53] <= ShiftRegister[52];
	ShiftRegister[54] <= ShiftRegister[53];
	ShiftRegister[55] <= ShiftRegister[54];
	ShiftRegister[56] <= ShiftRegister[55];
	ShiftRegister[57] <= ShiftRegister[56];
	ShiftRegister[58] <= ShiftRegister[57];
	ShiftRegister[59] <= ShiftRegister[58];
	ShiftRegister[60] <= ShiftRegister[59];
	ShiftRegister[61] <= ShiftRegister[60];
	ShiftRegister[62] <= ShiftRegister[61];
	ShiftRegister[63] <= ShiftRegister[62];
end
endmodule

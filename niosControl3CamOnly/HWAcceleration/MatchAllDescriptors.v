
module MatchAllDescriptors(
      iClk,   // Input clock
      iDatabaseDescriptor, 
      iSceneDescriptor,
		iDatabaseDescriptorCount,
		iSceneDescriptorCount,
		iStart,
		oReadDatabaseDescriptor,
		oReadSceneDescriptor,
		oResetDatabaseDescriptor,
		oResetSceneDescriptor,
		oDatabaseMatchIndex,
		oWriteDatabaseMatchIndex,
		oDone
        );
		  
input          iClk;
input  [15:0]  iDatabaseDescriptor;
input  [15:0]  iSceneDescriptor;
input  [11:0]  iDatabaseDescriptorCount;
input  [11:0]  iSceneDescriptorCount;
input          iStart;
output reg     oReadDatabaseDescriptor;
output reg     oReadSceneDescriptor;
output         oResetDatabaseDescriptor;
output         oResetSceneDescriptor;
output [11:0]  oDatabaseMatchIndex;
output         oWriteDatabaseMatchIndex;
output         oDone;


reg [11:0]  rDatabaseMatchIndex;
reg         rWriteDatabaseMatchIndex;

reg [11:0] rSceneDescriptorCount = 0;
reg [11:0] rDatabaseDescriptorCount = 12'hfff;
reg [11:0] SceneCounter = 0;
reg [11:0] DatabaseCounter;
reg [5:0] DescriptorCounter;
reg LoadSceneDescriptor = 0;
reg LoadDatabaseDescriptor = 0;
reg [63:0] rStartDelayed = 0;

wire iStartSceneDescriptorLoad;
wire iStartDatabaseDescriptorsLoad;

wire [15:0] iDesc;
reg [11:0] ResultCount = 0;
reg [11:0] WritebackCount = 0;
reg rMatch;
reg [11:0] rMatchIndex;
reg PseudoWrite = 0; // to fill block
reg rDone = 0;
wire oMatch, oMatch_Valid;
wire [11:0] oMatchIndex;

reg rResetDatabaseDescriptor = 0;

assign oDone = rDone;
assign oDatabaseMatchIndex = (PseudoWrite) ? 12'hfff : rDatabaseMatchIndex;
assign oWriteDatabaseMatchIndex = rWriteDatabaseMatchIndex | PseudoWrite;

assign oResetSceneDescriptor = iStart;
assign oResetDatabaseDescriptor = (iStart || rResetDatabaseDescriptor) ? 1'b1 : 1'b0;
always @ (posedge iClk) begin
	if (!oReadDatabaseDescriptor && LoadDatabaseDescriptor) rResetDatabaseDescriptor <= 1;
	else rResetDatabaseDescriptor <= 0;
end
	
assign iStartSceneDescriptorLoad = (LoadSceneDescriptor && (DescriptorCounter == 6'b0)) ? 1'b1 : 1'b0;
assign iStartDatabaseDescriptorsLoad = (LoadDatabaseDescriptor && (DescriptorCounter == 6'b0)) ? 1'b1 : 1'b0;

always @ (posedge iClk) begin
	rStartDelayed <= {rStartDelayed[62:0],iStart};
end
// load number of scene and database descriptors
always @ (posedge iClk) begin
	if (iStart) begin // load values
		rSceneDescriptorCount <= iSceneDescriptorCount;
		rDatabaseDescriptorCount <= iDatabaseDescriptorCount;
	end else begin // preserve values
		rSceneDescriptorCount <= rSceneDescriptorCount;
		rDatabaseDescriptorCount <= rDatabaseDescriptorCount;
	end
end

// counter control
always @ (posedge iClk) begin
	if (rStartDelayed[62]) DescriptorCounter <= 0; // reset
	else DescriptorCounter <= DescriptorCounter + 1;
end
always @ (posedge iClk) begin
	if (rStartDelayed[62]) begin	// reset
		DatabaseCounter <= 1;
		SceneCounter <= 0;
	end else if (LoadSceneDescriptor && (DescriptorCounter == 6'h3f) && (SceneCounter != rSceneDescriptorCount)) begin // end of a scene descriptor, but not the last
		SceneCounter <= SceneCounter + 1;
		DatabaseCounter <= 1;
	end else if (LoadDatabaseDescriptor && (DescriptorCounter == 6'h3f) && (DatabaseCounter != rDatabaseDescriptorCount)) begin // end of a database descriptor, but not the last
		SceneCounter <= SceneCounter;
		DatabaseCounter <= DatabaseCounter + 1;
	end else begin // maintain present value
		SceneCounter <= SceneCounter;
		DatabaseCounter <= DatabaseCounter;
	end
end

// Descriptor information
always @ (posedge iClk) begin
	if (rStartDelayed[62]) begin	// reset, begin scene descriptor
		LoadSceneDescriptor <= 1;
		LoadDatabaseDescriptor <= 0;
	end else if (LoadSceneDescriptor && (DescriptorCounter == 6'h3f)) begin // end of a scene descriptor
		LoadSceneDescriptor <= 0;
		LoadDatabaseDescriptor <= 1;
	end else if (LoadDatabaseDescriptor && (DescriptorCounter == 6'h3f) && (DatabaseCounter == rDatabaseDescriptorCount)) begin // end of last database descriptor
		if (SceneCounter != rSceneDescriptorCount) begin // more scene descriptors to go
			LoadSceneDescriptor <= 1;
			LoadDatabaseDescriptor <= 0;
		end else begin // no more scene descriptors
			LoadSceneDescriptor <= 0;
			LoadDatabaseDescriptor <= 0;
		end
	end else begin // maintain present value
		LoadSceneDescriptor <= LoadSceneDescriptor;
		LoadDatabaseDescriptor <= LoadDatabaseDescriptor;
	end
end

// FIFO Read signals
always @ (posedge iClk) begin
	if (rStartDelayed[61]) begin	// reset, begin scene descriptor
		oReadDatabaseDescriptor <= 0;
		oReadSceneDescriptor <= 1;
	end else if (LoadSceneDescriptor && (DescriptorCounter == 6'h3e)) begin // almost end of a scene descriptor
		oReadDatabaseDescriptor <= 1;
		oReadSceneDescriptor <= 0;
	end else if (LoadDatabaseDescriptor && (DescriptorCounter == 6'h3e) && (DatabaseCounter == rDatabaseDescriptorCount)) begin // almost end of last database descriptor
		if (SceneCounter != rSceneDescriptorCount) begin // more scene descriptors to go
			oReadDatabaseDescriptor <= 0;
			oReadSceneDescriptor <= 1;
		end else begin // no more scene descriptors
			oReadDatabaseDescriptor <= 0;
			oReadSceneDescriptor <= 0;
		end
	end else begin // maintain present value
		oReadDatabaseDescriptor <= oReadDatabaseDescriptor;
		oReadSceneDescriptor <= oReadSceneDescriptor;
	end
end

assign iDesc = (LoadSceneDescriptor) ? iSceneDescriptor : (LoadDatabaseDescriptor) ? iDatabaseDescriptor : 16'b0;
always @ (posedge iClk) begin
	if (iStart) begin
		WritebackCount <= 0;
		PseudoWrite <= 0;
		rDone <= 0;
	end else if ((WritebackCount >= rSceneDescriptorCount) && (WritebackCount < ({rSceneDescriptorCount[11:8],8'b0} + 12'h100))) begin
		WritebackCount <= WritebackCount + 1;
		PseudoWrite <= 1;
		rDone <= 0;
	end else if (WritebackCount >= {rSceneDescriptorCount[11:8],8'b0} + 12'h100) begin
		WritebackCount <= WritebackCount;
		PseudoWrite <= 0;
		rDone <= 1;
	end else if (ResultCount == rDatabaseDescriptorCount) begin
		WritebackCount <= WritebackCount + 1;
		PseudoWrite <= 0;
		rDone <= 0;
	end else begin
		WritebackCount <= WritebackCount;
		PseudoWrite <= 0;
		rDone <= 0;
	end
end
always @ (posedge iClk) begin
	if (ResultCount == rDatabaseDescriptorCount) ResultCount <= 0;
	else if (oMatch_Valid) ResultCount <= ResultCount + 1;
end
always @ (posedge iClk) begin
	if (ResultCount == rDatabaseDescriptorCount) begin
		rMatch <= 0;
		rMatchIndex <= 12'hfff;
		rDatabaseMatchIndex <= rMatchIndex;
		rWriteDatabaseMatchIndex <= 1'b1;
	end else if (oMatch_Valid) begin
		rMatch <= oMatch;
		rMatchIndex <= oMatchIndex;
		rDatabaseMatchIndex <= rDatabaseMatchIndex;
		rWriteDatabaseMatchIndex <= rWriteDatabaseMatchIndex;
	end else begin
		rMatch <= rMatch;
		rMatchIndex <= rMatchIndex;
		rDatabaseMatchIndex <= 12'hfff;
		rWriteDatabaseMatchIndex <= 1'b0;
	end
end

MatchSceneDescriptor MatchSceneDescriptor_inst (
      .iClk(iClk),   // Input clock
      .iStartSceneDescriptorLoad(iStartSceneDescriptorLoad), // Active-high synchronous start signal
      .iStartDatabaseDescriptorsLoad(iStartDatabaseDescriptorsLoad), // Active-high synchronous start signal
		.iDesc(iDesc), // Descriptor 2-byte pair input
		.oMatch(oMatch), // Output a match
		.oMatchIndex(oMatchIndex), // Output a match
		.oMatch_Valid(oMatch_Valid) // oMatch is valid
        );

		  
endmodule

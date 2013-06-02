module Software_Camera_Control (
	clk, // pixel clk
	resetN, // delay reset 2
	NiosSaysCapture, // nios is calibrated and ready to capture an image
	NiosSaysResetCapture, // nios is preparing to calibrate the camera
	NiosSaysRun,
	NiosSaysResetRun,
	DoCapture, // tell the CCD module to capture
	DoRun ); // tell the CCD module to run the camera
	
	input clk;
	input resetN;
	input NiosSaysCapture;
	input NiosSaysResetCapture;
	input NiosSaysRun;
	input NiosSaysResetRun;
	output reg DoCapture;
	output reg DoRun;
	
	reg captureDone;
	reg runDone;
	
	always @(posedge clk or negedge resetN) begin
		// this block controls the camera capture
		if (!resetN) begin
			// nios is preparing for a new image...we reset the
			// registers controlling the state of the capture
			DoCapture <= 1'b0;
			captureDone <= 1'b0;
		end
		else if (NiosSaysResetCapture) begin
			// nios is preparing for a new image...we reset the
			// registers controlling the state of the capture
			DoCapture <= 1'b0;
			captureDone <= 1'b0;
		end
		else if (NiosSaysCapture && !DoCapture && !captureDone) begin
			// nios has requested a capture, so we prepare to do it on the next tick
			DoCapture <= 1'b1;
			captureDone <= 1'b0;
		end
		else if (DoCapture || captureDone) begin
			// we did a capture on this tick, or we've already done a capture
			DoCapture <= 1'b0;
			captureDone <= 1'b1;
		end
		else begin
			// nios hasn't requested a capture yet and we didn't capture yet
			DoCapture <= 1'b0;
			captureDone <= 1'b0;
		end
		
		// this block controls the camera running
		if (!resetN) begin
			DoRun <= 1'b0;
			runDone <= 1'b0;
		end
		else if (NiosSaysResetRun) begin
			DoRun <= 1'b0;
			runDone <= 1'b0;
		end
		else if (NiosSaysRun && !DoRun && !runDone) begin
			// nios has requested that we run the cam, so we prepare to do it
			// on the next tick
			DoRun <= 1'b1;
			runDone <= 1'b0;
		end
		else if (DoRun || runDone) begin
			// we started the cam on this tick, or we've already started the cam
			DoRun <= 1'b0;
			runDone <= 1'b1;
		end
		else begin
			// nios hasn't requested that we start the cam yet and we didn't start it yet
			DoRun <= 1'b0;
			runDone <= 1'b0;
		end
	end
endmodule
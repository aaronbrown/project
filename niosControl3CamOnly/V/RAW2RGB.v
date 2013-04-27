// --------------------------------------------------------------------
// Copyright (c) 2007 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions:	RAW2RGB
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny FAN        :| 07/07/09  :| Initial Revision
// --------------------------------------------------------------------

module RAW2RGB(	oRed,
				oGreen,
				oBlue,
				oDVAL,
				iX_Cont,
				iY_Cont,
				iDATA,
				iDVAL,
				iCLK,
				iRST
				);

input	[10:0]	iX_Cont;
input	[10:0]	iY_Cont;
input	[11:0]	iDATA;
input			iDVAL;
input			iCLK;
input			iRST;
output	[11:0]	oRed;
output	[11:0]	oGreen;
output	[11:0]	oBlue;
output			oDVAL;
wire	[11:0]	mDATA_0;
wire	[11:0]	mDATA_1;
reg		[11:0]	mDATAd_0, mDATAdd_0;
reg		[11:0]	mDATAd_1, mDATAdd_1;
reg		[11:0]	iDATAd, iDATAdd;
wire		[11:0]	mCCD_R;
wire		[12:0]	mCCD_G;
wire		[11:0]	mCCD_B;
wire		[11:0]	GREY;
reg		[11:0]	tempR;
reg		[12:0] 	tempG;
reg		[11:0]	tempB;
reg				mDVAL;

assign	oRed	=	mCCD_R[11:0];
assign	oGreen	=	mCCD_G[11:0];
assign	oBlue	=	mCCD_B[11:0];
assign	oDVAL	=	mDVAL;

//assign GREY = ((tempR * 30) + (tempG * 59) + (tempB * 11)) / 100;
assign GREY = tempR[11:2] + tempR[11:5] + tempG[11:1] + tempG[11:3] + tempB[11:4] + tempB[11:5];
assign mCCD_R 	= GREY;
assign mCCD_G 	= GREY;
assign mCCD_B	= GREY;


Line_Buffer 	u0	(	.clken(iDVAL),
						.clock(iCLK),
						.shiftin(iDATA),
						.taps({mDATA_1,mDATA_0}	)
						);

always@(posedge iCLK or negedge iRST)
begin
	if(!iRST)
	begin
		//mCCD_R	<=	0;
		//mCCD_G	<=	0;
		//mCCD_B	<=	0;
		iDATAd <= 0;
		iDATAdd <= 0;
		mDATAd_0<=	0;
		mDATAdd_0<=	0;
		mDATAd_1<=	0;
		mDATAdd_1<=	0;
		mDVAL	<=	0;
	end
	else
	begin
		mDATAd_0	<=	mDATA_0;
		mDATAd_1	<=	mDATA_1;
		mDATAdd_0	<=	mDATAd_0;
		mDATAdd_1	<=	mDATAd_1;
		iDATAd   <= iDATA;
		iDATAdd  <= iDATAd;
		mDVAL		<=	{iY_Cont[0]|iX_Cont[0]}	?	1'b0	:	iDVAL;
		if({iY_Cont[0],iX_Cont[0]}==2'b10)
		begin
			tempR <= 12'h0;
			tempG <= 12'h0;
			tempB <= 12'h0;
		end	
		else if({iY_Cont[0],iX_Cont[0]}==2'b11)
		begin
			tempR <=	12'h0;
			tempG	<=	12'h0;
			tempB	<=	12'h0;
		end
		else if({iY_Cont[0],iX_Cont[0]}==2'b00)
		begin
			tempR	<=	(mDATAdd_1[11:1]+mDATA_1[11:1]);
			tempG	<=	(mDATAdd_0[11:2]+mDATA_0[11:2]+iDATAdd[11:2]+iDATA[11:2]);
			tempB	<=	(mDATAd_0[11:1]+iDATAd[11:1]);
		end
		else if({iY_Cont[0],iX_Cont[0]}==2'b01)
		begin
			tempR	<=	12'h0;
			tempG	<=	12'h0;
			tempB	<=	12'h0;
		end
		
		
	end
end

endmodule
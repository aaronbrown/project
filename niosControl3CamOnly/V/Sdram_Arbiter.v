// --------------------------------------------------------------------
// This module arbitrates control of the SDRAM between nios and cam
// --------------------------------------------------------------------

module Sdram_Arbiter(
		//	HOST Side
        RequestNiosControl, // hold high for nios to maintain control, otherwise
		                    // control will be transferred back to camera.
							// Takes priority over RequestAccelControl
        RequestAccelControl, // hold high for accel to maintain control, otherwise
		                    // control will be transferred back to camera
							// RequestNiosControl must be low for accel to receive control
        NiosHasControl,     // Set when Nios has full control after context switch
        AccelHasControl,     // Set when accel has full control after context switch
        CamHasControl,      // Set when Cam has full control after context switch
        Reset_N,              // active low, connect to Nios reset signal
		  clk,
		//	Nios Side
        SA_nios,
        BA_nios,
        CS_N_nios,
        CKE_nios,
        RAS_N_nios,
        CAS_N_nios,
        WE_N_nios,
        DQM_nios,
		//	Accelerator Side
        SA_accel,
        BA_accel,
        CS_N_accel,
        CKE_accel,
        RAS_N_accel,
        CAS_N_accel,
        WE_N_accel,
        DQM_accel,
		 // camera Side
        SA_cam,
        BA_cam,
        CS_N_cam,
        CKE_cam,
        RAS_N_cam,
        CAS_N_cam,
        WE_N_cam,
        DQM_cam,
		//	SDRAM Side
        SA,
        BA,
        CS_N,
        CKE,
        RAS_N,
        CAS_N,
        WE_N,
        DQM
        );

//	HOST Side
input                           RequestNiosControl;
input                           RequestAccelControl;
output reg                         NiosHasControl;
output reg                       CamHasControl;
output reg                       AccelHasControl;
input 							clk;
input 							Reset_N;
//	Camera Side
input   [11:0]                  SA_cam;                 //SDRAM address output
input   [1:0]                   BA_cam;                 //SDRAM bank address
input   [1:0]                   CS_N_cam;               //SDRAM Chip Selects
input                           CKE_cam;                //SDRAM clock enable
input                           RAS_N_cam;              //SDRAM Row address Strobe
input                           CAS_N_cam;              //SDRAM Column address Strobe
input                           WE_N_cam;               //SDRAM write enable
input   [1:0]                   DQM_cam;                //SDRAM data mask lines
//	Accel Side
input   [11:0]                  SA_accel;                //SDRAM address output
input   [1:0]                   BA_accel;                //SDRAM bank address
input   [1:0]                   CS_N_accel;              //SDRAM Chip Selects
input                           CKE_accel;               //SDRAM clock enable
input                           RAS_N_accel;             //SDRAM Row address Strobe
input                           CAS_N_accel;             //SDRAM Column address Strobe
input                           WE_N_accel;              //SDRAM write enable
input   [1:0]                   DQM_accel;               //SDRAM data mask lines
//	Nios Side
input   [11:0]                  SA_nios;                //SDRAM address output
input   [1:0]                   BA_nios;                //SDRAM bank address
input   [1:0]                   CS_N_nios;              //SDRAM Chip Selects
input                           CKE_nios;               //SDRAM clock enable
input                           RAS_N_nios;             //SDRAM Row address Strobe
input                           CAS_N_nios;             //SDRAM Column address Strobe
input                           WE_N_nios;              //SDRAM write enable
input   [1:0]                   DQM_nios;               //SDRAM data mask lines
//	SDRAM Side
output  [11:0]                  SA;                     //SDRAM address output
output  [1:0]                   BA;                     //SDRAM bank address
output  [1:0]                   CS_N;                   //SDRAM Chip Selects
output                          CKE;                    //SDRAM clock enable
output                          RAS_N;                  //SDRAM Row address Strobe
output                          CAS_N;                  //SDRAM Column address Strobe
output                          WE_N;                   //SDRAM write enable
output  [1:0]                   DQM;                    //SDRAM data mask lines


// FSM States
parameter [2:0] State_CamHasControl  = 3'h0;
parameter [2:0] State_CamNOP         = 3'h1;
parameter [2:0] State_LoadNiosMode   = 3'h2;
parameter [2:0] State_LoadCamMode    = 3'h3;
parameter [2:0] State_NiosNOP        = 3'h4;
parameter [2:0] State_NiosHasControl = 3'h5;
parameter [2:0] State_AccelHasControl  = 3'h6;
reg [2:0] Current_State = State_CamHasControl;
reg [2:0] Next_State;

// State Transition Logic
always @ (posedge clk, negedge Reset_N)
	if (!Reset_N) Current_State <= State_NiosHasControl;
	else Current_State <= Next_State;

// Next-State Logic
always @* begin
  if (RequestNiosControl)
    case (Current_State)
      State_CamHasControl :  Next_State = State_CamNOP;
      State_AccelHasControl :  Next_State = State_CamNOP;
      State_CamNOP :         Next_State = State_LoadNiosMode;
      State_LoadNiosMode :   Next_State = State_NiosNOP;
      State_LoadCamMode :    Next_State = State_CamNOP;
      State_NiosNOP :        Next_State = State_NiosHasControl;
      State_NiosHasControl : Next_State = State_NiosHasControl;
      default :              Next_State = State_CamHasControl;
    endcase
  else if (RequestAccelControl)
    case (Current_State)
      State_CamHasControl :  Next_State = State_AccelHasControl;
      State_AccelHasControl :  Next_State = State_AccelHasControl;
      State_CamNOP :         Next_State = State_CamHasControl;
      State_LoadNiosMode :   Next_State = State_NiosNOP;
      State_LoadCamMode :    Next_State = State_CamNOP;
      State_NiosNOP :        Next_State = State_LoadCamMode;
      State_NiosHasControl : Next_State = State_NiosNOP;
      default :              Next_State = State_CamHasControl;
    endcase
  else
    case (Current_State)
      State_CamHasControl :  Next_State = State_CamHasControl;
      State_AccelHasControl :  Next_State = State_CamHasControl;
      State_CamNOP :         Next_State = State_CamHasControl;
      State_LoadNiosMode :   Next_State = State_NiosNOP;
      State_LoadCamMode :    Next_State = State_CamNOP;
      State_NiosNOP :        Next_State = State_LoadCamMode;
      State_NiosHasControl : Next_State = State_NiosNOP;
      default :              Next_State = State_CamHasControl;
    endcase
end

//	Internal Registers/Wires
//	Controller
reg NOP, ArbiterHasControl, NiosLoadMode;
wire [11:0] SA_arbiter;
reg  [11:0] NiosModeBits = 12'b110000;
reg  [11:0] CamModeBits  = 12'b110111;

// Current State Output Logic
always @* begin
  NOP = 0; // ~NOP is LOAD REGISTER MODE
  ArbiterHasControl = 1;
  NiosLoadMode = 1;
  NiosHasControl = 0;
  CamHasControl = 0;
  AccelHasControl = 0;
  case (Current_State)
    State_CamHasControl :  begin 
							ArbiterHasControl = 1'b0;
							CamHasControl = 1'b1;
						   end
    State_AccelHasControl :  begin 
							ArbiterHasControl = 1'b0;
							AccelHasControl = 1'b1;
						   end
    State_CamNOP :         NOP = 1'b1;
    State_LoadNiosMode :   ;
    State_LoadCamMode :    NiosLoadMode = 1'b0;
    State_NiosNOP :        NOP = 1'b1;
    State_NiosHasControl : begin 
							ArbiterHasControl = 1'b0;
							NiosHasControl = 1'b1;
						   end
    default :              ;
  endcase
end
/*
always @ (posedge clk) 
	if ((CS_N_nios == 0) &&
	(RAS_N_nios == 0) &&
	(CAS_N_nios == 0) &&
	(WE_N_nios == 0))
		NiosModeBits <= SA_nios;
	else 
		NiosModeBits <= NiosModeBits;
*/
assign SA_arbiter = NiosLoadMode ? NiosModeBits : CamModeBits;

assign SA    = ArbiterHasControl ? SA_arbiter : NiosHasControl ? SA_nios    : AccelHasControl ? SA_accel    : SA_cam;
assign BA    = ArbiterHasControl ? 2'hx       : NiosHasControl ? BA_nios    : AccelHasControl ? BA_accel    : BA_cam;
assign CS_N  = ArbiterHasControl ? 1'b0       : NiosHasControl ? CS_N_nios  : AccelHasControl ? CS_N_accel  : CS_N_cam;
assign CKE   = ArbiterHasControl ? 1'b1       : NiosHasControl ? CKE_nios   : AccelHasControl ? CKE_accel   : CKE_cam;
assign RAS_N = ArbiterHasControl ? NOP        : NiosHasControl ? RAS_N_nios : AccelHasControl ? RAS_N_accel : RAS_N_cam;
assign CAS_N = ArbiterHasControl ? NOP        : NiosHasControl ? CAS_N_nios : AccelHasControl ? CAS_N_accel : CAS_N_cam;
assign WE_N  = ArbiterHasControl ? NOP        : NiosHasControl ? WE_N_nios  : AccelHasControl ? WE_N_accel  : WE_N_cam;
assign DQM   = ArbiterHasControl ? 2'h3       : NiosHasControl ? DQM_nios   : AccelHasControl ? DQM_accel   : DQM_cam;

endmodule

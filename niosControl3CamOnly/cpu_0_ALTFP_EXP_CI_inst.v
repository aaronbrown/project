// cpu_0_ALTFP_EXP_CI_inst.v

// This file was auto-generated as part of a SOPC Builder generate operation.
// If you edit it your changes will probably be lost.

`timescale 1 ps / 1 ps
module cpu_0_ALTFP_EXP_CI_inst (
		input  wire        clk,    // nios_custom_instruction_slave_0.clk
		input  wire        reset,  //                                .reset
		input  wire        clk_en, //                                .clk_en
		input  wire [31:0] dataa,  //                                .dataa
		output wire [31:0] result  //                                .result
	);

	ALTFP_EX_CI cpu_0_altfp_exp_ci_inst (
		.clk    (clk),    // nios_custom_instruction_slave_0.clk
		.reset  (reset),  //                                .reset
		.clk_en (clk_en), //                                .clk_en
		.dataa  (dataa),  //                                .dataa
		.result (result)  //                                .result
	);

endmodule

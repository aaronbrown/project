// cpu_0_ALTFP_EX_CI_inst_0.v

// This file was auto-generated as part of a SOPC Builder generate operation.
// If you edit it your changes will probably be lost.

`timescale 1 ps / 1 ps
module cpu_0_ALTFP_EX_CI_inst_0 (
		input  wire        reset,  // nios_custom_instruction_slave_0.reset
		input  wire [31:0] dataa,  //                                .dataa
		input  wire        clk_en, //                                .clk_en
		output wire [31:0] result, //                                .result
		input  wire        clk     //                                .clk
	);

	ALTFP_EX_CI cpu_0_altfp_ex_ci_inst_0 (
		.reset  (reset),  // nios_custom_instruction_slave_0.reset
		.dataa  (dataa),  //                                .dataa
		.clk_en (clk_en), //                                .clk_en
		.result (result), //                                .result
		.clk    (clk)     //                                .clk
	);

endmodule

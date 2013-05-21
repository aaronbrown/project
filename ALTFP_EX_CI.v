/*
module ALTFP_EX_CI(clk,
                   reset,
                   dataa,
                   clk_en,
                   result);

										
  input clk;
  input reset;
  input [31:0] dataa; 
  input clk_en;
  output [31:0] result;

  ALTFP_EXa ALTFP_EXa_inst (
				.clock (clk),
				.data (data),
				.result (result));
  
endmodule
*/


module ALTFP_EX_CI(
		clk, // CPU system clock (required for multicycle or extended multicycle)
		reset, // CPU master asynchronous active high reset
		// (required for multicycle or extended multicycle)
		clk_en,// Clock-qualifier (required for multicycle or extended multicycle)
		dataa, // Operand A (always required)
		result // Result (always required)
);

input clk;
input reset;
input clk_en;
input [31:0] dataa;
output [31:0] result;

	ALTFP_EXa exp_unit (
		.clock(clk),
		.data(dataa),
		.result(result));

endmodule
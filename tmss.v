module tmss
	(
	input MCLK,
	input [15:0] VD_i,
	input [2:0] test,
	input JAP,
	input AS,
	input LDS,
	input UDS,
	input RW,
	input [22:0] VA,
	input SRES,
	input CE0_i,
	input M3,
	input CART,
	input INTAK,
	output [15:0] VD_o,
	output DTACK,
	output RESET,
	output CE0_o,
	output test0,
	output test1,
	output test2,
	output test3,
	output test4,
	output data_out_en
	);

endmodule

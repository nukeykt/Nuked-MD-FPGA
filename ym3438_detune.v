module ym3438_detune
	(
	input MCLK,
	input c1,
	input c2,
	input [2:0] dt,
	input [4:0] kcode,
	output dt_sign_1,
	output dt_sign_2,
	output [4:0] dt_value
	);
	
	wire [2:0] dt_sr_o;
	
	ym3438_sr_bit_array #(.DATA_WIDTH(3)) dt_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(dt),
		.data_out(dt_sr_o)
		);
	
	assign dt_sign_1 = dt_sr_o[2];
	
	ym3438_sr_bit dt_sr2
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(dt_sign_1),
		.sr_out(dt_sign_2)
		);
	
	wire dt_1_2_3 = dt_sr_o[0] | dt_sr_o[1];
	wire dt_3 = dt_sr_o[1] & dt_sr_o[1];
	
	wire [6:0] dt_sum;
	assign dt_sum[6:2] = 1'h1 + { dt_1_2_3, 1'h0, dt_sr_o[1], dt_3 } + { 1'h0, kcode[4:2] };
	assign dt_sum[1:0] = kcode[4:2] == 3'h7 ? 2'h0 : kcode[1:0];
	
	wire dt_shift_5 = dt_sum[6:3] == 4'h5 & dt_1_2_3;
	wire dt_shift_6 = dt_sum[6:3] == 4'h6 & dt_1_2_3;
	wire dt_shift_7 = dt_sum[6:3] == 4'h7 & dt_1_2_3;
	wire dt_shift_8 = dt_sum[6:3] == 4'h8 & dt_1_2_3;
	wire dt_shift_9 = dt_sum[6:3] == 4'h9 & dt_1_2_3;
	
	wire [7:0] dt_index;
	
	genvar i;
	generate
		for (i = 0; i < 8; i = i + 1)
		begin : l1
			assign dt_index[i] = dt_sum[2:0] == i;
		end
	endgenerate
	
	wire [3:0] dt_val1;
	
	assign dt_val1[0] = dt_index[1] | dt_index[2] | dt_index[6] | dt_index[7];
	assign dt_val1[1] = dt_index[2] | dt_index[4] | dt_index[6];
	assign dt_val1[2] = dt_index[3] | dt_index[4] | dt_index[7];
	assign dt_val1[3] = dt_index[5] | dt_index[6] | dt_index[7];
	
	assign dt_value[0] = (dt_shift_9 & dt_val1[0]) | (dt_shift_8 & dt_val1[1]) | (dt_shift_7 & dt_val1[2])
		 | (dt_shift_6 & dt_val1[3]) | dt_shift_5;
	assign dt_value[1] = (dt_shift_9 & dt_val1[1]) | (dt_shift_8 & dt_val1[2]) | (dt_shift_7 & dt_val1[3])
		 | dt_shift_6;
	assign dt_value[2] = (dt_shift_9 & dt_val1[2]) | (dt_shift_8 & dt_val1[3]) | dt_shift_7;
	assign dt_value[3] = (dt_shift_9 & dt_val1[3]) | dt_shift_8;
	assign dt_value[4] = dt_shift_9;
	

endmodule

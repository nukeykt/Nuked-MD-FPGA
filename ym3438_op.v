module ym3438_op
	(
	input MCLK,
	input c1,
	input c2,
	input [9:0] pg_phase,
	input [9:0] eg_att,
	input [7:0] reg_21,
	input is_op1,
	input is_op2,
	input add1_cur,
	input add1_op1_2,
	input add1_op2,
	input add2_cur,
	input add2_op1_1,
	input no_fb,
	input [2:0] fb,
	output [13:0] op_output
	);
	
	wire [9:0] mod_add;
	
	wire [9:0] phase_sum = mod_add + pg_phase;
	
	wire [9:0] phase_sr_o;
	
	ym_sr_bit_array #(.DATA_WIDTH(10)) phase_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(phase_sum),
		.data_out(phase_sr_o)
		);
	
	wire [7:0] sin_index = phase_sr_o[7:0] ^ {8{phase_sr_o[8]}};
	
	wire [4:0] sin_lut_index = sin_index[5:1];
	
	reg [45:0] sine_lut_out;
	
	always @(sin_lut_index)
	begin
		case (sin_lut_index)
			5'h1f: sine_lut_out = 46'b0001100001000100100001000010101010101000100101;
			5'h1e: sine_lut_out = 46'b0001100001010100001000000001001001001100010100;
			5'h1d: sine_lut_out = 46'b0001100001010100001000110000101011001100000110;
			5'h1c: sine_lut_out = 46'b0001110000010000000000110011001001001100100111;
			5'h1b: sine_lut_out = 46'b0001110000010000011000000011101010001110010110;
			5'h1a: sine_lut_out = 46'b0001110000010100010001100000001000101110100111;
			5'h19: sine_lut_out = 46'b0001110000010100011001100001001011001110100101;
			5'h18: sine_lut_out = 46'b0001110000011100001001010011101000101111001111;
			5'h17: sine_lut_out = 46'b0001110001011000000001110010101110001101110111;
			5'h16: sine_lut_out = 46'b0001110001011000101000111001100101011001101010;
			5'h15: sine_lut_out = 46'b0001110001011100110000011011100100001010100111;
			5'h14: sine_lut_out = 46'b0001110001011100111000111110100011001001110111;
			5'h13: sine_lut_out = 46'b0100100010010000100001011100100000111001111011;
			5'h12: sine_lut_out = 46'b0100100010010100100001001111000001111110100010;
			5'h11: sine_lut_out = 46'b0100100010010100101001101111110110100101100100;
			5'h10: sine_lut_out = 46'b0100100111000000010000011101000110101110010111;
			5'h0f: sine_lut_out = 46'b0100100111000100010000101110001101001011111110;
			5'h0e: sine_lut_out = 46'b0100100111001100001011011000001001011000011011;
			5'h0d: sine_lut_out = 46'b0100110110001000001011101000001010111011111011;
			5'h0c: sine_lut_out = 46'b0100110110001100010011011010111110110100011000;
			5'h0b: sine_lut_out = 46'b0100110111001000110010111100101010001100010111;
			5'h0a: sine_lut_out = 46'b0100110111001100110110110111110001010111110000;
			5'h09: sine_lut_out = 46'b0111000100000000101111000101010101010101111001;
			5'h08: sine_lut_out = 46'b0111000100000100101111110111011101010010111011;
			5'h07: sine_lut_out = 46'b0111000101010101010100101000110000010010010001;
			5'h06: sine_lut_out = 46'b0111010100011001001100011010011100010000101001;
			5'h05: sine_lut_out = 46'b0111010101011011001001100100010000110100110010;
			5'h04: sine_lut_out = 46'b1010000100011011011001011110010001110010101001;
			5'h03: sine_lut_out = 46'b1010000101011111111100100101011100010010010011;
			5'h02: sine_lut_out = 46'b1010010111110101100010001011110001010100001010;
			5'h01: sine_lut_out = 46'b1011010110110011110111011000011100110000011010;
			5'h00: sine_lut_out = 46'b1110011111010001110111100110011001110101111010;
		endcase
	end
	
	wire sin_index_top_sel[3:0];
	assign sin_index_top_sel[0] = sin_index[7:6] == 2'h0;
	assign sin_index_top_sel[1] = sin_index[7:6] == 2'h1;
	assign sin_index_top_sel[2] = sin_index[7:6] == 2'h2;
	assign sin_index_top_sel[3] = sin_index[7:6] == 2'h3;
	
	wire [18:0] sin_lut_mux;
	
	assign sin_lut_mux[0] = (sine_lut_out[0] & sin_index_top_sel[0]) | (sine_lut_out[1] & sin_index_top_sel[1])
		| (sine_lut_out[2] & sin_index_top_sel[2]) | (sine_lut_out[3] & sin_index_top_sel[3]);
	assign sin_lut_mux[1] = (sine_lut_out[4] & sin_index_top_sel[0]) | (sine_lut_out[5] & sin_index_top_sel[1])
		| (sine_lut_out[6] & sin_index_top_sel[2]) | (sine_lut_out[7] & sin_index_top_sel[3]);
	assign sin_lut_mux[2] = (sine_lut_out[8] & sin_index_top_sel[0]) | (sine_lut_out[9] & sin_index_top_sel[1])
		| (sine_lut_out[10] & sin_index_top_sel[2]);
	assign sin_lut_mux[3] = (sine_lut_out[11] & sin_index_top_sel[0]) | (sine_lut_out[12] & sin_index_top_sel[1])
		| (sine_lut_out[13] & sin_index_top_sel[2]) | (sine_lut_out[14] & sin_index_top_sel[3]);
	assign sin_lut_mux[4] = (sine_lut_out[15] & sin_index_top_sel[0]) | (sine_lut_out[16] & sin_index_top_sel[1]);
	assign sin_lut_mux[5] = (sine_lut_out[17] & sin_index_top_sel[0]) | (sine_lut_out[18] & sin_index_top_sel[1])
		| (sine_lut_out[19] & sin_index_top_sel[2]) | (sine_lut_out[20] & sin_index_top_sel[3]);
	assign sin_lut_mux[6] = sine_lut_out[21] & sin_index_top_sel[0];
	assign sin_lut_mux[7] = (sine_lut_out[22] & sin_index_top_sel[0]) | (sine_lut_out[23] & sin_index_top_sel[1])
		| (sine_lut_out[24] & sin_index_top_sel[2]) | (sine_lut_out[25] & sin_index_top_sel[3]);
	assign sin_lut_mux[8] = sine_lut_out[26] & sin_index_top_sel[0];
	assign sin_lut_mux[9] = (sine_lut_out[27] & sin_index_top_sel[0]) | (sine_lut_out[28] & sin_index_top_sel[1])
		| (sine_lut_out[29] & sin_index_top_sel[2]) | (sine_lut_out[30] & sin_index_top_sel[3]);
	assign sin_lut_mux[10] = sine_lut_out[31] & sin_index_top_sel[0];
	assign sin_lut_mux[11] = (sine_lut_out[32] & sin_index_top_sel[0]) | (sine_lut_out[33] & sin_index_top_sel[1])
		| (sine_lut_out[34] & sin_index_top_sel[2]);
	assign sin_lut_mux[12] = sine_lut_out[35] & sin_index_top_sel[0];
	assign sin_lut_mux[13] = (sine_lut_out[36] & sin_index_top_sel[0]) | (sine_lut_out[37] & sin_index_top_sel[1])
		| (sine_lut_out[38] & sin_index_top_sel[2]);
	assign sin_lut_mux[14] = sine_lut_out[39] & sin_index_top_sel[0];
	assign sin_lut_mux[15] = (sine_lut_out[40] & sin_index_top_sel[0]) | (sine_lut_out[41] & sin_index_top_sel[1]);
	assign sin_lut_mux[16] = (sine_lut_out[42] & sin_index_top_sel[0]) | (sine_lut_out[43] & sin_index_top_sel[1]);
	assign sin_lut_mux[17] = sine_lut_out[44] & sin_index_top_sel[0];
	assign sin_lut_mux[18] = sine_lut_out[45] & sin_index_top_sel[0];
	
	wire [18:0] sin_lut_sr_o;
	
	ym_sr_bit_array #(.DATA_WIDTH(19)) sin_lut_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(sin_lut_mux),
		.data_out(sin_lut_sr_o)
		);
	
	wire sin_index_0_sr_o;
	
	ym_sr_bit sin_index_0_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(sin_index[0]),
		.sr_out(sin_index_0_sr_o)
		);
	
	wire [10:0] sin_base = { sin_lut_sr_o[18:15], sin_lut_sr_o[13], sin_lut_sr_o[11], sin_lut_sr_o[9], sin_lut_sr_o[7], sin_lut_sr_o[5], sin_lut_sr_o[3], sin_lut_sr_o[1] };
	
	wire [7:0] sin_delta = sin_index_0_sr_o ? 8'h0 : { sin_lut_sr_o[14], sin_lut_sr_o[12], sin_lut_sr_o[10], sin_lut_sr_o[8], sin_lut_sr_o[6], sin_lut_sr_o[4], sin_lut_sr_o[2], sin_lut_sr_o[0] };
	
	wire [11:0] sin_sum = sin_base + { sin_delta[7], sin_delta };
	
	wire sign_sr_o;
	
	ym_sr_bit #(.SR_LENGTH(3)) sign_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(phase_sr_o[9]),
		.sr_out(sign_sr_o)
		);
	
	wire [9:0] eg_att_sr_o;
	
	ym_sr_bit_array #(.DATA_WIDTH(10)) eg_att_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(eg_att),
		.data_out(eg_att_sr_o)
		);

	wire [12:0] att_sum = sin_sum + { eg_att_sr_o, 2'h0 };
	//wire [12:0] att_sum = sin_sum + 100;
	
	wire [12:0] att_sum_sr_o;
	
	ym_sr_bit_array #(.DATA_WIDTH(13)) att_sum_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(att_sum),
		.data_out(att_sum_sr_o)
		);
	
	wire [11:0] att_clamp = ~(att_sum_sr_o[12] ? 12'hfff : att_sum_sr_o[11:0]);
	
	wire [7:0] pow_index = att_clamp[7:0];
	
	wire [4:0] pow_lut_index = pow_index[5:1];
	
	reg [47:0] pow_lut_out;
	
	always @(pow_lut_index)
	begin
		case (pow_lut_index)
			5'h1f: pow_lut_out = 48'b111011111100011111101000111101000001000110011101;
			5'h1e: pow_lut_out = 48'b111011111100011010011111011000001011100010110011;
			5'h1d: pow_lut_out = 48'b111011111100000011110110111101101001110111011010;
			5'h1c: pow_lut_out = 48'b111011111100000011100001111101100101000001010110;
			5'h1b: pow_lut_out = 48'b111011111100000010000110011100100101000001011011;
			5'h1a: pow_lut_out = 48'b111011101001010101011101111101000001111111011101;
			5'h19: pow_lut_out = 48'b111011001011011101111010011111001000011011000000;
			5'h18: pow_lut_out = 48'b111011001011011100100101111100001001001111011110;
			5'h17: pow_lut_out = 48'b111011001011001101000110111101000001101011011010;
			5'h16: pow_lut_out = 48'b111011001011000001110011011101110001010111010100;
			5'h15: pow_lut_out = 48'b111011000011100010111100111100110001110110010101;
			5'h14: pow_lut_out = 48'b111010000111110011001111011101111001110010011011;
			5'h13: pow_lut_out = 48'b111010000111110011000000111001111011001110111101;
			5'h12: pow_lut_out = 48'b111010000100111110110111111100110101101001010001;
			5'h11: pow_lut_out = 48'b111010000100111110110000011100110001001110010011;
			5'h10: pow_lut_out = 48'b111010000100101101011010111101001001110011010101;
			5'h0f: pow_lut_out = 48'b111010000100101100001101011001001011010110110111;
			5'h0e: pow_lut_out = 48'b111010000100100100101010011000000011111010110001;
			5'h0d: pow_lut_out = 48'b111010000000110001110101111000000011011110110011;
			5'h0c: pow_lut_out = 48'b111010000000110000010110011001011011100011110101;
			5'h0b: pow_lut_out = 48'b111010000000010010001001111101011001000110010101;
			5'h0a: pow_lut_out = 48'b101110100010001011101110111000010011101010110101;
			5'h09: pow_lut_out = 48'b101100110011001111111001011000010011001111110011;
			5'h08: pow_lut_out = 48'b101100110011001110010011111001001011100010110001;
			5'h07: pow_lut_out = 48'b100101110111011111010100111001000011000010101010;
			5'h06: pow_lut_out = 48'b100101110111010111100011011000000011101110111000;
			5'h05: pow_lut_out = 48'b100101110111010100101100111100001001001010011010;
			5'h04: pow_lut_out = 48'b100101110111010000011011011100011001000110010000;
			5'h03: pow_lut_out = 48'b100101110111000001011000011001010011101010110001;
			5'h02: pow_lut_out = 48'b100101110101001000100111111001010011001110111011;
			5'h01: pow_lut_out = 48'b100101110101001000100001011101001001000100000000;
			5'h00: pow_lut_out = 48'b100101110001011001000110011000000011101010110000;
		endcase
	end
	
	wire pow_index_top_sel[3:0];
	assign pow_index_top_sel[0] = pow_index[7:6] == 2'h0;
	assign pow_index_top_sel[1] = pow_index[7:6] == 2'h1;
	assign pow_index_top_sel[2] = pow_index[7:6] == 2'h2;
	assign pow_index_top_sel[3] = pow_index[7:6] == 2'h3;
	
	wire [12:0] pow_lut_mux;
	
	assign pow_lut_mux[0] = (pow_lut_out[0] & pow_index_top_sel[0]) | (pow_lut_out[1] & pow_index_top_sel[1])
		| (pow_lut_out[2] & pow_index_top_sel[2]) | (pow_lut_out[3] & pow_index_top_sel[3]);
	assign pow_lut_mux[1] = (pow_lut_out[4] & pow_index_top_sel[0]) | (pow_lut_out[5] & pow_index_top_sel[1])
		| (pow_lut_out[6] & pow_index_top_sel[2]) | (pow_lut_out[7] & pow_index_top_sel[3]);
	assign pow_lut_mux[2] = (pow_lut_out[8] & pow_index_top_sel[0]) | (pow_lut_out[9] & pow_index_top_sel[1])
		| (pow_lut_out[10] & pow_index_top_sel[2]) | (pow_lut_out[11] & pow_index_top_sel[3]);
	assign pow_lut_mux[3] = (pow_lut_out[12] & pow_index_top_sel[0]) | (pow_lut_out[13] & pow_index_top_sel[1])
		| (pow_lut_out[14] & pow_index_top_sel[3]);
	assign pow_lut_mux[4] = (pow_lut_out[15] & pow_index_top_sel[0]) | (pow_lut_out[16] & pow_index_top_sel[1])
		| (pow_lut_out[17] & pow_index_top_sel[2]) | (pow_lut_out[18] & pow_index_top_sel[3]);
	assign pow_lut_mux[5] = (pow_lut_out[19] & pow_index_top_sel[0]) | (pow_lut_out[20] & pow_index_top_sel[1])
		| (pow_lut_out[21] & pow_index_top_sel[2]) | (pow_lut_out[22] & pow_index_top_sel[3]);
	assign pow_lut_mux[6] = (pow_lut_out[23] & pow_index_top_sel[0]) | (pow_lut_out[24] & pow_index_top_sel[1])
		| (pow_lut_out[25] & pow_index_top_sel[2]) | (pow_lut_out[26] & pow_index_top_sel[3]);
	assign pow_lut_mux[7] = (pow_lut_out[27] & pow_index_top_sel[0]) | (pow_lut_out[28] & pow_index_top_sel[1])
		| (pow_lut_out[29] & pow_index_top_sel[2]) | (pow_lut_out[30] & pow_index_top_sel[3]);
	assign pow_lut_mux[8] = (pow_lut_out[31] & pow_index_top_sel[0]) | (pow_lut_out[32] & pow_index_top_sel[1])
		| (pow_lut_out[33] & pow_index_top_sel[2]) | (pow_lut_out[34] & pow_index_top_sel[3]);
	assign pow_lut_mux[9] = (pow_lut_out[35] & pow_index_top_sel[0]) | (pow_lut_out[36] & pow_index_top_sel[1])
		| (pow_lut_out[37] & pow_index_top_sel[2]) | (pow_lut_out[38] & pow_index_top_sel[3]);
	assign pow_lut_mux[10] = (pow_lut_out[39] & pow_index_top_sel[0]) | (pow_lut_out[40] & pow_index_top_sel[1])
		| (pow_lut_out[41] & pow_index_top_sel[2]) | (pow_lut_out[42] & pow_index_top_sel[3]);
	assign pow_lut_mux[11] = (pow_lut_out[43] & pow_index_top_sel[1])
		| (pow_lut_out[44] & pow_index_top_sel[2]) | (pow_lut_out[45] & pow_index_top_sel[3]);
	assign pow_lut_mux[12] = (pow_lut_out[46] & pow_index_top_sel[2]) | (pow_lut_out[47] & pow_index_top_sel[3]);
	
	wire [12:0] pow_lut_sr_o;
	
	ym_sr_bit_array #(.DATA_WIDTH(13)) pow_lut_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(pow_lut_mux),
		.data_out(pow_lut_sr_o)
		);
	
	wire pow_index_0_sr_o;
	
	ym_sr_bit pow_index_0_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(pow_index[0]),
		.sr_out(pow_index_0_sr_o)
		);
	
	wire [9:0] pow_base = { pow_lut_sr_o[12:6], pow_lut_sr_o[4], pow_lut_sr_o[2], pow_lut_sr_o[0] };
	wire [2:0] pow_delta = pow_index_0_sr_o ? { pow_lut_sr_o[5], pow_lut_sr_o[3], pow_lut_sr_o[1] } : 3'h0;
	
	wire [9:0] pow_sum = pow_base + pow_delta;
	
	wire [3:0] pow_shift_sr_o;
	
	ym_sr_bit_array #(.DATA_WIDTH(4)) pow_shift_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(att_clamp[11:8]),
		.data_out(pow_shift_sr_o)
		);
	
	wire [3:0] sh_sel1;
	
	assign sh_sel1[0] = pow_shift_sr_o[1:0] == 2'h0;
	assign sh_sel1[1] = pow_shift_sr_o[1:0] == 2'h1;
	assign sh_sel1[2] = pow_shift_sr_o[1:0] == 2'h2;
	assign sh_sel1[3] = pow_shift_sr_o[1:0] == 2'h3;
	
	wire [3:0] sh_sel2;
	
	assign sh_sel2[0] = pow_shift_sr_o[3:2] == 2'h0;
	assign sh_sel2[1] = pow_shift_sr_o[3:2] == 2'h1;
	assign sh_sel2[2] = pow_shift_sr_o[3:2] == 2'h2;
	assign sh_sel2[3] = pow_shift_sr_o[3:2] == 2'h3;
	
	wire [12:0] pow_shift1 = ({13{sh_sel1[3]}} & { 1'h1, pow_sum, 2'h0 })
		| ({13{sh_sel1[2]}} & { 1'h1, pow_sum, 1'h0 })
		| ({13{sh_sel1[1]}} & { 1'h1, pow_sum })
		| ({13{sh_sel1[0]}} & { 1'h1, pow_sum[9:1] });
	
	wire [12:0] pow_shift2 = ({13{sh_sel2[3]}} & pow_shift1 )
		| ({13{sh_sel2[2]}} & pow_shift1[12:4] )
		| ({13{sh_sel2[1]}} & pow_shift1[12:8] )
		| ({13{sh_sel2[1]}} & pow_shift1[12:12] );
	
	wire [13:0] op_value1 = { reg_21[4], pow_shift2 };
	
	wire [13:0] op_value2 = (op_value1 ^ {14{sign_sr_o}}) + sign_sr_o;
	
	wire [13:0] op_value_sr_o;
	
	assign op_output = op_value_sr_o;
	
	ym_sr_bit_array #(.DATA_WIDTH(14)) op_value_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(op_value2),
		.data_out(op_value_sr_o)
		);
		
	wire [13:0] op_op1_1_sr_i;
	wire [13:0] op_op1_1_sr_o;
	
	ym_sr_bit_array #(.DATA_WIDTH(14), .SR_LENGTH(6)) op_op1_1_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(op_op1_1_sr_i),
		.data_out(op_op1_1_sr_o)
		);
	
	assign op_op1_1_sr_i = is_op1 ? op_value_sr_o : op_op1_1_sr_o;
		
	wire [13:0] op_op1_2_sr_i;
	wire [13:0] op_op1_2_sr_o;
	
	ym_sr_bit_array #(.DATA_WIDTH(14), .SR_LENGTH(6)) op_op1_2_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(op_op1_2_sr_i),
		.data_out(op_op1_2_sr_o)
		);
	
	assign op_op1_2_sr_i = is_op1 ? op_op1_1_sr_o : op_op1_2_sr_o;
		
	wire [13:0] op_op2_sr_i;
	wire [13:0] op_op2_sr_o;
	
	ym_sr_bit_array #(.DATA_WIDTH(14), .SR_LENGTH(6)) op_op2_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(op_op2_sr_i),
		.data_out(op_op2_sr_o)
		);
	
	assign op_op2_sr_i = is_op2 ? op_value_sr_o : op_op2_sr_o;
	
	wire [13:0] op_add1;
	wire [13:0] op_add2;
	
	assign op_add1 = ({14{add1_cur}} & op_value_sr_o)
		| ({14{add1_op1_2}} & op_op1_2_sr_o)
		| ({14{add1_op2}} & op_op2_sr_o);
		
	assign op_add2 = ({14{add2_cur}} & op_value_sr_o)
		| ({14{add2_op1_1}} & op_op1_1_sr_o);
	
	
	wire [14:0] op_sum = { op_add1[13], op_add1 } + { op_add2[13], op_add2 };
	
	wire [13:0] op_sum_sr_o;
	
	ym_sr_bit_array #(.DATA_WIDTH(14)) op_sum_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(op_sum[14:1]),
		.data_out(op_sum_sr_o)
		);
	
	wire is_fb = ~no_fb;
	
	wire [7:1] fb_sel;
	
	genvar i;
	generate
		for (i = 1; i < 8; i = i + 1)
		begin : l1
			assign fb_sel[i] = is_fb & (fb == i);
		end
	endgenerate
	
	wire [9:0] op_fm_value;
	
	assign op_fm_value = ({10{no_fb}} & op_sum_sr_o[9:0])
		| ({10{fb_sel[1]}} & {{4{op_sum_sr_o[13]}}, op_sum_sr_o[13:8]})
		| ({10{fb_sel[2]}} & {{3{op_sum_sr_o[13]}}, op_sum_sr_o[13:7]})
		| ({10{fb_sel[3]}} & {{2{op_sum_sr_o[13]}}, op_sum_sr_o[13:6]})
		| ({10{fb_sel[4]}} & {{1{op_sum_sr_o[13]}}, op_sum_sr_o[13:5]})
		| ({10{fb_sel[5]}} & op_sum_sr_o[13:4])
		| ({10{fb_sel[6]}} & op_sum_sr_o[12:3])
		| ({10{fb_sel[7]}} & op_sum_sr_o[11:2]);
	
	ym_sr_bit_array #(.DATA_WIDTH(10), .SR_LENGTH(6)) op_fm_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(op_fm_value),
		.data_out(mod_add)
		);
	
endmodule

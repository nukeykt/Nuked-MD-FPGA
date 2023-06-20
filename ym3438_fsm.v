module ym3438_fsm
	(
	input MCLK,
	input c1,
	input c2,
	input fsm_reset,
	input [2:0] connect,
	output fsm_sel0_o,
	output fsm_sel1_o,
	output fsm_sel2_o,
	output fsm_sel23_o,
	output fsm_timer_ed_o,
	output fsm_op1_sel_o,
	output fsm_op2_sel_o,
	output fsm_ch3_sel_o,
	output alg_fb_sel_o,
	output alg_op2_o,
	output alg_cur1_o,
	output alg_cur2_o,
	output alg_op1_0_o,
	output alg_out_o,
	output fsm_dac_load,
	output fsm_dac_out_sel,
	output fsm_dac_ch6
	);
	
	wire [1:0] cnt_low_out;
	wire [2:0] cnt_high_out;
	
	wire [4:0] fsm_cnt;
	
	wire reset_low_cnt = fsm_reset | cnt_low_out[1];
	
	ym3438_cnt_bit #(.DATA_WIDTH(2)) cnt_low
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.c_in(1'h1),
		.reset(reset_low_cnt),
		.val(cnt_low_out),
		.c_out()
		);
	
	ym3438_cnt_bit #(.DATA_WIDTH(3)) cnt_high
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.c_in(cnt_low_out[1]),
		.reset(fsm_reset),
		.val(cnt_high_out),
		.c_out()
		);
		
	assign fsm_cnt = { cnt_high_out, cnt_low_out };
	
	wire [23:0] fsm_sel;
	
	genvar i, j;
		
	generate
		for (i = 0; i < 8; i=i+1)
		begin : l1
			for (j = 0; j < 3; j=j+1)
			begin : l2
				assign fsm_sel[i*3+j] = (cnt_high_out == i) & (cnt_low_out == j);
			end
		end
	endgenerate
	
	wire fsm_sel0 = fsm_sel[0];
	wire fsm_op4_sel = fsm_sel[0] | fsm_sel[1] | fsm_sel[2] | fsm_sel[3] | fsm_sel[4] | fsm_sel[5];
	wire fsm_op1_sel = fsm_sel[6] | fsm_sel[7] | fsm_sel[8] | fsm_sel[9] | fsm_sel[10] | fsm_sel[11];
	wire fsm_op3_sel = fsm_sel[12] | fsm_sel[13] | fsm_sel[14] | fsm_sel[15] | fsm_sel[16] | fsm_sel[17];
	wire fsm_op2_sel = fsm_sel[18] | fsm_sel[19] | fsm_sel[20] | fsm_sel[21] | fsm_sel[22] | fsm_sel[23];
	wire fsm_sel2 = fsm_sel[2];
	wire fsm_sel23 = fsm_sel[23];
	wire fsm_ch3_sel = fsm_sel[2] | fsm_sel[8] | fsm_sel[14] | fsm_sel[20];
	assign fsm_dac_load = fsm_sel[0] | fsm_sel[4] | fsm_sel[8] | fsm_sel[12] | fsm_sel[16] | fsm_sel[20];
	assign fsm_dac_out_sel = fsm_sel[12] | fsm_sel[13] | fsm_sel[14] | fsm_sel[15] | fsm_sel[16] | fsm_sel[17]
							| fsm_sel[18] | fsm_sel[19] | fsm_sel[20] | fsm_sel[21] | fsm_sel[22] | fsm_sel[23];
	assign fsm_dac_ch6 = fsm_sel[4] | fsm_sel[5] | fsm_sel[6] | fsm_sel[7];
	wire fsm_sel1 = fsm_sel[1];
	
	wire fsm_timer_ed;
	
	ym3438_edge_detect ed
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(fsm_sel[2]),
		.outp(fsm_timer_ed)
		);
	
	wire alg_fb_sel_sr_out;
	wire alg_fb_sel = ~alg_fb_sel_sr_out;
		
	ym3438_sr_bit alg_fb_sel_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(fsm_op2_sel),
		.sr_out(alg_fb_sel_sr_out)
		);

	wire [7:0] alg_sel;
	
	generate
		for (i = 0; i < 8; i=i+1)
		begin : l3
			assign alg_sel[i] = connect == i;
		end
	endgenerate
	
	wire alg_567 = alg_sel[5] | alg_sel[6] | alg_sel[7];
	wire alg_4567 = alg_sel[4] | alg_sel[5] | alg_sel[6] | alg_sel[7];
	wire alg_25 = alg_sel[2] | alg_sel[5];
	wire alg_15 = alg_sel[1] | alg_sel[5];
	wire alg_03456 = alg_sel[0] | alg_sel[3] | alg_sel[4] | alg_sel[5] | alg_sel[6];
	wire alg_0134 = alg_sel[0] | alg_sel[1] | alg_sel[3] | alg_sel[4];
	wire alg_012 = alg_sel[0] | alg_sel[1] | alg_sel[2];
	
	wire alg_op2 = (fsm_op4_sel & alg_012) | (fsm_op3_sel & alg_sel[3]);
	wire alg_cur1 = (fsm_op3_sel & alg_sel[2]);
	wire alg_cur2 = (fsm_op1_sel & alg_03456) | (fsm_op3_sel & alg_0134);
	wire alg_op1_0 = (fsm_op4_sel & alg_15) | (fsm_op3_sel & alg_25) | fsm_op2_sel;
	wire alg_out = (fsm_op1_sel & alg_sel[7]) | (fsm_op3_sel & alg_567) | (fsm_op2_sel & alg_4567) | fsm_op4_sel;
	
	assign fsm_sel0_o = fsm_sel0;
	assign fsm_sel1_o = fsm_sel1;
	assign fsm_sel2_o = fsm_sel2;
	assign fsm_sel23_o = fsm_sel23;
	assign fsm_timer_ed_o = fsm_timer_ed;
	assign fsm_op1_sel_o = fsm_op1_sel;
	assign fsm_op2_sel_o = fsm_op2_sel;
	assign fsm_ch3_sel_o = fsm_ch3_sel;
	assign alg_fb_sel_o = alg_fb_sel;
	assign alg_op2_o = alg_op2;
	assign alg_cur1_o = alg_cur1;
	assign alg_cur2_o = alg_cur2;
	assign alg_op1_0_o = alg_op1_0;
	assign alg_out_o = alg_out;
	
endmodule

module ym3438_eg
	(
	input MCLK,
	input c1,
	input c2,
	input fsm_sel0,
	input IC,
	input TEST_i,
	input [7:0] lsi_21,
	input [7:3] lsi_2c,
	input [4:0] rate,
	input [4:0] kcode,
	input [1:0] ks,
	input [4:0] sl,
	input kon,
	input ssg_enable,
	input ssg_inv,
	input ssg_repeat,
	input ssg_holdup,
	input ssg_type0,
	input ssg_type2,
	input ssg_type3,
	input csm_kon,
	input [6:0] tl,
	input [1:0] ams,
	input [5:0] lfo_am,
	input mode_csm,
	input ch3_sel,
	input fsm_sel2,
	output [1:0] rate_sel,
	output pg_reset,
	output test_inc,
	output [9:0] eg_out,
	output eg_dbg
	);
	
	wire nIC = ~IC;
	
	wire fsm_sel1;
	
	ym_sr_bit fsm_sel1_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(fsm_sel0),
		.sr_out(fsm_sel1)
		);
	
	wire fsm_sel12;
	
	ym_sr_bit #(.SR_LENGTH(12)) fsm_sel12_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(fsm_sel0),
		.sr_out(fsm_sel12)
		);
	
	wire subcnt_rst;
	wire [1:0] subcnt_o;
	
	ym_cnt_bit #(.DATA_WIDTH(2)) subcnt
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.c_in(fsm_sel0),
		.reset(subcnt_rst),
		.val(subcnt_o),
		.c_out()
		);
	
	assign subcnt_rst = nIC | (subcnt_o[1] & fsm_sel0);
	
	wire subcnt_of_l_o;
	
	ym_dlatch_1 subcnt_of_l
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(subcnt_o[1]),
		.val(subcnt_of_l_o),
		.nval()
		);
	
	wire subcnt_of_sr_o;
	
	ym_sr_bit subcnt_of_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(subcnt_o[1]),
		.sr_out(subcnt_of_sr_o)
		);
	
	wire timer_bit;
	
	wire mask_bit_sr_o;
	
	wire mask_bit = ~(fsm_sel0 | fsm_sel12 | nIC) & (mask_bit_sr_o | timer_bit);
	
	ym_sr_bit mask_bit_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(mask_bit),
		.sr_out(mask_bit_sr_o)
		);
	
	wire eg_timer_i;
	wire eg_timer_o1;
	wire eg_timer_o2;
	
	ym_sr_bit #(.SR_LENGTH(11)) eg_timer_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(eg_timer_i),
		.sr_out(eg_timer_o1)
		);
	
	ym_sr_bit eg_timer_sr2
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(eg_timer_o1),
		.sr_out(eg_timer_o2)
		);
	
	wire carry_sr_i;
	wire carry_sr_o;
	
	ym_sr_bit carry_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(carry_sr_i),
		.sr_out(carry_sr_o)
		);
		
	wire timer_add = (fsm_sel1 & subcnt_o[1]) | carry_sr_o;
	
	wire [1:0] timer_ha = eg_timer_o2 + timer_add;
	
	assign carry_sr_i = timer_ha[1];
	
	assign eg_timer_i = ~(nIC | lsi_21[5]) & timer_ha[0];
	
	wire test_in = (TEST_i & lsi_2c[6]);
	
	assign timer_bit = test_in | eg_timer_i;
	
	wire timer_bit_masked = timer_bit & ~mask_bit_sr_o;
	
	wire [11:0] timer_shift_sel;
	wire [11:0] timer_shift_i;
	
	genvar i;
	generate
		for (i = 11; i >= 0; i = i - 1)
		begin : l1
			
			if (i == 11)
				assign timer_shift_i[i] = timer_bit_masked;
			else
				assign timer_shift_i[i] = timer_shift_sel[i+1];
	
			ym_sr_bit timer_shift_sr
				(
				.MCLK(MCLK),
				.c1(c1),
				.c2(c2),
				.bit_in(timer_shift_i[i]),
				.sr_out(timer_shift_sel[i])
				);
		end
	endgenerate
	
	wire eg_cnt_ed_o;
	
	ym_edge_detect eg_cnt_ed
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(subcnt_of_sr_o & fsm_sel1),
		.outp(eg_cnt_ed_o)
		);
	
	wire [1:0] eg_cnt_low_o;
		
	ym_slatch #(.DATA_WIDTH(2)) eg_cnt_low
		(
		.MCLK(MCLK),
		.en(eg_cnt_ed_o),
		.inp({ eg_timer_o1, eg_timer_o2}),
		.val(eg_cnt_low_o),
		.nval()
		);
	
	wire [3:0] eg_cnt_shift_i;
	
	assign eg_cnt_shift_i[0] = timer_shift_sel[0] | timer_shift_sel[2] | timer_shift_sel[4]
		| timer_shift_sel[6] | timer_shift_sel[8] | timer_shift_sel[10];
	assign eg_cnt_shift_i[1] = timer_shift_sel[1] | timer_shift_sel[2] | timer_shift_sel[5]
		| timer_shift_sel[6] | timer_shift_sel[9] | timer_shift_sel[10];
	assign eg_cnt_shift_i[2] = timer_shift_sel[3] | timer_shift_sel[4] | timer_shift_sel[5]
		| timer_shift_sel[6] | timer_shift_sel[11];
	assign eg_cnt_shift_i[3] = timer_shift_sel[7] | timer_shift_sel[8] | timer_shift_sel[9]
		| timer_shift_sel[10] | timer_shift_sel[11];
	
	wire [3:0] eg_cnt_shift_o;
		
	ym_slatch #(.DATA_WIDTH(4)) eg_cnt_shift
		(
		.MCLK(MCLK),
		.en(eg_cnt_ed_o),
		.inp(eg_cnt_shift_i),
		.val(eg_cnt_shift_o),
		.nval()
		);
	
	wire rate_nz_sr_o;
	
	ym_sr_bit rate_nz_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(rate != 5'h0),
		.sr_out(rate_nz_sr_o)
		);
	
	wire [4:0] rate_l_o; // ~eg_rate
	
	ym_dlatch_1 #(.DATA_WIDTH(5)) rate_l
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(rate),
		.val(),
		.nval(rate_l_o)
		);
	
	wire [4:0] rate_ks_add;
	
	assign rate_ks_add[0] = ((ks == 2'h0) & kcode[3]) | ((ks == 2'h1) & kcode[2]) | ((ks == 2'h2) & kcode[1]) | ((ks == 2'h3) & kcode[0]);
	assign rate_ks_add[1] = ((ks == 2'h0) & kcode[4]) | ((ks == 2'h1) & kcode[3]) | ((ks == 2'h2) & kcode[2]) | ((ks == 2'h3) & kcode[1]);
	assign rate_ks_add[2] = ((ks == 2'h1) & kcode[4]) | ((ks == 2'h2) & kcode[3]) | ((ks == 2'h3) & kcode[2]);
	assign rate_ks_add[3] = ((ks == 2'h2) & kcode[4]) | ((ks == 2'h3) & kcode[3]);
	assign rate_ks_add[4] = ((ks == 2'h3) & kcode[4]);
	
	wire [4:0] rate_ks_add_l_o; // ~eg_ksv
	
	ym_dlatch_1 #(.DATA_WIDTH(5)) rate_ks_add_l
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(rate_ks_add),
		.val(),
		.nval(rate_ks_add_l_o)
		);
	
	wire [6:0] rate_sum = { 1'h0, rate_l_o, 1'h1 } + { 2'h1, rate_ks_add_l_o } + 7'h1;
	
	wire [6:0] rate_sum_l_o; // eg_rate2
	
	ym_dlatch_2 #(.DATA_WIDTH(7)) rate_sum_l
		(
		.MCLK(MCLK),
		.c2(c2),
		.inp(rate_sum),
		.val(),
		.nval(rate_sum_l_o)
		);
	
	wire [5:0] rate_sum_clamp = rate_sum_l_o[5:0] | {6{rate_sum_l_o[6]}};
	
	wire rate_ls12 = rate_sum_clamp[5:4] != 2'h3;
	wire rate_sum_nz = rate_sum_clamp != 6'h00;
	
	wire [3:0] rate_shift_sum = rate_sum_clamp[5:2] + eg_cnt_shift_o;
	
	wire step_12 = rate_shift_sum == 4'hc & rate_sum_nz & rate_nz_sr_o & rate_ls12;
	wire step_13 = rate_shift_sum == 4'hd & rate_sum_clamp[1] & rate_nz_sr_o & rate_ls12;
	wire step_14 = rate_shift_sum == 4'he & rate_sum_clamp[0] & rate_nz_sr_o & rate_ls12;
	
	wire step_comb = ~(step_12 | step_13 | step_14);
	
	wire step_low_l_o; // eg_inc1
	
	ym_dlatch_1 step_low_l
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(step_comb),
		.val(),
		.nval(step_low_l_o)
		);
	
	wire rate_sum_not_max = rate_sum_clamp[5:1] != 5'h1f;
	wire rate_sum_12 = rate_sum_clamp[5:2] != 4'hc;
	wire rate_sum_13 = rate_sum_clamp[5:2] != 4'hd;
	wire rate_sum_14 = rate_sum_clamp[5:2] != 4'he;
	wire rate_sum_15 = rate_sum_clamp[5:2] != 4'hf;
	
	wire rate_not_max_sr_o; // ~eg_maxrate[1]
	
	ym_sr_bit rate_not_max_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(rate_sum_not_max),
		.sr_out(rate_not_max_sr_o)
		);
	
	wire rate_12_l_o; // eg_rate12
	wire rate_13_l_o; // eg_rate13
	wire rate_14_l_o; // eg_rate14
	wire rate_15_l_o; // eg_rate15
	
	ym_dlatch_1 rate_12_l
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(rate_sum_12),
		.val(),
		.nval(rate_12_l_o)
		);
	
	ym_dlatch_1 rate_13_l
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(rate_sum_13),
		.val(),
		.nval(rate_13_l_o)
		);
	
	ym_dlatch_1 rate_14_l
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(rate_sum_14),
		.val(),
		.nval(rate_14_l_o)
		);
	
	ym_dlatch_1 rate_15_l
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(rate_sum_15),
		.val(),
		.nval(rate_15_l_o)
		);
	
	wire rate_hi_sel = ~(
		(~eg_cnt_low_o[0] & rate_sum_clamp[1])
		| (eg_cnt_low_o == 2'h0 & rate_sum_clamp[1:0] == 2'h1)
		| (eg_cnt_low_o == 2'h1 & rate_sum_clamp[1:0] == 2'h3)
		);
	
	wire rate_hi_sel_l_o; // eg_inc2
	
	ym_dlatch_1 rate_hi_sel_l
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(rate_hi_sel),
		.val(),
		.nval(rate_hi_sel_l_o)
		);
	
	wire inc1 = subcnt_of_l_o & (step_low_l_o | (~rate_hi_sel_l_o & rate_12_l_o));
	wire inc2 = subcnt_of_l_o & (rate_hi_sel_l_o ? rate_12_l_o : rate_13_l_o);
	wire inc3 = subcnt_of_l_o & (rate_hi_sel_l_o ? rate_13_l_o : rate_14_l_o);
	wire inc4 = subcnt_of_l_o & ((rate_hi_sel_l_o & rate_14_l_o) | rate_15_l_o);
	
	wire inc1_l_o;
	wire inc2_l_o;
	wire inc3_l_o;
	wire inc4_l_o;
	
	ym_dlatch_2 inc1_l
		(
		.MCLK(MCLK),
		.c2(c2),
		.inp(inc1),
		.val(inc1_l_o),
		.nval()
		);
	
	ym_dlatch_2 inc2_l
		(
		.MCLK(MCLK),
		.c2(c2),
		.inp(inc2),
		.val(inc2_l_o),
		.nval()
		);
	
	ym_dlatch_2 inc3_l
		(
		.MCLK(MCLK),
		.c2(c2),
		.inp(inc3),
		.val(inc3_l_o),
		.nval()
		);
	
	ym_dlatch_2 inc4_l
		(
		.MCLK(MCLK),
		.c2(c2),
		.inp(inc4),
		.val(inc4_l_o),
		.nval()
		);
	
	wire inc_test_i = inc1_l_o | inc2_l_o | inc3_l_o | inc4_l_o;
	
	ym_sr_bit inc_test_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(inc_test_i),
		.sr_out(test_inc)
		);
	
	wire [4:0] sl_sr_o;
	
	ym_sr_bit_array #(.DATA_WIDTH(5), .SR_LENGTH(2)) sl_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(sl),
		.data_out(sl_sr_o)
		);
		

	wire ssg_pg_reset;
	wire ssg_pg_reset_o;
	
	ym_sr_bit #(.SR_LENGTH(2)) ssg_pg_reset_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(ssg_pg_reset),
		.sr_out(ssg_pg_reset_o)
		);
		
	wire ssg_toggle;
	wire ssg_toggle_o;
	
	ym_sr_bit #(.SR_LENGTH(2)) ssg_toggle_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(ssg_toggle),
		.sr_out(ssg_toggle_o)
		);
		
	wire ssg_enable_o;
	
	ym_sr_bit #(.SR_LENGTH(2)) ssg_enable_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(ssg_enable),
		.sr_out(ssg_enable_o)
		);
		
	wire ssg_holdup_i = ~(ssg_holdup & ssg_enable & kon);
	wire ssg_holdup_o;
	
	ym_sr_bit #(.SR_LENGTH(2)) ssg_holdup_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(ssg_holdup_i),
		.sr_out(ssg_holdup_o)
		);
	
	wire ssg_inv_i;
	wire ssg_inv_o;
	
	ym_sr_bit #(.SR_LENGTH(24)) ssg_inv_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(ssg_inv_i),
		.sr_out(ssg_inv_o)
		);
	
	wire csm_kon_o;
	ym_sr_bit #(.SR_LENGTH(2)) csm_kon_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(csm_kon),
		.sr_out(csm_kon_o)
		);
	
	wire [6:0] tl_o;
	wire [6:0] tl_o1;
	ym_sr_bit_array #(.DATA_WIDTH(7)) tl_sr_1
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(tl),
		.data_out(tl_o)
		);
	
	ym_sr_bit_array #(.DATA_WIDTH(7)) tl_sr_2
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(tl_o),
		.data_out(tl_o1)
		);
	
	wire pg_reset_i;
	ym_sr_bit #(.SR_LENGTH(2)) pg_reset_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(pg_reset_i),
		.sr_out(pg_reset)
		);
		
	wire kon_sr_o;
	
	ym_sr_bit #(.SR_LENGTH(2)) kon_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(kon),
		.sr_out(kon_sr_o)
		);
	
	wire okon_sr1_o; // okon2
	wire okon_sr_o; // okon
	
	ym_sr_bit #(.SR_LENGTH(22)) okon_sr1
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(kon_sr_o),
		.sr_out(okon_sr1_o)
		);
	
	ym_sr_bit #(.SR_LENGTH(2)) okon_sr2
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(okon_sr1_o),
		.sr_out(okon_sr_o)
		);
	
	wire [1:0] state_sr_i;
	wire [1:0] state_sr1_o;
	wire [1:0] state_sr_o;
	
	ym_sr_bit_array #(.DATA_WIDTH(2), .SR_LENGTH(22)) state_sr1
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(state_sr_i),
		.data_out(state_sr1_o)
		);
	
	ym_sr_bit_array #(.DATA_WIDTH(2), .SR_LENGTH(2)) state_sr2
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(state_sr1_o),
		.data_out(state_sr_o)
		);
	
	
	wire [9:0] eg_level_sr_i;
	wire [9:0] eg_level_sr_o1;
	wire [9:0] eg_level_sr_o;
	
	wire [9:0] eg_level2;
	
	wire sl_reach = eg_level2[9:5] == sl_sr_o & eg_level2[4] == 1'h0;
	wire zr_reach = eg_level2 == 10'h0;
	wire eg_quiet = eg_level2[9:4] == 6'h3f;
	wire eg_quiet_ssg = ssg_enable_o ? eg_level2[9] : eg_quiet;
	
	assign ssg_pg_reset = ssg_enable & eg_level_sr_o1[9] & ssg_type0;
	assign ssg_toggle = ssg_enable & eg_level_sr_o1[9] & ssg_repeat;
	
	assign ssg_inv_i = ssg_enable & okon_sr1_o
		& ((eg_level_sr_o1[9] & ssg_type3) | ((eg_level_sr_o1[9] & ssg_type2) ^ ssg_inv_o));
	
	wire kon_toggle = kon_sr_o & ~okon_sr_o;
	wire kon_toggle_off = ~kon_sr_o & okon_sr_o;
	
	wire kon_event_n = ~(kon_toggle | (okon_sr_o & ssg_toggle_o));
	
	assign pg_reset_i = ~(kon_toggle | ssg_pg_reset_o);
	
	wire rate_att = ~(okon_sr1_o ? ssg_toggle : kon);
	
	assign rate_sel = rate_att ? state_sr1_o : 2'h0;
	
	wire set_release = state_sr_o == 2'h3 & kon_event_n;
	wire set_release_koff = kon_event_n & ~kon_sr_o;
	wire eg_mute = nIC | (eg_quiet_ssg & state_sr_o != 2'h0 & ssg_holdup_o & kon_event_n);
	
	assign state_sr_i[0] = nIC
		| (state_sr_o == 2'h0 & zr_reach & kon_event_n)
		| (state_sr_o == 2'h1 & ~sl_reach & kon_event_n)
		| set_release
		| eg_mute
		| set_release_koff;
	assign state_sr_i[1] = nIC
		| (state_sr_o == 2'h1 & sl_reach & kon_event_n)
		| (state_sr_o == 2'h2 & kon_event_n)
		| set_release
		| eg_mute
		| set_release_koff;
	
	ym_sr_bit_array #(.DATA_WIDTH(10), .SR_LENGTH(21)) eg_level_sr1
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(eg_level_sr_i),
		.data_out(eg_level_sr_o1)
		);
	
	ym_sr_bit_array #(.DATA_WIDTH(10), .SR_LENGTH(2)) eg_level_sr2
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(eg_level_sr_o1),
		.data_out(eg_level_sr_o)
		);
		
	wire [9:0] eg_level_out_sr2_o;
	
	assign eg_level2 = kon_toggle_off ? eg_level_out_sr2_o : eg_level_sr_o;
	
	wire eg_linear_step = (kon_event_n & state_sr_o == 2'h1 & ~sl_reach & ~eg_quiet_ssg)
		| (kon_event_n & state_sr_o[1] & ~eg_quiet_ssg);
	
	wire eg_exp_step = state_sr_o == 2'h0 & kon_sr_o & ~zr_reach & rate_not_max_sr_o;
	
	wire eg_instantattack = (~rate_not_max_sr_o & kon_event_n) | rate_not_max_sr_o;
	
	wire eg_invert;
	
	ym_sr_bit eg_invert_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(okon_sr1_o & (ssg_inv ^ ssg_inv_o)),
		.sr_out(eg_invert)
		);
	
	wire [3:0] eg_add_linear_normal;
	
	assign eg_add_linear_normal[0] = eg_linear_step & ~ssg_enable_o & inc1_l_o;
	assign eg_add_linear_normal[1] = eg_linear_step & ~ssg_enable_o & inc2_l_o;
	assign eg_add_linear_normal[2] = eg_linear_step & ~ssg_enable_o & inc3_l_o;
	assign eg_add_linear_normal[3] = eg_linear_step & ~ssg_enable_o & inc4_l_o;
	
	wire [3:0] eg_add_linear_ssg;
	
	assign eg_add_linear_ssg[0] = eg_linear_step & ssg_enable_o & inc1_l_o;
	assign eg_add_linear_ssg[1] = eg_linear_step & ssg_enable_o & inc2_l_o;
	assign eg_add_linear_ssg[2] = eg_linear_step & ssg_enable_o & inc3_l_o;
	assign eg_add_linear_ssg[3] = eg_linear_step & ssg_enable_o & inc4_l_o;
	
	wire [9:0] eg_add_exponent_1 = { 4'hf, ~eg_level2[9:4] };
	wire [9:0] eg_add_exponent_2 = { 3'h7, ~eg_level2[9:3] };
	wire [9:0] eg_add_exponent_3 = { 2'h3, ~eg_level2[9:2] };
	wire [9:0] eg_add_exponent_4 = { 1'h1, ~eg_level2[9:1] };
	
	wire [9:0] eg_add_comb = { 6'h0, eg_add_linear_normal } | { 4'h0, eg_add_linear_ssg, 2'h0 }
		| ({10{inc1_l_o & eg_exp_step}} & eg_add_exponent_1)
		| ({10{inc2_l_o & eg_exp_step}} & eg_add_exponent_2)
		| ({10{inc3_l_o & eg_exp_step}} & eg_add_exponent_3)
		| ({10{inc4_l_o & eg_exp_step}} & eg_add_exponent_4);
	
	wire [9:0] eg_add_l_o;
	
	ym_dlatch_1 #(.DATA_WIDTH(10)) eg_add_l
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(eg_add_comb),
		.val(),
		.nval(eg_add_l_o)
		);
	
	wire [9:0] eg_level_comb;
	
	assign eg_level_comb = {10{eg_mute}} | ({10{eg_instantattack}} & eg_level2) | { ({7{csm_kon_o}} & tl_o1), 3'h0};
	
	wire [9:0] eg_level_comb_o;
	
	ym_dlatch_1 #(.DATA_WIDTH(10)) eg_level_comb_l
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(eg_level_comb),
		.val(),
		.nval(eg_level_comb_o)
		);
		
	wire [9:0] eg_level_sum = eg_add_l_o + eg_level_comb_o + 10'h1;
	
	ym_dlatch_2 #(.DATA_WIDTH(10)) eg_level_sum_l
		(
		.MCLK(MCLK),
		.c2(c2),
		.inp(eg_level_sum),
		.val(),
		.nval(eg_level_sr_i)
		);
	
	wire [9:0] eg_level_out_sr_o;
	
	ym_sr_bit_array #(.DATA_WIDTH(10)) eg_level_out_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(eg_level_sr_o1),
		.data_out(eg_level_out_sr_o)
		);
	
	wire [9:0] eg_level_outinv_l1_o;
	
	ym_dlatch_1 #(.DATA_WIDTH(10)) eg_level_outinv_l1
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(eg_level_sr_o1),
		.val(),
		.nval(eg_level_outinv_l1_o)
		);
	
	wire [9:0] eg_level_outinv_l2_i = eg_level_outinv_l1_o + 10'h201;
	wire [9:0] eg_level_outinv_l2_o;
	
	ym_dlatch_2 #(.DATA_WIDTH(10)) eg_level_outinv_l2
		(
		.MCLK(MCLK),
		.c2(c2),
		.inp(eg_level_outinv_l2_i),
		.val(eg_level_outinv_l2_o),
		.nval()
		);
	
	wire [9:0] eg_level_out = eg_invert ? eg_level_outinv_l2_o : eg_level_out_sr_o;
	
	ym_sr_bit_array #(.DATA_WIDTH(10)) eg_level_out_sr2
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(eg_level_out),
		.data_out(eg_level_out_sr2_o)
		);
	
	wire [9:0] eg_level_out_test = lsi_21[5] ? 10'h0 : eg_level_out;
	
	wire [6:0] eg_lfo_mux;
	
	wire [1:0] ams_l_o;
	
	ym_dlatch_1 #(.DATA_WIDTH(2)) ams_l
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(ams),
		.val(ams_l_o),
		.nval()
		);
	
	wire [5:0] lfo_am_l_o;
	
	ym_dlatch_1 #(.DATA_WIDTH(6)) lfo_am_l
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(lfo_am),
		.val(lfo_am_l_o),
		.nval()
		);
	
	wire [3:0] ams_sel;
	assign ams_sel[0] = ams_l_o == 2'h0;
	assign ams_sel[1] = ams_l_o == 2'h1;
	assign ams_sel[2] = ams_l_o == 2'h2;
	assign ams_sel[3] = ams_l_o == 2'h3;
	
	wire [6:0] lfo_sh0 = { 3'h0, lfo_am_l_o[5:2] };
	wire [6:0] lfo_sh1 = { 2'h0, lfo_am_l_o[5:1] };
	wire [6:0] lfo_sh2 = { 1'h0, lfo_am_l_o };
	wire [6:0] lfo_sh3 = { lfo_am_l_o, 1'h0 };
	
	assign eg_lfo_mux = ~(
		({7{ams_sel[1]}} & lfo_sh0)
		| ({7{ams_sel[2]}} & lfo_sh2)
		| ({7{ams_sel[3]}} & lfo_sh3)
		);
	
	wire [6:0] eg_lfo_mux_l_o;
	
	ym_dlatch_2 #(.DATA_WIDTH(7)) eg_lfo_mux_l
		(
		.MCLK(MCLK),
		.c2(c2),
		.inp(eg_lfo_mux),
		.val(),
		.nval(eg_lfo_mux_l_o)
		);
	
	wire [10:0] eg_level_lfo = { 4'h0, eg_lfo_mux_l_o } + { 1'h0, eg_level_out_test };
	//wire [10:0] eg_level_lfo = eg_level_out_test;
	wire [10:0] eg_level_lfo_l_o;
	
	ym_dlatch_1 #(.DATA_WIDTH(11)) eg_level_lfo_l
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(eg_level_lfo),
		.val(),
		.nval(eg_level_lfo_l_o)
		);
	
	wire ch3_sel_sr_o;
	
	ym_sr_bit ch3_sel_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(ch3_sel),
		.sr_out(ch3_sel_sr_o)
		);
	
	wire not_csm = ~(mode_csm & ch3_sel_sr_o);
		
	wire [6:0] tl_add_l_i = not_csm ? tl_o : 7'h0;
	wire [6:0] tl_add_l_o;
	
	ym_dlatch_1 #(.DATA_WIDTH(7)) tl_add_l
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(tl_add_l_i),
		.val(),
		.nval(tl_add_l_o)
		);
	
	wire [10:0] eg_level_tl = { 1'h0, eg_level_lfo_l_o[9:0] } + { 1'h0, tl_add_l_o, 3'h0 } + 11'h8;
	//wire [10:0] eg_level_tl = eg_level_lfo_l_o[9:0];
	
	wire eg_level_of = eg_level_tl[10] & eg_level_lfo_l_o[10];
	//wire eg_level_of = 1'h1;
	
	wire [9:0] eg_level_tl_clamp = eg_level_of ? eg_level_tl[9:0] : 10'h0;
	
	ym_dlatch_2 #(.DATA_WIDTH(10)) eg_out_l
		(
		.MCLK(MCLK),
		.c2(c2),
		.inp(eg_level_tl_clamp),
		.val(),
		.nval(eg_out)
		);
	
	ym_dbg_read_eg #(.DATA_WIDTH(10)) dbg_read
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.prev(0),
		.load(fsm_sel2),
		.load_val(eg_out),
		.next(eg_dbg)
		);
	
endmodule

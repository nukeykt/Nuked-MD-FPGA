module ym3438_reg_ctrl
	(
	input MCLK,
	input c1,
	input c2,
	input [7:0] data,
	input bank,
	input write_addr_en,
	input write_data_en,
	input IC,
	input fsm_sel_23,
	input fsm_sel_1,
	input timer_ed,
	input ch3_sel,
	input [1:0] rate_sel,
	input fsm_dac_load,
	input fsm_dac_out_sel,
	output [3:0] multi,
	output [2:0] dt,
	output [6:0] tl,
	output [1:0] ks,
	output [4:0] sl,
	output ssg_enable,
	output ssg_inv,
	output ssg_repeat,
	output ssg_holdup,
	output ssg_type0,
	output ssg_type2,
	output ssg_type3,
	output [4:0] rate,
	output [10:0] fnum,
	output [2:0] block,
	output [1:0] note,
	output [2:0] connect,
	output [2:0] fb,
	output [2:0] pms,
	output [1:0] ams,
	output [1:0] pan_o,
	output [7:0] reg_21,
	output [3:0] lfo,
	output [7:0] dac,
	output dac_en,
	output [7:3] reg_2c,
	output kon,
	output kon_csm,
	output mode_csm,
	output timer_a_status,
	output timer_b_status
	);
	
	wire fm_addr_write = (data[7:4] != 0) & write_addr_en;
	
	wire fm_addr_sr_o;
	
	ym_sr_bit fm_addr_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(~((~write_addr_en & ~fm_addr_sr_o) | fm_addr_write)),
		.sr_out(fm_addr_sr_o)
		);
	
	wire fm_data_write = ~fm_addr_sr_o & write_data_en;
	
	wire fm_data_sr_o2;
	wire fm_data_sr_o = ~fm_data_sr_o2;
	
	ym_sr_bit fm_data_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(~((~write_addr_en & fm_data_sr_o) | fm_data_write)),
		.sr_out(fm_data_sr_o2)
		);
		
	wire nIC = ~IC;
	
	wire [8:0] fm_address_in;
	wire [8:0] fm_address_out;
	
	assign fm_address_in = nIC ? 9'h000 : (fm_addr_write ? { bank, data } : fm_address_out); 
	
	ym_sr_bit_array #(.DATA_WIDTH(9)) fm_address
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(fm_address_in),
		.data_out(fm_address_out)
		);
	
	wire [7:0] fm_data_in;
	wire [7:0] fm_data_out;
	
	assign fm_data_in = nIC ? 8'h00 : (fm_data_write ? data : fm_data_out); 
	
	ym_sr_bit_array #(.DATA_WIDTH(8)) fm_data
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(fm_data_in),
		.data_out(fm_data_out)
		);
	
	wire [1:0] cnt_low_out;
	wire [2:0] cnt_high_out;
	
	wire [4:0] reg_cnt = { cnt_high_out, cnt_low_out };
	
	wire cnt_reset = nIC | fsm_sel_23;
	
	wire reset_low_cnt = cnt_reset | cnt_low_out[1];
	
	ym_cnt_bit #(.DATA_WIDTH(2)) cnt_low
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.c_in(1'h1),
		.reset(reset_low_cnt),
		.val(cnt_low_out),
		.c_out()
		);
	
	ym_cnt_bit #(.DATA_WIDTH(3)) cnt_high
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.c_in(cnt_low_out[1]),
		.reset(cnt_reset),
		.val(cnt_high_out),
		.c_out()
		);

	wire ch_match = ~((reg_cnt[0] ^ fm_address_out[0]) | (reg_cnt[1] ^ fm_address_out[1]) | (reg_cnt[2] ^ fm_address_out[8]));
	
	wire ch_write = ch_match & fm_data_sr_o;
	
	wire ch_writeA0 = ch_write & (fm_address_out[7:2] == 6'h28);
	wire ch_writeA4 = ch_write & (fm_address_out[7:2] == 6'h29);
	wire ch_writeA8 = ch_write & (fm_address_out[7:2] == 6'h2a);
	wire ch_writeAC = ch_write & (fm_address_out[7:2] == 6'h2b);
	wire ch_writeB0 = ch_write & (fm_address_out[7:2] == 6'h2c);
	wire ch_writeB4 = ch_write & (fm_address_out[7:2] == 6'h2d);
	
	wire op_match = ~((reg_cnt[0] ^ fm_address_out[0]) | (reg_cnt[1] ^ fm_address_out[1]) | (reg_cnt[3] ^ fm_address_out[2]) | (reg_cnt[2] ^ fm_address_out[8]));
	
	wire op_write = op_match & fm_data_sr_o;
	
	wire op_write30 = op_write & (fm_address_out[7:4] == 4'h3);
	wire op_write40 = op_write & (fm_address_out[7:4] == 4'h4);
	wire op_write50 = op_write & (fm_address_out[7:4] == 4'h5);
	wire op_write60 = op_write & (fm_address_out[7:4] == 4'h6);
	wire op_write70 = op_write & (fm_address_out[7:4] == 4'h7);
	wire op_write80 = op_write & (fm_address_out[7:4] == 4'h8);
	wire op_write90 = op_write & (fm_address_out[7:4] == 4'h9);
	
	wire [3:0] reg_multi_o;
	
	ym_sr_bit_array #(.DATA_WIDTH(4), .SR_LENGTH(2)) reg_multi_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(reg_multi_o),
		.data_out(multi)
		);
	
	ym3438_op_register #(.DATA_WIDTH(4)) reg_multi
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(fm_data_out[3:0]),
		.write_en(op_write30),
		.rst(nIC),
		.bank(fm_address_out[3]),
		.obank(reg_cnt[4]),
		.data_o(reg_multi_o)
		);
	
	ym3438_op_register #(.DATA_WIDTH(3)) reg_dt
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(fm_data_out[6:4]),
		.write_en(op_write30),
		.rst(nIC),
		.bank(fm_address_out[3]),
		.obank(reg_cnt[4]),
		.data_o(dt)
		);
	
	ym3438_op_register #(.DATA_WIDTH(7)) reg_tl
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(fm_data_out[6:0]),
		.write_en(op_write40),
		.rst(nIC),
		.bank(fm_address_out[3]),
		.obank(reg_cnt[4]),
		.data_o(tl)
		);
		
	wire [4:0] ar;
	
	ym3438_op_register #(.DATA_WIDTH(5)) reg_ar
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(fm_data_out[4:0]),
		.write_en(op_write50),
		.rst(nIC),
		.bank(fm_address_out[3]),
		.obank(reg_cnt[4]),
		.data_o(ar)
		);
	
	ym3438_op_register #(.DATA_WIDTH(2)) reg_ks
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(fm_data_out[7:6]),
		.write_en(op_write50),
		.rst(nIC),
		.bank(fm_address_out[3]),
		.obank(reg_cnt[4]),
		.data_o(ks)
		);
		
	wire [4:0] dr;
	
	ym3438_op_register #(.DATA_WIDTH(5)) reg_dr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(fm_data_out[4:0]),
		.write_en(op_write60),
		.rst(nIC),
		.bank(fm_address_out[3]),
		.obank(reg_cnt[4]),
		.data_o(dr)
		);
		
	wire am;
	
	ym3438_op_register #(.DATA_WIDTH(1)) reg_am
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(fm_data_out[7:7]),
		.write_en(op_write60),
		.rst(nIC),
		.bank(fm_address_out[3]),
		.obank(reg_cnt[4]),
		.data_o(am)
		);
		
	wire [4:0] sr;
	
	ym3438_op_register #(.DATA_WIDTH(5)) reg_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(fm_data_out[4:0]),
		.write_en(op_write70),
		.rst(nIC),
		.bank(fm_address_out[3]),
		.obank(reg_cnt[4]),
		.data_o(sr)
		);
		
	wire [3:0] rr;
	
	ym3438_op_register #(.DATA_WIDTH(4)) reg_rr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(fm_data_out[3:0]),
		.write_en(op_write80),
		.rst(nIC),
		.bank(fm_address_out[3]),
		.obank(reg_cnt[4]),
		.data_o(rr)
		);
	
	ym3438_op_register #(.DATA_WIDTH(4)) reg_sl
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(fm_data_out[7:4]),
		.write_en(op_write80),
		.rst(nIC),
		.bank(fm_address_out[3]),
		.obank(reg_cnt[4]),
		.data_o(sl[3:0])
		);
	
	assign sl[4] = sl[3:0] == 4'hf;
	
	wire [3:0] ssgeg;
	
	ym3438_op_register #(.DATA_WIDTH(4)) reg_ssgeg
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(fm_data_out[3:0]),
		.write_en(op_write90),
		.rst(nIC),
		.bank(fm_address_out[3]),
		.obank(reg_cnt[4]),
		.data_o(ssgeg)
		);
		
	assign ssg_enable = ssgeg[3];
	assign ssg_inv = ssgeg[2] & ssg_enable;
	assign ssg_repeat = ~ssgeg[0];
	assign ssg_holdup = ssgeg[2:0] == 3'h3 | ssgeg[2:0] == 3'h5;
	assign ssg_type0 = ssgeg[1:0] == 2'h0;
	assign ssg_type2 = ssgeg[1:0] == 2'h2;
	assign ssg_type3 = ssgeg[1:0] == 2'h3;
		
	wire [5:0] reg_a4_in;
	wire [5:0] reg_a4_out;
	
	ym_sr_bit_array #(.DATA_WIDTH(6)) reg_a4
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(reg_a4_in),
		.data_out(reg_a4_out)
		);
	
	assign reg_a4_in = nIC ? 6'h00 : (ch_writeA4 ? fm_data_out[5:0] : reg_a4_out);
		
	wire [5:0] reg_ac_in;
	wire [5:0] reg_ac_out;
	
	ym_sr_bit_array #(.DATA_WIDTH(6)) reg_ac
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(reg_ac_in),
		.data_out(reg_ac_out)
		);
	
	assign reg_ac_in = nIC ? 6'h00 : (ch_writeAC ? fm_data_out[5:0] : reg_ac_out);
	
	wire [10:0] reg_fnum_o;
	
	ym3438_ch_register #(.DATA_WIDTH(11)) reg_fnum
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data({reg_a4_out[2:0], fm_data_out}),
		.write_en(ch_writeA0),
		.rst(nIC),
		.data_o_4(reg_fnum_o)
		);
	
	wire [2:0] reg_block_o;
	
	ym3438_ch_register #(.DATA_WIDTH(3)) reg_block
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(reg_a4_out[5:3]),
		.write_en(ch_writeA0),
		.rst(nIC),
		.data_o_4(reg_block_o)
		);
	
	wire [10:0] reg_fnum_ch3_o_0;
	wire [10:0] reg_fnum_ch3_o_4;
	wire [10:0] reg_fnum_ch3_o_5;
	
	ym3438_ch_register #(.DATA_WIDTH(11)) reg_fnum_ch3
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data({reg_ac_out[2:0], fm_data_out}),
		.write_en(ch_writeA8),
		.rst(nIC),
		.data_o_0(reg_fnum_ch3_o_0),
		.data_o_4(reg_fnum_ch3_o_4),
		.data_o_5(reg_fnum_ch3_o_5)
		);
	
	wire [2:0] reg_block_ch3_o_0;
	wire [2:0] reg_block_ch3_o_4;
	wire [2:0] reg_block_ch3_o_5;
	
	ym3438_ch_register #(.DATA_WIDTH(3)) reg_block_ch3
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(reg_ac_out[5:3]),
		.write_en(ch_writeA8),
		.rst(nIC),
		.data_o_0(reg_block_ch3_o_0),
		.data_o_4(reg_block_ch3_o_4),
		.data_o_5(reg_block_ch3_o_5)
		);
	
	ym3438_ch_register #(.DATA_WIDTH(3)) reg_connect
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(fm_data_out[2:0]),
		.write_en(ch_writeB0),
		.rst(nIC),
		.data_o_5(connect)
		);
	
	ym3438_ch_register #(.DATA_WIDTH(3)) reg_fb
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(fm_data_out[5:3]),
		.write_en(ch_writeB0),
		.rst(nIC),
		.data_o_0(fb)
		);
	
	ym3438_ch_register #(.DATA_WIDTH(3)) reg_pms
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(fm_data_out[2:0]),
		.write_en(ch_writeB4),
		.rst(nIC),
		.data_o_5(pms)
		);
	
	wire [1:0] ams_o;
	
	assign ams = am ? ams_o : 2'h0;
	
	ym3438_ch_register #(.DATA_WIDTH(2)) reg_ams
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(fm_data_out[5:4]),
		.write_en(ch_writeB4),
		.rst(nIC),
		.data_o_5(ams_o)
		);
	
	wire [1:0] pan_o1;
	wire [1:0] pan_o2;
	
	ym3438_ch_register #(.DATA_WIDTH(2)) reg_pan
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(~fm_data_out[7:6]),
		.write_en(ch_writeB4),
		.rst(nIC),
		.data_o_4(pan_o1),
		.data_o_5(pan_o2)
		);
	
	wire [1:0] pan_sel = fsm_dac_out_sel ? ~pan_o2 : ~pan_o1;
	
	wire load_ed_o;
	
	ym_edge_detect load_ed
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(fsm_dac_load),
		.outp(load_ed_o)
		);

	ym_slatch #(.DATA_WIDTH(2)) pan_lock
		(
		.MCLK(MCLK),
		.en(load_ed_o),
		.inp(pan_sel),
		.val(pan_o),
		.nval()
		);
		
	wire reg_21_wr;
	
	ym3438_reg_wr_ctrl #(.REG_ADDRESS(8'h21)) reg_21_ctrl
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data),
		.bank(bank),
		.write_addr_en(write_addr_en),
		.write_data_en(write_data_en),
		.reg_wr(reg_21_wr)
		);
		
	ym3438_reg_data #(.DATA_WIDTH(8)) reg_21_data
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data[7:0]),
		.reg_wr(reg_21_wr),
		.rst(nIC),
		.data_o(reg_21)
		);
		
	wire reg_22_wr;
	
	ym3438_reg_wr_ctrl #(.REG_ADDRESS(8'h22)) reg_22_ctrl
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data),
		.bank(bank),
		.write_addr_en(write_addr_en),
		.write_data_en(write_data_en),
		.reg_wr(reg_22_wr)
		);
		
	ym3438_reg_data #(.DATA_WIDTH(4)) reg_22_data
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data[3:0]),
		.reg_wr(reg_22_wr),
		.rst(nIC),
		.data_o(lfo)
		);
	
	wire [9:0] reg_timer_a_o;
		
	wire reg_24_wr;
	
	ym3438_reg_wr_ctrl #(.REG_ADDRESS(8'h24)) reg_24_ctrl
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data),
		.bank(bank),
		.write_addr_en(write_addr_en),
		.write_data_en(write_data_en),
		.reg_wr(reg_24_wr)
		);
		
	ym3438_reg_data #(.DATA_WIDTH(8)) reg_24_data
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data[7:0]),
		.reg_wr(reg_24_wr),
		.rst(nIC),
		.data_o(reg_timer_a_o[9:2])
		);
		
	wire reg_25_wr;
	
	ym3438_reg_wr_ctrl #(.REG_ADDRESS(8'h25)) reg_25_ctrl
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data),
		.bank(bank),
		.write_addr_en(write_addr_en),
		.write_data_en(write_data_en),
		.reg_wr(reg_25_wr)
		);
		
	ym3438_reg_data #(.DATA_WIDTH(2)) reg_25_data
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data[1:0]),
		.reg_wr(reg_25_wr),
		.rst(nIC),
		.data_o(reg_timer_a_o[1:0])
		);
	
	wire [7:0] reg_timer_b_o;
		
	wire reg_26_wr;
	
	ym3438_reg_wr_ctrl #(.REG_ADDRESS(8'h26)) reg_26_ctrl
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data),
		.bank(bank),
		.write_addr_en(write_addr_en),
		.write_data_en(write_data_en),
		.reg_wr(reg_26_wr)
		);
		
	ym3438_reg_data #(.DATA_WIDTH(8)) reg_26_data
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data[7:0]),
		.reg_wr(reg_26_wr),
		.rst(nIC),
		.data_o(reg_timer_b_o)
		);
		
	wire reg_27_wr;
	
	ym3438_reg_wr_ctrl #(.REG_ADDRESS(8'h27)) reg_27_ctrl
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data),
		.bank(bank),
		.write_addr_en(write_addr_en),
		.write_data_en(write_data_en),
		.reg_wr(reg_27_wr)
		);
	
	wire [3:0] reg_27_timer_ctrl_o;
		
	ym3438_reg_data #(.DATA_WIDTH(4)) reg_27_timer_ctrl
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data[3:0]),
		.reg_wr(reg_27_wr),
		.rst(nIC),
		.data_o(reg_27_timer_ctrl_o)
		);
	
	wire [1:0] reg_27_timer_reset_o;

	ym_sr_bit_array #(.DATA_WIDTH(2)) reg_27_timer_reset
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(reg_27_wr ? data[5:4] : 2'h0),
		.data_out(reg_27_timer_reset_o)
		);
	
	wire [1:0] reg_27_mode_o;
		
	ym3438_reg_data #(.DATA_WIDTH(2)) reg_27_mode
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data[7:6]),
		.reg_wr(reg_27_wr),
		.rst(nIC),
		.data_o(reg_27_mode_o)
		);
		
	wire reg_28_wr;
	
	ym3438_reg_wr_ctrl #(.REG_ADDRESS(8'h28)) reg_28_ctrl
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data),
		.bank(bank),
		.write_addr_en(write_addr_en),
		.write_data_en(write_data_en),
		.reg_wr(reg_28_wr)
		);
	
	wire [2:0] reg_28_ch_o;
	wire [3:0] reg_28_slot_o;
		
	ym3438_reg_data #(.DATA_WIDTH(3)) reg_28_ch
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data[2:0]),
		.reg_wr(reg_28_wr),
		.rst(nIC),
		.data_o(reg_28_ch_o)
		);
		
	ym3438_reg_data #(.DATA_WIDTH(4)) reg_28_slot
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data[7:4]),
		.reg_wr(reg_28_wr),
		.rst(nIC),
		.data_o(reg_28_slot_o)
		);
		
	wire reg_2a_wr;
	
	ym3438_reg_wr_ctrl #(.REG_ADDRESS(8'h2a)) reg_2a_ctrl
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data),
		.bank(bank),
		.write_addr_en(write_addr_en),
		.write_data_en(write_data_en),
		.reg_wr(reg_2a_wr)
		);
		
	ym3438_reg_data #(.DATA_WIDTH(7)) reg_2a_dac
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data[6:0]),
		.reg_wr(reg_2a_wr),
		.rst(nIC),
		.data_o(dac[6:0])
		);

	
	wire reg_dac_msb_in;
	wire reg_dac_msb_out;

	ym_sr_bit reg_dac_msb
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(reg_dac_msb_in),
		.sr_out(reg_dac_msb_out)
		);
		
	assign reg_dac_msb_in = nIC ? 1'h0 : (reg_2a_wr ? ~data[7] : reg_dac_msb_out);
	assign dac[7] = ~reg_dac_msb_out;
		
	wire reg_2b_wr;
	
	ym3438_reg_wr_ctrl #(.REG_ADDRESS(8'h2b)) reg_2b_ctrl
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data),
		.bank(bank),
		.write_addr_en(write_addr_en),
		.write_data_en(write_data_en),
		.reg_wr(reg_2b_wr)
		);
		
	ym3438_reg_data #(.DATA_WIDTH(1)) reg_2b_dac_en
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data[7]),
		.reg_wr(reg_2b_wr),
		.rst(nIC),
		.data_o(dac_en)
		);
		
	wire reg_2c_wr;
	
	ym3438_reg_wr_ctrl #(.REG_ADDRESS(8'h2c)) reg_2c_ctrl
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data),
		.bank(bank),
		.write_addr_en(write_addr_en),
		.write_data_en(write_data_en),
		.reg_wr(reg_2c_wr)
		);
		
	ym3438_reg_data #(.DATA_WIDTH(5)) reg_2c_data
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data(data[7:3]),
		.reg_wr(reg_2c_wr),
		.rst(nIC),
		.data_o(reg_2c)
		);
	
	wire kon_sr1_in;
	wire kon_sr1_out;
	
	ym_sr_bit #(.SR_LENGTH(6)) kon_sr1
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(kon_sr1_in),
		.sr_out(kon_sr1_out)
		);
	
	wire kon_sr2_in;
	wire kon_sr2_out;
	
	ym_sr_bit #(.SR_LENGTH(6)) kon_sr2
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(kon_sr2_in),
		.sr_out(kon_sr2_out)
		);
	
	wire kon_sr3_in;
	wire kon_sr3_out;
	
	ym_sr_bit #(.SR_LENGTH(6)) kon_sr3
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(kon_sr3_in),
		.sr_out(kon_sr3_out)
		);
	
	wire kon_sr4_in;
	wire kon_sr4_out;
	
	ym_sr_bit #(.SR_LENGTH(6)) kon_sr4
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(kon_sr4_in),
		.sr_out(kon_sr4_out)
		);
	
	wire kon_ch_match = ~nIC & (reg_cnt == { 2'h0, reg_28_ch_o });
	
	assign kon_sr1_in = kon_ch_match ? reg_28_slot_o[0] : (~nIC & kon_sr4_out);
	assign kon_sr2_in = kon_ch_match ? reg_28_slot_o[3] : kon_sr1_out;
	assign kon_sr3_in = kon_ch_match ? reg_28_slot_o[1] : kon_sr2_out;
	assign kon_sr4_in = kon_ch_match ? reg_28_slot_o[2] : kon_sr3_out;
	
	assign kon = kon_sr4_out | kon_csm;
	
	assign mode_csm = reg_27_mode_o == 2'b10;
	
	wire mode_ch3 = reg_27_mode_o != 2'b00;
	
	wire timer_test = reg_21[2];
	
	wire timer_a_inc;
	wire timer_a_load;
	wire timer_a_load_cnt;
	wire timer_a_cout;
	wire timer_a_load_sr_o;
	wire timer_a_of_sr_o;
	wire timer_a_load_cnt_i;
	
	
	ym_cnt_bit_load #(.DATA_WIDTH(10)) timer_a_cnt
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.c_in(timer_a_inc),
		.reset(~timer_a_load),
		.load(timer_a_load_cnt),
		.load_val(reg_timer_a_o),
		.val(),
		.c_out(timer_a_cout)
		);
	
	assign timer_a_inc = (timer_a_load & fsm_sel_1) | timer_test;
	
	ym_slatch timer_a_load_l
		(
		.MCLK(MCLK),
		.en(timer_ed),
		.inp(reg_27_timer_ctrl_o[0]),
		.val(timer_a_load),
		.nval()
		);
	
	ym_sr_bit timer_a_load_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(timer_a_load),
		.sr_out(timer_a_load_sr_o)
		);
	
	ym_sr_bit timer_a_of_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(timer_a_cout),
		.sr_out(timer_a_of_sr_o)
		);
		
	assign timer_a_load_cnt_i = (~timer_a_load_sr_o & timer_a_load) | timer_a_of_sr_o;
	
	ym_sr_bit timer_a_load_cnt_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(timer_a_load_cnt_i),
		.sr_out(timer_a_load_cnt)
		);
	
	wire timer_a_status_reset = nIC | reg_27_timer_reset_o[0];
	
	wire timer_a_status_set = ~timer_a_status_reset & timer_a_of_sr_o & reg_27_timer_ctrl_o[2];
	
	wire timer_a_status_sr_o2;
	wire timer_a_status_sr_o = ~timer_a_status_sr_o2;
	assign timer_a_status = ~timer_a_status_sr_o;
	
	ym_sr_bit timer_a_status_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(~((timer_a_status_sr_o & ~timer_a_status_reset) | timer_a_status_set)),
		.sr_out(timer_a_status_sr_o2)
		);

	
	wire timer_b_inc;
	wire timer_b_load;
	wire timer_b_load_cnt;
	wire timer_b_sub_cout;
	wire timer_b_cout;
	wire timer_b_load_sr_o;
	wire timer_b_of_sr_o;
	wire timer_b_load_cnt_i;
	wire timer_b_subcnt_of_sr_o;
	
	ym_cnt_bit #(.DATA_WIDTH(4)) timer_b_subcnt
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.c_in(fsm_sel_1),
		.reset(nIC),
		.val(),
		.c_out(timer_b_sub_cout)
		);
	
	ym_sr_bit timer_b_subcnt_of_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(timer_b_sub_cout),
		.sr_out(timer_b_subcnt_of_sr_o)
		);
	
	
	ym_cnt_bit_load #(.DATA_WIDTH(8)) timer_b_cnt
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.c_in(timer_b_inc),
		.reset(~timer_b_load),
		.load(timer_b_load_cnt),
		.load_val(reg_timer_b_o),
		.val(),
		.c_out(timer_b_cout)
		);
	
	assign timer_b_inc = (timer_b_load & timer_b_subcnt_of_sr_o) | timer_test;
	
	ym_slatch timer_b_load_l
		(
		.MCLK(MCLK),
		.en(timer_ed),
		.inp(reg_27_timer_ctrl_o[1]),
		.val(timer_b_load),
		.nval()
		);
	
	ym_sr_bit timer_b_load_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(timer_b_load),
		.sr_out(timer_b_load_sr_o)
		);
	
	ym_sr_bit timer_b_of_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(timer_b_cout),
		.sr_out(timer_b_of_sr_o)
		);
		
	assign timer_b_load_cnt_i = (~timer_b_load_sr_o & timer_b_load) | timer_b_of_sr_o;
	
	ym_sr_bit timer_b_load_cnt_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(timer_b_load_cnt_i),
		.sr_out(timer_b_load_cnt)
		);
	
	wire timer_b_status_reset = nIC | reg_27_timer_reset_o[1];
	
	wire timer_b_status_set = ~timer_b_status_reset & timer_b_of_sr_o & reg_27_timer_ctrl_o[3];
	
	wire timer_b_status_sr_o2;
	wire timer_b_status_sr_o = ~timer_b_status_sr_o2;
	assign timer_b_status = ~timer_b_status_sr_o;
	
	ym_sr_bit timer_b_status_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(~((timer_b_status_sr_o & ~timer_b_status_reset) | timer_b_status_set)),
		.sr_out(timer_b_status_sr_o2)
		);
	
	wire kon_csm_o;
	
	ym_slatch kon_csm_l
		(
		.MCLK(MCLK),
		.en(timer_ed),
		.inp(mode_csm & timer_a_load_cnt_i),
		.val(kon_csm_o),
		.nval()
		);
		
	assign kon_csm = kon_csm_o & ch3_sel;
	
	wire [10:0] fnum_mux;
	
	ym_sr_bit_array #(.DATA_WIDTH(11)) fnum_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(fnum_mux),
		.data_out(fnum)
		);
	
	wire ch3_match = reg_cnt[2:0] == 3'h1;
	
	wire fnum_sel_ch3_1 = (reg_cnt[4:3] == 2'h0) & ch3_match & mode_ch3;
	wire fnum_sel_ch3_2 = (reg_cnt[4:3] == 2'h2) & ch3_match & mode_ch3;
	wire fnum_sel_ch3_3 = (reg_cnt[4:3] == 2'h1) & ch3_match & mode_ch3;
	wire fnum_sel_normal = ~fnum_sel_ch3_1 & ~fnum_sel_ch3_2 & ~fnum_sel_ch3_3;

	assign fnum_mux = (reg_fnum_o & { 11 {fnum_sel_normal}})
		| (reg_fnum_ch3_o_0 & { 11 {fnum_sel_ch3_3}})
		| (reg_fnum_ch3_o_4 & { 11 {fnum_sel_ch3_2}})
		| (reg_fnum_ch3_o_5 & { 11 {fnum_sel_ch3_1}});

	assign block = (reg_block_o & { 3 {fnum_sel_normal}})
		| (reg_block_ch3_o_0 & { 3 {fnum_sel_ch3_3}})
		| (reg_block_ch3_o_4 & { 3 {fnum_sel_ch3_2}})
		| (reg_block_ch3_o_5 & { 3 {fnum_sel_ch3_1}});
	
	assign note[1] = fnum_mux[10];
	assign note[0] = fnum_mux[10] ? (fnum_mux[9:7] != 3'h0) : (fnum_mux[9:7] ==3'h7);
	
	wire rate_sel_a = rate_sel == 2'h0;
	wire rate_sel_d = rate_sel == 2'h1;
	wire rate_sel_s = rate_sel == 2'h2;
	wire rate_sel_r = rate_sel == 2'h3;
	
	assign rate = (
		({5{rate_sel_a}} & ar)
		| ({5{rate_sel_d}} & dr)
		| ({5{rate_sel_s}} & sr)
		| {({4{rate_sel_r}} & rr), rate_sel_r}
		);
	
endmodule

module ym3438_op_register #(parameter DATA_WIDTH = 1)
	(
	input MCLK,
	input c1,
	input c2,
	input [DATA_WIDTH-1:0] data,
	input write_en,
	input rst,
	input bank,
	input obank,
	output [DATA_WIDTH-1:0] data_o
	);
	
	wire [DATA_WIDTH-1:0] sr1_in;
	wire [DATA_WIDTH-1:0] sr1_out;
	ym_sr_bit_array #(.DATA_WIDTH(DATA_WIDTH), .SR_LENGTH(12)) sr1
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(sr1_in),
		.data_out(sr1_out)
		);
		
	wire [DATA_WIDTH-1:0] sr2_in;
	wire [DATA_WIDTH-1:0] sr2_out;
	ym_sr_bit_array #(.DATA_WIDTH(DATA_WIDTH), .SR_LENGTH(12)) sr2
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(sr2_in),
		.data_out(sr2_out)
		);
	
	wire write1 = write_en & ~bank;
	wire write2 = write_en & bank;

	assign sr1_in = rst ? {DATA_WIDTH{1'h0}} : (write1 ? data : sr1_out);
	assign sr2_in = rst ? {DATA_WIDTH{1'h0}} : (write2 ? data : sr2_out);
	
	assign data_o = obank ? sr2_out : sr1_out;
	
endmodule

module ym3438_ch_register #(parameter DATA_WIDTH = 1)
	(
	input MCLK,
	input c1,
	input c2,
	input [DATA_WIDTH-1:0] data,
	input write_en,
	input rst,
	output [DATA_WIDTH-1:0] data_o_0,
	output [DATA_WIDTH-1:0] data_o_1,
	output [DATA_WIDTH-1:0] data_o_2,
	output [DATA_WIDTH-1:0] data_o_3,
	output [DATA_WIDTH-1:0] data_o_4,
	output [DATA_WIDTH-1:0] data_o_5
	);
	
	wire [DATA_WIDTH-1:0] sr_in[0:5];
	wire [DATA_WIDTH-1:0] sr_out[0:5];
	ym_sr_bit_array #(.DATA_WIDTH(DATA_WIDTH)) sr_0
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(sr_in[0]),
		.data_out(sr_out[0])
		);
	ym_sr_bit_array #(.DATA_WIDTH(DATA_WIDTH)) sr_1
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(sr_in[1]),
		.data_out(sr_out[1])
		);
	ym_sr_bit_array #(.DATA_WIDTH(DATA_WIDTH)) sr_2
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(sr_in[2]),
		.data_out(sr_out[2])
		);
	ym_sr_bit_array #(.DATA_WIDTH(DATA_WIDTH)) sr_3
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(sr_in[3]),
		.data_out(sr_out[3])
		);
	ym_sr_bit_array #(.DATA_WIDTH(DATA_WIDTH)) sr_4
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(sr_in[4]),
		.data_out(sr_out[4])
		);
	ym_sr_bit_array #(.DATA_WIDTH(DATA_WIDTH)) s_5
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(sr_in[5]),
		.data_out(sr_out[5])
		);
	
	assign sr_in[0] = rst ? {DATA_WIDTH{1'h0}} : (write_en ? data : sr_out[5]);
	assign sr_in[1] = sr_out[0]; 
	assign sr_in[2] = sr_out[1]; 
	assign sr_in[3] = sr_out[2]; 
	assign sr_in[4] = sr_out[3]; 
	assign sr_in[5] = sr_out[4];

	assign data_o_0 = sr_out[0];
	assign data_o_1 = sr_out[1];
	assign data_o_2 = sr_out[2];
	assign data_o_3 = sr_out[3];
	assign data_o_4 = sr_out[4];
	assign data_o_5 = sr_out[5];
	
endmodule

module ym3438_reg_wr_ctrl #(parameter REG_ADDRESS = 0)
	(
	input MCLK,
	input c1,
	input c2,
	input [7:0] data,
	input bank,
	input write_addr_en,
	input write_data_en,
	output reg_wr
	);

	
	wire reg_addr_o2;
	wire reg_addr_o = ~reg_addr_o2;
	wire reg_addr_sel = ~bank & data == REG_ADDRESS & write_addr_en;

	ym_sr_bit reg_addr_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(~(reg_addr_sel | (reg_addr_o & ~write_addr_en))),
		.sr_out(reg_addr_o2)
		);

		
	assign reg_wr = reg_addr_o & ~bank & write_data_en;

endmodule

module ym3438_reg_data #(parameter DATA_WIDTH = 1)
	(
	input MCLK,
	input c1,
	input c2,
	input [DATA_WIDTH-1:0] data,
	input reg_wr,
	input rst,
	output [DATA_WIDTH-1:0] data_o
	);

	
	wire [DATA_WIDTH-1:0] reg_sr_in;
	wire [DATA_WIDTH-1:0] reg_sr_out;

	ym_sr_bit_array #(.DATA_WIDTH(DATA_WIDTH)) reg_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(reg_sr_in),
		.data_out(reg_sr_out)
		);

		
	assign reg_sr_in = rst ? {DATA_WIDTH{1'h0}} : (reg_wr ? data : reg_sr_out);
	assign data_o = reg_sr_out;

endmodule

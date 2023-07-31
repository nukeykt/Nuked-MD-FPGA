module ym3438_ch
	(
	input MCLK,
	input c1,
	input c2,
	input [8:0] op_value,
	input op_out,
	input dac_en,
	input [7:0] dac,
	input [7:3] reg_2c,
	input op1_sel,
	input fsm_dac_load,
	input fsm_dac_out_sel,
	input fsm_dac_ch6,
	output [8:0] ch_dbg,
	output [8:0] ch_out,
	output dac_out_enable,
	output dac_out_enable_2612
	);
	
	wire dac_test = reg_2c[5];
	
	wire op_out_2 = op_out & ~dac_test;
	
	wire [8:0] op_value_mask = op_out_2 ? op_value : 9'h000;
	
	wire [8:0] ch_accm_sr_i;
	wire [8:0] ch_accm_sr_o;
	
	ym_sr_bit_array #(.DATA_WIDTH(9), .SR_LENGTH(6)) ch_accm_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(ch_accm_sr_i),
		.data_out(ch_accm_sr_o)
		);
	
	wire ch_load_accm = ~(dac_test | op1_sel);
	
	wire accm_clear = ~(dac_test | ch_load_accm);
	
	wire [8:0] ch_accm_masked = ~(ch_accm_sr_o | {9{accm_clear}});
	
	wire [8:0] ch_accm_sum = ch_accm_masked + op_value_mask + dac_test;
	
	wire ch_accm_uf = ch_accm_masked[8] & op_value_mask[8] & ~ch_accm_sum[8];
	wire ch_accm_of = ~ch_accm_masked[8] & ~op_value_mask[8] & ch_accm_sum[8];
	
	assign ch_accm_sr_i[7:0] = ~((ch_accm_sum[7:0] & {8{~ch_accm_uf}}) | {8{ch_accm_of}});
	assign ch_accm_sr_i[8] = ~((ch_accm_sum[8] & ~ch_accm_of) | ch_accm_uf);
	
	wire [8:0] ch_value_sr_i;
	wire [8:0] ch_value_sr_o1;
	wire [8:0] ch_value_sr_o2;
	
	ym_sr_bit_array #(.DATA_WIDTH(9), .SR_LENGTH(5)) ch_value_sr1
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(ch_value_sr_i),
		.data_out(ch_value_sr_o1)
		);
	
	ym_sr_bit_array #(.DATA_WIDTH(9)) ch_value_sr2
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(ch_value_sr_o1),
		.data_out(ch_value_sr_o2)
		);
	
	wire ch_sel = ~(dac_test | fsm_dac_out_sel);
	
	wire load_ed_o;
	
	ym_edge_detect load_ed
		(
		.MCLK(MCLK),
		.c1(c1),
		.inp(fsm_dac_load),
		.outp(load_ed_o)
		);
	
	wire ch_lock = ~(dac_test | load_ed_o);
	
	wire dac_sel = ~(dac_test | (fsm_dac_ch6 & dac_en));
	
	assign ch_value_sr_i = ch_load_accm ? ch_value_sr_o2 : ~ch_accm_sr_o;
	
	wire [8:0] ch_value_o = ch_sel ? ch_value_sr_o1 : ch_value_sr_o2;
	
	wire [8:0] ch_value_lock_o;

	ym_slatch2 #(.DATA_WIDTH(9)) ch_value_lock
		(
		.MCLK(MCLK),
		.en(~ch_lock),
		.inp(ch_value_o),
		.val(ch_value_lock_o),
		.nval()
		);
	
	assign ch_dbg = ch_value_lock_o;
	
	wire [8:0] ch_dac_value = { ~dac[7], dac[6:0], reg_2c[3] };
	
	wire [8:0] ch_out_i = dac_sel ? ch_value_lock_o : ch_dac_value;
	
	assign ch_out = { ~ch_out_i[8], ch_out_i[7:0] };
	
	assign dac_out_enable = dac_test | ~fsm_dac_load;
	
	assign dac_out_enable_2612 = dac_test | fsm_dac_load;

endmodule
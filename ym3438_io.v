module ym3438_io
	(
	input MCLK,
	input c1,
	input c2,
	input [1:0] address,
	input [7:0] data,
	input CS,
	input WR,
	input RD,
	input IC,
	input timer_a,
	input timer_b,
	input [7:0] reg_21,
	input [7:3] reg_2c,
	input pg_dbg,
	input eg_dbg,
	input eg_dbg_inc,
	input [13:0] op_dbg,
	input [8:0] ch_dbg,
	output write_addr_en,
	output write_data_en,
	output [7:0] data_bus,
	output bank,
	output [7:0] data_o,
	output io_dir,
	output irq
	);
	
	
	wire read_en = ~RD & IC & ~CS;
	wire write_addr = (~WR & ~CS & ~address[0]) | ~IC;
	wire write_data = ~WR & ~CS & address[0] & IC;
	
	wire io_IC = IC;
	
	wire write_a_tr1_q, write_a_tr1_nq;
	
	wire write_a_sig;
	
	ym_rs_trig write_a_tr1
		(
		.MCLK(MCLK),
		.set(write_addr),
		.rst(write_a_sig),
		.q(write_a_tr1_q),
		.nq(write_a_tr1_nq)
		);
	
	wire write_a_tr2_q;
	
	ym_rs_trig_sync write_a_tr2
		(
		.MCLK(MCLK),
		.set(write_a_tr1_q),
		.rst(write_a_tr1_nq),
		.c1(c1),
		.q(write_a_tr2_q),
		.nq()
		);
	
	ym_slatch write_a_sl
		(
		.MCLK(MCLK),
		.en(c2),
		.inp(write_a_tr2_q),
		.val(write_a_sig),
		.nval()
		);
	
	wire write_a_sig_delay;
	
	ym_sr_bit write_a_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(write_a_sig),
		.sr_out(write_a_sig_delay)
		);
	
	assign write_addr_en = write_a_sig & ~write_a_sig_delay;
	
	wire write_d_tr1_q, write_d_tr1_nq;
	
	wire write_d_sig;
	
	ym_rs_trig write_d_tr1
		(
		.MCLK(MCLK),
		.set(write_data),
		.rst(write_d_sig),
		.q(write_d_tr1_q),
		.nq(write_d_tr1_nq)
		);
	
	wire write_d_tr2_q;
	
	ym_rs_trig_sync write_d_tr2
		(
		.MCLK(MCLK),
		.set(write_d_tr1_q),
		.rst(write_d_tr1_nq),
		.c1(c1),
		.q(write_d_tr2_q),
		.nq()
		);
	
	ym_slatch write_d_sl
		(
		.MCLK(MCLK),
		.en(c2),
		.inp(write_d_tr2_q),
		.val(write_d_sig),
		.nval()
		);
		
	wire write_d_sig_delay;
	
	ym_sr_bit write_d_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(write_d_sig),
		.sr_out(write_d_sig_delay)
		);
	
	assign write_data_en = write_d_sig & ~write_d_sig_delay;
	
	wire [8:0] data_l_out;
	wire [8:0] data_in = { address[1], data };
	wire data_l_en = ~WR & ~CS;
	
	ym_slatch data_l[0:8]
		(
		.MCLK(MCLK),
		.en(data_l_en),
		.inp(data_in),
		.val(data_l_out),
		.nval()
		);
	
	wire busy_of;
	
	wire busy_state_o;
	
	ym_cnt_bit #(.DATA_WIDTH(5)) busy_cnt
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.c_in(~busy_state_o),
		.reset(~io_IC),
		.val(),
		.c_out(busy_of)
		);
	
	wire busy_state_i = ~(write_data_en | (~busy_state_o & ~(busy_of | ~io_IC)));
	
	ym_sr_bit busy_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.bit_in(busy_state_i),
		.sr_out(busy_state_o)
		);
	
	assign io_dir = ~(IC & ~RD & ~CS);
	
	assign data_bus = (io_dir & IC) ? data_l_out[7:0] : 8'h00; // tristate + pull down

	assign bank = data_l_out[8];
	
	wire read_status = ~reg_21[6] & read_en;
	wire read_debug = reg_21[6] & read_en;
	
	wire timer_a_status_sl_out;
	
	ym_slatch timer_a_status_sl
		(
		.MCLK(MCLK),
		.en(~read_en),
		.inp(timer_a),
		.val(),
		.nval(timer_a_status_sl_out)
		);
	
	wire timer_b_status_sl_out;
	
	ym_slatch timer_b_status_sl
		(
		.MCLK(MCLK),
		.en(~read_en),
		.inp(timer_b),
		.val(),
		.nval(timer_b_status_sl_out)
		);
	
	bufif1(data_o[0], timer_a_status_sl_out, read_status);
	bufif1(data_o[1], timer_b_status_sl_out, read_status);
	bufif1(data_o[7], ~busy_state_o, read_status);
	
	assign irq = ~(timer_a_status_sl_out | timer_b_status_sl_out);
	
	wire [7:0] debug_data;
	wire [15:0] debug_data_w;
	wire [6:0] debug_data1_1;
	wire [6:0] debug_data1_2;
	
	bufif1(data_o[0], debug_data[0], read_debug);
	bufif1(data_o[1], debug_data[1], read_debug);
	bufif1(data_o[2], debug_data[2], read_debug);
	bufif1(data_o[3], debug_data[3], read_debug);
	bufif1(data_o[4], debug_data[4], read_debug);
	bufif1(data_o[5], debug_data[5], read_debug);
	bufif1(data_o[6], debug_data[6], read_debug);
	bufif1(data_o[7], debug_data[7], read_debug);
	
	assign debug_data = reg_21[7] ? debug_data_w[15:8] : debug_data_w[7:0];
	
	wire [8:0] ch_dbg_sr_o;
	
	ym_sr_bit_array #(.DATA_WIDTH(9)) ch_dbg_sr
		(
		.MCLK(MCLK),
		.c1(c1),
		.c2(c2),
		.data_in(ch_dbg),
		.data_out(ch_dbg_sr_o)
		);
	
	assign debug_data_w[15] = pg_dbg;
	assign debug_data_w[14] = reg_21[0] ? eg_dbg : eg_dbg_inc;
	assign debug_data_w[13:0] = reg_2c[4] ? { 5'h0, ch_dbg_sr_o } : op_dbg;

endmodule

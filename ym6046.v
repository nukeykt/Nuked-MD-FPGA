/*
 * Copyright (C) 2023 nukeykt
 *
 * This file is part of Nuked-MD.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 *  YM6046(FC1004) emulator.
 *  Thanks:
 *      org (ogamespec):
 *          FC1004 decap and die shot.
 *      andkorzh, HardWareMan (emu-russia):
 *          help & support.
 *
 */

module ym6046
	(
	input MCLK,
	input [6:0] PORT_A_i,
	input [6:0] PORT_B_i,
	input [6:0] PORT_C_i,
	input test,
	input M3,
	input IO,
	input CAS0,
	input SRES,
	input VCLK,
	input NTSC,
	input DISK,
	input JAP,
	input [7:0] ZA_i,
	input [7:0] ZD_i,
	input [6:0] VA_i,
	input [15:0] VD_i,
	input LWR,
	input t1,
	input ZV,
	input VZ,
	output [6:0] PORT_A_d,
	output [6:0] PORT_B_d,
	output [6:0] PORT_C_d,
	output [6:0] PORT_A_o,
	output [6:0] PORT_B_o,
	output [6:0] PORT_C_o,
	output fres,
	output HL,
	output FRES,
	output bc1,
	output bc2,
	output bc3,
	output bc4,
	output bc5
	);

endmodule


module ym6046_controller_port
	(
	input MCLK,
	input [6:0] port_i,
	input [7:0] data_bus,
	input reset,
	input m3,
	input [3:0] uart_clk_i1,
	input [3:0] uart_clk_i2,
	input read_rx_data,
	input write_p_data,
	input write_tx_data,
	input write_s_control,
	output uart_clk1,
	output uart_clk2,
	output [7:0] p_data_q,
	output [7:0] p_control_q,
	output [7:0] p_tx_data,
	output [7:0] p_rx_data_q,
	output [4:0] s_control_q,
	output tx_state1_q,
	output rx_ready_q,
	output rx_error_q,
	output [7:0] port_d,
	output [7:0] port_o,
	output irq_b6,
	output irq_uart
	);
	
	wire [7:0] tx_data;
	wire [7:0] tx_shifter_q;
	wire tx_step;
	wire tx_bit_q;
	wire tx_fsm1_q, tx_fsm1_nq;
	wire tx_fsm2_q, tx_fsm2_nq;
	wire tx_fsm3_q, tx_fsm3_nq;
	wire tx_fsm4_q, tx_fsm4_nq;
	wire tx_fsm5_q;
	wire tx_state1_nq;
	wire tx_state2_q;
	
	ym_sdffr #(.DATA_WIDTH(8)) p_control(.MCLK(MCLK), .clk(write_p_control), .val(data_bus), .reset(reset & m3), .q(p_control_q));
	
	assign port_d = ((~p_control_q[6:0]) & (s_control_q[1] ? 7'h6f : 7'hff)) | (s_control_q[2] ? 7'h20 : 7'h0);
	
	ym_sdffr #(.DATA_WIDTH(8)) p_data(.MCLK(MCLK), .clk(write_p_data), .val(data_bus), .reset(1'h1), .q(p_data_q));
	
	assign port_o[7:5] = p_data_q[7:5];
	assign port_o[4] = s_control_q[1] ? tx_bit_q : p_data_q[4];
	assign port_o[3:0] = p_data_q[3:0];
	
	ym_sdffr #(.DATA_WIDTH(5)) s_control(.MCLK(MCLK), .clk(write_s_control), .val(data_bus[7:3]), .reset(reset & m3), .q(s_control_q));
	
	ym_slatch #(.DATA_WIDTH(8)) tx_data_sl(.MCLK(MCLK), .en(~write_tx_data), .inp(data_bus), .val(tx_data));
	
	assign uart_clk1 = uart_clk_i1[s_control_q[4:3]];
	assign uart_clk2 = uart_clk_i2[s_control_q[4:3]];
	
	ym_sdffr #(.DATA_WIDTH(8)) tx_shifter(.MCLK(MCLK), .clk(uart_clk2), .val(tx_step ? { 1'h0, tx_shifter_q[7:1] } : ~tx_data),
		.reset(s_control_q[1]), .q(tx_shifter_q));
	
	ym_sdffs tx_bit(.MCLK(MCLK), .clk(uart_clk2), .val(~tx_shifter_q[0] & tx_step), .set(s_control_q[1]), .q(tx_bit_q));
	
	wire t_i1 = (tx_fsm4_q & tx_fsm1_nq)
		| (tx_fsm1_nq & tx_fsm4_nq & tx_state2_l_q)
		| (tx_fsm4_q & tx_fsm1_q & tx_fsm2_q);
	wire t_i2 = (tx_fsm1_nq & tx_fsm4_nq & tx_state2_l_q) | (tx_fsm1_q & tx_fsm2_q)
		| (tx_fsm2_nq & tx_fsm1_nq & tx_fsm3_q & tx_fsm4_nq);
	wire t_i3 = (tx_fsm1_nq & tx_fsm4_nq & tx_state2_l_q)
		| (tx_fsm4_q & tx_fsm1_q & tx_fsm2_q)
		| (tx_fsm2_q & tx_fsm4_q & tx_fsm3_q)
		| (tx_fsm4_q & tx_fsm3_q & tx_fsm1_q);
	wire t_i4 = (tx_fsm1_q & tx_fsm2_q)
		| (tx_fsm2_nq & tx_fsm1_nq & tx_fsm3_q & tx_fsm4_nq)
		| (tx_fsm4_q & tx_fsm1_q)
		| (tx_fsm4_q & tx_fsm2_q);
	wire t_i5 = ~(tx_fsm1_nq & tx_fsm2_nq & tx_fsm3_nq & tx_fsm4_q);
	
	ym_sdffr tx_fsm1(.MCLK(MCLK), .clk(uart_clk2), .val(t_i1), .reset(reset), .q(tx_fsm1_q), .nq(tx_fsm1_nq));
	ym_sdffr tx_fsm2(.MCLK(MCLK), .clk(uart_clk2), .val(t_i2), .reset(reset), .q(tx_fsm2_q), .nq(tx_fsm2_nq));
	ym_sdffr tx_fsm3(.MCLK(MCLK), .clk(uart_clk2), .val(t_i3), .reset(reset), .q(tx_fsm3_q), .nq(tx_fsm3_nq));
	ym_sdffr tx_fsm4(.MCLK(MCLK), .clk(uart_clk2), .val(t_i4), .reset(reset), .q(tx_fsm4_q), .nq(tx_fsm4_nq));
	ym_sdffs tx_fsm5(.MCLK(MCLK), .clk(uart_clk2), .val(t_i5), .set(reset), .q(tx_fsm5_q));
	
	assign tx_step = ~(tx_state2_l_q & tx_fsm1_nq & tx_fsm2_nq & tx_fsm3_nq & tx_fsm4_nq);
	
	ym_sdffsr tx_state1(.MCLK(MCLK), .clk(uart_clk2), .val(~tx_step & tx_state1_q), .set(write_tx_data), .reset(reset),
		.q(tx_state1_q), .nq(tx_state1_nq));
	ym_sdffsr tx_state2(.MCLK(MCLK), .clk(tx_fsm5_q), .val(1'h0), .set(tx_state1_nq), .reset(reset),
		.q(tx_state2_q));
	
	ym_sdff tx_state2_l(.MCLK(MCLK), .clk(uart_clk1), .val(tx_state2_q), .q(tx_state2_l_q));
	
endmodule
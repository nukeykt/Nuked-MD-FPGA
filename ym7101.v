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
 *  YM7101 emulator
 *  Thanks:
 *      Fritzchens Fritz:
 *          YM7101 decap and die shot.
 *      andkorzh:
 *          YM7101 deroute.
 *      org (ogamespec):
 *          early YM7101 decap and die shot.
 *      HardWareMan:
 *          help & support.
 *
 */

module ym7101
	(
	input [7:0] SD,
	output SE1,
	output SE0,
	output SC,
	output RAS1,
	output CAS1,
	output WE1,
	output WE0,
	output OE1,
	inout [7:0] RD,
	output [7:0] DAC_R,
	output [7:0] DAC_G,
	output [7:0] DAC_B,
	inout [7:0] AD,
	output YS,
	inout SPA_B,
	output VSYNC,
	inout CSYNC,
	inout HSYNC,
	input HL,
	input SEL0,
	input PAL,
	input RESET,
	input SEL1,
	inout CLK1,
	output SBCR,
	output CLK0,
	input MCLK,
	inout EDCLK,
	inout [15:0] CD,
	inout [22:0] CA,
	output [15:0] SOUND,
	output INT,
	output BR,
	inout BGACK,
	input BG,
	input MREQ,
	input INTAK,
	output IPL1,
	output IPL2,
	input IORQ,
	input RD,
	input WR,
	input M1,
	input AS,
	input UDS,
	input LDS,
	input RW,
	inout DTACK,
	output UWR,
	output LWR,
	output OE0,
	output CAS0,
	output RAS0,
	output [7:0] RA
	);
	
	wire cpu_sel;
	wire cpu_as;
	wire cpu_uds;
	wire cpu_lds;
	wire cpu_m1;
	wire cpu_rd;
	wire cpu_wr;
	wire cpu_mreq
	wire cpu_iorq;
	wire cpu_rw;
	wire cpu_bg;
	wire cpu_intak;
	wire cpu_bgack;
	wire cpu_pal;
	wire cpu_pen;
	
	wire cpu_clk0;
	wire cpu_clk1;
	
	wire clk1, clk2;
	wire hclk1, hclk2;
	
	wire reset_comb;
	wire mclk_and1;
	reg dff1;
	reg dff2;
	reg dff3;
	reg dff4;
	reg dff5;
	reg dff6;
	reg dff7;
	reg dff8;
	reg dff9;
	reg dff10;
	reg dff11;
	wire dff12_l2;
	wire dff13_l2;
	wire dff14_l2;
	ym7101_dff dff12(.MCLK(MCLK), .clk(mclk_clk1), .inp(~(dff12_l2 | dff13_l2)), .rst(mclk_and1), outp(dff12_l2));
	ym7101_dff dff13(.MCLK(MCLK), .clk(mclk_clk1), .inp(dff12_l2), .rst(mclk_and1), outp(dff13_l2));
	ym7101_dff dff14(.MCLK(MCLK), .clk(~mclk_clk1), .inp(dff13_l3), .rst(mclk_and1), outp(dff14_l2));
	wire dff15_l2;
	wire dff16_l2;
	wire dff17_l2;
	ym7101_dff dff15(.MCLK(MCLK), .clk(mclk_clk2), .inp(~(dff15_l2 | dff16_l2)), .rst(mclk_and1), outp(dff15_l2));
	ym7101_dff dff16(.MCLK(MCLK), .clk(mclk_clk2), .inp(dff15_l2), .rst(mclk_and1), outp(dff16_l2));
	ym7101_dff dff17(.MCLK(MCLK), .clk(~mclk_clk2), .inp(dff16_l3), .rst(mclk_and1), outp(dff17_l2));
	wire mclk_clk1;
	wire mclk_clk2;
	wire mclk_clk3;
	wire mclk_sbcr;
	wire mclk_cpu_clk0;
	wire mclk_cpu_clk1;
	wire mclk_dclk;
	
	wire io_m1_dff1_l2;
	wire io_m1_dff2_l2;
	wire io_m1_dff3_l2;
	wire io_m1_dff4_l2;
	wire io_m1_s1;
	wire io_m1_s2;
	wire io_m1_s3;
	wire io_m1_s4;
	wire io_m1_s5;
	wire [23:0] io_address;
	wire io_dresss_22o;
	wire io_oe0;
	wire io_cas0;
	wire io_ras0;
	wire io_lwr;
	wire io_uwr;
	wire io_wr;
	wire io_ipl1;
	wire io_ipl2;
	wire [15:0] io_data;
	wire w1;
	wire dff1_l2;
	wire dff2_l2;
	wire t1;
	wire dff3_l2;
	wire dff4_l2;
	wire t2;
	wire t3;
	wire t4;
	wire w5;
	wire l1;
	wire l2;
	wire l3;
	wire w6;
	wire l4;
	wire w7;
	wire l5;
	wire w8;
	wire l6;
	wire l7;
	wire l8;
	wire w9;
	
	wire reg_test1_0;
	
	wire reg_rs0;
	
	wire reg_rs1;
	
	assign reset_comb = ~(RESET & w100);
	
	// prescaler
	
	assign mclk_and1 = dff2 & ~dff1;
	
	assign mclk_clk1 = dff4;
	
	assign mclk_clk2 = dff7;
	
	assign mclk_clk3 = ~dff11;
	
	assign mclk_clk4 = dff13_l2 | dff14_l2;
	
	assign mclk_clk5 = dff16_l2 | dff17_l2;
	
	assign mclk_sbcr = PAL ? mclk_clk4 ? mclk_clk5;
	
	assign mclk_cpu_clk0 = reg_test1_0 ? CLK1 ? mclk_clk5;
	
	assign mclk_cpu_clk1 = ~mclk_clk3;
	
	assign mclk_dclk = (reg_rs0 | reg_test1_0) ? EDCLK : (reg_rs1 ? mclk_clk1 : mclk_clk2);
	
	always @(posedge MCLK)
	begin
		dff1 <= reset_comb;
		dff2 <= dff1;
		
		if (mclk_and1)
		begin
			dff3 <= 1'h0;
			dff4 <= 1'h0;
			dff5 <= 1'h0;
			dff6 <= 1'h0;
			dff7 <= 1'h0;
			dff8 <= 1'h0;
			dff9 <= 1'h0;
			dff10 <= 1'h0;
			dff11 <= 1'h0;
		end
		else
			dff3 <= dff4;
			dff4 <= ~dff3;
			
			dff5 <= dff7;
			dff6 <= dff5;
			dff7 <= ~(dff5 & dff6);
			
			dff8 <= dff11;
			dff9 <= dff8;
			dff10 <= ~(dff8 & dff9);
			dff11 <= dff10;
		end
	end
	
	// clk1, clk2
	
	reg dclk_l;
	
	always @(posedge MCLK)
	begin
		dclk_l <= mclk_dclk;
	end
	
	assign clk1 = ~mclk_dclk & dclk_l;
	assign clk2 = mclk_dclk & ~dclk_l;
	
	// hclk1, hclk2 (half clock)
	
	wire reset_l1_o;
	wire reset_l2_o;
	wire reset_pulse = reset_l1_o & ~reset_l2_o;
	ym_sr_bit reset_l1(.MCLK(MCLK), .c1(clk1), .c2(clk2), .bit_in(~reset_comb), .sr_out(reset_l1_o)); // static latch
	ym_sr_bit reset_l2(.MCLK(MCLK), .c1(clk1), .c2(clk2), .bit_in(reset_l1_o), .sr_out(reset_l2_o));
	
	wire dclk_prescaler_l1_o;
	wire dclk_prescaler_l2_o;
	wire dclk_prescaler_l3_o;
	wire dclk_prescaler_dff1_l2;
	wire dclk_prescaler_dff2_l2;
	assign hclk1 = ~dclk_prescaler_dff1_l2;
	assign hclk2 = ~dclk_prescaler_dff2_l2;
	ym_sr_bit dclk_prescaler_l1(.MCLK(MCLK), .c1(clk1), .c2(clk2), .bit_in(~(dclk_prescaler_l1_o | reset_pulse)), .sr_out(dclk_prescaler_l1_o));
	ym_dlatch_1 dclk_prescaler_l2(.MCLK(MCLK), .c1(clk1), .inp(dclk_prescaler_l1_o), .val(dclk_prescaler_l2_o));
	ym_dlatch_1 dclk_prescaler_l3(.MCLK(MCLK), .c1(clk1), .inp(~dclk_prescaler_l1_o), .val(dclk_prescaler_l3_o));
	ym7101_dff dclk_prescaler_dff1(.MCLK(MCLK), .clk(~clk1), .inp(1'h1), .rst(dclk_prescaler_l2_o & clk2), outp(dclk_prescaler_dff1_l2));
	ym7101_dff dclk_prescaler_dff2(.MCLK(MCLK), .clk(~clk1), .inp(1'h1), .rst(dclk_prescaler_l3_o & clk2), outp(dclk_prescaler_dff2_l2));
	
	// IO, DMA/FIFO block
	
	assign cpu_sel = SEL0;
	assign cpu_as = ~AS & cpu_sel;
	assign cpu_uds = ~UDS & cpu_sel;
	assign cpu_lds = ~LDS & cpu_sel;
	assign cpu_m1 = ~M1 & ~cpu_sel;
	assign cpu_rd = ~RD & ~cpu_sel;
	assign cpu_wr = ~WR & ~cpu_sel;
	assign cpu_mreq = ~MREQ & ~cpu_sel;
	assign cpu_rw = ~RW;
	assign cpu_bg = ~BG;
	assign cpu_intak = ~INTAK;
	assign cpu_bgack = BGACK;
	assign cpu_pal = PAL;
	assign cpu_pen = PEN;
	
	ym7101_dff io_m1_dff1(.MCLK(MCLK), .clk(cpu_clk0), .inp(cpu_m1), .rst(0), outp(io_m1_dff1_l2));
	ym7101_dff io_m1_dff2(.MCLK(MCLK), .clk(cpu_clk0), .inp(io_m1_dff1_l2), .rst(0), outp(io_m1_dff2_l2));
	ym7101_dff io_m1_dff3(.MCLK(MCLK), .clk(~cpu_clk0), .inp(io_m1_dff2_l2), .rst(0), outp(io_m1_dff3_l2));
	
	assign io_m1_s1 = io_m1_dff3_l2 & io_m1_dff2_l2;
	assign io_m1_s2 = ~io_m1_s1 & io_m1_s4;
	ym7101_dff io_m1_dff4(.MCLK(MCLK), .clk(~cpu_clk0), .inp(io_m1_s2), .rst(0), outp(io_m1_dff4_l2));
	
	assign io_m1_s3 = io_m1_dff4_l2 & io_m1_s2;
	
	assign io_m1_s4 = cpu_mreq & (io_m1_s1 | ( &io_address[15:14]));
	
	assign io_m1_s5 = io_m1_s4 & io_m1_s1;
	
	assign io_oe0 = io_m1_s5 | w25 | w27 | w118 | l8;
	
	assign w1153  = w1 & ~w2;
	
	assign io_cas0 = reg_8b_b6 ?
		(io_m1_dff2_l2 | w15 | w28 | w30 | w102) :
		(l8 | w25 | w1153);
	
	assign io_ras0 = reg_8b_b6 ?
		(io_m1_s4 | w21 | w14 | w27) :
		(io_m1_s2 | w22 | w16);
	
	assign io_wr = cpu_rw & dff1_l2;
	
	assign io_lwr = cpu_wr | (cpu_lds & io_wr);
	assign io_uwr = cpu_uds & io_wr;
	
	assign w1 = ~cpu_rw & (cpu_uds | cpu_lds);
	ym7101_dff dff1(.MCLK(MCLK), .clk(~cpu_clk1), .inp(w23), .rst(0), .outp(dff1_l2));
	
	ym7101_dff dff2(.MCLK(MCLK), .clk(cpu_clk1), .inp(cpu_bg), .rst(0), .outp(dff2_l2));
	
	ym7101_rs_trig rs1(.MCLK(MCLK), .set(cpu_bg | reset_comb), .rst(~reg_data_l2[7] & w227 & reg_m5), .q(t1));
	
	assign w2 = w35 & (&io_address[22:20]);
	
	assign io_address_22o = ~(l4 & w247 & (l6 | ~l7));
	
	ym7101_dff dff4(.MCLK(MCLK), .clk(hclk2), .inp(w3), .rst(w4), outp(dff4_l2));
	ym7101_dff dff3(.MCLK(MCLK), .clk(hclk2), .inp(dff4_l2), .rst(w4), outp(dff3_l2));
	
	assign w3 = t2 | t3;
	
	assign w4 = reset_comb | l48;
	
	ym7101_rs_trig rs2(.MCLK(MCLK), .set(w63), .rst(w4), .q(t2));
	ym7101_rs_trig rs3(.MCLK(MCLK), .set(w5), .rst(w4), .q(t3));
	ym7101_rs_trig rs4(.MCLK(MCLK), .set(w62), .rst(w4 | w5), .q(t4));
	
	assign w5 = dff22_l2 & cpu_bgack & DTACK & dff2_l2 & cpu_sel & w37;
	
	assign io_ipl1 = ~(w11 & cpu_sel);
	assign io_ipl2 = ~(w12 & cpu_sel);
	
	ym_sr_bit sr1(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l108), .sr_out(l1));
	ym_sr_bit sr2(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l1), .sr_out(l2));
	ym_sr_bit sr3(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l2), .sr_out(l3));
	ym_sr_bit sr4(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(~(l108 | l1 | l2 | l3)), .sr_out(l4));
	ym_sr_bit sr5(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w267), .sr_out(l5));
	ym_dlatch_1 dl6(.MCLK(MCLK), .c1(hclk1), inp(~(w7 & w8 & l116)), .nval(l6));
	ym_dlatch_1 dl7(.MCLK(MCLK), .c1(clk1), inp(l6), .nval(l7));
	ym_dlatch_2 dl8(.MCLK(MCLK), .c2(clk2), .inp(l7), .mval(l8));
	
	assign w6 = ~(l1 | l3);
	assign w7 = ~(w6 & w256)
	
	assign w8 = l5 & w267;
	
	assign w9 = w58 | w57 | w60;
	assign w10 = ~dff13_l2;
	
	assign w11 = w58 | w60;
	assign w12 = w57 | w60;
	
	assign w13 = l4 & w246;
	
	assign w14 = ~l7 | (l6 & w13);
	
	assign w15 = (~l4 & l6) | (l8 & w13);
	
	assign w16 = (~l7 & w13) | (l8 & w13);
	
	assign w17 = l2 & l8;
	
	assign w18 = w267 & l4 & l8;
	
	assign w19 = w29 & w34;
	
	assign w20 = w34 & dff7_l2;
	
	assign w21 = w34 & w26;
	
	assign w22 = w10 ? w21 : w20;
	
	assign w23 = ~((w10 & w30) | (dff5_l2 & w34));
	
	assign w24 = w34 & (dff6_l2 | (dff11_l2 & w10));
	
	assign w25 = cpu_rd & l17;
	
	ym7101_dff dff5(.MCLK(MCLK), .clk(~cpu_clk1), .inp(dff6_l2), .rst(w10), .outp(dff5_l2));
	ym7101_dff dff6(.MCLK(MCLK), .clk(cpu_clk1), .inp(dff7_l2), .rst(w10), .outp(dff6_l2));
	
	assign w26 = ~(~dff6_l2 & dff8_l2);
	
	ym7101_dff dff7(.MCLK(MCLK), .clk(~cpu_clk1), .inp(dff8_l2), .rst(w10), .outp(dff7_l2));
	
	assign w27 = dff17_l2 & ~dff19_l2;
	
	assign w28 = dff16_l2 & ~dff19_l2;
	
	ym7101_dff dff8(.MCLK(MCLK), .clk(~cpu_clk1), .inp(dff9_l2), .rst(w10), .outp(dff8_l2));
	
	ym7101_dff dff9(.MCLK(MCLK), .clk(cpu_clk1), .inp(w30), .rst(w10), .outp(dff9_l2));
	
	assign w29 = ~(w10 | dff9_l2);
	
	assign w30 = w34 & dff10_l2;
	
	assign w31 = reset_comb | dff21_l2 | dff13_l2;
	
	ym7101_dff dff10(.MCLK(MCLK), .clk(~cpu_clk1), .inp(dff11_l2), .rst(w33), .outp(dff10_l2));
	ym7101_dff dff11(.MCLK(MCLK), .clk(cpu_clk1), .inp(w36), .rst(w33), .outp(dff11_l2));
	
	assign w32 = dff11_l2 & w1;
	
	assign w33 = ~w36;
	
	assign w34 = w2 & w36;
	
	assign w35 = ~cpu_intak;
	
	assign w36 = cpu_as & w40;
	
	assign w37 = ~cpu_as;
	
	ym7101_dff dff12(.MCLK(MCLK), .clk(w37), .inp(1'h1), .rst(w10), .outp(dff12_l2));
	
	assign w38 = dff12_l2 | reset_comb;
	
	ym7101_dff dff13(.MCLK(MCLK), .clk(w34), .inp(w44), .rst(w38), .outp(dff13_l2));
	
	// FSM block
	
	// Plane block
	
	// Sprite block
	
	// VRAM interface block
	
	// Video MUX block
	
	// PSG block

endmodule

module ym7101_rs_trig
	(
	input MCLK,
	input set,
	input rst,
	output q,
	output nq
	);
	
	reg mem = 1'h0;
	
	assign q = set ? 1'h1 : (rst ? 1'h0 : mem);
	assign nq = rst ? 1'h1 : (set ? 1'h0 : ~mem); 
	
	always @(posedge MCLK)
	begin
		mem <= q;
	end
	
endmodule


module ym7101_dff
	(
	input MCLK,
	input clk,
	input inp,
	input rst,
	output outp
	);
	
	reg l1, l2;
	
	wire l2_assign = rst ? 1'h0 : (clk ? l1 : l2);
	
	assign outp = l2_assign;
	
	always @(posedge MCLK)
	begin
		if (rst)
		begin
			l1 <= 1'h0;
		end
		else
		begin
			if (~clk)
				l1 <= inp;
		end
		assign l2 = l2_assign;
	end
	
endmodule
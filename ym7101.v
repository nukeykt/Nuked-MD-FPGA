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
	
	wire i_csync = ~CSYNC;
	wire i_hsync = ~HSYNC;
	
	wire reset_ext;
	
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
	
	wire [14:0] reg_test0;
	
	wire [10:0] reg_test1;
	
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
	ym_dlatch_1 dl7(.MCLK(MCLK), .c1(clk1), .inp(l6), .nval(l7));
	ym_dlatch_2 dl8(.MCLK(MCLK), .c2(clk2), .inp(l7), .nval(l8));
	
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
	
	ym7101_dff dff14(.MCLK(MCLK), .clk(cpu_clk1), .inp(w43), rst(0), .outp(dff14_l2));
	
	ym7101_dff dff15(.MCLK(MCLK), .clk(dff14_l2), .inp(w44), .srt(w31), .outp(dff15_l2));
	
	assign w39 = ~dff15_l2;
	
	assign w40 = w39 | dff21_l2;
	
	assign w41 = ~(~dff21_l2 & cpu_sel & w26);
	
	ym7101_dff dff16(.MCLK(MCLK), .clk(cpu_clk1), .inp(1'h1), .rst(w39), .outp(dff16_l2));
	ym7101_dff dff17(.MCLK(MCLK), .clk(cpu_clk1), .inp(dff16_l2), .rst(w39), .outp(dff17_l2));
	ym7101_dff dff18(.MCLK(MCLK), .clk(cpu_clk1), .inp(dff17_l2), .rst(w39), .outp(dff18_l2));
	ym7101_dff dff19(.MCLK(MCLK), .clk(~cpu_clk1), .inp(dff18_l2), .rst(w39), .outp(dff19_l2));
	ym7101_dff dff20(.MCLK(MCLK), .clk(cpu_clk1), .inp(dff19_l2), .rst(w39), .outp(dff20_l2));
	
	ym7101_dff dff21(.MCLK(MCLK), .clk(cpu_clk1), .inp(dff20_l2), .rst(1'h0), outp(dff21_l2));
	
	ym7101_dff dff22(.MCLK(MCLK), .clk(cpu_clk1), .inp(t4), .rst(1'h0), .outp(dff22_l2));
	
	assign w42 = ~(dff22_l2 & cpu_sel);
	
	wire [6:0] i_sum = w64 + { dff29_l2, dff28_l2, dff27_l2, dff26_l2, dff25_l2, dff24_l2, dff23_l2 };
	
	ym7101_dff dff23(.MCLK(MCLK), .clk(cpu_clk1), .inp(i_sum[0]), .rst(w41), .outp(dff23_l2));
	ym7101_dff dff24(.MCLK(MCLK), .clk(cpu_clk1), .inp(i_sum[1]), .rst(w41), .outp(dff24_l2));
	ym7101_dff dff25(.MCLK(MCLK), .clk(cpu_clk1), .inp(i_sum[2]), .rst(w41), .outp(dff25_l2));
	ym7101_dff dff26(.MCLK(MCLK), .clk(cpu_clk1), .inp(i_sum[3]), .rst(w41), .outp(dff26_l2));
	ym7101_dff dff27(.MCLK(MCLK), .clk(cpu_clk1), .inp(i_sum[4]), .rst(w41), .outp(dff27_l2));
	ym7101_dff dff28(.MCLK(MCLK), .clk(cpu_clk1), .inp(i_sum[5]), .rst(w41), .outp(dff28_l2));
	ym7101_dff dff29(.MCLK(MCLK), .clk(cpu_clk1), .inp(i_sum[6]), .rst(w41), .outp(dff29_l2));
	
	assign w43 = dff25_l2 & dff24_l2 & dff26_l2 & w44;
	
	assign w44 = dff28_l2 & dff27_l2 & dff29_l2;
	
	assign w45 = cpu_as & cpu_intak;
	
	assign w46 = w45 | w47;
	
	assign w47 = cpu_m1 & cpu_iorq;
	
	ym7101_rs_trig rs5(.MCLK(MCLK), .set(w46), .rst(l9), .q(t5));
	
	assign w48 = t6 & reg_m5;
	
	ym_sr_bit sr9(.MCLK(MCLK), .c1(clk1), .c2(clk2), .bit_in(w48), .sr_out(l9));
	ym_dlatch_1 dl10(.MCLK(MCLK), .c1(clk1), .inp(l9), .nval(l10));
	ym_dlatch_2 dl11(.MCLK(MCLK), .c2(clk2), .inp(l10), .nval(l11));
	
	assign w49 = reset_comb | (l11 & l10);
	
	assign w50 = reset_comb | w114;
	
	ym7101_rs_trig rs6(.MCLK(MCLK), .set(w50), .rst(l13), .q(t6));
	
	ym_sr_bit sr12(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(t6), .sr_out(l12));
	
	assign w51 = ~(l12 | reset_comb);
	
	ym_sr_bit sr13(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l12), .sr_out(l13));
	
	assign w52 = ~(l13 & w51);
	
	ym_dlatch_1 dl14(.MCLK(MCLK), .c1(hclk1), .inp(w52), .nval(l14));
	
	assign w53 = l14 & ~reg_m5;
	
	assign w54 = w53 | dff30_l2;
	
	ym7101_dff dff30(.MCLK(MCLK), .clk(~w48), .inp(w58), .rst(w49), .outp(dff30_l2));
	
	ym7101_dff dff31(.MCLK(MCLK), .clk(~w48), .inp(w57), .rst(w49), .outp(dff31_l2));
	
	assign w55 = w53 | dff31_l2;
	
	ym7101_dff dff32(.MCLK(MCLK), .clk(~w48), .inp(w60), .rst(w49), .outp(dff32_l2));
	
	assign w56 = w53 | dff32_l2;
	
	assign w57 = t7 & ~w60 & reg_ie1;
	
	assign w58 = ~w57 & w60 & t8 & reg_ie2;
	
	ym7101_rs_trig rs7(.MCLK(MCLK), .set(l15), .rst(w55), .q(t7));
	
	ym7101_rs_trig rs8(.MCLK(MCLK), .set(w59), .rst(w54), .q(t8));
	
	assign w59 = reg_m5 & l81;
	
	assign w60 = t9 & reg_ie0;
	
	assign w61 = reg_m1 & reg_m5;
	
	assign w62 = w61 & ~reg_dmd[1] & w182;
	
	assign w63 = w61 & w182 & reg_dmd[1];
	
	assign w64 = ~t3;
	
	assign w65 = ~(~reg_m5 | io_address[1] | cpu_sel);
	
	assign w66 = ~t9 & w1154;
	
	ym7101_rs_trig rs9(.MCLK(MCLK), .set(w120), .rst(w56), .q(t9));
	
	ym7101_rs_trig rs10(.MCLK(MCLK), .set(w66), .rst(l14), .q(t10));
	
	ym7101_rs_trig rs11(.MCLK(MCLK), .set(l600), .rst(l14), .q(t11));
	
	assign w67 = l115 | reg_test0[3];
	
	assign w68 = ~(t38 | l162 | reg_test0[3]);
	
	wire cnt1_of;
	
	ym_cnt_bit_load #(.DATA_WIDTH(8)) cnt1(.MCLK(MCLK), .c1(hclk1), .c2(hclk2),
		.c_in(w67), .reset(1'h0), .load(w69), .load_val(reg_hit), .c_out(cnt1_of));
		
	assign w69 = w68 | l15;
	
	ym_sr_bit sr15(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(cnt1_of & ~w68), .sr_out(l15));
	
	assign w70 = cpu_sel & (io_address & 23'h738070) == 23'h600000;
	
	assign w71 = ~cpu_sel & reg_test0[2] & w142;

	assign w72 = w65 ? w252 : cpu_pal;
	
	assign w73 = w64 ? l46 : dff3_l2;
	
	assign w74 = reg_test_18[11:8] == 4'hf;
	assign w75 = reg_test_18[11:8] == 4'h8;
	assign w76 = reg_test_18[11:8] == 4'h7;
	assign w77 = reg_test_18[11:8] == 4'h6;
	assign w78 = reg_test_18[11:8] == 4'h5;
	assign w79 = reg_test_18[11:8] == 4'h4;
	assign w80 = reg_test_18[11:8] == 4'h3;
	assign w81 = reg_test_18[11:8] == 4'h2;
	assign w82 = reg_test_18[11:8] == 4'h1;
	assign w83 = reg_test_18[11:8] == 4'h0;
	
	assign w84 = w83 & w129;
	assign w85 = w82 & w129;
	assign w86 = w81 & w129;
	assign w87 = w81 & w135;
	assign w88 = w80 & w129;
	assign w89 = w80 & w135;
	assign w90 = w79 & w129;
	assign w91 = w79 & w135;
	assign w92 = w78 & w129;
	assign w93 = w78 & w135;
	assign w94 = w77 & w129;
	assign w95 = w77 & w135;
	assign w96 = w76 & w129;
	assign w97 = w76 & w135;
	assign w98 = w75 & w129;
	assign w99 = w75 & w135;
	assign w100 = ~(w74 & w129);
	
	assign w101 = w16 | dff11_l2 | io_m1_s3;
	
	assign w102 = io_m1_s3 & w104;
	
	assign w103 = reg_8b_b7 ? l16 : (w101 ? 
		{ io_address[15], io_address[13], io_address[12], io_address[11],
			io_address[10], io_address[9], io_address[8], io_address[14] } :
			io_address[7:0]);
	
	assign w104 = re_8b_b7 ? 1'h1 : (w101 ? 1'h1 : 1'h0);
	
	ym_dlatch_1 #(.DATA_WIDTH(8)) dl16(.MCLK(MCLK), .c1(hclk1), .inp({ w1070, w105, color_pal, color_index}), .val(l16));
	
	assign w105 = reg_test0[0] ? color_priority : w1069;
	
	assign w106 = reg_lsm0_latch & reg_lsm1_latch;
	
	assign w107 = ~reg_m2 & reg_m5;
	assign w108 = reg_m2 & reg_m5;
	assign w109 = reg_m5 & reg_81_b7;
	
	assign w110 = io_address[7:6] == 2'h1 & cpu_iorq & cpu_wr; // z80 psg
	assign w111 = w110 | (w133 & cpu_lds);
	
	assign w112 = io_address[7:6] == 2'h2 & cpu_iorq & cpu_rd;
	assign w113 = w112 | w132;
	assign w114 = w113 & w130;
	
	assign w115 = reg_8b_b6 & w30;
	assign w116 = w115 | w24;
	
	assign w117 = ~(w24 | w125 | w128 | w129 | w133); // dtack
	
	assign w118 = (w1 & 1'h0) | (w32 & w116) | w19;
	
	ym_slatch sl17(.MCLK(MCLK), .en(cpu_clk0), .inp(cpu_rd), .val(l17));
	
	assign w119 = cpu_sel ? l110 : l115;
	
	assign w120 = w119 & w457;
	
	assign w121 = reset_comb | w360;
	
	ym7101_rs_trig rs12(.MCLK(MCLK), .set(w120), .rst(w121), .q(t12));
	
	assign w122 = ~(cpu_sel ? t12 : w9); // z80 int
	
	assign w123 = reg_lsm0_latch ? w355[8] : w355[0];
	
	assign w124 = w70 & cpu_as & w158;
	
	assign w125 = cpu_sel & w146;
	
	assign w126 = w152 & w162;
	
	assign w127 = w148 & w169;
	
	assign w128 = w124 & cpu_rw & io_address[3:2] == 2'h3 & ~w130; // test address
	
	assign w129 = w124 & cpu_rw & io_address[3:2] == 2'h3 & w130;
	
	assign w130 = cpu_sel ? io_address[1] : io_address[0];
	
	assign w131 = w124 & cpu_rw & io_address[3:2] == 2'h0 & w147;
	
	assign w132 = w124 & ~cpu_rw & io_address[3:2] == 2'h0 & w147;
	
	assign w133 = w124 & cpu_rw & io_address[3:2] == 2'h2;
	
	assign w134 = w124 & ~cpu_rw & io_address[3:2] = 2'h1;
	
	assign w135 = w124 & ~cpu_rw & io_address[3:2] = 2'h3;
	
	ym7101_rs_trig rs13(.MCLK(MCLK), .set(w163), .rst(w159), .q(t13));
	
	assign w136 = l48 | reset_comb;
	
	assign w137 = t1 & t14 & w168;
	
	ym7101_rs_trig rs14(.MCLK(MCLK), .set(w138), .rst(w143), .q(t14));
	
	assign w138 = reset_comb | l82;
	
	assign w139 = w131 | w140;
	
	assign w140 = cpu_iorq & cpu_wr & io_address[7:6] == 2'h2;
	
	assign w141 = cpu_iorq & cpu_rd & io_address[7:6] == 2'h1;
	
	assign w142 = w141 | w134; // HV cnt read
	
	ym_slatch sl18(.MCLK(MCLK), .en(~w139), .inp(w130), .val(l18));
	
	ym_slatch sl19(.MCLK(MCLK), .en(~w113), .inp(w130), .val(l19));
	
	assign w143 = ~l19 & w113;
	
	ym7101_rs_trig rs15(.MCLK(MCLK), .set(w173), .rst(w172), .q(t15), .nq(t15_n));
	
	ym7101_rs_trig rs16(.MCLK(MCLK), .set(w166), .rst(w174), .q(t16), .nq(t16_n));
	
	ym7101_rs_trig rs17(.MCLK(MCLK), .set(w175), .rst(w155), .q(t17));
	
	assign w144 = (t17 & w154) | reset_comb;
	
	assign w145 = w154 & t25 & w192 & reg_m5;
	
	ym7101_rs_trig rs18(.MCLK(MCLK), .set(w145), .rst(w144), .q(t18), .nq(t18_n));
	
	assign w146 = w126 | w127 | w137 | w164 | w165;
	
	ym7101_rs_trig rs19(.MCLK(MCLK), .set(cpu_uds), .rst(w183), .q(t19));
	
	ym7101_rs_trig rs20(.MCLK(MCLK), .set(cpu_lds), .rst(w183), .q(t20));
	
	assign w147 = cpu_uds | cpu_lds;
	
	assign w148 = ~(w150 | w252);
	
	assign w149 = t21 & w154;
	
	ym7101_rs_trig rs21(.MCLK(MCLK), .set(w169), .rst(w183), .q(t21));
	
	assign w150 = t21 & w153;
	
	assign w151 = w152 | w47;
	
	assign w152 = w113 | w135 | w142;
	
	assign w153 = l22 & ~l24;
	
	assign w154 = ~l24 & ~l23;
	
	assign w155 = l22 & l23;
	
	assign w156 = l27 | w136;
	
	assign w157 = w180 & l28;
	
	assign w158 = t13 | l23;
	
	assign w159 = l24 | reset_comb;
	
	assign w160 = w113 & ~w130;
	
	assign w161 = w154 | reset_comb;
	
	ym7101_rs_trig rs22(.MCLK(MCLK), .set(w161), .rst(l82), .q(t22));
	
	assign w162 = ~(t22 & w160);
	
	assign w163 = w113 | w139;
	
	assign w164 = (cpu_sel & w165) | w167;
	
	assign w165 = w139 & t18_n & t15_n & l18;
	
	assign w166 = w165 & ~cpu_sel;
	
	assign w167 = l18 & w140 & t15;
	
	assign w168 = w139 & t15_n & l18 & t18 & reg_m5;
	
	assign w169 = ~l18 & w139;
	
	assign w170 = w164 | w169 | w160 | w168 | w114;
	
	ym7101_rs_trig rs23(.MCLK(MCLK), .set(w168), .rst(w176), .q(t23));
	
	ym7101_rs_trig rs24(.MCLK(MCLK), .set(w143), .rst(w176), .q(t24));
	
	assign w171 = w160 | w169 | w168 | w114;
	
	assign w172 = (t16_n & w154) | reset_comb;
	
	assign w173 = w154 & t16;
	
	assign w174 = reset_comb | w170;
	
	assign w175 = reset_comb | w171;
	
	ym7101_rs_trig rs25(.MCLK(MCLK), .set(w164), .rst(w176), .q(t25));
	
	assign w176 = reset_comb | w155;
	
	assign w177 = ~(w201 | w202);
	
	assign w178 = w202 & ~reg_test0[4];
	
	assign w179 = w202 & reg_test0[4];
	
	assign w180 = w245 | w346;
	
	ym_dlatch_1 dl20(.MCLK(MCLK), .c1(clk1), .inp(w18), .val(l20));
	
	assign w181 = l20 | w164 | w168 | w191 | w261;
	
	assign w182 = w168 & io_data[7];
	
	assign w183 = (l21 & ~l22) | reset_comb;
	
	ym_dlatch_1 dl21(.MCLK(MCLK), .c1(clk1), .inp(~l22), .nval(l21));
	ym_dlatch_2 dl22(.MCLK(MCLK), .c2(clk2), .inp(l23), .nval(l22));
	ym_dlatch_1 dl23(.MCLK(MCLK), .c1(clk1), .inp(~l24), .nval(l23));
	
	ym_slatch dl24(.MCLK(MCLK), .en(clk2), .inp(l25), .val(l24));
	ym_slatch dl25(.MCLK(MCLK), .en(clk1), .inp(t13), .val(l25));
	
	ym_dlatch_1 dl26(.MCLK(MCLK), .c1(hclk1), .inp(w191), .nval(l26));
	
	assign w185 = l26 & l24;
	
	ym7101_rs_trig rs26(.MCLK(MCLK), .set(w157), .rst(w156), .q(t26), .nq(t26_n));
	
	assign w186 = t26 & l46 & l109;
	
	ym_sr_bit sr27(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w186), .sr_out(l27));
	
	assign w187 = l27 & w245;
	
	assign w188 = ~w245 & l27;
	
	assign w189 = l28 | w188;
	
	assign w190 = l28 & ~w245;
	
	assign w191 = w190 | w187 | l50;
	
	assign w192 = reg_code[1:0] != 2'h2;
	
	assign w193 = ~(~w192 & w184 & t25);
	
	assign w194 = ~(t24 | t23 | (t25 & ~reg_m5));
	
	assign w195 = l28 & w245;
	
	ym_sr_bit sr28(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w196), .sr_out(l28));
	
	assign w196 = t26_n & r27 & l46 & l109;
	
	ym7101_rs_trig rs27(.MCLK(MCLK), .set(w198), .rst(w197), .q(t27));
	
	assign w197 = l28 | w136;
	
	assign w198 = w199 | w200 | w203;
	
	assign w199 = w246 & reg_code[4];
	
	assign w200 = ~((reg_code[4] | reg_code[1] | reg_code[0]) | w194 | ~w154);
	
	assign w201 = w189 & reg_code[3:2] == 2'h1;
	
	assign w202 = w189 & reg_code[3:2] == 2'h2;
	
	ym_sr_bit sr29(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w177), .sr_out(l29));
	
	ym_sr_bit sr30(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l29), .sr_out(l30));
	
	assign w203 = w154 & t24 & ~reg_m5;
	
	assign w204 = reset_comb | ~reg_m5;
	
	assign w205 = l31 & hclk1;
	
	assign w206 = w205 & reg_data_l2[12:11] == 2'h0;
	assign w207 = w205 & reg_data_l2[12:11] == 2'h1;
	assign w208 = w205 & reg_data_l2[12:11] == 2'h2 & reg_m5;
	assign w209 = w205 & reg_data_l2[12:11] == 2'h1 & reg_m5;
	
	assign w210 = (w209 & reg_data_l2[10:8] == 3'h7) | reset_comb; // 8f
	assign w211 = (w208 & reg_data_l2[10:8] == 3'h3) | reset_comb; // 93
	assign w212 = (w208 & reg_data_l2[10:8] == 3'h4) | reset_comb; // 94
	assign w213 = (w209 & reg_data_l2[10:8] == 3'h3) | reset_comb; // 8b
	assign w214 = (w208 & reg_data_l2[10:8] == 3'h6) | reset_comb; // 96
	assign w215 = (w209 & reg_data_l2[10:8] == 3'h4) | reset_comb; // 8c
	assign w216 = (w206 & reg_data_l2[10:8] == 3'h0) | reset_comb; // 80
	assign w217 = (w206 & reg_data_l2[10:8] == 3'h1) | reset_comb; // 81
	assign w218 = (w206 & reg_data_l2[10:8] == 3'h2) | reset_comb; // 82
	assign w219 = (w206 & reg_data_l2[10:8] == 3'h3) | reset_comb; // 83
	assign w220 = (w206 & reg_data_l2[10:8] == 3'h4) | reset_comb; // 84
	assign w221 = (w206 & reg_data_l2[10:8] == 3'h7) | reset_comb; // 87
	assign w222 = (w208 & reg_data_l2[10:8] == 3'h2) | reset_comb; // 92
	assign w223 = (w208 & reg_data_l2[10:8] == 3'h1) | reset_comb; // 91
	assign w224 = (w208 & reg_data_l2[10:8] == 3'h0) | reset_comb; // 90
	assign w225 = (w206 & reg_data_l2[10:8] == 3'h6) | reset_comb; // 86
	assign w226 = (w206 & reg_data_l2[10:8] == 3'h5) | reset_comb; // 85
	assign w227 = (w208 & reg_data_l2[10:8] == 3'h7) | reset_comb; // 97
	assign w228 = (w208 & reg_data_l2[10:8] == 3'h5) | reset_comb; // 95
	assign w229 = (w207 & reg_data_l2[10:8] == 3'h2) | reset_comb; // 8a
	assign w230 = (w207 & reg_data_l2[10:8] == 3'h1) | reset_comb; // 89
	assign w231 = (w207 & reg_data_l2[10:8] == 3'h0) | reset_comb; // 88
	assign w232 = (w209 & reg_data_l2[10:8] == 3'h6) | reset_comb; // 8e
	assign w233 = (w209 & reg_data_l2[10:8] == 3'h5) | reset_comb; // 8d
	
	assign w234 = w250 & reg_test0[1];
	
	assign w235 = w250 & ~reg_test0[1];
	
	ym_slatch #(.DATA_WIDTH(17)) sl35(.MCLK(MCLK), .en(w299), .inp(vram_address), .val(l35));
	ym_slatch #(.DATA_WIDTH(17)) sl36(.MCLK(MCLK), .en(w294), .inp(reg_data_l2), .val(l36));
	ym_slatch #(.DATA_WIDTH(17)) sl37(.MCLK(MCLK), .en(w293), .inp(reg_data_l2), .val(l37));
	ym_slatch #(.DATA_WIDTH(17)) sl38(.MCLK(MCLK), .en(w292), .inp(reg_data_l2), .val(l38));
	ym_slatch #(.DATA_WIDTH(17)) sl39(.MCLK(MCLK), .en(w291), .inp(reg_data_l2), .val(l39));
	
	assign w244 = reg_lg == 16'hfffe & w250;
	
	assign w245 = dff3_l2 & reg_dmd == 2'h3;
	assign w246 = dff3_l2 & reg_dmd == 2'h1;
	assign w247 = dff3_l2 & reg_dmd == 2'h0;
	assign w248 = dff3_l2 & reg_dmd == 2'h2;
	
	ym_sr_bit sr40(.MCLK(MCLK), .c1(clk1), .c2(clk2), .bit_in(w18), .sr_out(l40));
	
	assign w249 = l40 & w18;
	
	ym_dlatch_2 dl41(.MCLK(MCLK), .c2(hclk2), .inp(w18), .val(l41));
	
	assign w250 = w187 | l50 | l41;
	
	wire reg_lg_of;
	
	assign w251 = reg_lg_of | w234;
	
	ym_sr_bit sr42(.MCLK(MCLK), .c1(clk1), .c2(clk2), .bit_in(w264), .sr_out(l42));
	
	assign w252 = (~reset_comb & w295 & l43) | (~reset_comb & w295 & l42);
	
	ym_sr_bit sr43(.MCLK(MCLK), .c1(clk1), .c2(clk2), .bit_in(w252), .sr_out(l43));
	
	ym_sr_bit sr44(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l49), .sr_out(l44));
	
	ym_sr_bit sr45(.MCLK(MCLK), .c1(clk1), .c2(clk2), .bit_in(l44), .sr_out(l45));
	
	assign w253 = l44 & ~l45 & ~l52;
	
	assign w254 = reset_comb | (l46 & w295) | (w295 & w253);
	
	wire reg_sa_of;
	
	assign w255 = reg_sa_of | w234;
	
	ym_sr_bit sr46(.MCLK(MCLK), .c1(clk1), .c2(clk2), .bit_in(w254), .sr_out(l46));
	
	assign w256 = l49 & ~l52;
	
	assign w257 = w256 & l53 & ~l54;
	assign w258 = w256 & ~l53 & ~l54;
	assign w259 = w256 & l53 & l54;
	assign w260 = w256 & ~l53 & l54;
	
	assign w261 = w149 | 1'h0;
	
	assign w262 = w248 | w300;
	
	assign w263 = w248 & l46;
	
	assign w264 = w249 | w150;
	
	assign w265 = w245 & l46;
	
	ym_slatch sl47(.MCLK(MCLK), .en(w266), .inp(vram_address[0]), .val(l47));
	
	assign w266 = hclk & l116;
	
	assign w267 = w247 | w246;
	
	ym_sr_bit sr48(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w244), .sr_out(l48));
	
	assign w267 = w247 | w246;
	
	assign w268 = ~w265 & l116;
	
	assign w269 = l109 & ~l46;
	
	ym_sr_bit sr49(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w269), .sr_out(l49));
	
	assign w270 = reset_comb | l48;
	
	assign w271 = dff3_l2 & l49;
	
	ym7101_rs_trig rs28(.MCLK(MCLK), .set(w271), .rst(w270), .q(t28));
	
	ym_sr_bit sr50(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w272), .sr_out(l50));
	
	assign w272 = t28 & w263 & l109;
	
	assign w273 = w274 & w325;
	
	assign w274 = ~w109 & cpu_sel;
	
	assign w275 = w188 | w300;
	
	assign w276 = dff3_l2 | t19;
	
	assign w277 = cpu_sel ? w276 : w280;
	
	assign w278 = dff3_l2 | t20;
	
	assign w279 = cpu_sel ? w278 : ~w280;
	
	assign w280 = reg_data_l2[0] & reg_m5;
	
	assign w281 = w187 & (w109 | vram_address[0]);
	
	assign w282 = w187 & (w109 | ~vram_address[0]);
	
	assign w283 = w281 | (w289 & w317);
	
	assign w284 = w282 | (w289 & w319);
	
	assign w285 = w319 | ~w109;
	
	assign w286 = w187 | (w289 & w285);
	
	assign w287 = w109 & w317;
	
	assign w288 = w187 | (w287 & w289);
	
	assign w289 = w301 & ~w316 & ~w318 & ~w320;
	
	assign w290 = w149 | (w249 & clk1);
	
	ym_cnt_bit #(.DATA_WIDTH(2)) cnt2(.MCLK(MCLK), .c1(clk1), .c2(clk2),
		.c_in(w264), .reset(reset_comb), .val(l51));
	
	assign w291 = w290 & l51 == 2'h2;
	assign w292 = w290 & l51 == 2'h3;
	assign w293 = w290 & l51 == 2'h0;
	assign w294 = w290 & l51 == 2'h1;
	
	assign w295 = l51 == { l54, l53 };
	
	assign w296 = l49 & w305;
	assign w297 = l49 & ~w305;
	
	wire [2:0] l52_sum = reset_comb ? 3'h0 : ({l54, l53, l52} + { 1'h0, w297, w296 });
	
	ym_sr_bit sr52(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l52_sum[0]), .sr_out(l52));
	ym_sr_bit sr53(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l52_sum[1]), .sr_out(l53));
	ym_sr_bit sr54(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l52_sum[2]), .sr_out(l54));
	
	assign w298 = ~(l52 | w188);
	
	assign w299 = hclk1 & (w191 | (l49 & w298));
	
	assign w300 = w273 & l49 & l52;
	
	ym_slatch sl55(.MCLK(MCLK), .en(w292), .inp(w277), .val(l55));
	ym_slatch sl56(.MCLK(MCLK), .en(w291), .inp(w277), .val(l56));
	ym_slatch sl57(.MCLK(MCLK), .en(w294), .inp(w277), .val(l57));
	ym_slatch sl58(.MCLK(MCLK), .en(w293), .inp(w277), .val(l58));
	ym_slatch sl59(.MCLK(MCLK), .en(w292), .inp(w279), .val(l59));
	ym_slatch sl60(.MCLK(MCLK), .en(w291), .inp(w279), .val(l60));
	ym_slatch sl61(.MCLK(MCLK), .en(w294), .inp(w279), .val(l61));
	ym_slatch sl62(.MCLK(MCLK), .en(w293), .inp(w279), .val(l62));
	ym_slatch sl63(.MCLK(MCLK), .en(w292), .inp(reg_code[0]), .val(l63));
	ym_slatch sl64(.MCLK(MCLK), .en(w291), .inp(reg_code[0]), .val(l64));
	ym_slatch sl65(.MCLK(MCLK), .en(w294), .inp(reg_code[0]), .val(l65));
	ym_slatch sl66(.MCLK(MCLK), .en(w293), .inp(reg_code[0]), .val(l66));
	ym_slatch sl67(.MCLK(MCLK), .en(w292), .inp(reg_code[1]), .val(l67));
	ym_slatch sl68(.MCLK(MCLK), .en(w291), .inp(reg_code[1]), .val(l68));
	ym_slatch sl69(.MCLK(MCLK), .en(w294), .inp(reg_code[1]), .val(l69));
	ym_slatch sl70(.MCLK(MCLK), .en(w293), .inp(reg_code[1]), .val(l70));
	ym_slatch sl71(.MCLK(MCLK), .en(w292), .inp(reg_code[2]), .val(l71));
	ym_slatch sl72(.MCLK(MCLK), .en(w291), .inp(reg_code[2]), .val(l72));
	ym_slatch sl73(.MCLK(MCLK), .en(w294), .inp(reg_code[2]), .val(l73));
	ym_slatch sl74(.MCLK(MCLK), .en(w293), .inp(reg_code[2]), .val(l74));
	ym_slatch sl75(.MCLK(MCLK), .en(w292), .inp(reg_code[3]), .val(l75));
	ym_slatch sl76(.MCLK(MCLK), .en(w291), .inp(reg_code[3]), .val(l76));
	ym_slatch sl77(.MCLK(MCLK), .en(w294), .inp(reg_code[3]), .val(l77));
	ym_slatch sl78(.MCLK(MCLK), .en(w293), .inp(reg_code[3]), .val(l78));
	
	assign w301 = w321 & (l50 | l49);
	
	assign w302 = w301 & w316 & ~w320 & w317 & ~w318;
	
	assign w303 = w301 & w316 & ~w320 & w319 & ~w318;
	
	assign w304 = w249 | w169;
	
	assign w305 = ~(~w273 | w332);
	
	assign w306 = l53 & l54;
	assign w307 = ~l53 & l54;
	assign w308 = l53 & ~l54;
	assign w309 = ~l53 & ~l54;
	
	assign w310 = (w306 & l67) | (w307 & l68) | (w308 & l69) | (w309 & l70);
	
	assign w311 = (w306 & l55) | (w307 & l56) | (w308 & l57) | (w309 & l58);
	
	assign w312 = (w306 & l71) | (w307 & l72) | (w308 & l73) | (w309 & l74);
	
	assign w313 = (w306 & l59) | (w307 & l60) | (w308 & l61) | (w309 & l62);
	
	assign w314 = (w306 & l75) | (w307 & l76) | (w308 & l77) | (w309 & l78);
	
	assign w315 = (w306 & l63) | (w307 & l64) | (w308 & l65) | (w309 & l66);
	
	assign w316 = l50 ? reg_code[1] : w310;
	
	assign w317 = l50 ? w277 : w311;
	
	assign w318 = l50 ? reg_code[2] : w312;
	
	assign w319 = l50 ? w279 : w313;
	
	assign w320 = l50 ? reg_code[3] : w314;
	
	assign w321 = l50 ? reg_code[0] : w322;
	
	assign w322 = w315 | ~reg_m5;
	
	assign w323 = w301 & w317 & ~w316 & w318 & ~w320;
	
	assign w324 = w301 & w319 & ~w316 & w318 & ~w320;
	
	assign w325 = ~w318 & ~w316;
	
	assign w326 = w268 & ~l53 & ~l54;
	assign w327 = w268 & ~l53 & l54;
	assign w328 = w268 & l53 & ~l54;
	assign w329 = w268 & l53 & l54;
	
	assign w330 = ~(w273 & w332);
	
	assign w331 = w330 ? l52 : w311;
	
	assign w332 = w315 | ~reg_m5;
	
	assign w333 = cpu_sel | io_address[0];
	
	assign w334 = ~(~reg_m5 | reg_m3);
	
	ym_sr_bit sr79(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(cpu_pen), .sr_out(l79));
	ym_sr_bit sr80(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l79), .sr_out(l80));
	
	assign w335 = ~l79 & l80;
	
	ym_sr_bit sr81(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w335), .sr_out(l81));
	
	assign w336 = ~cpu_sel | w337;
	
	assign w337 = w334 | (hclk1 & l81);
	
	assign w338 = ~(reg_code[3] | reg_code[2]);
	
	ym_sr_bit sr82(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l88), .sr_out(l82));
	ym_sr_bit sr83(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l47), .sr_out(l83));
	ym_sr_bit sr84(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l83), .sr_out(l84));
	
	assign w339 = ~(l84 & w346);
	
	assign w340 = ~(~l84 & w346);
	
	ym_sr_bit sr85(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l84), .sr_out(l85));
	ym_sr_bit sr86(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w189), .sr_out(l86));
	ym_sr_bit sr87(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l86), .sr_out(l87));
	
	assign w341 = l87 & w340;
	
	assign w342 = l87 & w339;
	
	ym_sr_bit sr88(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w341), .sr_out(l88));
	ym_sr_bit sr89(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w342), .sr_out(l89));
	
	assign w343 = hclk1 & l88;
	
	assign w344 = hclk1 & l89;
	
	assign w345 = w109 & ~cpu_sel & l85;
	
	assign w346 = ~w109 & cpu_sel & w338;
	
	ym_slatch #(.DATA_WIDTH(8)) sl90(.MCLK(MCLK), .en(w336), .inp(w355[7:0]), .val(l90)); // v counter
	
	ym_slatch #(.DATA_WIDTH(8)) sl91(.MCLK(MCLK), .en(w337), .inp(l106[8:1]), .val(l91)); // h counter
	
	assign w347 = w333 ? l91 : l90;
	
	assign w348 = w345 ? vram_data[15:8] : vram_data[7:0];
	
	ym_slatch #(.DATA_WIDTH(8)) sl92(.MCLK(MCLK), .en(w344), .inp(w348), .val(l92));
	
	assign w349 = w346 ? vram_data[7:0] : vram_data[15:8];
	
	ym_slatch #(.DATA_WIDTH(8)) sl93(.MCLK(MCLK), .en(w343), .inp(w349), .val(l93));
	
	assign w350 = cpu_sel ? io_data[15:8] : io_data[7:0];
	
	ym_slatch #(.DATA_WIDTH(8)) sl94(.MCLK(MCLK), .en(w304), .inp(w350), .val(l94));
	ym_slatch #(.DATA_WIDTH(8)) sl95(.MCLK(MCLK), .en(w304), .inp(io_data[7:0]), .val(l95));
	
	ym_slatch #(.DATA_WIDTH(8)) sl96(.MCLK(MCLK), .en(w294), .inp(l94), .val(l96));
	ym_slatch #(.DATA_WIDTH(8)) sl97(.MCLK(MCLK), .en(w294), .inp(l95), .val(l97));
	
	assign w351 = w331 ? l96 : l97;
	
	assign unk_data =
		(w328 ? l97 : 8'h0) |
		(w327 ? l99 : 8'h0) |
		(w329 ? l101 : 8'h0) |
		(w326 ? l103 : 8'h0);
	
	ym_slatch #(.DATA_WIDTH(8)) sl98(.MCLK(MCLK), .en(w291), .inp(l94), .val(l98));
	ym_slatch #(.DATA_WIDTH(8)) sl99(.MCLK(MCLK), .en(w291), .inp(l95), .val(l99));
	
	assign w352 = w331 ? l98 : l99;
	
	ym_slatch #(.DATA_WIDTH(8)) sl100(.MCLK(MCLK), .en(w292), .inp(l94), .val(l100));
	ym_slatch #(.DATA_WIDTH(8)) sl101(.MCLK(MCLK), .en(w292), .inp(l95), .val(l101));
	
	assign w353 = w331 ? l100 : l101;
	
	ym_slatch #(.DATA_WIDTH(8)) sl102(.MCLK(MCLK), .en(w293), .inp(l94), .val(l102));
	ym_slatch #(.DATA_WIDTH(8)) sl103(.MCLK(MCLK), .en(w293), .inp(l95), .val(l103));
	
	assign w354 = w331 ? l102 : l103;
	
	ym_sr_bit_array #(.DATA_WIDTH(8)) sr104(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .data_in(unk_data), .data_out(l104));
	
	ym_slatch_r #(.DATA_WIDTH(8)) sl_hit(.MCLK(MCLK), .en(w229), .rst(reset_comb), .inp(~reg_data_l2[7:0]), .val(reg_hit));
	
	ym_slatch sl_lsm0_latch(.MCLK(MCLK), .en(w457), .inp(reg_lsm0), .val(reg_lsm0_latch));
	ym_slatch sl_lsm1_latch(.MCLK(MCLK), .en(w457), .inp(reg_lsm1), .val(reg_lsm1_latch));
	
	ym_slatch_r #(.DATA_WIDTH(12)) sl_test_18(.MCLK(MCLK), .en(w128), .rst(reset_ext), .inp(io_data[11:0]), .val(reg_test_18));
	
	ym_slatch_r #(.DATA_WIDTH(15)) sl_test0(.MCLK(MCLK), .en(w84), .rst(reset_ext), .inp(io_data[14:0]), .val(reg_test0));
	
	ym_slatch_r #(.DATA_WIDTH(11)) sl_test1(.MCLK(MCLK), .en(w85), .rst(reset_ext), .inp(io_data[10:0]), .val(reg_test1));
	
	ym_slatch #(.DATA_WIDTH(2)) sl_code_01(.MCLK(MCLK), .en(w164), .inp(w350[7:6]), .val(reg_code[1:0]));
	ym_slatch_r #(.DATA_WIDTH(3)) sl_code_234(.MCLK(MCLK), .en(w168), .rst(w204), .inp(io_data[4:2]), .val(reg_code[4:2]))
	
	ym_slatch #(.DATA_WIDTH(8)) sl_addr_1(.MCLK(MCLK), .en(w165), .inp(io_data[7:0]), .val(reg_addr[7:0]));
	ym_slatch #(.DATA_WIDTH(6)) sl_addr_2(.MCLK(MCLK), .en(w164), .inp(w350[5:0]), .val(reg_addr[13:8]));
	ym_slatch_r #(.DATA_WIDTH(3)) sl_addr_3(.MCLK(MCLK), .en(w168), .rst(w204), .inp(io_data[7:0]), .val(reg_addr[16:14]))
	
	wire [16:0] reg_data_sum = reg_data_l2 + reg_inc + ~reg_m5;
	wire [16:0] reg_data_mux = w185 ? reg_addr : reg_data_sum;
	
	ym7101_dff #(.DATA_WIDTH(14)) reg_data_1(.MCLK(MCLK), .clk(~w181), .inp(reg_data_mux[13:0]),
		.rst(reset_comb), .outp(reg_data_l2[13:0]));
	
	ym7101_dff #(.DATA_WIDTH(3)) reg_data_2(.MCLK(MCLK), .clk(~w181), .inp(reg_data_mux[16:14]),
		.rst(w204), .outp(reg_data_l2[16:14]));
	
	ym_slatch sl_80_b0(.MCLK(MCLK), .en(w216), .inp(reg_data_l2[0]), .val(reg_80_b0));
	ym_slatch sl_m3(.MCLK(MCLK), .en(w216), .inp(reg_data_l2[1]), .val(reg_m3));
	ym_slatch sl_80_b2(.MCLK(MCLK), .en(w216), .inp(reg_data_l2[2]), .val(reg_80_b2));
	ym_slatch sl_80_b3(.MCLK(MCLK), .en(w216), .inp(reg_data_l2[3]), .val(reg_80_b3));
	ym_slatch sl_ie1(.MCLK(MCLK), .en(w216), .inp(reg_data_l2[4]), .val(reg_ie1));
	ym_slatch sl_lcb(.MCLK(MCLK), .en(w216), .inp(reg_data_l2[5]), .val(reg_lcb));
	ym_slatch sl_80_b6(.MCLK(MCLK), .en(w216), .inp(reg_data_l2[6]), .val(reg_80_b6));
	ym_slatch sl_80_b7(.MCLK(MCLK), .en(w216), .inp(reg_data_l2[7]), .val(reg_80_b7));
	
	
	ym_slatch sl_rs1(.MCLK(MCLK), .en(w215), .inp(reg_data_l2[0]), .val(reg_rs1));
	ym_slatch sl_lsm0(.MCLK(MCLK), .en(w215), .inp(reg_data_l2[1]), .val(reg_lsm0));
	ym_slatch sl_lsm1(.MCLK(MCLK), .en(w215), .inp(reg_data_l2[2]), .val(reg_lsm1));
	ym_slatch sl_ste(.MCLK(MCLK), .en(w215), .inp(reg_data_l2[3]), .val(reg_ste));
	ym_slatch sl_8c_b4(.MCLK(MCLK), .en(w215), .inp(reg_data_l2[4]), .val(reg_8c_b4));
	ym_slatch sl_8c_b5(.MCLK(MCLK), .en(w215), .inp(reg_data_l2[5]), .val(reg_8c_b5));
	ym_slatch sl_8c_b6(.MCLK(MCLK), .en(w215), .inp(reg_data_l2[6]), .val(reg_8c_b6));
	ym_slatch sl_rs0(.MCLK(MCLK), .en(w215), .inp(reg_data_l2[7]), .val(reg_rs0));
	
	ym_slatch sl_81_b0(.MCLK(MCLK), .en(w217), .inp(reg_data_l2[0]), .val(reg_81_b0));
	ym_slatch sl_81_b1(.MCLK(MCLK), .en(w217), .inp(reg_data_l2[1]), .val(reg_81_b1));
	ym_slatch sl_m5(.MCLK(MCLK), .en(w217), .inp(reg_data_l2[2]), .val(reg_m5));
	ym_slatch sl_m2(.MCLK(MCLK), .en(w217), .inp(reg_data_l2[3]), .val(reg_m2));
	ym_slatch sl_m1(.MCLK(MCLK), .en(w217), .inp(reg_data_l2[4]), .val(reg_m1));
	ym_slatch sl_ie0(.MCLK(MCLK), .en(w217), .inp(reg_data_l2[5]), .val(reg_ie0));
	ym_slatch sl_disp(.MCLK(MCLK), .en(w217), .inp(reg_data_l2[6]), .val(reg_disp));
	ym_slatch sl_81_b7(.MCLK(MCLK), .en(w217), .inp(reg_data_l2[7]), .val(reg_81_b7));
	
	
	ym_slatch sl_lscr(.MCLK(MCLK), .en(w213), .inp(reg_data_l2[0]), .val(reg_lscr));
	ym_slatch sl_hscr(.MCLK(MCLK), .en(w213), .inp(reg_data_l2[1]), .val(reg_hscr));
	ym_slatch sl_vscr(.MCLK(MCLK), .en(w213), .inp(reg_data_l2[2]), .val(reg_vscr));
	ym_slatch sl_ie2(.MCLK(MCLK), .en(w213), .inp(reg_data_l2[3]), .val(reg_ie2));
	ym_slatch sl_8b_b4(.MCLK(MCLK), .en(w213), .inp(reg_data_l2[4]), .val(reg_8b_b4));
	ym_slatch sl_8b_b5(.MCLK(MCLK), .en(w213), .inp(reg_data_l2[5]), .val(reg_8b_b5));
	ym_slatch sl_8b_b6(.MCLK(MCLK), .en(w213), .inp(reg_data_l2[6]), .val(reg_8b_b6));
	ym_slatch sl_8b_b7(.MCLK(MCLK), .en(w213), .inp(reg_data_l2[7]), .val(reg_8b_b7));
	
	ym_slatch #(.DATA_WIDTH(8)) sl_inc(.MCLK(MCLK), .en(w210), .inp(reg_data_l2[7:0]), .val(reg_inc));
	
	ym_slatch #(.DATA_WIDTH(6)) sl_sa_high(.MCLK(MCLK), .en(w227), .inp(reg_data_l2[5:0]), .val(reg_sa_high));
	
	ym_slatch #(.DATA_WIDTH(2)) sl_dmd(.MCLK(MCLK), .en(w227), .inp(reg_data_l2[7:6]), .val(reg_dmd));
	
	ym_cnt_bit_load #(.DATA_WIDTH(8)) cnt_lg_1(.MCLK(MCLK), .c1(hclk1), .c2(hclk2),
		.c_in(w235), .reset(1'h0), .load(w211), .load_val(~reg_data[7:0]), .c_out(reg_lg_of), val(reg_lg[7:0]));
		
	ym_cnt_bit_load #(.DATA_WIDTH(8)) cnt_lg_2(.MCLK(MCLK), .c1(hclk1), .c2(hclk2),
		.c_in(w251), .reset(1'h0), .load(w212), .load_val(~reg_data[7:0]), val(reg_lg[15:8]));
	
	ym_cnt_bit_load #(.DATA_WIDTH(8)) cnt_sa_low_1(.MCLK(MCLK), .c1(hclk1), .c2(hclk2),
		.c_in(w235), .reset(1'h0), .load(w228), .load_val(reg_data[7:0]), .c_out(reg_sa_of), val(reg_sa_low[7:0]));
		
	ym_cnt_bit_load #(.DATA_WIDTH(8)) cnt_sa_low_2(.MCLK(MCLK), .c1(hclk1), .c2(hclk2),
		.c_in(w255), .reset(1'h0), .load(w214), .load_val(reg_data[7:0]), val(reg_sa_low[15:8]));
	
	// FSM block
	
	ym_cnt_bit_load #(.DATA_WIDTH(9)) cnt105(.MCLK(MCLK), .c1(hclk1), .c2(hclk2),
		.c_in(w436), .reset(1'h0), .load(w437), .load_val(w428), val(l105));
	
	assign w355 = w106 ? { l105, w446 } : { 1'h0, l106 };
	
	ym_cnt_bit_load #(.DATA_WIDTH(9)) cnt106(.MCLK(MCLK), .c1(hclk1), .c2(hclk2),
		.c_in(w363), .reset(1'h0), .load(w361), .load_val(w364), val(l106));
	
	ym_sr_bit #(.SR_LENGTH(8)) sr107(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l663), .sr_out(l107));
	
	ym_sr_bit sr108(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w476), .sr_out(l108));
	
	ym_sr_bit sr109(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w359), .sr_out(l109));
	
	ym_sr_bit sr110(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w504), .sr_out(l110));
	
	assign w356 = w357 | (l118 & w380);
	
	assign w357 = reg_test1[6:4] == 3'h1;
	
	assign w358 = ~(w476 | w477 | w478 | w479);
	
	assign w359 = w358 & w386 & w395;
	
	assign w360 = ~l117;
	
	ym_sr_bit sr111(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w503), .sr_out(l111));
	
	ym_sr_bit sr112(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w490), .sr_out(l112));
	
	assign w361 = l112 | w88 | reset_comb | w370;
	
	assign w362 = ~(w361 | reg_test1[3]);
	
	assign w363 = w362 | (reg_test1[3] & ~INTAK);
	
	assign w364 = w88 ? io_data[8:0] : { 3'h7, ~w365, w368, w367, w366, w365 };
	
	assign w365 = ~reg_80_b0 & reg_rs1 & reg_m5;

	assign w366 = ~reg_80_b0 & ~reg_rs1;
	
	assign w367 = reg_80_b0 & ~reg_rs1;
	
	assign w368 = w365 | w369;
	
	assign w369 = ~reg_rs1 & reg_80_b0 & reg_m5;
	// h40: 457
	// h32: 466
	// m4: 466
	
	assign w370 = ~l113 & l121 & reg_80_b0;
	
	ym_sr_bit sr113(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w121), .sr_out(l113));
	
	ym_sr_bit sr114(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w491), .sr_out(l114));
	
	ym_sr_bit sr115(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w502), .sr_out(l115));
	
	ym_sr_bit sr116(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w384), .sr_out(l116));
	
	assign w371 = reg_test1[6:4] == 3'h2;
	
	assign w372 = w371 | (l119 & w380);
	
	ym_sr_bit sr117(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w505), .sr_out(l117));
	
	ym_sr_bit sr118(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w477), .sr_out(l118));
	
	ym_sr_bit sr119(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w478), .sr_out(l119));
	
	assign w373 = ~(reg_m5 ? l107 : l663);
	
	assign w374 = reg_8c_b6 ? hclk2 : w373;
	
	ym_sr_bit sr120(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(i_csync), .sr_out(l120));
	
	assign w375 = l120 | w411;
	
	assign w376 = w377 & (l121 | w375);
	
	assign w377 = ~(l114 | reset_comb);
	
	ym_sr_bit sr121(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w376), .sr_out(l121));
	
	ym_sr_bit sr122(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w492), .sr_out(l122));
	
	ym_sr_bit sr123(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w501), .sr_out(l123));
	
	assign w378 = reg_vscr ? l124 : ~l117;
	
	assign w379 = w378 & w380;
	
	assign w380 = reg_test1[6:4] == 3'h0;
	
	assign w381 = reg_test1[6:4] == 3'h5;
	
	assign w382 = reg_test1[6:4] == 3'h3;
	
	assign w383 = reg_test1[6:4] == 3'h4;
	
	assign w384 = ~(w483 & ~l132);
	
	assign w385 = w382 | (w380 & l125);
	
	assign w386 = ~(w480 | w483 | w481);
	
	ym_sr_bit sr124(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w506), .sr_out(l124));
	
	ym_sr_bit sr125(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w479), .sr_out(l125));
	
	ym_sr_bit sr126(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w480), .sr_out(l126));
	
	assign w387 = reg_m5 ? l127 : w420;
	
	ym_sr_bit #(.SR_LENGTH(8)) sr127(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w420), .sr_out(l127));
	
	assign w388 = t29 & ~w439;
	
	ym_sr_bit sr128(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w397), .sr_out(l128));
	
	assign w389 = reg_disp & t29 & t38;
	
	ym_sr_bit sr129(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(t30), .sr_out(l129));
	
	assign w390 = w441 | w450;
	
	assign w391 = t31 & w443;
	
	ym_sr_bit sr130(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w493), .sr_out(l130));
	
	assign w392 = reset_comb | l137;
	
	ym7101_rs_trig rs29(.MCLK(MCLK), .set(l130), .rst(w392), .q(t29));
	
	ym_sr_bit sr131(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w500), .sr_out(l131));
	
	assign w393 = l133 & w380;
	
	ym_sr_bit sr132(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w403), .sr_out(l132));
	
	assign w394 = w383 | (w380 & l126);
	
	assign w395 = ~(w486 | w489 | w482 | w488);
	
	ym_sr_bit sr133(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w507), .sr_out(l133));
	
	ym_sr_bit sr134(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w481), .sr_out(l134));
	
	assign w396 = reg_m5 ? l135 : w421;
	
	ym_sr_bit #(.SR_LENGTH(7)) sr135(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w421), .sr_out(l135));
	
	ym_sr_bit sr136(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w404), .sr_out(l136));
	
	assign w397 = ~(~reg_80_b0 & w387);
	
	assign w398 = ~(w441 | w443 | w450);
	
	assign w399 = ~w398 & t32;
	
	assign w400 = w390 & t32;
	
	ym7101_rs_trig rs30(.MCLK(MCLK), .set(w401), .rst(l152), .q(t30));
	
	assign w401 = reset_comb | l143;
	
	ym_sr_bit sr137(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w494), .sr_out(l137));
	
	ym_sr_bit sr138(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w499), .sr_out(l138));
	
	assign w402 = w380 & l140;
	
	ym_sr_bit sr139(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w410), .sr_out(l139));
	
	assign w403 = l139 | w410;
	
	ym_sr_bit sr140(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w508), .sr_out(l140));
	
	ym_sr_bit sr141(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w502), .sr_out(l141));
	
	ym_sr_bit sr142(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w489), .sr_out(l142));
	
	assign w404 = ~(w396 & ~reg_8c_b5);
	
	assign w405 = w398 & t33;
	
	assign w406 = w398 & t33;
	
	ym7101_rs_trig rs31(.MCLK(MCLK), .set(w407), .rst(w408), .q(t31));
	
	assign w407 = l137 | l153;
	
	assign w408 = reset_comb | w409;
	
	assign w409 = l131 | l144;
	
	ym_sr_bit sr143(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w495), .sr_out(l143));
	
	ym_sr_bit sr144(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w498), .sr_out(l144));
	
	assign w410 = w361 & w416;
	
	ym_sr_bit sr145(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w510), .sr_out(l145));
	
	ym_sr_bit sr146(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w509), .sr_out(l146));
	
	ym_sr_bit sr147(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w487), .sr_out(l147));
	
	ym_sr_bit sr148(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w488), .sr_out(l148));
	
	assign w411 = reg_8c_b5 & l149;
	
	ym_sr_bit sr149(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(i_hsync), .sr_out(l149));
	
	ym_sr_bit sr150(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w412), .sr_out(l150));
	
	assign w412 = w405 | w399;
	
	assign w413 = w405 | w400 | w391;
	
	ym_sr_bit sr151(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w413), .sr_out(l151));
	
	ym7101_rs_trig rs32(.MCLK(MCLK), .set(w414), .rst(l138), .q(t32));
	
	assign w414 = w409 | reset_comb;
	
	ym_sr_bit sr152(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w496), .sr_out(l152));
	
	ym_sr_bit sr153(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w497), .sr_out(l153));
	
	assign w415 = w380 & l154;
	
	assign w416 = ~reg_8c_b4 & reg_80_b0;
	
	assign w417 = l146 | l145;
	
	assign w418 = l145 | l155;
	
	assign w419 = w381 | (w380 & l148);
	
	ym_sr_bit sr154(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w511), .sr_out(l154));
	
	ym_sr_bit sr155(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w485), .sr_out(l155));
	
	ym_sr_bit sr156(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w484), .sr_out(l156));
	
	assign w420 = l151 & l663;
	
	assign w421 = w427 ? l160 : l157;
	
	ym_sr_bit sr157(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l150), .sr_out(l157));
	
	assign w422 = reg_m5 ? l158 : l129;
	
	ym_sr_bit #(.SR_LENGTH(8)) sr158(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l129), .sr_out(l158));
	
	ym7101_rs_trig rs33(.MCLK(MCLK), .set(w423), .rst(l123), .q(t33));
	
	assign w423 = reset_comb | l131;
	
	assign w424 = l159 & w380;
	
	assign w425 = w416 & ~reg_81_b0;
	
	ym_sr_bit sr159(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w512), .sr_out(l159));
	
	ym_cnt_bit cnt160(.MCLK(MCLK), .c1(hclk1), .c2(hclk2),
		.c_in(w426), .reset(reset_comb), .val(l160));
	
	assign w426 = w420 & ~l61;
	
	ym_sr_bit sr161(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w420), .sr_out(l161));
	
	assign w427 = reg_m5 & reg_80_b3;
	
	assign w428 = w87 ? io_data[8:0] :
		{ 2'h3, ~w431, w429, ~w107, w433, ~cpu_pal, w434, w435 };
	
	assign w429 = w430 | w431;
	
	assign w430 = ~cpu_pal & w107;
	
	assign w431 = cpu_pal & ~reg_m5;
	
	assign w432 = cpu_pal & w107;
	
	assign w433 = w432 | w431;
	
	assign w434 = cpu_pal & ~w446;
	
	assign w435 = ~cpu_pal ^ w446;
	
	assign w436 = (~reg_test1[2] & l115 & ~w437) | (reg_test1[2] & ~cpu_bg);
	
	assign w437 = w438 | reset_comb | w86 | w460;
	
	assign w438 = l115 & l174;
	
	ym_sr_bit sr162(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(~w475), .sr_out(l162));
	
	assign w439 = ~(reg_disp & (l162 | t38));
	
	ym_sr_bit sr163(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w474), .sr_out(l163));
	
	assign w440 = reset_comb | w442;
	
	ym7101_rs_trig rs34(.MCLK(MCLK), .set(w444), .rst(w440), .q(t34));
	
	assign w441 = t34 & reg_m5;
	
	ym_sr_bit sr164(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w473), .sr_out(l164));
	
	assign w442 = l163 & w449;
	
	ym7101_rs_trig rs35(.MCLK(MCLK), .set(w445), .rst(w444), .q(t35));
	
	assign w443 = t35 & reg_m5;
	
	ym_sr_bit sr165(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w472), .sr_out(l165));
	
	assign w444 = l164 & w449;
	
	assign w445 = reset_comb | w447;
	
	ym7101_rs_trig rs36(.MCLK(MCLK), .set(w452), .rst(w448), .q(t36));
	
	ym_cnt_bit_rs cnt166(.MCLK(CLK), .c1(hclk1), .c2(hclk2), .c_in(w455), .reset(w455), .set(l168), .val(w446));
	
	ym_sr_bit sr167(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w471), .sr_out(l167));
	
	assign w447 = l165 & w449;
	
	assign w448 = reset_comb | w447;
	
	assign w449 = l111 | ~w446;
	
	ym_sr_bit sr168(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w456), .sr_out(l168));
	
	assign w450 = reg_m5 & t36;
	
	assign w451 = reset_comb | ~reg_lsm0 | (w454 & ~t39);
	
	ym_sr_bit sr169(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w470), .sr_out(l169));
	
	assign w452 = l169 & w449;
	
	assign w453 = w452 | reset_comb;
	
	ym7101_rs_trig rs37(.MCLK(MCLK), .set(w453), .rst(l167), .q(t37));
	
	assign w454 = reg_80_b0 & w459;
	
	assign w455 = ~reg_80_b0 & w459;
	
	assign w456 = w454 & t39;
	
	ym_sr_bit sr170(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w469), .sr_out(l170));
	
	assign w457 = ~l170;
	
	assign w458 = reset_comb | w457;
	
	assign w459 = ~l170 & l110;
	
	ym7101_rs_trig rs38(.MCLK(MCLK), .set(l172), .rst(w458), .q(t38));
	
	ym_sr_bit sr171(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l114), .sr_out(l171));
	
	ym_sr_bit sr172(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(~w468), .sr_out(l172));
	
	ym7101_rs_trig rs39(.MCLK(MCLK), .set(w465), .rst(w461), .q(t39));
	
	assign w460 = reg_80_b0 & ~l176 & l175;
	
	assign w461 = reset_comb | (w460 & l171);
	
	assign w462 = ~(l167 | reset_comb);
	
	assign w463 = l120 & (l122 | l114);
	
	assign w464 = w462 & (l175 | w463);
	
	assign w465 = w460 & l173;
	
	assign w466 = ~w439;
	
	assign pla_vcnt[0] = l105 == 9'd511;
	assign pla_vcnt[1] = w446 & cpu_pal & w108 & l105 == 9'd471;
	assign pla_vcnt[2] = w446 & cpu_pal & w107 & l105 == 9'd463;
	assign pla_vcnt[3] = w446 & ~cpu_pal & w107 & l105 == 9'd490;
	assign pla_vcnt[4] = ~w446 & cpu_pal & w108 & l105 == 9'd472;
	assign pla_vcnt[5] = ~w446 & cpu_pal & w107 & l105 == 9'd464;
	assign pla_vcnt[6] = ~w446 & cpu_pal & ~reg_m5 & l105 == 9'd448;
	assign pla_vcnt[7] = ~w446 & ~cpu_pal & w107 & l105 == 9'd491;
	assign pla_vcnt[8] = ~w446 & ~cpu_pal & ~reg_m5 & l105 == 9'd475;
	assign pla_vcnt[9] = w446 & cpu_pal & w108 & l105 == 9'd468;
	assign pla_vcnt[10] = w446 & cpu_pal & w107 & l105 == 9'd460;
	assign pla_vcnt[11] = w446 & ~cpu_pal & w107 & l105 == 9'd487;
	assign pla_vcnt[12] = ~w446 & cpu_pal & w108 & l105 == 9'd469;
	assign pla_vcnt[13] = ~w446 & cpu_pal & w107 & l105 == 9'd461;
	assign pla_vcnt[14] = ~w446 & cpu_pal & ~reg_m5 & l105 == 9'd445;
	assign pla_vcnt[15] = ~w446 & ~cpu_pal & w107 & l105 == 9'd488;
	assign pla_vcnt[16] = ~w446 & ~cpu_pal & ~reg_m5 & l105 == 9'd472;
	assign pla_vcnt[17] = w446 & cpu_pal & w108 & l105 == 9'd465;
	assign pla_vcnt[18] = w446 & cpu_pal & w107 & l105 == 9'd457;
	assign pla_vcnt[19] = w446 & ~cpu_pal & w107 & l105 == 9'd484;
	assign pla_vcnt[20] = ~w446 & cpu_pal & w108 & l105 == 9'd466;
	assign pla_vcnt[21] = ~w446 & cpu_pal & w107 & l105 == 9'd458;
	assign pla_vcnt[22] = ~w446 & cpu_pal & ~reg_m5 & l105 == 9'd442;
	assign pla_vcnt[23] = ~w446 & ~cpu_pal & w107 & l105 == 9'd485;
	assign pla_vcnt[24] = ~w446 & ~cpu_pal & ~reg_m5 & l105 == 9'd469;
	assign pla_vcnt[25] = cpu_pal & w108 & l105 == 9'd482;
	assign pla_vcnt[26] = cpu_pal & w107 & l105 == 9'd474;
	assign pla_vcnt[27] = cpu_pal & ~reg_m5 & l105 == 9'd458;
	assign pla_vcnt[28] = ~cpu_pal & w107 & l105 == 9'd501;
	assign pla_vcnt[29] = ~cpu_pal & ~reg_m5 & l105 == 9'd485;
	assign pla_vcnt[30] = reg_lsm0 & cpu_pal & w108 & l105 == 9'd263;
	assign pla_vcnt[31] = reg_lsm0 & cpu_pal & w107 & l105 == 9'd255;
	assign pla_vcnt[32] = ~reg_lsm0 & cpu_pal & w108 & l105 == 9'd264;
	assign pla_vcnt[33] = ~reg_lsm0 & cpu_pal & w107 & l105 == 9'd256;
	assign pla_vcnt[34] = ~reg_lsm0 & cpu_pal & ~reg_m5 & l105 == 9'd240;
	assign pla_vcnt[35] = ~cpu_pal & w107 & l105 == 9'd232;
	assign pla_vcnt[36] = ~cpu_pal & ~reg_m5 & l105 == 9'd216;
	assign pla_vcnt[37] = w108 & l105 == 9'd240;
	assign pla_vcnt[38] = w107 & l105 == 9'd224;
	assign pla_vcnt[39] = ~reg_m5 & l105 == 9'd192;
	assign pla_vcnt[40] = l105 == 9'd0;
	assign pla_vcnt[41] = reg_lsm0 & cpu_pal & w108 & l105 == 9'd265;
	assign pla_vcnt[42] = reg_lsm0 & cpu_pal & w107 & l105 == 9'd257;
	assign pla_vcnt[43] = ~reg_lsm0 & cpu_pal & w108 & l105 == 9'd266;
	assign pla_vcnt[44] = ~reg_lsm0 & cpu_pal & w107 & l105 == 9'd258;
	assign pla_vcnt[45] = ~reg_lsm0 & cpu_pal & ~reg_m5 & l105 == 9'd242;
	assign pla_vcnt[46] = ~cpu_pal & w107 & l105 == 9'd234;
	assign pla_vcnt[47] = ~cpu_pal & ~reg_m5 & l105 == 9'd218;
	
	assign pla_hcnt1[0] = w466 & ~reg_m5 & l106 == 9'd488;
	assign pla_hcnt1[1] = w466 & ~reg_m5 & l106 == 9'd484;
	assign pla_hcnt1[2] = w466 & ~reg_m5 & (l106 & 9'd507) == 9'd472;
	assign pla_hcnt1[3] = w466 & ~reg_m5 & (l106 & 9'd503) == 9'd272;
	assign pla_hcnt1[4] = w466 & ~reg_m5 & (l106 & 9'd495) == 9'd268;
	assign pla_hcnt1[5] = w466 & reg_m5 & reg_rs1 & (l106 & 9'd463) == 9'd266;
	assign pla_hcnt1[6] = w466 & reg_m5 & (l106 & 9'd271) == 9'd10;
	assign pla_hcnt1[7] = w466 & reg_m5 & reg_rs1 & l106 == 9'd484;
	assign pla_hcnt1[8] = w466 & reg_m5 & reg_rs1 & l106 == 9'd460;
	assign pla_hcnt1[9] = w466 & reg_m5 & reg_rs1 & l106 == 9'd458;
	assign pla_hcnt1[10] = w466 & ~w425 & reg_m5 & reg_rs1 & (l106 & 9'd505) == 9'd344;
	assign pla_hcnt1[11] = w466 & ~w416 & reg_m5 & reg_rs1 & l106 == 9'd364;
	assign pla_hcnt1[12] = w466 & ~w416 & reg_m5 & reg_rs1 & (l106 & 9'd509) == 9'd360;
	assign pla_hcnt1[13] = w466 & ~w416 & reg_m5 & reg_rs1 & (l106 & 9'd505) == 9'd352;
	assign pla_hcnt1[14] = w466 & reg_m5 & reg_rs1 & (l106 & 9'd505) == 9'd336;
	assign pla_hcnt1[15] = w466 & reg_m5 & reg_rs1 & (l106 & 9'd505) == 9'd328;
	assign pla_hcnt1[16] = w466 & reg_m5 & reg_rs1 & (l106 & 9'd509) == 9'd324;
	assign pla_hcnt1[17] = w466 & ~w416 & reg_m5 & ~reg_rs1 & l106 == 9'd290;
	assign pla_hcnt1[18] = w466 & ~w416 & reg_m5 & ~reg_rs1 & (l106 & 9'd509) == 9'd292;
	assign pla_hcnt1[19] = w466 & ~w425 & reg_m5 & ~reg_rs1 & (l106 & 9'd505) == 9'd280;
	assign pla_hcnt1[20] = w466 & reg_m5 & ~reg_rs1 & (l106 & 9'd505) == 9'd264;
	assign pla_hcnt1[21] = w466 & reg_m5 & ~reg_rs1 & (l106 & 9'd509) == 9'd260;
	assign pla_hcnt1[22] = w466 & reg_m5 & ~reg_rs1 & (l106 & 9'd505) == 9'd272;
	assign pla_hcnt1[23] = w466 & reg_m5 & l106 == 9'd486;
	assign pla_hcnt1[24] = w466 & reg_m5 & (l106 & 9'd503) == 9'd498;
	assign pla_hcnt1[25] = w466 & reg_m5 & (l106 & 9'd505) == 9'd488;
	assign pla_hcnt1[26] = w466 & reg_m5 & (l106 & 9'd509) == 9'd480;
	assign pla_hcnt1[27] = w466 & reg_m5 & (l106 & 9'd497) == 9'd464;
	assign pla_hcnt1[28] = w466 & ~reg_m5 & (l106 & 9'd509) == 9'd488;
	assign pla_hcnt1[29] = w466 & ~reg_m5 & (l106 & 9'd509) == 9'd476;
	assign pla_hcnt1[30] = w466 & ~reg_m5 & (l106 & 9'd509) == 9'd284;
	assign pla_hcnt1[31] = w466 & ~reg_m5 & (l106 & 9'd509) == 9'd272;
	assign pla_hcnt1[32] = w466 & ~reg_m5 & (l106 & 9'd509) == 9'd484;
	assign pla_hcnt1[33] = w466 & ~reg_m5 & (l106 & 9'd509) == 9'd472;
	assign pla_hcnt1[34] = w466 & ~reg_m5 & (l106 & 9'd509) == 9'd280;
	assign pla_hcnt1[35] = w466 & ~reg_m5 & (l106 & 9'd509) == 9'd268;
	assign pla_hcnt1[36] = w466 & ~reg_m5 & (l106 & 9'd509) == 9'd480;
	assign pla_hcnt1[37] = w466 & ~reg_m5 & (l106 & 9'd509) == 9'd468;
	assign pla_hcnt1[38] = w466 & ~reg_m5 & (l106 & 9'd509) == 9'd276;
	assign pla_hcnt1[39] = w466 & ~reg_m5 & (l106 & 9'd509) == 9'd264;
	assign pla_hcnt1[40] = w466 & ~reg_m5 & (l106 & 9'd279) == 9'd18;
	assign pla_hcnt1[41] = w466 & ~reg_m5 & (l106 & 9'd287) == 9'd10;
	assign pla_hcnt1[42] = w466 & ~reg_m5 & (l106 & 9'd497) == 9'd496;
	assign pla_hcnt1[43] = ~w466 & (l106 & 9'd259) == 9'd0;
	assign pla_hcnt1[44] = (l106 & 9'd1) == 9'd1;
	assign pla_hcnt1[45] = w466 & reg_m5 & l106 == 9'd510;
	assign pla_hcnt1[46] = w466 & reg_m5 & l106 == 9'd502;
	assign pla_hcnt1[47] = w466 & reg_m5 & l106 == 9'd508;
	assign pla_hcnt1[48] = w466 & reg_m5 & l106 == 9'd500;
	assign pla_hcnt1[49] = w466 & reg_m5 & l106 == 9'd504;
	assign pla_hcnt1[50] = w466 & reg_m5 & l106 == 9'd496;
	assign pla_hcnt1[51] = w466 & reg_m5 & reg_rs1 & (l106 & 9'd455) == 9'd262;
	assign pla_hcnt1[52] = w466 & (l106 & 9'd263) == 9'd6;
	assign pla_hcnt1[53] = w466 & reg_m5 & reg_rs1 & (l106 & 9'd455) == 9'd260;
	assign pla_hcnt1[54] = w466 & (l106 & 9'd263) == 9'd4;
	assign pla_hcnt1[55] = w466 & reg_m5 & reg_rs1 & (l106 & 9'd463) == 9'd264;
	assign pla_hcnt1[56] = w466 & (l106 & 9'd271) == 9'd8;
	assign pla_hcnt1[57] = w466 & ~reg_m5 & (l106 & 9'd271) == 9'd8;
	assign pla_hcnt1[58] = w466 & reg_m5 & reg_rs1 & (l106 & 9'd463) == 9'd256;
	assign pla_hcnt1[59] = w466 & (l106 & 9'd271) == 9'd0;
	assign pla_hcnt1[60] = ~w466 & (l106 & 9'd63) == 9'd50;
	assign pla_hcnt1[61] = w466 & reg_m5 & reg_rs1 & l106 == 9'd306;
	assign pla_hcnt1[62] = w466 & reg_m5 & (l106 & 9'd319) == 9'd50;
	
	assign pla_hcnt2[0] = (chip->l106 & 9'd15) == 9'd3;
	assign pla_hcnt2[1] = l106 == 9'd507;
	assign pla_hcnt2[2] = reg_m5 & reg_rs1 & (chip->l106 & 9'd463) == 9'd269;
	assign pla_hcnt2[3] = reg_m5 & (chip->l106 & 9'd271) == 9'd13;
	assign pla_hcnt2[4] = ~reg_m5 & l106 == 9'd483;
	assign pla_hcnt2[5] = ~reg_m5 & l106 == 9'd471;
	assign pla_hcnt2[6] = ~reg_m5 & l106 == 9'd279;
	assign pla_hcnt2[7] = ~reg_m5 & l106 == 9'd267;
	assign pla_hcnt2[8] = (chip->l106 & 9'd15) == 9'd15;
	assign pla_hcnt2[9] = ~reg_m5 & (chip->l106 & 9'd15) == 9'd15;
	assign pla_hcnt2[10] = (chip->l106 & 9'd15) == 9'd7;
	assign pla_hcnt2[11] = (chip->l106 & 9'd7) == 9'd0;
	assign pla_hcnt2[12] = reg_rs1 & l106 == 9'd322;
	assign pla_hcnt2[13] = ~reg_rs1 & l106 == 9'd258;
	assign pla_hcnt2[14] = l106 == 9'd0;
	assign pla_hcnt2[15] = reg_rs1 & l106 == 9'd120;
	assign pla_hcnt2[16] = ~reg_rs1 & l106 == 9'd95;
	assign pla_hcnt2[17] = reg_m5 & reg_rs1 & l106 == 9'd328;
	assign pla_hcnt2[18] = reg_m5 & ~reg_rs1 & l106 == 9'd264;
	assign pla_hcnt2[19] = ~reg_m5 & l106 == 9'd488;
	assign pla_hcnt2[20] = reg_rs1 & l106 == 9'd482;
	assign pla_hcnt2[21] = ~reg_rs1 & l106 == 9'd488;
	assign pla_hcnt2[22] = reg_rs1 & l106 == 9'd358;
	assign pla_hcnt2[23] = ~reg_rs1 & l106 == 9'd292;
	assign pla_hcnt2[24] = reg_rs1 & l106 == 9'd164;
	assign pla_hcnt2[25] = reg_rs1 & l106 == 9'd466;
	assign pla_hcnt2[26] = ~reg_rs1 & l106 == 9'd134;
	assign pla_hcnt2[27] = ~reg_rs1 & l106 == 9'd475;
	assign pla_hcnt2[28] = reg_rs1 & l106 == 9'd148;
	assign pla_hcnt2[29] = ~reg_rs1 & l106 == 9'd121;
	assign pla_hcnt2[30] = reg_rs1 & l106 == 9'd120;
	assign pla_hcnt2[31] = ~reg_rs1 & l106 == 9'd95;
	assign pla_hcnt2[32] = reg_rs1 & l106 == 9'd1;
	assign pla_hcnt2[33] = ~reg_rs1 & l106 == 9'd0;
	assign pla_hcnt2[34] = reg_rs1 & l106 == 9'd348;
	assign pla_hcnt2[35] = ~reg_rs1 & l106 == 9'd284;
	assign pla_hcnt2[36] = reg_rs1 & l106 == 9'd330;
	assign pla_hcnt2[37] = ~reg_rs1 & l106 == 9'd266;
	assign pla_hcnt2[38] = l106 == 9'd18;
	assign pla_hcnt2[39] = ~reg_lcb & l106 == 9'd10;
	assign pla_hcnt2[40] = reg_rs1 & l106 == 9'd43;
	assign pla_hcnt2[41] = ~reg_rs1 & l106 == 9'd36;
	assign pla_hcnt2[42] = reg_rs1 & l106 == 9'd253;
	assign pla_hcnt2[43] = ~reg_rs1 & l106 == 9'd206;
	assign pla_hcnt2[44] = reg_rs1 & l106 == 9'd363;
	assign pla_hcnt2[45] = ~reg_rs1 & l106 == 9'd294;

	assign w467 = pla_vcnt[41] | pla_vcnt[42] | pla_vcnt[43]
		| pla_vcnt[44] | pla_vcnt[45] | pla_vcnt[46] | pla_vcnt[47];
	assign w468 = ~pla_vcnt[40];
	assign w469 = ~(pla_vcnt[37] | pla_vcnt[38] | pla_vcnt[39]);
	assign w470 = pla_vcnt[30] | pla_vcnt[31] | pla_vcnt[32]
		| pla_vcnt[33] | pla_vcnt[34] | pla_vcnt[35] | pla_vcnt[36];
	assign w471 = pla_vcnt[25] | pla_vcnt[26] | pla_vcnt[27]
		| pla_vcnt[28] | pla_vcnt[29];
	assign w472 = pla_vcnt[17] | pla_vcnt[18] | pla_vcnt[19] | pla_vcnt[20]
		| pla_vcnt[21] | pla_vcnt[22] | pla_vcnt[23] | pla_vcnt[24];
	assign w473 = pla_vcnt[9] | pla_vcnt[10] | pla_vcnt[11] | pla_vcnt[12]
		| pla_vcnt[13] | pla_vcnt[14] | pla_vcnt[15] | pla_vcnt[16];
	assign w474 = pla_vcnt[1] | pla_vcnt[2] | pla_vcnt[3] | pla_vcnt[4]
		| pla_vcnt[5] | pla_vcnt[6] | pla_vcnt[7] | pla_vcnt[8];
	assign w475 = ~pla_vcnt[0];

	assign w476 = pla_hcnt1[60] | pla_hcnt1[61] | pla_hcnt1[62];
	assign w477 = pla_hcnt1[50] | pla_hcnt1[57] | pla_hcnt1[58] | pla_hcnt1[59];
	assign w478 = pla_hcnt1[49] | pla_hcnt1[55] | pla_hcnt1[56];
	assign w479 = pla_hcnt1[47] | pla_hcnt1[48] | pla_hcnt1[53] | pla_hcnt1[54];
	assign w480 = pla_hcnt1[45] | pla_hcnt1[46] | pla_hcnt1[51] | pla_hcnt1[52];
	assign w481 = pla_hcnt1[5] | pla_hcnt1[6] | pla_hcnt1[36] |
		pla_hcnt1[37] | pla_hcnt1[38] | pla_hcnt1[39];
	assign w482 = pla_hcnt1[7] | pla_hcnt1[8] | pla_hcnt1[9] | pla_hcnt1[10]
		| pla_hcnt1[11] | pla_hcnt1[12] | pla_hcnt1[13] | pla_hcnt1[14]
		| pla_hcnt1[15] | pla_hcnt1[16] | pla_hcnt1[17] | pla_hcnt1[18]
		| pla_hcnt1[19] | pla_hcnt1[20] | pla_hcnt1[21] | pla_hcnt1[22]
		| pla_hcnt1[24] | pla_hcnt1[25] | pla_hcnt1[26] | pla_hcnt1[27]
		| pla_hcnt1[32] | pla_hcnt1[33] | pla_hcnt1[34] | pla_hcnt1[35];
	assign w483 = pla_hcnt1[44];
	assign w484 = pla_hcnt1[0] | pla_hcnt1[1] | pla_hcnt1[2] | pla_hcnt1[3] | pla_hcnt1[4];
	assign w485 = pla_hcnt1[36] | pla_hcnt1[37] | pla_hcnt1[38] | pla_hcnt1[39]
		| pla_hcnt1[43];
	assign w486 = w403 | pla_hcnt1[40] | pla_hcnt1[41] | pla_hcnt1[42];
	assign w487 = pla_hcnt1[7] | pla_hcnt1[8] | pla_hcnt1[9] | pla_hcnt1[10]
		| pla_hcnt1[11] | pla_hcnt1[12] | pla_hcnt1[13] | pla_hcnt1[14]
		| pla_hcnt1[17] | pla_hcnt1[18] | pla_hcnt1[19] | pla_hcnt1[22] | pla_hcnt1[23]
		| pla_hcnt1[24] | pla_hcnt1[25] | pla_hcnt1[26] | pla_hcnt1[27]
		| pla_hcnt1[40] | pla_hcnt1[41] | pla_hcnt1[42]
		| pla_hcnt1[46] | pla_hcnt1[47] | pla_hcnt1[48]
		| pla_hcnt1[49] | pla_hcnt1[50];
	assign w488 = pla_hcnt1[23];
	assign w489 = pla_hcnt1[31] | pla_hcnt1[28] | pla_hcnt1[29] | pla_hcnt1[30];

	assign w490 = pla_hcnt2[44] | pla_hcnt2[45];
	assign w491 = pla_hcnt2[42] | pla_hcnt2[43];
	assign w492 = pla_hcnt2[40] | pla_hcnt2[41];
	assign w493 = pla_hcnt2[38] | pla_hcnt2[39];
	assign w494 = pla_hcnt2[36] | pla_hcnt2[37];
	assign w495 = pla_hcnt2[34] | pla_hcnt2[35];
	assign w496 = pla_hcnt2[32] | pla_hcnt2[33];
	assign w497 = pla_hcnt2[30] | pla_hcnt2[31];
	assign w498 = pla_hcnt2[28] | pla_hcnt2[29];
	assign w499 = pla_hcnt2[24] | pla_hcnt2[25] | pla_hcnt2[26] | pla_hcnt2[27];
	assign w500 = pla_hcnt2[22] | pla_hcnt2[23];
	assign w501 = pla_hcnt2[20] | pla_hcnt2[21];
	assign w502 = ~(pla_hcnt2[17] | pla_hcnt2[18] | pla_hcnt2[19]);
	assign w503 = pla_hcnt2[15] | pla_hcnt2[16];
	assign w504 = pla_hcnt2[14];
	assign w505 = ~(pla_hcnt2[12] | pla_hcnt2[13]);
	assign w506 = pla_hcnt2[11];
	assign w507 = pla_hcnt2[9] | pla_hcnt2[10];
	assign w508 = pla_hcnt2[8];
	assign w509 = pla_hcnt2[4] | pla_hcnt2[5] | pla_hcnt2[6] | pla_hcnt2[7];
	assign w510 = pla_hcnt2[2] | pla_hcnt2[3];
	assign w511 = pla_hcnt2[1];
	assign w512 = pla_hcnt2[0];
	
	ym_sr_bit sr663(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(t35), .sr_out(l663));

	// Plane block
	
	assign w513 = (hclk1 & w379) | reg_test1[7];
	
	ym_sr_bit sr178(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l106[3]), .sr_out(l178));
	
	assign w514 = hclk1 & l115 & (reg_m5 | l162);
	
	ym_slatch #(.DATA_WIDTH(8)) sl179(.MCLK(MCLK), .en(w230), .inp(reg_data_l2[7:0]), .val(l179));
	
	assign w515 = reg_m5 ? vsram_out : { 3'h0, l179 };
	
	ym_slatch #(.DATA_WIDTH(11)) sl180(.MCLK(MCLK), .en(w516), .inp(vsram_out), .val(l180));
	
	ym_sr_bit_array #(.DATA_WIDTH(11)) sr181(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .data_in({ l182, l104 }), .data_out(l181));
	
	ym_sr_bit_array #(.DATA_WIDTH(3)) sr182(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .data_in(vram_data[10:8]), .data_out(l182));
	
	ym_sr_bit sr183(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l209), .sr_out(l183));
	
	assign w516 = l209 & hclk1;
	
	assign w517 = w514 | reg_test1[7];
	
	ym_slatch #(.DATA_WIDTH(11)) sl184(.MCLK(MCLK), .en(w517), .inp(w515), .val(l184));
	
	ym_slatch #(.DATA_WIDTH(11)) sl185(.MCLK(MCLK), .en(w513), .inp(vsram_out), .val(l185));
	
	ym_sr_bit sr186(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w519), .sr_out(l186));
	
	assign w518 = { l184[10:8], l186 ? l184[7:0] : 8'h0 };
	
	assign w519 = ~(l106[7:6] == 2'h3 & reg_80_b7);
	
	assign w520 = reg_m5 & (l178 | reg_vscr);
	
	assign w521 = w520 ? l185 : w518;
	
	assign w522 = w521 + { 2'h0, w355[8:0] };
	
	ym_slatch #(.DATA_WIDTH(2)) sl_hsz(.MCLK(MCLK), .en(w224), .inp(reg_data_l2[1:0]), .val(reg_hsz));
	
	ym_slatch #(.DATA_WIDTH(2)) sl_vsz(.MCLK(MCLK), .en(w224), .inp(reg_data_l2[5:4]), .val(reg_vsz));
	
	assign w523 = reg_hsz == 2'h0;
	
	assign w524 = reg_hsz == 2'h1;
	
	assign w525 = reg_hsz == 2'h3;
	
	assign w526 = w106 ? w522[10:4] : w522[9:3];
	
	assign w527 =
		( w523 ? w528 : 7'h0 ) |
		( w524 ? { w528[5:0], w555[5] }: 7'h0 ) |
		( w525 ? { w528[4:0], w555[6:5] } : 7'h0 );
	
	wire [2:0] w528_sum = w526[4:2] + { 2'h0, w529 };
	
	assign w528 = { reg_vsz[1] & w526[6], reg_vsz[0] & w526[5], w528_sum, w526[1:0] };
	
	assign w529 = ~reg_m5 & w530;
	
	assign w530 = w526[4:2] == 3'h7 | w526[5];
	
	assign w531 = reg_m5 & w558;
	
	ym_slatch #(.DATA_WIDTH(4)) sl_sa(.MCLK(MCLK), .en(w218), .inp(reg_data_l2[6:3]), .val(reg_sa));
	
	ym_slatch #(.DATA_WIDTH(2)) sl_sa(.MCLK(MCLK), .en(w218), .inp(reg_data_l2[2:1]), .val(reg_nt));
	
	ym_slatch #(.DATA_WIDTH(4)) sl_sb(.MCLK(MCLK), .en(w220), .inp(reg_data_l2[3:0]), .val(reg_sb));
	
	assign w532 = l200 ? reg_sb : reg_sa;
	
	assign w533 = reg_m5 ? w527[6:5] : reg_nt;
	
	ym_slatch sl_8e_b0(.MCLK(MCLK), .en(w232), .inp(reg_data_l2[0]), .val(reg_8e_b0));
	
	ym_slatch sl_8e_b4(.MCLK(MCLK), .en(w232), .inp(reg_data_l2[4]), .val(reg_8e_b4));
	
	assign w534 = l106[8:7] != 2'h3;
	
	assign w535 = { reg_hscr ? w537[7:3] : 5'h0, reg_lscr ? w537[2:0] : 3'h0 };
	
	assign w536 = reg_rs1 ?
		{ w537[7:3], l106[8] } :
		{ reg_wd[0], w537[7:3] };
	
	ym_slatch #(.DATA_WIDTH(6)) sl_wd(.MCLK(MCLK), .en(w219), .inp(reg_data_l2[6:1]), .val(reg_wd));
	
	ym_slatch #(.DATA_WIDTH(7)) sl_hs(.MCLK(MCLK), .en(w233), .inp(reg_data_l2[6:0]), .val(reg_hs));
	
	assign w537 = w106 ? w355[8:0] : w355[7:0];
	
	assign w538 = w546 ^ ~l187;
	
	assign w539 = w538 & w534;
	
	assign w540 = w545 ^ l189;
	
	assign w541 = (w540 | w539) & ~l106[3] & reg_m5;
	
	ym_slatch #(.DATA_WIDTH(5)) sl_whp(.MCLK(MCLK), .en(w223), .inp(reg_data_l2[4:0]), .val(reg_whp));
	
	ym_slatch sl_rigt(.MCLK(MCLK), .en(w223), .inp(reg_data_l2[7]), .val(reg_rigt));
	
	ym_slatch #(.DATA_WIDTH(5)) sl_wvp(.MCLK(MCLK), .en(w222), .inp(reg_data_l2[4:0]), .val(reg_wvp));
	
	ym_slatch sl_down(.MCLK(MCLK), .en(w222), .inp(reg_data_l2[7]), .val(reg_down));
	
	assign w542 = reg_test1[7] | l115;
	
	assign w543 = l115 & (reg_m5 | l162);
	
	assign w544 = w543 | reg_test1[7];
	
	ym_slatch sl187(.MCLK(MCLK), .en(w542), .inp(reg_rigt), .val(l187));
	
	ym_slatch #(.DATA_WIDTH(5)) sl188(.MCLK(MCLK), .en(w542), .inp(reg_whp), .val(l188));
	
	ym_slatch sl189(.MCLK(MCLK), .en(w544), .inp(reg_down), .val(l189));
	
	ym_slatch #(.DATA_WIDTH(5)) sl190(.MCLK(MCLK), .en(w544), .inp(reg_wvp), .val(l190));
	
	assign w545 = w537[7:3] < l190;
	
	assign w546 = l188 <= l106[8:4];
	
	assign w547 = reg_test1[7] | l115;
	
	ym_slatch #(.DATA_WIDTH(8)) sl_88(.MCLK(MCLK), .en(w231), .inp(reg_data_l2[7:0]), .val(reg_88));
	
	ym_slatch #(.DATA_WIDTH(8)) sl191(.MCLK(MCLK), .en(w570), .inp(vram_serial), .val(l191));
	
	ym_slatch #(.DATA_WIDTH(8)) sl192(.MCLK(MCLK), .en(w572), .inp(vram_serial), .val(l192));
	
	assign w548 = w394 | w385;
	
	assign w549 = w372 | (reg_test1[8] & cpu_pen);
	
	assign w550 = w394 & ~reg_m5;
	
	assign w551 = w550 | w385;
	
	assign w552 = ~(~reg_80_b6 | w355[5] | w355[6] | w355[4] | w355[7]);
	
	assign w553 = w552 | reg_m5;
	
	ym_slatch #(.DATA_WIDTH(8)) sl193(.MCLK(MCLK), .en(w547), .inp(reg_88), .val(l193));
	
	assign w554 = ~(
		(~w553 ? { 2'h0, l193 } : 10'h0) |
		(w574 ? { l194, l191 } : 10'h0) |
		(w575 ? { l195, l192 } : 10'h0)
		);
	
	ym_slatch #(.DATA_WIDTH(2)) sl194(.MCLK(MCLK), .en(w571), .inp(vram_serial[1:0]), .val(l194));
	
	ym_slatch #(.DATA_WIDTH(2)) sl195(.MCLK(MCLK), .en(w573), .inp(vram_serial[1:0]), .val(l195));
	
	assign w555 = { w554[9:4], w564 } + { w567, w565, w563 } + 7'h1;
	
	ym_sr_bit sr196(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w548), .sr_out(l196));
	
	ym_sr_bit sr197(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l106[3]), .sr_out(l197));
	
	ym_sr_bit sr198(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(~w550), .sr_out(l198));
	
	ym_sr_bit sr199(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w551), .sr_out(l199));
	
	assign w556 = reg_m5 & ~reg_test1[8] & w549;
	
	ym_sr_bit sr200(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w556), .sr_out(l200));
	
	assign w557 = ~w541 & w356;
	
	ym_sr_bit sr201(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w557), .sr_out(l201));
	
	assign w558 = l200 | l201;
	
	assign w559 = w356 & w541;
	
	ym_sr_bit sr202(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w559), .sr_out(l202));
	
	assign w560 = w356 | w549;
	
	ym_sr_bit sr203(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w560), .sr_out(l203));
	
	ym_sr_bit sr204(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l203), .sr_out(l204));
	
	ym_sr_bit sr205(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l204), .sr_out(l205));
	
	assign w561 = reg_rs1 ? w568 : l106[8];
	
	assign w562 = ~(w561 | reg_m5);
	
	assign w563 = w562 & l106[3];
	
	assign w564 = w554[3] | reg_m5;
	
	assign w565 = w561 ? 4'hf : l106[7:4];
	
	assign w566 = reg_m5 & l199;
	
	assign w567 = w561 ? reg_hsz : { w568, l106[8] };
	
	assign w568 = l106[8] & (l106[7] | l106[6])
	
	ym_sr_bit sr206(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w201), .sr_out(l206));
	
	ym_sr_bit sr207(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w323), .sr_out(l207));
	
	ym_sr_bit sr208(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w324), .sr_out(l208));
	
	ym_sr_bit sr209(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l206), .sr_out(l209));
	
	ym_sr_bit sr210(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l207), .sr_out(l210));
	
	ym_sr_bit sr211(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l208), .sr_out(l211));
	
	assign w569 = l206 | l207 | l208;
	
	ym_sr_bit_array #(.DATA_WIDTH(6)) sr212(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .data_in(w626), .data_out(l212));
	
	ym_dlatch_1 dl213(.MCLK(MCLK), .c1(clk1), .inp(~(hclk1 & l316)), .nval(l213));
	
	assign w570 = l213 & clk2;
	
	ym_sr_bit sr214(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l213), .sr_out(l214));
	
	assign w571 = l214 & clk2;
	
	ym_sr_bit sr215(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l214), .sr_out(l215));
	
	assign w572 = l215 & clk2;
	
	ym_sr_bit sr216(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l215), .sr_out(l216));
	
	assign w573 = l216 & clk2;
	
	assign w574 = ~w541 & reg_m5 & ~l106[3];
	
	assign w575 = ~w541 & reg_m5 & l106[3];
	
	assign w576 = l217 ? w355[3:0] : w522[3:0];
	
	assign w577 = w583 ? 4'hf : w576;
	
	assign w578 = w106 ? { l219, w577[3] } : { l220[0], l219 };
	
	assign w579 = w106 ? l220[2:0] : { w581, l220[2:1] };
	
	assign w580 = w106 ? { l222[2:0], l221, w577[3] } : { w581, l222[2:0], l221 };
	
	assign w581 = l197 ? reg_8e_b4 : reg_8e_b0;
	
	ym_sr_bit sr217(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w541), .sr_out(l217));
	
	assign w582 = w394 & reg_m5;
	
	ym_sr_bit sr218(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w582), .sr_out(l218));
	
	assign w583 = l218 ? l222[4] : w585;
	
	ym_slatch #(.DATA_WIDTH(8)) sl219(.MCLK(MCLK), .en(w615), .inp(vram_serial), .val(l219));
	
	ym_slatch #(.DATA_WIDTH(8)) sl220(.MCLK(MCLK), .en(w616), .inp(vram_serial), .val(l220));
	
	ym_slatch #(.DATA_WIDTH(8)) sl221(.MCLK(MCLK), .en(w617), .inp(vram_serial), .val(l221));
	
	ym_slatch #(.DATA_WIDTH(8)) sl222(.MCLK(MCLK), .en(w618), .inp(vram_serial), .val(l222));
	
	assign w584 = reg_m5 ? l220[3] : l220[1];
	assign w585 = reg_m5 ? l220[4] : l220[2];
	assign w586 = reg_m5 ? l220[6:5] : { 1'h0, l220[3] };
	assign w587 = reg_m5 ? l220[7] : l220[4];
	
	ym_slatch #(.DATA_WIDTH(8)) sl223(.MCLK(MCLK), .en(w591), .inp(vram_serial), .val(l223));
	
	ym_slatch #(.DATA_WIDTH(8)) sl224(.MCLK(MCLK), .en(w590), .inp(vram_serial), .val(l224));
	
	ym_slatch #(.DATA_WIDTH(8)) sl225(.MCLK(MCLK), .en(w589), .inp(vram_serial), .val(l225));
	
	ym_slatch #(.DATA_WIDTH(8)) sl226(.MCLK(MCLK), .en(w588), .inp(vram_serial), .val(l226));
	
	ym_dlatch_1 dl227(.MCLK(MCLK), .c1(clk1), .inp(w613), .nval(l227));
	
	ym_sr_bit sr228(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l227), .sr_out(l228));
	
	ym_sr_bit sr229(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l228), .sr_out(l229));
	
	ym_sr_bit sr230(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l229), .sr_out(l230));
	
	ym_sr_bit sr231(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l230), .sr_out(l231));
	
	assign w588 = l227 & clk2;
	
	assign w589 = l228 & clk2;
	
	assign w590 = l229 & clk2;
	
	assign w591 = l230 & clk2;
	
	ym_slatch #(.DATA_WIDTH(8)) sl232(.MCLK(MCLK), .en(w592), .inp(l223), .val(l232));
	
	ym_slatch #(.DATA_WIDTH(8)) sl233(.MCLK(MCLK), .en(w592), .inp(l224), .val(l233));
	
	ym_slatch #(.DATA_WIDTH(8)) sl234(.MCLK(MCLK), .en(w592), .inp(l225), .val(l234));
	
	ym_slatch #(.DATA_WIDTH(8)) sl235(.MCLK(MCLK), .en(w592), .inp(l226), .val(l235));
	
	assign w592 = w598 & clk2;
	
	ym_slatch #(.DATA_WIDTH(4)) sl236(.MCLK(MCLK), .en(l242), .inp(w554[3:0]), .val(l236));
	
	assign w593 = w614 & l236 == 4'hf;
	
	ym_slatch #(.DATA_WIDTH(8)) sl237(.MCLK(MCLK), .en(w611), .inp(l232), .val(l237));
	
	ym_slatch #(.DATA_WIDTH(8)) sl238(.MCLK(MCLK), .en(w611), .inp(l233), .val(l238));
	
	ym_slatch #(.DATA_WIDTH(8)) sl239(.MCLK(MCLK), .en(w611), .inp(l234), .val(l239));
	
	ym_slatch #(.DATA_WIDTH(8)) sl240(.MCLK(MCLK), .en(w611), .inp(l235), .val(l240));
	
	ym_cnt_bit_load #(.DATA_WIDTH(4)) cnt241(.MCLK(MCLK), .c1(hclk1), .c2(hclk2),
		.c_in(1'h1), .reset(1'h0), .load(w614), .load_val(l236), val(l241));
	
	ym_sr_bit sr242(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w614), .sr_out(l242));
	
	ym_slatch #(.DATA_WIDTH(8)) sl243(.MCLK(MCLK), .en(w597), .inp(vram_serial), .val(l243));
	
	ym_slatch #(.DATA_WIDTH(8)) sl244(.MCLK(MCLK), .en(w596), .inp(vram_serial), .val(l244));
	
	ym_slatch #(.DATA_WIDTH(8)) sl245(.MCLK(MCLK), .en(w595), .inp(vram_serial), .val(l245));
	
	ym_slatch #(.DATA_WIDTH(8)) sl246(.MCLK(MCLK), .en(w594), .inp(vram_serial), .val(l246));
	
	ym_dlatch_1 dl247(.MCLK(MCLK), .c1(clk1), .inp(w600), .nval(l247));
	
	ym_sr_bit sr248(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l247), .sr_out(l248));
	
	ym_sr_bit sr249(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l248), .sr_out(l249));
	
	ym_sr_bit sr250(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l249), .sr_out(l250));
	
	assign w594 = l247 & clk2;
	
	assign w595 = l248 & clk2;
	
	assign w596 = l249 & clk2;
	
	assign w597 = l250 & clk2;
	
	ym_dlatch_1 dl251(.MCLK(MCLK), .c1(clk1), .inp(w633), .nval(l251));
	
	ym_sr_bit sr252(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l251), .sr_out(l252));
	
	ym_sr_bit sr253(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l252), .sr_out(l253));
	
	ym_sr_bit sr254(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l253), .sr_out(l254));
	
	ym_slatch #(.DATA_WIDTH(8)) sl255(.MCLK(MCLK), .en(w592), .inp(l243), .val(l255));
	
	ym_slatch #(.DATA_WIDTH(8)) sl256(.MCLK(MCLK), .en(w592), .inp(l244), .val(l256));
	
	ym_slatch #(.DATA_WIDTH(8)) sl257(.MCLK(MCLK), .en(w592), .inp(l245), .val(l257));
	
	ym_slatch #(.DATA_WIDTH(8)) sl258(.MCLK(MCLK), .en(w592), .inp(l246), .val(l258));
	
	ym_slatch #(.DATA_WIDTH(8)) sl259(.MCLK(MCLK), .en(w591),
		.inp({ w587, l522[7], w586[1], l222[6], w586[0], l222[5], w584, l222[3] }), .val(l259));
	
	ym_slatch #(.DATA_WIDTH(8)) sl260(.MCLK(MCLK), .en(w592), .inp(l259), .val(l260));
	
	ym_slatch #(.DATA_WIDTH(8)) sl261(.MCLK(MCLK), .en(w611), .inp(l255), .val(l261));
	
	ym_slatch #(.DATA_WIDTH(8)) sl262(.MCLK(MCLK), .en(w611), .inp(l256), .val(l262));
	
	ym_slatch #(.DATA_WIDTH(8)) sl263(.MCLK(MCLK), .en(w611), .inp(l257), .val(l263));
	
	ym_slatch #(.DATA_WIDTH(8)) sl264(.MCLK(MCLK), .en(w611), .inp(l258), .val(l264));
	
	ym_slatch #(.DATA_WIDTH(8)) sl265(.MCLK(MCLK), .en(w611), .inp(l260), .val(l265));
	
	assign w598 = reg_m5 ? l302 : l231;
	
	assign w599 = reg_m5 & l241[3];
	
	assign w600 = ~(hclk1 & w612);
	
	assign w601 = reg_m5 ^ l241[1];
	
	assign w602 = w599 ? l265[0] : l265[1];
	
	assign w603 = w599 ? l265[2] : l265[3];
	
	assign w604 = w599 ? l265[4] : l265[5];
	
	assign w605 = w599 ? l265[6] : l265[7];
	
	wire[2:0] w606_t = { l241[2], w601, l241[0] };
	
	assign w606 = w602 ? ~w606_t : w606_t;
	
	wire [7:0] w606_sel;
	
	assign w606_sel[0] = w606 == 3'h0;
	assign w606_sel[1] = w606 == 3'h1;
	assign w606_sel[2] = w606 == 3'h2;
	assign w606_sel[3] = w606 == 3'h3;
	assign w606_sel[4] = w606 == 3'h4;
	assign w606_sel[5] = w606 == 3'h5;
	assign w606_sel[6] = w606 == 3'h6;
	assign w606_sel[7] = w606 == 3'h7;
	
	wire [3:0] w607_m4 =
		(w606_sel[0] ? { l239[7], l240[7], l263[7], l264[7] } : 4'h0 ) |
		(w606_sel[1] ? { l239[6], l240[6], l263[6], l264[6] } : 4'h0 ) |
		(w606_sel[2] ? { l239[5], l240[5], l263[5], l264[5] } : 4'h0 ) |
		(w606_sel[3] ? { l239[4], l240[4], l263[4], l264[4] } : 4'h0 ) |
		(w606_sel[4] ? { l239[3], l240[3], l263[3], l264[3] } : 4'h0 ) |
		(w606_sel[5] ? { l239[2], l240[2], l263[2], l264[2] } : 4'h0 ) |
		(w606_sel[6] ? { l239[1], l240[1], l263[1], l264[1] } : 4'h0 ) |
		(w606_sel[7] ? { l239[0], l240[0], l263[0], l264[0] } : 4'h0 );
	
	wire [3:0] w607_m5_1 =
		(w606_sel[7] : l261[3:0] : 4'h0) |
		(w606_sel[6] : l261[7:3] : 4'h0) |
		(w606_sel[5] : l262[3:0] : 4'h0) |
		(w606_sel[4] : l262[7:3] : 4'h0) |
		(w606_sel[3] : l263[3:0] : 4'h0) |
		(w606_sel[2] : l263[7:3] : 4'h0) |
		(w606_sel[1] : l265[3:0] : 4'h0) |
		(w606_sel[0] : l265[7:3] : 4'h0);
	
	wire [3:0] w607_m5_2 =
		(w606_sel[7] : l237[3:0] : 4'h0) |
		(w606_sel[6] : l237[7:3] : 4'h0) |
		(w606_sel[5] : l238[3:0] : 4'h0) |
		(w606_sel[4] : l238[7:3] : 4'h0) |
		(w606_sel[3] : l239[3:0] : 4'h0) |
		(w606_sel[2] : l239[7:3] : 4'h0) |
		(w606_sel[1] : l240[3:0] : 4'h0) |
		(w606_sel[0] : l240[7:3] : 4'h0);
	
	assign w607 =
		(~reg_m5 ? w607_m4 : 4'h0) |
		((reg_m5 & ~l241[3]) ? w607_m5_1 : 4'h0) |
		((reg_m5 & l241[3]) ? w607_m5_2 : 4'h0);
	
	assign w608 = l241[3] | ~reg_m5;
	
	assign w609 = w608 & l241[2:0] == 3'h7;
	
	assign w610 = ~(w609 | w593);
	
	ym_dlatch_1 dl266(.MCLK(MCLK), .c1(hclk1), .inp(w610), .nval(l266));
	
	assign w611 = hclk2 & l266;
	
	assign w612 = w393 | (reg_test1[9] & cpu_pen);
	
	ym_sr_bit sr267(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w612), .sr_out(l267));
	
	ym_sr_bit sr268(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l267), .sr_out(l268));
	
	assign w613 = ~(l268 & hclk1);
	
	ym_sr_bit_array #(.DATA_WIDTH(4)) sr269(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .data_in(w607), .data_out(l269));
	
	ym_sr_bit_array #(.DATA_WIDTH(4)) sr270(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .data_in(l269), .data_out(l270));
	
	ym_sr_bit_array #(.DATA_WIDTH(2)) sr271(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .data_in({ w604, w603 }), .data_out(l271));
	
	ym_sr_bit_array #(.DATA_WIDTH(2)) sr272(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .data_in(l271), .data_out(l272));
	
	ym_sr_bit sr273(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w605), .sr_out(l273));
	
	ym_sr_bit sr274(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l273), .sr_out(l274));
	
	assign w614 = w424 | w90;
	
	ym_slatch #(.DATA_WIDTH(8)) sl275(.MCLK(MCLK), .en(w622), .inp(vram_serial), .val(l275));
	
	ym_slatch #(.DATA_WIDTH(8)) sl276(.MCLK(MCLK), .en(w621), .inp(vram_serial), .val(l276));
	
	ym_slatch #(.DATA_WIDTH(8)) sl277(.MCLK(MCLK), .en(w620), .inp(vram_serial), .val(l277));
	
	ym_slatch #(.DATA_WIDTH(8)) sl278(.MCLK(MCLK), .en(w619), .inp(vram_serial), .val(l278));
	
	ym_slatch #(.DATA_WIDTH(8)) sl279(.MCLK(MCLK), .en(w631), .inp(l275), .val(l279));
	
	ym_slatch #(.DATA_WIDTH(8)) sl280(.MCLK(MCLK), .en(w631), .inp(l276), .val(l280));
	
	ym_slatch #(.DATA_WIDTH(8)) sl281(.MCLK(MCLK), .en(w631), .inp(l277), .val(l281));
	
	ym_slatch #(.DATA_WIDTH(8)) sl282(.MCLK(MCLK), .en(w631), .inp(l278), .val(l282));
	
	assign w615 = l251 & clk2;
	assign w616 = l252 & clk2;
	assign w617 = l253 & clk2;
	assign w618 = l254 & clk2;
	
	ym_dlatch_1 dl283(.MCLK(MCLK), .c1(clk1), .inp(w640), .nval(l283));
	
	ym_sr_bit sr284(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l251), .sr_out(l284));
	
	ym_sr_bit sr285(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l252), .sr_out(l285));
	
	ym_sr_bit sr286(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l253), .sr_out(l286));
	
	assign w619 = l283 & clk2;
	assign w620 = l284 & clk2;
	assign w621 = l285 & clk2;
	assign w622 = l286 & clk2;
	
	ym_slatch #(.DATA_WIDTH(8)) sl287(.MCLK(MCLK), .en(w645), .inp(l279), .val(l287));
	
	ym_slatch #(.DATA_WIDTH(8)) sl288(.MCLK(MCLK), .en(w645), .inp(l280), .val(l288));
	
	ym_slatch #(.DATA_WIDTH(8)) sl289(.MCLK(MCLK), .en(w645), .inp(l281), .val(l289));
	
	ym_slatch #(.DATA_WIDTH(8)) sl290(.MCLK(MCLK), .en(w645), .inp(l282), .val(l290));
	
	ym_slatch #(.DATA_WIDTH(8)) sl291(.MCLK(MCLK), .en(w631),
		.inp({ w587, l522[7], w586[1], l222[6], w586[0], l222[5], w584, l222[3] }), .val(l291));
	
	ym_slatch #(.DATA_WIDTH(8)) sl292(.MCLK(MCLK), .en(w645), .inp(l291), .val(l292));
	
	assign w623 = ~(reg_m5 & reg_vscr);
	
	ym_sr_bit_array #(.DATA_WIDTH(6)) sr293(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .data_in(vram_address[6:1]), .data_out(l293));
	
	assign w624 = w623 & l106[3];
	
	assign w625 = reg_vscr ? l106[8:4] : 5'h0;
	
	assign w626 = w569 ? l293 : { w625, w624 };
	
	ym_slatch #(.DATA_WIDTH(8)) sl294(.MCLK(MCLK), .en(w630), .inp(vram_serial), .val(l294));
	
	ym_slatch #(.DATA_WIDTH(8)) sl295(.MCLK(MCLK), .en(w629), .inp(vram_serial), .val(l295));
	
	ym_slatch #(.DATA_WIDTH(8)) sl296(.MCLK(MCLK), .en(w628), .inp(vram_serial), .val(l296));
	
	ym_slatch #(.DATA_WIDTH(8)) sl297(.MCLK(MCLK), .en(w627), .inp(vram_serial), .val(l297));
	
	ym_dlatch_1 dl298(.MCLK(MCLK), .c1(clk1), .inp(w639), .nval(l298));
	
	ym_sr_bit sr299(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l251), .sr_out(l299));
	
	ym_sr_bit sr300(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l252), .sr_out(l300));
	
	ym_sr_bit sr301(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l253), .sr_out(l301));
	
	ym_sr_bit sr302(.MCLK(MCLK), .c1(clk2), .c2(clk1), .bit_in(l254), .sr_out(l302));
	
	assign w627 = l298 & clk2;
	
	assign w628 = l299 & clk2;
	
	assign w629 = l300 & clk2;
	
	assign w630 = l301 & clk2;
	
	assign w631 = l302 & clk2;
	
	ym_slatch #(.DATA_WIDTH(8)) sl303(.MCLK(MCLK), .en(w631), .inp(l294), .val(l303));
	
	ym_slatch #(.DATA_WIDTH(8)) sl304(.MCLK(MCLK), .en(w631), .inp(l295), .val(l304));
	
	ym_slatch #(.DATA_WIDTH(8)) sl305(.MCLK(MCLK), .en(w631), .inp(l296), .val(l305));
	
	ym_slatch #(.DATA_WIDTH(8)) sl306(.MCLK(MCLK), .en(w631), .inp(l297), .val(l306));
	
	ym_slatch #(.DATA_WIDTH(8)) sl307(.MCLK(MCLK), .en(w645), .inp(l303), .val(l307));
	
	ym_slatch #(.DATA_WIDTH(8)) sl308(.MCLK(MCLK), .en(w645), .inp(l304), .val(l308));
	
	ym_slatch #(.DATA_WIDTH(8)) sl309(.MCLK(MCLK), .en(w645), .inp(l305), .val(l309));
	
	ym_slatch #(.DATA_WIDTH(8)) sl310(.MCLK(MCLK), .en(w645), .inp(l306), .val(l310));
	
	ym_cnt_bit_load #(.DATA_WIDTH(4)) cnt311(.MCLK(MCLK), .c1(hclk1), .c2(hclk2),
		.c_in(1'h1), .reset(1'h0), .load(w649), .load_val({~w554[3], w554[2:0]}), val(l311));
	
	wire [2:0] w632_t = l311[2:0];
	
	assign w632 = w634 ? ~w632_t : w632_t;
	
	assign w633 = ~(hclk1 & l205);
	
	assign w634 = l311[3] ? l292[0] : l292[1];
	assign w635 = l311[3] ? l292[2] : l292[3];
	assign w636 = l311[3] ? l292[4] : l292[5];
	assign w637 = l311[3] ? l292[6] : l292[7];
	
	assign w638 = w402 | (reg_test1[10] & cpu_pen);
	
	ym_sr_bit sr312(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w638), .sr_out(l312));
	
	ym_sr_bit sr313(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l312), .sr_out(l313));
	
	assign w639 = ~(hclk1 & l313);
	
	assign w640 = ~(hclk1 & w638);
	
	assign w641 = { w632[2], ~w632[1], w632[0] };
	
	assign w642 = w419 | (reg_test1[6] & cpu_pen);
	
	ym_sr_bit sr314(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w642), .sr_out(l314));
	
	ym_sr_bit sr315(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l314), .sr_out(l315));
	
	ym_sr_bit sr316(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l315), .sr_out(l316));
	
	assign w643 = l314 & ~reg_test1[7];
	
	assign w644 = ~(l311 == 4'h15);
	
	ym_dlatch_1 dl317(.MCLK(MCLK), .c1(hclk1), .inp(w644), .nval(l317));
	
	assign w645 = l317 & hclk2;
	
	assign w646 = l269 != 4'h0;
	
	wire [7:0] w641_sel;
	
	assign w641_sel[0] = w641 == 3'h0;
	assign w641_sel[1] = w641 == 3'h1;
	assign w641_sel[2] = w641 == 3'h2;
	assign w641_sel[3] = w641 == 3'h3;
	assign w641_sel[4] = w641 == 3'h4;
	assign w641_sel[5] = w641 == 3'h5;
	assign w641_sel[6] = w641 == 3'h6;
	assign w641_sel[7] = w641 == 3'h7;
	
	wire [3:0] w647_1 =
		(w641_sel[7] : l307[3:0] : 4'h0) |
		(w641_sel[6] : l307[7:3] : 4'h0) |
		(w641_sel[5] : l308[3:0] : 4'h0) |
		(w641_sel[4] : l308[7:3] : 4'h0) |
		(w641_sel[3] : l309[3:0] : 4'h0) |
		(w641_sel[2] : l309[7:3] : 4'h0) |
		(w641_sel[1] : l310[3:0] : 4'h0) |
		(w641_sel[0] : l310[7:3] : 4'h0);
	
	wire [3:0] w647_2 =
		(w641_sel[7] : l287[3:0] : 4'h0) |
		(w641_sel[6] : l287[7:3] : 4'h0) |
		(w641_sel[5] : l288[3:0] : 4'h0) |
		(w641_sel[4] : l288[7:3] : 4'h0) |
		(w641_sel[3] : l289[3:0] : 4'h0) |
		(w641_sel[2] : l289[7:3] : 4'h0) |
		(w641_sel[1] : l290[3:0] : 4'h0) |
		(w641_sel[0] : l290[7:3] : 4'h0);
	
	assign w647 =
		(l311[3] ? w647_1 : 4'h0) |
		(~l311[3] ? w647_2 : 4'h0);
	
	ym_sr_bit_array #(.DATA_WIDTH(4)) sr318(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .data_in(w647), .data_out(l318));
	
	ym_sr_bit_array #(.DATA_WIDTH(4)) sr319(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .data_in(l318), .data_out(l319));
	
	assign w648 = l318 != 4'h0;
	
	ym_sr_bit sr320(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(w637), .sr_out(l320));
	
	ym_sr_bit sr321(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .bit_in(l320), .sr_out(l321));
	
	ym_sr_bit_array #(.DATA_WIDTH(2)) sr322(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .data_in({w636, w635}), .data_out(l322));
	
	ym_sr_bit_array #(.DATA_WIDTH(2)) sr323(.MCLK(MCLK), .c1(hclk1), .c2(hclk2), .data_in(l322), .data_out(l323));
	
	assign w649 = w92 | w415;
	
	// vsram
	
	wire [5:0] vsram_index = l212;
	
	wire vsram_w1 = hclk1 & l211;
	wire vsram_w2 = hclk1 & l210;
	
	always @(posedge MCLK)
	begin
		if (vsram_index < 6'd40)
		begin
			if (vsram_w1)
			begin
				vsram_out[7:0] <= l181[7:0];
				vsram_low[vsram_index] <= l181[7:0];
			end
			else
				vsram_out[7:0] <= vsram_low[vsram_index];
			if (vsram_w2)
			begin
				vsram_out[10:8] <= l181[10:8];
				vsram_hi[vsram_index] <= l181[10:8];
			end
			else
				vsram_out[10:8] <= vsram_hi[vsram_index];
			if (vsram_index[0])
				vsram_out_odd <= vsram_out;
			else
				vsram_out_even <= vsram_out;
		end
		else
		begin
			if (vsram_index[0])
				vsram_out <= vsram_out & vsram_out_odd;
			else
				vsram_out <= vsram_out & vsram_out_even;
		end
	end
	
	
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


module ym7101_dff #(parameter DATA_WIDTH = 1)
	(
	input MCLK,
	input clk,
	input [DATA_WIDTH-1:0] inp,
	input rst,
	output [DATA_WIDTH-1:0] outp
	);
	
	reg [DATA_WIDTH-1:0] l1, l2;
	
	wire [DATA_WIDTH-1:0] l2_assign = rst ? {DATA_WIDTH{1'h0}} : (clk ? l1 : l2);
	
	assign outp = l2_assign;
	
	always @(posedge MCLK)
	begin
		if (rst)
		begin
			l1 <= {DATA_WIDTH{1'h0}};
		end
		else
		begin
			if (~clk)
				l1 <= inp;
		end
		assign l2 = l2_assign;
	end
	
endmodule
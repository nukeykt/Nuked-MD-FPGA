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
 *  YM6045C(FC1004) emulator.
 *  Thanks:
 *      org (ogamespec):
 *          FC1004 decap and die shot.
 *      andkorzh, HardWareMan (emu-russia):
 *          help & support.
 *
 */
module ym6045
	(
	input MCLK,
	input VCLK,
	input ZCLK,
	input VD8_i,
	input [15:7] ZA_i,
	input ZA0_i,
	input [22:7] VA_i,
	input ZRD,
	input M1,
	input ZWR,
	input BGACK_i,
	input BG,
	input IORQ,
	input RW_i,
	input UDS_i,
	input AS_i,
	input DTACK_i,
	input LDS_i,
	input CAS0,
	input M3,
	input WRES,
	input CART,
	input OE0,
	input WAIT_in,
	input ZBAK,
	input MREQ_in,
	input FC0,
	input FC1,
	input SRES,
	input test_mode_0,
	input ZD0_i,
	input HSYNC,
	output VD8_o,
	output ZA0_o,
	output [15:8] ZA_o,
	output [22:7] VA_o,
	output ZRD_o,
	output UDS_o,
	output ZWR_o,
	output BGACK_o,
	output AS_o,
	output RW_d,
	output RD_o,
	output LDS_o,
	output strobe_d,
	output DTACK_o,
	output BR,
	output IA14,
	output TIME,
	output CE0,
	output FDWR,
	output FDC,
	output ROM,
	output ASEL,
	output EOE,
	output NOE,
	output RAS2,
	output CAS2,
	output REF,
	output ZRAM,
	output WAIT_o,
	output ZBR,
	output NMI,
	output ZRES,
	output SOUND,
	output VZ,
	output MREQ_o,
	output VRES,
	output VPA,
	output VDPM,
	output IO,
	output ZV,
	output INTAK,
	output EDCLK
	);
	
	wire pal_trap = ~1'h0;
	
	reg dff1;
	reg dff2;
	reg dff3;
	wire dff4_l2, dff4_cout;
	wire dff5_l2, dff5_cout;
	wire dff6_l2, dff6_cout;
	wire dff7_l2;
	wire dff8_nq;
	wire dff9_q;
	wire w1;
	wire w2;
	wire w3;
	wire w4;
	wire w5;
	wire w7;
	wire w9;
	wire w10;
	wire w11;
	
	// EDCLK
	always @(posedge MCLK)
	begin
		if (!sres)
		begin
			dff1 <= 1'h0;
			dff2 <= 1'h0;
			dff3 <= 1'h0;
		end
		else
		begin
			if (~w1)
			begin
				dff1 <= 1'h1;
				dff2 <= ~dff9_q;
				dff3 <= 1'h0;
			end
			else
			begin
				dff1 <= dff1 ^ w3;
				dff2 <= ~dff2;
				dff3 <= dff3 & dff2;
			end
		end
	end
	
	assign w1 = ~(~dff1 & ~dff2 & ~dff3);
	assign w2 = dff3;
	assign w3 = dff2 & dff3;
	assign w4 = w2;
	assign w5 = ~(~dff4_l2 | ~dff5_l2 | ~dff6_l2 | ~dff7_l2);

	ym_scnt_bit dff4(.MCLK(MCLK), .clk(w4), .load(dff9_q), .val(1'h1), .cin(dff9_q), .rst(sres), .outp(dff4_l2), .cout(dff4_cout));
	ym_scnt_bit dff5(.MCLK(MCLK), .clk(w4), .load(dff9_q), .val(1'h0), .cin(dff4_cout), .rst(sres), .outp(dff5_l2), .cout(dff5_cout));
	ym_scnt_bit dff6(.MCLK(MCLK), .clk(w4), .load(dff9_q), .val(1'h0), .cin(dff5_cout), .rst(sres), .outp(dff6_l2), .cout(dff6_cout));
	ym_scnt_bit dff7(.MCLK(MCLK), .clk(w4), .load(dff9_q), .val(1'h0), .cin(dff6_cout), .rst(sres), .outp(dff7_l2));
	
	assign EDCLK = w2;
	
	assign w7 = dff8_nq;
	assign w11 = ~(~HSYNC | dff9_q);
	assign w10 = ~(w11 | (1'h0 & dff9_q));
	
	ym_sdffr dff9(.MCLK(MCLK), .clk(w2), .val(w10), .reset(w7), .q(dff9_q));
	ym_sdffs dff8(.MCLK(MCLK), .clk(w2), .val(w5), .set(sres), .nq(dff8_nq));
	
	// RAM OE
	assign w9 = sres;
	
	assign w279 = ~BGACK_i;
	assign w302 = ~(w9 & (dff50_nq | dff62_q));
	assign w299 = ~w302;
	
	ym_sdffr dff49(.MCLK(MCLK), .clk(VCLK), .val(w279), .reset(dff51_q), .q(dff49_q), .nq(dff49_nq));
	ym_sdffr dff50(.MCLK(MCLK), .clk(~VCLK), .val(w322), .reset(w9), .q(dff50_q), .nq(dff50_nq));
	ym_sdffr dff51(.MCLK(MCLK), .clk(w279), .val(w336), .reset(w299), .q(dff51_q));
	
	assign w325 = CAS0 & dff62_q;
	assign w321 = dff61_nq & OE0;
	assign w326 = w321 | w325;
	assign w300 = ~(w326 & (dff49_nq | dff50_q));
	assign w314 = ~w300;
	assign NOE = w314;
	assign EOE = ~(~w314 & M3);
	
	assign w322 = dff62_q;
	
	assign w342 = dff49_q;
	
	ym_sdffr dff61(.MCLK(MCLK), .clk(~VCLK), .val(w342), .reset(dff51_q), .q(dff61_q), .nq(dff61_nq));
	
	ym_sdffr dff62(.MCLK(MCLK), .clk(VCLK), .val(dff61_q), .reset(dff51_q), .q(dff62_q));
	
	// delays
	
	wire d1_out;
	wire d2_out;
	wire d3_out;
	wire d4_out;
	wire d5_out;
	wire d6_out;
	wire d7_out;
	wire d8_out;
	
	ym_delaychain #(DELAY_CNT(1)) d1(.MCLK(MCLK), .inp(M1), .outp(d1_out));
	ym_delaychain #(DELAY_CNT(1)) d2(.MCLK(MCLK), .inp(w188), .outp(d2_out));
	ym_delaychain #(DELAY_CNT(7)) d3(.MCLK(MCLK), .inp(w254), .outp(d3_out));
	ym_delaychain #(DELAY_CNT(1)) d4(.MCLK(MCLK), .inp(w113), .outp(d4_out));
	ym_delaychain #(DELAY_CNT(2)) d5(.MCLK(MCLK), .inp(w271), .outp(d5_out));
	ym_delaychain #(DELAY_CNT(6)) d6(.MCLK(MCLK), .inp(w238), .outp(d6_out));
	ym_delaychain #(DELAY_CNT(6)) d7(.MCLK(MCLK), .inp(w223), .outp(d7_out));
	ym_delaychain #(DELAY_CNT(1)) d8(.MCLK(MCLK), .inp(M3), .outp(d8_out));
	
	// 
	
	assign w143 = ~M3 | w220 | ~ZA_i[15];
	assign w185 = w86 | w220;
	assign w188 = w185 & w143;
	ym_sdff dff34(.MCLK(MCLK), .clk(ZCLK), .val(d2_out), .q(dff34_q));
	assign w182 = w188 & dff34_q;
	assign w255 = ~(DTACK_i | w79);
	assign w258 = ~(w255 | w79);
	assign WAIT_o = ~w258;
	assign w78 = ~w79 | w182 | ~sres;
	assign w79 = dff21_q | w182 | ~sres;
	ym_sdff dff10(.MCLK(MCLK), .clk(VCLK), .val(w78), .q(dff10_q));
	assign BR = dff10_q;
	ym_sdff dff28(.MCLK(MCLK), .clk(VCLK), .val(w79), .q(dff28_q));
	assign w111 = dff28_q | w182;
	ym_sdff dff22(.MCLK(MCLK), .clk(VCLK), .val(w111), .q(dff22_q));
	assign w77 = dff22_q | w182;
	ym_sdff dff18(.MCLK(MCLK), .clk(VCLK), .val(w77), .q(dff18_q));
	assign w50 = w77 | ZRD_i;
	assign w51 = dff18_q | ZWR_i;
	assign w53 = w50 & w51;
	assign UDS_o = w53 | ZA0_i;
	assign LDS_o = w53 | ~ZA0_i;
	assign AS_o = w77;
	assign w149 = ~(test | pal_trap | w146);
	assign w76 = ~sres | dff21_q;
	assign ztov = w76 & M3;
	assign w106 = w76;
	assign w175 = ~AS_i;
	assign w176 = ~BGACK_i;
	assign w174 = w175 | w176 | w182 | BG;
	assign w178 = w174 & w79;
	ym_sdff dff21(.MCLK(MCLK), .clk(~VCLK), .val(w178), .q(dff21_q));
	assign w146 = w76;
	assign w268 = ~(test | pal_trap | w146);
	assign RW_d = w146 | test;
	assign strobe_dir = ~w268;
	assign BGACK_o = ~w149;
	
	//assign w45 = w46 & ztov;
	//assign w46 = w45 | BGACK_i;
	
	reg w45;
	
	always @(posedge MCLK)
	begin
		if (~ztov)
			w45 <= 1'h0;
		else
			w45 <= w45 | BGACK_i;
	end
	
	assign w48 = ~w45;
	
	
endmodule

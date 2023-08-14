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
 *  TMSS(FC1004) emulator
 *  Thanks:
 *      org (ogamespec):
 *          FC1004 decap and die shot.
 *      andkorzh, HardWareMan (emu-russia):
 *          help & support.
 *
 */

module tmss
	(
	input MCLK,
	input [15:0] VD_i,
	input [2:0] test,
	input JAP,
	input AS,
	input LDS,
	input UDS,
	input RW,
	input [22:0] VA,
	input SRES,
	input CE0_i,
	input M3,
	input CART,
	input INTAK,
	output [15:0] VD_o,
	output DTACK,
	output RESET,
	output CE0_o,
	output test_0,
	output test_1,
	output test_2,
	output test_3,
	output test_4,
	output data_out_en,
	input tmss_enable,
	input [15:0] tmss_data,
	output [9:0] tmss_address
	);
	
	wire dff1_q;
	wire dff2_nq;
	wire w3;
	wire w10;
	wire w15;
	wire w23;
	wire w40;
	wire w41;
	wire dff3_q;
	wire w31;
	wire w28;
	wire w38;
	wire [15:0] l1;
	wire w39;
	wire [15:0] l2;
	wire [15:0] w20;
	wire w50;
	wire w51;
	wire w53;
	wire w54;
	wire w55;
	wire w56;
	wire w52;
	wire w57;
	wire w58;
	wire w59;
	wire w62;
	
	ym_sdffr dff1(.MCLK(MCLK), .clk(w40), .val(w3), .reset(SRES), .q(dff1_q));
	ym_sdffs dff2(.MCLK(MCLK), .clk(w10), .val(dff1_q), .set(SRES), .nq(dff2_nq));
	
	assign w3 = l1 == 16'h5345 & l2 == 16'h4741;
	
	assign RESET = tmss_enable ? (~(JAP & dff2_nq) | test_4) : 1'h1;
	
	assign w10 = ~(~AS & VA[22:20] == 3'h6);
	
	assign w15 = ~AS & ~LDS & VA[22:1] == 22'h285000 & ~UDS;
	assign w23 = ~AS & ~LDS & VA == 23'h50a080;
	
	assign DTACK = tmss_enable ? (~((w15 | w23) & INTAK) | test_4) : 1'h1;
	
	assign w40 = ~(~RW & w15);
	assign w41 = ~(RW & w15);
	
	ym_sdffr dff3(.MCLK(MCLK), .clk(~w23 | RW), .val(VD_i[0]), .reset(SRES), .q(dff3_q));
	//ym_sdffs dff3(.MCLK(MCLK), .clk(~w23 | RW), .val(VD_i[0]), .set(SRES), .q(dff3_q));
	
	assign w31 = CART | ~M3;
	assign w28 = dff3_q | w31 | CE0_i;
	assign CE0_o = tmss_enable ? (~(dff3_q | w31) | CE0_i) : CE0_i;
	
	assign w38 = ~VA[0] & ~RW & w15;
	ym_slatch #(.DATA_WIDTH(16)) sl1(.MCLK(MCLK), .en(w38), .inp(VD_i), .val(l1));
	assign w39 = VA[0] & ~RW & w15;
	ym_slatch #(.DATA_WIDTH(16)) sl2(.MCLK(MCLK), .en(w39), .inp(VD_i), .val(l2));
	
	assign w20 = VA[0] ? l2 : l1;
	assign VD_o = tmss_enable ? (w28 ? w20 : tmss_data) : 16'h0;
	
	assign tmss_address = VA[9:0];
	
	assign data_out_en = tmss_enable ? (w41 & w28) | test_4 : 1'h1;
	
	assign no_tmss_flag = 1'h0;
	
	assign w50 = test[2:0] == 3'h0;
	assign w51 = test[2:0] == 3'h1;
	assign w53 = test[2:0] == 3'h2;
	assign w54 = test[2:0] == 3'h3;
	assign w55 = test[2:0] == 3'h4;
	assign w56 = test[2:0] == 3'h7;
	
	assign w52 = w50 ^ w56;
	assign w57 = w51 ^ w56;
	assign w58 = w53 ^ w56;
	assign w59 = w54 ^ w56;
	assign w62 = w56 ^ w55;
	
	assign test_0 = ~w52;
	assign test_1 = ~w57;
	assign test_2 = ~w58;
	assign test_3 = ~w59;
	assign test_4 = ~w62;

endmodule

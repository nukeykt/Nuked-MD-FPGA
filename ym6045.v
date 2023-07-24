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
	input ZRD_i,
	input M1,
	input ZWR_i,
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
	input WAIT_i,
	input ZBAK,
	input MREQ_i,
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
	output RW_o,
	output LDS_o,
	output strobe_dir,
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
	output EDCLK,
	output vtoz,
	output w12,
	output w131,
	output w142,
	output w310,
	output w353
	);
	
	wire pal_trap = ~1'h1;
	
	reg dff1;
	reg dff2;
	reg dff3;
	wire dff4_nq, dff4_cout;
	wire dff5_nq, dff5_cout;
	wire dff6_nq, dff6_cout;
	wire dff7_nq;
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
	wire dff10_q;
	wire w16;
	wire dff11_q;
	wire dff12_q, dff12_nq;
	wire w26;
	wire w27;
	wire w31;
	wire w33;
	wire w34;
	wire w35;
	wire dff13_q;
	wire w36;
	wire zbr_nq;
	wire sres;
	wire dff15_q, dff15_nq;
	wire w40;
	wire w41;
	wire w42;
	wire w43;
	wire dff16_q;
	wire w44;
	wire w45;
	wire w46;
	wire w48;
	wire w49;
	wire dff17_q;
	wire w50;
	wire dff18_q;
	wire w51;
	wire w53;
	wire w54;
	wire vd8;
	wire w58;
	wire w59;
	wire w63;
	wire w64;
	wire w65;
	wire w66;
	wire w68;
	wire dff19_q;
	wire w69;
	wire w70;
	wire w71;
	wire w72;
	wire dff20_q, dff20_nq;
	wire w73;
	wire w74;
	wire w75;
	wire w76;
	wire w77;
	wire w78;
	wire w79;
	wire dff21_q;
	wire dff22_q;
	wire mreq_in;
	wire w83;
	wire w84;
	wire w86;
	wire dff23_q, dff23_nq;
	wire w90;
	wire w91;
	wire w92; // nc
	wire w94;
	wire w95;
	wire w96;
	wire w97;
	wire w99;
	wire w101;
	wire w102;
	wire w103;
	wire dff24_q, dff24_nq;
	wire dff25_q;
	wire ztov;
	wire w106;
	wire w107;
	wire w111;
	wire w112;
	wire w113;
	wire w118;
	wire w119;
	wire w122;
	wire w124;
	wire w126;
	wire w128;
	wire w129;
	wire w130;
	wire dff26_nq;
	wire dff27_q;
	wire w132;
	wire w133;
	wire w134;
	wire dff28_q;
	wire w136;
	wire w137;
	wire w140;
	wire w143;
	wire dff29_q;
	wire w146;
	wire w149;
	wire w150;
	wire test;
	wire w163;
	wire w164;
	wire w166;
	wire w167;
	wire dff30_q;
	wire w168;
	wire w169;
	wire w170;
	wire dff31_q;
	wire w171;
	wire w172;
	wire w173;
	wire w174;
	wire w175;
	wire w176;
	wire w178;
	wire w182;
	wire sres_syncv_q, sres_syncv_nq;
	wire dff33_q, dff33_nq;
	wire w183;
	wire w185;
	wire w188;
	wire w194;
	wire w197;
	wire w198;
	wire w199;
	wire w200;
	wire w202;
	wire w204;
	wire w206;
	wire w207;
	wire w208;
	wire w211;
	wire w215;
	wire w220;
	wire dff34_q;
	wire w222;
	wire w223;
	wire va22_cart;
	wire dff44_q, dff44_nq;
	wire w232;
	wire w234;
	wire w235;
	wire w238;
	wire w248;
	wire w249;
	wire w254;
	wire w255;
	wire w257;
	wire w258;
	wire w266;
	wire w268;
	wire w269;
	wire dff45_q, dff45_nq;
	wire dff46_q, dff46_nq;
	wire w271;
	wire dff47_q, dff47_nq;
	wire w272;
	wire w273;
	wire w274;
	wire w279;
	wire w283;
	wire w286;
	wire w287;
	wire w289;
	wire dff48_nq, dff48_cout;
	wire w298;
	wire dff49_q, dff49_nq;
	wire dff50_q, dff50_nq;
	wire dff51_q;
	wire w299;
	wire w300;
	wire w301;
	wire w302;
	wire dff52_q, dff52_nq;
	wire w307;
	wire w308;
	wire dff53_nq, dff53_cout;
	wire dff54_nq, dff54_cout;
	wire dff55_nq, dff55_cout;
	wire w309;
	wire w311;
	wire w314;
	wire w316;
	wire w318;
	wire w320;
	wire w321;
	wire w322;
	wire w325;
	wire w326;
	wire nmi_q;
	wire dff57_q;
	wire dff58_nq;
	wire dff59_q;
	wire w328;
	wire w331;
	wire w332;
	wire w333;
	wire dff60_q;
	wire w334;
	wire w336;
	wire w337;
	wire w339;
	wire dff61_q, dff61_nq;
	wire w341;
	wire w342;
	wire dff62_q;
	wire w343;
	wire dff63_q, dff63_nq;
	wire dff64_nq;
	wire w344;
	wire dff65_q, dff65_nq;
	wire dff66_q, dff66_nq;
	wire dff67_q, dff67_nq;
	wire dff68_q, dff68_nq;
	wire dff69_q, dff69_nq;
	wire w346;
	wire w348;
	wire dff70_q;
	wire dff71_q, dff71_nq;
	wire dff72_q, dff72_nq;
	wire dff73_q;
	wire dff74_q, dff74_nq;
	wire w354;
	wire dff75_nq;
	wire dff76_q, dff76_nq;
	wire dff77_nq, dff77_cout;
	wire w356;
	wire w362;
	wire w363;
	wire w372;
	wire dff78_nq, dff78_cout;
	wire w374;
	wire dff79_nq, dff79_cout;
	wire dff80_nq, dff80_cout;
	wire w383;
	
	wire fc00;
	wire fc01;
	wire fc10;
	wire fc11;
	
	wire va14_in;
	wire va21_in;
	wire va22_in;
	wire va23_in;
	
	wire za15_in;
	
	wire [8:0] z80bank_q;
	
	wire [15:0] va_out;
	
	reg edclk_buf;
	
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
				dff3 <= dff3 ^ dff2;
			end
		end
		
		edclk_buf <= w2;
	end
	
	assign w1 = ~(~dff1 & ~dff2 & ~dff3);
	assign w2 = dff3;
	assign w3 = dff2 & dff3;
	assign w4 = w2;
	assign w5 = ~(dff4_nq | dff5_nq | dff6_nq | dff7_nq);

	ym_scnt_bit dff4(.MCLK(MCLK), .clk(w4), .load(dff9_q), .val(1'h1), .cin(dff9_q), .rst(sres), .nq(dff4_nq), .cout(dff4_cout));
	ym_scnt_bit dff5(.MCLK(MCLK), .clk(w4), .load(dff9_q), .val(1'h0), .cin(dff4_cout), .rst(sres), .nq(dff5_nq), .cout(dff5_cout));
	ym_scnt_bit dff6(.MCLK(MCLK), .clk(w4), .load(dff9_q), .val(1'h0), .cin(dff5_cout), .rst(sres), .nq(dff6_nq), .cout(dff6_cout));
	ym_scnt_bit dff7(.MCLK(MCLK), .clk(w4), .load(dff9_q), .val(1'h0), .cin(dff6_cout), .rst(sres), .nq(dff7_nq));
	
	assign EDCLK = edclk_buf;
	
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
	
	ym_delaychain #(.DELAY_CNT(1)) d1(.MCLK(MCLK), .inp(M1), .outp(d1_out));
	ym_delaychain #(.DELAY_CNT(1)) d2(.MCLK(MCLK), .inp(w188), .outp(d2_out));
	ym_delaychain #(.DELAY_CNT(7)) d3(.MCLK(MCLK), .inp(w254), .outp(d3_out));
	ym_delaychain #(.DELAY_CNT(1)) d4(.MCLK(MCLK), .inp(w113), .outp(d4_out));
	ym_delaychain #(.DELAY_CNT(2)) d5(.MCLK(MCLK), .inp(w271), .outp(d5_out));
	ym_delaychain #(.DELAY_CNT(6)) d6(.MCLK(MCLK), .inp(w238), .outp(d6_out));
	ym_delaychain #(.DELAY_CNT(6)) d7(.MCLK(MCLK), .inp(w223), .outp(d7_out));
	ym_delaychain #(.DELAY_CNT(1)) d8(.MCLK(MCLK), .inp(M3), .outp(d8_out));
	
	// 
	
	assign w143 = ~M3 | w220 | ~ZA_i[15];
	assign w185 = w86 | w220;
	assign w188 = w185 & w143;
	ym_sdff dff34(.MCLK(MCLK), .clk(ZCLK), .val(d2_out), .q(dff34_q));
	assign w182 = w188 & dff34_q;
	assign w255 = ~(DTACK_i | w79);
	assign w258 = ~(w255 | pal_trap | w182);
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
	
	reg w45_mem;
	
	assign w45 = w46 & ztov;
	assign w46 = w45_mem | BGACK_i;
	
	always @(posedge MCLK)
	begin
		w45_mem <= w45;
	end
	
	assign w48 = ~w45;
	
	assign w163 = vd8 | mreq_in | va22_in | M3;
	assign w68 = ~(vd8 | w163);
	assign VDPM = ~w68;
	
	assign w16 = ~(dff33_nq | w346);
	ym_sdffr dff60(.MCLK(MCLK), .clk(~w16), .val(dff69_q), .reset(sres_syncv_q), .q(dff60_q));
	assign w334 = ~(dff60_q | dff69_nq);
	
	assign w337 = ~WRES;
	
	ym_sdffr dff68(.MCLK(MCLK), .clk(~w16), .val(dff68_nq), .reset(~sres_syncv_nq), .q(dff68_q), .nq(dff68_nq));
	ym_sdffr dff71(.MCLK(MCLK), .clk(~dff68_q), .val(dff71_nq), .reset(~sres_syncv_nq), .q(dff71_q), .nq(dff71_nq));
	ym_sdffr dff72(.MCLK(MCLK), .clk(~dff71_q), .val(dff72_nq), .reset(~sres_syncv_nq), .q(dff72_q), .nq(dff72_nq));
	ym_sdffr dff76(.MCLK(MCLK), .clk(~dff72_q), .val(dff76_nq), .reset(~sres_syncv_nq), .q(dff76_q), .nq(dff76_nq));
	assign w362 = w363 | dff76_q;
	ym_sdffr dff63(.MCLK(MCLK), .clk(~w362), .val(dff63_nq), .reset(~sres_syncv_nq), .q(dff63_q), .nq(dff63_nq));
	ym_sdffr dff52(.MCLK(MCLK), .clk(~dff63_q), .val(dff52_nq), .reset(~sres_syncv_nq), .q(dff52_q), .nq(dff52_nq));
	ym_sdffr dff65(.MCLK(MCLK), .clk(~dff52_q), .val(dff65_nq), .reset(~sres_syncv_nq), .q(dff65_q), .nq(dff65_nq));
	ym_sdffr dff67(.MCLK(MCLK), .clk(~dff65_q), .val(dff67_nq), .reset(~sres_syncv_nq), .q(dff67_q), .nq(dff67_nq));
	ym_sdffr dff74(.MCLK(MCLK), .clk(~dff67_q), .val(dff74_nq), .reset(sres_syncv_q), .q(dff74_q), .nq(dff74_nq));
	
	ym_sdffs nmi(.MCLK(MCLK), .clk(dff74_q), .val(va23_in), .set(w332), .q(nmi_q));
	ym_sdffr dff57(.MCLK(MCLK), .clk(dff74_q), .val(sres_syncv_q), .reset(sres_syncv_q), .q(dff57_q));
	ym_sdffr dff58(.MCLK(MCLK), .clk(dff74_q), .val(dff57_q), .reset(sres_syncv_q), .nq(dff58_nq));
	ym_sdffr dff69(.MCLK(MCLK), .clk(dff74_q), .val(w337), .reset(sres_syncv_q), .q(dff69_q), .nq(dff69_nq));
	assign w328 = ~(dff58_nq | w334);
	
	assign w113 = IORQ | M3 | ~M1;
	ym_sdff dff29(.MCLK(MCLK), .clk(ZCLK), .val(d4_out), .q(dff29_q));
	assign w112 = w113 & dff29_q;
	
	ym_sdff dff27(.MCLK(MCLK), .clk(ZCLK), .val(d1_out), .q(dff27_q));
	ym_sdff dff30(.MCLK(MCLK), .clk(ZCLK), .val(dff27_q), .q(dff30_q));
	assign w199 = dff30_q;
	assign w207 = w199;
	ym_sdff dff44(.MCLK(MCLK), .clk(~ZCLK), .val(w207), .q(dff44_q), .nq(dff44_nq));
	
	assign w220 = mreq_in | dff44_nq;
	
	assign NMI = nmi_q;
	
	assign w316 = ~(~M3 | dff70_q);
	
	assign w320 = ~(~M3 | dff44_q | mreq_in);
	assign w318 = w316 | w320;
	assign REF = ~w318;
	
	assign w63 = ~(w99 & ~w122 & ~UDS_i);
	assign w12 = test | ~RW_i | w63;
	assign w36 = w63 | RW_i;
	ym_sdffr zbr(.MCLK(MCLK), .clk(w36), .val(vd8), .reset(sres_syncv_q), .nq(zbr_nq));
	assign w33 = ZBAK;
	assign w34 = w33 | zbr_nq;
	assign ZBR = zbr_nq;
	
	assign w257 = ~(LDS_i & UDS_i);
	ym_sdff dff59(.MCLK(MCLK), .clk(VCLK), .val(w257), .q(dff59_q));
	assign w331 = w257 & dff66_nq & dff59_q;
	assign MREQ_o = ~w331;
	
	assign w66 = w119 | AS_i;
	
	assign w354 = ~(w339 & dff70_q);
	ym_sdff dff75(.MCLK(MCLK), .clk(~VCLK), .val(w354), .nq(dff75_nq));
	assign w348 = ~(w339 & dff70_q & dff75_nq);
	ym_sdff dff66(.MCLK(MCLK), .clk(~VCLK), .val(w348), .q(dff66_q), .nq(dff66_nq));
	ym_sdff dff73(.MCLK(MCLK), .clk(VCLK), .val(AS_i), .q(dff73_q));
	assign w344 = dff66_q | AS_i | dff73_q;
	ym_sdff dff64(.MCLK(MCLK), .clk(VCLK), .val(w344), .nq(dff64_nq));
	assign w341 = ~(dff64_nq & w336);
	assign w134 = w66 | w341;
	
	assign vtoz = w119 | test | w33;
	
	assign w308 = ~(w287 | w343);
	assign w307 = ~(w308 | sres_syncv_nq);
	assign w272 = ~(dff47_q | AS_i);
	assign w273 = ~(w272 | w307);
	assign w164 = ~(w34 & w166);
	ym_sdffs dff47(.MCLK(MCLK), .clk(~VCLK), .val(w273), .set(w164), .q(dff47_q), .nq(dff47_nq));
	assign w339 = ~(AS_i & dff47_nq);
	ym_sdff dff70(.MCLK(MCLK), .clk(~VCLK), .val(w339), .q(dff70_q));
	
	assign w249 = ~(ztov & fc11);
	assign INTAK = w249;
	
	assign VPA = AS_i | w249;
	
	assign w73 = sres_syncv_q & M3;
	
	ym_sdffr dff26(.MCLK(MCLK), .clk(w97), .val(vd8), .reset(sres_syncv_q), .nq(dff26_nq));
	assign w274 = ~CAS0;
	ym_sdffs dff45(.MCLK(MCLK), .clk(w274), .val(va23_in), .set(~w223), .q(dff45_q));
	assign w269 = dff45_q & va23_in & w274;
	assign w248 = w223 | w269;
	assign w208 = dff26_nq ? w248 : w254;
	assign w202 = w208 | ~va22_cart;
	assign w170 = dff26_nq | d5_out;
	assign w167 = w170 & w202;
	assign w211 = ~M3 | AS_i | va23_in;
	assign w72 = dff15_nq | w43;
	assign w132 = w72 | w211;
	assign w69 = ~(w44 | dff12_nq);
	assign w168 = ~(w69 | dff26_nq);
	assign w169 = w168 | w211 | ~va22_cart;
	
	ym_sdffr dff25(.MCLK(MCLK), .clk(~VCLK), .val(dff12_nq), .reset(w73), .q(dff25_q));
	assign w101 = ~(dff20_nq | dff25_q);
	assign w173 = w101 | dff26_nq;
	assign w171 = za15_in | w220 | M3;
	assign w172 = ~(w169 & w167 & w171 & w173);
	assign CE0 = ~w172;
	
	assign w301 = ~(w223 & d7_out);
	assign w298 = w301 & va23_in;
	ym_sdffs dff46(.MCLK(MCLK), .clk(w274), .val(dff46_nq), .set(w298), .q(dff46_q), .nq(dff46_nq));
	assign w271 = dff46_q | d6_out;
	
	assign w254 = w223 | va23_in;
	assign w206 = ~va21_in | va22_cart | w254;
	assign w238 = CAS0 | w223;
	assign w204 = ~(~w211 & w69 & ~va22_cart & va21_in);
	assign w197 = w206 & d5_out;
	assign w198 = ~(w197 & w101 & w204);
	assign RAS2 = ~w198;
	
	assign w234 = va22_cart | va21_in | w211;
	assign va22_cart = ~(va22_in ^ CART);
	assign w232 = va22_cart | w248 | va21_in;
	assign w235 = ~(w234 & w232);
	assign ROM = ~w235;
	assign w107 = ~(ZA_i[15:14] == 2'h2 & ~w220 & ~M3);
	assign w102 = ~(w70 & w107 & w238);
	assign CAS2 = ~w102;
	
	assign w64 = ~(w43 & d3_out);
	assign ASEL = ~w64;
	
	assign w59 = ~M3 | AS_i;
	assign w54 = ~(dff23_q & va23_in);
	assign w84 = ~(dff23_nq & dff33_nq & w356);
	assign w58 = w54 & w84;
	ym_sdffs dff17(.MCLK(MCLK), .clk(VCLK), .val(w58), .set(w73), .q(dff17_q));
	assign w49 = dff17_q;
	assign w74 = w49;
	ym_sdffs dff20(.MCLK(MCLK), .clk(~VCLK), .val(w74), .set(w73), .q(dff20_q), .nq(dff20_nq));
	assign w71 = dff20_q & w74;
	
	ym_sdffs dff19(.MCLK(MCLK), .clk(~VCLK), .val(w71), .set(w73), .q(dff19_q));
	assign w42 = ~(dff19_q & w71);
	assign w44 = w42 | va23_in | w59;
	ym_sdff dff16(.MCLK(MCLK), .clk(VCLK), .val(w44), .q(dff16_q));
	assign w43 = w44 | dff16_q;
	ym_sdff dff11(.MCLK(MCLK), .clk(~VCLK), .val(w43), .q(dff11_q));
	assign w27 = dff11_q | w44;
	
	assign w41 = w27 | dff15_q;
	ym_sdff dff12(.MCLK(MCLK), .clk(~VCLK), .val(w41), .q(dff12_q), .nq(dff12_nq));
	assign w26 = ~(dff15_nq & dff12_q);
	assign w83 = dff23_nq | va23_in;
	assign w40 = w26 & w83;
	ym_sdffs dff15(.MCLK(MCLK), .clk(VCLK), .val(w40), .set(w73), .q(dff15_q), .nq(dff15_nq));
	
	assign w70 = w27 & w71;
	
	
	assign w286 = ~(w287 | sres_syncv_nq);
	assign w289 = w286;
	assign w372 = w289 & 1'h1 & 1'h1;
	
	ym_scnt_bit dff78(.MCLK(MCLK), .clk(VCLK), .load(w289), .val(1'h0), .cin(w372), .rst(1'h1), .nq(dff78_nq), .cout(dff78_cout));
	ym_scnt_bit dff80(.MCLK(MCLK), .clk(VCLK), .load(w289), .val(1'h0), .cin(dff78_cout), .rst(1'h1), .nq(dff80_nq), .cout(dff80_cout));
	ym_scnt_bit dff79(.MCLK(MCLK), .clk(VCLK), .load(w289), .val(1'h0), .cin(dff80_cout), .rst(1'h1), .nq(dff79_nq), .cout(dff79_cout));
	ym_scnt_bit dff77(.MCLK(MCLK), .clk(VCLK), .load(w289), .val(1'h0), .cin(dff79_cout), .rst(1'h1), .nq(dff77_nq), .cout(dff77_cout));
	assign w374 = ~(dff77_nq | dff78_nq | dff79_nq | dff80_nq);
	assign w356 = w374 & 1'h1;
	
	assign w266 = w289 & w356 & w356;
	ym_scnt_bit dff48(.MCLK(MCLK), .clk(VCLK), .load(w289), .val(1'h0), .cin(w266), .rst(1'h1), .nq(dff48_nq), .cout(dff48_cout));
	ym_scnt_bit dff54(.MCLK(MCLK), .clk(VCLK), .load(w289), .val(1'h0), .cin(dff48_cout), .rst(1'h1), .nq(dff54_nq), .cout(dff54_cout));
	ym_scnt_bit dff53(.MCLK(MCLK), .clk(VCLK), .load(w289), .val(1'h0), .cin(dff54_cout), .rst(1'h1), .nq(dff53_nq), .cout(dff53_cout));
	ym_scnt_bit dff55(.MCLK(MCLK), .clk(VCLK), .load(w289), .val(M3), .cin(dff53_cout), .rst(1'h1), .nq(dff55_nq), .cout(dff55_cout));
	assign w309 = ~(dff48_nq | dff53_nq | dff54_nq | dff55_nq);
	assign w287 = w309 & w356;
	
	assign w183 = ~(dff33_q | dff23_q | w356 | ~w223);
	assign w283 = ~(w183 | w287 | w343);
	ym_sdffs dff33(.MCLK(MCLK), .clk(VCLK), .val(w283), .set(sres_syncv_q), .q(dff33_q), .nq(dff33_nq));
	ym_sdffr dff23(.MCLK(MCLK), .clk(~w59), .val(dff33_nq), .reset(dff33_nq), .q(dff23_q), .nq(dff23_nq));
	
	
	assign ZRD_o = AS_i | ~RW_i;
	
	assign ZV = ztov;
	
	ym_sdff dff13(.MCLK(MCLK), .clk(~VCLK), .val(UDS_i), .q(dff13_q));
	assign w65 = ~(dff13_q & UDS_i);
	assign w31 = ~w65;
	
	assign sres = SRES;
	
	assign ZWR_o = RW_i | AS_i;
	
	assign vd8 = VD8_i;
	
	assign mreq_in = MREQ_i;
	
	assign w95 = ~(UDS_i | RW_i);
	
	assign w96 = ~(w95 & w90 & ~w122);
	
	assign w97 = ~(w95 & w91 & ~w122);
	
	assign w130 = AS_i | w129;
	assign w103 = ~(dff24_q | RW_i | w130);
	ym_sdff dff24(.MCLK(MCLK), .clk(VCLK), .val(w103), .q(dff24_q), .nq(dff24_nq));
	assign FDC = w130;
	assign FDWR = dff24_nq;
	
	assign w94 = w128 | AS_i;
	assign w75 = ~(w112 & w94);
	assign IO = ~w75;
	
	assign SOUND = w140;
	
	assign w126 = w124 | AS_i;
	assign TIME = w126;
	
	assign w131 = ztov | test | pal_trap;
	
	assign w137 = ~(w106 | test | pal_trap);
	
	assign w142 = ~w137;
	
	assign test = test_mode_0;
	
	ym_sdffr dff31(.MCLK(MCLK), .clk(w96), .val(vd8), .reset(w328), .q(dff31_q));
	assign w166 = M3 ? dff31_q : w328;
	
	ym_sdff sres_syncv(.MCLK(MCLK), .clk(VCLK), .val(SRES), .q(sres_syncv_q), .nq(sres_syncv_nq));
	
	assign RW_o = ZWR_i;
	
	assign w118 = w122 | AS_i;
	assign w133 = ~(w132 & w118 & w130 & w126 & w94 & w134);
	assign w200 = ~(w133 & w249);
	assign w222 = ~(w200 | test);
	assign DTACK_o = ~w222;
	
	assign w215 = va21_in | mreq_in;
	
	assign w223 = w48 | BGACK_i | ~M3;
	
	assign ZRES = w166;
	
	assign w336 = WAIT_i;
	
	assign w311 = ~(M3 & w328);
	assign VRES = ~w311;
	
	assign w343 = ~(~fc00 | d8_out);
	assign w363 = ~(~fc01 | d8_out);
	assign w346 = ~(~fc10 | d8_out);
	assign w332 = ~(w333 | d8_out);
	assign w333 = ~(d8_out | sres_syncv_q);
	
	assign w353 = w194;
	
	assign fc00 = ~FC1 & ~FC0;
	assign fc01 = ~FC1 & FC0;
	assign fc10 = FC1 & ~FC0;
	assign fc11 = FC1 & FC0;
	
	assign ZRAM = w136;
	
	assign va14_in = VA_i[13];
	
	assign va21_in = VA_i[20];
	
	assign va22_in = VA_i[21];

	assign va23_in = VA_i[22];
	
	assign ZA0_o = w31;
	
	assign ZA_o[15:8] = { 1'h0, VA_i[13:7] };
	
	assign VZ = vtoz;
	
	assign za15_in = ZA_i[15];
	
	ym_sdffr #(.DATA_WIDTH(9)) z80bank(.MCLK(MCLK), .clk(w150), .val({ ZD0_i, z80bank_q[8:1] }),
		.reset(sres_syncv_q), .q(z80bank_q));
	
	wire [15:0] va_out_t = M3 ? { w86 ? z80bank_q : 9'h180, ZA_i[14:8] } : { 3'h0, w166, IORQ, mreq_in, w215, ZA_i[15:7] };
	
	assign va_out = w86 ? va_out_t : {va_out_t[15:8], 8'h0};
	
	assign w91 = VA_i[8:7] == 2'h0;
	assign w99 = VA_i[8:7] == 2'h1;
	assign w90 = VA_i[8:7] == 2'h2;
	assign w92 = VA_i[8:7] == 2'h3;
	
	assign w194 = AS_i | LDS_i | UDS_i | VA_i[22:7] != 16'ha140;
	assign w310 = ~(VA_i[22:7] == 16'hc000 & ~AS_i);
	
	assign w119 = ~(M3 & VA_i[22:15] == 8'ha0);
	
	assign w128 = ~(M3 & VA_i[22:7] == 16'ha100);
	
	assign w122 = ~(M3 & VA_i[22:9] == 14'h2844);
	
	assign w129 = ~(M3 & VA_i[22:7] == 16'ha120);
	
	assign w124 = ~(M3 & VA_i[22:7] == 16'ha130);
	
	assign w136 = ~(ZA_i[15:14] == 2'h0 & ~w220 & M3);
	
	assign w140 = ~(ZA_i[15:13] == 3'h2 & ~w220 & M3);
	
	assign w150 = ~(M3 & ZA_i[15:8] == 8'h60 & ~ZWR_i & ~w220);
	
	assign w86 = ~(ZA_i[15:8] == 8'h7f & M3);
	
	assign IA14 = ~(M3 & va14_in);
	
	assign VA_o[22:7] = va_out;
	
	assign VD8_o = w33;
	
endmodule

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
	assign w5 = ~(dff4_nq | dff5_nq | dff6_nq | dff7_nq);

	ym_scnt_bit dff4(.MCLK(MCLK), .clk(w4), .load(dff9_q), .val(1'h1), .cin(dff9_q), .rst(sres), .nq(dff4_nq), .cout(dff4_cout));
	ym_scnt_bit dff5(.MCLK(MCLK), .clk(w4), .load(dff9_q), .val(1'h0), .cin(dff4_cout), .rst(sres), .nq(dff5_nq), .cout(dff5_cout));
	ym_scnt_bit dff6(.MCLK(MCLK), .clk(w4), .load(dff9_q), .val(1'h0), .cin(dff5_cout), .rst(sres), .nq(dff6_nq), .cout(dff6_cout));
	ym_scnt_bit dff7(.MCLK(MCLK), .clk(w4), .load(dff9_q), .val(1'h0), .cin(dff6_cout), .rst(sres), .nq(dff7_nq));
	
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
	ym_sdffr dff60(.MCLK(MCLK), .clk(~w16), .val(dff69_q), .reset(sres_syncv_q), .nq(dff60_nq));
	assign w334 = ~(~dff60_q | dff69_nq);
	
	assign w337 = ~WRES;
	
	ym_sdffr dff68(.MCLK(MCLK), .clk(~w16), .val(dff68_nq), .reset(~sres_syncv_nq), .q(dff68_q), .nq(dff68_nq));
	ym_sddfr dff71(.MCLK(MCLK), .clk(~dff68_q), .val(dff71_nq), .reset(~sres_syncv_nq), .q(dff71_q), .nq(dff71_nq));
	ym_sddfr dff72(.MCLK(MCLK), .clk(~dff71_q), .val(dff72_nq), .reset(~sres_syncv_nq), .q(dff72_q), .nq(dff72_nq));
	ym_sddfr dff76(.MCLK(MCLK), .clk(~dff72_q), .val(dff76_nq), .reset(~sres_syncv_nq), .q(dff76_q), .nq(dff76_nq));
	assign w362 = w363 | dff76_q;
	ym_sdffr dff63(.MCLK(MCLK), .clk(~ww362), .val(dff63_nq), .reset(~sres_syncv_nq), .q(dff63_q), .nq(dff63_nq));
	ym_sdffr dff52(.MCLK(MCLK), .clk(~dff63_q), .val(dff52_nq), .reset(~sres_syncv_nq), .q(dff52_q), .nq(dff52_nq));
	ym_sdffr dff65(.MCLK(MCLK), .clk(~dff52_q), .val(dff65_nq), .reset(~sres_syncv_nq), .q(dff65_q), .nq(dff65_nq));
	ym_sdffr dff67(.MCLK(MCLK), .clk(~dff65_q), .val(dff67_nq), .reset(~sres_syncv_nq), .q(dff67_q), .nq(dff67_nq));
	ym_sdffr dff74(.MCLK(MCLK), .clk(~dff67_q), .val(dff74_nq), .reset(sres_syncv_2), .q(dff74_q), .nq(dff74_nq));
	
	ym_sdffs nmi(.MCLK(MCLK), .clk(dff74_q), .val(va23_in), .set(w332), .q(nmi_q));
	ym_sdffr dff57(.MCLK(MCLK), .clk(dff74_q), .val(sres_syncv_2), .reset(sres_syncv_q), .q(dff57_q));
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
	
	assign NMI_o = nmi_q;
	
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
	assign w211 = ~M3 | AS_i | va23_i;
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
	
	assign w234 = va22_cart | va21 | w211;
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
	
	
	assign w286 = ~(w287 | sre_syncv_nq);
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
	ym_sdffs dff33(.MCLK(MCLK), .clk(VCLK), .val(w383), .set(sres_syncv_q), .q(dff33_q), .nq(dff33_nq));
	ym_sdffr dff23(.MCLK(MCLK), .clk(~w59), .val(dff33_nq), .reset(dff23_nq), .q(dff23_q), .nq(dff23_nq));
	
	ym_sdff sres_syncv(.MCLK(MCLK), .clk(VCLK), .val(SRES), .q(sres_syncv_q), .nq(sres_syncv_nq));
	
	
endmodule

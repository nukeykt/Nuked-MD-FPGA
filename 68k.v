/*
 * Copyright (C) 2022-2023 nukeykt
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
 *  68000 emulator.
 *  Thanks:
 *      John McMaster (siliconpr0n.org):
 *          68000 decap and die shot.
 *      Olivier Galibert:
 *          68000 schematics.
 *      org, andkorzh, HardWareMan (emu-russia):
 *          help & support.
 *
 */
module m68kcpu
	(
	input MCLK,
	input CLK,
	input VPA,
	input BR,
	input BGACK,
	input DTACK,
	input DATA,
	input VPA_TEST,
	inout [2:0] IPL,
	inout BERR,
	inout RESET,
	inout HALT,
	inout [15:0] DATA,
	output E_CLK,
	output BG,
	output [2:0] FC,
	output RW,
	output [23:1] ADDRESS,
	output AS,
	output LDS,
	output UDS
	);
	
	reg w1;
	reg l1;
	reg l2;
	reg w2;
	reg l3;
	reg l4;
	wire w3;
	wire w4;
	wire w5;
	wire w6;
	wire w7;
	wire w8;
	wire w9;
	wire w10;
	wire w11;
	wire w12;
	wire w13;
	wire w14;
	wire w15;
	wire w16;
	wire w17;
	wire w18;
	wire w19;
	wire w20;
	wire w21;
	wire w22;
	wire w23;
	wire w24;
	wire w25;
	wire w26;
	wire w27;
	wire w28;
	wire w29;
	wire w30;
	wire w31;
	wire w32;
	wire w33;
	wire w34;
	wire w35;
	wire w36;
	wire w37;
	wire w38;
	wire w39;
	wire w40;
	wire w41;
	wire w42;
	wire w55;
	wire w56;
	wire w57;
	wire w58;
	wire w59;
	wire w60;
	wire w61;
	reg w62;
	reg w63;
	reg w64;
	reg w65;
	reg w66;
	reg w67;
	reg w68;
	reg w69;
	reg w70;
	reg w71;
	reg w72;
	reg w73;
	wire w74;
	reg w75;
	wire w76;
	reg w76;
	wire w77;
	wire w78;
	wire w79;
	wire w80;
	wire w81;
	wire w82;
	wire w83;
	wire w84;
	wire w85;
	wire w86;
	wire w87;
	wire w88;
	wire w89;
	wire w90;
	wire w91;
	wire w92;
	wire w93;
	wire w94;
	wire w95;
	reg l5;
	wire w96;
	wire w97;
	wire w98;
	wire w99;
	wire w100;
	reg l6;
	reg l7;
	reg l8;
	reg l9;
	reg l10;
	reg w101;
	reg w102;
	reg w103;
	wire w104;
	reg w105;
	wire w106;
	reg [15:0] w107;
	wire [7:0] w108;
	reg [15:0] w109;
	reg [15:0] w110;
	wire [15:0] w114;
	wire addr_carry;
	wire w123;
	wire w124;
	wire w125;
	wire w126;
	reg w127;
	reg w128;
	wire [15:0] w132;
	wire [15:0] w145;
	reg [15:0] w147;
	reg l11;
	wire w148;
	wire w149;
	wire w150;
	wire w151;
	wire w152;
	wire w153;
	wire w154;
	wire w155;
	wire w156;
	wire w157;
	reg [15:0] w158;
	wire [15:0] w159;
	wire w160;
	wire w161;
	wire w162;
	wire w163;
	wire w164;
	wire w165;
	wire w166;
	wire w167;
	wire w168;
	reg [15:0] w169;
	wire w170;
	reg [15:0] w171;
	wire [15:0] w172;
	wire w173;
	wire w174;
	wire w175;
	wire w176;
	wire w177;
	wire w178;
	wire w179;
	wire w180;
	wire w181;
	wire w183;
	wire w184;
	wire w185;
	wire w186;
	wire w187;
	wire w188;
	wire w189;
	wire w190;
	wire w191;
	wire w192;
	wire w193;
	wire w184;
	wire w195;
	wire w196;
	wire w197;
	wire w198;
	wire w199;
	wire w200;
	wire w201;
	wire w202;
	wire w203;
	wire w204;
	wire w205;
	wire w206;
	wire w207;
	wire w208;
	wire w209;
	wire w210;
	wire w211;
	wire w212;
	wire w213;
	wire w214;
	wire w215;
	wire w216;
	wire w217;
	wire w218;
	wire w219;
	wire w220;
	wire w221;
	wire w222;
	wire w223;
	wire w224;
	wire w225;
	wire w226;
	wire w227;
	wire w228;
	reg w229;
	wire w230;
	reg w231;
	reg w232;
	wire w235;
	reg w238;
	wire w239;
	wire w240;
	wire w241;
	wire w242;
	wire w243;
	wire w244;
	wire w245;
	wire w246;
	wire w247;
	wire w248;
	wire w249;
	wire w250;
	wire w251;
	wire w252;
	wire w253;
	wire w254;
	wire w255;
	wire w256;
	wire w257;
	reg w258;
	reg [3:0] w259[0:1];
	reg w260;
	reg w261_0;
	reg w261_1;
	reg w262;
	reg w263;
	reg w264;
	wire w265;
	wire w266;
	reg w267;
	reg w268[0:2];
	reg w269[0:2];
	reg [2:0] w270[0:1];
	reg w273;
	reg w274;
	reg w275[0:2];
	reg w276[0:2];
	reg w277[0:5];
	reg w278;
	reg _w279_0, _w379_2;
	wire _w279_1, _w379_3;
	reg w280_mem;
	wire w280;
	reg _w281_0, _w281_2;
	wire _w281_1, _w281_3;
	reg w282_mem, w282_n_mem;
	wire w282, w282_n;
	reg _w284_0, _w284_1;
	wire _w284_1, _w284_3;
	wire w285;
	reg w285_mem;
	wire w286;
	reg w287;
	wire w288;
	reg w289;
	reg w290;
	wire w291;
	reg w292;
	wire w293;
	reg w294[0:1];
	wire w295;
	reg w296[0:3];
	reg w297[0:3];
	reg w298[0:3];
	reg w299;
	wire w300;
	reg w301;
	wire w302;
	reg w303
	wire w304;
	wire w305;
	wire w306;
	wire w307;
	reg w308;
	wire w309;
	wire w310;
	wire w311;
	reg w312;
	wire w313;
	reg w314;
	wire w316;
	reg w315[0:1];
	reg w317;
	wire w318;
	
	reg [67:0] w529;
	
	wire [17:0] w597;
	
	reg [15:0] b1[0:3];
	reg [15:0] b2[0:3];
	reg [15:0] b3[0:3];
	
	wire c1;
	wire c2;
	wire c3;
	wire c4;
	wire c5;
	wire c6;
	
	reg o_e;
	reg o_bg;
	
	assign E = o_e;
	assign BG = o_bg;
	
	wire clk1 = ~CLK;
	wire clk2 = CLK;
	
	
	always @(posedge MCLK)
	begin
		if (c1)
		begin
			l1 <= ~w529[60];
			l2 <= ~w529[59];
			l3 <= ~w529[62];
			l4 <= ~w529[61];
		end
		if (l1 & l2)
			w1 <= 1'h0;
		else if (~l1)
			w1 <= c3;
		else if (~l2)
			w1 <= c2;
		if (l3 & l4)
			w2 <= 1'h0;
		else if (~l3)
			w2 <= c3;
		else if (~l4)
			w2 <= c2;
	end
	
	wire v1_1 = w42 & ~w67 & ~w66;
	wire v2_1 = ~w63 & w62 & w39;
	
	assign w3 = (v1_1 & ~w65) ? w1 : 1'h0;
	assign w4 = (v2_1 & ~w64) ? w2 : 1'h0;
	assign w5 = (v2_1 & w64) ? w2 : 1'h0;
	assign w6 = (v1_1 & w65) ? w1 : 1'h0;
	
	wire v1_2 = w42 & ~w67 & w66;
	wire v2_2 = w63 & ~w62 & w39;
	
	assign w7 = (v1_2 & ~w65) ? w1 : 1'h0;
	assign w8 = (v2_2 & ~w64) ? w2 : 1'h0;
	assign w9 = (v2_2 & w64) ? w2 : 1'h0;
	assign w10 = (v1_2 & w65) ? w1 : 1'h0;
	
	wire v1_3 = w42 & w67 & ~w66;
	wire v2_3 = ~w63 & w62 & w39;
	
	assign w11 = (v1_3 & ~w65) ? w1 : 1'h0;
	assign w12 = (v2_3 & ~w64) ? w2 : 1'h0;
	assign w13 = (v2_3 & w64) ? w2 : 1'h0;
	assign w14 = (v1_3 & w65) ? w1 : 1'h0;
	
	wire v1_4 = w42 & w67 & w66;
	wire v2_4 = w63 & w62 & w39;
	
	assign w15 = (v1_4 & ~w65) ? w1 : 1'h0;
	assign w16 = (v2_4 & ~w64) ? w2 : 1'h0;
	assign w17 = (v2_4 & w64) ? w2 : 1'h0;
	assign w18 = (v1_4 & w65) ? w1 : 1'h0;
	
	wire v1_5 = w41 & ~w67 & ~w66;
	wire v2_5 = ~w63 & ~w62 & w40;
	
	assign w19 = (v1_5 & ~w65) ? w1 : 1'h0;
	assign w20 = (v2_5 & ~w64) ? w2 : 1'h0;
	assign w21 = (v2_5 & w64) ? w2 : 1'h0;
	assign w22 = (v1_5 & w65) ? w1 : 1'h0;
	
	wire v1_6 = ~w67 & w41 & w66;
	wire v2_6 = w63 & ~w62 & w40;
	
	assign w23 = (v1_5 & ~w65) ? w1 : 1'h0;
	assign w24 = (v2_5 & ~w64) ? w2 : 1'h0;
	assign w25 = (v2_5 & w64) ? w2 : 1'h0;
	assign w26 = (v1_5 & w65) ? w1 : 1'h0;
	
	wire v1_6 = w41 & w67 & ~w66;
	wire v2_6 = ~w63 & w62 & w40;
	
	assign w27 = (v1_6 & ~w65) ? w1 : 1'h0;
	assign w28 = (v2_6 & ~w64) ? w2 : 1'h0;
	assign w29 = (v2_6 & w64) ? w2 : 1'h0;
	assign w30 = (v1_6 & w65) ? w1 : 1'h0;
	
	wire v1_7 = w41 & w67 & w66;
	wire v2_7 = w63 & w62 & w40;
	
	assign w31 = (v1_7 & ~w65) ? w1 : 1'h0;
	assign w32 = (v2_7 & ~w64) ? w2 : 1'h0;
	assign w33 = (v2_7 & w64 & w634) ? w2 : 1'h0;
	assign w34 = (v1_7 & w65 & w634) ? w1 : 1'h0;
	assign w35 = (v1_7 & w65 & w88) ? w1 : 1'h0;
	assign w36 = (v2_7 & w64 & w88) ? w2 : 1'h0;
	
	assign w37 = (~w55 & ~w77) ? w2 : 1'h0;
	assign w38 = (~w58 & ~w75) ? w1 : 1'h0;
	
	assign w39 = ~w57 & ~w73;
	assign w40 = ~w57 & w73;
	assign w41 = w68 & ~w60;
	assign w42 = ~w68 & ~w60;
	
	assign w55 = ~w72;
	assign w56 = ~(w71 | w77);
	assign w57 = w71 | w72 | w77;
	
	assign w58 = ~w70;
	assign w59 = ~(w69 | w75);
	assign w60 = w69 | w70 | w75;
	
	assign w61 = ~w529[45];
	
	always @(posedge MCLK)
	begin
		if (c1)
		begin
			w64 <= w61 ? w653 : w626[0];
			w63 <= w61 ? w654 : w626[1];
			w73 <= w61 ? w651 : w626[3];
			w62 <= w61 ? w655 : w626[2];
			w65 <= w61 ? w626[0] : w653;
			w66 <= w61 ? w626[1] : w654;
			w68 <= w61 ? w626[3] : w651;
			w67 <= w61 ? w626[2] : w655;
			w69 <= w61 ? 1'h0 : w631;
			w70 <= w61 ? w629 : w630;
			w71 <= w61 ? w631 : 1'h0;
			w72 <= w61 ? w630 : w629;
		end
	end
	
	assign w74 = ~w529[66];
	assign w76 = ~w529[67];
	
	always @(posedge MCLK)
	begin
		if (c1)
		begin
			w75 <= ~(w74 | w529[67]);
			w77 <= ~(w529[66] | w76);
		end
	end
	
	assign w78 = ~(w74 | w76);
	
	assign w79 = w637 ? 1'h0 : c2;
	
	assign w80 = w81 ? c2 : 1'h0;
	
	assign w81 = ~(w529[63] | ~w529[64]);
	
	assign w82 = w83 ? c2 : 1'h0;
	
	assign w83 = ~(~w529[63] | w529[64]);
	
	assign w84 = w85 ? c2 : 1'h0;
	
	assign w85 = ~(~w529[63] | ~w529[64]);
	
	assign w86 = w56 ? 1'h0 : w2;
	
	assign w87 = w59 ? 1'h0 : w1;
	
	assign w88 = ~w634;
	
	assign w89 = ~(~w529[46] : w529[47]);
	assign w90 = ~(~w529[46] : ~w529[47]);
	assign w91 = ~(w529[46] : ~w529[47]);
	
	assign w92 = w90 ? c2 : 1'h0;
	assign w93 = w91 ? c2 : 1'h0;
	assign w94 = w89 ? c2 : 1'h0;
	
	always @(posedge MCLK)
	begin
		if (c1)
			l5 <= ~w529[48];
	end
	
	assign w95 = c1 ? 1'h0 : (l5 ? c3 : 1'h0);
	
	assign w96 = w643;
	assign w97 = ~w643;
	
	assign w98 = ~w639;
	assign w99 = w103;
	assign w100 = w105;
	
	always @(posedge MCLK)
	begin
		if (c1)
		begin
			l6 <= w529[57];
			l7 <= ~w529[58];
			l8 <= w529[57];
			l9 <= w636;
			l10 <= w529[57];
		end
		
		if (l7)
			w101 <= 1'h0;
		else
		begin
			if (~l6)
				w101 <= c3;
			if (l8)
				w101 <= c2;
		end
		
		if (l9)
			w102 <= 1'h0;
		else
		begin
			if (~l10)
				w102 <= c3;
			if (l8)
				w102 <= c2;
		end
		
		if (c1)
		begin
			w103 <= ~w529[55];
			w105 <= ~w529[54];
		end
	end
	
	assign w104 = w103 ? c6 : 1'h0;
	assign w106 = w105 ? c6 : 1'h0;
	
	always @(posedge MCLK)
	begin
		if (w95)
			w109 = ~w114;
	end
	
	always @(posedge MCLK)
	begin
		if (w80)
			w107 <= ~b1[3];
		else if (w82)
			w107 <= ~b1[1];
		else if (w84)
			w107 <= w109;
	end
	
	assign w108 = ~w107[7:0];
	
	always @(posedge MCLK)
	begin
		if (w97)
			w110 <= w98 ? 16'hffff : 16'h0;
		else if (w96)
			w110 <= b1[3];
	end
	
	// replace carry look-ahead circuit with simple add
	assign w114 = ~w110 + ~b1[1] + addr_carry;
	
	assign w123 = c1 ? 1'h0 : ~(w100 | b2[2][15]);
	assign w124 = c1 ? 1'h0 : ~(w99 | b2[1][15]);
	assign w125 = c1 ? 1'h0 : ~(w99 | b2[0][15]);
	assign w126 = c1 ? 1'h0 : ~(w100 | b2[3][15]);
	
	always @(posedge MCLK)
	begin
		if (c1)
		begin
			w127 <= w529[53];
			w128 <= w529[52];
		end
	end

	assign w132 = w643 ? b2[3] : { w639 ? 14'h3fff : 14'h0, w642, w640 };
	
	// replace carry look-ahead circuit with simple add
	assign { addr_carry, w145 } = { 1'h0, ~w132 } + { 1'h0, ~b2[1] } + { 16'h0, w638 & w646 };
	
	always @(posedge MCLK)
	begin
		if (w148)
			w147 = ~w145;
	end
	
	always @(posedge MCLK)
	begin
		if (c1)
			l11 <= ~w529[48];
	end
	
	assign w148 = c1? 1'h0 : (l11 ? c3 : 1'h0);
	
	assign w149 = ~(~w529[46] | w529[47]);
	assign w150 = ~(w529[46] | ~w529[47]);
	assign w151 = ~(~w529[46] | ~w529[47]);
	assign w152 = w149 ? c2 : 1'h0;
	assign w153 = w150 ? c2 : 1'h0;
	assign w154 = w151 ? c2 : 1'h0;
	assign w155 = w675 ? 1'h0 : w847;
	assign w156 = w668 ? 1'h0 : w853;
	
	assign w157 = w147[5:0] == 6'h0;
	
	always @(posedge MCLK)
	begin
		if (w160)
			w158 <= w147;
		else if (w161)
			w158 <= ~b2[1];
		else if (w162)
			w158 <= ~b2[3];
	end
	
	assign w159 = ~w158;
	
	assign w160 = w164 ? c2 : 1'h0;
	assign w161 = w165 ? c2 : 1'h0;
	assign w162 = w166 ? c2 : 1'h0;
	assign w163 = w637 ? 1'h0 : c2;
	
	assign w164 = ~(~w529[63] | ~w529[64]);
	assign w165 = ~(~w529[63] | w529[64]);
	assign w166 = ~(w529[63] | ~w529[64]);
	
	assign w167 = w597[0] ? c3 : 1'h0;
	assign w168 = w597[4] ? c2 : 1'h0;
	
	always @(posedge MCLK)
	begin
		if (w168)
			w169 <= b2[2];
		else if (w167)
			w169 <= w169 & ~w173;
	end
	
	assign w170 = w169 == 16'h0;
	
	always @(posedge MCLK)
	begin
		if (c2)
			w171 <= ~w169;
	end
	
	// replaced with simpler logic
	assign w172[0] = ~(w171[0] == 1'h1);
	assign w172[1] = ~(w171[1:0] == 2'h3);
	assign w172[2] = ~(w171[2:0] == 3'h7);
	assign w172[3] = ~(w171[3:0] == 4'hf);
	assign w172[4] = ~(w171[4:0] == 5'h1f);
	assign w172[5] = ~(w171[5:0] == 6'h3f);
	assign w172[6] = ~(w171[6:0] == 7'h7f);
	assign w172[7] = ~(w171[7:0] == 8'hff);
	assign w172[8] = ~(w171[8:0] == 9'h1ff);
	assign w172[9] = ~(w171[9:0] == 10'h3ff);
	assign w172[10] = ~(w171[10:0] == 11'h7ff);
	assign w172[11] = ~(w171[11:0] == 12'hfff);
	assign w172[12] = ~(w171[12:0] == 13'h1fff);
	assign w172[13] = ~(w171[13:0] == 14'h3fff);
	assign w172[14] = ~(w171[14:0] == 15'h7fff);
	assign w172[15] = ~(w171[15:0] == 16'hffff);
	
	assign w173 = ~({w172[14:0], 1'h0} | w171);
	
	assign w174 = (w173 & 16'h5555) == 16'h0000;
	assign w175 = (w173 & 16'h3333) == 16'h0000;
	assign w176 = (w173 & 16'h0f0f) == 16'h0000;
	assign w177 = (w173 & 16'h00ff) == 16'h0000;
	
	assign w178 = w597[5] ? (w597[4] ? c3 : c2) : 1'h0;
	assign w179 = w597[6] ? (w597[4] ? c3 : c2) : 1'h0;
	
	assign w180 = w597[7];
	assign w181 = w597[8] ? c3 : 1'h0;
	
	assign w183 = w201 & ~w199 & ~w200;
	assign w184 = w201 & ~w199 & w200;
	
	assign w185 = w204 & ~w207 & ~w208;
	assign w186 = w204 & ~w207 & w208;
	
	assign w187 = w201 & w199 & ~w200;
	assign w188 = w201 & w199 & w200;
	
	assign w189 = w202 & ~w199 & ~w200;
	assign w190 = w202 & ~w199 & w200;
	
	assign w191 = w202 & w199 & ~w200;
	assign w192 = w202 & w199 & w200;
	
	assign w193 = w204 & w207 & ~w208;
	assign w194 = w204 & w207 & w208;
	
	assign w195 = w203 & ~w207 & ~w208;
	assign w196 = w203 & ~w207 & w208;
	
	assign w197 = w203 & w207 & ~w208;
	assign w198 = w203 & w207 & w208;
	
	assign w199 = w660;
	assign w200 = w659;
	assign w201 = w670;
	assign w202 = w671;
	assign w203 = w680;
	assign w204 = w679;
	assign w205 = w678;
	assign w206 = w677;
	assign w207 = w658;
	assign w208 = w657;
	assign w209 = w672;
	assign w210 = w673;
	
	assign w211 = w209 & ~w199 & ~w200;
	assign w212 = w209 & ~w199 & w200;
	
	assign w213 = w209 & w199 & ~w200;
	assign w214 = w209 & w199 & w200;
	
	assign w215 = w210 & ~w199 & ~w200;
	assign w216 = w210 & ~w199 & w200;
	
	assign w217 = w206 & ~w207 & ~w208;
	assign w218 = w206 & ~w207 & w208;
	
	assign w219 = w206 & w207 & ~w208;
	assign w220 = w206 & w207 & w208;
	
	assign w221 = w205 & ~w207 & ~w208;
	assign w222 = w205 & ~w207 & w208;
	
	assign w223 = w210 & w199 & ~w200;
	assign w224 = w210 & w199 & w200 & w634;
	assign w225 = w210 & w199 & w200 & ~w634;
	
	assign w226 = w205 & w207 & ~w208;
	assign w227 = w205 & w207 & w208 & w634;
	assign w228 = w205 & w207 & w208 & ~w634;
	
	always @(posedge MCLK)
	begin
		if (c1)
			w229 <= w576;
	end
	
	assign w230 = ~((w199 & w210 & w200) | w229);
	
	always @(posedge MCLK)
	begin
		if (c1)
		begin
			w231 <= w529[38];
			w232 <= ~w529[37];
			w238 <= ~w529[36];
		end
	end
	
	assign w235 = w232 ? 1'h0 : (w231 ? c2 : c3);
	
	assign w239 = w238 ? 1'h0 : (w231 ? c2 : c3);
	
	assign w240 = w228 ? w847 : 1'h0;

	assign w241 = w225 ? w853 : 1'h0;

	assign w242 = w224 ? w853 : 1'h0;

	assign w243 = w227 ? w847 : 1'h0;

	assign w244 = w226 ? w847 : 1'h0;

	assign w245 = w223 ? w853 : 1'h0;

	assign w246 = w216 ? w853 : 1'h0;

	assign w247 = w222 ? w847 : 1'h0;

	assign w248 = w221 ? w847 : 1'h0;

	assign w249 = w215 ? w853 : 1'h0;

	assign w250 = w214 ? w853 : 1'h0;

	assign w251 = w220 ? w847 : 1'h0;

	assign w252 = w219 ? w847 : 1'h0;

	assign w253 = w213 ? w853 : 1'h0;

	assign w254 = w212 ? w853 : 1'h0;

	assign w255 = w218 ? w847 : 1'h0;

	assign w256 = w217 ? w847 : 1'h0;

	assign w257 = w211 ? w853 : 1'h0;
	
	assign w266 = VPA_TEST;
	
	wire [12:0] br_fsm_cases;
	
	assign br_fsm_cases[0] = (w270[1] == 3'h7) & ~w395 & w268_2 & ~w269_2;
	assign br_fsm_cases[1] = (w270[1] == 3'h1) & w268_2;
	assign br_fsm_cases[2] = (w270[1] == 3'h4);
	assign br_fsm_cases[3] = (w270[1] == 3'h2) & w268_2;
	assign br_fsm_cases[4] = (w270[1] == 3'h6);
	assign br_fsm_cases[5] = (w270[1] == 3'h0) & w268_2 & ~w269_2;
	assign br_fsm_cases[6] = (w270[1] == 3'h7) & ~w395 & w269_2;
	assign br_fsm_cases[7] = (w270[1] == 3'h5) & w269_2;
	assign br_fsm_cases[8] = (w270[1] == 3'h1) & ~w268_2 & w269_2;
	assign br_fsm_cases[9] = (w270[1] == 3'h2) & ~w268_2 & w269_2;
	assign br_fsm_cases[10] = (w270[1] == 3'h2) & w268_2 & ~w269_2;
	assign br_fsm_cases[11] = (w270[1] == 3'h0) & w269_2;
	assign br_fsm_cases[12] = (w270[1] == 3'h5) & w268_2;
	
	always @(posedge MCLK)
	begin
		if (clk1)
		begin
			o_e <= w258;
			w259[0] <= w260 ? 4'hf :  { w259[1][2:0], w262 };
			
			w261[1] <= w261[0];
			
			w268[1] <= w268[0];
			
			w269[1] <= w269[0];
			
			w270[0][0] <= ~(br_fsm_cases[0] | br_fsm_cases[1] | br_fsm_cases[2] | br_fsm_cases[3] | br_fsm_cases[4] | br_fsm_cases[5]);
			w270[0][1] <= ~(br_fsm_cases[1] | br_fsm_cases[4] | br_fsm_cases[5] | br_fsm_cases[6] | br_fsm_cases[7] | br_fsm_cases[8]
				| br_fsm_cases[9] | br_fsm_cases[10] | br_fsm_cases[11] | br_fsm_cases[12]);
			w270[0][2] <= ~(br_fsm_cases[2] | br_fsm_cases[3] | br_fsm_cases[4] | br_fsm_cases[5] | br_fsm_cases[6] | br_fsm_cases[7]
				| br_fsm_cases[8] | br_fsm_cases[12]);
			
			w275[1] <= w275[0];
			
			w276[1] <= w276[0];
			
			w277[0] <= w336;
			w277[2] <= w277[1];
			w277[4] <= w277[3];
			
			w278 <= (w275[2] & w276[2]) | (w265[2] & w395 & w277[5]);
			
			_w279_0 <= _w279_1;
			_w279_2 <= _w279_1;
			
			_w281_0 <= w285;
			_w281_2 <= _w279_3;
			
			_w284_0 <= _w284_1;
			_w284_2 <= _w284_1;
			
			w290 <= w291;
			
			w294[0] <= w435[2];
			
			w296[1] <= w296[0];
			w296[1] <= w296[2];
			w297[1] <= w297[0];
			w297[1] <= w297[2];
			w298[1] <= w298[0];
			w298[1] <= w298[2];
			w299 <= ~w296[3];
			w301 <= ~w297[3];
			w303 <= ~w298[3];
			
			w315[0] <= ~w314;
		end
		if (clk2)
		begin
			if (w259[0] == 4'h6)
				w258 <= 1'h0;
			else if (w259[0] == 4'h8)
				w258 <= 1'h1;
			w259[1] <= w259[0];
			
			w260 <= w261[1] | (w259[0] == 4'h6) | (w259[0] == 4'h0);
			w261[0] <= w266;
			
			w262 <= ((w259[0] & 4'hc) == 4'h8) | ((w259[0] & 4'hc) == 4'h4);
			
			if (w259[0] == 4'h8)
				w263 <= 1'h1;
			else if (w259[0] == 4'h9 & w343[2] & w400)
				w263 <= 1'h0;
			
			if (w259[0] == 4'h8)
				w264 <= 1'h1;
			else iof (w259[0] == 4'hc & ~w263)
				w264 <= 1'h0;
			
			w267 <= w266;
			
			w268[0] <= ~BR;
			w268[2] <= w268_1;
			
			w269[0] <= ~BGACK;
			w269[2] <= w269_1;
			
			w273 <= w268_2;
			w274 <= w269_2;
			
			w270[1] <= w270_0;
			
			o_bg <= w270_0[0];
			
			w275[0] <= ~RESET;
			w275[2] <= w275[1];
			
			w276[0] <= ~HALT;
			w276[2] <= w276[1];
			
			w277[1] <= w277[0];
			w277[3] <= w277[2];
			w277[5] <= w277[4];
			
			_w279_0 <= w282;
			_w279_2 <= _w279_3;
			
			_w281_0 <= _w281_1;
			_w281_2 <= _w281_1;
			
			_w284_0 <= 1'h0;
			_w284_2 <= _w284_3;
			
			w287 <= w285;
			w289 <= w288;
			
			w294[1] <= w294[0];
			
			w296[0] <= ~IPL[0];
			w296[2] <= w296[1];
			
			w297[0] <= ~IPL[1];
			w297[2] <= w297[1];
			
			w298[0] <= ~IPL[2];
			w298[2] <= w298[1];
			
			w308 <= ~w307;
			
			w312 <= ~w305;
			
			w314 <= ~w306;
			w315[1] <= w315[0];
			
			w317 <= w305;
		end
	end
	
	assign _w279_1 = _w279_0 & ~w278;
	assign _w279_3 = _w279_2 & ~w278;
	
	assign _w281_1 = _w281_0 & ~w278;
	assign _w281_3 = _w281_2 & ~w278;
	
	assign w280 = ~_w279_2 ? 1'h0 : (_w279_3 ? 1'h1 : w280_mem);
	
	assign w282_n = _w281_3 ? 1'h0 : (~_w281_2 ? 1'h1 : w282_n_mem);
	
	assign w282 = ~_w281_2 ? 1'h0 : (_w281_3 ? 1'h1 : w282_mem);
	
	assign w285 = ~(_w284_2 | w286) ? 1'h0 : (_w284_3 ? 1'h1 : w285_mem);
	
	always @(posedge MCLK)
	begin
		w280_mem <= w280;
		w282_mem <= w282;
		w282_n_mem <= w282_n;
		w285_mem <= w285;
	end
	
	assign w265 = ~w264 | (~w343[2] & (w435[2] | w292));
	
	assign RESET = w336 ? 'bz : 1'h0;
	assign HALT = w339 ? 'bz : 1'h0;
	
	assign w286 = ~(w292 | w287 | w289 | clk2 | w430 | w435[2]);
	
	assign w288 = ~(w290 | w280 | w285);
	
	assign w291 = ~(w293 | w278 | w292);
	
	always @(posedge MCLK)
	begin
		if (w341)
			w292 <= 1'h1;
		else if (c5 && w340)
			w292 <= 1'h0;
	end
	
	assign w293 = w988 & w294[1] & w325 & w351;
	
	assign w295 = IPL[0];
	
	assign IPL[0] = (w297[2] & w298[2] & w266) ? 1'h0 : 'bz;
	assign IPL[1] = (IPL[0] & w266) ? 1'h0 : 'bz;
	assign IPL[2] = (IPL[0] & w266) ? 1'h0 : 'bz;
	assign BERR = (IPL[0] & w266) ? 1'h0 : 'bz;
	
	assign w300 = ~((w296[2] & w296[3]) | (~w296[2] & ~w296[3]));
	assign w302 = ~((w297[2] & w297[3]) | (~w297[2] & ~w297[3]));
	assign w304 = ~((w298[2] & w298[3]) | (~w298[2] & ~w298[3]));
	
	// interrupt priority comparator
	
	wire [2:0] ipc_t2 = { w303, w301, w299 };
	wire [2:0] ipc_t3 = { w609, w610, w611 };
	
	assign w305 = ~(
		((ipc_t2 & 3'h5) == 3'h0 & (ipc_t3 & 3'h3) == 3'h0) |
		((ipc_t2 & 3'h7) == 3'h0 & (ipc_t3 & 3'h1) == 3'h0) |
		((ipc_t2 & 3'h4) == 3'h0 & (ipc_t3 & 3'h4) == 3'h0) |
		((ipc_t2 & 3'h2) == 3'h0 & (ipc_t3 & 3'h6) == 3'h0) |
		((ipc_t2 & 3'h3) == 3'h0 & (ipc_t3 & 3'h5) == 3'h0) |
		((ipc_t2 & 3'h1) == 3'h0 & (ipc_t3 & 3'h7) == 3'h0) |
		((ipc_t2 & 3'h6) == 3'h0 & (ipc_t3 & 3'h2) == 3'h0)	
		);
	
	assign w306 = ipc_t2 == 3'h0;
	assign w307 = ~(w302 | w304 | w300);
	
	assign w309 = ~(w310 | w311 | w318 | w308);
	assign w310 = ~(w313 | w309 | w316);
	assign w311 = ~(w308 | clk2 | w312 | w306);
	assign w313 = ~(w314 | clk2 | w315[1] | w308);
	assign w316 = ~(w308 | clk2 | w317);
	assign w318 = ~(w321 | clk2 | w319 | w325 | w320);

endmodule

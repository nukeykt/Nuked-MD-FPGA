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
	reg w319;
	reg w320;
	reg w321;
	reg w322;
	reg w323;
	reg w324;
	wire w325;
	reg w326;
	wire w327;
	wire w328;
	reg c1_l;
	reg c2_l;
	reg c3_l;
	reg c4_l;
	reg c5_l;
	wire w330;
	wire w331;
	wire w332;
	wire w333;
	wire w334;
	reg w335;
	wire w336;
	wire w337;
	reg w338;
	wire w339;
	wire w340;
	wire w341;
	reg w342;
	reg w343[0:2];
	reg w344;
	reg w345;
	wire w346;
	wire w347;
	reg w348;
	reg w349;
	reg w350;
	reg w351;
	wire w352;
	wire w353;
	wire w354;
	wire w355;
	reg w356_0;
	wire w356_1;
	reg w357_0;
	wire w357_1;
	reg w358_0;
	wire w358_1;
	reg w359[0:2];
	wire w359_3;
	wire w360;
	wire w361;
	reg w361_mem;
	reg w362;
	reg w363;
	reg w364[0:1];
	wire w365;
	reg w366;
	reg w367;
	reg w368;
	reg w369;
	reg w370;
	reg w371;
	wire w372;
	reg w373;
	reg w374;
	wire w375;
	wire w376;
	wire w377;
	reg w378;
	reg w379;
	reg w380;
	wire w381;
	wire w382;
	reg w383;
	reg w384;
	wire w385;
	reg w386;
	reg w387;
	reg w388;
	wire w389[0:8];
	wire w390;
	wire w391;
	wire w392;
	wire w393;
	wire w394;
	wire w395;
	wire w396;
	wire w397;
	reg w398;
	wire w399;
	reg w400;
	reg w401;
	wire w402;
	wire w403;
	reg w404;
	wire w405;
	reg w406;
	wire w407;
	reg w408;
	wire w409;
	reg w410;
	wire w411;
	wire w412;
	wire w413;
	reg w414[0:2];
	reg w415;
	wire w416;
	reg w417;
	reg w418_mem;
	wire w418_1;
	wire w419;
	reg w420;
	reg w421_mem
	wire w421_1;
	wire w422;
	wire w423;
	wire w424;
	wire w425;
	wire w426;
	wire w427;
	wire w428;
	reg w429;
	wire w430;
	wire w431;
	wire w432;
	wire w433;
	wire w434;
	reg w435[0:2];
	reg w436[0:1];
	wire w437;
	reg w438;
	reg w439[0:1];
	wire w440;
	wire w441;
	reg w442[0:1];
	reg w443[0:1];
	wire w444;
	reg w444_mem;
	reg [9:0] w445;
	reg w446;
	reg w447;
	reg w448;
	wire w449;
	wire w450;
	reg w451;
	reg w452;
	reg w453;
	reg w454;
	reg w455;
	reg w456;
	reg w457;
	reg w458;
	reg w459;
	reg w460;
	reg w461;
	wire w462[0:10];
	wire w463;
	wire [9:0] w464;
	wire w465[0:4];
	reg [9:0] codebus;
	wire w466;
	wire w467;
	wire w468;
	wire w469;
	wire w470;
	wire w471;
	reg [9:0] codebus2;
	reg w472;
	reg w473;
	wire w474;
	wire w475;
	wire w476;
	wire w477;
	wire w478;
	reg w479;
	reg w480;
	reg w481;
	wire w482[0:4];
	wire w483;
	wire w484;
	wire w485;
	wire w486;
	wire w487;
	wire w488;
	reg w489;
	reg w490;
	wire w491;
	wire w492;
	wire w493;
	reg w495;
	wire w496;
	wire w497;
	wire w498;
	wire w499;
	reg w500;
	reg w501;
	reg w502;
	reg w503;
	reg w504;
	reg w505;
	reg w506;
	wire w507;
	wire w508;
	wire w509;
	wire w510;
	wire w511;
	wire w512;
	wire w513;
	wire w514;
	wire w515;
	wire w516;
	wire w517;
	wire w518;
	reg [0:117] w519;
	reg [0:117] w520;
	reg [0:67] w521;
	reg [16:0] w522;
	reg [16:0] w523;
	wire w524;
	wire w525;
	wire w526;
	wire w527;
	reg [0:67] w528;
	reg [67:0] w529;
	
	wire [17:0] w597;
	
	reg [67:0] ucode[0:117];
	
	wire [170:0] a0_pla;
	reg [164:20] a0_pla_mem;
	
	reg [15:0] b1[0:3];
	reg [15:0] b2[0:3];
	reg [15:0] b3[0:3];
	
	wire c1;
	wire c2;
	wire c3;
	wire c4;
	wire c5;
	reg c6;
	
	reg o_e;
	reg o_bg;
	
	assign E = o_e;
	assign BG = o_bg;
	
	wire clk1 = ~CLK;
	wire clk2 = CLK;
	
	initial
	begin
		$readmemb("68k_ucode.txt", ucode);
	end
	
	
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
			
			w343[1] <= w343[0];
			
			w359[1] <= w359[0];
			
			w359[2] <= w359[3];
			
			w363 <= ~((w395 & w418_1) | w364[1] | ~w383);
			
			w364[0] <= w397 & w389[0];
			
			w366 <= ~(w367 | w365);
			
			w368 <= ~(w367 | w395);
			
			w369 <= w391;
			
			w370 <= w391;
			
			w371 <= ~(w389[1] | w372 | ~w386);
			
			w373 <= ~w365;
			
			w374 <= ~(w389[2] | w384);
			
			w378 <= ~(~w388 | (w389[7] & w397) | w267);
			
			w379 <= ~(w267 | w397 | w381);
			
			w380 <= ~(w267 | ~w391 | ~w387);
			
			w398 <= ~(~w397 | w381 | w267);
			
			w418[0] <= w394;
			
			w414[2] <= w414[1];
			
			w415 <= w402;
			
			w417 <= w265;
			
			w435[1] <= w435[0];
			
			w436[0] <= w435[2];
			
			w439[0] <= w400;
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
			
			w343[0] <= ~VPA;
			w343[2] <= w343[1];
			
			w359[0] <= ~DTACK;
			w359[2] <= w359[1];
			
			w364[1] <= w364[0];
			
			w367 <=  ~w387;
			
			w383 <= w382;
			
			w384 <= w374 | w373;
			
			w386 <= w385;
			
			w387 <= w376;
			
			w388 <= w377;
			
			w401 <= w377;
			
			w404 <= w403;
			
			w410 <= ~w377;
			
			w414[1] <= w414[0];
			
			w435[0] <= ~BERR;
			w435[2] <= w435[1];
			
			w436[1] <= w436[0];
			
			w439[1] <= ~w439[0];
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
	
	always @(posedge MCLK)
	begin
		if (w278)
		begin
			w319 <= 1'h0;
			w320 <= 1'h0;
			w321 <= 1'h0;
		end
		else if (w328)
		begin
			w319 <= w299;
			w320 <= w301;
			w321 <= w303;
		end
		
		if (w330)
		begin
			w322 <= ~w522[15] & (w631 | w522[16]);
			w323 <= ~w522[16] & (w522[15] | ~w631);
			w324 <= ~w607;
		end
	end
	
	assign w325 <= w322 | w323 | w324;
	
	always @(posedge MCLK)
	begin
		if (c1)
			w326 <= w522[0];
	end
	
	assign w327 = ~(w326 | w267);
	
	assign w328 = w327 ? 1'h0 : c2;
	
	always @(posedge MCLK)
	begin
		if (clk1)
		begin
			c2_l <= w285;
			c3_l <= w280;
			c5_l <= w288;
		end
		if (clk2)
		begin
			c1_l <= w282_n;
			c4_l <= w282;
		end
		
		if (c2)
			c6 <= 1'h1;
		else if (c1)
			c6 <= 1'h0;
	end
	
	assign c1 = clk1 ? c1_l : 1'h0;
	assign c2 = clk2 ? c2_l : 1'h0;
	assign c3 = clk2 ? c3_l : 1'h0;
	assign c4 = clk1 ? c4_l : 1'h0;
	assign c5 = clk2 ? c5_l : 1'h0;
	
	assign w330 = w567 ? 1'h0 : c2;
	
	assign FC[0] = w409 ? 'bz : ~w322;
	assign FC[1] = w409 ? 'bz : ~w323;
	assign FC[2] = w409 ? 'bz : ~w324;
	
	assign w331 = ~w323;
	assign w332 = ~w322;
	
	assign w333 = ~w567;
	
	assign w334 = ~(w522[16] | w333 | ~w522[15]);
	
	always @(posedge MCLK)
	begin
		if (c2)
			w335 <= ~w334;
		else if (clk1)
			w335 <= w336;
	end
	
	assign w336 = w335 | w278;
	
	assign w337 = ~(w333 | w522[15] | ~w522[16]);
	
	always @(posedge MCLK)
	begin
		if (c2)
			w338 <= ~w337;
		else if (clk1)
			w338 <= w339;
	end
	
	assign w339 = w338 | w278;
	
	assign w340 = ~w400;
	assign w341 = ~(~w403 | w340 | clk1 | c2);
	
	always @(posedge MCLK)
	begin
		if (c1)
			w342 <= w525 | w267 | ~w343[2];
		if (clk1)
			w345 <= ~w294[1];
		if (c1)
			w344 <= w345 | w267 | w325;
	end
	
	assign w346 = ~(~w435[2] | w340 | ~w325);
	assign w347 = ~(w340 | w346);
	
	always @(posedge MCLK)
	begin
		if (c1)
			w349 <= w567;
		
		if (clk2)
		begin
			if (w278)
				w348 <= 1'h0;
			else if (~w349)
				w348 <= 1'h1;
		end
		
		if (clk1)
			w350 <= ~w348;
		
		if (clk1)
		begin
			if (w346 & w347)
			begin
			end
			else if (w346)
				w351 <= 1'h1;
			else if (w347)
				w351 <= 1'h0;
		end
	end
	
	assign w352 = ~(w403 | w351);
	
	assign w353 = ~(w352 | w463);
	
	assign w354 = ~w352;
	
	assign w355 = ~(c5 | c3);
	
	always @(posedge MCLK)
	begin
		if (c5)
		begin
			w356_0 <= w350;
			w357_0 <= w354;
			w358_0 <= w353;
		end
		else if (c3)
		begin
			w356_0 <= 1'h0;
			w357_0 <= 1'h0;
			w358_0 <= 1'h0;
		end
		else if (w355)
		begin
			w356_0 <= w356_1;
			w357_0 <= w357_1;
			w358_0 <= w358_1;
		end
	end
	
	assign w356_1 = w356_0;
	assign w357_1 = w356_1 ? 1'h0 : w357_0;
	assign w358_1 = w356_1 ? 1'h0 : w358_0;
	
	assign w359_3 = w359[2] & ~w343[2];
	assign w360 = w359_3;
	
	always @(posedge MCLK)
	begin
		if (clk2)
			w362 <= w382;
		w361_mem <= w361;
	end
	
	assign w361 = (~w362 & clk1) ? 1'h1 : (w362 ? 1'h0 : w361_mem);
	
	assign w365 = ~(w391 | w389[5] | w389[3] | w389[4]);
	
	assign w372 = ~(~w395 | w418_1);
	
	assign w375 = ~(w414[2] | w416 | w415 | w420);
	
	assign w376 = w369 | w368 | w375;
	
	assign w377 = w380 | w379 | w378;
	
	assign w381 = ~(w389[4] | w389[5]);
	
	assign w382 = w363 | w366;
	
	assign w385 = w371 | w370 | w396;
	
	assign w389[0] = w383 & w384 & w386 & ~w387 & ~w388;
	assign w389[1] = ~w383 & w384 & w386 & ~w387 & ~w388;
	assign w389[2] = w383 & ~w386 & ~w387 & ~w388;
	assign w389[3] = w383 & ~w384 & w386 & ~w387 & ~w388;
	assign w389[4] = w383 & ~w384 & w386 & w387 & ~w388;
	assign w389[5] = ~w383 & w384 & w386 & w387 & ~w388;
	assign w389[6] = w383 & w384 & w386 & w387 & ~w388;
	assign w389[7] = w383 & w384 & w386 & w387 & w388;
	assign w389[8] = ~w383 & w384 & ~w387 & ~w388;
	
	assign w390 = ~w389[0] & ~w389[1] & ~w389[2] & ~w389[3]
		& ~w389[4] & ~w389[5] & ~w389[6] & ~w389[7] & ~w389[8];
	
	assign w391 = w390 | w428;
	
	assign w392 = w389[0];
	
	assign w393 = ~(w389[3] | w389[4] | w389[5]);
	
	assign w394 = ~(w389[2] | w389[8]);
	
	assign w395 = w389[6];
	
	assign w396 = ~(w414[2] | w415 | w416);
	
	assign w397 = ~(w267 | w419 | ~(w421_1 & w567) | w426);
	
	assign w399 = w398 ? clk2 : 1'h0;
	
	always @(posedge MCLK)
	begin
		if (~w401 & clk1)
			w400 <= 1'h1;
		else if (w399 | (c2 & w267) | w401)
			w401 <= 1'h0;
	end
	
	assign w402 = ~(w404 | w422);
	
	assign w403 = w406 & ~w267 & w405;
	
	assign w405 = ~w815;
	
	assign w407 = w567 ? 1'h0 : c2;
	
	always @(posedge MCLK)
	begin
		if (w407)
			w406 <= ~w408;
		if (c1)
			w408 <= ~w563;
	end
	
	assign w409 = ~(w433 | w410);
	
	assign w411 = w406 ^ w815;
	assign w412 = ~w411;
	assign w413 = ~w405;
	
	assign w416 = ~(w359[3] | w417);
	
	always @(posedge MCLK)
	begin
		w418_mem <= w418_1;
		w421_mem <= w421_1;
	end
	
	assign w418_1 = (w407 ? w568 : w418_mem) & ~w267;
	
	assign w419 = ~(w392 | w432);
	
	always @(posedge MCLK)
	begin
		if (w407)
			w420 <= w431;
	end
	
	assign w421_1 = (w407 ? 1'h1 : w421_mem) & ~w425 & ~w428;
	
	assign w422 = ~(w428 | w425 | w267 | w424);
	assign w423 = ~w422;
	
	assign w424 = c2 ? w441 : w423;
	
	assign w425 = ~(w393 | w426 | clk2);
	
	assign w426 = ~(w403 | w427);
	
	assign w427 = ~(w435[2] & w276[2] & w438);
	
	assign w428 = ~(clk2 | w434);
	
	always @(posedge MCLK)
	begin
		if (clk2)
			w429 <= w396;
	end
	
	assign w430 = ~(w423 | w429);
	
	assign w431 = ~(w568 | w546);
	
	assign w432 = ~(w269[2] | ~w270[0][0] | w268[2] | w276[2]);
	
	assign w433 = ~(w278 | ~w270[0][1] | ~w270[0][0]);
	
	assign w434 = ~(w278 | (w440 & w437 & w436[1] & w435[2]));
	
	assign w437 = ~(w276[2] & w438);
	
	always @(posedge MCLK)
	begin
		if (c2)
			w438 <= w546;
	end
	
	assign w440 = ~(w439[1] | w343[2]);
	
	assign w441 = ~(w568 | ~w544);
	
	assign w444 = w443[1] ? 1'h0 : (w442[1] ? c1 : w444_mem);
	
	always @(posedge MCLK)
	begin
		if (w450)
			w442[0] <= 1'h1;
		else if (c1)
			w442[0] <= 1'h0;
		if (w450)
			w443[0] <= 1'h0;
		else if (c1)
			w443[0] <= 1'h0;
		
		if (~c1)
		begin
			w442[1] <= w442[0];
			w443[1] <= w443[0];
		end
		
		w444_mem <= w444;
		
		if (w444)
			w445 <= w531;
		
		if (c1)
		begin
			w446 <= w477;
			w447 <= w474;
			w448 <= w475;
		end
	end
	
	assign w449 = w448 ? c3 : 1'h0;
	
	assign w450 = (w446 | w447) ? c3 : 1'h0;
	
	always @(posedge MCLK)
	begin
		if (w449)
		begin
			w451 <= w403;
			w452 <= w344;
			w453 <= w342;
			w454 <= w351;
			w455 <= w350;
		end
		if (w450)
		begin
			w456 <= a0_pla[169];
			w457 <= a0_pla[170];
			w458 <= w989;
			w459 <= w990;
			w460 <= w548;
			w461 <= w991;
		end
	end
	
	assign w462[0] = w455;
	assign w462[1] = ~w451 & ~w452 & ~w454 & ~w455 & ~w460;
	assign w462[2] = ~w451 & w452 & ~w453 & ~w454 & ~w455 & ~w460;
	assign w462[3] = ~w451 & w452 & w453 & ~w454 & ~w455 & w457 & ~w460 & w461;
	assign w462[4] = ~w451 & w452 & w453 & ~w454 & ~w455 & w456 & ~w457 & ~w460 & w461;
	assign w462[5] = ~w451 & w452 & w453 & ~w454 & ~w455 & ~w456 & ~w457 & ~w458 & ~w460 & w461;
	assign w462[6] = ~w451 & w452 & w453 & ~w454 & ~w455 & ~w456 & ~w457 & w458 & w459 & ~w460 & w461;
	assign w462[7] = ~w451 & w452 & w453 & ~w454 & ~w455 & ~w460 & ~w461;
	assign w462[8] = ~w451 & ~w454 & ~w455 & w460;
	assign w462[9] = w451 & ~w455;
	assign w462[10] = ~w451 & w454 & ~w455;
	
	assign w464 = (
		(w462[3] ? 10'h1c0 : 10'h3ff) &
		(w462[4] ? 10'h1c0 : 10'h3ff) &
		(w462[5] ? 10'h1c0 : 10'h3ff) &
		(w462[6] ? 10'h1c0 : 10'h3ff) &
		(w462[7] ? 10'h1c4 : 10'h3ff) &
		(w462[8] ? 10'h1c0 : 10'h3ff));
	
	always @(posedge MCLK)
	begin
		if (w466)
			codebus <= w445;
		else if (w467)
			codebus <= w464;
		else if (w482[3])
			codebus <= w534;
		else if (w482[2])
			codebus <= w535;
		if (w476)
			codebus2 <= ~codebus;
		if (w482[0])
		begin
			codebus2[6] <= ~w472;
			codebus2[7] <= ~w473;
		end
		if (w482[1])
		begin
			codebus2[6] <= w484;
			codebus2[7] <= w485;
		end
		if (w486)
		begin
			codebus2[0] <= ~w522[11];
			codebus2[1] <= ~w522[12];
			codebus2[2] <= ~w522[7];
			codebus2[3] <= ~w522[8];
			codebus2[4] <= ~w522[9];
			codebus2[5] <= ~w522[10];
			codebus2[8] <= ~w522[13];
			codebus2[9] <= ~w522[14];
		end
	end
	
	assign w465[0] = ~(w462[3] | w462[4] | w462[5] | w462[6] | w462[7] | w462[8]);
	assign w465[1] = ~(w462[3] | w462[4] | w462[5] | w462[6]);
	assign w465[2] = ~(w462[1] | w462[2] | w462[4] | w462[5] | w462[6] | w462[7] | w462[8]);
	assign w465[3] = ~(w462[0] | w462[2] | w462[3] | w462[6] | w462[7] | w462[10]);
	assign w465[4] = ~(w462[0] | w462[1] | w462[3] | w462[5] | w462[7] | w462[9]);
	
	assign w466 = ~(w483 | ~w465[0]);
	assign w467 = ~(w483 | w465[0]);
	
	assign w468 = ~w465[1];
	assign w469 = ~w465[2];
	assign w470 = ~w465[3];
	assign w471 = ~w465[4];
	
	always @(posedge MCLK)
	begin
		if (w267)
		begin
			w472 <= w274;
			w473 <= w273;
		end
		else if (w561)
		begin
			w472 <= w557;
			w473 <= w558;
		end
		else if (w562)
		begin
			w472 <= w556;
			w473 <= w558;
		end
	end
	
	assign w475 = ~(w522[1] | ~w522[4]);
	assign w474 = ~(~w522[0] | w475);
	
	assign w476 = w482[3] | w482[4] | w482[2];
	
	assign w478 = ~(w267 & (w360 | w296[2]));
	assign w477 = ~w478;
	
	always @(posedge MCLK)
	begin
		if (w478)
		begin
			w479 <= w522[2];
			w480 <= w522[3];
			w481 <= w522[4];
		end
		else if (w477)
		begin
			w479 <= w296[2];
			w480 <= w360;
			w481 <= 1'h0;
		end
	end
	
	assign w482[0] = w481;
	assign w482[1] = ~w479 & ~w480 & ~w481;
	assign w482[2] = w479 & w480 & ~w481;
	assign w482[3] = ~w479 & w480 & ~w481;
	assign w482[4] = w479 & ~w480 & w481;
	
	assign w483 = ~w482[4];
	
	assign w484 = ~w522[5];
	assign w485 = ~w522[6];
	
	assign w486 = (w482[1] | w482[0]) & ~w477;

	assign w487 = ~(codebus2[6] | w508);
	assign w488 = ~(codebus2[7] | w508);
	
	always @(posedge MCLK)
	begin
		if (c4)
		begin
			w489 <= w487;
			w490 <= w488;
		end
	end
	
	assign w491 = w489 & ~w490;
	assign w492 = ~w489 & ~w490;
	assign w493 = w489 & w490;
	assign w494 = ~w489 &~w490;
	
	assign w496 = w494 ? c3 : 1'h0;
	assign w497 = w493 ? c3 : 1'h0;
	assign w498 = w492 ? c3 : 1'h0;
	assign w499 = w491 ? c3 : 1'h0;
	
	always @(posedge MCLK)
	begin
		if (c1)
		begin
			w495 <= ~(codebus[3] | w508);
			w500 <= ~(codebus[2] | w508);
			w501 <= ~(codebus[5] | w508);
			w502 <= ~(codebus[4] | w508);
			w503 <= ~(codebus[8] | w508);
			w504 <= ~(codebus[9] | w508);
			w505 <= ~((codebus[1] & w507) | w358[1]);
			w506 <= ~((codebus[0] & w507) | w356[1]);
		end
	end
	
	assign w507 = ~(w356[1] | w357[1] | w358[1]);
	assign w508 = ~w507;
	assign w509 = ~(~w495 | ~w500);
	assign w510 = ~(~w495 | w500);
	assign w511 = ~(w495 | ~w500);
	assign w512 = ~(w495 | w500);
	assign w513 = ~(c1 | c2 | ~w501);
	assign w514 = ~(c1 | c2 | w501);
	assign w515 = ~(w506 | w505);
	assign w516 = ~(~w506 | w505);
	assign w517 = ~(w506 | ~w505);
	assign w518 = ~(~w506 | ~w505);
	
	assign w524 = ~(~w505 | ~w506):
	assign w525 = ~(w505 | ~w506):
	assign w526 = ~(~w505 | w506):
	assign w527 = ~(w505 | w506):
	
	integer i, j;
	
	always @(posedge MCLK)
	begin
		if (c2)
		begin
			for (i = 0; i < 118; i = i + 1)
				w519[i] <= 1'h1;
		end
		else
		begin
			if (w513 | w502 | w503 | w504)
				w519[0] <= 1'h0;
			if (w514 | w502 | w503 | w504)
				w519[1] <= 1'h0;
			if (w513 | w502 | w503 | w504)
				w519[2] <= 1'h0;
			if (w514 | w502 | w503 | w504)
				w519[3] <= 1'h0;
			if (w513 | w502 | w503 | w504)
				w519[4] <= 1'h0;
			if (w514 | w502 | w503 | w504)
				w519[5] <= 1'h0;
			if (w513 | w502 | w503 | w504)
				w519[6] <= 1'h0;
			if (w514 | w502 | w503 | w504)
				w519[7] <= 1'h0;
			if (w513 | w502 | ~w503 | w504)
				w519[8] <= 1'h0;
			if (w514 | w502 | ~w503 | w504)
				w519[9] <= 1'h0;
			if (w513 | ~w502 | ~w503 | w504)
				w519[10] <= 1'h0;
			if (w514 | ~w502 | ~w503 | w504)
				w519[11] <= 1'h0;
			if (w513 | ~w502 | ~w503 | w504)
				w519[12] <= 1'h0;
			if (w514 | ~w502 | ~w503 | w504)
				w519[13] <= 1'h0;
			if (w513 | w502 | ~w503 | w504)
				w519[14] <= 1'h0;
			if (w514 | w502 | ~w503 | w504)
				w519[15] <= 1'h0;
			if (w513 | ~w502 | ~w503 | w504)
				w519[16] <= 1'h0;
			if (w514 | ~w502 | ~w503 | w504)
				w519[17] <= 1'h0;
			if (w513 | ~w502 | w503 | ~w504)
				w519[18] <= 1'h0;
			if (w514 | ~w502 | w503 | ~w504)
				w519[19] <= 1'h0;
			if (w513 | ~w502 | w503 | ~w504)
				w519[20] <= 1'h0;
			if (w514 | ~w502 | w503 | ~w504)
				w519[21] <= 1'h0;
			if (w513 | ~w502 | w503 | ~w504)
				w519[22] <= 1'h0;
			if (w514 | ~w502 | w503 | ~w504)
				w519[23] <= 1'h0;
			if (w513 | ~w502 | w503 | ~w504)
				w519[24] <= 1'h0;
			if (w514 | ~w502 | w503 | ~w504)
				w519[25] <= 1'h0;
			if (w513 | w502 | ~w503 | ~w504)
				w519[26] <= 1'h0;
			if (w514 | w502 | ~w503 | ~w504)
				w519[27] <= 1'h0;
			if (w513 | w502 | ~w503 | ~w504)
				w519[28] <= 1'h0;
			if (w514 | w502 | ~w503 | ~w504)
				w519[29] <= 1'h0;
			if (w513 | w502 | ~w503 | ~w504)
				w519[30] <= 1'h0;
			if (w514 | w502 | ~w503 | ~w504)
				w519[31] <= 1'h0;
			if (w513 | w502 | ~w503 | ~w504)
				w519[32] <= 1'h0;
			if (w514 | w502 | ~w503 | ~w504)
				w519[33] <= 1'h0;;

			if (w513 | w500 | w495 | w502 | w503 | w504)
				w519[34] <= 1'h0;
			if (w514 | w500 | w495 | w502 | w503 | w504)
				w519[35] <= 1'h0;
			if (w513 | ~w500 | w495 | w502 | w503 | w504)
				w519[36] <= 1'h0;
			if (w514 | ~w500 | w495 | w502 | w503 | w504)
				w519[37] <= 1'h0;
			if (w513 | ~w495 | w502 | w503 | w504)
				w519[38] <= 1'h0;
			if (w514 | ~w495 | w502 | w503 | w504)
				w519[39] <= 1'h0;
			if (w513 | w500 | w495 | w502 | w503 | w504)
				w519[40] <= 1'h0;
			if (w514 | w500 | w495 | w502 | w503 | w504)
				w519[41] <= 1'h0;
			if (w513 | ~w500 | w495 | w502 | w503 | w504)
				w519[42] <= 1'h0;
			if (w514 | ~w500 | w495 | w502 | w503 | w504)
				w519[43] <= 1'h0;
			if (w513 | ~w495 | w502 | w503 | w504)
				w519[44] <= 1'h0;
			if (w514 | ~w495 | w502 | w503 | w504)
				w519[45] <= 1'h0;
			if (w513 | w500 | w495 | w502 | w503 | w504)
				w519[46] <= 1'h0;
			if (w514 | w500 | w495 | w502 | w503 | w504)
				w519[47] <= 1'h0;
			if (w513 | ~w500 | w502 | w503 | w504)
				w519[48] <= 1'h0;
			if (w514 | ~w500 | w502 | w503 | w504)
				w519[49] <= 1'h0;
			if (w513 | w500 | ~w495 | w502 | w503 | w504)
				w519[50] <= 1'h0;
			if (w514 | w500 | ~w495 | w502 | w503 | w504)
				w519[51] <= 1'h0;
			if (w513 | w500 | w495 | w502 | w503 | w504)
				w519[52] <= 1'h0;
			if (w514 | w500 | w495 | w502 | w503 | w504)
				w519[53] <= 1'h0;
			if (w513 | ~w500 | w495 | w502 | w503 | w504)
				w519[54] <= 1'h0;
			if (w514 | ~w500 | w495 | w502 | w503 | w504)
				w519[55] <= 1'h0;
			if (w513 | ~w495 | w502 | w503 | w504)
				w519[56] <= 1'h0;
			if (w514 | ~w495 | w502 | w503 | w504)
				w519[57] <= 1'h0;
			if (w513 | w502 | ~w503 | w504)
				w519[58] <= 1'h0;
			if (w514 | w502 | ~w503 | w504)
				w519[59] <= 1'h0;
			if (w513 | ~w502 | ~w503 | w504)
				w519[60] <= 1'h0;
			if (w514 | ~w502 | ~w503 | w504)
				w519[61] <= 1'h0;
			if (w513 | w500 | w495 | ~w502 | ~w503 | w504)
				w519[62] <= 1'h0;
			if (w514 | w500 | w495 | ~w502 | ~w503 | w504)
				w519[63] <= 1'h0;
			if (w513 | ~w500 | w495 | ~w502 | ~w503 | w504)
				w519[64] <= 1'h0;
			if (w514 | ~w500 | w495 | ~w502 | ~w503 | w504)
				w519[65] <= 1'h0;
			if (w513 | w500 | ~w495 | ~w502 | ~w503 | w504)
				w519[66] <= 1'h0;
			if (w514 | w500 | ~w495 | ~w502 | ~w503 | w504)
				w519[67] <= 1'h0;
			if (w513 | ~w500 | ~w495 | ~w502 | ~w503 | w504)
				w519[68] <= 1'h0;
			if (w514 | ~w500 | ~w495 | ~w502 | ~w503 | w504)
				w519[69] <= 1'h0;
			if (w513 | ~w503 | w504)
				w519[70] <= 1'h0;
			if (w514 | ~w503 | w504)
				w519[71] <= 1'h0;
			if (w513 | w500 | w495 | ~w502 | w503 | ~w504)
				w519[72] <= 1'h0;
			if (w514 | w500 | w495 | ~w502 | w503 | ~w504)
				w519[73] <= 1'h0;
			if (w513 | ~w500 | w495 | ~w502 | w503 | ~w504)
				w519[74] <= 1'h0;
			if (w514 | ~w500 | w495 | ~w502 | w503 | ~w504)
				w519[75] <= 1'h0;

			if (w513 | w500 | ~w495 | ~w502 | w503 | ~w504)
				w519[76] <= 1'h0;
			if (w514 | w500 | ~w495 | ~w502 | w503 | ~w504)
				w519[77] <= 1'h0;
			if (w513 | ~w500 | ~w495 | ~w502 | w503 | ~w504)
				w519[78] <= 1'h0;
			if (w514 | ~w500 | ~w495 | ~w502 | w503 | ~w504)
				w519[79] <= 1'h0;
			if (w513 | w500 | w495 | ~w502 | w503 | ~w504)
				w519[80] <= 1'h0;
			if (w514 | w500 | w495 | ~w502 | w503 | ~w504)
				w519[81] <= 1'h0;
			if (w513 | ~w500 | w495 | ~w502 | w503 | ~w504)
				w519[82] <= 1'h0;
			if (w514 | ~w500 | w495 | ~w502 | w503 | ~w504)
				w519[83] <= 1'h0;
			if (w513 | w500 | ~w495 | ~w502 | w503 | ~w504)
				w519[84] <= 1'h0;
			if (w514 | w500 | ~w495 | ~w502 | w503 | ~w504)
				w519[85] <= 1'h0;
			if (w513 | ~w500 | ~w495 | ~w502 | w503 | ~w504)
				w519[86] <= 1'h0;
			if (w514 | ~w500 | ~w495 | ~w502 | w503 | ~w504)
				w519[87] <= 1'h0;
			if (w513 | w495 | ~w502 | w503 | ~w504)
				w519[88] <= 1'h0;
			if (w514 | w495 | ~w502 | w503 | ~w504)
				w519[89] <= 1'h0;
			if (w513 | ~w495 | ~w502 | w503 | ~w504)
				w519[90] <= 1'h0;
			if (w514 | ~w495 | ~w502 | w503 | ~w504)
				w519[91] <= 1'h0;
			if (w513 | w495 | ~w502 | w503 | ~w504)
				w519[92] <= 1'h0;
			if (w514 | w495 | ~w502 | w503 | ~w504)
				w519[93] <= 1'h0;
			if (w513 | ~w495 | ~w502 | w503 | ~w504)
				w519[94] <= 1'h0;
			if (w514 | ~w495 | ~w502 | w503 | ~w504)
				w519[95] <= 1'h0;
			if (w513 | w500 | w495 | w502 | ~w503 | ~w504)
				w519[96] <= 1'h0;
			if (w514 | w500 | w495 | w502 | ~w503 | ~w504)
				w519[97] <= 1'h0;
			if (w513 | ~w500 | w495 | w502 | ~w503 | ~w504)
				w519[98] <= 1'h0;
			if (w514 | ~w500 | w495 | w502 | ~w503 | ~w504)
				w519[99] <= 1'h0;
			if (w513 | w500 | ~w495 | w502 | ~w503 | ~w504)
				w519[100] <= 1'h0;
			if (w514 | w500 | ~w495 | w502 | ~w503 | ~w504)
				w519[101] <= 1'h0;
			if (w513 | ~w500 | ~w495 | w502 | ~w503 | ~w504)
				w519[102] <= 1'h0;
			if (w514 | ~w500 | ~w495 | w502 | ~w503 | ~w504)
				w519[103] <= 1'h0;
			if (w513 | w500 | w495 | w502 | ~w503 | ~w504)
				w519[104] <= 1'h0;
			if (w514 | w500 | w495 | w502 | ~w503 | ~w504)
				w519[105] <= 1'h0;
			if (w513 | ~w500 | w495 | w502 | ~w503 | ~w504)
				w519[106] <= 1'h0;
			if (w514 | ~w500 | w495 | w502 | ~w503 | ~w504)
				w519[107] <= 1'h0;
			if (w513 | w500 | ~w495 | w502 | ~w503 | ~w504)
				w519[108] <= 1'h0;
			if (w514 | w500 | ~w495 | w502 | ~w503 | ~w504)
				w519[109] <= 1'h0;
			if (w513 | ~w500 | ~w495 | w502 | ~w503 | ~w504)
				w519[110] <= 1'h0;
			if (w514 | ~w500 | ~w495 | w502 | ~w503 | ~w504)
				w519[111] <= 1'h0;
			if (w513 | w495 | w502 | ~w503 | ~w504)
				w519[112] <= 1'h0;
			if (w514 | w495 | w502 | ~w503 | ~w504)
				w519[113] <= 1'h0;
			if (w513 | ~w495 | w502 | ~w503 | ~w504)
				w519[114] <= 1'h0;
			if (w514 | ~w495 | w502 | ~w503 | ~w504)
				w519[115] <= 1'h0;
			if (w513 | w502 | ~w503 | ~w504)
				w519[116] <= 1'h0;
			if (w514 | w502 | ~w503 | ~w504)
				w519[117] <= 1'h0;
		end

		if (w519[0])
			w520[0] <= w498;
		if (w519[1])
			w520[1] <= w498;
		if (w519[2])
			w520[2] <= w499;
		if (w519[3])
			w520[3] <= w499;
		if (w519[4])
			w520[4] <= w496;
		if (w519[5])
			w520[5] <= w496;
		if (w519[6])
			w520[6] <= w497;
		if (w519[7])
			w520[7] <= w497;
		if (w519[8])
			w520[8] <= w498;
		if (w519[9])
			w520[9] <= w498;
		if (w519[10])
			w520[10] <= w498;
		if (w519[11])
			w520[11] <= w498;
		if (w519[12])
			w520[12] <= w499;
		if (w519[13])
			w520[13] <= w499;
		if (w519[14])
			w520[14] <= w497;
		if (w519[15])
			w520[15] <= w497;
		if (w519[16])
			w520[16] <= w497;
		if (w519[17])
			w520[17] <= w497;
		if (w519[18])
			w520[18] <= w498;
		if (w519[19])
			w520[19] <= w498;
		if (w519[20])
			w520[20] <= w499;
		if (w519[21])
			w520[21] <= w499;
		if (w519[22])
			w520[22] <= w496;
		if (w519[23])
			w520[23] <= w496;
		if (w519[24])
			w520[24] <= w497;
		if (w519[25])
			w520[25] <= w497;
		if (w519[26])
			w520[26] <= w498;
		if (w519[27])
			w520[27] <= w498;
		if (w519[28])
			w520[28] <= w499;
		if (w519[29])
			w520[29] <= w499;
		if (w519[30])
			w520[30] <= w496;
		if (w519[31])
			w520[31] <= w496;
		if (w519[32])
			w520[32] <= w497;
		if (w519[33])
			w520[33] <= w497;

		if (w519[34])
			w520[34] <= w498;
		if (w519[35])
			w520[35] <= w498;
		if (w519[36])
			w520[36] <= w498;
		if (w519[37])
			w520[37] <= w498;
		if (w519[38])
			w520[38] <= w498;
		if (w519[39])
			w520[39] <= w498;
		if (w519[40])
			w520[40] <= w499;
		if (w519[41])
			w520[41] <= w499;
		if (w519[42])
			w520[42] <= w499;
		if (w519[43])
			w520[43] <= w499;
		if (w519[44])
			w520[44] <= w499;
		if (w519[45])
			w520[45] <= w499;
		if (w519[46])
			w520[46] <= w496;
		if (w519[47])
			w520[47] <= w496;
		if (w519[48])
			w520[48] <= w496;
		if (w519[49])
			w520[49] <= w496;
		if (w519[50])
			w520[50] <= w496;
		if (w519[51])
			w520[51] <= w496;
		if (w519[52])
			w520[52] <= w497;
		if (w519[53])
			w520[53] <= w497;
		if (w519[54])
			w520[54] <= w497;
		if (w519[55])
			w520[55] <= w497;
		if (w519[56])
			w520[56] <= w497;
		if (w519[57])
			w520[57] <= w497;
		if (w519[58])
			w520[58] <= w498;
		if (w519[59])
			w520[59] <= w498;
		if (w519[60])
			w520[60] <= w498;
		if (w519[61])
			w520[61] <= w498;
		if (w519[62])
			w520[62] <= w499;
		if (w519[63])
			w520[63] <= w499;
		if (w519[64])
			w520[64] <= w499;
		if (w519[65])
			w520[65] <= w499;
		if (w519[66])
			w520[66] <= w499;
		if (w519[67])
			w520[67] <= w499;
		if (w519[68])
			w520[68] <= w499;
		if (w519[69])
			w520[69] <= w499;
		if (w519[70])
			w520[70] <= w497;
		if (w519[71])
			w520[71] <= w497;
		if (w519[72])
			w520[72] <= w498;
		if (w519[73])
			w520[73] <= w498;
		if (w519[74])
			w520[74] <= w498;
		if (w519[75])
			w520[75] <= w498;

		if (w519[76])
			w520[76] <= w498;
		if (w519[77])
			w520[77] <= w498;
		if (w519[78])
			w520[78] <= w498;
		if (w519[79])
			w520[79] <= w498;
		if (w519[80])
			w520[80] <= w499;
		if (w519[81])
			w520[81] <= w499;
		if (w519[82])
			w520[82] <= w499;
		if (w519[83])
			w520[83] <= w499;
		if (w519[84])
			w520[84] <= w499;
		if (w519[85])
			w520[85] <= w499;
		if (w519[86])
			w520[86] <= w499;
		if (w519[87])
			w520[87] <= w499;
		if (w519[88])
			w520[88] <= w496;
		if (w519[89])
			w520[89] <= w496;
		if (w519[90])
			w520[90] <= w496;
		if (w519[91])
			w520[91] <= w496;
		if (w519[92])
			w520[92] <= w497;
		if (w519[93])
			w520[93] <= w497;
		if (w519[94])
			w520[94] <= w497;
		if (w519[95])
			w520[95] <= w497;
		if (w519[96])
			w520[96] <= w498;
		if (w519[97])
			w520[97] <= w498;
		if (w519[98])
			w520[98] <= w498;
		if (w519[99])
			w520[99] <= w498;
		if (w519[100])
			w520[100] <= w498;
		if (w519[101])
			w520[101] <= w498;
		if (w519[102])
			w520[102] <= w498;
		if (w519[103])
			w520[103] <= w498;
		if (w519[104])
			w520[104] <= w499;
		if (w519[105])
			w520[105] <= w499;
		if (w519[106])
			w520[106] <= w499;
		if (w519[107])
			w520[107] <= w499;
		if (w519[108])
			w520[108] <= w499;
		if (w519[109])
			w520[109] <= w499;
		if (w519[110])
			w520[110] <= w499;
		if (w519[111])
			w520[111] <= w499;
		if (w519[112])
			w520[112] <= w496;
		if (w519[113])
			w520[113] <= w496;
		if (w519[114])
			w520[114] <= w496;
		if (w519[115])
			w520[115] <= w496;
		if (w519[116])
			w520[116] <= w497;
		if (w519[117])
			w520[117] <= w497;
		
		if (c4)
		begin
			for (i = 0; i < 68; i = i + 1)
				w521[i] <= 1'h1;
		end
		else if (w515)
		begin
			for (i = 0; i < 34; i = i + 1)
			begin
				if (w520[i])
				begin
					for (j = 0; j < 68; j = j + 1)
						if (ucode[117 - i][j * 4 + 3])
							w521[j] <= 1'h0;
				end
			end
		end
		else if (w516)
		begin
			for (i = 0; i < 34; i = i + 1)
			begin
				if (w520[i])
				begin
					for (j = 0; j < 68; j = j + 1)
						if (ucode[117 - i][j * 4 + 2])
							w521[j] <= 1'h0;
				end
			end
		end
		else if (w517)
		begin
			for (i = 0; i < 34; i = i + 1)
			begin
				if (w520[i])
				begin
					for (j = 0; j < 68; j = j + 1)
						if (ucode[117 - i][j * 4 + 1])
							w521[j] <= 1'h0;
				end
			end
		end
		else if (w518)
		begin
			for (i = 0; i < 34; i = i + 1)
			begin
				if (w520[i])
				begin
					for (j = 0; j < 68; j = j + 1)
						if (ucode[117 - i][j * 4 + 0])
							w521[j] <= 1'h0;
				end
			end
		end
		
		if (w512)
		begin
			for (i = 0; i < 17; i = i + 1)
				w523[i] <= w521[i * 4 + 3];
		end
		else if (w511)
		begin
			for (i = 0; i < 17; i = i + 1)
				w523[i] <= w521[i * 4 + 2];
		end
		else if (w510)
		begin
			for (i = 0; i < 17; i = i + 1)
				w523[i] <= w521[i * 4 + 1];
		end
		else if (w509)
		begin
			for (i = 0; i < 17; i = i + 1)
				w523[i] <= w521[i * 4 + 0];
		end
		
		if (c3)
			w522 <= ~w523;
		else if (c5)
		begin
			w522[15] <= 1'h0;
			w522[16] <= 1'h0;
		end
		
		if (c4)
		begin
			for (i = 0; i < 68; i = i + 1)
				w528[i] <= 1'h1;
		end
		else if (w527)
		begin
			for (i = 0; i < 84; i = i + 1)
			begin
				if (w520[i + 34])
				begin
					for (j = 0; j < 68; j = j + 1)
					begin
						if (ucode[83 - i][j * 4 + 3])
							w528[j] <= 1'h0;
					end
				end
			end
		end
		else if (w526)
		begin
			for (i = 0; i < 84; i = i + 1)
			begin
				if (w520[i + 34])
				begin
					for (j = 0; j < 68; j = j + 1)
					begin
						if (ucode[83 - i][j * 4 + 1])
							w528[j] <= 1'h0;
					end
				end
			end
		end
		else if (w525)
		begin
			for (i = 0; i < 84; i = i + 1)
			begin
				if (w520[i + 34])
				begin
					for (j = 0; j < 68; j = j + 1)
					begin
						if (ucode[83 - i][j * 4 + 2])
							w528[j] <= 1'h0;
					end
				end
			end
		end
		else if (w524)
		begin
			for (i = 0; i < 84; i = i + 1)
			begin
				if (w520[i + 34])
				begin
					for (j = 0; j < 68; j = j + 1)
					begin
						if (ucode[83 - i][j * 4 + 0])
							w528[j] <= 1'h0;
					end
				end
			end
		end
		
		if (c3)
			w529 <= ~w528;
		
		if (c5)
		begin
			for (i = 0; i < 68; i = i + 1)
				w529[i] <= 1'h0;
		end
	end

endmodule

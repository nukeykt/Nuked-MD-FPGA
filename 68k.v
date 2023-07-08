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
	output [22:0] ADDRESS,
	output AS,
	output LDS,
	output UDS
	);
	
	wire w1;
	reg l1;
	reg l2;
	wire w2;
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
	//reg l6;
	reg l7;
	reg l8;
	reg l9;
	//reg l10;
	wire w101;
	wire w102;
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
	reg [67:0] w528;
	reg [67:0] w529;
	reg [67:0] ucode[0:117];
	reg [15:0] w530;
	wire [170:0] a0_pla;
	reg [164:20] a0_pla_mem;
	wire [9:0] w531;
	wire w532;
	wire w533;
	wire [149:0] a2_pla;
	wire a2_pla_g1, a2_pla_g2, a2_pla_g3;
	wire [9:0] w534;
	wire [9:0] w535;
	wire w536;
	wire w537;
	reg [15:0] w538;
	wire [31:0] irdbus;
	wire [31:0] irdbus_dbg;
	wire [31:0] irdbus_normal;
	wire w539;
	wire w540;
	wire w541;
	wire w542;
	wire w543;
	wire w544;
	reg w545;
	wire w546;
	wire w547;
	wire w548;
	reg w549;
	reg w550;
	reg w551;
	reg w552;
	wire w553;
	wire w554;
	wire w555, w555_1;
	wire w556, w556_1;
	wire w557;
	wire w558;
	wire [3:0] w559;
	wire [3:0] w560;
	wire [17:0] cond_pla1;
	wire [22:0] cond_pla2;
	wire w561;
	wire w562;
	wire w563;
	wire w564;
	wire w565;
	wire w566;
	wire w567;
	wire w568;
	wire [49:0] ird_pla1;
	wire [31:0] ird_pla2;
	wire [29:0] ird_pla3;
	wire [21:0] ird_pla4;
	wire [14:0] w569;
	wire w570;
	wire w571;
	wire w572;
	wire w573;
	wire w574;
	wire w575;
	wire w576;
	reg w577;
	wire w578;
	wire w579;
	wire w580;
	wire w581;
	wire w582;
	wire w583;
	wire w584;
	wire w585;
	wire w586;
	wire w587;
	wire w588;
	wire w589;
	wire w590;
	wire [15:0] w591;
	wire w592;
	wire w593;
	wire w594;
	wire w595;
	reg [3:0] w596;
	wire [17:0] w597;
	reg w598;
	wire w599;
	wire w600;
	wire w601;
	wire w602;
	wire w603;
	wire w604;
	reg [15:0] alu_io;
	reg w605;
	reg w606;
	reg w607;
	reg w609;
	reg w610;
	reg w611;
	wire w612;
	reg w613;
	wire w614;
	reg w615;
	reg [4:0] w616;
	reg w617;
	reg w618;
	wire w619;
	reg w620;
	wire [3:0] w621;
	wire w625;
	wire [3:0] w626;
	wire w627;
	wire w628;
	wire w629;
	wire w630;
	wire w631;
	wire w632;
	wire w633;
	reg w634;
	wire w635;
	wire w636;
	wire w637;
	reg w638;
	reg w639;
	wire w640;
	reg w641;
	wire w642;
	wire w643;
	reg w644;
	wire w645;
	wire w646;
	wire w647;
	reg w648;
	reg w649;
	reg w650;
	wire w651;
	wire w652;
	wire w653;
	wire w654;
	wire w655;
	reg w656;
	reg w657;
	reg w658;
	reg w659;
	reg w660;
	reg w661;
	reg w662;
	reg w663;
	reg w664;
	reg w665;
	reg w666;
	wire w667;
	wire w668;
	wire w669;
	wire w670;
	wire w671;
	wire w672;
	wire w673;
	wire w674;
	wire w675;
	wire w676;
	wire w677;
	wire w678;
	wire w679;
	wire w680;
	wire w681;
	wire w682;
	wire w683;
	wire w684;
	wire w685;
	wire w686;
	wire w687;
	wire w688;
	wire w689;
	wire w690;
	reg w691;
	reg w692;
	reg w693;
	reg w694;
	reg w695;
	reg w696;
	reg w697;
	reg w698;
	reg w699;
	reg w700;
	reg w701;
	reg w702;
	reg w703;
	reg w704;
	reg w705;
	reg w706;
	reg w707;
	reg w708;
	reg w709;
	reg w710;
	reg w711;
	wire w712;
	wire w713;
	reg w714;
	reg w715;
	reg w716;
	reg w717;
	reg w718;
	reg w719;
	reg w720;
	reg w721;
	reg w722;
	reg w723;
	reg w724;
	reg w725;
	reg w726;
	reg w727;
	reg w728;
	reg w729;
	reg w730;
	reg w731;
	reg w732;
	reg w733;
	wire w734;
	wire w735;
	wire w736;
	reg w737;
	reg w738;
	reg w739;
	reg w740;
	reg w741;
	reg w742;
	wire w743;
	reg w744;
	wire w745;
	reg w746;
	wire w747;
	reg w748;
	wire w749;
	reg w750;
	reg w751;
	reg w752;
	reg w753;
	reg w754;
	reg w755;
	reg w756;
	wire w757;
	reg w758;
	reg w759;
	reg w760;
	reg w761;
	reg w762;
	reg w763;
	wire w764;
	reg w765;
	reg w766;
	reg w767;
	reg w768;
	reg w769;
	reg w770;
	wire w771;
	reg w773;
	wire w774;
	reg w775;
	reg w776;
	reg w777;
	wire w778;
	reg w779;
	wire w780;
	reg w781;
	wire w783;
	reg w784;
	wire w785;
	wire w786;
	wire w787;
	wire w789;
	wire w790;
	wire w791;
	wire w792;
	reg w793;
	wire w794;
	wire w795;
	wire w796;
	wire w797;
	wire w798;
	wire w799;
	wire w800;
	wire w801;
	wire w802;
	wire w803;
	wire w804;
	wire w805;
	wire w806;
	reg w807;
	reg w808;
	wire w809;
	wire w810;
	wire w811;
	reg w812;
	wire w813;
	wire w814;
	wire w815;
	wire w816;
	wire w817;
	reg w818;
	reg w819;
	wire w820;
	wire w821;
	wire w822;
	wire w823;
	wire w824;
	wire w825;
	wire w826;
	wire w827;
	wire w828;
	wire w829;
	wire w830;
	wire w831;
	wire w832;
	reg w833;
	reg w834;
	reg w835;
	wire w836;
	wire w837;
	reg w838;
	reg w839;
	wire w840;
	reg w841;
	wire w842;
	wire w843;
	reg w844;
	reg w845;
	reg w846;
	wire w847;
	reg w848;
	wire w849;
	reg w850;
	reg w851;
	reg w852;
	wire w853;
	wire w854;
	wire w855;
	wire w856;
	wire w857;
	wire w858;
	wire w859;
	wire w860;
	wire w861;
	wire w862;
	wire w863;
	wire w864;
	wire w865;
	wire w866;
	wire w867;
	wire w868;
	wire w869;
	wire w870;
	wire w871;
	wire w872;
	wire w873;
	wire w874;
	wire w875;
	wire w876;
	wire w877;
	wire w878;
	wire w879;
	wire w880;
	wire w881;
	reg w882;
	wire w883;
	reg w884;
	reg w885;
	wire w886;
	wire w887;
	wire w888;
	reg w889;
	wire w890
	reg w891;
	wire w892;
	reg w893;
	reg w894;
	wire w895;
	wire w896;
	wire w897;
	reg w898;
	wire w899;
	wire w900;
	wire w901;
	wire w902;
	wire w903;
	reg w904;
	wire w905;
	wire w906;
	wire w907;
	wire w908;
	wire w909;
	wire w910;
	wire w911;
	wire w912;
	reg w913;
	wire w914;
	reg w915;
	wire w916;
	reg w917;
	wire w918;
	wire w919;
	wire w920;
	wire w921;
	wire w922;
	wire w923;
	reg w924;
	wire w925;
	wire w926;
	reg w927;
	wire w928;
	reg w929;
	wire w930;
	wire w931;
	wire w932;
	wire w933;
	wire w934;
	reg w935;
	wire w936;
	reg w937;
	wire w938;
	reg w940;
	reg w941;
	wire w942;
	wire w943;
	reg [4:0] w944;
	reg w945;
	wire w946;
	wire [15:0] w947;
	reg [15:0] w948;
	wire [15:0] w949;
	reg [15:0] w950;
	wire [15:0] w951;
	wire [15:0] w952;
	wire [15:0] w953;
	wire [18:0] w954;
	wire w955;
	wire w956;
	wire w957;
	wire w958;
	wire w959;
	wire w960;
	wire [15:0] w961;
	reg [15:0] w962;
	reg [15:0] w963;
	reg [15:0] w964;
	wire w965;
	wire w966;
	reg w967;
	wire w968;
	wire w969;
	reg w970;
	reg w971;
	reg w972;
	wire w973;
	wire w974;
	wire w975;
	wire w976;
	reg w977;
	reg w978;
	wire w979;
	reg [15:0] w980;
	reg [15:0] w981;
	wire w982;
	wire w983;
	reg [15:0] w984;
	wire w985;
	wire w986;
	wire w987;
	reg [15:0] data_l;
	reg as_l1;
	reg as_l2;
	reg as_l3;
	
	
	reg [15:0] b1[0:3];
	reg [15:0] b2[0:3];
	reg [15:0] b3[0:3];
	
	reg [15:0] r1[0:17];
	reg [15:0] r2;
	reg [15:0] r3;
	reg [15:0] r4;
	reg [15:0] r5;
	reg [15:0] r6[0:9];
	reg [15:0] r7[0:8];
	reg [15:0] r8;
	
	reg [15:0] data_io;
	
	wire [15:0] address_mux;
	
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
		//if (l1 & l2)
		//	w1 <= 1'h0;
		//else if (~l1)
		//	w1 <= c3;
		//else if (~l2)
		//	w1 <= c2;
		//if (l3 & l4)
		//	w2 <= 1'h0;
		//else if (~l3)
		//	w2 <= c3;
		//else if (~l4)
		//	w2 <= c2;
	end
	
	assign w1 = (~l2) ? c2 : ((~l1) ? c3 : 1'h0);
	assign w2 = (~l4) ? c2 : ((~l3) ? c3 : 1'h0);
	
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
			//l6 <= w529[57];
			l7 <= ~w529[58];
			l8 <= w529[57];
			l9 <= w636;
			//l10 <= w529[57];
		end
		
	//	if (l7)
	//		w101 <= 1'h0;
	//	else
	//	begin
	//		if (~l6)
	//			w101 <= c3;
	//		if (l8)
	//			w101 <= c2;
	//	end
		
	//	if (l9)
	//		w102 <= 1'h0;
	//	else
	//	begin
	//		if (~l10)
	//			w102 <= c3;
	//		if (l8)
	//			w102 <= c2;
	//	end
		
		if (c1)
		begin
			w103 <= ~w529[55];
			w105 <= ~w529[54];
		end
	end
	
	assign w101 = l7 ? 1'h0 : (l8 ? c2 : c3);
	assign w102 = l9 ? 1'h0 : (l8 ? c2 : c3);
	
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
	
	always @(posedge MCLK)
	begin
		if (w943)
			w530 <= ~w984;
	end
	
	assign a0_pla[0] = (w530 & 16'hf100) == 16'h0100;
	assign a0_pla[1] = (w530 & 16'hd000) == 16'h1000;
	assign a0_pla[2] = (w530 & 16'hf1c0) == 16'h4180;
	assign a0_pla[3] = (w530 & 16'hf1c0) == 16'h4000;
	assign a0_pla[4] = (w530 & 16'hf940) == 16'h4040;
	assign a0_pla[5] = (w530 & 16'hff40) == 16'h4a40;
	assign a0_pla[6] = (w530 & 16'hb080) == 16'h8000;
	assign a0_pla[7] = (w530 & 16'hb040) == 16'h8040;
	assign a0_pla[8] = (w530 & 16'h9080) == 16'h9000;
	assign a0_pla[9] = (w530 & 16'h9140) == 16'h9040;
	assign a0_pla[10] = (w530 & 16'hf080) == 16'h5000;
	assign a0_pla[11] = (w530 & 16'hf040) == 16'h5040;
	assign a0_pla[12] = (w530 & 16'hf8c0) == 16'he0c0;
	
	assign w532 = ~(a0_pla[0] | a0_pla[1] | a0_pla[2] | a0_pla[3] | a0_pla[4] | a0_pla[5]
		| a0_pla[6] | a0_pla[7] | a0_pla[8] | a0_pla[9] | a0_pla[10] | a0_pla[11] | a0_pla[12]);
	
	assign a0_pla[13] = (w530 & 16'hf000) == 16'h2000;
	assign a0_pla[14] = (w530 & 16'hf9c0) == 16'h4080;
	assign a0_pla[15] = (w530 & 16'hffc0) == 16'h4a80;
	assign a0_pla[16] = (w530 & 16'hf0c0) == 16'h5080;
	assign a0_pla[17] = (w530 & 16'ha0c0) == 16'h8080;
	assign a0_pla[18] = (w530 & 16'h90c0) == 16'h9080;
	assign a0_pla[19] = (w530 & 16'h9180) == 16'h9180;
	
	assign w533 = ~(a0_pla[13] | a0_pla[14] | a0_pla[15] | a0_pla[16] | a0_pla[17]
		| a0_pla[18] | a0_pla[19]);
	
	always @(posedge MCLK)
	begin
		for (i = 20; i <= 164; i = i + 1)
			a0_pla_mem[i] <= w450 ? 1'h1 : a0_pla[i];
	end
	
	assign a0_pla[20] = a0_pla_mem[20] & (w530 & 16'h003f) == 16'h0039 & ~w533;
	assign a0_pla[21] = a0_pla_mem[21] & (w530 & 16'h003f) == 16'h0039 & ~w532;
	assign a0_pla[22] = a0_pla_mem[22] & (w530 & 16'h003f) == 16'h0038 & ~w533;
	assign a0_pla[23] = a0_pla_mem[23] & (w530 & 16'h003f) == 16'h0038 & ~w532;
	assign a0_pla[24] = a0_pla_mem[24] & (w530 & 16'h0038) == 16'h0010 & ~w533;
	assign a0_pla[25] = a0_pla_mem[25] & (w530 & 16'h0038) == 16'h0010 & ~w532;
	assign a0_pla[26] = a0_pla_mem[26] & (w530 & 16'h0038) == 16'h0028 & ~w533;
	assign a0_pla[27] = a0_pla_mem[27] & (w530 & 16'h003f) == 16'h003a & ~w533;
	assign a0_pla[28] = a0_pla_mem[28] & (w530 & 16'h0038) == 16'h0028 & ~w532;
	assign a0_pla[29] = a0_pla_mem[29] & (w530 & 16'h003f) == 16'h003a & ~w532;
	assign a0_pla[30] = a0_pla_mem[30] & (w530 & 16'h0038) == 16'h0030 & ~w533;
	assign a0_pla[31] = a0_pla_mem[31] & (w530 & 16'h003f) == 16'h003b & ~w533;
	assign a0_pla[32] = a0_pla_mem[32] & (w530 & 16'h0038) == 16'h0030 & ~w532;
	assign a0_pla[33] = a0_pla_mem[33] & (w530 & 16'h003f) == 16'h003b & ~w532;
	assign a0_pla[34] = a0_pla_mem[34] & (w530 & 16'hb1f8) == 16'h8108;
	assign a0_pla[35] = a0_pla_mem[35] & (w530 & 16'hb1f8) == 16'h9188;
	assign a0_pla[36] = a0_pla_mem[36] & (w530 & 16'hb1b8) == 16'h9108;
	assign a0_pla[37] = a0_pla_mem[37] & (w530 & 16'hffff) == 16'h4e71;
	assign a0_pla[38] = a0_pla_mem[38] & (w530 & 16'hfff8) == 16'h4ac0;
	assign a0_pla[39] = a0_pla_mem[39] & (w530 & 16'hfff0) == 16'h4e40;
	assign a0_pla[40] = a0_pla_mem[40] & (w530 & 16'hffff) == 16'h4e76;
	assign a0_pla[41] = a0_pla_mem[41] & (w530 & 16'hf1f8) == 16'h0180;
	assign a0_pla[42] = a0_pla_mem[42] & (w530 & 16'hf178) == 16'h0140;
	assign a0_pla[43] = a0_pla_mem[43] & (w530 & 16'hfff8) == 16'h4a80;
	assign a0_pla[44] = a0_pla_mem[44] & (w530 & 16'hf1f8) == 16'h0100;
	assign a0_pla[45] = a0_pla_mem[45] & (w530 & 16'hf1f8) == 16'h4180;
	assign a0_pla[46] = a0_pla_mem[46] & (w530 & 16'hf1b8) == 16'hb108;
	assign a0_pla[47] = a0_pla_mem[47] & (w530 & 16'hf1f8) == 16'hb188;
	assign a0_pla[48] = a0_pla_mem[48] & (w530 & 16'hf1f0) == 16'hb080;
	assign a0_pla[49] = a0_pla_mem[49] & (w530 & 16'hf1f0) == 16'hb1c0;
	assign a0_pla[50] = a0_pla_mem[50] & (w530 & 16'hf1f0) == 16'hb0c0;
	assign a0_pla[51] = a0_pla_mem[51] & (w530 & 16'hf1b0) == 16'hb000;
	assign a0_pla[52] = a0_pla_mem[52] & (w530 & 16'hf0f8) == 16'h50c8;
	assign a0_pla[53] = a0_pla_mem[53] & (w530 & 16'hf1f8) == 16'h81c0;
	assign a0_pla[54] = a0_pla_mem[54] & (w530 & 16'hf1f8) == 16'h80c0;
	assign a0_pla[55] = a0_pla_mem[55] & (w530 & 16'hf1f0) == 16'hc140;
	assign a0_pla[56] = a0_pla_mem[56] & (w530 & 16'hf1f8) == 16'hc188;
	assign a0_pla[57] = a0_pla_mem[57] & (w530 & 16'hfff8) == 16'h48c0;
	assign a0_pla[58] = a0_pla_mem[58] & (w530 & 16'h003f) == 16'h003c & ~w533;
	assign a0_pla[59] = a0_pla_mem[59] & (w530 & 16'h003f) == 16'h003c & ~w532;
	assign a0_pla[60] = a0_pla_mem[60] & (w530 & 16'hffff) == 16'h4ef9;
	assign a0_pla[61] = a0_pla_mem[61] & (w530 & 16'hffff) == 16'h4ef8;
	assign a0_pla[62] = a0_pla_mem[62] & (w530 & 16'hfff8) == 16'h4ed0;
	assign a0_pla[63] = a0_pla_mem[63] & (w530 & 16'hfff8) == 16'h4ee8;
	assign a0_pla[64] = a0_pla_mem[64] & (w530 & 16'hffff) == 16'h4efa;
	assign a0_pla[65] = a0_pla_mem[65] & (w530 & 16'hfff8) == 16'h4ef0;
	assign a0_pla[66] = a0_pla_mem[66] & (w530 & 16'hffff) == 16'h4efb;
	assign a0_pla[67] = a0_pla_mem[67] & (w530 & 16'hffff) == 16'h4eb9;
	assign a0_pla[68] = a0_pla_mem[68] & (w530 & 16'hffff) == 16'h4eb8;
	assign a0_pla[69] = a0_pla_mem[69] & (w530 & 16'hfff8) == 16'h4e90;
	assign a0_pla[70] = a0_pla_mem[70] & (w530 & 16'hfff8) == 16'h4ea8;
	assign a0_pla[71] = a0_pla_mem[71] & (w530 & 16'hffff) == 16'h4eba;
	assign a0_pla[72] = a0_pla_mem[72] & (w530 & 16'hfff8) == 16'h4eb0;
	assign a0_pla[73] = a0_pla_mem[73] & (w530 & 16'hffff) == 16'h4ebb;
	assign a0_pla[74] = a0_pla_mem[74] & (w530 & 16'hf1ff) == 16'h41f9;
	assign a0_pla[75] = a0_pla_mem[75] & (w530 & 16'hf1ff) == 16'h41f8;
	assign a0_pla[76] = a0_pla_mem[76] & (w530 & 16'hffb8) == 16'h4ca8;
	assign a0_pla[77] = a0_pla_mem[77] & (w530 & 16'hffbf) == 16'h4cba;
	assign a0_pla[78] = a0_pla_mem[78] & (w530 & 16'hffb8) == 16'h4c90;
	assign a0_pla[79] = a0_pla_mem[79] & (w530 & 16'hffb8) == 16'h4cb0;
	assign a0_pla[80] = a0_pla_mem[80] & (w530 & 16'hffbf) == 16'h4cbb;
	assign a0_pla[81] = a0_pla_mem[81] & (w530 & 16'hf1f8) == 16'h41d0;
	assign a0_pla[82] = a0_pla_mem[82] & (w530 & 16'hf1f8) == 16'h41e8;
	assign a0_pla[83] = a0_pla_mem[83] & (w530 & 16'hf1ff) == 16'h41fa;
	assign a0_pla[84] = a0_pla_mem[84] & (w530 & 16'hf1f8) == 16'h41f0;
	assign a0_pla[85] = a0_pla_mem[85] & (w530 & 16'hf1ff) == 16'h41fb;
	assign a0_pla[86] = a0_pla_mem[86] & (w530 & 16'hfff8) == 16'h4e50;
	assign a0_pla[87] = a0_pla_mem[87] & (w530 & 16'hffbf) == 16'h4cb9;
	assign a0_pla[88] = a0_pla_mem[88] & (w530 & 16'hffbf) == 16'h4cb8;
	assign a0_pla[89] = a0_pla_mem[89] & (w530 & 16'hfff8) == 16'h4e60;
	assign a0_pla[90] = a0_pla_mem[90] & (w530 & 16'hf1f8) == 16'h0148;
	assign a0_pla[91] = a0_pla_mem[91] & (w530 & 16'hf1f8) == 16'h0108;
	assign a0_pla[92] = a0_pla_mem[92] & (w530 & 16'hf1f8) == 16'h01c8;
	assign a0_pla[93] = a0_pla_mem[93] & (w530 & 16'hf1f8) == 16'h0188;
	assign a0_pla[94] = a0_pla_mem[94] & (w530 & 16'hf0f8) == 16'hc0c0;
	assign a0_pla[95] = a0_pla_mem[95] & (w530 & 16'hfff8) == 16'h4800;
	assign a0_pla[96] = a0_pla_mem[96] & (w530 & 16'hf9f8) == 16'h4080;
	assign a0_pla[97] = a0_pla_mem[97] & (w530 & 16'hf9b8) == 16'h4000;
	assign a0_pla[98] = a0_pla_mem[98] & (w530 & 16'hfff8) == 16'h4880;
	assign a0_pla[99] = a0_pla_mem[99] & (w530 & 16'hffb8) == 16'h4a00;
	assign a0_pla[100] = a0_pla_mem[100] & (w530 & 16'hf180) == 16'h0000;
	assign a0_pla[101] = a0_pla_mem[101] & (w530 & 16'hfff8) == 16'h4e58;
	assign a0_pla[102] = a0_pla_mem[102] & (w530 & 16'hffff) == 16'h4879;
	assign a0_pla[103] = a0_pla_mem[103] & (w530 & 16'hffff) == 16'h4878;
	assign a0_pla[104] = a0_pla_mem[104] & (w530 & 16'h0038) == 16'h0020 & ~w533;
	assign a0_pla[105] = a0_pla_mem[105] & (w530 & 16'h0038) == 16'h0020 & ~w532;
	assign a0_pla[106] = a0_pla_mem[106] & (w530 & 16'hfff8) == 16'h4850;
	assign a0_pla[107] = a0_pla_mem[107] & (w530 & 16'hfff8) == 16'h4868;
	assign a0_pla[108] = a0_pla_mem[108] & (w530 & 16'hffff) == 16'h487a;
	assign a0_pla[109] = a0_pla_mem[109] & (w530 & 16'hfff8) == 16'h4870;
	assign a0_pla[110] = a0_pla_mem[110] & (w530 & 16'hffff) == 16'h487b;
	assign a0_pla[111] = a0_pla_mem[111] & (w530 & 16'h0038) == 16'h0018 & ~w533;
	assign a0_pla[112] = a0_pla_mem[112] & (w530 & 16'h0038) == 16'h0018 & ~w532;
	assign a0_pla[113] = a0_pla_mem[113] & (w530 & 16'hffb8) == 16'h4c98;
	assign a0_pla[114] = a0_pla_mem[114] & (w530 & 16'hffb8) == 16'h48a0;
	assign a0_pla[115] = a0_pla_mem[115] & (w530 & 16'hfff0) == 16'h23c0;
	assign a0_pla[116] = a0_pla_mem[116] & (w530 & 16'hdff0) == 16'h13c0;
	assign a0_pla[117] = a0_pla_mem[117] & (w530 & 16'hf0f0) == 16'h5080;
	assign a0_pla[118] = a0_pla_mem[118] & (w530 & 16'hf0f8) == 16'h5048;
	assign a0_pla[119] = a0_pla_mem[119] & (w530 & 16'hf0b8) == 16'h5000;
	assign a0_pla[120] = a0_pla_mem[120] & (w530 & 16'hfff0) == 16'h21c0;
	assign a0_pla[121] = a0_pla_mem[121] & (w530 & 16'hdff0) == 16'h11c0;
	assign a0_pla[122] = a0_pla_mem[122] & (w530 & 16'hb1f8) == 16'h8100;
	assign a0_pla[123] = a0_pla_mem[123] & (w530 & 16'hf100) == 16'h7000;
	assign a0_pla[124] = a0_pla_mem[124] & (w530 & 16'hf1f0) == 16'h2140;
	assign a0_pla[125] = a0_pla_mem[125] & (w530 & 16'hd1f0) == 16'h1140;
	assign a0_pla[126] = a0_pla_mem[126] & (w530 & 16'hf1f0) == 16'h20c0;
	assign a0_pla[127] = a0_pla_mem[127] & (w530 & 16'hd1f0) == 16'h10c0;
	assign a0_pla[128] = a0_pla_mem[128] & (w530 & 16'hf1f0) == 16'h2100;
	assign a0_pla[129] = a0_pla_mem[129] & (w530 & 16'hd1f0) == 16'h1100;
	assign a0_pla[130] = a0_pla_mem[130] & (w530 & 16'hf1f0) == 16'h2080;
	assign a0_pla[131] = a0_pla_mem[131] & (w530 & 16'hd1f0) == 16'h1080;
	assign a0_pla[132] = a0_pla_mem[132] & (w530 & 16'hf1f0) == 16'h2180;
	assign a0_pla[133] = a0_pla_mem[133] & (w530 & 16'hd1f0) == 16'h1180;
	assign a0_pla[134] = a0_pla_mem[134] & (w530 & 16'hf1f8) == 16'hb180;
	assign a0_pla[135] = a0_pla_mem[135] & (w530 & 16'hf1b8) == 16'hb100;
	assign a0_pla[136] = a0_pla_mem[136] & (w530 & 16'ha1f0) == 16'h8080;
	assign a0_pla[137] = a0_pla_mem[137] & (w530 & 16'hb1b8) == 16'h9180;
	assign a0_pla[138] = a0_pla_mem[138] & (w530 & 16'hb1f0) == 16'h91c0;
	assign a0_pla[139] = a0_pla_mem[139] & (w530 & 16'hb1f0) == 16'h90c0;
	assign a0_pla[140] = a0_pla_mem[140] & (w530 & 16'ha1b0) == 16'h8000;
	assign a0_pla[141] = a0_pla_mem[141] & (w530 & 16'hb1b8) == 16'h9100;
	assign a0_pla[142] = a0_pla_mem[142] & (w530 & 16'hf1b0) == 16'h2000;
	assign a0_pla[143] = a0_pla_mem[143] & (w530 & 16'hf1f0) == 16'h3040;
	assign a0_pla[144] = a0_pla_mem[144] & (w530 & 16'hd1f0) == 16'h1000;
	assign a0_pla[145] = a0_pla_mem[145] & (w530 & 16'hfdf8) == 16'h44c0;
	assign a0_pla[146] = a0_pla_mem[146] & (w530 & 16'hfffb) == 16'h4e73;
	assign a0_pla[147] = a0_pla_mem[147] & (w530 & 16'hffff) == 16'h4e75;
	assign a0_pla[148] = a0_pla_mem[148] & (w530 & 16'hf0f8) == 16'h50c0;
	assign a0_pla[149] = a0_pla_mem[149] & (w530 & 16'hffbf) == 16'h48b9;
	assign a0_pla[150] = a0_pla_mem[150] & (w530 & 16'hffbf) == 16'h48b8;
	assign a0_pla[151] = a0_pla_mem[151] & (w530 & 16'hf0e0) == 16'he080;
	assign a0_pla[152] = a0_pla_mem[152] & (w530 & 16'hf0a0) == 16'he000;
	assign a0_pla[153] = a0_pla_mem[153] & (w530 & 16'hf0e0) == 16'he0a0;
	assign a0_pla[154] = a0_pla_mem[154] & (w530 & 16'hf0a0) == 16'he020;
	assign a0_pla[155] = a0_pla_mem[155] & (w530 & 16'hffb8) == 16'h48a8;
	assign a0_pla[156] = a0_pla_mem[156] & (w530 & 16'hffb8) == 16'h4890;
	assign a0_pla[157] = a0_pla_mem[157] & (w530 & 16'hffb8) == 16'h48b0;
	assign a0_pla[158] = a0_pla_mem[158] & (w530 & 16'hffff) == 16'h4e72;
	assign a0_pla[159] = a0_pla_mem[159] & (w530 & 16'hfff8) == 16'h40c0;
	assign a0_pla[160] = a0_pla_mem[160] & (w530 & 16'hfff8) == 16'h4e68;
	assign a0_pla[161] = a0_pla_mem[161] & (w530 & 16'hfff8) == 16'h4840;
	assign a0_pla[162] = a0_pla_mem[162] & (w530 & 16'hffff) == 16'h4e70;
	assign a0_pla[163] = a0_pla_mem[163] & (w530 & 16'hf1c0) == 16'h0080 & ~a0_pla[168];
	assign a0_pla[164] = a0_pla_mem[164] & (w530 & 16'hf000) == 16'h6000 & ~a0_pla[165] & ~a0_pla[166] & ~a0_pla[167];
	assign a0_pla[165] = (w530 & 16'hf0ff) == 16'h6000 & ~a0_pla[167];
	assign a0_pla[166] = (w530 & 16'hff00) == 16'h6100 & ~a0_pla[167];
	assign a0_pla[167] = (w530 & 16'hffff) == 16'h6100;
	assign a0_pla[168] = (w530 & 16'hff80) == 16'h0880;
	assign a0_pla[169] = (w530 & 16'hf000) == 16'hf000;
	assign a0_pla[170] = (w530 & 16'hf000) == 16'ha000;
	
	assign w531 =
		(a0_pla[20] ? 10'h1e6 : 10'h3ff) &
		(a0_pla[21] ? 10'h1e2 : 10'h3ff) &
		(a0_pla[22] ? 10'h00e : 10'h3ff) &
		(a0_pla[23] ? 10'h00a : 10'h3ff) &
		(a0_pla[24] ? 10'h00b : 10'h3ff) &
		(a0_pla[25] ? 10'h006 : 10'h3ff) &
		(a0_pla[26] ? 10'h1c6 : 10'h3ff) &
		(a0_pla[27] ? 10'h1c6 : 10'h3ff) &
		(a0_pla[28] ? 10'h1c2 : 10'h3ff) &
		(a0_pla[29] ? 10'h1c2 : 10'h3ff) &
		(a0_pla[30] ? 10'h1e7 : 10'h3ff) &
		(a0_pla[31] ? 10'h1e7 : 10'h3ff) &
		(a0_pla[32] ? 10'h1e3 : 10'h3ff) &
		(a0_pla[33] ? 10'h1e3 : 10'h3ff) &
		(a0_pla[34] ? 10'h107 : 10'h3ff) &
		(a0_pla[35] ? 10'h10b : 10'h3ff) &
		(a0_pla[36] ? 10'h10f : 10'h3ff) &
		(a0_pla[37] ? 10'h363 : 10'h3ff) &
		(a0_pla[38] ? 10'h345 : 10'h3ff) &
		(a0_pla[39] ? 10'h1d0 : 10'h3ff) &
		(a0_pla[40] ? 10'h06d : 10'h3ff) &
		(a0_pla[41] ? 10'h3eb : 10'h3ff) &
		(a0_pla[42] ? 10'h3ef : 10'h3ff) &
		(a0_pla[43] ? 10'h125 : 10'h3ff) &
		(a0_pla[44] ? 10'h3e7 : 10'h3ff) &
		(a0_pla[45] ? 10'h152 : 10'h3ff) &
		(a0_pla[46] ? 10'h06b : 10'h3ff) &
		(a0_pla[47] ? 10'h06f : 10'h3ff) &
		(a0_pla[48] ? 10'h1d5 : 10'h3ff) &
		(a0_pla[49] ? 10'h1d5 : 10'h3ff) &
		(a0_pla[50] ? 10'h1d9 : 10'h3ff) &
		(a0_pla[51] ? 10'h1d1 : 10'h3ff) &
		(a0_pla[52] ? 10'h06c : 10'h3ff) &
		(a0_pla[53] ? 10'h0ae : 10'h3ff) &
		(a0_pla[54] ? 10'h0a6 : 10'h3ff) &
		(a0_pla[55] ? 10'h3e3 : 10'h3ff) &
		(a0_pla[56] ? 10'h3e3 : 10'h3ff) &
		(a0_pla[57] ? 10'h232 : 10'h3ff) &
		(a0_pla[58] ? 10'h0a7 : 10'h3ff) &
		(a0_pla[59] ? 10'h0ea : 10'h3ff) &
		(a0_pla[60] ? 10'h1f6 : 10'h3ff) &
		(a0_pla[61] ? 10'h297 : 10'h3ff) &
		(a0_pla[62] ? 10'h255 : 10'h3ff) &
		(a0_pla[63] ? 10'h2b4 : 10'h3ff) &
		(a0_pla[64] ? 10'h2b4 : 10'h3ff) &
		(a0_pla[65] ? 10'h1f7 : 10'h3ff) &
		(a0_pla[66] ? 10'h1f7 : 10'h3ff) &
		(a0_pla[67] ? 10'h1f2 : 10'h3ff) &
		(a0_pla[68] ? 10'h293 : 10'h3ff) &
		(a0_pla[69] ? 10'h273 : 10'h3ff) &
		(a0_pla[70] ? 10'h2b0 : 10'h3ff) &
		(a0_pla[71] ? 10'h2b0 : 10'h3ff) &
		(a0_pla[72] ? 10'h1f3 : 10'h3ff) &
		(a0_pla[73] ? 10'h1f3 : 10'h3ff) &
		(a0_pla[74] ? 10'h3e4 : 10'h3ff) &
		(a0_pla[75] ? 10'h275 : 10'h3ff) &
		(a0_pla[76] ? 10'h1fd : 10'h3ff) &
		(a0_pla[77] ? 10'h1fd : 10'h3ff) &
		(a0_pla[78] ? 10'h127 : 10'h3ff) &
		(a0_pla[79] ? 10'h1f5 : 10'h3ff) &
		(a0_pla[80] ? 10'h1f5 : 10'h3ff) &
		(a0_pla[81] ? 10'h2f1 : 10'h3ff) &
		(a0_pla[82] ? 10'h2f2 : 10'h3ff) &
		(a0_pla[83] ? 10'h2f2 : 10'h3ff) &
		(a0_pla[84] ? 10'h1fb : 10'h3ff) &
		(a0_pla[85] ? 10'h1fb : 10'h3ff) &
		(a0_pla[86] ? 10'h30b : 10'h3ff) &
		(a0_pla[87] ? 10'h1e9 : 10'h3ff) &
		(a0_pla[88] ? 10'h1f9 : 10'h3ff) &
		(a0_pla[89] ? 10'h2f5 : 10'h3ff) &
		(a0_pla[90] ? 10'h1d6 : 10'h3ff) &
		(a0_pla[91] ? 10'h1d2 : 10'h3ff) &
		(a0_pla[92] ? 10'h1ce : 10'h3ff) &
		(a0_pla[93] ? 10'h1ca : 10'h3ff) &
		(a0_pla[94] ? 10'h15b : 10'h3ff) &
		(a0_pla[95] ? 10'h13b : 10'h3ff) &
		(a0_pla[96] ? 10'h137 : 10'h3ff) &
		(a0_pla[97] ? 10'h133 : 10'h3ff) &
		(a0_pla[98] ? 10'h133 : 10'h3ff) &
		(a0_pla[99] ? 10'h12d : 10'h3ff) &
		(a0_pla[100] ? 10'h2b9 : 10'h3ff) &
		(a0_pla[101] ? 10'h119 : 10'h3ff) &
		(a0_pla[102] ? 10'h1fa : 10'h3ff) &
		(a0_pla[103] ? 10'h178 : 10'h3ff) &
		(a0_pla[104] ? 10'h179 : 10'h3ff) &
		(a0_pla[105] ? 10'h103 : 10'h3ff) &
		(a0_pla[106] ? 10'h17c : 10'h3ff) &
		(a0_pla[107] ? 10'h17d : 10'h3ff) &
		(a0_pla[108] ? 10'h17d : 10'h3ff) &
		(a0_pla[109] ? 10'h1ff : 10'h3ff) &
		(a0_pla[110] ? 10'h1ff : 10'h3ff) &
		(a0_pla[111] ? 10'h00f : 10'h3ff) &
		(a0_pla[112] ? 10'h21c : 10'h3ff) &
		(a0_pla[113] ? 10'h123 : 10'h3ff) &
		(a0_pla[114] ? 10'h3a4 : 10'h3ff) &
		(a0_pla[115] ? 10'h1ee : 10'h3ff) &
		(a0_pla[116] ? 10'h1ea : 10'h3ff) &
		(a0_pla[117] ? 10'h2dc : 10'h3ff) &
		(a0_pla[118] ? 10'h2dc : 10'h3ff) &
		(a0_pla[119] ? 10'h2d8 : 10'h3ff) &
		(a0_pla[120] ? 10'h2dd : 10'h3ff) &
		(a0_pla[121] ? 10'h2d9 : 10'h3ff) &
		(a0_pla[122] ? 10'h1cd : 10'h3ff) &
		(a0_pla[123] ? 10'h23b : 10'h3ff) &
		(a0_pla[124] ? 10'h2de : 10'h3ff) &
		(a0_pla[125] ? 10'h2da : 10'h3ff) &
		(a0_pla[126] ? 10'h2fd : 10'h3ff) &
		(a0_pla[127] ? 10'h2fe : 10'h3ff) &
		(a0_pla[128] ? 10'h2fc : 10'h3ff) &
		(a0_pla[129] ? 10'h2f8 : 10'h3ff) &
		(a0_pla[130] ? 10'h2f9 : 10'h3ff) &
		(a0_pla[131] ? 10'h2fa : 10'h3ff) &
		(a0_pla[132] ? 10'h1ef : 10'h3ff) &
		(a0_pla[133] ? 10'h1eb : 10'h3ff) &
		(a0_pla[134] ? 10'h10c : 10'h3ff) &
		(a0_pla[135] ? 10'h100 : 10'h3ff) &
		(a0_pla[136] ? 10'h1c5 : 10'h3ff) &
		(a0_pla[137] ? 10'h1c5 : 10'h3ff) &
		(a0_pla[138] ? 10'h1c5 : 10'h3ff) &
		(a0_pla[139] ? 10'h1c9 : 10'h3ff) &
		(a0_pla[140] ? 10'h1c1 : 10'h3ff) &
		(a0_pla[141] ? 10'h1c1 : 10'h3ff) &
		(a0_pla[142] ? 10'h129 : 10'h3ff) &
		(a0_pla[143] ? 10'h279 : 10'h3ff) &
		(a0_pla[144] ? 10'h121 : 10'h3ff) &
		(a0_pla[145] ? 10'h301 : 10'h3ff) &
		(a0_pla[146] ? 10'h12a : 10'h3ff) &
		(a0_pla[147] ? 10'h126 : 10'h3ff) &
		(a0_pla[148] ? 10'h384 : 10'h3ff) &
		(a0_pla[149] ? 10'h1e5 : 10'h3ff) &
		(a0_pla[150] ? 10'h1ed : 10'h3ff) &
		(a0_pla[151] ? 10'h385 : 10'h3ff) &
		(a0_pla[152] ? 10'h381 : 10'h3ff) &
		(a0_pla[153] ? 10'h386 : 10'h3ff) &
		(a0_pla[154] ? 10'h382 : 10'h3ff) &
		(a0_pla[155] ? 10'h1f1 : 10'h3ff) &
		(a0_pla[156] ? 10'h3a0 : 10'h3ff) &
		(a0_pla[157] ? 10'h325 : 10'h3ff) &
		(a0_pla[158] ? 10'h3a2 : 10'h3ff) &
		(a0_pla[159] ? 10'h3a5 : 10'h3ff) &
		(a0_pla[160] ? 10'h230 : 10'h3ff) &
		(a0_pla[161] ? 10'h341 : 10'h3ff) &
		(a0_pla[162] ? 10'h3a6 : 10'h3ff) &
		(a0_pla[163] ? 10'h3e0 : 10'h3ff) &
		(a0_pla[164] ? 10'h308 : 10'h3ff) &
		(a0_pla[165] ? 10'h068 : 10'h3ff) &
		(a0_pla[166] ? 10'h089 : 10'h3ff) &
		(a0_pla[167] ? 10'h0a9 : 10'h3ff) &
		(a0_pla[168] ? 10'h2b9 : 10'h3ff);

	assign a2_pla[0] = (w530 & 16'h003d) == 16'h003d & ~a2_pla[2] & ~a2_pla[3];
	assign a2_pla[1] = (w530 & 16'h003e) == 16'h003e & ~a2_pla[2] & ~a2_pla[3];
	assign a2_pla[2] = (w530 & 16'hf000) == 16'he000;
	assign a2_pla[3] = (w530 & 16'he000) == 16'h6000;
	assign a2_pla[4] = (w530 & 16'hf1c0) == 16'h00c0 & ~a2_pla[5];
	assign a2_pla[5] = (w530 & 16'h0e00) == 16'h0800;
	assign a2_pla[6] = (w530 & 16'hff00) == 16'h0e00;
	assign a2_pla[7] = (w530 & 16'hf03e) == 16'h003a & ~a2_pla[8] & ~a2_pla[9];
	assign a2_pla[8] = (w530 & 16'h0fc0) == 16'h0800;
	assign a2_pla[9] = (w530 & 16'h01c0) == 16'h0100;
	assign a2_pla[10] = (w530 & 16'hf03f) == 16'h003c & ~a2_pla[9] & ~a2_pla[11] & ~a2_pla[14];
	assign a2_pla[11] = (w530 & 16'h0780) == 16'h0200;
	assign a2_pla[12] = (w530 & 16'he038) == 16'h0008 & ~a2_pla[13];
	assign a2_pla[13] = (w530 & 16'h1100) == 16'h0100;
	assign a2_pla[14] = (w530 & 16'h0d80) == 16'h0000;
	assign a2_pla[15] = (w530 & 16'hf1c0) == 16'h1040;
	assign a2_pla[16] = (w530 & 16'hc9c0) == 16'h09c0 & ~a2_pla[18];
	assign a2_pla[17] = (w530 & 16'hc5c0) == 16'h05c0 & ~a2_pla[18];
	assign a2_pla[18] = (w530 & 16'h3000) == 16'h0000;
	assign a2_pla[19] = (w530 & 16'hffc0) == 16'h42c0;
	assign a2_pla[20] = (w530 & 16'hfdc0) == 16'h4c00;
	assign a2_pla[21] = (w530 & 16'hff80) == 16'h4c00;
	assign a2_pla[22] = (w530 & 16'hf038) == 16'h4008 & ~a2_pla[24];
	assign a2_pla[23] = (w530 & 16'hf0be) == 16'h403a & ~a2_pla[25];
	assign a2_pla[24] = (w530 & 16'h0fc0) == 16'h0e40;
	assign a2_pla[25] = (w530 & 16'h0f40) == 16'h0840;
	assign a2_pla[26] = (w530 & 16'hf5be) == 16'h40ba;
	assign a2_pla[27] = (w530 & 16'hf9fe) == 16'h40ba;
	assign a2_pla[28] = (w530 & 16'h0dc0) == 16'h04c0;
	assign a2_pla[29] = (w530 & 16'hf03f) == 16'h403c & ~a2_pla[28] & ~a2_pla[30];
	assign a2_pla[30] = (w530 & 16'h01c0) == 16'h0180;
	assign a2_pla[31] = (w530 & 16'hf180) == 16'h4100;
	assign a2_pla[32] = (w530 & 16'hfff7) == 16'h4e74;
	assign a2_pla[33] = (w530 & 16'hff78) == 16'h4858;
	assign a2_pla[34] = (w530 & 16'hffb8) == 16'h4898;
	assign a2_pla[35] = (w530 & 16'hf1f8) == 16'h41d8;
	assign a2_pla[36] = (w530 & 16'hffb8) == 16'h4e98;
	assign a2_pla[37] = (w530 & 16'hfff8) == 16'h4860;
	assign a2_pla[38] = (w530 & 16'hfd98) == 16'h4c80;
	assign a2_pla[39] = (w530 & 16'hf1d8) == 16'h41c0;
	assign a2_pla[40] = (w530 & 16'hf0f8) == 16'h5008;
	assign a2_pla[41] = (w530 & 16'hf03a) == 16'h503a;
	assign a2_pla[42] = (w530 & 16'hf03c) == 16'h503c;
	assign a2_pla[43] = (w530 & 16'hf100) == 16'h7100;
	assign a2_pla[44] = (w530 & 16'hf038) == 16'h8008 & ~a2_pla[45];
	assign a2_pla[45] = (w530 & 16'h01c0) == 16'h0100;
	assign a2_pla[46] = (w530 & 16'h81be) == 16'h813a;
	assign a2_pla[47] = (w530 & 16'h817e) == 16'h813a & ~a2_pla[51];
	assign a2_pla[48] = (w530 & 16'h81bc) == 16'h813c & ~a2_pla[51];
	assign a2_pla[49] = (w530 & 16'h817c) == 16'h813c & ~a2_pla[51];
	assign a2_pla[50] = (w530 & 16'hf1f8) == 16'h8140;
	assign a2_pla[51] = (w530 & 16'hf000) == 16'he000;
	assign a2_pla[52] = (w530 & 16'h91f8) == 16'h9008;
	//assign a2_pla[53] = (w530 & 16'h0000) == 16'h0000;
	//assign a2_pla[54] = (w530 & 16'h0000) == 16'h0000;
	//assign a2_pla[55] = (w530 & 16'h0000) == 16'h0000;
	assign a2_pla[56] = (w530 & 16'hf8c0) == 16'he8c0;
	assign a2_pla[57] = (w530 & 16'hb138) == 16'h8008;
	assign a2_pla[58] = (w530 & 16'hb1f8) == 16'h81c8;
	assign a2_pla[59] = (w530 & 16'hb1f8) == 16'h8180;
	assign a2_pla[60] = (w530 & 16'hfff0) == 16'h4e60;
	assign a2_pla[61] = (w530 & 16'hf8f0) == 16'he0c0;
	assign a2_pla[62] = (w530 & 16'hf8fc) == 16'he0fc;
	assign a2_pla[63] = (w530 & 16'hf8fa) == 16'he0fa;
	assign a2_pla[64] = (w530 & 16'hf5ff) == 16'h007c;
	assign a2_pla[65] = (w530 & 16'hfffe) == 16'h4e72;
	assign a2_pla[66] = (w530 & 16'hfffd) == 16'h4e70;
	assign a2_pla[67] = (w530 & 16'hffc0) == 16'h46c0;
	assign a2_pla[68] = (w530 & 16'hfff8) == 16'h4e78;
	//assign a2_pla[69] = (w530 & 16'h0000) == 16'h0000;
	assign a2_pla[70] = (w530 & 16'h01c0) == 16'h0080; // g2
	assign a2_pla[71] = (w530 & 16'hf000) == 16'h0000; // g1
	assign a2_pla_g1 = ~a2_pla[71];
	assign a2_pla_g2 = ~a2_pla[70];
	assign a2_pla[72] = (w530 & 16'h0038) == 16'h0010 & ~a2_pla_g1 & ~a2_pla_g2 & ~a2_pla_g3;
	assign a2_pla[73] = (w530 & 16'h0e00) == 16'h0800 & ~a2_pla_g1 & ~a2_pla_g2; // g3
	assign a2_pla_g2 = a2_pla[73];
	assign a2_pla[74] = (w530 & 16'h0138) == 16'h0010 & ~a2_pla_g1 & ~a2_pla[72];
	assign a2_pla[75] = (w530 & 16'h0038) == 16'h0018 & ~a2_pla_g1 & ~a2_pla_g2 & ~a2_pla_g3;
	assign a2_pla[76] = (w530 & 16'h0038) == 16'h0018 & ~a2_pla_g1 & ~a2_pla[75];
	assign a2_pla[77] = (w530 & 16'h0038) == 16'h0020 & ~a2_pla_g1 & ~a2_pla_g2 & ~a2_pla_g3;
	assign a2_pla[78] = (w530 & 16'h0138) == 16'h0020 & ~a2_pla_g1 & ~a2_pla[77];
	assign a2_pla[79] = (w530 & 16'h0038) == 16'h0028 & ~a2_pla_g1 & ~a2_pla_g2 & ~a2_pla_g3;
	assign a2_pla[80] = (w530 & 16'h0fff) == 16'h083a & ~a2_pla_g1;
	assign a2_pla[81] = (w530 & 16'h0138) == 16'h0028 & ~a2_pla_g1 & ~a2_pla[79];
	assign a2_pla[82] = (w530 & 16'h0038) == 16'h0030 & ~a2_pla_g1 & ~a2_pla_g2 & ~a2_pla_g3;
	assign a2_pla[83] = (w530 & 16'h0fff) == 16'h083b & ~a2_pla_g1;
	assign a2_pla[84] = (w530 & 16'h0138) == 16'h0030 & ~a2_pla_g1 & ~a2_pla[82];
	assign a2_pla[85] = (w530 & 16'h003f) == 16'h0038 & ~a2_pla_g1 & ~a2_pla_g2 & ~a2_pla_g3;
	assign a2_pla[86] = (w530 & 16'h013f) == 16'h0038 & ~a2_pla_g1 & ~a2_pla[85];
	assign a2_pla[87] = (w530 & 16'h003f) == 16'h0039 & ~a2_pla_g1 & ~a2_pla_g2 & ~a2_pla_g3;
	assign a2_pla[88] = (w530 & 16'h013f) == 16'h0039 & ~a2_pla_g1 & ~a2_pla[87];
	assign a2_pla[89] = (w530 & 16'h0fb8) == 16'h0c00 & ~a2_pla_g1;
	assign a2_pla[90] = (w530 & 16'h0ff8) == 16'h0800 & ~a2_pla_g1;
	assign a2_pla[91] = (w530 & 16'h0f78) == 16'h0840 & ~a2_pla_g1;
	assign a2_pla[92] = (w530 & 16'h01b8) == 16'h0000 & ~a2_pla[89] & ~a2_pla[90] & ~a2_pla[91];
	assign a2_pla[93] = (w530 & 16'h01bf) == 16'h003c & ~a2_pla_g1;
	assign a2_pla[94] = (w530 & 16'h0e38) == 16'h0800 & ~a2_pla_g1 & ~a2_pla_g2;
	assign a2_pla[95] = (w530 & 16'h0038) == 16'h0000 & ~a2_pla_g1 & ~a2_pla_g2 & ~a2_pla[94] & ~a2_pla[96];
	assign a2_pla[96] = (w530 & 16'h0e38) == 16'h0c00 & ~a2_pla_g1 & ~a2_pla_g2;
	assign a2_pla[97] = (w530 & 16'h01c0) == 16'h0100 & ~a2_pla_g1;
	assign a2_pla[98] = (w530 & 16'h0fc0) == 16'h0800 & ~a2_pla_g1;
	assign a2_pla[99] = (w530 & 16'h0f40) == 16'h0840 & ~a2_pla_g1;
	assign a2_pla[100] = (w530 & 16'h0140) == 16'h0140 & ~a2_pla_g1;
	assign a2_pla[101] = (w530 & 16'h0f80) == 16'h0c00 & ~a2_pla_g1;
	assign a2_pla[102] = (w530 & 16'h0180) == 16'h0000 & ~a2_pla_g1 & ~a2_pla[98] & ~a2_pla[99] & ~a2_pla[101];
	assign a2_pla[103] = (w530 & 16'h8180) == 16'h8100;
	assign a2_pla[104] = (w530 & 16'hf8c0) == 16'he0c0;
	assign a2_pla[105] = (w530 & 16'h0e00) == 16'h0800 & ~a2_pla_g1 & ~a2_pla_g2;
	assign a2_pla[106] = (w530 & 16'h0e00) == 16'h0c00 & ~a2_pla_g1 & ~a2_pla_g2;
	assign a2_pla[107] = (w530 & 16'h01c0) == 16'h0180 & ~a2_pla_g1;
	assign a2_pla[108] = ~a2_pla_g1 & ~a2_pla_g2 & ~a2_pla[105] & ~a2_pla[106];
	assign a2_pla[109] = (w530 & 16'hfe00) == 16'h4a00 & ~a2_pla_g2;
	assign a2_pla[110] = (w530 & 16'hf000) == 16'h2000 & ~a2_pla_g2;
	assign a2_pla[111] = (w530 & 16'hf800) == 16'h4000 & ~a2_pla_g2;
	assign a2_pla[112] = (w530 & 16'hd000) == 16'h1000 & ~a2_pla_g2;
	assign a2_pla[113] = (w530 & 16'ha000) == 16'h8000 & ~a2_pla_g2;
	assign a2_pla[114] = (w530 & 16'hf000) == 16'hb000 & ~a2_pla_g2;
	assign a2_pla[115] = (w530 & 16'hd1c0) == 16'h1140;
	assign a2_pla[116] = (w530 & 16'hd1c0) == 16'h1180;
	assign a2_pla[117] = (w530 & 16'hdfc0) == 16'h11c0;
	assign a2_pla[118] = (w530 & 16'hf1c0) == 16'h3040;
	assign a2_pla[119] = (w530 & 16'hf180) == 16'h2000;
	assign a2_pla[120] = (w530 & 16'hd1c0) == 16'h1000;
	assign a2_pla[121] = (w530 & 16'hf1c0) == 16'h20c0;
	assign a2_pla[122] = (w530 & 16'hf1c0) == 16'h2100;
	assign a2_pla[123] = (w530 & 16'hf1c0) == 16'h2140;
	assign a2_pla[124] = (w530 & 16'hf1c0) == 16'h2180;
	assign a2_pla[125] = (w530 & 16'hffc0) == 16'h21c0;
	assign a2_pla[126] = (w530 & 16'hffc0) == 16'h23c0;
	assign a2_pla[127] = (w530 & 16'hf980) == 16'h4000;
	assign a2_pla[128] = (w530 & 16'hdfc0) == 16'h13c0;
	assign a2_pla[129] = (w530 & 16'hffc0) == 16'h40c0;
	assign a2_pla[130] = (w530 & 16'hfdc0) == 16'h44c0;
	assign a2_pla[131] = (w530 & 16'hffc0) == 16'h4800;
	assign a2_pla[132] = (w530 & 16'hff80) == 16'h4a00;
	assign a2_pla[133] = (w530 & 16'h81c0) == 16'h8180;
	assign a2_pla[134] = (w530 & 16'hffc0) == 16'h4ac0;
	assign a2_pla[135] = (w530 & 16'hf1c0) == 16'h4180;
	assign a2_pla[136] = (w530 & 16'hf080) == 16'h5000;
	assign a2_pla[137] = (w530 & 16'hf0c0) == 16'h5080;
	assign a2_pla[138] = (w530 & 16'hf0c0) == 16'h50c0;
	assign a2_pla[139] = (w530 & 16'ha180) == 16'h8000;
	assign a2_pla[140] = (w530 & 16'hb1c0) == 16'h90c0;
	assign a2_pla[141] = (w530 & 16'hd1c0) == 16'h10c0;
	assign a2_pla[142] = (w530 & 16'hb1c0) == 16'h91c0;
	assign a2_pla[143] = (w530 & 16'hf1c0) == 16'h80c0;
	assign a2_pla[144] = (w530 & 16'hf1c0) == 16'h81c0;
	assign a2_pla[145] = (w530 & 16'hd1c0) == 16'h1100;
	assign a2_pla[146] = (w530 & 16'hf1c0) == 16'hb1c0;
	assign a2_pla[147] = (w530 & 16'hf180) == 16'hb000;
	assign a2_pla[148] = (w530 & 16'hf1c0) == 16'hb0c0;
	assign a2_pla[149] = (w530 & 16'hf0c0) == 16'hc0c0;
	
	assign w536 = ~(
		a2_pla[0] | a2_pla[1] | a2_pla[4] | a2_pla[6] | a2_pla[7] | a2_pla[10] | a2_pla[12]
		| a2_pla[15] | a2_pla[16] | a2_pla[17] | a2_pla[19] | a2_pla[20] | a2_pla[21] | a2_pla[22]
		| a2_pla[23] | a2_pla[26] | a2_pla[27] | a2_pla[29] | a2_pla[31] | a2_pla[32] | a2_pla[33]
		| a2_pla[34] | a2_pla[35] | a2_pla[36] | a2_pla[37] | a2_pla[38] | a2_pla[39] | a2_pla[40]
		| a2_pla[41] | a2_pla[42] | a2_pla[43] | a2_pla[44] | a2_pla[46] | a2_pla[47] | a2_pla[48]
		| a2_pla[49] | a2_pla[50] | a2_pla[52] | a2_pla[56] | a2_pla[57] | a2_pla[58] | a2_pla[59]
		| a2_pla[61] | a2_pla[62] | a2_pla[63] | a2_pla[68]
		);
	
	assign w537 = ~(
		a2_pla[60] | a2_pla[64] | a2_pla[65] | a2_pla[66] | a2_pla[67]
		);

	assign w534 =
		(a2_pla[72] ? 10'h00b : 10'h3ff) &
		(a2_pla[73] ? 10'h3ff : 10'h3ff) &
		(a2_pla[74] ? 10'h006 : 10'h3ff) &
		(a2_pla[75] ? 10'h00f : 10'h3ff) &
		(a2_pla[76] ? 10'h21c : 10'h3ff) &
		(a2_pla[77] ? 10'h179 : 10'h3ff) &
		(a2_pla[78] ? 10'h103 : 10'h3ff) &
		(a2_pla[79] ? 10'h1c6 : 10'h3ff) &
		(a2_pla[80] ? 10'h1c2 : 10'h3ff) &
		(a2_pla[81] ? 10'h1c2 : 10'h3ff) &
		(a2_pla[82] ? 10'h1e7 : 10'h3ff) &
		(a2_pla[83] ? 10'h1e3 : 10'h3ff) &
		(a2_pla[84] ? 10'h1e3 : 10'h3ff) &
		(a2_pla[85] ? 10'h00e : 10'h3ff) &
		(a2_pla[86] ? 10'h00a : 10'h3ff) &
		(a2_pla[87] ? 10'h1e6 : 10'h3ff) &
		(a2_pla[88] ? 10'h1e2 : 10'h3ff) &
		(a2_pla[89] ? 10'h108 : 10'h3ff) &
		(a2_pla[90] ? 10'h3e7 : 10'h3ff) &
		(a2_pla[91] ? 10'h3ef : 10'h3ff) &
		(a2_pla[92] ? 10'h100 : 10'h3ff) &
		(a2_pla[93] ? 10'h1cc : 10'h3ff) &
		(a2_pla[94] ? 10'h3eb : 10'h3ff) &
		(a2_pla[95] ? 10'h10c : 10'h3ff) &
		(a2_pla[96] ? 10'h104 : 10'h3ff) &
		(a2_pla[97] ? 10'h0ab : 10'h3ff) &
		(a2_pla[98] ? 10'h3ff : 10'h3ff) &
		(a2_pla[99] ? 10'h3ff : 10'h3ff) &
		(a2_pla[100] ? 10'h3ff : 10'h3ff) &
		(a2_pla[101] ? 10'h3ff : 10'h3ff) &
		(a2_pla[102] ? 10'h3ff : 10'h3ff) &
		(a2_pla[103] ? 10'h3ff : 10'h3ff) &
		(a2_pla[104] ? 10'h3ff : 10'h3ff) &
		(a2_pla[105] ? 10'h3ff : 10'h3ff) &
		(a2_pla[106] ? 10'h3ff : 10'h3ff) &
		(a2_pla[107] ? 10'h3ff : 10'h3ff) &
		(a2_pla[108] ? 10'h3ff : 10'h3ff) &
		(a2_pla[109] ? 10'h3ff : 10'h3ff) &
		(a2_pla[110] ? 10'h2f9 : 10'h3ff) &
		(a2_pla[111] ? 10'h3ff : 10'h3ff) &
		(a2_pla[112] ? 10'h2fa : 10'h3ff) &
		(a2_pla[113] ? 10'h1c5 : 10'h3ff) &
		(a2_pla[114] ? 10'h1d5 : 10'h3ff) &
		(a2_pla[115] ? 10'h2da : 10'h3ff) &
		(a2_pla[116] ? 10'h1eb : 10'h3ff) &
		(a2_pla[117] ? 10'h2d9 : 10'h3ff) &
		(a2_pla[118] ? 10'h279 : 10'h3ff) &
		(a2_pla[119] ? 10'h129 : 10'h3ff) &
		(a2_pla[120] ? 10'h121 : 10'h3ff) &
		(a2_pla[121] ? 10'h2fd : 10'h3ff) &
		(a2_pla[122] ? 10'h2fc : 10'h3ff) &
		(a2_pla[123] ? 10'h2de : 10'h3ff) &
		(a2_pla[124] ? 10'h1ef : 10'h3ff) &
		(a2_pla[125] ? 10'h2dd : 10'h3ff) &
		(a2_pla[126] ? 10'h1ee : 10'h3ff) &
		(a2_pla[127] ? 10'h3ff : 10'h3ff) &
		(a2_pla[128] ? 10'h1ea : 10'h3ff) &
		(a2_pla[129] ? 10'h3ff : 10'h3ff) &
		(a2_pla[130] ? 10'h301 : 10'h3ff) &
		(a2_pla[131] ? 10'h3ff : 10'h3ff) &
		(a2_pla[132] ? 10'h3ff : 10'h3ff) &
		(a2_pla[133] ? 10'h3ff : 10'h3ff) &
		(a2_pla[134] ? 10'h3ff : 10'h3ff) &
		(a2_pla[135] ? 10'h152 : 10'h3ff) &
		(a2_pla[136] ? 10'h3ff : 10'h3ff) &
		(a2_pla[137] ? 10'h3ff : 10'h3ff) &
		(a2_pla[138] ? 10'h3ff : 10'h3ff) &
		(a2_pla[139] ? 10'h1c1 : 10'h3ff) &
		(a2_pla[140] ? 10'h1c9 : 10'h3ff) &
		(a2_pla[141] ? 10'h2fe : 10'h3ff) &
		(a2_pla[142] ? 10'h1c5 : 10'h3ff) &
		(a2_pla[143] ? 10'h0a6 : 10'h3ff) &
		(a2_pla[144] ? 10'h0ae : 10'h3ff) &
		(a2_pla[145] ? 10'h2f8 : 10'h3ff) &
		(a2_pla[146] ? 10'h1d5 : 10'h3ff) &
		(a2_pla[147] ? 10'h1d1 : 10'h3ff) &
		(a2_pla[148] ? 10'h1d9 : 10'h3ff) &
		(a2_pla[149] ? 10'h15b : 10'h3ff);
	
	assign w535 =
		(a2_pla[72] ? 10'h3ff : 10'h3ff) &
		(a2_pla[73] ? 10'h3ff : 10'h3ff) &
		(a2_pla[74] ? 10'h3ff : 10'h3ff) &
		(a2_pla[75] ? 10'h3ff : 10'h3ff) &
		(a2_pla[76] ? 10'h3ff : 10'h3ff) &
		(a2_pla[77] ? 10'h3ff : 10'h3ff) &
		(a2_pla[78] ? 10'h3ff : 10'h3ff) &
		(a2_pla[79] ? 10'h3ff : 10'h3ff) &
		(a2_pla[80] ? 10'h3ff : 10'h3ff) &
		(a2_pla[81] ? 10'h3ff : 10'h3ff) &
		(a2_pla[82] ? 10'h3ff : 10'h3ff) &
		(a2_pla[83] ? 10'h3ff : 10'h3ff) &
		(a2_pla[84] ? 10'h3ff : 10'h3ff) &
		(a2_pla[85] ? 10'h3ff : 10'h3ff) &
		(a2_pla[86] ? 10'h3ff : 10'h3ff) &
		(a2_pla[87] ? 10'h3ff : 10'h3ff) &
		(a2_pla[88] ? 10'h3ff : 10'h3ff) &
		(a2_pla[89] ? 10'h3ff : 10'h3ff) &
		(a2_pla[90] ? 10'h3ff : 10'h3ff) &
		(a2_pla[91] ? 10'h3ff : 10'h3ff) &
		(a2_pla[92] ? 10'h3ff : 10'h3ff) &
		(a2_pla[93] ? 10'h3ff : 10'h3ff) &
		(a2_pla[94] ? 10'h3ff : 10'h3ff) &
		(a2_pla[95] ? 10'h3ff : 10'h3ff) &
		(a2_pla[96] ? 10'h3ff : 10'h3ff) &
		(a2_pla[97] ? 10'h215 : 10'h3ff) &
		(a2_pla[98] ? 10'h215 : 10'h3ff) &
		(a2_pla[99] ? 10'h081 : 10'h3ff) &
		(a2_pla[100] ? 10'h081 : 10'h3ff) &
		(a2_pla[101] ? 10'h087 : 10'h3ff) &
		(a2_pla[102] ? 10'h299 : 10'h3ff) &
		(a2_pla[103] ? 10'h299 : 10'h3ff) &
		(a2_pla[104] ? 10'h3c7 : 10'h3ff) &
		(a2_pla[105] ? 10'h069 : 10'h3ff) &
		(a2_pla[106] ? 10'h08f : 10'h3ff) &
		(a2_pla[107] ? 10'h069 : 10'h3ff) &
		(a2_pla[108] ? 10'h29d : 10'h3ff) &
		(a2_pla[109] ? 10'h3cb : 10'h3ff) &
		(a2_pla[110] ? 10'h3a9 : 10'h3ff) &
		(a2_pla[111] ? 10'h2bc : 10'h3ff) &
		(a2_pla[112] ? 10'h3ab : 10'h3ff) &
		(a2_pla[113] ? 10'h1cb : 10'h3ff) &
		(a2_pla[114] ? 10'h1d7 : 10'h3ff) &
		(a2_pla[115] ? 10'h38a : 10'h3ff) &
		(a2_pla[116] ? 10'h298 : 10'h3ff) &
		(a2_pla[117] ? 10'h388 : 10'h3ff) &
		(a2_pla[118] ? 10'h158 : 10'h3ff) &
		(a2_pla[119] ? 10'h29f : 10'h3ff) &
		(a2_pla[120] ? 10'h29b : 10'h3ff) &
		(a2_pla[121] ? 10'h3ad : 10'h3ff) &
		(a2_pla[122] ? 10'h38f : 10'h3ff) &
		(a2_pla[123] ? 10'h38e : 10'h3ff) &
		(a2_pla[124] ? 10'h29c : 10'h3ff) &
		(a2_pla[125] ? 10'h38c : 10'h3ff) &
		(a2_pla[126] ? 10'h30f : 10'h3ff) &
		(a2_pla[127] ? 10'h2b8 : 10'h3ff) &
		(a2_pla[128] ? 10'h32b : 10'h3ff) &
		(a2_pla[129] ? 10'h3a1 : 10'h3ff) &
		(a2_pla[130] ? 10'h159 : 10'h3ff) &
		(a2_pla[131] ? 10'h15c : 10'h3ff) &
		(a2_pla[132] ? 10'h3c3 : 10'h3ff) &
		(a2_pla[133] ? 10'h29d : 10'h3ff) &
		(a2_pla[134] ? 10'h343 : 10'h3ff) &
		(a2_pla[135] ? 10'h151 : 10'h3ff) &
		(a2_pla[136] ? 10'h2f3 : 10'h3ff) &
		(a2_pla[137] ? 10'h2f7 : 10'h3ff) &
		(a2_pla[138] ? 10'h380 : 10'h3ff) &
		(a2_pla[139] ? 10'h1c3 : 10'h3ff) &
		(a2_pla[140] ? 10'h1c7 : 10'h3ff) &
		(a2_pla[141] ? 10'h3af : 10'h3ff) &
		(a2_pla[142] ? 10'h1cb : 10'h3ff) &
		(a2_pla[143] ? 10'h0a4 : 10'h3ff) &
		(a2_pla[144] ? 10'h0ac : 10'h3ff) &
		(a2_pla[145] ? 10'h38b : 10'h3ff) &
		(a2_pla[146] ? 10'h1d7 : 10'h3ff) &
		(a2_pla[147] ? 10'h1d3 : 10'h3ff) &
		(a2_pla[148] ? 10'h1cf : 10'h3ff) &
		(a2_pla[149] ? 10'h15a : 10'h3ff);
	
	always @(posedge MCLK)
	begin
		if (w539)
			w538 <= w530;
	end

	assign irdbus = (w267 ? irdbus_normal : 16'h0) | irdbus_dbg;
	
	assign irdbus_normal = {
		~w538[15], w538[15],
		~w538[14], w538[14],
		~w538[13], w538[13],
		~w538[12], w538[12],
		~w538[11], w538[11],
		~w538[10], w538[10],
		~w538[9], w538[9],
		~w538[8], w538[8],
		~w538[7], w538[7],
		~w538[6], w538[6],
		~w538[5], w538[5],
		~w538[4], w538[4],
		~w538[3], w538[3],
		~w538[2], w538[2],
		~w538[1], w538[1],
		~w538[0], w538[0]
		};
	
	assign irdbus_dbg =
		(w564 ?
		{ w529[25], w529[28], ~w529[31], ~w529[34], ~w529[37], w529[40], w529[43], w529[46],
			w529[1], w529[49], w529[4], w529[52], ~w529[7], w529[55], w529[10], ~w529[58],
			w529[13], ~w529[61], w529[16], w529[64], w529[19], w529[67], w529[22], 9'h0 } : 32'h0) |
		(w565 ?
		{ w529[24], w529[27], ~w529[30], w529[33], ~w529[36], w529[39], w529[42], w529[45],
			~w529[0], ~w529[48], w529[3], w529[51], w529[6], w529[54], ~w529[9], w529[57],
			w529[12], ~w529[60], ~w529[15], w529[63], w529[18], w529[66], w529[21], 9'h0 } : 32'h0) |
		(w566 ?
		{ w529[23], w529[26], ~w529[29], ~w529[32], ~w529[35], w529[38], w529[41], w529[44],
			w522[0], w529[47], w529[2], w529[50], w529[5], w529[53], w529[8], ~w529[56],
			w529[11], ~w529[59], w529[14], ~w529[62], ~w529[17], w529[65], w529[20], 9'h0 } : 32'h0);
	
	assign w539 = w540 ? c2 : 1'h0;
	
	assign w540 = ~(w267 | ~w529[0]);
	assign w541 = ~(w522[0] | w477);
	assign w542 = ~(w540 | w541);
	
	assign w543 = w477 | (w529[1] & ~w267);
	
	assign w544 = ~(w529[7] | w529[1]);
	
	always @(posedge MCLK)
	begin
		if (c4)
			w545 <= ird_pla1[43];
	end
	
	assign w546 = ~(w545 & w529[25]);
	
	assign w547 = ~w267 & w607;
	
	assign w548 = ~(w267 | ~w605);
	
	always @(posedge MCLK)
	begin
		if (w539)
		begin
			w549 <= w468;
			w550 <= w469;
			w551 <= w470;
			w552 <= w471;
		end
	end
	
	assign w553 = ~w984[11];
	assign w554 = ~w876;
	
	assign w559 = w522[5:2];
	
	assign w560 = { irdbus[22], irdbus[20], irdbus[18], irdbus[16] };
	
	assign cond_pla1[0] = w560 == 4'hf & ~w754 & w752 & w753;
	assign cond_pla1[1] = w560 == 4'hf & ~w754 & ~w752 & ~w753;
	assign cond_pla1[2] = w560 == 4'he & w754;
	assign cond_pla1[3] = w560 == 4'hd & w752 & w753;
	assign cond_pla1[4] = w560 == 4'hd & ~w752 & ~w753;
	assign cond_pla1[5] = (w560 & 4'hd) == 4'hc & ~w752 & w753;
	assign cond_pla1[6] = (w560 & 4'hd) == 4'hc & w752 & ~w753;
	assign cond_pla1[7] = w560 == 4'hb & ~w753;
	assign cond_pla1[8] = w560 == 4'ha & w753;
	assign cond_pla1[9] = w560 == 4'h9 & ~w752;
	assign cond_pla1[10] = w560 == 4'h8 & w752;
	assign cond_pla1[11] = w560 == 4'h7 & ~w754;
	assign cond_pla1[12] = w560 == 4'h5 & ~w751;
	assign cond_pla1[13] = w560 == 4'h4 & w751;
	assign cond_pla1[14] = w560 == 4'h3 & ~w754 & ~w751;
	assign cond_pla1[15] = (w560 & 4'hb) == 4'h2 & w754;
	assign cond_pla1[16] = w560 == 4'h2 & w751;
	assign cond_pla1[17] = w560 == 4'h1;
	
	assign cond_pla2[0] = w559 == 4'h9;
	assign cond_pla2[1] = w559 == 4'he & ~w170 & ~irdbus[12];
	assign cond_pla2[2] = w559 == 4'he & w170;
	assign cond_pla2[3] = w559 == 4'hd & w752;
	assign cond_pla2[4] = w559 == 4'hc & ~w554;
	assign cond_pla2[5] = w559 == 4'hb & ~w753 & ~w752;
	assign cond_pla2[6] = w559 == 4'ha & ~w800;
	assign cond_pla2[7] = w559 == 4'h8 & ~w560[0] & w901;
	assign cond_pla2[8] = w559 == 4'h8 & w560[0] & ~w901 & w899;
	assign cond_pla2[9] = w559 == 4'h8 & w157;
	assign cond_pla2[10] = w559 == 4'h8 & w560[0] & w901 & ~w899;
	assign cond_pla2[11] = w559 == 4'h7 & w560[0] & w899;
	assign cond_pla2[12] = w559 == 4'h7 & ~w560[0] & w899;
	assign cond_pla2[13] = w559 == 4'h6 & w754;
	assign cond_pla2[14] = w559 == 4'h6 & w753;
	assign cond_pla2[15] = w559 == 4'h5 & ~w753;
	assign cond_pla2[16] = w559 == 4'h4 & w753 & ~w754;
	assign cond_pla2[17] = w559 == 4'h4 & ~w753 & ~w754;
	assign cond_pla2[18] = w559 == 4'h3 & ~w754;
	assign cond_pla2[19] = w559 == 4'h2;
	assign cond_pla2[20] = w559 == 4'h2 & w751;
	assign cond_pla2[21] = w559 == 4'h1 & w157;
	assign cond_pla2[22] = w559 == 4'h0 & ~w553;
	
	assign w555_1 = |cond_pla[17:0];
	
	assign w556_1 = |cond_pla[17:0];
	
	assign w555 = ~(
		(cond_pla2[0] & w555_1) |
		cond_pla2[2] |
		cond_pla2[3] |
		cond_pla2[4] |
		cond_pla2[5] |
		cond_pla2[6] |
		cond_pla2[7] |
		cond_pla2[8] |
		cond_pla2[9] |
		cond_pla2[12] |
		cond_pla2[13] |
		cond_pla2[14] |
		cond_pla2[15] |
		cond_pla2[16] |
		cond_pla2[18] |
		cond_pla2[19] |
		cond_pla2[21] |
		cond_pla2[22]
		);
		
	assign w556 = ~(
		(cond_pla2[0] & w556_1) |
		cond_pla2[1] |
		cond_pla2[4] |
		cond_pla2[15] |
		cond_pla2[20] |
		cond_pla2[21] |
		);
	
	assign w557 = ~(
		cond_pla2[1] |
		cond_pla2[2] |
		cond_pla2[3] |
		cond_pla2[5] |
		cond_pla2[6] |
		cond_pla2[9] |
		cond_pla2[10] |
		cond_pla2[11] |
		cond_pla2[17] |
		cond_pla2[18] |
		cond_pla2[20] |
		cond_pla2[22]
		);
		
	assign w558 = ~(
		cond_pla2[2] |
		cond_pla2[21]
		);
	
	assign w561 = ~(w267 | w522[6]);
	assign w562 = ~(w561 | w267);
	
	assign w563 = ~(w578 | (w529[25] & ird_pla1[0]));
	
	assign w564 = ~(~w320 | ~w267 | ~w321);
	assign w565 = ~(w320 | ~w267 | ~w321);
	assign w566 = ~(~w320 | ~w267 | w321);
	
	assign w567 = ~(w529[63] | w529[64]);
	
	assign w568 = w529[11] | w529[14];
	
	assign ird_pla1[0] = (chip->irdbus & 32'h55000580) == 32'h0;
	assign ird_pla1[1] = (chip->irdbus & 32'h9a000000) == 32'h0 & ~ird_pla1[2] & ~ird_pla1[3] & ~ird_pla1[4];
	assign ird_pla1[2] = (chip->irdbus & 32'h9a010000) == 32'h0;
	assign ird_pla1[3] = (chip->irdbus & 32'h9a02a000) == 32'h0;
	assign ird_pla1[4] = (chip->irdbus & 32'h9a000580) == 32'h0;
	assign ird_pla1[5] = (chip->irdbus & 32'ha9010000) == 32'h0;
	assign ird_pla1[6] = (chip->irdbus & 32'ha9020000) == 32'h0;
	assign ird_pla1[7] = (chip->irdbus & 32'ha924a000) == 32'h0;
	assign ird_pla1[8] = (chip->irdbus & 32'ha9000240) == 32'h0 & ~ird_pla1[15];
	assign ird_pla1[9] = (chip->irdbus & 32'ha914a000) == 32'h0;
	assign ird_pla1[10] = (chip->irdbus & 32'ha9000140) == 32'h0 & ~ird_pla1[15];
	assign ird_pla1[11] = (chip->irdbus & 32'ha928a000) == 32'h0;
	assign ird_pla1[12] = (chip->irdbus & 32'ha9000280) == 32'h0 & ~ird_pla1[15];
	assign ird_pla1[13] = (chip->irdbus & 32'ha918a000) == 32'h0;
	assign ird_pla1[14] = (chip->irdbus & 32'ha9000180) == 32'h0 & ~ird_pla1[15];
	assign ird_pla1[15] = (chip->irdbus & 32'ha900a000) == 32'h0;
	assign ird_pla1[16] = (chip->irdbus & 32'h65000000) == 32'h0;
	assign ird_pla1[17] = (chip->irdbus & 32'h65029000) == 32'h0;
	assign ird_pla1[18] = (chip->irdbus & 32'h45590000) == 32'h0;
	assign ird_pla1[19] = (chip->irdbus & 32'h45954000) == 32'h0;
	assign ird_pla1[20] = (chip->irdbus & 32'h45650000) == 32'h0;
	assign ird_pla1[21] = (chip->irdbus & 32'h45690000) == 32'h0;
	assign ird_pla1[22] = (chip->irdbus & 32'h45550000) == 32'h0;
	assign ird_pla1[23] = (chip->irdbus & 32'h45990000) == 32'h0;
	assign ird_pla1[24] = (chip->irdbus & 32'h45958000) == 32'h0;
	assign ird_pla1[25] = (chip->irdbus & 32'h55a50000) == 32'h0;
	assign ird_pla1[26] = (chip->irdbus & 32'h55024000) == 32'h0;
	assign ird_pla1[27] = (chip->irdbus & 32'h55028000) == 32'h0;
	assign ird_pla1[28] = (chip->irdbus & 32'h55000000) == 32'h0;
	assign ird_pla1[29] = (chip->irdbus & 32'h46010000) == 32'h0 & ~ird_pla1[31];
	assign ird_pla1[30] = (chip->irdbus & 32'h46020000) == 32'h0 & ~ird_pla1[31];
	assign ird_pla1[31] = (chip->irdbus & 32'h4600a000) == 32'h0;
	assign ird_pla1[32] = (chip->irdbus & 32'h48000000) == 32'h0;
	assign ird_pla1[33] = (chip->irdbus & 32'h95000000) == 32'h0;
	assign ird_pla1[34] = (chip->irdbus & 32'h85000000) == 32'h0 & ~ird_pla1[35] & ~ird_pla1[36];
	assign ird_pla1[35] = (chip->irdbus & 32'h85025500) == 32'h0;
	assign ird_pla1[36] = (chip->irdbus & 32'h8500a000) == 32'h0;
	assign ird_pla1[37] = (chip->irdbus & 32'ha5000000) == 32'h0;
	assign ird_pla1[38] = (chip->irdbus & 32'h96000000) == 32'h0;
	assign ird_pla1[39] = (chip->irdbus & 32'h86000000) == 32'h0 & ~ird_pla1[40] & ~ird_pla1[41];
	assign ird_pla1[40] = (chip->irdbus & 32'h86021500) == 32'h0;
	assign ird_pla1[41] = (chip->irdbus & 32'h86024500) == 32'h0;
	assign ird_pla1[42] = (chip->irdbus & 32'ha6000000) == 32'h0;
	assign ird_pla1[43] = (chip->irdbus & 32'h6599a000) == 32'h0;
	assign ird_pla1[44] = (chip->irdbus & 32'h8600a000) == 32'h0;
	assign ird_pla1[45] = (chip->irdbus & 32'h58016000) == 32'h0;
	assign ird_pla1[46] = (chip->irdbus & 32'h64000580) == 32'h0;
	assign ird_pla1[47] = (chip->irdbus & 32'ha9005000) == 32'h0;
	assign ird_pla1[48] = (chip->irdbus & 32'ha9002000) == 32'h0;
	assign ird_pla1[49] = (chip->irdbus & 32'ha9009000) == 32'h0;

	assign ird_pla2[0] = (chip->irdbus & 32'h68008000) == 32'h0 & ~w586 & ~w587;
	assign ird_pla2[1] = (chip->irdbus & 32'h00000500) == 32'h0;
	assign ird_pla2[2] = (chip->irdbus & 32'h8500a000) == 32'h0 & ~w586 & ~w587;
	assign ird_pla2[3] = (chip->irdbus & 32'h6599a000) == 32'h0 & ~w586 & ~w587;
	assign ird_pla2[4] = (chip->irdbus & 32'ha9000000) == 32'h0 & ~w586;
	assign ird_pla2[5] = (chip->irdbus & 32'h66004000) == 32'h0 & ~w586;
	assign ird_pla2[6] = (chip->irdbus & 32'h66001000) == 32'h0 & ~w586;
	assign ird_pla2[7] = (chip->irdbus & 32'h6a010000) == 32'h0;
	assign ird_pla2[8] = (chip->irdbus & 32'h69000000) == 32'h0;
	assign ird_pla2[9] = (chip->irdbus & 32'h55020000) == 32'h0 & ~ird_pla2[1];
	assign ird_pla2[10] = (chip->irdbus & 32'h6519a000) == 32'h0;
	assign ird_pla2[11] = (chip->irdbus & 32'h55950000) == 32'h0 & ~ird_pla2[1];
	assign ird_pla2[12] = (chip->irdbus & 32'h55024580) == 32'h0;
	assign ird_pla2[13] = (chip->irdbus & 32'h6600a580) == 32'h0;
	assign ird_pla2[14] = (chip->irdbus & 32'h6600a000) == 32'h0 & ~ird_pla2[13];
	assign ird_pla2[15] = (chip->irdbus & 32'h55015000) == 32'h0 & ~ird_pla2[16];
	assign ird_pla2[16] = (chip->irdbus & 32'h00940500) == 32'h0;
	assign ird_pla2[17] = (chip->irdbus & 32'h80005000) == 32'h0;
	assign ird_pla2[18] = (chip->irdbus & 32'h20005000) == 32'h0;
	assign ird_pla2[19] = (chip->irdbus & 32'h56000000) == 32'h0;
	assign ird_pla2[20] = (chip->irdbus & 32'ha9000a80) == 32'h0;
	assign ird_pla2[21] = (chip->irdbus & 32'h00000a98) == 32'h0 & ~ird_pla2[20] & ~w529[24];
	assign ird_pla2[22] = (chip->irdbus & 32'h00000a84) == 32'h0 & ~ird_pla2[20] & ~w529[24];
	assign ird_pla2[23] = (chip->irdbus & 32'h66000000) == 32'h0;
	assign ird_pla2[24] = (chip->irdbus & 32'h55010000) == 32'h0;
	assign ird_pla2[25] = (chip->irdbus & 32'ha9001000) == 32'h0;
	assign ird_pla2[26] = (chip->irdbus & 32'ha9004000) == 32'h0;
	assign ird_pla2[27] = (chip->irdbus & 32'h00000540) == 32'h0;
	assign ird_pla2[28] = (chip->irdbus & 32'h6600a580) == 32'h0;
	assign ird_pla2[29] = (chip->irdbus & 32'h65a96a6a) == 32'h0;
	assign ird_pla2[30] = (chip->irdbus & 32'h6565a000) == 32'h0;
	assign ird_pla2[31] = (chip->irdbus & 32'h55015000) == 32'h0;
	
	wire [3:0] ird_pla3_i == { w549, w550, w551, w552 };

	assign ird_pla3[0] = (ird_pla3_i & 4'd7) == 4'd0;
	assign ird_pla3[1] = (ird_pla3_i & 4'd15) == 4'd7 & (irdbus & 32'h00008000) == 32'h0;
	assign ird_pla3[2] = (ird_pla3_i & 4'd15) == 4'd7 & (irdbus & 32'h00002000) == 32'h0;
	assign ird_pla3[3] = (ird_pla3_i & 4'd15) == 4'd3;
	assign ird_pla3[4] = (ird_pla3_i & 4'd15) == 4'd6 & ~~w611;
	assign ird_pla3[5] = (ird_pla3_i & 4'd15) == 4'd6 & ~~w610;
	assign ird_pla3[6] = (ird_pla3_i & 4'd15) == 4'd6 & ~~w609;
	assign ird_pla3[7] = (ird_pla3_i & 4'd15) == 4'd0 & (irdbus & 32'h65a96a69) == 32'h0;
	assign ird_pla3[8] = (ird_pla3_i & 4'd15) == 4'd12;
	assign ird_pla3[9] = (ird_pla3_i & 4'd15) == 4'd11;
	assign ird_pla3[10] = (ird_pla3_i & 4'd15) == 4'd4;
	assign ird_pla3[11] = (ird_pla3_i & 4'd15) == 4'd0 & (irdbus & 32'h65a96500) == 32'h0;
	assign ird_pla3[12] = (ird_pla3_i & 4'd15) == 4'd7 & (irdbus & 32'h00000800) == 32'h0;
	assign ird_pla3[13] = (ird_pla3_i & 4'd15) == 4'd14;
	assign ird_pla3[14] = (ird_pla3_i & 4'd15) == 4'd6;
	assign ird_pla3[15] = (ird_pla3_i & 4'd15) == 4'd7 & (irdbus & 32'h00000200) == 32'h0;
	assign ird_pla3[16] = (ird_pla3_i & 4'd15) == 4'd5;
	assign ird_pla3[17] = (ird_pla3_i & 4'd15) == 4'd0 & (irdbus & 32'h65a96580) == 32'h0;
	assign ird_pla3[18] = (ird_pla3_i & 4'd15) == 4'd7 & (irdbus & 32'h00000080) == 32'h0;
	assign ird_pla3[19] = (ird_pla3_i & 4'd15) == 4'd0 & (irdbus & 32'h65029000) == 32'h0;
	assign ird_pla3[20] = (ird_pla3_i & 4'd15) == 4'd0 & (irdbus & 32'h9500a000) == 32'h0;
	assign ird_pla3[21] = (ird_pla3_i & 4'd15) == 4'd0 & (irdbus & 32'h65a96520) == 32'h0;
	assign ird_pla3[22] = (ird_pla3_i & 4'd15) == 4'd7 & (irdbus & 32'h00000020) == 32'h0;
	assign ird_pla3[23] = (ird_pla3_i & 4'd15) == 4'd13;
	assign ird_pla3[24] = (ird_pla3_i & 4'd15) == 4'd0 & (irdbus & 32'h65a96502) == 32'h0;
	assign ird_pla3[25] = (ird_pla3_i & 4'd15) == 4'd0 & (irdbus & 32'h65a96508) == 32'h0;
	assign ird_pla3[26] = (ird_pla3_i & 4'd15) == 4'd2;
	assign ird_pla3[27] = (ird_pla3_i & 4'd15) == 4'd1;
	assign ird_pla3[28] = (ird_pla3_i & 4'd15) == 4'd7 & (irdbus & 32'h00000008) == 32'h0;
	assign ird_pla3[29] = (ird_pla3_i & 4'd15) == 4'd7 & (irdbus & 32'h00000002) == 32'h0;


	assign ird_pla4[0] = (irdbus & 0x00000a84ul) == 32'h0 & ~ird_pla4[2] & ~w529[24];
	assign ird_pla4[1] = (irdbus & 0x00000a98ul) == 32'h0 & ~ird_pla4[2] & ~w529[24];
	assign ird_pla4[2] = (irdbus & 0xa9000a80ul) == 32'h0;
	assign ird_pla4[3] = (irdbus & 0x65a96900ul) == 32'h0;
	assign ird_pla4[4] = (irdbus & 0x66000000ul) == 32'h0;
	assign ird_pla4[5] = (irdbus & 0x55010000ul) == 32'h0;
	assign ird_pla4[6] = (irdbus & 0x69560000ul) == 32'h0;
	assign ird_pla4[7] = (irdbus & 0x65a90000ul) == 32'h0;
	assign ird_pla4[8] = (irdbus & 0x65956000ul) == 32'h0;
	assign ird_pla4[9] = (irdbus & 0x00080000ul) == 32'h0;
	assign ird_pla4[10] = (irdbus & 0x00200000ul) == 32'h0;
	assign ird_pla4[11] = (irdbus & 0x00800000ul) == 32'h0;
	assign ird_pla4[12] = (irdbus & 0xa5029580ul) == 32'h0;
	assign ird_pla4[13] = (irdbus & 0x84020580ul) == 32'h0 & ~ird_pla4[12];
	assign ird_pla4[14] = (irdbus & 0x90020580ul) == 32'h0;
	assign ird_pla4[15] = (irdbus & 0x8200a000ul) == 32'h0;
	assign ird_pla4[16] = (irdbus & 0x6502a000ul) == 32'h0;
	assign ird_pla4[17] = (irdbus & 0x52000000ul) == 32'h0 & ~ird_pla4[19];
	assign ird_pla4[18] = (irdbus & 0x58000000ul) == 32'h0 & ~ird_pla4[19];
	assign ird_pla4[19] = (irdbus & 0x00015000ul) == 32'h0;
	assign ird_pla4[20] = (irdbus & 0x65858000ul) == 32'h0;
	assign ird_pla4[21] = (irdbus & 0x65958940ul) == 32'h0;

	assign w569 =
		(ird_pla1[1] ? 15'h1000 : 15'h7fff) &
		(ird_pla1[2] ? 15'h0020 : 15'h7fff) &
		(ird_pla1[3] ? 15'h0020 : 15'h7fff) &
		(ird_pla1[4] ? 15'h0020 : 15'h7fff) &
		(ird_pla1[5] ? 15'h0292 : 15'h7fff) &
		(ird_pla1[6] ? 15'h050c : 15'h7fff) &
		(ird_pla1[7] ? 15'h7ce1 : 15'h7fff) &
		(ird_pla1[8] ? 15'h7ce1 : 15'h7fff) &
		(ird_pla1[9] ? 15'h7867 : 15'h7fff) &
		(ird_pla1[10] ? 15'h7867 : 15'h7fff) &
		(ird_pla1[11] ? 15'h7b61 : 15'h7fff) &
		(ird_pla1[12] ? 15'h7b61 : 15'h7fff) &
		(ird_pla1[13] ? 15'h7879 : 15'h7fff) &
		(ird_pla1[14] ? 15'h7879 : 15'h7fff) &
		(ird_pla1[16] ? 15'h47b8 : 15'h7fff) &
		(ird_pla1[17] ? 15'h3867 : 15'h7fff) &
		(ird_pla1[18] ? 15'h084d : 15'h7fff) &
		(ird_pla1[19] ? 15'h1945 : 15'h7fff) &
		(ird_pla1[20] ? 15'h0855 : 15'h7fff) &
		(ird_pla1[21] ? 15'h0c47 : 15'h7fff) &
		(ird_pla1[22] ? 15'h2a45 : 15'h7fff) &
		(ird_pla1[23] ? 15'h5845 : 15'h7fff) &
		(ird_pla1[24] ? 15'h28c5 : 15'h7fff) &
		(ird_pla1[25] ? 15'h4fe5 : 15'h7fff) &
		(ird_pla1[26] ? 15'h5fc5 : 15'h7fff) &
		(ird_pla1[27] ? 15'h6fc5 : 15'h7fff) &
		(ird_pla1[28] ? 15'h303a : 15'h7fff) &
		(ird_pla1[29] ? 15'h0002 : 15'h7fff) &
		(ird_pla1[30] ? 15'h0010 : 15'h7fff) &
		(ird_pla1[31] ? 15'h4000 : 15'h7fff) &
		(ird_pla1[32] ? 15'h0002 : 15'h7fff) &
		(ird_pla1[33] ? 15'h2101 : 15'h7fff) &
		(ird_pla1[34] ? 15'h7eba : 15'h7fff) &
		(ird_pla1[35] ? 15'h5fb6 : 15'h7fff) &
		(ird_pla1[36] ? 15'h5ef3 : 15'h7fff) &
		(ird_pla1[37] ? 15'h004c : 15'h7fff) &
		(ird_pla1[38] ? 15'h0210 : 15'h7fff) &
		(ird_pla1[39] ? 15'h75ff : 15'h7fff) &
		(ird_pla1[40] ? 15'h7fed : 15'h7fff) &
		(ird_pla1[41] ? 15'h7fed : 15'h7fff) &
		(ird_pla1[42] ? 15'h0802 : 15'h7fff) &
		(w267 ? 15'h0000 : 15'h7fff);
	
	assign w570 = ird_pla1[44] | ird_pla1[45] | ird_pla1[46];
	
	assign w571 = ~(ird_pla2[29] | ird_pla2[30] | ird_pla2[31]);
	
	assign w572 = ird_pla2[25] | ird_pla2[26] | ird_pla2[27] | ird_pla2[28];
	
	assign w573 = (ird_pla2[23] | ird_pla2[24]) & ~w529[43];
	
	assign w574 = ird_pla2[22];
	assign w575 = ird_pla2[21];
	
	assign w576 = ~(ird_pla2[19] | ird_pla2[18] | ird_pla2[17] | ird_pla2[15] | ird_pla2[14]
		| ird_pla2[12] | ird_pla2[11] | ird_pla2[10] | ird_pla2[9]);
	
	always @(posedge MCLK)
	begin
		if (c1)
			w577 <= w576;
	end
	
	assign w578 = ~(w577 | ~w529[25]);
	
	assign w579 = ~irdbus[4];
	assign w580 = ~irdbus[2];
	assign w581 = ~irdbus[0];
	
	assign w583 = 1'h0;
	
	assign w584 = ~(ird_pla2[6] | ird_pla2[5] | ird_pla2[4]);
	
	assign w585 = ~w597[15];
	
	assign w586 = ~w585;
	
	assign w587 = ~w597[14];
	
	assign w588 = ~(w584 | w587);
	assign w589 = ~(w582 | w587);
	assign w590 = ~(w585 | w587);
	
	wire [9:0] w591_ird = 
		(ird_pla3[29] ? 10'h4 : 10'h0) |
		(ird_pla3[28] ? 10'h8 : 10'h0) |
		(ird_pla3[27] ? 10'hc : 10'h0) |
		(ird_pla3[26] ? 10'h8 : 10'h0) |
		(ird_pla3[25] ? 10'h8 : 10'h0) |
		(ird_pla3[24] ? 10'h4 : 10'h0) |
		(ird_pla3[23] ? 10'h10 : 10'h0) |
		(ird_pla3[22] ? 10'h10 : 10'h0) |
		(ird_pla3[21] ? 10'h10 : 10'h0) |
		(ird_pla3[20] ? 10'h14 : 10'h0) |
		(ird_pla3[19] ? 10'h18 : 10'h0) |
		(ird_pla3[18] ? 10'h20 : 10'h0) |
		(ird_pla3[17] ? 10'h20 : 10'h0) |
		(ird_pla3[16] ? 10'h60 : 10'h0) |
		(ird_pla3[15] ? 10'h40 : 10'h0) |
		(ird_pla3[14] ? 10'h60 : 10'h0) |
		(ird_pla3[13] ? 10'h20 : 10'h0) |
		(ird_pla3[12] ? 10'h80 : 10'h0) |
		(ird_pla3[11] ? 10'h80 : 10'h0) |
		(ird_pla3[10] ? 10'h24 : 10'h0) |
		(ird_pla3[9] ? 10'h28 : 10'h0) |
		(ird_pla3[8] ? 10'h2c : 10'h0) |
		(ird_pla3[7] ? 10'h1c : 10'h0) |
		(ird_pla3[6] ? 10'h10 : 10'h0) |
		(ird_pla3[5] ? 10'h8 : 10'h0) |
		(ird_pla3[4] ? 10'h4 : 10'h0) |
		(ird_pla3[2] ? 10'h100 : 10'h0) |
		(ird_pla3[1] ? 10'h200 : 10'h0);
	
	assign w591 = ~(
		(w589 ? { 8'h0, irdbus[14], irdbus[12], irdbus[10], irdbus[8], irdbus[6], irdbus[4], irdbus[2], irdbus[0] } : 16'h0) |
		(w590 ? { irdbus[30], irdbus[28], irdbus[26], irdbus[24], irdbus[22], irdbus[20], irdbus[18], irdbus[16], 8'h0 } : 16'h0) |
		(ird_pla2[3] ? 16'h0080 : 16'h0) |
		(ird_pla2[0] ? 16'hff00 : 16'h0) |
		(ird_pla2[2] ? 16'h000f : 16'h0) |
		(w583 ? 16'hff00 : 16'h0) |
		(w597[13] ? 16'hfff0 : 16'h0) |
		(w588 ? { 12'h0, w595, w594, w593, w592 } : 16'h0) |
		(w597[17] ? { 6'h0, w591_ird } : 16'h0) |
		(w597[13] ? { 12'h0, w609, w610, w611, 1'h0 } : 16'h0)
		);
	
	assign w592 = ~irdbus[19];
	assign w593 = ~irdbus[21];
	assign w594 = ~irdbus[23];
	assign w595 = ~(irdbus[18] | irdbus[20] | irdbus[22]);
	
	always @(posedge MCLK)
	begin
		if (c1)
			w596 <= w529[42:39];
	end
	
	assign w597[0] = w596 == 4'ha;
	assign w597[1] = w596 == 4'hb;
	assign w597[2] = w596 == 4'h1;
	assign w597[3] = w596 == 4'he;
	assign w597[4] = w596 == 4'hc;
	assign w597[5] = (w596 & 4'hd) == 4'h4;
	assign w597[6] = (w596 & 4'hb) == 4'h8;
	assign w597[7] = w596 == 4'h2;
	assign w597[8] = w596[0] & ~w597[10];
	assign w597[9] = w596 == 4'h6;
	assign w597[10] = w596 == 4'hf;
	assign w597[11] = w596 == 4'h7;
	assign w597[12] = w596 == 4'h2 & ~w598;
	assign w597[13] = w596 == 4'h5;
	assign w597[14] = w596[2:0] == 3'h1;
	assign w597[15] = w596 == 4'h9;
	assign w597[16] = w596[1:0] == 2'h1;
	assign w597[17] = w596 == 4'hd;
	
	always @(posedge MCLK)
	begin
		if (c1)
			w598 <= ~w571;
	end
	
	assign w599 = ~(w597[9] | w597[10] | w597[3]);
	
	assign w600 = w597[9] ? c3 : 1'h0;
	
	assign w601 = w597[16] ? c2 : 1'h0;
	
	assign w602 = w599 ? 1'h0 : c3;
	
	assign w603 = w597[16] ? c3 : 1'h0;
	
	assign w604 = w597[12] ? c3 : 1'h0;
	
	always @(posedge MCLK)
	begin
		if (w601)
			alu_io <= 16'hffff;
		else if (w597[11])
		begin
			alu_io <= { w606, 1'h0, w607, 2'h0, w609, w610, w611, 3'h0, w760, w753, w754, w752, w751 }, 
		end
		else if (w180)
		begin
			alu_io <= r5;
		end
		else if (w603)
		begin
			alu_io <= alu_io & w591;
		end
		else if (w597[1])
		begin
			alu_io[4:0] <= w616;
		end
	end
	
	always @(posedge MCLK)
	begin
		if (c3)
		begin
			if (w597[3])
				w605 <= 1'h0;
			else if (w597[2])
				w605 <= w606;
		end
		
		if (w604)
			w606 <= alu_io[15];
		else if (w602)
			w606 <= 1'h0;
		
		if (w604)
			w607 <= alu_io[13];
		else if (w602)
			w607 <= 1'h1;
		
		if (w600)
		begin
			w609 <= ~w321;
			w610 <= ~w320;
			w611 <= ~w319;
		end
		else if (w604)
		begin
			w609 = alu_io[10];
			w610 = alu_io[9];
			w611 = alu_io[8];
		end
	end
	
	
	always @(posedge MCLK)
	begin
		if (c1)
		begin
			w613 <= w637;
			w615 <= ~(w529[63] | w529[64]);
			w618 <= w568;
		end
		
		if (w612)
			w616 <= { w617, ~ird_pla3[0], w607, w331, w332 };
		
		if (w614)
			w617 <= ~w618;
	end
	
	assign w612 = w613 ? 1'h0 : c3;
	assign w614 = w615 ? 1'h0 : c3;
	
	assign w619 = w597[0] ? c3 : 1'h0;
	
	
	always @(posedge MCLK)
	begin
		if (w619)
			w620 <= { w177, w176, w175, w174 };
	end
	
	assign w621 = ~ird_pla4[20] ? { w625, ird_pla4[11], ird_pla4[10], ird_pla4[9] } : (~ird_pla4[21] ? w620 : ~w620);
	
	assign w625 = ird_pla4[18] | ird_pla[17] | ird_pla4[16] | ird_pla4[15] | ird_pla4[14] | ird_pla4[13];
	
	assign w626 = (w529[43] | w627) ? 4'hf : w621;
	
	assign w627 = ird_pla4[8] | ird_pla4[7] | ird_pla4[6];
	
	assign w628 = ~(ird_pla4[5] | ird_pla4[4]);
	
	assign w629 = ~(w529[43] | w628);
	
	assign w630 = ird_pla4[0];
	assign w631 = ird_pla4[1];
	
	assign w632 = ~ird_pla4[3];
	
	assign w633 = ~(w529[43] | (w607 & ((~w529[60] & ~w529[59]) | w529[45] | w632)));
	
	always @(posedge MCLK)
	begin
		if (c1)
			w634 <= w633;
	end
	
	assign w635 = ~(~w529[56] | w529[57] | ~w529[58]);
	assign w636 = w635 | ~w529[56];
	
	assign w637 = ~w635;
	
	assign w640 = ~(w638 & w639);
	
	assign w642 = ~w641;
	assign w643 = ~w641 & ~w639 & w638;
	
	assign w645 = ~(w644 | w230);
	
	assign w656 = w645 ? w639 : w641;
	
	assign w647 = ~w529[27];
	
	assign w652 = w529[24];
	
	assign w651 = ~(w652 ? w984[15] : w572);
	assign w653 = ~(w652 ? w984[12] : w581);
	assign w654 = ~(w652 ? w984[13] : w580);
	assign w655 = ~(w652 ? w984[14] : w579);
	
	always @(posedge MCLK)
	begin
		if (c1)
		begin
			w638 <= w529[51];
			w639 <= ~w529[50];
			w641 <= w529[49];
			w644 <= w78;
			w648 <= w647 ? w575 : 1'h0;
			w649 <= w647 ? w574 : w573;
			w650 <= w647 ? w651 : w626[3];
			w656 <= w647 ? w655 : w626[2];
			w657 <= w647 ? w626[0] : w653;
			w658 <= w647 ? w626[1] : w654;
			w659 <= w647 ? w653 : w626[0];
			w660 <= w647 ? w654 : w626[1];
			w661 <= w647 ? w626[2] : w655;
			w662 <= w647 ? w626[3] : w651;
			w663 <= w647 ? w573 : w574;
			w664 <= w647 ? 1'h0 : w575;
			w665 <= w529[28];
			w666 <= w529[26];
		end
	end
	
	assign w667 = w648 | w649 | w665;
	
	assign w668 = ~(w648 | w665);
	
	assign w669 = ~(~w649 | w665);
	
	assign w670 = ~(w656 | w650 | w667);
	
	assign w671 = ~(~w656 | w650 | w667);
	
	assign w672 = ~(w656 | ~w650 | w667);
	
	assign w673 = ~(~w656 | ~w650 | w667);
	
	assign w674 = w663 | w664 | w666;
	
	assign w675 = ~(w664 | w666);
	
	assign w676 = ~(~w663 | w666);
	
	assign w677 = ~(~w662 | w661 | w674);
	
	assign w678 = ~(~w662 | ~w661 | w674);
	
	assign w679 = ~(w662 | w661 | w674);
	
	assign w680 = ~(w662 | ~w661 | w674);
	
	wire [2:0] alu_i = w529[4:2];
	
	assign w681 = (alu_i & 3'h5) == 3'h4;
	assign w682 = alu_i == 3'h3;
	assign w683 = alu_i == 3'h2;
	assign w684 = alu_i == 3'h1;
	assign w685 = alu_i == 3'h5;
	assign w686 = alu_i == 3'h0;
	
	assign w687 = ~w529[6];
	
	assign w688 = ~(~w529[5] | ~w529[6]);
	
	assign w689 = ~((w529[5] & ~w529[6]) | (~w529[5] & w529[6]));
	
	assign w690 = ~((w683 & (w569 & 15'h0a00) != 15'h0) | w529[5]);
	
	always @(posedge MCLK)
	begin
		if (c1)
		begin
			w691 <= ~(w689 | w570 | w685 | w684 |
				(w681 & (w569 & 15'h0341) != 15'h0) |
				(w683 & (w569 & 15'h34e9) != 15'h0) |
				(w682 & (w569 & 15'h34e9) != 15'h0));
			
			w692 <= ~(w689 | w570 |
				(w684 & (w690 | (w569 & 15'h079e) != 15'h0)));
			
			w693 <= ~(w689 | w570 |
				(w684 & (w687 | (w569 & 15'h3000) != 15'h0)));
			
			w694 <= ~(w689 | w570 |
				(w684 & (w690 | (w569 & 15'h079e) != 15'h0)));
			
			w695 <= ~(w689 | w570 |
				(w684 & (w687 | (w569 & 15'h3000) != 15'h0)));
			
			w696 <= ~(w689 | w570 |
				(w684 & (w569 & 15'h3000) != 15'h0));
			
			w697 <= ~(w689 | w570 |
				(w683 & (w569 & 15'h0104) != 15'h0));
			
			w698 <= w686;
			
			w699 <= ~(w681 & (w569 & 15'h0004) != 15'h0);
			
			w700 <= ~(w684 | (w569 & 15'h3089) != 15'h0 |
				(w681 & (w569 & 15'h07ce) != 15'h0));
			
			w701 <= ~w685 | w687;
			
			w702 <= w690;
			
			w703 <= ~(w682 & (w569 & 15'h0104) != 15'h0);
			
			w704 <= w576;
			
			w705 <= ~(w684 |
				(w681 & (w569 & 15'h0040) != 15'h0) |
				(w682 & (w569 & 15'h03b9) != 15'h0) |
				(w683 & (w569 & 15'h0379) != 15'h0));
			
			w706 <= ~(w686 & (w569 & 15'h0480) != 15'h0);
			
			w707 <= ~(w681 & (w569 & 15'h07bf) != 15'h0);
			
			w708 <= w682;
			
			w709 <= w686;
			
			w710 <= ~w569[8];
			
			w711 <= ~(w684 |
				(w681 & (w569 & 15'h02d2) != 15'h0) |
				(w682 & (w569 & 15'h0088) != 15'h0) |
				(w683 & (w569 & 15'h0008) != 15'h0));
			
			w714 <= ~ird_pla1[49];
			
			w715 <= ~ird_pla1[48];
			
			w716 <= w930;
			
			w717 <= ~(w685 |
				(w683 & (w569 & 15'h0080) != 15'h0));
			
			w718 <= ~(
				(w683 & (w569 & 15'h0771) != 15'h0) |
				(w682 & (w569 & 15'h0631) != 15'h0));
			
			w719 <= ~(w681 & (w569 & 15'h0040) != 15'h0);
			
			w720 <= ~(w681 & (w569 & 15'h0240) != 15'h0);
			
			w721 <= ~(w681 & (w569 & 15'h0002) != 15'h0);
			
			w722 <= ~(w681 & (w569 & 15'h0080) != 15'h0);
			
			w723 <= ~(w681 & (w569 & 15'h0010) != 15'h0);
			
			w724 <= ~(w681 & (w569 & 15'h02d2) != 15'h0);
			
			w725 <= ~(w681 & (w569 & 15'h050d) != 15'h0);
			
			w726 <= ~(w681 & (w569 & 15'h0001) != 15'h0);
			
			w727 <= ~(w681 & (w569 & 15'h0100) != 15'h0);
			
			w728 <= ~(
				(w683 & (w569 & 15'h0804) != 15'h0) |
				(w681 & (w569 & 15'h0400) != 15'h0) |
				(w682 & (w569 & 15'h0802) != 15'h0));
			
			w729 <= ~(
				(w682 & (w569 & 15'h0231) != 15'h0) |
				(w683 & (w569 & 15'h0300) != 15'h0));
			
			w730 <= ~(w685 | w686 |
				(w683 & (w569 & 15'h7482) != 15'h0) |
				(w681 & (w569 & 15'h200c) != 15'h0) |
				(w682 & (w569 & 15'h7444) != 15'h0));
			
			w731 <= ~(w684 |
				(w683 & (w569 & 15'h0079) != 15'h0) |
				(w681 & (w569 & 15'h02d2) != 15'h0) |
				(w682 & (w569 & 15'h0188) != 15'h0));
			
			w732 <= w529[3];
		end
	end
	
	w712 = (w685 |
		(w681 & (w569 & 15'h2000) != 15'h0) |
		(w682 & (w569 & 15'h3000) != 15'h0) |
		(w683 & (w569 & 15'h7080) != 15'h0));
	
	w713 = (w685 |
		(w682 & (w569 & 15'h2000) != 15'h0) |
		(w683 & (w569 & 15'h6080) != 15'h0));
	
	assign w734 = b3[2][15];
	assign w735 = ~w982;
	
	assign w736 = w708 ? w793 : w750;
	
	assign w743 = r8[15];
	
	assign w745 = ~w739;
	
	assign w747 = ~w717;
	
	assign w749 = w748 ? c3 : 1'h0;
	
	assign w757 = w756 ? c1 : 1'h0;
	
	assign w771 = ~w770;

	assign w774 = ~w773;
	
	always @(posedge MCLK)
	begin
		if (~w726)
			w733 <= w732;
		else if (~w714)
			w733 <= w734;
		
		if (~w715)
			w737 <= w734;
		else if (~w714)
			w737 <= w740;
		else if (~w716)
			w737 <= w735;
		
		if (~w726)
			w738 <= w740;
		else if (~w727)
			w738 <= w737;
		else if (~w728)
			w738 <= w736;
		else if (~w729)
			w738 <= ~w736;
		else if (~w730)
			w738 <= 1'h0;
		else if (~w731)
			w738 <= 1'h1;
		
		if (~w721)
			w739 <= w737;
		else if (~w722)
			w739 <= w736;
		else if (~w723)
			w739 <= 1'h0;
		else if (~w720)
			w739 <= w985;
		
		if (c2)
		begin
			w740 <= r8[15];
			w741 <= r8[0];
		end
		
		if (~w714)
			w742 <= w741;
		else if (~w715)
			w742 <= w739;
		else if (~w719)
			w742 <= w780;
		
		if (~w714)
			w744 <= w743;
		else if (~w716)
			w744 <= w962[7];
		else if (~w715)
			w744 <= w970;
		
		if (w725)
			w746 <= w737;
		else if (w724)
			w746 <= w985;
		
		if (c1)
			w748 <= w688;
		
		if (w749)
			w750 <= alu_io[4];
		else if (w790)
			w750 <= ~w791;
		
		if (w749)
			w751 <= alu_io[0];
		else if (w792)
			w751 <= ~w791;
		
		if (w749)
			w752 <= alu_io[1];
		else if (w794)
			w752 <= ~w795;
		
		if (w749)
			w753 <= alu_io[3];
		else if (w797)
			w753 <= w798;
			
		if (w749)
			w754 <= alu_io[2];
		else if (w799)
			w754 <= ~w800;
		
		if (c3)
			w755 <= 1'h1;
		else if (c1)
			w755 <= 1'h0;
		if (!c1)
			w756 <= w755;
		
		if (c3)
		begin
			w758 <= ~w691;
			w759 <= ~(w691 | w693);
			w760 <= ~(w694 | w695);
			w761 <= ~w696;
			w762 <= ~w697;
			w763 <= ~w698;
			w765 <= ~w699;
			w766 <= ~w700;
			w767 <= ~w701;
			w768 <= ~w702;
			w769 <= ~w703;
			w770 <= ~w704;
			w773 <= ~w705;
			w775 <= ~w706;
			w776 <= ~(~w706 | ~w707);
			w777 <= ~w707;
		end
	end
	
	assign w778 = w709 ? 1'h0 : c3;
	
	always @(posedge MCLK)
	begin
		if (c1)
			w779 <= ~irdbus[16];
	end
	
	assign w780 = w779 ? w751 : w805;
	
	always @(posedge MCLK)
	begin
		if (w778)
		begin
			w781 <= w746;
			w782 <= w744;
		end
	end
	
	assign w783 = w781 ^ w782;
	
	assign w785 = w775;
	assign w786 = w777;
	assign w789 = ~w776;
	
	always @(posedge MCLK)
	begin
		if (w785)
			w784 <= ~w750;
		else if (~w771 & ~w789)
			w784 <= w972;
		else if (~w772 & ~w789)
			w784 <= w978;
		else if (w786)
			w784 <= w781;
	end
	
	assign w787 = w774 ? w784 : ~w784;
	
	assign w791 = ~(w787 | (w769 & w751));
	
	assign w790 = w758 ? 1'h0 : w757;
	
	assign w792 = w759 ? 1'h0 : w757;
	
	assign w764 = w763 ? w757 : 1'h0;
	
	always @(posedge MCLK)
	begin
		if (w764)
			w793 <= ~w791;
	end
	
	assign w794 = w760 ? 1'h0 : w757;
	
	assign w795 = ~(w767 | (w796 & ~w766)
		| (w752 & w765) | (w783 & w765));
	
	assign w796 = w771 ? w977 : w971;
	
	assign w797 = w761 ? 1'h0 : w757;
	
	assign w798 = w771 ? w970 : w962[7];
	
	assign w799 = w762 ? 1'h0 : w757;
	
	assign w800 = w801 | w804;
	
	assign w801 = ~(w754 | ~w768);
	
	assign w802 = ~w975;
	assign w803 = ~(w975 & w976);
	
	assign w804 = w771 ? w803 : w802;
	
	assign w805 = w753 ^ w752;
	
	assign w806 = ~(~w724 & ~w529[17]);
	
	always @(posedge MCLK)
	begin
		if (c1)
		begin
			w807 <= w529[16];
			w808 <= ~w529[15];
		end
	end
	
	assign w809 = ~(w807 | ~w808);
	assign w810 = ~(w807 | w808);
	assign w811 = ~w807;
	
	always @(posedge MCLK)
	begin
		if (c3)
			w812 <= 1'h0;
		else if (c2)
			w812 <= 1'h1;
	end
	
	assign w815 = w159[0];
	
	assign w814 = ~(~w815 | ~w578);
	
	assign w813 = ~(w529[14] | w529[11] | w814);
	
	assign w816 = ~(w815 | ~w578);
	
	assign w817 = ~(w529[14] | w529[11] | w816);
	
	always @(posedge MCLK)
	begin
		if (w267)
		begin
			w818 <= 1'h0;
			w819 <= 1'h0;
		end
		else if (c2 | w812)
		begin
			w818 <= ~w813;
			w819 <= ~w817;
		end
	end
	
	assign w820 = ~(w724 | w725);
	
	assign w821 = ~(w529[10] & ~w529[9]);
	
	assign w822 = ~(w529[8] & ~w529[9]);
	
	assign w833 = ~(w529[11] | w529[14]);
	
	assign w834 = ~(w823 | w529[12] | w267);
	assign w835 = ~(w823 | w267 | w578 | w529[13]);
	
	assign w826 = w529[13] ^ w529[12];
	
	assign w827 = ~(~w267 & (w826 | w578));
	
	assign w828 = ~w529[14];
	
	assign w829 = ~w529[11];
	
	assign w830 = ~(w828 | w529[11]);
	assign w831 = ~(w829 | w529[14]);
	assign w832 = ~(w829 | w828);
	
	always @(posedge MCLK)
	begin
		if (c1)
		begin
			w833 <= ~w529[10];
			w834 <= ~w529[9];
			w835 <= w529[7];
		end
	end
	
	assign w836 = ~(w833 | w834);
	assign w837 = ~(w834 | ~w529[8]);
	
	always @(posedge MCLK)
	begin
		if (c2)
			w838 <= 1'h0;
		else if (c3)
			w838 <= w835;
		
		if (c2)
		begin
			w839 <= ~w529[12];
			w841 <= ~w529[13];
		end
	end

	assign w840 = ~(w839 & w838);
	assign w842 = ~(w841 & w838);
	assign w849 = ~(~w529[29] | w576);
	
	always @(posedge MCLK)
	begin
		if (c1)
		begin
			w844 <= ~w529[31];
			w845 <= ~w529[30];
			w846 <= w849;
			w848 <= ~(w849 | ~w529[32]);
			w850 <= w529[33];
			w851 <= ~w529[34];
			w852 <= ~w529[35];
		end
		
	//	if (w844 & w845)
	//		w847 <= 1'h0;
	//	else if (~w844)
	//		w847 <= c3;
	//	else if (~w845)
	//		w847 <= c2;
	//	
	//	if (w851 & w852)
	//		w853 <= 1'h0;
	//	else if (~w851)
	//		w853 <= c3;
	//	else if (~w852)
	//		w853 <= c2;
	end
	
	assign w847 = (~w845) ? c2 : ((~w844) ? c3 : 1'h0);
	assign w853 = (~w852) ? c2 : ((~w851) ? c3 : 1'h0);
	
	assign w854 = w850;
	
	assign w855 = w848;
	
	assign w856 = w846;
	
	assign w857 = w846 ? 1'h0 : c6;
	
	assign w843 = w192 ? w853 : 1'h0;
	assign w858 = w198 ? w847 : 1'h0;
	assign w859 = w197 ? w847 : 1'h0;
	assign w860 = w191 ? w853 : 1'h0;
	assign w861 = w190 ? w853 : 1'h0;
	assign w862 = w196 ? w847 : 1'h0;
	assign w863 = w195 ? w847 : 1'h0;
	assign w864 = w189 ? w853 : 1'h0;
	assign w865 = w188 ? w853 : 1'h0;
	assign w866 = w194 ? w847 : 1'h0;
	assign w867 = w193 ? w847 : 1'h0;
	assign w868 = w187 ? w853 : 1'h0;
	assign w869 = w184 ? w853 : 1'h0;
	assign w870 = w186 ? w847 : 1'h0;
	assign w871 = w185 ? w847 : 1'h0;
	assign w872 = w183 ? w853 : 1'h0;
	assign w873 = w669 ? w853 : 1'h0;
	assign w874 = w676 ? w847 : 1'h0;
	
	assign w875 = w836 ? c3 : 1'h0;
	
	assign w876 = w944[4];
	
	assign w877 = w837 ? c2 : 1'h0;
	
	assign w878 = w529[20] ? c2 : 1'h0;
	
	assign w879 = w529[21] ? c2 : 1'h0;
	
	assign w880 = w840 ? 1'h0 : clk1;
	
	assign w881 = w842 ? 1'h0 : clk1;
	
	always @(posedge MCLK)
	begin
		if (c2)
			w882 <= w827;
	end
	
	assign w883 = ~w882;
	
	always @(posedge MCLK)
	begin
		if (c2)
		begin
			w884 <= w825;
			w885 <= w824;
		end
	end
	
	assign w886 = w830 ? c2 : 1'h0;
	
	assign w887 = w831 ? c2 : 1'h0;
	
	assign w888 = w832 ? c2 : 1'h0;
	
	always @(posedge MCLK)
	begin
		if (c1)
		begin
			w889 <= w529[22];
			w891 <= w529[23];
		end
	end
	
	assign w890 = w889 ? c2 : 1'h0;
	
	assign w891 = w891 ? c2 : 1'h0;
	
	always @(posedge MCLK)
	begin
		if (c1)
		begin
			w893 <= w822;
			w894 <= w821;
		end
		
		//if (w893 & w894)
		//	w895 <= 1'h0;
		//else if (~w893)
		//	w895 <= c3;
		//else if (~w894)
		//	w895 <= c2;
	end
	
	assign w895 = (~w894) ? c2 : ((~w893) : c3 : 1'h0);
	
	assign w896 = w820 ? 1'h0 : c3;
	assign w897 = w725 ? c2 : 1'h0;
	
	always @(posedge MCLK)
	begin
		if (w725)
			w898 <= ~w733;
	end
	
	assign w899 = r8[0];
	
	assign w900 = w725 ? 1'h0 : c2;
	
	assign w901 = r8[1];
	
	assign w902 = ~w739;
	
	always @(posedge MCLK)
	begin
		if (c1)
			w904 <= w686;
	end
	
	assign w904 ? 1'h0 : c3;
	
	assign w906 = ~w710;
	assign w905 = ~w906;
	
	assign w908 = ~w907;
	assign w907 = ~c2;
	
	assign w909 = ~w738;
	
	assign w910 = w725;
	
	assign w912 = ~w711;
	
	assign w911 = w912;
	
	always @(posedge MCLK)
	begin
		if (c1)
			w913 <= w712;
	end
	
	assign w914 = ~w913;
	
	always @(posedge MCLK)
	begin
		if (c1)
			w915 <= w713;
	end
	
	assign w916 = ~w915;
	
	always @(posedge MCLK)
	begin
		if (c1)
			w917 <= ~w529[15];
	end
	
	assign w918 = ~w917;
	
	assign w919 = ~w811;
	
	assign w920 = w810 ? c2 : 1'h0;
	
	assign w921 = w809;
	
	assign w922 = w724;
	
	always @(posedge MCLK)
	begin
		if (c1)
			w924 <= ~w529[17];
	end
	
	assign w923 = ~w924;
	
	assign w925 = w718;
	assign w926 = ~w718;
	
	always @(posedge MCLK)
	begin
		if (c1)
			w927 <= w806;
	end
	
	assign w928 = ~w927;
	
	always @(posedge MCLK)
	begin
		if (c1)
			w929 <= w930;
	end
	
	assign w930 = ~ird_pla1[47];
	
	assign w931 = ~w929;
	
	assign w932 = ~w745;
	
	assign w933 = w747;
	
	assign w934 = w742;
	
	always @(posedge MCLK)
	begin
		if (c1)
			w935 <= w529[18];
	end
	
	assign w936 = w935 ? c3 : 1'h0;
	
	always @(posedge MCLK)
	begin
		if (c1)
			w937 <= w529[19];
	end
	
	assign w938 = w937 ? c3 : 1'h0;
	
	always @(posedge MCLK)
	begin
		if (c1)
			w940 <= w543;
		
		if (c2)
			w941 <= 1'h1;
		else if (c3)
			w941 <= ~w940;
	end
	
	assign w942 = clk2 ? 1'h0 : (w941 ? 1'h0 : clk1);
	
	assign w943 = w542 ? c2 : 1'h0;
	
	assign w946 = ~w856;
	
	always @(posedge MCLK)
	begin
		if (w875)
		begin
			w944 <= b3[2][4:0];
			w945 <= ~w946;
		end
	end
	
	assign w947 <= ~((w945 | ~w944[3]) ? (16'h1 << w944[2:0]) : (16'h100 << w944[2:0]));
	
	always @(posedge MCLK)
	begin
		if (w880)
			w948[7:0] <= data_io[7:0];
		if (w881)
			w948[15:8] <= data_io[15:8];
	end
	
	assign w949 = w926 ? w980 : ~w980;
	
	always @(posedge MCLK)
	begin
		if (w921)
			w950 <= b3[0];
		else if (w919)
			w950 <= w918 ? 16'hffff : 16'h0;
		else if (w920)
			w950 <= { 8'h0, w965, (w905 & w974) | (w965 & w972), (w905 & w974) | (w965 & w972), w965,
				w965, (w905 & w968) | (w965 & w969), (w905 & w968) | (w965 & w969), w965 };
	end
	
	assign w951 = ~(
		(w910 ? 16'hffff : 16'h0) |
		(w916 ? (w949 & w950) : 16'h0) |
		w952);
	
	assign w952 = ~(
		(w911 ? 16'hffff : 16'h0) |
		(w949 | w950));
	
	assign w953 = ~(
		(w911 ? 16'hffff : 16'h0) |
		(w914 ? (w949 & w950) : 16'h0));
	
	
	assign w954[0] = ~(~w953[0] | (w951[0] & ~w909));
	assign w954[1] = ~(~w953[1] | (w951[1] & ~w954[0]));
	assign w954[2] = ~(~w953[2] | (w951[2] & ~w954[1]));
	assign w954[3] = ~(~w953[3] | (w951[3] & ~w954[2]));
	
	assign w955 = ~w954[3];
	assign w954[4] = ~w955;
	
	assign w954[5] = ~(~w953[4] | (w951[4] & ~w954[4]));
	assign w954[6] = ~(~w953[5] | (w951[5] & ~w954[5]));
	assign w954[7] = ~(~w953[6] | (w951[6] & ~w954[6]));
	assign w954[8] = ~(~w953[7] | (w951[7] & ~w954[7]));
	
	assign w956 = ~w954[8];
	assign w957 = ~(w954[4] | (w951 & 16'hf0) != 16'hf0);
	assign w954[9] = ~(w956 | w957);
	
	assign w954[10] = ~(~w953[8] | (w951[8] & ~w954[9]));
	assign w954[11] = ~(~w953[9] | (w951[9] & ~w954[10]));
	assign w954[12] = ~(~w953[10] | (w951[10] & ~w954[11]));
	assign w954[13] = ~(~w953[11] | (w951[11] & ~w954[12]));
	
	assign w958 = ~w954[13];
	assign w959 = ~(w954[4] | (w951 & 16'hff0) != 16'hff0);
	assign w960 = ~(w954[9] | (w951 & 16'hf00) != 16'hf00);
	assign w914[14] = ~(w958 | w959 | w960);
	
	assign w954[15] = ~(~w953[12] | (w951[12] & ~w954[14]));
	assign w954[16] = ~(~w953[13] | (w951[13] & ~w954[15]));
	assign w954[17] = ~(~w953[14] | (w951[14] & ~w954[16]));
	assign w954[18] = ~(~w953[15] | (w951[15] & ~w954[17]));
	
	assign w961 = ~(w951 ^ {w954[17:14], w957[12:9], w957[7:4], w957[2:0], w909});
	
	always @(posedge MCLK)
	begin
		if (w903)
		begin
			w962 <= w961;
			w967 <= ~w955;
			w970 <= w961[15];
			w971 <= w954[7] ^ w954[8];
			w972 <= w956;
			w977 <= w954[17] ^ w954[18];
			w978 <= ~w954[18];
		end
		
		if (w900)
		begin
			w963 <= { w902, ~r8[15:1]};
		end
		else
		begin
			if (w897)
			begin
				w963[15:1] <= ~r8[14:0];
			end
			if (w725)
			begin
				w963[0] <= w898;
			end
		end
		
		if (w896)
			r8 <= ~w963;
		
		if (w888)
			w964 <= w962;
		else if (w887)
			w964 <= ~b3[3];
		else if (w886)
			w964 <= ~b3[1];
	end
	
	assign w965 = ~w905;
	
	assign w966 = ~(
		w962[3] & (w962[2] | w962[1])
		);
	
	assign w969 = ~w967;
	
	assign w973 = ~(
		w962[7]
		& ((w962[6] | w962[5])
			| (w962[4] & ~w966)));
	
	assign w974 = ~(w973 & ~w972);
	
	assign w975 = (w962 & 16'hff) == 16'h0;
	assign w976 = (w962 & 16'hff00) == 16'h0;
	
	assign w979 = ~b3[2][15];
	
	always @(posedge MCLK)
	begin
		if (w928)
		begin
			w980[7:0] <= b3[2][7:0];
			if (w933)
				w983[15:8] <= w983 ? 8'hff : 8'h0
			else
				w983[15:8] <= b3[2][15:8];
		end
		else if (w923)
			w980 <= w981;
		else if (w922)
		begin
			w980[6:0] <= b3[2][7:1];
			w980[7] <= w931 ? w932 : b3[2][8];
			w980[14:8] <= b3[2][15:9];
			w980[15] <= w934;
		end
		
		if (w936)
			w981 <= b3[0];
		else if (w938)
			w981 <= b3[2];
	end
	
	assign w982 = ~b3[2][7];
	assign w983 = b3[2][7];
	
	always @(posedge MCLK)
	begin
		if (w942)
			w984 <= data_io;
	end
	
	assign w985 = b3[2][0];
	
	assign w986 = w818 ? 1'h0 : clk1;
	assign w976 = w819 ? 1'h0 : clk1;
	
	always @(posedge MCLK)
	begin
		if (clk2)
			data_l <= DATA;
	end
	
	assign DATA = w361 ? ~data_io : 'bz;
	
	assign address_mux = w267 ?
		{ irdbus[23], irdbus[21], irdbus[19], irdbus[17], irdbus[15], irdbus[13], irdbus[11], irdbus[9],
			irdbus[31], irdbus[30], irdbus[29], irdbus[28], irdbus[27], irdbus[26], irdbus[25], irdbus[24],
			irdbus[22], irdbus[20], irdbus[18], irdbus[16], irdbus[14], irdbus[12], irdbus[10] }
			: { w108[7:0], w159[15:1] };
	
	assign ADDRESS = w400 ? address_mux : 'bz;
	
	always @(posedge MCLK)
	begin
		if (clk2)
		begin
			as_l1 <= w376;
			as_l3 <= w409;
		end
		if (as_l1 & clk1)
			as_l2 <= 1'h0;
		else if (~as_l1)
			as_l2 <= 1'h1;
	end
	
	assign AS = as_l3 ? 'bz : ~as_l2;
	
	always @(posedge MCLK)
	begin
		if (clk2)
		begin
			uds_l1 <= w385;
			uds_l3 <= w409;
		end
		if (uds_l1 & clk1)
			uds_l2 <= 1'h0;
		else if (~uds_l1)
			uds_l2 <= w413;
	end
	
	assign UDS = uds_l3 ? 'bz : ~uds_l2;
	
	always @(posedge MCLK)
	begin
		if (clk2)
		begin
			lds_l1 <= w385;
			lds_l3 <= w409;
		end
		if (lds_l1 & clk1)
			lds_l2 <= 1'h0;
		else if (~lds_l1)
			lds_l2 <= w412;
	end
	
	assign LDS = lds_l3 ? 'bz : ~lds_l2;

	// alu bus & registers logic
	
	wire [15:0] b1_pulldown[0:3];
	wire [15:0] b2_pulldown[0:3];
	wire [15:0] b3_pulldown[0:3];
	wire [15:0] b12_pulldown[0:3];
	wire [15:0] b23_pulldown[0:3];
	wire [15:0] b123_pulldown[0:3];
	wire [15:0] b1_pulldown_comb[0:3];
	wire [15:0] b2_pulldown_comb[0:3];
	wire [15:0] b3_pulldown_comb[0:3];
	
	assign b1_pulldown[0] = 
		(w104 ? b1[1] : 16'h0) |
		(w37 ? ~r1[0] : 16'h0) |
		(w36 ? ~r1[1] : 16'h0) |
		(w33 ? ~r1[2] : 16'h0) |
		(w32 ? ~r1[3] : 16'h0) |
		(w29 ? ~r1[4] : 16'h0) |
		(w28 ? ~r1[5] : 16'h0) |
		(w25 ? ~r1[6] : 16'h0) |
		(w24 ? ~r1[7] : 16'h0) |
		(w21 ? ~r1[8] : 16'h0) |
		(w20 ? ~r1[9] : 16'h0) |
		(w17 ? ~r1[10] : 16'h0) |
		(w16 ? ~r1[11] : 16'h0) |
		(w13 ? ~r1[12] : 16'h0) |
		(w12 ? ~r1[13] : 16'h0) |
		(w9 ? ~r1[14] : 16'h0) |
		(w8 ? ~r1[15] : 16'h0) |
		(w5 ? ~r1[16] : 16'h0) |
		(w4 ? ~r1[17] : 16'h0) |
		(w86 ? ~r2 : 16'h0) |
		(w102 ? ~r3 : 16'h0) |
		(w93 ? ~w109 : 16'h0) |
		(w125 ? 16'ffff : 16'h0);
	
	assign b1_pulldown[1] = 
		(w104 ? b1[0] : 16'h0) |
		(w37 ? r1[0] : 16'h0) |
		(w36 ? r1[1] : 16'h0) |
		(w33 ? r1[2] : 16'h0) |
		(w32 ? r1[3] : 16'h0) |
		(w29 ? r1[4] : 16'h0) |
		(w28 ? r1[5] : 16'h0) |
		(w25 ? r1[6] : 16'h0) |
		(w24 ? r1[7] : 16'h0) |
		(w21 ? r1[8] : 16'h0) |
		(w20 ? r1[9] : 16'h0) |
		(w17 ? r1[10] : 16'h0) |
		(w16 ? r1[11] : 16'h0) |
		(w13 ? r1[12] : 16'h0) |
		(w12 ? r1[13] : 16'h0) |
		(w9 ? r1[14] : 16'h0) |
		(w8 ? r1[15] : 16'h0) |
		(w5 ? r1[16] : 16'h0) |
		(w4 ? r1[17] : 16'h0) |
		(w86 ? r2 : 16'h0) |
		(w102 ? r3 : 16'h0) |
		(w93 ? w109 : 16'h0) |
		(w124 ? 16'ffff : 16'h0);
	
	assign b1_pulldown[2] = 
		(w106 ? b1[3] : 16'h0) |
		(w38 ? ~r1[0] : 16'h0) |
		(w35 ? ~r1[1] : 16'h0) |
		(w34 ? ~r1[2] : 16'h0) |
		(w31 ? ~r1[3] : 16'h0) |
		(w30 ? ~r1[4] : 16'h0) |
		(w27 ? ~r1[5] : 16'h0) |
		(w26 ? ~r1[6] : 16'h0) |
		(w23 ? ~r1[7] : 16'h0) |
		(w22 ? ~r1[8] : 16'h0) |
		(w19 ? ~r1[9] : 16'h0) |
		(w18 ? ~r1[10] : 16'h0) |
		(w15 ? ~r1[11] : 16'h0) |
		(w14 ? ~r1[12] : 16'h0) |
		(w11 ? ~r1[13] : 16'h0) |
		(w10 ? ~r1[14] : 16'h0) |
		(w7 ? ~r1[15] : 16'h0) |
		(w6 ? ~r1[16] : 16'h0) |
		(w3 ? ~r1[17] : 16'h0) |
		(w87 ? ~r2 : 16'h0) |
		(w101 ? ~r3 : 16'h0) |
		(w94 ? ~w109 : 16'h0) |
		(w79 ? w107 : 16'h0) |
		(w123 ? 16'ffff : 16'h0);
	
	assign b1_pulldown[3] = 
		(w106 ? b1[2] : 16'h0) |
		(w38 ? r1[0] : 16'h0) |
		(w35 ? r1[1] : 16'h0) |
		(w34 ? r1[2] : 16'h0) |
		(w31 ? r1[3] : 16'h0) |
		(w30 ? r1[4] : 16'h0) |
		(w27 ? r1[5] : 16'h0) |
		(w26 ? r1[6] : 16'h0) |
		(w23 ? r1[7] : 16'h0) |
		(w22 ? r1[8] : 16'h0) |
		(w19 ? r1[9] : 16'h0) |
		(w18 ? r1[10] : 16'h0) |
		(w15 ? r1[11] : 16'h0) |
		(w14 ? r1[12] : 16'h0) |
		(w11 ? r1[13] : 16'h0) |
		(w10 ? r1[14] : 16'h0) |
		(w7 ? r1[15] : 16'h0) |
		(w6 ? r1[16] : 16'h0) |
		(w3 ? r1[17] : 16'h0) |
		(w87 ? r2 : 16'h0) |
		(w101 ? r3 : 16'h0) |
		(w94 ? w109 : 16'h0) |
		(w79 ? ~w107 : 16'h0) |
		(w126 ? 16'ffff : 16'h0);
	
	assign b2_pulldown[0] =
		(w153 ? ~w147 : 16'h0) |
		(w156 ? ~r4 : 16'h0) |
		(w178 ? ~r5 : 16'h0) |
		(w235 ? ~r6[0] : 16'h0) |
		(w241 ? ~r6[1] : 16'h0) |
		(w242 ? ~r6[2] : 16'h0) |
		(w245 ? ~r6[3] : 16'h0) |
		(w246 ? ~r6[4] : 16'h0) |
		(w249 ? ~r6[5] : 16'h0) |
		(w250 ? ~r6[6] : 16'h0) |
		(w253 ? ~r6[7] : 16'h0) |
		(w254 ? ~r6[8] : 16'h0) |
		(w257 ? ~r6[9] : 16'h0) |
		(c6 ? b2[1] : 16'h0);
		
	assign b2_pulldown[1] =
		(w153 ? w147 : 16'h0) |
		(w156 ? r4 : 16'h0) |
		(w178 ? r5 : 16'h0) |
		(w235 ? r6[0] : 16'h0) |
		(w241 ? r6[1] : 16'h0) |
		(w242 ? r6[2] : 16'h0) |
		(w245 ? r6[3] : 16'h0) |
		(w246 ? r6[4] : 16'h0) |
		(w249 ? r6[5] : 16'h0) |
		(w250 ? r6[6] : 16'h0) |
		(w253 ? r6[7] : 16'h0) |
		(w254 ? r6[8] : 16'h0) |
		(w257 ? r6[9] : 16'h0) |
		(c6 ? b2[0] : 16'h0);
	
	assign b2_pulldown[2] =
		(w152 ? ~w147 : 16'h0) |
		(w163 ? w158 : 16'h0) |
		(w155 ? ~r4 : 16'h0) |
		(w179 ? ~r5 : 16'h0) |
		(w239 ? ~r6[0] : 16'h0) |
		(w240 ? ~r6[1] : 16'h0) |
		(w243 ? ~r6[2] : 16'h0) |
		(w244 ? ~r6[3] : 16'h0) |
		(w247 ? ~r6[4] : 16'h0) |
		(w248 ? ~r6[5] : 16'h0) |
		(w251 ? ~r6[6] : 16'h0) |
		(w252 ? ~r6[7] : 16'h0) |
		(w255 ? ~r6[8] : 16'h0) |
		(w256 ? ~r6[9] : 16'h0) |
		(c6 ? b2[3] : 16'h0);
	
	assign b2_pulldown[3] =
		(w152 ? w147 : 16'h0) |
		(w163 ? ~w158 : 16'h0) |
		(w155 ? r4 : 16'h0) |
		(w179 ? r5 : 16'h0) |
		(w239 ? r6[0] : 16'h0) |
		(w240 ? r6[1] : 16'h0) |
		(w243 ? r6[2] : 16'h0) |
		(w244 ? r6[3] : 16'h0) |
		(w247 ? r6[4] : 16'h0) |
		(w248 ? r6[5] : 16'h0) |
		(w251 ? r6[6] : 16'h0) |
		(w252 ? r6[7] : 16'h0) |
		(w255 ? r6[8] : 16'h0) |
		(w256 ? r6[9] : 16'h0) |
		(c6 ? b2[2] : 16'h0);
	
	assign b3_pulldown[0] =
		(w877 ? w947 : 16'h0) |
		(w878 ? w948 : 16'h0) |
		(w892 ? ~w962 : 16'h0) |
		(w843 ? ~r7[0] : 16'h0) |
		(w860 ? ~r7[1] : 16'h0) |
		(w861 ? ~r7[2] : 16'h0) |
		(w864 ? ~r7[3] : 16'h0) |
		(w865 ? ~r7[4] : 16'h0) |
		(w868 ? ~r7[5] : 16'h0) |
		(w869 ? ~r7[6] : 16'h0) |
		(w872 ? ~r7[7] : 16'h0) |
		(w873 ? ~r7[8] : 16'h0) |
		(w895 ? ~r8 : 16'h0) |
		(c6 ? b3[1] : 16'h0);
	
	assign b3_pulldown[1] =
		(w877 ? ~w947 : 16'h0) |
		(w878 ? ~w948 : 16'h0) |
		(w892 ? w962 : 16'h0) |
		(w843 ? r7[0] : 16'h0) |
		(w860 ? r7[1] : 16'h0) |
		(w861 ? r7[2] : 16'h0) |
		(w864 ? r7[3] : 16'h0) |
		(w865 ? r7[4] : 16'h0) |
		(w868 ? r7[5] : 16'h0) |
		(w869 ? r7[6] : 16'h0) |
		(w872 ? r7[7] : 16'h0) |
		(w873 ? r7[8] : 16'h0) |
		(w895 ? r8 : 16'h0) |
		(c6 ? b3[0] : 16'h0);
	
	assign b3_pulldown[2] =
		(w879 ? w948 : 16'h0) |
		(w890 ? ~w962 : 16'h0) |
		(w858 ? ~r7[0] : 16'h0) |
		(w859 ? ~r7[1] : 16'h0) |
		(w862 ? ~r7[2] : 16'h0) |
		(w863 ? ~r7[3] : 16'h0) |
		(w866 ? ~r7[4] : 16'h0) |
		(w867 ? ~r7[5] : 16'h0) |
		(w870 ? ~r7[6] : 16'h0) |
		(w871 ? ~r7[7] : 16'h0) |
		(w874 ? ~r7[8] : 16'h0) |
		(c6 ? { 8'h0, b3[3][7:0] } : 16'h0) |
		(w857 ? { b3[3][15:8], 8'h0 } : 16'h0);
	
	assign b3_pulldown[3] =
		(w879 ? ~w948 : 16'h0) |
		(w890 ? w962 : 16'h0) |
		(w858 ? r7[0] : 16'h0) |
		(w859 ? r7[1] : 16'h0) |
		(w862 ? r7[2] : 16'h0) |
		(w863 ? r7[3] : 16'h0) |
		(w866 ? r7[4] : 16'h0) |
		(w867 ? r7[5] : 16'h0) |
		(w870 ? r7[6] : 16'h0) |
		(w871 ? r7[7] : 16'h0) |
		(w874 ? r7[8] : 16'h0) |
		(c6 ? { 8'h0, b3[2][7:0] } : 16'h0) |
		(w857 ? { b3[2][15:8], 8'h0 } : 16'h0);
	
	assign b12_pulldown[0] = b1_pulldown[0] | b2_pulldown[0];
	assign b12_pulldown[1] = b1_pulldown[1] | b2_pulldown[1];
	assign b12_pulldown[2] = b1_pulldown[2] | b2_pulldown[2];
	assign b12_pulldown[3] = b1_pulldown[3] | b2_pulldown[3];
	assign b23_pulldown[0] = b2_pulldown[0] | b3_pulldown[0];
	assign b23_pulldown[1] = b2_pulldown[1] | b3_pulldown[1];
	assign b23_pulldown[2] = b2_pulldown[2] | b3_pulldown[2];
	assign b23_pulldown[3] = b2_pulldown[3] | b3_pulldown[3];
	assign b123_pulldown[0] = b1_pulldown[0] | b2_pulldown[0] | b3_pulldown[0];
	assign b123_pulldown[1] = b1_pulldown[1] | b2_pulldown[1] | b3_pulldown[1];
	assign b123_pulldown[2] = b1_pulldown[2] | b2_pulldown[2] | b3_pulldown[2];
	assign b123_pulldown[3] = b1_pulldown[3] | b2_pulldown[3] | b3_pulldown[3];
	
	assign b1_pulldown_comb[0] = (w128 & w854) ? b123_pulldown[0] : (w128 ? b12_pulldown[0] : b1_pulldown[0]);
	assign b1_pulldown_comb[1] = (w128 & w854) ? b123_pulldown[1] : (w128 ? b12_pulldown[1] : b1_pulldown[1]);
	assign b1_pulldown_comb[2] = (w128 & w854) ? b123_pulldown[2] : (w128 ? b12_pulldown[2] : b1_pulldown[2]);
	assign b1_pulldown_comb[3] = (w128 & w854) ? b123_pulldown[3] : (w128 ? b12_pulldown[3] : b1_pulldown[3]);
	assign b2_pulldown_comb[0] = (w128 & w854) ? b123_pulldown[0] : (w128 ? b12_pulldown[0] : (w854 ? b23_pulldown[0] : b2_pulldown[0]));
	assign b2_pulldown_comb[1] = (w128 & w854) ? b123_pulldown[1] : (w128 ? b12_pulldown[1] : (w854 ? b23_pulldown[1] : b2_pulldown[1]));
	assign b2_pulldown_comb[2] = (w128 & w854) ? b123_pulldown[2] : (w128 ? b12_pulldown[2] : (w854 ? b23_pulldown[2] : b2_pulldown[2]));
	assign b2_pulldown_comb[3] = (w128 & w854) ? b123_pulldown[3] : (w128 ? b12_pulldown[3] : (w854 ? b23_pulldown[3] : b2_pulldown[3]));
	assign b3_pulldown_comb[0] = (w128 & w854) ? b123_pulldown[0] : (w854 ? b23_pulldown[0] : b3_pulldown[0]);
	assign b3_pulldown_comb[1] = (w128 & w854) ? b123_pulldown[1] : (w854 ? b23_pulldown[1] : b3_pulldown[1]);
	assign b3_pulldown_comb[2] = (w128 & w854) ? b123_pulldown[2] : (w854 ? b23_pulldown[2] : b3_pulldown[2]);
	assign b3_pulldown_comb[3] = (w128 & w854) ? b123_pulldown[3] : (w854 ? b23_pulldown[3] : b3_pulldown[3]);
	
	always @(posedge MCLK)
	begin
		b1[0] <= ~b1_pulldown_comb[0];
		b1[1] <= ~b1_pulldown_comb[1];
		b1[2] <= ~b1_pulldown_comb[2];
		b1[3] <= ~b1_pulldown_comb[3];
		b2[0] <= ~b2_pulldown_comb[0];
		b2[1] <= ~b2_pulldown_comb[1];
		b2[2] <= ~b2_pulldown_comb[2];
		b2[3] <= ~b2_pulldown_comb[3];
		b3[0] <= ~b3_pulldown_comb[0];
		b3[1] <= ~b3_pulldown_comb[1];
		b3[2] <= ~b3_pulldown_comb[2];
		b3[3] <= ~b3_pulldown_comb[3];
		
		if (w38)
			r1[0] <= (r1[0] & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		else if (w37)
			r1[0] <= (r1[0] & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		if (w36)
			r1[1] <= (r1[1] & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		else if (w35)
			r1[1] <= (r1[1] & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		if (w34)
			r1[2] <= (r1[2] & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		else if (w33)
			r1[2] <= (r1[2] & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		if (w32)
			r1[3] <= (r1[3] & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		else if (w31)
			r1[3] <= (r1[3] & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		if (w30)
			r1[4] <= (r1[4] & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		else if (w29)
			r1[4] <= (r1[4] & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		if (w28)
			r1[5] <= (r1[5] & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		else if (w27)
			r1[5] <= (r1[5] & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		if (w26)
			r1[6] <= (r1[6] & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		else if (w25)
			r1[6] <= (r1[6] & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		if (w24)
			r1[7] <= (r1[7] & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		else if (w23)
			r1[7] <= (r1[7] & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		if (w22)
			r1[8] <= (r1[8] & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		else if (w21)
			r1[8] <= (r1[8] & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		if (w20)
			r1[9] <= (r1[9] & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		else if (w19)
			r1[9] <= (r1[9] & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		if (w18)
			r1[10] <= (r1[10] & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		else if (w17)
			r1[10] <= (r1[10] & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		if (w16)
			r1[11] <= (r1[11] & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		else if (w15)
			r1[11] <= (r1[11] & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		if (w14)
			r1[12] <= (r1[12] & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		else if (w13)
			r1[12] <= (r1[12] & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		if (w12)
			r1[13] <= (r1[13] & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		else if (w11)
			r1[13] <= (r1[13] & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		if (w10)
			r1[14] <= (r1[14] & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		else if (w9)
			r1[14] <= (r1[14] & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		if (w8)
			r1[15] <= (r1[15] & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		else if (w7)
			r1[15] <= (r1[15] & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		if (w6)
			r1[16] <= (r1[16] & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		else if (w5)
			r1[16] <= (r1[16] & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		if (w4)
			r1[17] <= (r1[17] & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		else if (w3)
			r1[17] <= (r1[17] & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		
		if (w87)
			r2 <= (r2 & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		else if (w86)
			r2 <= (r2 & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		else if (w92)
			r2 <= w109;
		
		if (w101)
			r3 <= (r3 & ~b1_pulldown_comb[2]) | b1_pulldown_comb[3];
		else if (w102)
			r3 <= (r3 & ~b1_pulldown_comb[0]) | b1_pulldown_comb[1];
		
		if (w155)
			r4 <= (r4 & ~b2_pulldown_comb[2]) | b2_pulldown_comb[3];
		else if (w156)
			r4 <= (r4 & ~b2_pulldown_comb[0]) | b2_pulldown_comb[1];
		else if (w154)
			r4 <= w147;
		
		if (w179)
			r5 <= (r5 & ~b2_pulldown_comb[2]) | b2_pulldown_comb[3];
		else if (w178)
			r5 <= (r5 & ~b2_pulldown_comb[0]) | b2_pulldown_comb[1];
		else if (w181)
			r5 <= alu_io;
		
		if (w235)
			r6[0] <= (r6[0] & ~b2_pulldown_comb[0]) | b2_pulldown_comb[1];
		else if (w239)
			r6[0] <= (r6[0] & ~b2_pulldown_comb[2]) | b2_pulldown_comb[3];
		if (w240)
			r6[1] <= (r6[1] & ~b2_pulldown_comb[2]) | b2_pulldown_comb[3];
		else if (w241)
			r6[1] <= (r6[1] & ~b2_pulldown_comb[0]) | b2_pulldown_comb[1];
		if (w242)
			r6[2] <= (r6[2] & ~b2_pulldown_comb[0]) | b2_pulldown_comb[1];
		else if (w243)
			r6[2] <= (r6[2] & ~b2_pulldown_comb[2]) | b2_pulldown_comb[3];
		if (w244)
			r6[3] <= (r6[3] & ~b2_pulldown_comb[2]) | b2_pulldown_comb[3];
		else if (w245)
			r6[3] <= (r6[3] & ~b2_pulldown_comb[0]) | b2_pulldown_comb[1];
		if (w246)
			r6[4] <= (r6[4] & ~b2_pulldown_comb[0]) | b2_pulldown_comb[1];
		else if (w247)
			r6[4] <= (r6[4] & ~b2_pulldown_comb[2]) | b2_pulldown_comb[3];
		if (w248)
			r6[5] <= (r6[5] & ~b2_pulldown_comb[2]) | b2_pulldown_comb[3];
		else if (w249)
			r6[5] <= (r6[5] & ~b2_pulldown_comb[0]) | b2_pulldown_comb[1];
		if (w250)
			r6[6] <= (r6[6] & ~b2_pulldown_comb[0]) | b2_pulldown_comb[1];
		else if (w251)
			r6[6] <= (r6[6] & ~b2_pulldown_comb[2]) | b2_pulldown_comb[3];
		if (w252)
			r6[7] <= (r6[7] & ~b2_pulldown_comb[2]) | b2_pulldown_comb[3];
		else if (w253)
			r6[7] <= (r6[7] & ~b2_pulldown_comb[0]) | b2_pulldown_comb[1];
		if (w254)
			r6[8] <= (r6[8] & ~b2_pulldown_comb[0]) | b2_pulldown_comb[1];
		else if (w255)
			r6[8] <= (r6[8] & ~b2_pulldown_comb[2]) | b2_pulldown_comb[3];
		if (w256)
			r6[9] <= (r6[9] & ~b2_pulldown_comb[2]) | b2_pulldown_comb[3];
		else if (w257)
			r6[9] <= (r6[9] & ~b2_pulldown_comb[0]) | b2_pulldown_comb[1];
		
		if (w843)
			r6[0] <= (r6[0] & ~b3_pulldown_comb[0]) | b3_pulldown_comb[1];
		else if (w858)
			r6[0] <= (r6[0] & ~b3_pulldown_comb[2]) | b3_pulldown_comb[3];
		if (w859)
			r6[1] <= (r6[1] & ~b3_pulldown_comb[2]) | b3_pulldown_comb[3];
		else if (w860)
			r6[1] <= (r6[1] & ~b3_pulldown_comb[0]) | b3_pulldown_comb[1];
		if (w861)
			r6[2] <= (r6[2] & ~b3_pulldown_comb[0]) | b3_pulldown_comb[1];
		else if (w862)
			r6[2] <= (r6[2] & ~b3_pulldown_comb[2]) | b3_pulldown_comb[3];
		if (w863)
			r6[3] <= (r6[3] & ~b3_pulldown_comb[2]) | b3_pulldown_comb[3];
		else if (w864)
			r6[3] <= (r6[3] & ~b3_pulldown_comb[0]) | b3_pulldown_comb[1];
		if (w865)
			r6[4] <= (r6[4] & ~b3_pulldown_comb[0]) | b3_pulldown_comb[1];
		else if (w866)
			r6[4] <= (r6[4] & ~b3_pulldown_comb[2]) | b3_pulldown_comb[3];
		if (w867)
			r6[5] <= (r6[5] & ~b3_pulldown_comb[2]) | b3_pulldown_comb[3];
		else if (w868)
			r6[5] <= (r6[5] & ~b3_pulldown_comb[0]) | b3_pulldown_comb[1];
		if (w869)
			r6[6] <= (r6[6] & ~b3_pulldown_comb[0]) | b3_pulldown_comb[1];
		else if (w870)
			r6[6] <= (r6[6] & ~b3_pulldown_comb[2]) | b3_pulldown_comb[3];
		if (w871)
			r6[7] <= (r6[7] & ~b3_pulldown_comb[2]) | b3_pulldown_comb[3];
		else if (w872)
			r6[7] <= (r6[7] & ~b3_pulldown_comb[0]) | b3_pulldown_comb[1];
		if (w873)
			r6[8] <= (r6[8] & ~b3_pulldown_comb[0]) | b3_pulldown_comb[1];
		else if (w874)
			r6[8] <= (r6[8] & ~b3_pulldown_comb[2]) | b3_pulldown_comb[3];
			
		if (w895)
			r8 <= (r8 & ~b3_pulldown_comb[0]) | b3_pulldown_comb[1];
	end
	
endmodule

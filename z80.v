module z80cpu
	(
	input MCLK,
	input CLK,
	output [15:0] ADDRESS,
	inout [7:0] DATA,
	output M1,
	output MREQ,
	output IORQ,
	output RD,
	output WR,
	output RFSH,
	output HALT,
	input WAIT,
	input INT,
	input NMI,
	input RESET,
	input BUSRQ,
	output BUSAK
	);
	
	wire clk = CLK;
	
	wire w1;
	wire w2;
	wire w3;
	wire w4, w4_i;
	wire w5;
	wire w6, w6_i;
	wire w7;
	wire w8, w8_i;
	wire w9_n, w9_i;
	reg w9;
	wire w10;
	wire w11;
	wire w12;
	wire w15;
	wire w16;
	wire w18, w18_i;
	wire w19, w19_i;
	wire w21, w21_i;
	wire w22, w22_i;
	wire w23;
	wire w24;
	wire w25;
	wire w26;
	wire w27;
	wire w28;
	reg w30;
	wire w31, w31_i;
	wire w32;
	wire w33, w33_i;
	wire w34, w34_i;
	wire w35;
	wire w36;
	wire w37, w37_i; //
	wire w38;
	wire w39, w39_i;
	reg w40, w40_i;
	wire w41;
	wire w42;
	wire w43;
	wire w44, w44_n, w44_i;
	wire w45;
	wire w46;
	wire w47;
	wire w48, w48_i;
	wire w49;
	wire w50, w50_i;
	wire w51, w51_i;
	wire w52;
	wire w53;
	wire w54;
	wire w55;
	wire w56;
	wire w57;
	wire w58, w58_i;
	wire w59;
	wire w60;
	wire w61, w61_i;
	wire w62;
	wire w63, w63_t;
	wire w65;
	wire w66, w66_i;
	wire w67;
	wire o_busak;
	wire w68, w68_i;
	wire w69;
	wire w71;
	reg w73;
	reg w74;
	wire w75;
	wire w76;
	wire w77;
	reg w78_i;
	wire w78;
	wire w79;
	reg w80;
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
	reg w92;
	wire w93;
	wire w94;
	reg w95_i;
	wire w95;
	wire w96;
	wire w97;
	wire w98;
	wire w99;
	reg w100;
	wire w101;
	wire w102;
	wire w103;
	wire w104;
	wire w105;
	wire w106;
	wire w107;
	wire w109_i;
	wire w109;
	wire w110;
	wire w111;
	wire w112;
	wire w114, w114_i;
	wire w115, w115_i;
	wire w116;
	wire w117;
	wire w118;
	wire w120, w120_i;
	wire w121, w121_i;
	wire w122;
	wire w123, w123_i;
	wire w124;
	wire w125;
	wire w126;
	wire w127, w127_i;
	wire w128;
	wire w129;
	wire rfsh_rs, rfsh;
	wire w130;
	wire w131, w131_i;
	wire w132;
	wire w133;
	wire w134;
	wire w135;
	wire w136;
	wire w137;
	wire w138;
	wire w139;
	wire w140;
	wire w141;
	wire w142;
	wire w143;
	wire w144;
	reg [7:0] w145;
	reg [7:0] w146; // bus 1
	wire bu1; // bus 1 pull
	reg [7:0] w147;
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
	wire w158;
	wire w159;
	wire w160;
	wire w161;
	wire w162;
	wire w163;
	wire w164;
	wire w165;
	wire w166;
	wire w167;
	wire w168;
	wire w169;
	wire w170;
	wire w171;
	wire w172;
	wire w173;
	wire w174;
	wire w175;
	wire w176;
	wire w177;
	wire w178;
	wire w179;
	wire w180;
	wire w181;
	wire w182;
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
	wire w194;
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
	wire w210, w210_i;
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
	wire w229;
	wire w230;
	wire w231;
	wire w232;
	wire w233;
	wire w234;
	wire w235;
	wire w236;
	wire w237;
	wire w238;
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
	wire w258;
	wire w259;
	wire w260;
	wire w261;
	wire w262;
	wire w263;
	wire w264;
	wire w265;
	wire w266;
	wire w267;

	wire w530;
	wire w532;
	
	wire halt;
	
	wire l1;
	wire l2;
	wire l3;
	wire l4;
	wire l5;
	wire l6;
	wire l7;
	wire l8;
	wire l9;
	wire l10;
	wire l11;
	wire l12;
	wire l13;
	wire l14;
	wire l15;
	wire l16;
	wire l17;
	wire l18;
	wire l19;
	wire l20;
	wire l21;
	wire l22;
	wire l23;
	wire l24;
	wire l25;
	wire l26;
	wire l27;
	wire l28;
	wire l29;
	wire l30;
	wire l31;
	wire l32;
	wire l33;
	wire l34;
	wire l35;
	wire l36;
	wire l37;
	wire l38;
	wire l39;
	wire l40;
	wire l41;
	
	wire l43;
	
	// pla
	
	wire [98:0] pla;
	
	
	//
	
	wire w1_i;
	
	assign w1 = ~w1_i;
	
	z80_rs_trig_nor rs1
		(
		.MCLK(MCLK),
		.rst(clk & w3 & w41),
		.set(w55 | (clk & (w114 | w201))),
		.q(w1_i),
		.nq()
		);
		
	z80_dlatch dl1
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w69),
		.outp(l1)
		);
	
	z80_rs_trig_nor rs2
		(
		.MCLK(MCLK),
		.rst((clk & w131 & w41) | (~clk & ~l1)),
		.set(clk & w15),
		.q(w2),
		.nq()
		);
	
	
	assign w3 = ~(w201 | w202);
	
	
	z80_rs_trig_nand rs4
		(
		.MCLK(MCLK),
		.nset(clk | ~INT),
		.nrst(clk | INT),
		.q(w4),
		.nq(w4_i)
		);
	
	
	z80_rs_trig_nor rs5
		(
		.MCLK(MCLK),
		.rst(clk & w4_i),
		.set(clk & w4),
		.q(w5),
		.nq()
		);
		
	z80_dlatch dl2
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~(w55 | w19)),
		.outp(l2)
		);
	
	wire nmi = ~NMI;
	
	z80_rs_trig_nor rs7
		(
		.MCLK(MCLK),
		.rst(~l2),
		.set(~nmi),
		.q(w7),
		.nq()
		);
	
	z80_rs_trig_nor rs6
		(
		.MCLK(MCLK),
		.rst(~l2 | (nmi & ~w7)),
		.set(nmi & w7),
		.q(w6),
		.nq(w6_i)
		);
	
	
	z80_rs_trig_nand rs8
		(
		.MCLK(MCLK),
		.nset(clk | w6),
		.nrst(clk | w6_i),
		.q(w8),
		.nq(w8_i)
		);
	
	z80_rs_trig_nor rs6
		(
		.MCLK(MCLK),
		.rst(clk & w8_i),
		.set(clk & w8),
		.q(w9_n),
		.nq(w9_i)
		);
	
	always @(w9_n or w9_i)
	begin
		if (w9_i)
			w9 <= 1'h0;
		else if (w9_n)
			w9 <= 1'h1;
	end
	
	assign w10 = ~(w12 | w9 | w11);
	
	assign w11 = ~(w12 | w9 | ~pla[3]);
		
	z80_dlatch dl3
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~w73 | pla[1]),
		.outp(l3)
		);
	
	assign w12 = ~(w5 | w9 | l3);
	
	assign w13 = ~((w16 & ~w10) | w18 | w19 | halt);
	
	assign w14 = ~(w13 | (w16 | w10));
	
	assign w15 = ~(~w114 | w202 | w201);
		
	z80_dlatch dl4
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~(w55 | ~w97 | ~w118 | w133)),
		.outp(l4)
		);
	
	assign w16 = l4 & ~clk;
	
	z80_rs_trig_nor rs18
		(
		.MCLK(MCLK),
		.rst(w16 & w12),
		.set((w16 & ~w12) | w55),
		.q(w18_i),
		.nq()
		);
	
	assign w18 = ~w18_i;
	
	z80_rs_trig_nor rs19
		(
		.MCLK(MCLK),
		.rst(w16 & w9),
		.set((w16 & ~w9) | w55),
		.q(w19_i),
		.nq()
		);
	
	assign w19 = ~w19_i;
	
	z80_rs_trig_nor rs21
		(
		.MCLK(MCLK),
		.rst(w32 | w26),
		.set(w24),
		.q(w21),
		.nq(w21_i)
		);
	
	assign MREQ = ~w21_i ? 1'h0 : ((~w21 & ~w62) ? 1'h1 : 1'hz);
	
	z80_rs_trig_nor rs22
		(
		.MCLK(MCLK),
		.rst(w26 | w32),
		.set(w23 | (w36 & clk)),
		.q(w22),
		.nq(w22_i)
		);
	
	assign IORQ = ~w22_i ? 1'h0 : ((~w22 & ~w62) ? 1'h1 : 1'hz);
		
	z80_dlatch dl5
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w35),
		.outp(l5)
		);
	
	assign w23 = ~clk & ~l5;
		
	z80_dlatch dl6
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w27),
		.outp(l6)
		);
	
	assign w24 = ~clk & ~w202 & ~l6;
	
	assign w25 = ~(w24 | w23 | (w36 & clk));
	
	assign w26 = w131 & w41 & clk;
	
	assign w27 = !((w110 & w93) | (w131 & (w41 | (w110 & ~w18))));
		
	z80_dlatch dl7
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w57),
		.outp(l7)
		);
	
	assign w28 = ~(halt | (w18 & w80) | w55 | w19 | ~(w18 | l7));
	
	always @(posedge MCLK)
	begin
		if (w55)
			w30 <= 1'h1;
		else if (clk)
			w30 <= w30;
		else if (w103)
			w30 <= w28;
	end
		
	z80_dlatch dl8
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w101),
		.outp(l8)
		);
	
	z80_rs_trig_nor rs31
		(
		.MCLK(MCLK),
		.rst(w26 | w32),
		.set(~w25 & l8),
		.q(w31),
		.nq(w31_i)
		);
	
	assign RD = ~w31_i ? 1'h0 : ((~w31 & ~w62) ? 1'h1 : 1'hz);
	
		
	z80_dlatch dl9
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w94),
		.outp(l9)
		);
	
	
	assign w32 = ~clk & l9;
	
	z80_rs_trig_nor rs33
		(
		.MCLK(MCLK),
		.rst(~clk & l10),
		.set(~l11 | (clk & w106 & w114 & w201)),
		.q(w33),
		.nq(w33_i)
		);
	
	assign WR = ~w33_i ? 1'h0 : ((~w33 & ~w62) ? 1'h1 : 1'hz);
		
	z80_dlatch dl10
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~w41 & ~w55),
		.outp(l10)
		);
		
	z80_dlatch dl11
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~(w114 & w201)),
		.outp(l11)
		);
	
	wire w34_v = ~(l12 & w112);
	
	z80_rs_trig_nand rs34
		(
		.MCLK(MCLK),
		.nset(clk | ~w34_v),
		.nrst(clk | w34_v),
		.q(w34),
		.nq(w34_i)
		);
		
	z80_dlatch dl12
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~w41 & ~(~w114 & ~w34_i)),
		.outp(l12)
		);
	
	assign w35 = ~(~w37 & ~w131 & w18);
	
	assign w36 = w114 & w106;
	
	z80_rs_trig_nand rs37
		(
		.MCLK(MCLK),
		.nset(clk | ~w531),
		.nrst(clk | w531),
		.q(w37),
		.nq(w37_i)
		);
	
	z80_dlatch dl_w38
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~(((w18 & w131) | w106) & (~w37 | w114))),
		.outp(w38)
		)
	
	z80_rs_trig_nor rs39
		(
		.MCLK(MCLK),
		.rst(clk & ~(w38 & WAIT)),
		.set(clk & (w38 & WAIT)),
		.q(w39),
		.nq(w39_i)
		);
	
	always @(posedge MCLK)
	begin
		w40 <= ~(w202 | (w40_i & (clk | w39)));
		w40_i <= ~(w40 & (clk | w39_i)));
	end
	
	assign w41 = ~w40 & ~w34;
	
	assign w42 = ~clk & ~w43;
	
	assign w43 = ~(~pla[35] & l13);
	
	z80_dlatch dl13
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w110 & w201),
		.outp(l13)
		)
	
	z80_rs_trig_nor rs44
		(
		.MCLK(MCLK),
		.rst(w45),
		.set(l14 | (clk & w110)),
		.q(w44_n),
		.nq(w44_i)
		);
	
	z80_dlatch dl14
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w113),
		.outp(l14)
		)
		
	assign w44 = ~w44_i;
	
	z80_dlatch dl15
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~(w201 & w110)),
		.outp(l15)
		)
	
	assign w45 = ~clk & ~l15;
	
	assign w46 = ~(w131 | (w127 & pla[35]) | (w127 & w107));
	
	assign w47 = ~clk & ~l16;
	
	z80_dlatch dl16
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~(w107 & w127 & w41)),
		.outp(l16)
		)
	
	z80_dlatch dl17
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~(w114 & w131)),
		.outp(l17)
		)
	
	z80_dlatch dl18
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~(w41 | w55)),
		.outp(l18)
		)
	
	z80_rs_trig_nand rs48
		(
		.MCLK(MCLK),
		.nset(clk | l17),
		.nrst(clk | l18),
		.q(w48),
		.nq(w48_i)
		);
	
	assign w49 = ~(w48 | w47);
	
	z80_rs_trig_nand rs50
		(
		.MCLK(MCLK),
		.nset(clk | RESET),
		.nrst(clk | ~RESET),
		.q(w50),
		.nq(w50_i)
		);
	
	z80_rs_trig_nor rs51
		(
		.MCLK(MCLK),
		.rst(clk & w50_i),
		.set(clk & w50),
		.q(w51),
		.nq(w51_i)
		);
		
	assign w52 = ~clk & l19;
	
	z80_dlatch dl19
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~(w131 & w114)),
		.outp(l19)
		)
		
	assign w53 = ~clk & ~l20 & ~w55;
	
	z80_dlatch dl20
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~(w131 & w114)),
		.outp(l20)
		);
	
	z80_rs_trig_nor rs54
		(
		.MCLK(MCLK),
		.rst(w52 & w51)
		.set(w52 & w51_i),
		.q(w54),
		.nq()
		);
	
	assign w55 = ~w54;
	
	z80_rs_trig_nor rs56
		(
		.MCLK(MCLK),
		.rst(w53 & w51)
		.set((w53 & w104 & ~w51) | w55),
		.q(w56),
		.nq()
		);
	
	assign w57 = w56 | ~w104;
	
	z80_rs_trig_nand rs58
		(
		.MCLK(MCLK),
		.nset(clk | BUSRQ),
		.nrst(clk | ~BUSRQ),
		.q(w58),
		.nq(w58_i)
		);
	
	z80_rs_trig_nor rs59
		(
		.MCLK(MCLK),
		.rst(clk & w58_i),
		.set(clk & w58),
		.q(w59),
		.nq()
		);
	
	z80_dlatch dl21
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w68),
		.outp(l21)
		);
	
	assign w60 = l21 & w112;
	
	z80_rs_trig_nand rs61
		(
		.MCLK(MCLK),
		.nset(clk | ~w60),
		.nrst(clk | w60),
		.q(),
		.nq(w61_i)
		);
	
	assign w61 = ~w61_i;
	
	assign w62 = l22 | o_busak;
	
	z80_dlatch dl22
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(o_busak),
		.outp(l22)
		);
	
	assign o_busak = ~w65 & ~w66_i & ~w67;
	
	assign BUSAK = ~o_busak;
	
	z80_dlatch dl23
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w55),
		.outp(l23)
		);
	
	z80_rs_trig_nand rs63
		(
		.MCLK(MCLK),
		.nset(clk | ~l23),
		.nrst(clk | l23),
		.q(),
		.nq(w63_t)
		);
	
	assign w63 = ~(w63_t | ~(clk | ~l23));
	
	z80_dlatch dl24
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~w63 & ~w133),
		.outp(l24)
		);
	
	assign w65 = ~(~l24 | clk | ~w59);
	
	z80_rs_trig_nor rs66
		(
		.MCLK(MCLK),
		.rst(w63 | w67),
		.set(w65),
		.q(w66),
		.nq(w66_i)
		);
	
	assign w67 = ~clk & ~w59;
	
	z80_dlatch dl25
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w109),
		.outp(l25)
		);
	
	assign w68 = ~w68_i;
	
	wire w68_v = ~(l25 & w112);
	
	z80_rs_trig_nand rs68
		(
		.MCLK(MCLK),
		.nset(clk | w68_v),
		.nrst(clk | ~w68_v),
		.q()
		.nq(w68_i);
		);
	
	assign w69 = ~(w55 | (w41 & ~w131));
	
	z80_dlatch dl26
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~(w131 & pla[1] & w110),
		.outp(l26)
		);
	
	assign w71 = ~clk & ~l26;
	
	always @(posedge MCLK)
	begin
		if (w19 | w18 | w55)
			w73 <= 0;
		else if (clk)
			w73 <= w73;
		else if (w71)
			w73 <= w147[3];
		else if (w75)
			w73 <= w74;
	begin
	
	always @(posedge MCLK)
	begin
		if (w18 | w55)
			w74 <= 0;
		else if (clk)
			w74 <= w74;
		else if (w71)
			w74 <= w147[3];
	end
	
	z80_dlatch dl27
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w76),
		.outp(l27)
		);
	
	assign w75 = ~clk & ~l27 & ~w19;
	
	assign w76 = ~(pla[52] & w131 & w114);
	
	assign w77 = w89 & w19;
	
	always @(posedge MCLK)
	begin
		if (w55)
			w78_i <= 0;
		else if (clk)
			w78_i <= w78_i;
		else if (w79)
			w78_i <= w147[3];
	end
	
	assign w78 = ~w78_i;
	
	z80_dlatch dl28
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~(pla[2] & w131 & w110)),
		.outp(l28)
		);
	
	
	assign w79 = ~clk & ~l28;
	
	always @(posedge MCLK)
	begin
		if (w55)
			w80 <= 0;
		else if (clk)
			w80 <= w80;
		else if (w79)
			w80 <= w147[4];
	end
	
	assign w81 = w80 & (w89 & w78 & w18);
	
	assign w82 = ~(pla[33] | pla[34]);
	
	assign w83 = ~(w77 | ~w86);
	
	assign w84 = ~(~w80 | w85);
	
	assign w85 = ~(w78 & w18);
	
	assign w86 = (w89 & (w84 | w19)) | (~w89 & pla[42]);
	
	assign w87 = ~(w78 | ~w80);
	
	assign w88 = ~(w87 & w89 & w18);
	
	assign w89 = ~(w103 | ~w30);
	
	assign w90 = ~(~w91 | w30);
	
	assign w91 = ~(w92 | ~w95);
	
	z80_dlatch dl43
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~pla[47]),
		.outp(l43)
		);
	
	always @(posedge MCLK)
	begin
		if (w55)
			w92 <= 0;
		else if (clk)
			w92 <= w92;
		else if (w103)
			w92 <= ~l43;
	end
	
	assign w93 = ~(w131 | w106);
	
	assign w94 = (w41 & ~w131) | w55 | w109;
	
	always @(posedge MCLK)
	begin
		if (w55)
			w95_i <= 0;
		else if (clk)
			w95_i <= w95_i;
		else if (w103)
			w95_i <= w98;
	end
	
	assign w95 = ~w95_i;
	
	assign w96 = w95 | w103;
	
	assign w97 = ~(pla[47] | pla[54] | pla[57]);
	
	z80_dlatch dw98
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(pla[54]),
		.outp(w98)
		);
	
	z80_dlatch dw99
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~pla[57]),
		.outp(w99)
		);
		
	always @(posedge MCLK)
	begin
		if (w55)
			w100 <= 0;
		else if (clk)
			w100 <= w100;
		else if (!w98 & w103)
			w100 <= w99;
	end
	
	assign w101 = ~(w202 | w201 | (w131 & (w41 | w18)));
	
	assign w102 = ~((w131 & w114) | (w110 & w127 & w107));
	
	z80_dlatch dl29
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w102),
		.outp(l29)
		);
	
	assign w103 = ~l29 & ~clk;
	
	z80_dlatch dw104
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w97),
		.outp(w104)
		);
	
	assign w105 = pla[61] | pla[71];
	
	assign w106 = (pla[77] & w120) | (w127 & pla[78]) | (w105 & w123);
	
	z80_dlatch dw107
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(pla[76]),
		.outp(w107)
		);
	
	assign w109 = ~w109_i;
	
	z80_dlatch dl30
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w41),
		.outp(l30)
		);
	
	assign w530 = ~(w112 & l30);
	
	z80_rs_trig_nand rs109
		(
		.MCLK(MCLK),
		.nset(clk | w530),
		.nrst(clk | ~w530),
		.q(),
		.nq(w109_i);
		);
	
	assign w110 = ~(w113 | w111);
	
	z80_rs_trig_nand rs111
		(
		.MCLK(MCLK),
		.nset(clk | ~w112),
		.nrst(clk | w112),
		.q(w111),
		.nq();
		);
	
	z80_dlatch dw112
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~w113 & w133),
		.outp(w112)
		);
	
	assign w113 = w66 | w63 | w65;
	
	z80_dlatch dl31
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w110),
		.outp(l31)
		);
	
	assign w532 = ~(w112 & l31);
	
	z80_rs_trig_nand rs114
		(
		.MCLK(MCLK),
		.nset(clk | w532),
		.nrst(clk | ~w532),
		.q(),
		.nq(w114_i);
		);
	
	assign w114 = ~w114_i;
	
	z80_rs_trig_nor rs115
		(
		.MCLK(MCLK),
		.rst(clk & (w131 | w123)),
		.set(clk & w116),
		.q(),
		.nq(w115_i);
		);
	
	assign w115 = ~w115_i;
	
	assign w116 = w114 & w120 & w126;
	
	assign w117 = w55 | w121 | (w123 & ~w164) | (w120 & w138 & ~w159)
		| (w127 & (pla[98] | (w155 & (~(~w164 | ~w151) | ~w151))));
	
	assign w118 = w117 | w299 | (w131 & w139);
	
	z80_dlatch dl32
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w131),
		.outp(l32)
		);
	
	assign w119 = l32 & ~w134 & ~w130;
	
	z80_rs_trig_nor rs120
		(
		.MCLK(MCLK),
		.rst(w132 & ~w119),
		.set(w132 & w119),
		.q(),
		.nq(w120_i);
		);
	
	assign w120 = ~w120_i;
	
	z80_rs_trig_nor rs121
		(
		.MCLK(MCLK),
		.rst(w132 & ~w122),
		.set(w132 & w122),
		.q(),
		.nq(w121_i);
		);
	
	assign w121 = ~w121_i;
	
	z80_dlatch dl33
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w123),
		.outp(l33)
		);
	
	assign w122 = l33 & ~w130;
	
	z80_rs_trig_nor rs123
		(
		.MCLK(MCLK),
		.rst(w132 & ~w124),
		.set(w132 & w124),
		.q(),
		.nq(w123_i);
		);
	
	assign w123 = ~w123_i;
	
	z80_dlatch dl34
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w127),
		.outp(l34)
		);
	
	assign w124 = ~w130 & (l34 | w134);
	
	assign w125 = ~((~w169 & ~w100) | (w169 & w161));
	
	assign w126 = (~w169 & ~w100) | w255;
	
	z80_rs_trig_nor rs127
		(
		.MCLK(MCLK),
		.rst(w132 & ~w128),
		.set(w132 & w128),
		.q(),
		.nq(w127_i);
		);
	
	assign w127 = ~w127_i;
	
	z80_dlatch dl35
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w120),
		.outp(l35)
		);
	
	assign w128 = ~(w134 | w130 | ~l35);
	
	assign w129 = ~(w131 & (w109 | w41));
	
	z80_rs_trig_nor rsrfsh
		(
		.MCLK(MCLK),
		.rst(clk & ~w129),
		.set(clk & w129),
		.q(rfsh_rs),
		.nq();
		);
	
	assign rfsh = ~rfsh_rs;
	
	assign RFSH = ~rfsh;
	
	z80_dlatch dw130
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w118),
		.outp(w130)
		);
	
	z80_rs_trig_nor rs131
		(
		.MCLK(MCLK),
		.rst(w132 & ~w130),
		.set(w132 & w130),
		.q(),
		.nq(w131_i);
		);
	
	assign w131 = ~w131_i;
	
	z80_dlatch dl36
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~w133),
		.outp(l36)
		);
	
	assign w132 = ~clk & l36;
	
	assign w133 = ~w137 & ~w55;
	
	z80_dlatch dw134
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w125 & ((w159 & w131) | w120)),
		.outp(w134)
		);
	
	assign w135 = ~((w190 & w68) | (w131 & w109 & w149));
	
	assign w136 = ~(w61 | (w41 & w143) | (w109 & w141));
	
	assign w137 = ~w135 | ~w136;
	
	assign w138 = w161 & ~w126;
	
	assign w139 = w159 & w161 & w169 & w157;
	
	assign w140 = ~w155 & w151 & ~w255;
	
	assign w141 = w186 & ((w140 & w127) | w123);
	
	assign w142 = w186 & ~w255 & ~w234;
	
	assign w143 = w120 | (w142 & w123) | (w121 & ~pla[88]);
	
	z80_dlatch dl37
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w133),
		.outp(l37)
		);
	
	z80_dlatch dl38
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~w110 & ~w55),
		.outp(l38)
		);
	
	z80_rs_trig_nand rs144
		(
		.MCLK(MCLK),
		.nset(clk | l37),
		.nrst(clk | l38),
		.q(w144),
		.nq();
		);
	
	always @(posedge MCLK)
	begin
		if (w2)
			w145 <= ~DATA;
		else if (w42)
			w145 <= w146;
		else
			w145 <= w145;
	end
	
	assign bu1 = w1 | w483;
	
	always @(posedge MCLK)
	begin
		if (w1)
			w146 <= w145;
		else if (w483)
			w146 <= 8'hff;
	end
	
	always @(posedge MCLK)
	begin
		if (w49)
			w147 <= w147;
		else
			w147 <= ~w146;
	end
	
	// pla
	assign pla[0] = (w147 & 8'hf7) == 8'hd3 & w90; // out(n), a; in(n), a
	assign pla[1] = (w147 & 8'hf7) == 8'hf3 & w90; // di; ei
	assign pla[2] = (w147 & 8'hc7) == 8'h46 & w92; // im 0; im 1; im 2
	assign pla[3] = w147 == 8'h76 & w90; // halt
	assign pla[4] = (w147 & 8'he7) == 8'ha0 & w92; // ldi; ldd; ldir; lddr
	assign pla[5] = (w147 & 8'he7) == 8'ha1 & w92; // cpi; cpd; cpir; cpdr
	assign pla[6] = w147 == 8'h37 & w90; // scf
	assign pla[7] = (w147 & 8'he6) == 8'ha2 & w92; // ini; outi; ind; outd; inir; otir; indr; otdr
	assign pla[8] = w147 == 8'h10 & w90; // djnz d
	assign pla[9] = w147 == 8'h3f & w90; // ccf
	assign pla[10] = (w147 & 8'h38) == 8'h28 & ~w82; // xor
	assign pla[11] = (w147 & 8'hf7) == 8'h57 & w92; // ld a,i; ld a,r
	assign pla[12] = (w147 & 8'h38) == 8'h30 & ~w82; // or
	assign pla[13] = (w147 & 8'h38) == 8'h20 & ~w82; // and
	assign pla[14] = (w147 & 8'h38) == 8'h00 & ~w82; // add
	assign pla[15] = (w147 & 8'hf7) == 8'h57 & w92 & ~w74; // ???
	assign pla[16] = (w147 & 8'hc7) == 8'h44 & w92; // neg
	assign pla[17] = w147 == 8'h2f & w90; // cpl
	assign pla[18] = (w147 & 8'h38) == 8'h08 & ~w82; // adc
	assign pla[19] = (w147 & 8'h38) == 8'h18 & ~w82; // sbc
	assign pla[20] = (w147 & 8'h38) == 8'h10 & ~w82; // sub
	assign pla[21] = w147 == 8'h27 & w90; // daa
	assign pla[22] = (w147 & 8'h38) == 8'h38 & ~w82; // cp
	assign pla[23] = (w147 & 8'hc7) == 8'h05 & w90; // dec byte
	assign pla[24] = (w147 & 8'hc0) == 8'hc0 & ~w96; // set
	assign pla[25] = (w147 & 8'hc0) == 8'h80 & ~w96; // res
	assign pla[26] = (w147 & 8'hc0) == 8'h40 & ~w96; // bit
	assign pla[27] = (w147 & 8'he7) == 8'h07 & w90; // rlca; rrca; rla; rra
	assign pla[28] = (w147 & 8'hc0) == 8'h00 & ~w96; // rlc; rrc; rl; rr; sla; sra; sll; srl
	assign pla[29] = (w147 & 8'hcf) == 8'h09 & w90; // add hl, bc; de ; hl ;sp
	assign pla[30] = (w147 & 8'hc7) == 8'h42 & w92; // sbc hl, adc hl
	assign pla[31] = (w147 & 8'hc7) == 8'h40 & w92; // in (c)
	assign pla[32] = (w147 & 8'hc6) == 8'h04 & w90; // inc dec byte
	assign pla[33] = (w147 & 8'hc0) == 8'h80 & w90; // 8'h80-8'hbf alu opcode
	assign pla[34] = (w147 & 8'hc7) == 8'hc6 & w90; // n alu opcodes
	assign pla[35] = (w147 & 8'hc7) == 8'h06 & w90; // ld n opcodes
	assign pla[36] = ~w96;
	assign pla[37] = (w147 & 8'hc0) == 8'h40 & w90; // ld reg opcodes
	assign pla[38] = (w147 & 8'hf7) == 8'h67 & w92; // rrd, rld
	assign pla[39] = (w147 & 8'hf8) == 8'h70 & w90 & ~pla[3]; // ld to (hl) opcodes
	assign pla[40] = (w147 & 8'hc7) == 8'h46 & w90 & ~pla[3]; // ld from (hl) opcodes
	assign pla[41] = (w147 & 8'hf7) == 8'h47 & w92; // ld i,a ; ld r,a
	assign pla[42] = (w147 & 8'hc7) == 8'hc7 & w90; // rst n
	assign pla[43] = (w147 & 8'h07) == 8'h06 & ~w96; // bit opcode (hl)
	assign pla[44] = ~w96 & ~w100; // 
	assign pla[45] = (w147 & 8'hfe) == 8'h34 & w90; // inc dec (hl)
	assign pla[46] = (w147 & 8'hc7) == 8'h86 & w90; // alu (hl)
	assign pla[47] = w147 == 8'hed & w90; // misc opcode prefix
	assign pla[48] = w147 == 8'h36 & w90; // ld (hl), n
	assign pla[49] = w147 == 8'hcb & ~w100; // ix, iy bit instutruction ?
	assign pla[50] = (w147 & 8'he7) == 8'h20 & w90; // jr nz, z, nc, c
	assign pla[51] = w147 == 8'h18 & w90; // jr d
	assign pla[52] = (w147 & 8'hc7) == 8'h45 & w92; // retn, reti
	assign pla[53] = (w147 & 8'hc7) == 8'hc0 & w90; // ret condition
	assign pla[54] = w147 == 8'hcb & w90; // bit opcode prefix
	assign pla[55] = (w147 & 8'hc7) == 8'hc2 & w90; // jp n condition
	assign pla[56] = (w147 & 8'hc7) == 8'hc4 & w90; // call n condition
	assign pla[57] = (w147 & 8'hdf) == 8'hdd & w90; // ix, iy
	assign pla[58] = w147 == 8'h36 & w90 & ~w100; // ld (ix/y), n
	assign pla[59] = w147 == 8'h08 & w90; // ex af, af'
	assign pla[60] = (w147 & 8'hf7) == 8'h32 & w90; // ld (nn), a; ld a, (nn)
	assign pla[61] = (w147 & 8'hf7) == 8'hd3 & w90; // out (n), a; in a, (n)
	assign pla[62] = (w147 & 8'he7) == 8'h02 & w90; // ld (bc), a; ld (de), a; ld a, (bc); ld a(de)
	assign pla[63] = w147 == 8'hc9 & w90; // ret
	assign pla[64] = (w147 & 8'hc7) == 8'h41 & w92; // out (c), reg
	assign pla[65] = (w147 & 8'hcf) == 8'h43 & w92; // ld (nn), word reg
	assign pla[66] = (w147 & 8'he7) == 8'h47 & w92; // ld i, a; ld r, a; ld a, i; ld a, r
	assign pla[67] = (w147 & 8'hc7) == 8'h43 & w92; // ld (nn), word reg, ld word reg, (nn)
	assign pla[68] = (w147 & 8'hf7) == 8'h22 & w90; // ld (nn), hl; ld hl, (nn)
	assign pla[69] = w147 == 8'hc3 & w90; // jp nn
	assign pla[70] = w147 == 8'hd3 & w90; // out (n), a
	assign pla[71] = (w147 & 8'hc6) == 8'h40 & w92; // in/ out (c), byte
	assign pla[72] = w147 == 8'h10 & w90; // djnz d
	assign pla[73] = (w147 & 8'he7) == 8'h07 & w90; // rlca; rrca; rla; rra
	assign pla[74] = w147 == 8'hcd & w90; // call nn
	assign pla[75] = (w147 & 8'hcb) == 8'hc1 & w90; // pop, push
	assign pla[76] = w147 == 8'hcb & ~w100; // ix, iy bit instutruction ?
	assign pla[77] = (w147 & 8'he7) == 8'ha2 & w92; // ini; ind; inir; indr
	assign pla[78] = (w147 & 8'he7) == 8'ha3 & w92; // outi; outd; otir; otdr
	assign pla[79] = (w147 & 8'he7) == 8'ha1 & w92; // cpi; cpd; cpir; cpdr
	assign pla[80] = (w147 & 8'he7) == 8'ha0 & w92; // ldi; ldd; ldir; lddr
	assign pla[81] = (w147 & 8'hc7) == 8'h06 & w90; // ld byte n
	assign pla[82] = (w147 & 8'hcf) == 8'hc5 & w90; // push
	assign pla[83] = (w147 & 8'hf7) == 8'h67 & w92; // rrd, rld
	assign pla[84] = (w147 & 8'hcf) == 8'h0b & w90; // dec word
	assign pla[85] = (w147 & 8'hcf) == 8'h02 & w90; // load from address
	assign pla[86] = (w147 & 8'he7) == 8'ha0 & w92; // ldi; ldd; ldir; lddr
	assign pla[87] = (w147 & 8'he7) == 8'ha1 & w92; // cpi; cpd; cpir; cpdr
	assign pla[88] = w147 == 8'he3 & w90; // ex (sp), hl
	assign pla[89] = (w147 & 8'hc7) == 8'h03 & w90; // inc, dec word
	assign pla[90] = (w147 & 8'he7) == 8'h02 & w90; // ld address from register
	assign pla[91] = (w147 & 8'hcf) == 8'h01 & w90; // ld nn word
	assign pla[92] = w147 == 8'he9 & w90; // jp (hl)
	assign pla[93] = w147 == 8'hf9 & w90; // ld sp, hl
	assign pla[94] = (w147 & 8'he7) == 8'h47 & w92; // ld i,a; ld r,a; ld a,i; ld a,r
	assign pla[95] = (w147 & 8'hdf) == 8'hdd & w90; // ix, iy
	assign pla[96] = w147 == 8'heb & w90; // ex de, hl
	assign pla[97] = w147 == 8'hd9 & w90; // exx
	assign pla[98] = (w147 & 8'hf4) == 8'ha0 & w92; // 
	
	assign w148 = ~(pla[11] | pla[16] | pla[17] |
		pla[21] | pla[27] | pla[33] | pla[34]
		| pla[38]);
	assign w149 = ~(w86 | ~w88 | pla[53] | pla[72]
		| pla[77] | pla[78] | pla[82] | pla[89]
		| pla[93] | pla[94]);
	assign w150 = ~(pla[11] | pla[21] | pla[27]
		| pla[28] | pla[31] | pla[33] | pla[34]
		| pla[35] | pla[37]);
	assign w151 = ~(~w88 | pla[55] | pla[60]
		| pla[67] | pla[68] | pla[69] | pla[77]
		| pla[78] | pla[91]);
	assign w152 = ~(pla[4] | pla[5] | pla[6] | pla[7]
		| pla[9] | pla[26] | pla[28] | pla[29]
		| pla[30] | pla[31] | pla[32] | pla[33]
		| pla[34]);
	assign w153 = ~(w86 | ~w88 | pla[50] | pla[51]
		| pla[52] | pla[53] | pla[55] | pla[56]
		| pla[63] | pla[69] | pla[72] | pla[74]
		| pla[92]);
	assign w154 = ~(pla[11] | pla[16] | pla[17]
		| pla[27] | pla[28] | pla[31] | pla[35]
		| pla[37] | w86);
	assign w155 = ~(~w88 | pla[44] | pla[45]
		| pla[49] | pla[56] | pla[60] | pla[67]
		| pla[68] | pla[74] | pla[77] | pla[78]
		| pla[83] | pla[88]);
	assign w156 = ~(pla[10] | pla[12] | pla[14]
		| pla[16] | pla[18] | pla[19] | pla[20]
		| pla[22] | pla[29] | pla[30]);
	assign w157 = ~(~w88 | pla[50] | pla[51]
		| pla[55] | pla[56] | pla[60] | pla[67]
		| pla[68] | pla[69] | pla[72] | pla[74]
		| pla[77] | pla[78] | pla[79] | pla[80]
		| pla[83] | pla[88] | pla[91]);
	assign w158 = ~(pla[11] | pla[14] | pla[16]
		| pla[18] | pla[19] | pla[20] | pla[22]
		| pla[30] | pla[32]);
	assign w159 = ~(pla[34] | pla[35] | pla[50]
		| pla[51] | pla[61] | pla[72]);
	assign w160 = ~(pla[5] | pla[7] | pla[8]
		| pla[16] | pla[17] | pla[19] | pla[20]
		| pla[22] | pla[23] | pla[25]);
	assign w161 = ~(pla[29] | pla[30] | w86
		| pla[48] | pla[52] | pla[53] | pla[61]
		| pla[62] | pla[63] | pla[71] | pla[75]);
	assign w162 = ~(pla[5] | pla[7] | pla[8]
		| pla[11] | pla[16] | pla[21] | pla[26]
		| pla[28] | pla[30] | pla[31] | pla[32]
		| pla[33] | pla[34] | pla[38]);
	assign w163 = ~(pla[32] | pla[33] | pla[34]
		| pla[36] | pla[37]);
	assign w164 = ~(pla[26] | pla[39] | pla[40]
		| pla[46] | pla[48] | pla[60] | pla[61]
		| pla[62] | pla[71] | pla[77] | pla[78]
		| pla[79] | pla[80] | pla[83]);
	assign w165 = ~(pla[7] | pla[8] | pla[13]
		| pla[17] | pla[26] | pla[32]);
	assign w166 = ~(pla[9] | pla[18] | pla[19]
		| pla[30]);
	assign w167 = ~(w86 | pla[39] | pla[48]
		| pla[56] | pla[64] | pla[65] | pla[70]
		| pla[74] | pla[82] | pla[83] | pla[85]
		| pla[88] | pla[89] | pla[93]);
	assign w168 = ~(pla[10] | pla[12] | pla[24]);
	assign w169 = ~(pla[39] | pla[40] | pla[43]
		| pla[44] | pla[45] | pla[46] | pla[48]
		| pla[49]);
	assign w170 = ~(pla[49] | pla[55] | pla[56] | pla[44]
		| pla[58] | pla[60] | pla[67] | pla[68]
		| pla[69] | pla[74] | pla[91]);
	assign w171 = ~(pla[6] | pla[9] | pla[13]);
	assign w172 = ~(pla[24] | pla[25] | pla[28]
		| pla[31] | pla[32] | pla[35] | pla[37]);
	assign w173 = ~(w86 | pla[52] |  pla[53] | pla[56]
		| pla[63] | pla[74] | pla[75] | pla[88]);
	assign w174 = ~(pla[7] | pla[8] | pla[32]
		| pla[36] | pla[50] | pla[51]);
	assign w175 = ~(pla[50] | pla[51] | pla[72]);
	assign w176 = ~(pla[82] | pla[84]);
	assign w177 = ~(pla[4] | pla[5] | pla[6]
		| pla[7] | pla[9]);
	assign w178 = ~(pla[7] | pla[8]);
	assign w179 = ~(pla[5] | pla[7] | pla[8]);
	assign w180 = ~(pla[12] | pla[24]);
	assign w181 = ~(pla[13] | pla[25] | pla[26]);
	assign w182 = ~(pla[33] | pla[36]);
	assign w183 = ~(w182 & (w114 | ~pla[37]));
	assign w184 = ~(pla[55] | pla[56]);
	assign w185 = ~(pla[56] | pla[74]);
	assign w186 = ~(pla[77] | pla[78] | pla[79]
		| pla[80]);
	assign w187 = ~(pla[60] | pla[61] | pla[62]);
	assign w188 = ~(pla[71] | pla[72] | pla[77]
		| pla[78]);
	assign w189 = ~(pla[72] | pla[73] | pla[77]
		| pla[78]);
	assign w190 = ~(pla[89] | pla[93]);
	assign w191 = ~(pla[79] | pla[80] | pla[81]
		| ~w169 | pla[83] | pla[92] | pla[93]);
	
	assign w192 = (w201 & w110) | (w41 & w3 & w46);
	
	assign w193 = (w144 & w14) | w205;
	
	assign w194 = ~w202 & ~w203;
	
	assign w195 = ~(pla[88] | ~(w196 | (~w299 & ~w173)));
	
	assign w196 = pla[86] | pla[87];
	
	assign w197 = ~w234 & w186;
	
	assign w198 = ~w199 & w170;
	
	assign w199 = ~(pla[83] | pla[87] | w254);
	
	assign w200 = ~((w127 & (~w186 | ~w88))
		| (w120 & ~w88)
		| (w123 & ~w167)
		| (w121 & (~w167 | w255)));
	
	assign w201 = ~w200 & ~w202;
	
	assign w202 = ((w121 | w123) & ~w197)
		| (w127 & w198);
	
	assign w203 = ~(w110 & (w41 & w131));
	
	assign w204 = ~((w109 & pla[93])
		| (pla[88] & w121 & w41));
	
	z80_dlatch dl39
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w204),
		.outp(l39)
		);
	
	z80_rs_trig_nand rs205
		(
		.MCLK(MCLK),
		.nset(clk | l39),
		.nrst(clk | ~l39),
		.q(w205),
		.nq();
		);
	
	assign w206 = ~((w131 & w109 & w207)
		| (~w186 & w123 & (w41 | w110))
		| (w195 & w127 & w41));
	
	assign w207 = ~(w176 & ~(w86 | ~w88));
	
	assign w208 = ~(w110 &
		((w120 & (w209 | ~w88))
			| (w123 & ~w173 & ~w167)
			| (w127 & w209)));
	
	assign w209 = ~w186 & w147[3];
	
	z80_dlatch dl40
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(~w206 | ~w208),
		.outp(l40)
		);
	
	z80_rs_trig_nand rs210
		(
		.MCLK(MCLK),
		.nset(clk | ~l40),
		.nrst(clk | l40),
		.q(),
		.nq(w210_i);
		);
	
	assign w210 = ~w210_i;
	
	assign w211 = ~((w114 & ((w123 & w212)
		| (w120 & w213)))
		| (w109 & (w121 | ((w123 | w127)
			& (~w186 | ~w173)))));
	
	assign w212 = ~(w186 & (~w169 | w255));
	
	assign w213 = ~(w186 & w218);
	
	assign w214 = ~((w41 & w131)
		| (w68 & w131 & (~w88 | ~w167))
		| (w114 & ((w127 & ~w186)
			| (w121 & w167 & ~w173))));
	
	z80_dlatch dl41
		(
		.MCLK(MCLK),
		.en(clk),
		.inp(w55 | (~w57 & w110 & w131)),
		.outp(l41)
		);
	
	assign w215 = l41;
	
	assign w216 = ~w214 | ~w211;
	
	assign w217 = ~((w120 & w218) | w131 | w127);
	
	assign w218 = ~pla[88] & w88;
	
	assign w219 = ~((w41 & (w121 | (w127 & ~w186)))
		| (w109 & w131)
		| (w114 & (w131 | (w127 & ~w173))));
	
	assign w220 = ~(w127 & w196);
	
	assign w221 = ~((w110 & (w123 | w121)
		& (~w185 | w86))
		| (w109 & w123 & ~w186));
	
	assign w222 = ~((~w175 & ((w114 & w120)
		| (w41 & w127)))
		| (w110 & (w127 | w120) & ~w88));
	
	assign w223 = ~((w127 & ~w186)
		| (w120 & ~w170)
		| (w131 & w224));
	
	assign w224 = ~w170 | w225 | ~w159;
	
	assign w225 = ~w100 & ~w169;
	
	assign w226 = ~((w110 & (
		w131
		| (w120 & w224)
		| (w127 & ~w170)))
		| w55);
	
	assign w227 = ~(w131 & w114);
	
	assign w228 = ~(w131 & w41);
	
	assign w229 = ~((w41 & w120 & ~w88)
		| (w109 & w131 & pla[94]));
	
	assign w230 = ~((w68 & w131 & (pla[93] | ~w173))
		| (w114 & (((w127 | w123) & ~w173)
			| (w121 & ~w173 & w167))));
	
	assign w231 = ~(((w68 | w109) & (w131 | w127)
		& (~w173 | ~w88))
		| (w114 & w120 & ~w88));

	assign w232 = ~((w41 & (w120 | w127) & pla[91])
		| ((w109 | w68)
			& (w121 | (w131
				& (pla[89] | pla[90]))))
		);
	
	assign w233 = ~(
		(w110 & (w123 | w121)
			& (pla[88] | w234 | w235))
		| (w41 & (w123 | w121)
			& w237)
		);
	
	assign w234 = pla[29] | pla[30];
	
	assign w235 = ~(w236 | w147[3]);
	
	assign w236 = ~(pla[67] | pla[68]);
	
	assign w237 = ~(w236 | ~w167);
	
	assign w238 = ~(
		((w41 & w127) | (w114 & w120))
		& w225);
	
	assign w239 = ~((w114 & w120 & w240)
		| (w109 & ((w127 & pla[83]) | (w123 & w234)))
		| (w41 & (w123 | w121) & w234)
		);
	
	assign w240 = ~(pla[77] | w186);
	
	assign w241 = ~(
		(w131 & w68 & pla[78])
		| (w131 & w109 & (w234 | ~w191))
		| (w114 & w127 & pla[77])
		| (w41 & w120 & (pla[77] | pla[81]))
		);
	
	assign w242 = ~(
		((w41 & w120)
		| (w114 & w127)) & pla[80]
		);
	
	assign w243 = ~(
		(w109 & ((w127 & ~w186) | (w131 & ~w188)))
		| (w68 & w131 & pla[77])
		| (w110 & w120 & ~w188)
		| (w41 & ((w127 & ~w186) | (w120 & pla[78])))
		);
	
	assign w244 = ~(
		(w110 | w41) & (w123 | w121) & pla[75]
		);
	
	assign w245 = ~(~w187 | (~w236 & w147[3])
		| (~w153 & w175) | pla[75] | ~w173
		| pla[91]);
	
	assign w246 = ~((w110 & w123 & ~w187)
		| (w41 & w123 & w167 & ~w187)
		| (w109 & w131 & pla[73])
		| (w114 & w131 & w247)
		);
	
	assign w247 = ~(pla[22] | w148);
	
	assign w248 = ~(
		(w110 & w123 & (pla[71] | ~w163))
		| (w109 & w131 & (~w163 & w169))
		);
	
	assign w249 = ~(w109 & w131 & pla[66]);
	
	assign w250 = ~(w114 & w131 & ~w172);

	assign w251 = ~(
		(w41 & ((w123 & w252)
			| (w120 & w88 & w253)))
		| (w114 & w127 & (~w88 | w254))
		);
	
	assign w252 = w187 & (w86 | w234 | (w167 & ~w245));
	
	assign w253 = ~w245 | w235;
	
	assign w254 = ~(~w255 | ~w186);
	
	assign w255 = ~w174 | (w115 & w256);
	
	assign w256 = ~w169 & ~w100;
	
	assign w257 = ~(
		(w110 & w120 & (~w189 | ~w187))
		| (w41 & ((w127 & w253) | (w121 & w252)))
		);
	
	assign w258 = ~(
		(w41 & w123 & ~w187)
		| (w68 & w127 & w255)
		| (w114 & w131 & w247)
		);
	
	assign w259 = ~(w110 & w131 & pla[59]);
	
	assign w260 = ~(
		(w110 & w121 & ~w245)
		| (w109 & w131 & w261)
		);
	
	assign w261 = w235 | w234;
	
	assign w262 = ~(
		(
		(w110 & ((w120 & ~w88) | (w123 & w261)))
		| (w114 & w120)
		);
	
	assign w263 = ~(
		(w109 & ((w131 & ~w189) | w123))
		| ((w110 | w41) & w120 & ~w88)
		);
	
	assign w264 = ~(
		(w110 & ((w123 & (~w245 | ~w187))
			| (w121 & w261)))
		| (w41 & w127 & w255)
		);
	
	assign w265 = ~(
		(w127 & ~w184)
		| (w131 & pla[53])
		| (w120 & pla[50])
		);
	
	assign w266 = ~(
		(w109 & w131 & pla[41])
		| (w110 & w127 & w88)
		);
	
	assign w267 = ~(
		(w110 & w123 & pla[38])
		| (w41 & ((w123 & w86)
			| (w127 & pla[38])))
		);
	
endmodule


module z80_dlatch
	(
	input MCLK,
	input en,
	input inp,
	output reg outp = 1'h0
	);

	
	always @(posedge MCLK)
	begin
		if (en)
			outp <= inp;
	end
endmodule

module z80_rs_trig_nor
	(
	input MCLK,
	input rst,
	input set,
	output reg q = 1'h0,
	output reg nq = 1'h1
	);
	
	always @(posedge MCLK)
	begin
//		if (rst)
//			q <= 1'h0;
//		else if (set)
//			q <= 1'h1;
//		if (set)
//			nq <= 1'h0;
//		else if (rst)
//			nq <= 1'h1;
		q <= ~(rst | nq);
		nq <= ~(set | q);
	end
endmodule

module z80_rs_trig_nand
	(
	input MCLK,
	input nset,
	input nrst,
	output reg q = 1'h0,
	output reg nq = 1'h1
	);
	
	always @(posedge MCLK)
	begin
//		if (~nset)
//			q <= 1'h1;
//		else if (~nrst)
//			q <= 1'h0;
//		if (~nrst)
//			nq <= 1'h0;
//		else if (~nset)
//			nq <= 1'h1;
		q <= ~(nq & nset);
		nq <= ~(q & nrst);
	end
endmodule
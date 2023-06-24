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
	wire w114;
	wire w131;
	wire [7:0] w147;
	wire w201;
	
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
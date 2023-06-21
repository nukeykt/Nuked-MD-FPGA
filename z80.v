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
	wire w41;
	wire w55
	wire w114;
	wire w131;
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
		.nset(clk & ~INT),
		.nrst(clk & INT),
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
		.nset(clk & w6),
		.nrst(clk & w6_i),
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
		if (rst)
			q <= 1'h0;
		else if (set)
			q <= 1'h1;
		if (set)
			nq <= 1'h0;
		else if (rst)
			nq <= 1'h1;
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
		if (~nset)
			q <= 1'h1;
		else if (~nrst)
			q <= 1'h0;
		if (~nrst)
			nq <= 1'h0;
		else if (~nset)
			nq <= 1'h1;
	end
endmodule
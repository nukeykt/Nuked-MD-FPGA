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
	
	reg [67:0] w529;
	
	reg [15:0] b1[0:3];
	reg [15:0] b2[0:3];
	reg [15:0] b3[0:3];
	
	wire c1;
	wire c2;
	wire c3;
	wire c4;
	wire c5;
	wire c6;
	
	
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

endmodule

module YM7101
	(
	input [7:0] SD,
	output SE1,
	output SE0,
	output SC,
	output RAS1,
	output CAS1,
	output WE1,
	output WE0,
	output OE1,
	inout [7:0] RD,
	output [7:0] DAC_R,
	output [7:0] DAC_G,
	output [7:0] DAC_B,
	inout [7:0] AD,
	output YS,
	inout SPA_B,
	output VSYNC,
	inout CSYNC,
	inout HSYNC,
	input HL,
	input SEL0,
	input PAL,
	input RESET,
	input SEL1,
	inout CLK1,
	output SBCR,
	output CLK0,
	input MCLK,
	inout EDCLK,
	inout [15:0] CD,
	inout [22:0] CA,
	output [15:0] SOUND,
	output INT,
	output BR,
	inout BGACK,
	input BG,
	input MREQ,
	input INTAK,
	output IPL1,
	output IPL2,
	input IORQ,
	input RD,
	input WR,
	input M1,
	input AS,
	input UDS,
	input LDS,
	input RW,
	inout DTACK,
	output UWR,
	output LWR,
	output OE0,
	output CAS0,
	output RAS0,
	output [7:0] RA
	);
	
	wire reset_comb;
	wire mclk_and1;
	reg dff1;
	reg dff2;
	reg dff3;
	reg dff4;
	reg dff5;
	reg dff6;
	reg dff7;
	reg dff8;
	reg dff9;
	reg dff10;
	reg dff11;
	wire dff12_l2;
	wire dff13_l2;
	wire dff14_l2;
	ym7101_dff dff12(.MCLK(MCLK), .clk(mclk_clk1), .inp(~(dff12_l2 | dff13_l2)), .rst(mclk_and1), outp(dff12_l2));
	ym7101_dff dff13(.MCLK(MCLK), .clk(mclk_clk1), .inp(dff12_l2), .rst(mclk_and1), outp(dff13_l2));
	ym7101_dff dff14(.MCLK(MCLK), .clk(~mclk_clk1), .inp(dff13_l3), .rst(mclk_and1), outp(dff14_l2));
	wire dff15_l2;
	wire dff16_l2;
	wire dff17_l2;
	ym7101_dff dff15(.MCLK(MCLK), .clk(mclk_clk2), .inp(~(dff15_l2 | dff16_l2)), .rst(mclk_and1), outp(dff15_l2));
	ym7101_dff dff16(.MCLK(MCLK), .clk(mclk_clk2), .inp(dff15_l2), .rst(mclk_and1), outp(dff16_l2));
	ym7101_dff dff17(.MCLK(MCLK), .clk(~mclk_clk2), .inp(dff16_l3), .rst(mclk_and1), outp(dff17_l2));
	wire mclk_clk1;
	wire mclk_clk2;
	wire mclk_clk3;
	wire mclk_sbcr;
	wire mclk_cpu_clk0;
	wire mclk_cpu_clk1;
	wire mclk_dclk;
	
	wire reg_test1_0;
	
	wire reg_rs0;
	
	wire reg_rs1;
	
	assign reset_comb = ~(RESET & w100);
	
	// prescaler
	
	assign mclk_and1 = dff2 & ~dff1;
	
	assign mclk_clk1 = dff4;
	
	assign mclk_clk2 = dff7;
	
	assign mclk_clk3 = ~dff11;
	
	assign mclk_clk4 = dff13_l2 | dff14_l2;
	
	assign mclk_clk5 = dff16_l2 | dff17_l2;
	
	assign mclk_sbcr = PAL ? mclk_clk4 ? mclk_clk5;
	
	assign mclk_cpu_clk0 = reg_test1_0 ? CLK1 ? mclk_clk5;
	
	assign mclk_cpu_clk1 = ~mclk_clk3;
	
	assign mclk_dclk = (reg_rs0 | reg_test1_0) ? EDCLK : (reg_rs1 ? mclk_clk1 : mclk_clk2);
	
	always @(posedge MCLK)
	begin
		dff1 <= reset_comb;
		dff2 <= dff1;
		
		if (mclk_and1)
		begin
			dff3 <= 1'h0;
			dff4 <= 1'h0;
			dff5 <= 1'h0;
			dff6 <= 1'h0;
			dff7 <= 1'h0;
			dff8 <= 1'h0;
			dff9 <= 1'h0;
			dff10 <= 1'h0;
			dff11 <= 1'h0;
		end
		else
			dff3 <= dff4;
			dff4 <= ~dff3;
			
			dff5 <= dff7;
			dff6 <= dff5;
			dff7 <= ~(dff5 & dff6);
			
			dff8 <= dff11;
			dff9 <= dff8;
			dff10 <= ~(dff8 & dff9);
			dff11 <= dff10;
		end
	end
	


endmodule


module ym7101_dff
	(
	input MCLK,
	input clk,
	input inp,
	input rst
	output outp
	);
	
	reg l1, l2;
	
	assign outp = l2;
	
	always @(posedge MCLK)
	begin
		if (rst)
		begin
			l1 <= 1'h0;
			l2 <= 1'h0;
		end
		else
		begin
			if (~clk)
				l1 <= inp;
			else
				l2 <= l1;
		end
	end
	
endmodule
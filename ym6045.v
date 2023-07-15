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
	input WAIT_in,
	input ZBAK,
	input MREQ_in,
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
	
	reg dff1;
	reg dff2;
	reg dff3;
	wire dff4_l2, dff4_cout;
	wire dff5_l2, dff5_cout;
	wire dff6_l2, dff6_cout;
	wire dff7_l2;
	wire dff8_nq;
	wire dff9_q;
	wire w1;
	wire w2;
	wire w3;
	wire w4;
	wire w5;
	wire w7;
	wire w10;
	wire w11;
	
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
	assign w5 = ~(~dff4_l2 | ~dff5_l2 | ~dff6_l2 | ~dff7_l2);

	ym_scnt_bit dff4(.MCLK(MCLK), .clk(w4), .load(dff9_q), .val(1'h1), .cin(dff9_q), .rst(sres), .outp(dff4_l2), .cout(dff4_cout));
	ym_scnt_bit dff5(.MCLK(MCLK), .clk(w4), .load(dff9_q), .val(1'h0), .cin(dff4_cout), .rst(sres), .outp(dff5_l2), .cout(dff5_cout));
	ym_scnt_bit dff6(.MCLK(MCLK), .clk(w4), .load(dff9_q), .val(1'h0), .cin(dff5_cout), .rst(sres), .outp(dff6_l2), .cout(dff6_cout));
	ym_scnt_bit dff7(.MCLK(MCLK), .clk(w4), .load(dff9_q), .val(1'h0), .cin(dff6_cout), .rst(sres), .outp(dff7_l2));
	
	assign EDCLK = w2;
	
	assign w7 = dff8_nq;
	assign w11 = ~(~HSYNC | dff9_q);
	assign w10 = ~(w11 | (1'h0 & dff9_q));
	
	ym_sdffr dff9(.MCLK(MCLK), .clk(w2), .val(w10), .reset(w7), .q(dff9_q));
	ym_sdffs dff8(.MCLK(MCLK), .clk(w2), .val(w5), .set(sres), .nq(dff8_nq));
	
endmodule

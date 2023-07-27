module ym3438_prescaler(
	input MCLK,
	input PHI,
	input IC,
	output c1, c2,
	output reset_fsm
	);
	
	
	wire nIC = ~IC;
	
	wire pc1 = ~PHI;
	wire pc2 = PHI;
	
	wire ic_latch_out;
	
	ym_sr_bit2 #(.SR_LENGTH(12)) ic_latch(
		.MCLK(MCLK),
		.bit_in(nIC),
		.sr_out(ic_latch_out),
		.c1(pc1),
		.c2(pc2)
		);
	
	wire fsm_reset_and = nIC & ~ic_latch_out;
	
	wire fsm_res_latch_out;
	
	ym_sr_bit2 #(.SR_LENGTH(4)) fsm_res_latch(
		.MCLK(MCLK),
		.bit_in(fsm_reset_and),
		.sr_out(fsm_res_latch_out),
		.c1(pc1),
		.c2(pc2)
		);
	
	assign reset_fsm = fsm_res_latch_out;
	
	wire [5:0] clkgen_sr_in;
	wire [5:0] clkgen_sr_out;

	genvar i;
	
	generate
		for (i = 0; i < 6; i=i+1)
		begin : l1
	
			ym_sr_bit2 clkgen_sr(
				.MCLK(MCLK),
				.bit_in(clkgen_sr_in[i]),
				.sr_out(clkgen_sr_out[i]),
				.c1(pc1),
				.c2(pc2)
				);
			if (i != 0)
				assign clkgen_sr_in[i] = clkgen_sr_out[i-1];
		end
	endgenerate
	
	wire clkgen_bit = ~(fsm_reset_and | (clkgen_sr_out[4:0] != 4'b0));
	
	assign clkgen_sr_in[0] = clkgen_bit;
	
	wire c1_in = clkgen_sr_out[0] | clkgen_sr_out[5];
	wire c2_in = clkgen_sr_out[2] | clkgen_sr_out[3];
	
	ym_sr_bit2 c1_sr(
		.MCLK(MCLK),
		.bit_in(c1_in),
		.sr_out(c1),
		.c1(pc1),
		.c2(pc2)
		);
	
	ym_sr_bit2 c2_sr(
		.MCLK(MCLK),
		.bit_in(c2_in),
		.sr_out(c2),
		.c1(pc1),
		.c2(pc2)
		);

endmodule

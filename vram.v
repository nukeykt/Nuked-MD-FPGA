module vram
	(
	input MCLK,
	input RAS,
	input CAS,
	input WE,
	input OE,
	input SC,
	input SE,
	input [7:0] AD,
	input [7:0] RD_i,
	output reg [7:0] RD_o,
	output RD_d,
	output [7:0] SD_o,
	output SD_d
	);
	
	reg [15:0] addr;
	reg dt;
	reg [1:0] addr_ser;
	reg [31:0] ser;
	
	reg o_OE;
	reg o_RAS;
	reg o_cas;
	reg o_SC;
	reg o_valid;
	
	wire cas = ~RAS & ~CAS;
	wire wr = ~RAS & ~CAS & ~WE;
	wire rd = ~RAS & ~CAS & ~OE & ~dt;
	
	wire [13:0] mem_addr = addr[15:2];
	wire [3:0] mem_be;
	wire [31:0] mem_o;
	
	assign mem_be[0] = addr[1:0] == 2'h0;
	assign mem_be[1] = addr[1:0] == 2'h1;
	assign mem_be[2] = addr[1:0] == 2'h2;
	assign mem_be[3] = addr[1:0] == 2'h3;
	
	assign RD_d = ~o_valid;
	assign SD_d = SE;

	vram_ip mem
		(
		.clock(MCLK),
		.address(mem_addr),
		.byteena(mem_be),
		.data({RD_i, RD_i, RD_i, RD_i}),
		.wren(wr),
		.q(mem_o)
		);
	
	reg [7:0] vram_ser;
	
	assign SD_o = vram_ser;
	
	always @(posedge MCLK)
	begin
		if (dt & !o_OE & OE)
		begin
			addr_ser <= addr[1:0];
			ser <= mem_o;
		end
		else if (~o_SC & SC)
		begin
			addr_ser <= addr_ser + 2'h1;
			vram_ser <=
				(addr_ser == 2'h0 ? ser[7:0] : 8'h0) |
				(addr_ser == 2'h1 ? ser[15:8] : 8'h0) |
				(addr_ser == 2'h2 ? ser[23:16] : 8'h0) |
				(addr_ser == 2'h3 ? ser[31:24] : 8'h0);
		end
		if (o_RAS & ~RAS)
		begin
			dt <= ~OE;
			addr[15:8] <= AD;
		end
		if (~o_cas & cas)
		begin
			addr[7:0] <= AD;
		end
		if (dt & !o_OE & OE)
		begin
			addr_ser <= addr[1:0];
			ser <= mem_o;
		end
		
		if (rd)
		begin
			RD_o <=
				(addr[1:0] == 2'h0 ? mem_o[7:0] : 8'h0) |
				(addr[1:0] == 2'h1 ? mem_o[15:8] : 8'h0) |
				(addr[1:0] == 2'h2 ? mem_o[23:16] : 8'h0) |
				(addr[1:0] == 2'h3 ? mem_o[31:24] : 8'h0);
			o_valid <= 1'h1;
		end
		else if (CAS | OE)
		begin
			o_valid <= 1'h0;
		end
		
		o_OE <= OE;
		o_RAS <= RAS;
		o_cas <= cas;
		o_SC <= SC;
	end

endmodule

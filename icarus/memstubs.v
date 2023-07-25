module ram_68k (
	address,
	byteena,
	clock,
	data,
	wren,
	q);

	input	[14:0]  address;
	input	[1:0]  byteena;
	input	  clock;
	input	[15:0]  data;
	input	  wren;
	output	[15:0]  q;

	assign q = 0;

endmodule // ram_68k

module ram_z80 (
	address,
	clock,
	data,
	wren,
	q);

	input	[12:0]  address;
	input	  clock;
	input	[7:0]  data;
	input	  wren;
	output	[7:0]  q;

	assign q = 0;

endmodule // ram_z80

module vram_ip (
	address,
	byteena,
	clock,
	data,
	wren,
	q);

	input	[13:0]  address;
	input	[3:0]  byteena;
	input	  clock;
	input	[31:0]  data;
	input	  wren;
	output	[31:0]  q;

	assign q = 0;

endmodule // vram_ip

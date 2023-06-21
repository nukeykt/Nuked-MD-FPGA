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
	
	
	
	

endmodule


module z80_dlatch
	(
	input MCLK,
	input en,
	input inp,
	output reg outp
	);

	
	always @(posedge MCLK)
	begin
		if (en)
			outp <= inp;
	end
endmodule

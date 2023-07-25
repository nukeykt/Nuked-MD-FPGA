`timescale 1ns/1ns

module MD_Run();

    reg CLK;
    reg extreset;

    always #8 CLK = ~CLK;

    md_board md
        (
            .MCLK(CLK),
            .ext_reset(extreset),
        
            // cart
            .M3(0),
            .cart_data(0)        
        );

    initial begin

        $display("Check that the NukedMD Core is moving.");
        $dumpfile("md.vcd");
        $dumpvars(0, MD_Run);

        CLK <= 1'b0;
        
        extreset <= 1'b1; 
        repeat (256) @ (posedge CLK);
        extreset <= 1'b0;

        repeat (256) @ (posedge CLK);
        $finish;
    end 

endmodule // MD_Run

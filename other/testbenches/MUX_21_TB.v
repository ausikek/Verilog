//MUX2_1 TESTBENCH

`timescale 1ns/1ps
`include "components.v"

module MUX2_1_TB();

    reg A_TB;
    reg [7:0] B_TB;
    reg [7:0] C_TB;
    wire [7:0] F_TB;

    integer i, j;

    MUX2_1 DUT(F_TB, A_TB, B_TB, C_TB);

    initial 
    
        begin
        
            $dumpfile("MUX2_1_TB.vcd");
            $dumpvars(0, MUX2_1_TB);
            
            A_TB = 0;
            B_TB = 64;

            for (i = 0; i < 32; i = i + 1) begin

                C_TB = i;

                #10;

            end

            A_TB = 1;
            C_TB = 64;

            for (j = 0; j < 32; j = j + 1) begin

                B_TB = j;

                #10;

            end
            
        end

endmodule
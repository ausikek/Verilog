//INVERT 16-BIT TESTBENCH

`timescale 1ns/1ps
`include "INVERT.v"

module INVERT_TB();

    reg [7:0] A_TB;
    wire [7:0] F_TB;

    integer i;

    INVERT DUT(F_TB, A_TB);

    initial

        begin

            $dumpfile("INVERT_TB.vcd");
            $dumpvars(0, INVERT_TB);

            for (i = 0; i < 32; i = i + 1) begin
                
                A_TB = i;

                #10;

            end
        
        end

endmodule
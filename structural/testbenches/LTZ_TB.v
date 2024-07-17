//LESS THAN ZERO TESTBENCH

`timescale 1ns/1ps
`include "components.v"

module LESS_ZERO_TB();

    reg [7:0] A_TB;
    wire F_TB;

    integer i;

    LESS_ZERO DUT(F_TB, A_TB);

    initial 
    
        begin
        
            $dumpfile("LESS_ZERO_TB.vcd");
            $dumpvars(0, LESS_ZERO_TB);

            for (i = -5; i < 100; i = i + 1) begin

                A_TB = i;

                #10;

            end

        end

endmodule

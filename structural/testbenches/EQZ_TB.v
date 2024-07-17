//EQUAL TO ZERO TESTBENCH

`timescale 1ns/1ps
`include "components.v"

module EQUAL_ZERO_TB();

    reg [7:0] A_TB;
    wire F_TB;

    integer i;

    EQUAL_ZERO DUT(F_TB, A_TB);

    initial

        begin

            $dumpfile("EQUAL_ZERO_TB.vcd");
            $dumpvars(0, EQUAL_ZERO_TB);

            for (i = 0; i < 64; i = i + 1) begin
                
                A_TB = i;

                #10;

            end

        end

endmodule
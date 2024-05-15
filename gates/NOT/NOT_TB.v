//NOT TESTBENCH

`timescale 1ns/1ps
`include "NOT.v"

module NOT_TB();

    reg A_TB;
    wire F_TB;

    NOT DUT(F_TB, A_TB);

    initial
        
        begin

            $dumpfile("NOT_TB.vcd");
            $dumpvars(0, NOT_TB);

            A_TB = 0;
        #10 A_TB = 1;
        #10 A_TB = 0;

        end

endmodule
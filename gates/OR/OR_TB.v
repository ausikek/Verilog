//OR TESTBENCH

`timescale 1ns/1ps
`include "OR.v"

module OR_TB();

    reg A_TB;
    reg B_TB;
    wire F_TB;

    OR DUT(F_TB, A_TB, B_TB);

    initial

        begin

            $dumpfile("OR_TB.vcd");
            $dumpvars(0, OR_TB);

            A_TB = 0; B_TB = 0;
        #10 A_TB = 0; B_TB = 1;
        #10 A_TB = 1; B_TB = 0;
        #10 A_TB = 1; B_TB = 1;
        #10 A_TB = 0; B_TB = 0;

        end

endmodule
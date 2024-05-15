//XOR TESTBENCH

`timescale 1ns/1ps
`include "XOR.v"

module XOR_TB();

    reg A_TB;
    reg B_TB;
    wire F_TB;

    XOR DUT(F_TB, A_TB, B_TB);

    initial
        
        begin

            $dumpfile("XOR_TB.vcd");
            $dumpvars(0, XOR_TB);

            A_TB = 0; B_TB = 0;
        #10 A_TB = 0; B_TB = 1;
        #10 A_TB = 1; B_TB = 0;
        #10 A_TB = 1; B_TB = 1;
        #10 A_TB = 0; B_TB = 0;

        end

endmodule
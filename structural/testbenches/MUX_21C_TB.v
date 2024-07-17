//MUX 2 TO 1 WITH 1 BIT INPUTS TESTBENCH

`timescale 1ns/1ps
`include "components.v"

module MUX_21C_TB();

    wire F_TB;
    reg S_TB;
    reg A_TB, B_TB;

    MUX2_1_classic DUT (F_TB, S_TB, A_TB, B_TB);

    initial

        begin

        $dumpfile("MUX_21C_TB.vcd");
        $dumpvars(0, MUX_21C_TB);

            S_TB = 0; A_TB = 0; B_TB = 0;
        #10 S_TB = 0; A_TB = 1; B_TB = 0;
        #10 S_TB = 1; A_TB = 1; B_TB = 0;
        #10 S_TB = 1; A_TB = 1; B_TB = 1;
        #10 S_TB = 0; A_TB = 0; B_TB = 0;

        end

endmodule
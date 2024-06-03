//HALF-ADDER TESTBENCH

`timescale 1ns/1ps
`include "components.v"

module HALF_ADDER_TB();

    reg A_TB;
    reg B_TB;
    wire H_TB;
    wire L_TB;

    HALFADDER DUT(H_TB, L_TB, A_TB, B_TB);

    initial 
        
        begin

            $dumpfile("HALF_ADDER_TB.vcd");
            $dumpvars(0, HALF_ADDER_TB);

            A_TB = 0; B_TB = 0;
        #10 A_TB = 0; B_TB = 1;
        #10 A_TB = 1; B_TB = 0;
        #10 A_TB = 1; B_TB = 1;
        #10 A_TB = 0; B_TB = 0;

        end

endmodule
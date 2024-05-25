//FULL-ADDER TESTBENCH

`timescale 1ns/1ps
`include "FULL_ADDER.v"

module FULL_ADDER_TB();

    reg A_TB;
    reg B_TB;
    reg C_TB;
    wire H_TB;
    wire L_TB;

    FULL_ADDER DUT(H_TB, L_TB, A_TB, B_TB, C_TB);

    initial
        
        begin
            
            $dumpfile("FULL_ADDER_TB.vcd");
            $dumpvars(0, FULL_ADDER_TB);

            A_TB = 0; B_TB = 0; C_TB = 0;
        #10 A_TB = 0; B_TB = 0; C_TB = 1;
        #10 A_TB = 0; B_TB = 1; C_TB = 0;
        #10 A_TB = 0; B_TB = 1; C_TB = 1;
        #10 A_TB = 1; B_TB = 0; C_TB = 0;
        #10 A_TB = 1; B_TB = 0; C_TB = 1;
        #10 A_TB = 1; B_TB = 1; C_TB = 0;
        #10 A_TB = 1; B_TB = 1; C_TB = 1;
        #10 A_TB = 0; B_TB = 0; C_TB = 0;

        end

endmodule
//OVERFLOW IN ADDER TESTBENCH

`timescale 1ns/1ps
`include "components.v"

module OVA_TB();

    reg A_TB, B_TB, R_TB;
    wire F_TB;

    OVERFLOW_ADD DUT(F_TB, A_TB, B_TB, R_TB);

    initial 

        begin
            
        $dumpfile("OVA_TB.vcd");
        $dumpvars(0, OVA_TB);
    
            A_TB = 0; B_TB = 0; R_TB = 0;
        #10 A_TB = 0; B_TB = 0; R_TB = 1;
        #10 A_TB = 0; B_TB = 1; R_TB = 0;
        #10 A_TB = 0; B_TB = 1; R_TB = 1;
        #10 A_TB = 1; B_TB = 0; R_TB = 0;
        #10 A_TB = 1; B_TB = 0; R_TB = 1;
        #10 A_TB = 1; B_TB = 1; R_TB = 0;
        #10 A_TB = 1; B_TB = 1; R_TB = 1;
        #10 A_TB = 0; B_TB = 0; R_TB = 0;

        end

endmodule
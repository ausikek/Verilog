//AND TESTBENCH

`timescale 1ns/1ps
`include "AND.v"

module AND_TB();

    reg A_TB;
    reg B_TB;
    wire F_TB;

    AND DUT(F_TB, A_TB, B_TB);

    initial 
        
        begin

            $dumpfile("AND_TB.vcd");
            $dumpvars(0, AND_TB);

            A_TB = 0; B_TB = 0;
        #10 A_TB = 0; B_TB = 1;
        #10 A_TB = 1; B_TB = 0;
        #10 A_TB = 1; B_TB = 1;
        #10 A_TB = 0; B_TB = 0;

        end

endmodule
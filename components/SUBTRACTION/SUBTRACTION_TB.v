//SUBTRACTION TESTBENCH

`timescale 1ns/1ps
`include "SUBTRACTION.v"

module SUBTRACTION_TB();

    reg [7:0] A_TB;
    reg [7:0] B_TB;
    output wire [7:0] F_TB;

    integer i, j;

    SUBTRACTION DUT(F_TB, A_TB, B_TB);

    initial

        begin

            $dumpfile("SUBTRACTION_TB.vcd");
            $dumpvars(0, SUBTRACTION_TB);

            for (i = 64; i > 0; i = i - 1) begin

                for (j = 0; j < 64; j = j + 1) begin 

                    A_TB = i;
                    B_TB = j;

                    #10;

                end

            end
        
        end

endmodule
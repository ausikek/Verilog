//MULTI-BIT ADDER TESTBENCH

`timescale 1ns/1ps
`include "MULTI_BIT_ADDER.v"

module MULTI_BIT_ADDER_TB();

    reg [15:0] A_TB;
    reg [15:0] B_TB;
    reg C_TB;
    wire [16:0] F_TB;

    integer i, j;

    MULTI_BIT_ADDER DUT(F_TB, A_TB, B_TB, C_TB);

    initial

        begin
            
            $dumpfile("MULTI_BIT_ADDER_TB.vcd");
            $dumpvars(0, MULTI_BIT_ADDER_TB);

            for (i = 0; i < 65; i = i + 1) begin

                for (j = 0; j < 65; j = j + 1) begin

                        A_TB = i;
                        B_TB = j;

                        C_TB = 0;

                        #10;

                        C_TB = 1;

                        #10;

                    
                end
                
            end
        
        end

endmodule
//RIPPLECARRY ADDER TESTBENCH

`timescale 1ns/1ps
`include "components.v"

module RIPPLECARRY_TB();

    reg [7:0] A_TB;
    reg [7:0] B_TB;
    reg C_TB;
    wire [7:0] F_TB;
    wire E_TB;

    integer i, j;

    RIPPLECARRY DUT(E_TB, F_TB, A_TB, B_TB, C_TB);

    initial

        begin
            
            $dumpfile("RIPPLECARRY_TB.vcd");
            $dumpvars(0, RIPPLECARRY_TB);

            for (i = 0; i < 32; i = i + 1) begin

                for (j = 0; j < 32; j = j + 1) begin

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
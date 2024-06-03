//LOGIC UNIT TESTBENCH

`timescale 1ns/1ps
`include "components.v"

module LU_TB();

    wire [7:0] F_TB;
    reg [7:0] A_TB, B_TB;
    reg [1:0] S_TB;

    LU DUT(F_TB, A_TB, B_TB, S_TB);

    initial

    begin

        $dumpfile("LU_TB.vcd");
        $dumpvars(0, LU_TB);
            
            S_TB = 2'b00; A_TB = 8'b11100001; B_TB = 8'b10101010;
        #10 S_TB = 2'b01;
        #10 S_TB = 2'b10;
        #10 S_TB = 2'b11;

        end

endmodule
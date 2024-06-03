//MUX 4 TO 1 WITH 1 BIT INPUTS TESTBENCH

`timescale 1ns/1ps
`include "components.v"

module MUX_41C_TB();

    wire F_TB;
    reg [1:0] S_TB;
    reg A_TB, B_TB, C_TB, D_TB;

    MUX4_1_classic DUT (F_TB, S_TB, A_TB, B_TB, C_TB, D_TB);

    initial
    
        begin

        $dumpfile("MUX_41C_TB.vcd");
        $dumpvars(0, MUX_41C_TB);
            
            S_TB = 2'b00; A_TB = 0; B_TB = 0; C_TB = 0; D_TB = 0;
        #10 S_TB = 2'b00; A_TB = 1; B_TB = 0; C_TB = 0; D_TB = 0;
        #10 S_TB = 2'b01; A_TB = 1; B_TB = 1; C_TB = 0; D_TB = 0;
        #10 S_TB = 2'b10; A_TB = 1; B_TB = 1; C_TB = 0; D_TB = 0;
        #10 S_TB = 2'b10; A_TB = 1; B_TB = 1; C_TB = 1; D_TB = 0;
        #10 S_TB = 2'b11; A_TB = 1; B_TB = 1; C_TB = 1; D_TB = 1;
        #10 S_TB = 2'b00; A_TB = 0; B_TB = 0; C_TB = 0; D_TB = 0; 

        end

endmodule
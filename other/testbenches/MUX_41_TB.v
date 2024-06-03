//MUX 4-1 8 BITS TEST BENCH

`timescale 1ns/1ps
`include "components.v"

module MUX4_1_TB();

    reg [7:0] A_TB, B_TB, C_TB, D_TB;
    reg [1:0] S_TB;
    wire [7:0] F_TB;

    MUX4_1 DUT(F_TB, S_TB, A_TB, B_TB, C_TB, D_TB);
    
    initial

        begin
            $dumpfile("MUX4_1_TB.vcd");
            $dumpvars(0, MUX4_1_TB);
            
                A_TB = 8'b00000000; B_TB = 8'b01000000; C_TB = 8'b00000000; D_TB = 8'b00000000; S_TB = 2'b00;
            #10 A_TB = 8'b00000000; B_TB = 8'b00000001; C_TB = 8'b00000010; D_TB = 8'b00000011; S_TB = 2'b01;
            #10 A_TB = 8'b00000000; B_TB = 8'b00000001; C_TB = 8'b00000010; D_TB = 8'b00000011; S_TB = 2'b10;
            #10 A_TB = 8'b00000000; B_TB = 8'b00000001; C_TB = 8'b00000010; D_TB = 8'b00000011; S_TB = 2'b11;
            #10 A_TB = 8'b00000000; B_TB = 8'b00000001; C_TB = 8'b00000010; D_TB = 8'b00000011; S_TB = 2'b00;
        end

endmodule
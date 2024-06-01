//MUX 4-1 8 BITS TEST BENCH

`timescale 1ns/1ps
`include "mux_4_1.v"

module mux4_1_tb();

    reg [7:0] A_TB, B_TB, C_TB, D_TB;
    reg [1:0] S_TB;
    wire [7:0] F_TB;

    MUX4_1 DUT(F_TB, S_TB, A_TB, B_TB, C_TB, D_TB);
    
    initial

        begin
            $dumpfile("mux4-1_tb.vcd");
            $dumpvars(0, mux4_1_tb);
            
                    A_TB = 8'b00001000; B_TB = 8'b01000001; C_TB = 8'b00000011; D_TB = 8'b01001011; S_TB = 2'b00;
            #10 A_TB = 8'b00000000; B_TB = 8'b00000001; C_TB = 8'b00000010; D_TB = 8'b00000011; S_TB = 2'b01;
            #10 A_TB = 8'b00000000; B_TB = 8'b00000001; C_TB = 8'b00000010; D_TB = 8'b00000011; S_TB = 2'b10;
            #10 A_TB = 8'b00000000; B_TB = 8'b00000001; C_TB = 8'b00000010; D_TB = 8'b00000011; S_TB = 2'b11;
            #10 A_TB = 8'b00000000; B_TB = 8'b00000001; C_TB = 8'b00000010; D_TB = 8'b00000011; S_TB = 2'b00;
        end

endmodule
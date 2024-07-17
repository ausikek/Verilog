//ALU TESTBENCH

`timescale 1ns/1ps
`include "alu.v"

module ALU_TB();

    wire [7:0] Result_TB;
    wire [3:0] NZVC_TB;
    reg [7:0] A_TB, B_TB;
    reg [2:0] C_TB;

    ALU DUT(Result_TB, NZVC_TB, A_TB, B_TB, C_TB);

    initial

    begin

        $dumpfile("ALU_TB.vcd");
        $dumpvars(0, ALU_TB);

            C_TB = 3'b000; A_TB = 8'b00000000; B_TB = 8'b00000000;
        #10 C_TB = 3'b000; A_TB = 8'b00000001; B_TB = 8'b00000001;
        #10 C_TB = 3'b001; A_TB = 8'b00000010; B_TB = 8'b00000001;
        #10 C_TB = 3'b010; A_TB = 8'b00000010; B_TB = 8'b00000001;
        #10 C_TB = 3'b011; A_TB = 8'b00000100; B_TB = 8'b00000001;
        #10 C_TB = 3'b100; A_TB = 8'b11111111; B_TB = 8'b10101010;
        #10 C_TB = 3'b101; A_TB = 8'b11000101; B_TB = 8'b10101010;
        #10 C_TB = 3'b110; A_TB = 8'b11001001; B_TB = 8'b10101010;
        #10 C_TB = 3'b111; A_TB = 8'b10101010; B_TB = 8'b00000000;
        #10 C_TB = 3'b000; A_TB = 8'b00000000; B_TB = 8'b00000000;

        end

endmodule
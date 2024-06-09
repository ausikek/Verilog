//XOR 8-bit TESTBENCH

`timescale 1ns/1ps
`include "gates.v"

module XOR8_TB();

    reg [7:0] A_TB, B_TB;
    wire [7:0] F_TB;

    XOR8 DUT (F_TB, A_TB, B_TB);

    initial 
    
        begin
            
            $dumpfile("XOR8_TB.vcd");
            $dumpvars(0, XOR8_TB);
            
            A_TB = 8'b00000000; B_TB = 8'b00000000;
        #10 A_TB = 8'b11111111; B_TB = 8'b00000001;
        #10 A_TB = 8'b00000000; B_TB = 8'b11111111;
        #10 A_TB = 8'b11111111; B_TB = 8'b11111111;
        #10 A_TB = 8'b01011001; B_TB = 8'b10111110;
        #10 A_TB = 8'b10101010; B_TB = 8'b01110010;
        #10 A_TB = 8'b00000000; B_TB = 8'b00000000;

        end

endmodule
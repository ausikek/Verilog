//NOT 8-bit TESTBENCH

`timescale 1ns/1ps
`include "gates.v"

module NOT8_TB();

    reg [7:0] A_TB;
    wire [7:0] F_TB;

    NOT8 DUT (F_TB, A_TB);

    initial 
    
        begin
            
            $dumpfile("NOT8_TB.vcd");
            $dumpvars(0, NOT8_TB);
            
            A_TB = 8'b00000000;
        #10 A_TB = 8'b11111111;
        #10 A_TB = 8'b00000000;
        #10 A_TB = 8'b10111111;
        #10 A_TB = 8'b01011001;
        #10 A_TB = 8'b10101010;
        #10 A_TB = 8'b00000000;

        end

endmodule
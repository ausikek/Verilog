//ARITHMETIC UNIT TESTBENCH

`timescale 1ns/1ps
`include "components.v"

module AU_TB();

    wire C_TB;
    wire [7:0] R_TB;
    reg [7:0] A_TB, B_TB;
    reg [1:0] CONTROL_TB;

    AU DUT(C_TB, R_TB, A_TB, B_TB, CONTROL_TB);

    initial

        begin

        $dumpfile("AU_TB.vcd");
        $dumpvars(0, AU_TB);
            
            CONTROL_TB = 2'b00; A_TB = 8'b00000010; B_TB = 8'b00000001;
        #10 CONTROL_TB = 2'b01; A_TB = 8'b00001000; B_TB = 8'b00000001;
        #10 CONTROL_TB = 2'b10; A_TB = 8'b00000100; B_TB = 8'b00000000;
        #10 CONTROL_TB = 2'b11; A_TB = 8'b00000001; B_TB = 8'b00000000;
        #10 CONTROL_TB = 2'b00; A_TB = 8'b00000000; B_TB = 8'b00000000;

        end

endmodule
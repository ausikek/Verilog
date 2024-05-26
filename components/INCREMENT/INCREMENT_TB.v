//INCREMENT TESTBENCH

`timescale 1ns/1ps
`include "INCREMENT.v"

module INCREMENT_TB();

    reg [7:0] A_TB;
    wire [7:0] F_TB;

    integer i;

    INCREMENT DUT(F_TB, A_TB);

    initial

        begin

            $dumpfile("INCREMENT_TB.vcd");
            $dumpvars(0, INCREMENT_TB);

            for (i = 0; i < 64; i = i + 1) begin

                A_TB = i;

                #10;

            end
        
        end

endmodule
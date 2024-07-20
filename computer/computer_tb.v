`include "computer.v"
`timescale 1ns/1ps

module computer_tb();

    reg [7:0] port_in_00, port_in_01, port_in_02, port_in_03, port_in_04, port_in_05, port_in_06, port_in_07, port_in_08, port_in_09, port_in_10, port_in_11, port_in_12, port_in_13, port_in_14, port_in_15;
    reg clk, reset;
    wire [7:0] port_out_00, port_out_01, port_out_02, port_out_03, port_out_04, port_out_05, port_out_06, port_out_07, port_out_08, port_out_09, port_out_10, port_out_11, port_out_12, port_out_13, port_out_14, port_out_15;
    integer i;

    computer DUT(
    
        .port_out_00(port_out_00),
        .port_out_01(port_out_01),
        .port_out_02(port_out_02),
        .port_out_03(port_out_03),
        .port_out_04(port_out_04),
        .port_out_05(port_out_05),
        .port_out_06(port_out_06),
        .port_out_07(port_out_07),
        .port_out_08(port_out_08),
        .port_out_09(port_out_09),
        .port_out_10(port_out_10),
        .port_out_11(port_out_11),
        .port_out_12(port_out_12),
        .port_out_13(port_out_13),
        .port_out_14(port_out_14),
        .port_out_15(port_out_15),
        .port_in_00(port_in_00),
        .port_in_01(port_in_01),
        .port_in_02(port_in_02),
        .port_in_03(port_in_03),
        .port_in_04(port_in_04),
        .port_in_05(port_in_05),
        .port_in_06(port_in_06),
        .port_in_07(port_in_07),
        .port_in_08(port_in_08),
        .port_in_09(port_in_09),
        .port_in_10(port_in_10),
        .port_in_11(port_in_11),
        .port_in_12(port_in_12),
        .port_in_13(port_in_13),
        .port_in_14(port_in_14),
        .port_in_15(port_in_15),
        .clk(clk),
        .reset(reset)
        
        );
        
        initial begin

            $dumpfile("computer_tb.vcd");
            $dumpvars(0, computer_tb);

            clk = 0;
            #40;

            for (i = 0; i < 1200; i = i + 1) begin

                clk = ~clk;
                #40;

            end
        
        end

        initial begin
            
                reset = 0;
        #100    reset = 1;

        end
        
    endmodule
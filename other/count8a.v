// 8-BIT COUNTER

`timescale 1ns/1ps
`include "reg8a.v"

module count8a (
    
    output wire [7:0] CNT, 
    input wire clk, res, EN, load,
    input wire [7:0] CNT_In
    
    );

    wire [7:0] Mux_Out ;
    wire [7:0] Inc_Out;
    wire Cout;
    
    RIPPLECARRY adder0 (Cout, Inc_Out, CNT, 8'b00000001, 1'b0);

    MUX2_1 mux0 (Mux_Out, load, Inc_Out, CNT_In);

    reg8a reg0 (CNT, clk, res, EN, Mux_Out);

endmodule
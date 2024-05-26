//SUBTRACTION

`timescale 1ns/1ps
`include "../INCREMENT/INCREMENT.v" 
`include "../INVERT/INVERT.v"

module SUBTRACTION(

    output wire [7:0] F,
    input wire [7:0] A,
    input wire [7:0] B

    );

    wire [7:0] X;
    wire [7:0] Y;

    wire E;
    wire C;

    assign C = 0;

    INVERT inverter1(X, B);

    INCREMENT incrementer1(Y, X);

    MULTI_BIT_ADDER adder1(E, F, A, Y, C);

endmodule
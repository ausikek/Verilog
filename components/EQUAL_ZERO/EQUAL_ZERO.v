//EQUAL TO ZERO

`timescale 1ns/1ps
`include "../../gates/OR/OR.v"
`include "../../gates/NOT/NOT.v"

module EQUAL_ZERO(

    output wire F,
    input wire [7:0] A

    );

    wire X1, X2, X3, X4;
    wire X5, X6;
    wire X7;

    OR or_gate01(X1, A[0],  A[1]);
    OR or_gate02(X2, A[2],  A[3]);
    OR or_gate03(X3, A[4],  A[5]);
    OR or_gate04(X4, A[6],  A[7]);

    OR or_gate09(X5,  X1, X2);
    OR or_gate10(X6, X3, X4);

    OR or_gate13(X7, X5, X6);

    NOT not_gate1(F, X7);

endmodule
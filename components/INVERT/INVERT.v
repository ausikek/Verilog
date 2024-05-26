//INVERT 16-BIT

`timescale 1ns/1ps
`include "../../gates/NOT/NOT.v"

module INVERT(

    output wire [7:0] F,
    input wire [7:0] A

    );

    NOT not_gate1(F[0], A[0]);
    NOT not_gate2(F[1], A[1]);
    NOT not_gate3(F[2], A[2]);
    NOT not_gate4(F[3], A[3]);
    NOT not_gate5(F[4], A[4]);
    NOT not_gate6(F[5], A[5]);
    NOT not_gate7(F[6], A[6]);
    NOT not_gate8(F[7], A[7]);

endmodule
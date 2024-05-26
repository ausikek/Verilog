//MULTI-BIT ADDER

`timescale 1ns/1ps
`include "../FULL_ADDER/FULL_ADDER.v"

module MULTI_BIT_ADDER(
    
    output wire E,
    output wire [7:0] F,
    input wire [7:0]  A, 
    input wire [7:0]  B, 
    input wire         C

    );

    wire [6:0] S;

    FULL_ADDER full_adder1   (S[0], F[0], A[0], B[0], C);
    FULL_ADDER full_adder2   (S[1], F[1], A[1], B[1], S[0]);
    FULL_ADDER full_adder3   (S[2], F[2], A[2], B[2], S[1]);
    FULL_ADDER full_adder4   (S[3], F[3], A[3], B[3], S[2]);
    FULL_ADDER full_adder5   (S[4], F[4], A[4], B[4], S[3]);
    FULL_ADDER full_adder6   (S[5], F[5], A[5], B[5], S[4]);
    FULL_ADDER full_adder7   (S[6], F[6], A[6], B[6], S[5]);
    FULL_ADDER full_adder8   (E,    F[7], A[7], B[7], S[6]);

endmodule
//MULTI-BIT ADDER

`timescale 1ns/1ps
`include "../FULL_ADDER/FULL_ADDER.v"

module MULTI_BIT_ADDER(
    
    output wire [16:0] F,
    input wire [15:0]  A, 
    input wire [15:0]  B, 
    input wire         C

    );

    wire [14:0] S;

    FULL_ADDER full_adder1   (S[0], F[0], A[0], B[0], C);
    FULL_ADDER full_adder2   (S[1], F[1], A[1], B[1], S[0]);
    FULL_ADDER full_adder3   (S[2], F[2], A[2], B[2], S[1]);
    FULL_ADDER full_adder4   (S[3], F[3], A[3], B[3], S[2]);
    FULL_ADDER full_adder5   (S[4], F[4], A[4], B[4], S[3]);
    FULL_ADDER full_adder6   (S[5], F[5], A[5], B[5], S[4]);
    FULL_ADDER full_adder7   (S[6], F[6], A[6], B[6], S[5]);
    FULL_ADDER full_adder8   (S[7], F[7], A[7], B[7], S[6]);
    FULL_ADDER full_adder9   (S[8], F[8], A[8], B[8], S[7]);
    FULL_ADDER full_adder10  (S[9], F[9], A[9], B[9], S[8]);
    FULL_ADDER full_adder11  (S[10], F[10], A[10], B[10], S[9]);
    FULL_ADDER full_adder12  (S[11], F[11], A[11], B[11], S[10]);
    FULL_ADDER full_adder13  (S[12], F[12], A[12], B[12], S[11]);
    FULL_ADDER full_adder14  (S[13], F[13], A[13], B[13], S[12]);
    FULL_ADDER full_adder15  (S[14], F[14], A[14], B[14], S[13]);
    FULL_ADDER full_adder16  (F[16], F[15], A[15], B[15], S[14]);


endmodule
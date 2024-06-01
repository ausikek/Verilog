//8 BIT OR

`timescale 1ns/1ps
`include "../gates/OR/OR.v"

module OR8 (
    
    output wire [7:0] F,
    input wire [7:0] A, B
    
    );

    OR OR0 (F[0], A[0], B[0]);
    OR OR1 (F[1], A[1], B[1]);
    OR OR2 (F[2], A[2], B[2]);
    OR OR3 (F[3], A[3], B[3]);
    OR OR4 (F[4], A[4], B[4]);
    OR OR5 (F[5], A[5], B[5]);
    OR OR6 (F[6], A[6], B[6]);
    OR OR7 (F[7], A[7], B[7]);
    
endmodule
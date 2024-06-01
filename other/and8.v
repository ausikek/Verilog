//AND 8 BIT

`timescale 1ns/1ps
`include "../gates/AND/AND.v"

module AND8 (
    
    output wire [7:0] F,
    input wire [7:0] A, B
    
    );

    AND AND0 (F[0], A[0], B[0]);
    AND AND1 (F[1], A[1], B[1]);
    AND AND2 (F[2], A[2], B[2]);
    AND AND3 (F[3], A[3], B[3]);
    AND AND4 (F[4], A[4], B[4]);
    AND AND5 (F[5], A[5], B[5]);
    AND AND6 (F[6], A[6], B[6]);
    AND AND7 (F[7], A[7], B[7]);

endmodule
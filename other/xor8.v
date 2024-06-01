//8 BIT XOR

`timescale 1ns/1ps
`include "../gates/XOR/XOR.v"

module XOR8 (
    
    output wire [7:0] F,
    input wire [7:0] A, B
    
    );

    XOR XOR0 (F[0], A[0], B[0]);
    XOR XOR1 (F[1], A[1], B[1]);
    XOR XOR2 (F[2], A[2], B[2]);
    XOR XOR3 (F[3], A[3], B[3]);
    XOR XOR4 (F[4], A[4], B[4]);
    XOR XOR5 (F[5], A[5], B[5]);
    XOR XOR6 (F[6], A[6], B[6]);
    XOR XOR7 (F[7], A[7], B[7]);

endmodule
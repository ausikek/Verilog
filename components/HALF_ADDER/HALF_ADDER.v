//HALF-ADDER

`timescale 1ns/1ps
`include "../../gates/AND/AND.v"
`include "../../gates/XOR/XOR.v"

module HALF_ADDER(

    output wire H, L,
    input wire A, B

    );

    XOR xor_gate(L, A, B);
    AND and_gate(H, A, B);

endmodule
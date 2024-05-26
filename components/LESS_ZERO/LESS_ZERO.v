//LESS THAN ZERO

`timescale 1ns/1ps
`include "../../gates/OR/OR.v"

module LESS_ZERO(

    output wire F,
    input wire [7:0] A

    );

    wire Z;

    assign Z = 0;

    OR or_gate1(F, A[7], Z);

endmodule
//FULL-ADDER

`timescale 1ns/1ps
`include "../HALF_ADDER/HALF_ADDER.v"

module FULL_ADDER(

    output wire H, L,
    input wire A, B, C

    );

    wire S0, C0;
    wire C1;
    wire Z; //Discard Carry Wire

    HALF_ADDER half_adder1(C0, S0, A, B);
    
    HALF_ADDER half_adder2(C1, L, S0, C);

    HALF_ADDER half_adder3(Z, H, C0, C1);

endmodule
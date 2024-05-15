//XOR GATE

`timescale 1ns/1ps

module XOR(

    output wire F,
    input wire A, B
    
    );

    wire X;
    wire Y;
    wire Z;

    nand nand_gate1(X, A, B);

    nand nand_gate2(Y, A, X);

    nand nand_gate3(Z, B, X);

    nand nand_gate4(F, Y, Z);

endmodule
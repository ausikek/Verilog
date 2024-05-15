//OR GATE

`timescale 1ns/1ps

module OR(
    
    output wire F,
    input wire A,B
    
    );

    wire X;
    wire Y;

    nand nand_gate1(X, A, A);

    nand nand_gate2(Y, B, B);

    nand nand_gate3(F, X, Y);

endmodule
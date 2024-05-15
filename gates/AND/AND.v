//AND GATE

`timescale 1ns/1ps

module AND(

    output wire F,
    input wire A, B

    );

    wire X;

    nand nand_gate1(X, A, B);

    nand nand_gate2(F, X, X);

endmodule
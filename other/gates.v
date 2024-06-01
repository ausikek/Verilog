//SIMPLE GATES

`timescale 1ns/1ps

//AND GATE

module AND(

    output wire F,
    input wire A, B

    );

    wire X;

    nand nand_gate1(X, A, B);

    nand nand_gate2(F, X, X);

endmodule


//OR GATE

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

//XOR GATE

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

//NOT GATE

module NOT(
    
    output wire F,
    input wire A

    );

    nand nand_gate1 (F, A, A);

endmodule
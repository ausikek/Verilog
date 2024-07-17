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

//8 BIT GATES

//AND GATE

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

//OR GATE

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

//XOR GATE

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

//NOT GATE

module NOT8 (
    
    output wire [7:0] F,
    input wire [7:0] A
    
    );

   NOT NOT0 (F[0], A[0]);
   NOT NOT1 (F[1], A[1]);
   NOT NOT2 (F[2], A[2]);
   NOT NOT3 (F[3], A[3]);
   NOT NOT4 (F[4], A[4]);
   NOT NOT5 (F[5], A[5]);
   NOT NOT6 (F[6], A[6]);
   NOT NOT7 (F[7], A[7]);

endmodule
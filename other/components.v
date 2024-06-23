/*
Components File:
Created because of the need to have a file that contains all the components used in the design.
Simultaneous imports of the base gates and components give include errors. This file is used to import all the components in one go.
*/

`timescale 1ns/1ps
`include "gates.v"

/*-----------------------------------------------ARITHMETIC COMPONENTS-----------------------------------------------*/

module HALFADDER(

    output wire Carry, Sum,
    input wire A, B

    );

    XOR XOR1 (Sum, A, B);
    AND AND1 (Carry, A, B);

endmodule


module FULLADDER(

    output wire Carry, Sum,
    input wire A, B, Cin

    );

    wire C1, S1, C2;

    HALFADDER HA1 (C1, S1, A, B);
    HALFADDER HA2 (C2, Sum, S1, Cin);
    
    OR OR1 (Carry, C1, C2);

endmodule


module RIPPLECARRY(
    
    output wire Carry,
    output wire [7:0] Sum,
    input wire [7:0] A, B, 
    input wire Cin
    
    );

    wire C0, C1, C2, C3, C4, C5, C6;

    FULLADDER FA0 (C0, Sum[0], A[0], B[0], Cin);
    FULLADDER FA1 (C1, Sum[1], A[1], B[1], C0);
    FULLADDER FA2 (C2, Sum[2], A[2], B[2], C1);
    FULLADDER FA3 (C3, Sum[3], A[3], B[3], C2);
    FULLADDER FA4 (C4, Sum[4], A[4], B[4], C3);
    FULLADDER FA5 (C5, Sum[5], A[5], B[5], C4);
    FULLADDER FA6 (C6, Sum[6], A[6], B[6], C5);
    FULLADDER FA7 (Carry, Sum[7], A[7], B[7], C6);

endmodule


module EQUAL_ZERO(

    output wire F,
    input wire [7:0] A

    );

    wire X1, X2, X3, X4;
    wire X5, X6;
    wire X7;

    OR or_gate01(X1, A[0],  A[1]);
    OR or_gate02(X2, A[2],  A[3]);
    OR or_gate03(X3, A[4],  A[5]);
    OR or_gate04(X4, A[6],  A[7]);

    OR or_gate09(X5,  X1, X2);
    OR or_gate10(X6, X3, X4);

    OR or_gate13(X7, X5, X6);

    NOT not_gate1(F, X7);

endmodule


module LESS_ZERO(

    output wire F,
    input wire [7:0] A

    );

    OR or_gate1(F, A[7], 1'b0);

endmodule


module OVERFLOW_ADD(

    output wire F,
    input wire A, B, R

    );

    wire nA, nB, nR;
    wire andAB, andnAB;
    wire aux1, aux2;

    NOT NOT0 (nA, A);
    NOT NOT1 (nB, B);
    NOT NOT2 (nR, R);

    AND AND0 (andAB, A, B);
    AND AND1 (andnAB, nA, nB);

    AND AND2 (aux1, andAB, nR);
    AND AND3 (aux2, andnAB, R);

    OR OR0 (F, aux1, aux2);

endmodule


module OVERFLOW_SUB(

    output wire F,
    input wire A, B, R

    );

    wire nA, nB, nR;
    wire andBR, andnBR;
    wire aux1, aux2;

    NOT NOT0 (nA, A);
    NOT NOT1 (nB, B);
    NOT NOT2 (nR, R);

    AND AND0 (andBR, B, R);
    AND AND1 (andnBR, nB, nR);

    AND AND2 (aux1, A, andnBR);
    AND AND3 (aux2, nA, andBR);

    OR OR0 (F, aux1, aux2);

endmodule

/*-----------------------------------------------MULTIPLEXERS-----------------------------------------------*/

module MUX2_1(
    
    output wire [7:0] F,
    input wire S,
    input wire [7:0] A, B
    
    );

    wire nS;
    wire [7:0] wA, wB;

    NOT NOT0 (nS, S);

    AND AND0 (wA[0], A[0], nS);
    AND AND1 (wA[1], A[1], nS);
    AND AND2 (wA[2], A[2], nS);
    AND AND3 (wA[3], A[3], nS);
    AND AND4 (wA[4], A[4], nS);
    AND AND5 (wA[5], A[5], nS);
    AND AND6 (wA[6], A[6], nS);
    AND AND7 (wA[7], A[7], nS);

    AND AND8 (wB[0], B[0], S);
    AND AND9 (wB[1], B[1], S);
    AND AND10 (wB[2], B[2], S);
    AND AND11 (wB[3], B[3], S);
    AND AND12 (wB[4], B[4], S);
    AND AND13 (wB[5], B[5], S);
    AND AND14 (wB[6], B[6], S);
    AND AND15 (wB[7], B[7], S);

    OR8 OR0 (F, wA, wB);

endmodule


module MUX2_1_classic (
    
    output wire F,
    input wire S,
    input wire A, B
    
    );

    wire nS;
    wire wA, wB;

    NOT NOT0 (nS, S);

    AND AND0 (wA, A, nS);
    AND AND1 (wB, B, S);

    OR OR0 (F, wA, wB);

endmodule


module MUX4_1 (
    
    output wire [7:0] F,
    input wire [1:0] S,
    input wire [7:0] A, B, C, D
    
    );

    wire nS0, nS1;
    wire N0, N1, N2, N3;
    wire [7:0] M0, M1, M2, M3;
    wire [7:0] L0, L1;

    NOT NOT0 (nS0, S[0]);
    NOT NOT1 (nS1, S[1]);

    AND AND0 (N0, nS0, nS1);
    AND AND1 (N1, S[0], nS1);
    AND AND2 (N2, nS0, S[1]);
    AND AND3 (N3, S[0], S[1]);

    AND AND4 (M0[0], A[0], N0);
    AND AND5 (M0[1], A[1], N0);
    AND AND6 (M0[2], A[2], N0);
    AND AND7 (M0[3], A[3], N0);
    AND AND8 (M0[4], A[4], N0);
    AND AND9 (M0[5], A[5], N0);
    AND AND10 (M0[6], A[6], N0);
    AND AND11 (M0[7], A[7], N0);

    AND AND12 (M1[0], B[0], N1);
    AND AND13 (M1[1], B[1], N1);
    AND AND14 (M1[2], B[2], N1);
    AND AND15 (M1[3], B[3], N1);
    AND AND16 (M1[4], B[4], N1);
    AND AND17 (M1[5], B[5], N1);
    AND AND18 (M1[6], B[6], N1);
    AND AND19 (M1[7], B[7], N1);

    AND AND20 (M2[0], C[0], N2);
    AND AND21 (M2[1], C[1], N2);
    AND AND22 (M2[2], C[2], N2);
    AND AND23 (M2[3], C[3], N2);
    AND AND24 (M2[4], C[4], N2);
    AND AND25 (M2[5], C[5], N2);
    AND AND26 (M2[6], C[6], N2);
    AND AND27 (M2[7], C[7], N2);
    
    AND AND28 (M3[0], D[0], N3);
    AND AND29 (M3[1], D[1], N3);
    AND AND30 (M3[2], D[2], N3);
    AND AND31 (M3[3], D[3], N3);
    AND AND32 (M3[4], D[4], N3);
    AND AND33 (M3[5], D[5], N3);
    AND AND34 (M3[6], D[6], N3);
    AND AND35 (M3[7], D[7], N3);
    
    OR8 OR1 (L0, M0, M1);
    OR8 OR2 (L1, M2, M3);

    OR8 OR3 (F, L0, L1);

endmodule


module MUX4_1_classic (
    
    output wire F,
    input wire [1:0] S,
    input wire A, B, C, D
    
    );

    wire nS0, nS1;
    wire N0, N1, N2, N3;
    wire M0, M1, M2, M3;
    wire L0, L1;

    NOT NOT0 (nS0, S[0]);
    NOT NOT1 (nS1, S[1]);

    AND AND0 (N0, nS0, nS1);
    AND AND1 (N1, S[0], nS1);
    AND AND2 (N2, nS0, S[1]);
    AND AND3 (N3, S[0], S[1]);

    AND AND4 (M0, A, N0);
    AND AND5 (M1, B, N1);
    AND AND6 (M2, C, N2);
    AND AND7 (M3, D, N3);

    OR OR0 (L0, M0, M1);
    OR OR1 (L1, M2, M3);

    OR OR2 (F, L0, L1);

endmodule

/*-----------------------------------------------ARITHMETIC UNIT-----------------------------------------------*/

module AU(

    output wire Carry,
    output wire [7:0] Result,
    input wire [7:0] A, B,
    input wire [1:0] Control

    );

    wire [7:0] Sum, Increment, Subtraction, Decrement;
    wire sumCarry, incCarry, subCarry, nsubCarry, ndecCarry, decCarry;
    wire [7:0] nB;

    NOT8 NOT0 (nB, B);
    NOT NOT1 (nsubCarry, subCarry);
    NOT NOT2 (ndecCarry, decCarry);

    RIPPLECARRY RC0 (sumCarry, Sum, A, B, 1'b0);
    RIPPLECARRY RC1 (incCarry, Increment, A, 8'b00000001, 1'b0);
    RIPPLECARRY RC2 (subCarry, Subtraction, A, nB, 1'b1);
    RIPPLECARRY RC3 (decCarry, Decrement, A, 8'b11111111, 1'b0);

    MUX4_1 MUX0 (Result, Control, Sum, Increment, Subtraction, Decrement);
    MUX4_1_classic MUX1 (Carry, Control, sumCarry, incCarry, nsubCarry, ndecCarry);

endmodule

/*-----------------------------------------------LOGIC UNIT-----------------------------------------------*/

module LU(

    output wire [7:0] F,
    input wire [7:0] A, B,
    input wire [1:0] Control

    );

    wire [7:0] And, Or, Xor, Not;

    AND8 AND0 (And, A, B);
    OR8 OR0 (Or, A, B);
    XOR8 XOR0 (Xor, A, B);
    NOT8 NOT0 (Not, A);

    MUX4_1 MUX0 (F, Control, And, Or, Xor, Not);

endmodule

/*-----------------------------------------------ALU-----------------------------------------------*/

module ALU(
    
    output wire [7:0] Result,
	output wire [3:0] NZVC, //Flags: Negative, Zero, Overflow, Carry
	input wire [7:0] A, B,
	input wire [2:0] ALU_Sel
    
    );

    wire [7:0] auResult, luResult;
    wire [3:0] auNZVC, luNZVC;
    wire ovAdd, ovSub;

    AU AU1 (auNZVC[0], auResult, A, B, {ALU_Sel[1], ALU_Sel[0]});
    LU LU1 (luResult, A, B, {ALU_Sel[1], ALU_Sel[0]});

    AND AND0 (luNZVC[0], luResult[0], 1'b0);
    AND AND1 (luNZVC[1], luResult[0], 1'b0);

    EQUAL_ZERO EQ1 (auNZVC[2], auResult);
    EQUAL_ZERO EQ2 (luNZVC[2], luResult);

    LESS_ZERO LZ1 (auNZVC[3], auResult);
    LESS_ZERO LZ2 (luNZVC[3], luResult);

    OVERFLOW_ADD OVADD (ovAdd, A[7], B[7], auResult[7]);
    OVERFLOW_SUB OVSUB (ovSub, A[7], B[7], auResult[7]);

    MUX2_1_classic MUX1 (auNZVC[1], ALU_Sel[1], ovAdd, ovSub);
    MUX2_1 MUX2 (NZVC, ALU_Sel[2], auNZVC, luNZVC);
    MUX2_1 MUX3 (Result, ALU_Sel[2], auResult, luResult);

endmodule
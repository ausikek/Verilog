//SELECTOR

`timescale 1ns/1ps
`include "../../gates/AND/AND.v"
`include "../../gates/OR/OR.v"
`include "../../gates/NOT/NOT.v"

module SELECTOR(

    output wire [7:0] F,
    input wire A,
    input wire [7:0] I1,
    input wire [7:0] I0

    );
    
    wire [7:0] T0;
    wire [7:0] T1;

    //Choosing I0 -> A = 0
    //Choosing I1 -> A = 1

    wire nA;

    NOT not_gate(nA, A);

    AND and_gate_0_01(T0[0],  nA, I0[0]);
    AND and_gate_0_02(T0[1],  nA, I0[1]);
    AND and_gate_0_03(T0[2],  nA, I0[2]);
    AND and_gate_0_04(T0[3],  nA, I0[3]);
    AND and_gate_0_05(T0[4],  nA, I0[4]);
    AND and_gate_0_06(T0[5],  nA, I0[5]);
    AND and_gate_0_07(T0[6],  nA, I0[6]);
    AND and_gate_0_08(T0[7],  nA, I0[7]);

    AND and_gate_1_01(T1[0],  A, I1[0]);
    AND and_gate_1_02(T1[1],  A, I1[1]);
    AND and_gate_1_03(T1[2],  A, I1[2]);
    AND and_gate_1_04(T1[3],  A, I1[3]);
    AND and_gate_1_05(T1[4],  A, I1[4]);
    AND and_gate_1_06(T1[5],  A, I1[5]);
    AND and_gate_1_07(T1[6],  A, I1[6]);
    AND and_gate_1_08(T1[7],  A, I1[7]);

    OR or_gate1(F[0],   T0[0],  T1[0]);
    OR or_gate2(F[1],   T0[1],  T1[1]);
    OR or_gate3(F[2],   T0[2],  T1[2]);
    OR or_gate4(F[3],   T0[3],  T1[3]);
    OR or_gate5(F[4],   T0[4],  T1[4]);
    OR or_gate6(F[5],   T0[5],  T1[5]);
    OR or_gate7(F[6],   T0[6],  T1[6]);
    OR or_gate8(F[7],   T0[7],  T1[7]);

endmodule
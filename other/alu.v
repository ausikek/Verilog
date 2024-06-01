//ARITHMETIC UNIT

`timescale 1ns/1ps
`include "components.v"

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

    AND AND0 (auNZVC[0], luResult[0], 1'b0);

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
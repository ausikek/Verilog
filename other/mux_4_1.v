`include "and8.v"
`include "or8.v"
`include "not8.v"
`timescale 1ns/1ps

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
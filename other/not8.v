//8 BIT NOT

`timescale 1ns/1ps
`include "../gates/NOT/NOT.v"

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
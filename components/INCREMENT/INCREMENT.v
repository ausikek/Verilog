//INCREMENT

`timescale 1ns/1ps
`include "../MULTI_BIT_ADDER/MULTI_BIT_ADDER.v"

module INCREMENT(

    output wire [7:0] F,
    input wire [7:0] A

    );

    wire E;
    wire [7:0] B; 
    wire C;         

    //B is set to 1 and C is set to 0.

    assign B = 8'b0000_0001;
    assign C = 0;

    MULTI_BIT_ADDER adder(E, F, A, B, C);

endmodule
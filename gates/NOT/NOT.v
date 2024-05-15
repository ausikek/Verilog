//NOT GATE

`timescale 1ns/1ps

module NOT(
    
    output wire F,
    input wire A

    );

    nand nand_gate1 (F, A, A);

endmodule
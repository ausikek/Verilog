// 8-BIT REGISTER

`timescale 1ns/1ps
`include "combinational.v"


module dflipflop (output reg Q,Qn, 
                  input wire clk, res, EN, D);
  
  always @ (posedge clk or negedge res or negedge EN)
  	begin
	  	if (!res)
  			begin
  				Q <= 1'b0;
  				Qn <= 1'b1;
  			end
  		else if (!EN)
  			begin
  				Q <= 1'b1;
  				Qn <= 1'b0;
  			end
  		else
  			begin
  				Q <= D;
  				Qn <= ~D;
  			end
    end

endmodule


module reg8a (
        
    output wire [7:0] Reg_Out,
    input wire clk, res, EN,
    input wire [7:0] Reg_In
    
    );

    wire [7:0] nQ;
    wire [7:0] Mux_Out;

    MUX2_1 mux0 (Mux_Out, EN, Reg_Out, Reg_In);

    dflipflop dff0 (Reg_Out[0], nQ[1], clk, res, 1'b1, Mux_Out[0]);
    dflipflop dff1 (Reg_Out[1], nQ[0], clk, res, 1'b1, Mux_Out[1]);
    dflipflop dff2 (Reg_Out[2], nQ[3], clk, res, 1'b1, Mux_Out[2]);
    dflipflop dff3 (Reg_Out[3], nQ[2], clk, res, 1'b1, Mux_Out[3]);
    dflipflop dff4 (Reg_Out[4], nQ[5], clk, res, 1'b1, Mux_Out[4]);
    dflipflop dff5 (Reg_Out[5], nQ[4], clk, res, 1'b1, Mux_Out[5]);
    dflipflop dff6 (Reg_Out[6], nQ[7], clk, res, 1'b1, Mux_Out[6]);
    dflipflop dff7 (Reg_Out[7], nQ[6], clk, res, 1'b1, Mux_Out[7]);

endmodule
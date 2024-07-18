`timescale 1ns/1ps

module register(
    
    output reg [7:0] Reg_Out, 
    input wire clk, load, reset,
    input wire [7:0] Reg_In
              
    );
  
  always @ (posedge clk)
  	
    begin: REGISTER	  	
  		
        if (!reset)
            Reg_Out <= 8'b0;
        else
            if (load)
                Reg_Out <= Reg_In;
  	end
  
endmodule
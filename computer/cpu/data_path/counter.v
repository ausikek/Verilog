`timescale 1ns/1ps

module counter(
    
    output reg [7:0] CNT, 
    input wire clk, load, inc, reset,
    input wire [7:0] CNT_In
    
    );
  
  always @ (posedge clk)
  	
    begin: COUNTER	  	
        if (!reset)
            CNT <= 8'b0;
        else
            if (load)
                CNT <= CNT_In;	
            else if (inc)
                CNT <= CNT + 1; 		
    end

endmodule


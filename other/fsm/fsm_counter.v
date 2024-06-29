/* 
   Verilog 8-bit Counter
   3 block FSM diagram
*/

`timescale 1ns/1ps

module count8a (
   
   output reg [7:0] CNT, 
   input wire clk, res, EN, load,
   input wire [7:0] CNT_In
                
   );

   // States

   reg [1:0] state, next_state;

   // State definitions

   localparam S0 = 2'b00; // res false, EN don't care and load don't care
   localparam S1 = 2'b01; // res true, EN true and load true
   localparam S2 = 2'b10; // res true, EN true and load false
   localparam S3 = 2'b11; // res true, EN false and load don't care

   // 1: State Transition

   always @ (*) begin
      
      if (!res)

         state <= S0;

      else

         state <= next_state;

   end

   // 2: Next State

   always @ (*) begin

      if (res && EN && load) begin

         next_state <= S1;

      end


      else if (res && EN && !load) begin

         next_state <= S2;

      end


      else if (res && !EN) begin

         next_state <= S3;

      end


      else if (!res) begin

         next_state <= S0;

      end

   end

   // 3: Counter Logic

   always @ (posedge clk or negedge res) begin

      if (!res)

         CNT <= 8'b00000000;

      else begin

         case (state)

            S0: begin

               CNT <= 8'b00000000;

            end

            S1: begin

               CNT <= CNT_In;

            end

            S2: begin

               CNT <= CNT + 8'b00000001;

            end

            S3: begin

               CNT <= CNT;

            end

         endcase

      end

   end

endmodule
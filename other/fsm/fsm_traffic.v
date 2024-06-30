/* Verilog Traffic Simulator */

`timescale 1ms/1ps

module fsm_traffic (

    output reg GRN,
    output reg YLW,
    output reg RED,
    input wire car,
    input wire clk,
    input wire rst

    );

    // States

    reg [2:0] state, next_state;

    // State definitions

    localparam S0 = 3'b100; // Green Light
    localparam S1 = 3'b010; // Yellow Light
    localparam S2 = 3'b001; // Red Light

    localparam T1 = 1499; // 3 seconds (1500 counter flips)
    localparam T2 = 7499; // 15 seconds (7500 counter flips)

    reg [15:0] counter;
    reg timeout;

    // 1: State Transition

    always @ (posedge clk or posedge rst or posedge car) begin

        if (rst) begin

            state <= S0;
            counter <= 0;
            timeout <= 0;

        end

        else begin

            if (counter == 0) begin

                state <= next_state;

                case (next_state)

                    S1: counter <= T1;
                    S2: counter <= T2;

                endcase

            end

            else

                counter <= counter - 1;

                if (counter == 1 && state == S2)

                    timeout <= 1;

        end

    end

    // 2: Next State

    always @ (*) begin

        case (state)
            
            S0: begin
                
                if (car) 
                    
                    next_state = S1;
                
                else begin
                    
                    next_state = S0;
                    timeout = 0;

                end
            
            end
            
            S1: next_state = S2;
            
            S2: begin
                
                if (timeout)
                    
                    next_state = S0;
                
                else
                    
                    next_state = S2;
            
            end
            
            default: next_state = S0;
        
        endcase

    end

    // 3: Output Logic

    always @ (*) begin

        if (state == S0) begin

            GRN <= 1;
            YLW <= 0;
            RED <= 0;

        end

        else if (state == S1) begin

            GRN <= 0;
            YLW <= 1;
            RED <= 0;

        end

        else if (state == S2) begin

            GRN <= 0;
            YLW <= 0;
            RED <= 1;

        end

    end

endmodule
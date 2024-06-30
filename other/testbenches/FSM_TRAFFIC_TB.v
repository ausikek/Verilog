//FSM TRAFFIC TESTBENCH

`timescale 1ms/1ps	
`include "fsm_traffic.v"

module FSM_TRAFFIC_TB();

    reg CAR_TB;
    reg RST_TB;
    reg CLK_TB;
    wire GRN_TB, YLW_TB, RED_TB;

    integer i;

    fsm_traffic DUT (GRN_TB, YLW_TB, RED_TB, CAR_TB, CLK_TB, RST_TB);

    initial 
    
        begin
            
            $dumpfile("FSM_TRAFFIC_TB.vcd");
            $dumpvars(0, FSM_TRAFFIC_TB);

                    CLK_TB = 0;
                    #1

                    for (i = 0; i < 120000; i = i + 1) begin

                        CLK_TB = ~CLK_TB;
                        #1;

                    end
        end

    initial

        begin
                    
                    CAR_TB = 0; 
                    RST_TB = 1;
            #100    RST_TB = 0;
            #5000   CAR_TB = 1;
            #100    CAR_TB = 0;
            #10000  CAR_TB = 0;
            #100    CAR_TB = 0;
            #40000  CAR_TB = 1;
            #100    CAR_TB = 0;
            #15000  CAR_TB = 0;
            #100    CAR_TB = 0;
        
        end

endmodule
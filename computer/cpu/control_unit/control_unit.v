module control_unit(
		
	output reg IR_Load, 
	output reg MAR_Load, 
	output reg PC_Load, PC_Inc, 
	output reg A_Load, B_Load,
	output reg CCR_Load,
	output reg [2:0] ALU_Sel,
	output reg [1:0] Bus1_Sel, Bus2_Sel,
	output reg write, 
	input wire [7:0] IR, 
	input wire [3:0] CCR_Result,
	input wire clk, reset
	
	);
             
  	reg [7:0] current_state, next_state;

	parameter LDA_IMM = 8'h86; // Load Register A (Immediate Addressing)
	parameter LDA_DIR = 8'h87; // Load Register A from memory (RAM or IO) (Direct Addressing)
	parameter LDB_IMM = 8'h88; // Load Register B (Immediate Addressing)
	parameter LDB_DIR = 8'h89; // Load Register B from memory (RAM or IO) (Direct Addressing)
	parameter STA_DIR = 8'h96; // Store Register A to memory (RAM or IO)
	parameter STB_DIR = 8'h97; // Store Register B to memory (RAM or IO)
	
	parameter ADD_AB  = 8'h42; // A <= A + B
	parameter SUB_AB  = 8'h43; // A <= A - B
	parameter AND_AB  = 8'h44; // A <= A & B
	parameter OR_AB   = 8'h45; // A <= A | B
	parameter INCA    = 8'h46; // A <= A + 1
	parameter INCB    = 8'h47; // B <= B + 1
	parameter DECA	  = 8'h48; // A <= A - 1
	parameter DECB    = 8'h49; // B <= B - 1
	parameter XOR_AB  = 8'h4A; // A <= A ^ B
	parameter NOTA	  = 8'h4B; // A <= ~A
	parameter NOTB    = 8'h4C; // B <= ~B
	
	parameter BRA     = 8'h20; // Branch Always    to (ROM) Address
	parameter BMI     = 8'h21; // Branch if N == 1 to (ROM) Address
	parameter BPL     = 8'h22; // Branch if N == 0 to (ROM) Address
	parameter BEQ     = 8'h23; // Branch if Z == 1 to (ROM) Address
	parameter BNE	  = 8'h24; // Branch if Z == 0 to (ROM) Address
	parameter BVS	  = 8'h25; // Branch if V == 1 to (ROM) Address 
	parameter BVC     = 8'h26; // Branch if V == 0 to (ROM) Address
	parameter BCS     = 8'h27; // Branch if C == 1 to (ROM) Address
	parameter BCC     = 8'h28; // Branch if C == 0 to (ROM) Address
  	
	parameter S0_FETCH =    0,  //-- Opcode fetch states
              S1_FETCH =    1,
              S2_FETCH =    2,
              
              S3_DECODE =   3, //-- Opcode decode state
              
              S4_LDA_IMM =  4, //-- LDA_IMM execute states
              S5_LDA_IMM =  5,
              S6_LDA_IMM =  6,
              
              S4_LDA_DIR =  7, //-- LDA_DIR execute states
              S5_LDA_DIR =  8,
              S6_LDA_DIR =  9,
			  S7_LDA_DIR = 10,
			  S8_LDA_DIR = 11,

			  S4_LDB_IMM = 12, //-- LDB_IMM execute states
			  S5_LDB_IMM = 13,
			  S6_LDB_IMM = 14,
			  
			  S4_LDB_DIR = 15, //-- LDB_DIR execute states
			  S5_LDB_DIR = 16,
			  S6_LDB_DIR = 17,
			  S7_LDB_DIR = 18,
			  S8_LDB_DIR = 19,
			  
			  S4_STA_DIR = 20, //-- STA_DIR execute states
			  S5_STA_DIR = 21,
			  S6_STA_DIR = 22,
			  S7_STA_DIR = 23,
			  
			  S4_STB_DIR = 24, //-- STB_DIR execute states
			  S5_STB_DIR = 25,
			  S6_STB_DIR = 26,
			  S7_STB_DIR = 27,
			  
			  S4_ADD_AB = 28, //-- ADD_AB execute states
			  
			  S4_SUB_AB = 29, //-- SUB_AB execute states
			  S5_SUB_AB = 30,
			  S6_SUB_AB = 31,
			  
			  S4_AND_AB = 32, //-- AND_AB execute states
			  
			  S4_OR_AB  = 33, //-- OR_AB execute states
			  
			  S4_INCA   = 34, //-- INCA execute states
			  S5_INCA   = 35,
			  
			  S4_INCB   = 36, //-- INCB execute states
			  
			  S4_DECA   = 37, //-- DECA execute states
			  S5_DECA   = 38,
			  
			  S4_DECB   = 39, //-- DECB execute states
			  
			  S4_XOR_AB = 40, //-- XOR_AB execute states
			  
			  S4_NOTA   = 41, //-- NOTA execute states
			  S5_NOTA   = 42,
			  
			  S4_NOTB   = 43, //-- NOTB execute states

			  S4_BRA    = 44, //-- BRA execute states
			  S5_BRA    = 45,
			  S6_BRA    = 46,

			  S4_BMI    = 47, //-- BMI execute states
			  S5_BMI    = 48,
			  S6_BMI    = 49,
			  S7_BMI    = 50,

			  S4_BPL    = 51, //-- BPL execute states
			  S5_BPL    = 52,
			  S6_BPL    = 53,
			  S7_BPL    = 54,

			  S4_BEQ    = 55, //-- BEQ execute states
			  S5_BEQ    = 56,
			  S6_BEQ    = 57,
			  S7_BEQ    = 58,

			  S4_BNE    = 59, //-- BNE execute states
			  S5_BNE    = 60,
			  S6_BNE    = 61,
			  S7_BNE    = 62,

			  S4_BVS    = 63, //-- BVS execute states
			  S5_BVS    = 64,
			  S6_BVS    = 65,
			  S7_BVS    = 66,

			  S4_BVC    = 67, //-- BVC execute states
			  S5_BVC    = 68,
			  S6_BVC    = 69,
			  S7_BVC    = 70,

			  S4_BCS    = 71, //-- BCS execute states
			  S5_BCS    = 72,
			  S6_BCS    = 73,
			  S7_BCS    = 74,

			  S4_BCC    = 75, //-- BCC execute states
			  S5_BCC    = 76,
			  S6_BCC    = 77,
			  S7_BCC    = 78;
            
  	initial
  		begin
    		current_state = S0_FETCH;
    		next_state = S0_FETCH;
    		IR_Load = 0;
    		MAR_Load = 1;
    		PC_Load = 0;
    		PC_Inc = 0;
    		A_Load = 0;
    		B_Load = 0;
    		CCR_Load = 0;
    		ALU_Sel = 3'b000;
    		Bus1_Sel = 2'b00;
    		Bus2_Sel = 2'b01;
    		write = 0;
    	end          
  
  	always @ (posedge clk or negedge reset)
  		begin: STATE_MEMORY
  			if (!reset)
  				current_state <= S0_FETCH;
  			else
  				current_state <= next_state;
  		end
  	
  	always @ (current_state)
  		begin: NEXT_STATE_LOGIC
			case (current_state)
  				
				S0_FETCH : next_state = S1_FETCH;
  				S1_FETCH : next_state = S2_FETCH;
  				S2_FETCH : next_state = S3_DECODE;
  				
  				S3_DECODE :  if (IR == LDA_IMM) next_state = S4_LDA_IMM;
  						else if (IR == LDA_DIR) next_state = S4_LDA_DIR;
						else if (IR == LDB_IMM) next_state = S4_LDB_IMM;
  						else if (IR == LDB_DIR) next_state = S4_LDB_DIR;
  						else if (IR == STA_DIR) next_state = S4_STA_DIR;
  						else if (IR == STB_DIR) next_state = S4_STB_DIR;
  						else if (IR ==  ADD_AB) next_state = S4_ADD_AB;
  						else if (IR ==  SUB_AB) next_state = S4_SUB_AB;
  						else if (IR ==  AND_AB) next_state = S4_AND_AB;
  						else if (IR ==   OR_AB) next_state = S4_OR_AB;
  						else if (IR ==    INCA) next_state = S4_INCA;
  						else if (IR ==    INCB) next_state = S4_INCB;
  						else if (IR ==    DECA) next_state = S4_DECA;
  						else if (IR ==    DECB) next_state = S4_DECB;
  						else if (IR ==  XOR_AB) next_state = S4_XOR_AB;
  						else if (IR ==    NOTA) next_state = S4_NOTA;
  						else if (IR ==    NOTB) next_state = S4_NOTB;
  						else if (IR ==     BRA) next_state = S4_BRA;
  						
						else if (IR == BMI) begin
							
							if (CCR_Result[3] == 1)
								
								next_state = S4_BMI;
							else
								
								next_state = S7_BMI;
							
						end
  						
						else if (IR == BPL) begin

							if (CCR_Result[3] == 0)
								
								next_state = S4_BPL;
							else
								
								next_state = S7_BPL;
							
						end
  						
						else if (IR == BEQ) begin

							if (CCR_Result[2] == 1)
								
								next_state = S4_BEQ;
							else
								
								next_state = S7_BEQ;
							
						end
  						
						else if (IR == BNE) begin

							if (CCR_Result[2] == 0)
								
								next_state = S4_BNE;
							else
								
								next_state = S7_BNE;
							
						end
  						
						else if (IR == BVS) begin

							if (CCR_Result[1] == 1)
								
								next_state = S4_BVS;
							else
								
								next_state = S7_BVS;
							
						end
  						
						else if (IR == BVC) begin

							if (CCR_Result[1] == 0)
								
								next_state = S4_BVC;
							else
								
								next_state = S7_BVC;
							
						end
  						
						else if (IR == BCS) begin

							if (CCR_Result[0] == 1)
								
								next_state = S4_BCS;
							else
								
								next_state = S7_BCS;
							
						end
  						
						else if (IR == BCC) begin

							if (CCR_Result[0] == 0)
								
								next_state = S4_BCC;
							else
								
								next_state = S7_BCC;
							
						end
  						
						else next_state = S0_FETCH;
  			   				
  				S4_LDA_IMM : next_state = S5_LDA_IMM; // Execute LDA_IMM  
  				S5_LDA_IMM : next_state = S6_LDA_IMM;
				S6_LDA_IMM : next_state = S0_FETCH;

				S4_LDA_DIR : next_state = S5_LDA_DIR; // Execute LDA_DIR
				S5_LDA_DIR : next_state = S6_LDA_DIR;
				S6_LDA_DIR : next_state = S7_LDA_DIR;
				S7_LDA_DIR : next_state = S8_LDA_DIR;
				S8_LDA_DIR : next_state = S0_FETCH;

				S4_LDB_IMM : next_state = S5_LDB_IMM; // Execute LDB_IMM
				S5_LDB_IMM : next_state = S6_LDB_IMM;
				S6_LDB_IMM : next_state = S0_FETCH;

				S4_LDB_DIR : next_state = S5_LDB_DIR; // Execute LDB_DIR
				S5_LDB_DIR : next_state = S6_LDB_DIR;
				S6_LDB_DIR : next_state = S7_LDB_DIR;
				S7_LDB_DIR : next_state = S8_LDB_DIR;
				S8_LDB_DIR : next_state = S0_FETCH;

				S4_STA_DIR : next_state = S5_STA_DIR; // Execute STA_DIR
				S5_STA_DIR : next_state = S6_STA_DIR;
				S6_STA_DIR : next_state = S7_STA_DIR;
				S7_STA_DIR : next_state = S0_FETCH;

				S4_STB_DIR : next_state = S5_STB_DIR; // Execute STB_DIR
				S5_STB_DIR : next_state = S6_STB_DIR;
				S6_STB_DIR : next_state = S7_STB_DIR;
				S7_STB_DIR : next_state = S0_FETCH;

				S4_ADD_AB : next_state = S0_FETCH; // Execute ADD_AB
				
				S4_SUB_AB : next_state = S5_SUB_AB; // Execute SUB_AB
				S5_SUB_AB : next_state = S6_SUB_AB;
				S6_SUB_AB : next_state = S0_FETCH;

				S4_AND_AB : next_state = S0_FETCH; // Execute AND_AB

				S4_OR_AB  : next_state = S0_FETCH; // Execute OR_AB

				S4_INCA   : next_state = S5_INCA;
				S5_INCA   : next_state = S0_FETCH; // Execute INCA

				S4_INCB   : next_state = S0_FETCH; // Execute INCB

				S4_DECA   : next_state = S5_DECA;
				S5_DECA   : next_state = S0_FETCH; // Execute DECA

				S4_DECB   : next_state = S0_FETCH; // Execute DECB

				S4_XOR_AB : next_state = S0_FETCH; // Execute XOR_AB

				S4_NOTA   : next_state = S5_NOTA;
				S5_NOTA   : next_state = S0_FETCH; // Execute NOTA

				S4_NOTB   : next_state = S0_FETCH; // Execute NOTB

				S4_BRA : next_state = S5_BRA; // Execute BRA
				S5_BRA : next_state = S6_BRA;
				S6_BRA : next_state = S0_FETCH;
				
				S4_BMI : next_state = S5_BMI; // Execute BMI
				S5_BMI : next_state = S6_BMI;
				S6_BMI : next_state = S0_FETCH;
				S7_BMI : next_state = S0_FETCH;
				
				S4_BPL : next_state = S5_BPL; // Execute BPL
				S5_BPL : next_state = S6_BPL;
				S6_BPL : next_state = S0_FETCH;
				S7_BPL : next_state = S0_FETCH;
				
				S4_BEQ : next_state = S5_BEQ; // Execute BEQ
				S5_BEQ : next_state = S6_BEQ;
				S6_BEQ : next_state = S0_FETCH;
				S7_BEQ : next_state = S0_FETCH;
				
				S4_BNE : next_state = S5_BNE; // Execute BNE
				S5_BNE : next_state = S6_BNE;
				S6_BNE : next_state = S0_FETCH;
				S7_BNE : next_state = S0_FETCH;
				
				S4_BVS : next_state = S5_BVS; // Execute BVS
				S5_BVS : next_state = S6_BVS;
				S6_BVS : next_state = S0_FETCH;
				S7_BVS : next_state = S0_FETCH;
				
				S4_BVC : next_state = S5_BVC; // Execute BVC
				S5_BVC : next_state = S6_BVC;
				S6_BVC : next_state = S0_FETCH;
				S7_BVC : next_state = S0_FETCH;
				
				S4_BCS : next_state = S5_BCS; // Execute BCS
				S5_BCS : next_state = S6_BCS;
				S6_BCS : next_state = S0_FETCH;
				S7_BCS : next_state = S0_FETCH;
				
				S4_BCC : next_state = S5_BCC; // Execute BCC
				S5_BCC : next_state = S6_BCC;
				S6_BCC : next_state = S0_FETCH;
				S7_BCC : next_state = S0_FETCH;

  				default  : next_state = S0_FETCH;
  			
			endcase
  		end
  	
  		always @ (current_state)
  			begin: OUTPUT_LOGIC
  				case (current_state)
  				
  					S0_FETCH : 
  						begin // Put PC onto MAR to provide address of Opcode 
  							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
 							write = 0;
						end
					
					S1_FETCH : 
  						begin // Increment PC 
  							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 1;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
 							write = 0;
						end

					S2_FETCH : 
  						begin // Load Opcode from memory into IR 
  							IR_Load = 1;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
 							write = 0;
						end
						
					S3_DECODE : 
  						begin // Decode Opcode 
  							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
 							write = 0;
						end

					S4_LDA_IMM : 
  						begin // Load PC address into MAR
  							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
 							write = 0;
						end

					S5_LDA_IMM : 
  						begin // Increment PC
  							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 1;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
 							write = 0;
						end

					S6_LDA_IMM : 
  						begin // Load data from memory into A
  							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 1;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
 							write = 0;
						end

					S4_LDA_DIR : 
  						begin // Load PC address into MAR
  							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
 							write = 0;
						end

					S5_LDA_DIR : 
  						begin // Increment PC
  							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 1;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
 							write = 0;
						end

					S6_LDA_DIR : 
  						begin // Load address on MAR
  							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
 							write = 0;
						end

					S7_LDA_DIR :
						begin // Wait
  							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
 							write = 0;
						end

					S8_LDA_DIR :
						begin // Load data from memory into A
  							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 1;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
 							write = 0;
						end

					S4_LDB_IMM : 
  						begin // Load PC address into MAR
  							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
 							write = 0;
						end

					S5_LDB_IMM : 
  						begin // Increment PC
  							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 1;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
 							write = 0;
						end

					S6_LDB_IMM : 
  						begin // Load data from memory into B
  							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 1;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
 							write = 0;
						end

					S4_LDB_DIR : 
  						begin // Load PC address into MAR
  							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
 							write = 0;
						end

					S5_LDB_DIR : 
  						begin // Increment PC
  							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 1;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
 							write = 0;
						end

					S6_LDB_DIR : 
  						begin // Load address into MAR
  							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
 							write = 0;
						end

					S7_LDB_DIR : 
  						begin // Wait
  							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
 							write = 0;
						end

					S8_LDB_DIR :
						begin // Load data from memory into B
  							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 1;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
 							write = 0;
						end

					S4_STA_DIR : 
  						begin // Load PC address into MAR
  							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
 							write = 0;
						end

					S5_STA_DIR : 
  						begin // Increment PC
  							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 1;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
 							write = 0;
						end

					S6_STA_DIR : 
  						begin // Load data from memory into MAR
  							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
 							write = 0;
						end

					S7_STA_DIR : 
  						begin // Write data from A into memory
  							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b01; // PC, A, B
  							Bus2_Sel = 2'b00; // ALU, Bus1, from_memory
 							write = 1;
						end

					S4_STB_DIR : 
  						begin // Load PC address into MAR
  							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
 							write = 0;
						end

					S5_STB_DIR : 
  						begin // Increment PC
  							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 1;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
 							write = 0;
						end

					S6_STB_DIR : 
  						begin // Load data from memory into MAR
  							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
 							write = 0;
						end

					S7_STB_DIR : 
  						begin // Write data from B into memory
  							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b10; // PC, A, B
  							Bus2_Sel = 2'b00; // ALU, Bus1, from_memory
 							write = 1;
						end

					S4_ADD_AB : 
  						begin // Redirect A to ALU
  							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 1;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 1;
 							Bus1_Sel = 2'b01; // PC, A, B
  							Bus2_Sel = 2'b00; // ALU, Bus1, from_memory
 							write = 0;
						end

					S4_SUB_AB :
						begin // Do NOT B and store in B
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 1;
							ALU_Sel = 3'b111;
							CCR_Load = 0;
							Bus1_Sel = 2'b10; // PC, A, B
							Bus2_Sel = 2'b00; // ALU, Bus1, from_memory
							write = 0;
						end

					S5_SUB_AB :
						begin // Do INC B and store in B
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 1;
							ALU_Sel = 3'b001;
							CCR_Load = 0;
							Bus1_Sel = 2'b10; // PC, A, B
							Bus2_Sel = 2'b00; // ALU, Bus1, from_memory
							write = 0;
						end

					S6_SUB_AB :
						begin // Do A + B and store in A
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 1;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 1;
							Bus1_Sel = 2'b01; // PC, A, B
							Bus2_Sel = 2'b00; // ALU, Bus1, from_memory
							write = 0;
						end

					S4_AND_AB :
						begin // Redirect A to ALU
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 1;
							B_Load = 0;
							ALU_Sel = 3'b100;
							CCR_Load = 1;
							Bus1_Sel = 2'b01; // PC, A, B
							Bus2_Sel = 2'b00; // ALU, Bus1, from_memory
							write = 0;
						end
					
					S4_OR_AB :
						begin // Redirect A to ALU
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 1;
							B_Load = 0;
							ALU_Sel = 3'b101;
							CCR_Load = 1;
							Bus1_Sel = 2'b01; // PC, A, B
							Bus2_Sel = 2'b00; // ALU, Bus1, from_memory
							write = 0;
						end

					S4_INCA :
						begin // Load A into BUS1 and into B
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 1;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b01; // PC, A, B
							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
							write = 0;
						end

					S5_INCA :
						begin // Redirect A to ALU
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 1;
							B_Load = 0;
							ALU_Sel = 3'b001;
							CCR_Load = 0;
							Bus1_Sel = 2'b01; // PC, A, B
							Bus2_Sel = 2'b00; // ALU, Bus1, from_memory
							write = 0;
						end


					S4_INCB :
						begin // Redirect B to ALU
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 1;
							ALU_Sel = 3'b001;
							CCR_Load = 1;
							Bus1_Sel = 2'b10; // PC, A, B
							Bus2_Sel = 2'b00; // ALU, Bus1, from_memory
							write = 0;
						end	

					S4_DECA :
						begin // Load A into BUS1 and into B
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 1;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b01; // PC, A, B
							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
							write = 0;
						end

					S5_DECA :
						begin // Redirect A to ALU
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 1;
							B_Load = 0;
							ALU_Sel = 3'b011;
							CCR_Load = 0;
							Bus1_Sel = 2'b01; // PC, A, B
							Bus2_Sel = 2'b00; // ALU, Bus1, from_memory
							write = 0;
						end

					S4_DECB :
						begin // Redirect B to ALU
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 1;
							ALU_Sel = 3'b011;
							CCR_Load = 1;
							Bus1_Sel = 2'b10; // PC, A, B
							Bus2_Sel = 2'b00; // ALU, Bus1, from_memory
							write = 0;
						end

					S4_XOR_AB :
						begin // Redirect A to ALU
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 1;
							B_Load = 0;
							ALU_Sel = 3'b110;
							CCR_Load = 1;
							Bus1_Sel = 2'b01; // PC, A, B
							Bus2_Sel = 2'b00; // ALU, Bus1, from_memory
							write = 0;
						end

					S4_NOTA :
						begin // Load A into BUS1 and into B
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 1;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b01; // PC, A, B
							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
							write = 0;
						end

					S5_NOTA :
						begin // Redirect A to ALU
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 1;
							B_Load = 0;
							ALU_Sel = 3'b111;
							CCR_Load = 1;
							Bus1_Sel = 2'b01; // PC, A, B
							Bus2_Sel = 2'b00; // ALU, Bus1, from_memory
							write = 0;
						end

					S4_NOTB :
						begin // Redirect B to ALU
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 1;
							ALU_Sel = 3'b111;
							CCR_Load = 1;
							Bus1_Sel = 2'b10; // PC, A, B
							Bus2_Sel = 2'b00; // ALU, Bus1, from_memory
							write = 0;
						end

					S4_BRA :
						begin // Load PC address into MAR
							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
							write = 0;
						end

					S5_BRA :
						begin // Wait
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S6_BRA :
						begin // Load data from memory into PC
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 1;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S4_BMI :
						begin // Load PC address into MAR
							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
							write = 0;
						end

					S5_BMI :
						begin // Wait
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S6_BMI :
						begin // Load data from memory into PC
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 1;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S7_BMI :
						begin // Increment PC
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 1;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S4_BPL :
						begin // Load PC address into MAR
							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
							write = 0;
						end

					S5_BPL :
						begin // Wait
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S6_BPL :
						begin // Load data from memory into PC
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 1;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S7_BPL :
						begin // Increment PC
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 1;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S4_BEQ :
						begin // Load PC address into MAR
							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
							write = 0;
						end

					S5_BEQ :
						begin // Wait
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S6_BEQ :
						begin // Load data from memory into PC
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 1;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S7_BEQ :
						begin // Increment PC
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 1;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S4_BNE :
						begin // Load PC address into MAR
							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
							write = 0;
						end

					S5_BNE :
						begin // Wait
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end
					
					S6_BNE :
						begin // Load data from memory into PC
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 1;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end
					
					S7_BNE :
						begin // Increment PC
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 1;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S4_BVS :
						begin // Load PC address into MAR
							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
							write = 0;
						end

					S5_BVS :
						begin // Wait
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S6_BVS :
						begin // Load data from memory into PC
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 1;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S7_BVS :
						begin // Increment PC
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 1;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S4_BVC :
						begin // Load PC address into MAR
							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
							write = 0;
						end

					S5_BVC :
						begin // Wait
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S6_BVC :
						begin // Load data from memory into PC
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 1;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S7_BVC :
						begin // Increment PC
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 1;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S4_BCS :
						begin // Load PC address into MAR
							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
							write = 0;
						end

					S5_BCS :
						begin // Wait
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S6_BCS :
						begin // Load data from memory into PC
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 1;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S7_BCS :
						begin // Increment PC
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 1;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S4_BCC :
						begin // Load PC address into MAR
							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
							write = 0;
						end

					S5_BCC :
						begin // Wait
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S6_BCC :
						begin // Load data from memory into PC
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 1;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					S7_BCC :
						begin // Increment PC
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 1;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b10; // ALU, Bus1, from_memory
							write = 0;
						end

					default : 
						begin
							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 0;
							A_Load = 0;
							B_Load = 0;
							ALU_Sel = 3'b000;
							CCR_Load = 0;
							Bus1_Sel = 2'b00; // PC, A, B
							Bus2_Sel = 2'b00; // ALU, Bus1, from_memory
							write = 0;
						end
  				
				endcase
  			end
endmodule
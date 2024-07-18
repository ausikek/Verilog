`include "./cpu/data_path/alu.v"
`include "./cpu/data_path/register.v"
`include "./cpu/data_path/counter.v"

module data_path(
	
	output reg [7:0] address,
	output reg [7:0] to_memory,
	output wire [7:0] IR_out,
	output wire [3:0] CCR_Result, 
	input wire [7:0] from_memory,
	input wire [2:0] ALU_Sel,
	input wire [1:0] Bus1_Sel, Bus2_Sel,
	input wire IR_Load, MAR_Load, PC_Load, PC_Inc, A_Load, B_Load, CCR_Load,  
	input wire clk, reset
	
	);
	
	reg [7:0] Bus1, Bus2;
	wire [7:0] PC, MAR, A, B, ALU_Result;
	wire [3:0] NZVC;
	
	always @ (Bus1_Sel, PC, A, B) 
	begin: MUX_BUS1
		case (Bus1_Sel)
			2'b00 : Bus1 = PC;
			2'b01 : Bus1 = A;
			2'b10 : Bus1 = B; 
			default : Bus1 = 8'hXX;
		endcase 
	end
	
	always @ (Bus2_Sel, ALU_Result, Bus1, from_memory) 
	begin: MUX_BUS2
		case (Bus2_Sel)
			2'b00 : Bus2 = ALU_Result;
			2'b01 : Bus2 = Bus1;
			2'b10 : Bus2 = from_memory; 
			default : Bus2 = 8'hXX;
		endcase 
	end	
	
	always @ (Bus1, MAR) 
	begin
		to_memory = Bus1;
		address = MAR; 
	end

	counter PC0(
		
		.CNT(PC),
		.clk(clk),
		.load(PC_Load),
		.inc(PC_Inc),
		.reset(reset),
		.CNT_In(Bus2)
	
	);

	register MAR0(
		
		.Reg_Out(MAR),
		.clk(clk),
		.load(MAR_Load),
		.reset(reset),
		.Reg_In(Bus2)
	
	);

	register IR0(
		
		.Reg_Out(IR_out),
		.clk(clk),
		.load(IR_Load),
		.reset(reset),
		.Reg_In(Bus2)
	
	);

	register A_Register(
		
		.Reg_Out(A),
		.clk(clk),
		.load(A_Load),
		.reset(reset),
		.Reg_In(Bus2)
	
	);

	register B_Register(
		
		.Reg_Out(B),
		.clk(clk),
		.load(B_Load),
		.reset(reset),
		.Reg_In(Bus2)
	
	);

	alu ALU0(
		
		.A(B),
		.B(Bus1),
		.ALU_Sel(ALU_Sel),
		.Result(ALU_Result),
		.NZVC(NZVC)
	
	);

	register CCR0(
		
		.Reg_Out(CCR_Result),
		.clk(clk),
		.load(CCR_Load),
		.reset(reset),
		.Reg_In(NZVC)
	
	);

endmodule
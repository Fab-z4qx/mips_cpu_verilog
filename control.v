`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:50:45 01/15/2016 
// Design Name: 
// Module Name:    control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module control(op, PC, mem_read, mem_reg, mem_write, alu_src, reg_write, alu_ctrl );

input [4:0] op;

output reg[3:0] alu_ctrl;
output reg[2:0] PC;

output reg mem_read;
output reg mem_reg;
output reg mem_write;
output reg alu_src;
output reg reg_write;

integer i;
initial begin

	for(i=0;i<=3;i= i+1)begin
		alu_ctrl[i]<=0;
	end
	for(i=0;i<=2;i= i+1)begin
		PC[i]<=0;
	end
	
	mem_read <= 0;
	mem_reg <= 0;
	mem_write <= 0;
	alu_src <= 0;
	reg_write <= 0;

end


//Type-R
parameter ADD = 'd0;
parameter SUB = 'd1;
parameter MUL = 'd2;
parameter AND = 'd3;
parameter OR  = 'd4;

//Type memory
parameter LBD = 'd10;
parameter LDW = 'd11;
parameter STB = 'd12;
parameter STW = 'd13;
parameter MOV = 'd14;

//Brench instruction
parameter BEQ = 'd30;
parameter JUMP = 'd31;

//Others
parameter TLBWRITE = 'd32;
parameter IRET = 'd33;


always @(op)
	begin
		case(op)
		// ====== R -type ===== //	
			ADD:begin
				alu_ctrl <= 0;
		end
			SUB:begin
				alu_ctrl <= 1;
		end
			MUL:begin
				alu_ctrl <= 2;
		end
			AND:begin
				alu_ctrl <= 3;
		end
			OR:begin
				alu_ctrl <= 4;
		end
		// ===== Memory instruction ===== //
			LBD:begin
		end
			LDW:begin
		end
			STB:begin
		end
			STW:begin
		end
			MOV:begin
		end
		//===== Branch instruction ===== //
			BEQ:begin
		end
			JUMP:begin
		end
		//====== Others instruction =====//
			TLBWRITE:begin
		end
			IRET:begin
		end
		default:begin
			$display("Error: undefined opcode: %d",op) ;
		end
	endcase
end	
endmodule

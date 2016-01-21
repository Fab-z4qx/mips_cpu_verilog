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
module control(clk, op, reg_dest, branch, mem_read, mem_to_reg, alu_ctrl, mem_write, alu_src, reg_write, hold, unhold );

input [5:0] op;
input clk;

output reg reg_dest;
output reg branch;
output reg mem_read;
output reg mem_to_reg;
output reg[3:0] alu_ctrl;
output reg mem_write;
output reg alu_src;
output reg reg_write;

output reg hold;
input unhold;


initial begin
	alu_ctrl <= 3'b0;	
	alu_ctrl <= 4'b0;
	reg_dest <= 0;
	branch <= 0;
	mem_read <= 0;
	mem_to_reg <= 0;
	mem_write <= 0;
	alu_src <= 0;
	reg_write <= 0;
	hold <= 0;
	
end


//Type-R
parameter ADD = 'd0;
parameter SUB = 'd1;
parameter MUL = 'd2;
parameter AND = 'd3;
parameter OR  = 'd4;
parameter ADDI= 'd5;

//Type memory
parameter LBD = 'd10;
parameter LDW = 'd11;

parameter STB = 'd12;
parameter STW = 'd13;
parameter MOV = 'd14;

//Brench instruction
parameter BEQ = 'd20;
parameter JUMP = 'd21;

//Others
parameter TLBWRITE = 'd30;
parameter IRET = 'd31;

always @(*)begin
//if(i%2==0) begin
	if((op>=0) && (op<5))begin
		reg_dest <=   1;
		alu_src <=    0;
		mem_to_reg <= 0;
		reg_write <=  1;
		mem_read <=   0;
		mem_write <=  0;
		branch <=     0;
	end
	if(op == 5) begin
		reg_dest <=   0;
		alu_src <=    1;
		mem_to_reg <= 0;
		reg_write <=  0;
		mem_read <=   0;
		mem_write <=  0;
		branch <=     0;
	end
	else if(op == 10 || op == 11) begin
		reg_dest <=   0;
		alu_src <=    1;
		mem_to_reg <= 1;
		reg_write <=  1;
		mem_read <=   1;
		mem_write <=  0;
		branch <=     0;
	end
	else if(op ==12 || op == 13 || op == 14) begin
		reg_dest <=   0;
		alu_src <=    1;
		mem_to_reg <= 0;
		reg_write <=  0;
		mem_read <=   0;
		mem_write <=  1;
		branch <=     0;
	
	end
	else if(op == 20|| op == 21) begin
		reg_dest <=   0;
		alu_src <=    0;
		mem_to_reg <= 0;
		reg_write <=  0;
		mem_read <=   0;
		mem_write <=  0;
		branch <=     1;
	end
	
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
			//alu op => maybe do the calcul here
		end
			JUMP:begin
		end
		//====== Others instruction =====//
			TLBWRITE:begin
		end
			IRET:begin
		end
		default:begin
			$display("Control Error: undefined opcode: %d",op) ;
		end
	endcase
	$display("Control value: \n reg_dest:%d \n mem_to_reg:%d \n reg_write:%d\n mem_read:%d \n mem_write:%d \n branch:%d \n",reg_dest, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch);
//end
end	
endmodule

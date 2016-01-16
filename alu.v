`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:54:23 01/16/2016 
// Design Name: 
// Module Name:    alu 
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
module alu(control, oper1, oper2, result, overflow, zero);

parameter ADD = 0;
parameter SUB = 1;
parameter MUL = 2;
parameter AND = 3;
parameter OR = 4;

	input [3:0] control;
	input [31:0] oper1;
	input [31:0] oper2;
	
	output reg [31:0] result;
	output reg overflow;
	output reg zero;
	
	integer i;
	initial begin
		for(i=0; i<32; i= i+1) begin
			result <=0;
		end
		overflow <= 0;
		zero <= 0;
	end

	always @(control)
	begin
		case(control)
		ADD : //ADD
			begin
				result = oper1 + oper2; 
				overflow 	= 0;
				zero		= (result == 0) ? 1 : 0;
			end
		SUB : //SUB
			begin
				result = oper1 - oper2;
				overflow 	= 0;
				zero		= (result == 0) ? 1 : 0;
			end
		MUL : //MUL
			begin
				result = oper1 * oper2;
				overflow 	= 0;
				zero		= (result == 0) ? 1 : 0;
			end
		AND : //AND
			begin
				result = oper1 & oper2;
				overflow 	= 0;
				zero		= (result == 0) ? 1 : 0;
			end
		OR: //OR
			begin
				result = oper1 | oper2;
				overflow 	= 0;
				zero		= (result == 0) ? 1 : 0;
			end
		10: //LDB
			begin
				result = oper1 - oper2;
			end
		11: //LBW
			begin
				result = oper1 - oper2;
			end
		12: //STB
			begin
				result = oper1 - oper2;
			end
		13: //STW
			begin
				result = oper1 - oper2;
			end
		14: //MOV
			begin
				result = oper1 - oper2;
			end
		30: //BEQ
			begin
				result = oper1 - oper2;
			end
		31: //JUMP
			begin
				result = oper1 - oper2;
			end
		32: //TLBWRITE
			begin
				result = oper1 - oper2;
			end
		33: //IRET
			begin
				result = oper1 - oper2;
			end
	endcase
	end

endmodule

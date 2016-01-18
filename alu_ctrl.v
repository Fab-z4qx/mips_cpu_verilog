`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:04:16 01/16/2016 
// Design Name: 
// Module Name:    alu_ctrl 
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


module alu_control(clk, Op_from_control, fonction, ctrl_command);

parameter ADD = 0;
parameter SUB = 1;
parameter MUL = 2;
parameter AND = 3;
parameter OR  = 4;

input clk;
input     [3:0] Op_from_control;
input     [5:0] fonction;
output reg[3:0] ctrl_command;


integer i;
initial 
begin
	for(i =0; i<=3; i=i+1)
	begin
		ctrl_command[i] <= 0;
	end
end

always @(posedge clk) begin
	case(Op_from_control)
		ADD:begin
			ctrl_command <= ADD;
		end
		SUB:begin
			ctrl_command <= SUB;
		end
		MUL:begin
			ctrl_command <= MUL;
		end
		AND:begin
			ctrl_command <= AND;
		end
		OR:begin
			ctrl_command <= OR;
		end
	default begin ctrl_command <= ADD; end
	endcase
	$display("ALU Control: opcode_received : %d",Op_from_control);
end

endmodule

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


module alu_control(ALUOp, fonction, ctrl_command );

parameter ADD = 0000;
parameter SUB = 0001;
parameter MUL = 0010;
parameter AND = 0110;
parameter OR  = 0111;

input     [3:0] ALUOp;
input     [5:0] fonction;
output reg[3:0] ctrl_command;


integer i;
initial 
begin
	for(i =0; i<3; i=i+1)
	begin
		ctrl_command[i] <= 0;
	end
end

/*always @(*) begin
		case(funct[5:0])
			4'd0:  _funct = 4'd2;	
			4'd2:  _funct = 4'd6;	
			4'd5:  _funct = 4'd1;
			4'd6:  _funct = 4'd13;	
			4'd7:  _funct = 4'd12;	
			4'd10: _funct = 4'd7;	
			default: _funct = 4'd0;
		endcase
end
*/

always @(*) begin
	case(ALUOp)
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
	endcase
end


endmodule

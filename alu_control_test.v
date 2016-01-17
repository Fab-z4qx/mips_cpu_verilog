`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:43:00 01/17/2016 
// Design Name: 
// Module Name:    alu_control_test 
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
module alu_control_test();

reg [3:0]opcode;
reg [5:0]fonction;

wire[3:0]output_from_alu_control;

integer i;
initial begin
	for(i=0; i<=5; i=i+1)
	begin
		//op_from_control[i] <= 0;
		fonction[i] <= 0;
	end
	
	opcode[0] <= 0;
	opcode[1] <= 0;
	opcode[2] <= 0;
	opcode[3] <= 0;
end

alu_control alu_ctrl(
.Op_from_control(opcode), 
.fonction(fonction), 
.ctrl_command(output_from_alu_control) 
);

endmodule

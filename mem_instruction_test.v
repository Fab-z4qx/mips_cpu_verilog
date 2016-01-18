`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:20:40 01/17/2016 
// Design Name: 
// Module Name:    mem_instruction_test 
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
`include "mem_instruction.v"

module mem_instruction_test();

reg  clk;
reg  [31:0] address;
wire [31:0] instruction;

initial begin
	clk <= 0;
	address <= 0;
end

always begin
	#500 clk = ~clk;
	address <= address +4;
end

mem_instruction mem_instu(
.clk(clk), .
address(address), 
.instruction(instruction)
);

endmodule

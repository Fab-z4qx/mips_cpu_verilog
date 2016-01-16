`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:03:28 01/15/2016 
// Design Name: 
// Module Name:    mem_instruction 
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
module mem_instruction(clk, address, instruction);

input clk;
input [7:0] address;
output reg [31:0] instruction;

reg	[7:0]	memAddr;
reg	[31:0] Imem[0:512];

initial
// Read the memory contents in the file Prog.bin
	$readmemb ("Prog.bin.txt", Imem);

	always @(posedge clk)
	begin
		memAddr = address;
		instruction = Imem[memAddr];
	end

endmodule

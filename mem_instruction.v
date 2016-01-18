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
input [31:0] address;
output [31:0] instruction;

reg	[31:0] Imem[0:512];

initial begin
// Read the memory contents in the file Prog.bin
	//$readmemh("v.out",MEM, 32, 64) from 32 to 64 
	//Maybe do a boot loader here to load the memory
	$readmemb ("Prog.bin.txt", Imem);
end

//always begin $display("Instruction mem : %d ",address) ; end

assign instruction=Imem[address[10:2]];

endmodule

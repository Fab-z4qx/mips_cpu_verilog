`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:12:21 01/21/2016 
// Design Name: 
// Module Name:    jump_unit_test 
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
module jump_unit_test(clk, command, jump_addr, pc_addr, output_addr);

output reg clk;
output reg command;
output reg [31:0] jump_addr;
output reg [31:0] pc_addr;
input wire [31:0] output_addr;

initial begin
	#10000;
	command <= 1;
	pc_addr <= 10;
	jump_addr <= 20;
end

always @(*) begin
	#500 clk = ~clk;
end

add_jump_unit jump_unit(
.clk(clk),
.branch_command(command) , 
.sign_extand(jump_addr), 
.pc_addr(pc_addr), 
//output
.jump_addr(output_addr)
);

endmodule

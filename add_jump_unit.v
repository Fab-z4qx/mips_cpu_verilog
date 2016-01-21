`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:16:30 01/21/2016 
// Design Name: 
// Module Name:    add_jump_unit 
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
module add_jump_unit(clk, branch_command , sign_extand, pc_addr, jump_addr);

input clk;
input branch_command;
input [31:0] sign_extand;
input [31:0] pc_addr;

output reg [31:0] jump_addr;

assign sign_extand = sign_extand << 2;

initial begin
	jump_addr = 32'b0;
end

always @(*) begin
	if(branch_command) begin
		jump_addr <= jump_addr + sign_extand;
	end
end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:03:41 01/16/2016 
// Design Name: 
// Module Name:    mem_data 
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
module mem_data(clk, addr, rd, wr, wdata, rdata);

input wire clk;
input wire [6:0] addr;
input wire rd, wr;
input wire [31:0] wdata;
output wire [31:0] rdata;

	reg[31:0] mem[0:127];
	
	integer i;
	initial begin
		for(i=0; i<=127; i=i+1)begin
			mem[i] <= 0;
		end
	end
	
	always @(posedge clk) begin
		if (wr) begin
			mem[addr] <= wdata;
		end
	end

	assign rdata = wr ? wdata : mem[addr];

endmodule

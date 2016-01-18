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
module mem_data(clk, addr, mem_read_control, write_data_control, wdata, rdata);

input wire clk;
input wire [31:0] addr;
input wire mem_read_control, write_data_control;
input wire [31:0] wdata;
output wire [31:0] rdata;

	reg[31:0] mem[0:127];
	
	integer i;
	initial begin
		for(i=0; i<=127; i=i+1)begin
			mem[i] <= 0;
		end
		mem[0] <= 0;
		mem[1] <= 2;
		mem[2] <= 5;
		mem[3] <= 4;
	end
	
	always @(posedge clk) begin
	$display("Memory Data: Writing of the value %d in %d",wdata, addr);
		if (write_data_control) begin
			mem[addr] <= wdata;
		end
	end
	
	assign rdata = write_data_control ? wdata : mem[addr];

endmodule

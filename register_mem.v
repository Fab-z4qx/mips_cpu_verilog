`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:53:32 01/15/2016 
// Design Name: 
// Module Name:    register_mem 
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
//

//http://web-ext.u-aizu.ac.jp/~yliu/teaching/comparch/lab2.html

//INPUT
// 1bit  clk = clock 										
// 5bit  r_reg => read in register1
// 5bit  r_reg2 => read the register2
// 5bit  w_in_reg => address of reg where i want to write
// 32bit w_data => data i want to write
// 1bit  reg_w => ctrl for write value
//OUTPUT
// 32bit r_data1 and r_data2 output of register 
// 1bit  clr => clear all registers

module register_mem(clk, r_reg1, r_reg2, w_reg_addr, w_data, reg_w, r_data1, r_data2, clr);

input clk;
input [4:0] r_reg1, r_reg2; //input addr reg to read
input	[4:0] w_reg_addr;		//write reg addr
input	[31:0] w_data;			//write data in the reg
input	reg_w;					//1 bit to regWrite condition
output [31:0] r_data1;
output [31:0] r_data2; // output

//option
input clr;

//32 reg of 32 bit
reg [31:0] mem[0:31];

assign r_data1 = mem[r_reg1];
assign r_data2 = mem[r_reg2];

integer i;
	initial begin
		for(i = 0; i <32; i = i+1)begin
			  mem[i] <= 0;
		end
		mem[1] <= 4;
		mem[2] <= 3;
	end
	
	always @(posedge clk) 
	begin
		$display("Registers: r%d = %d",w_reg_addr,w_data);
		if (reg_w) begin
			mem[w_reg_addr] <= w_data;
		end
		if (clr) begin
			for(i =0; i<32; i = i+1) begin
				mem[i] <= 0;
			end
		end
		 
	end
endmodule

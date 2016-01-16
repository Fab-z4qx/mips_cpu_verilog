`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:02:52 01/15/2016 
// Design Name: 
// Module Name:    register_test 
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
`include "register_mem.v"

module register_test();

reg clk;

	reg [4:0]r_reg1;
	reg [4:0]r_reg2;
	reg [4:0]w_reg_addr;
	
	reg [31:0]w_data;
	reg reg_w;
	
	wire [31:0]r_data1;
	wire [31:0]r_data2;
	reg clr;
	/*
	wire [4:0]r_reg1;
	wire [4:0]r_reg2;
	wire [4:0]w_reg_addr;
	wire [31:0]w_data;
	wire reg_w;
	wire [31:0]r_data1;
	wire [31:0]r_data2;
	wire clr;*/
	/*assign r_reg1 = 0;
	assign r_reg2 = 1;
	assign w_reg_addr = 0;
	assign w_data = 0;
	assign r_data1 = 0;
	assign r_data2 = 0;
	assign reg_w = 0;
	assign clr = 0;*/

/*
always begin
	  clk <= 1;
	  #1000;
	  clk <= 0;
	  #1000;
	  
	  r_reg1 <= 0;
	  r_reg2 <= 1;
	  w_reg_addr <= 0;
	  w_data <= 0;
	  r_data1 <= 0;
	  r_data2 <= 0;
	  reg_w <= 0;
	  clr <= 0;
end
*/
integer i;
initial begin 
	clk = 1; 
	i = 0;
	r_reg1 <= 0;
	r_reg2 <= 0;
	w_reg_addr <= 0;
	w_data <= 0;
	//r_data1 <= 0;
	//r_data2 <= 0;
	reg_w <= 0;
	clr <= 0;
end

always begin
	#(500) clk = ~clk; 
	
	if(i == 1) begin
		 reg_w <= 1;
		 w_data <= 1256;
		 w_reg_addr <= 1;
	end
	else if(i == 3)begin 
		 reg_w <= 0;
		 w_data <= 0;
		 w_reg_addr <= 0;
		 r_reg1 <= 1;
	end
	if(i == 5) begin
		 reg_w <= 1;
		 w_data <= 1256;
		 w_reg_addr <= 15;
	end
	
	i = i+1;
end

	//#(500) clk = ~clk; 
	/*clk <= 1;
	reg_w <= 1;
	w_data <= 1256;
	w_reg_addr <= 3;
	#200;
	reg_w <= 0;
	w_data <= 0;
	w_reg_addr <= 0;
	#200
	r_reg1 <= 3;

*/
//clk <= 1;
	  
	  /*  force reg_w = 1;
		 force w_data = 1256;
		 force w_reg_addr = 3;
	  #200;
		 force reg_w = 0;
		 force w_data = 0;
		 force w_reg_addr = 0;
	  #200;
	    force r_reg1 = 3;*/
	 /* #200;
		 force r_reg2 = 3;
	  #200;
		force reg_w = 1;
		force w_data = 1111;
		force w_reg_addr = 5;
	  #200;
		force reg_w = 1;
		force w_data = 5555;
		force w_reg_addr = 10;
	  #200;
		force reg_w = 0;
		force w_data = 0;
		force w_reg_addr = 0;
		force r_reg1 = 10;
		force r_reg2 = 5; */
		
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

register_mem reg_mem(
.clk(clk),
//input
.r_reg1(r_reg1),
.r_reg2(r_reg2),
.w_reg_addr(w_reg_addr),
.w_data(w_data),
.reg_w(reg_w),
//output to alu
.r_data1(r_data1),
.r_data2(r_data2),
//option 
.clr(clr)
);

//module register_mem(clk, r_reg1, r_reg2, w_in_reg, w_data, reg_w, r_data1, r_data2, clr);

endmodule

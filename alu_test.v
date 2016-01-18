`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:31:28 01/16/2016 
// Design Name: 
// Module Name:    alu_test 
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


module alu_test();


reg [3:0]  alu_ctrl;
reg [31:0] r_data1;
reg [31:0] r_data2;

wire [31:0] alu_result; 
wire alu_overflow;
wire alu_zero;

integer i;
initial begin
	for(i=0; i<32; i=i+1)begin
		if(i<3)begin alu_ctrl <= 0; end
		r_data1[i] <= 0;
		r_data2[i] <= 0;
	end
	r_data1 <= 1;
	r_data2 <= 1;
	alu_ctrl <= 0;//add test
end

alu alu(
//input
.control(alu_ctrl), 
.oper1(r_data1), 
.oper2(r_data2), 
//output
.result(alu_result), 
.overflow(alu_overflow), 
.zero(alu_zero)
);


endmodule

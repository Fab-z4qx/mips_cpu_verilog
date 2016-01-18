`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:37:46 01/16/2016 
// Design Name: 
// Module Name:    control_test 
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
`include "control.v"
module control_test();

reg [5:0] opcode;
reg clk;

wire reg_dest;
wire [3:0] alu_ctrl;
wire PC;
wire mem_read;
wire mem_reg;
wire mem_write;
wire alu_src;
wire reg_write;

control ctrl(
.clk(clk),
.op(opcode),
//output
.reg_dest(reg_dest), 
.branch(PC), 
.mem_read(mem_read), 
.mem_to_reg(mem_reg), 
.mem_write(mem_write), 
.alu_src(alu_src), 
.reg_write(reg_write), 
.alu_ctrl(alu_ctrl)
);

initial opcode <= 0; 

always #500 clk = ~clk;

endmodule

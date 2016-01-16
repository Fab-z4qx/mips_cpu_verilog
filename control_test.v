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


control ctrl
(op, 
PC, 
mem_read, 
mem_reg, 
mem_write, 
alu_src, 
//output
reg_write, 
alu_ctrl );


endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:07:09 01/17/2016 
// Design Name: 
// Module Name:    mux_register_alu 
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
module mux_register_alu(input [31:0] in_a, input [15:0] in_b, input in_select, output [31:0]out_z);

assign out_z = (in_select == 0) ? in_a : in_b;

endmodule


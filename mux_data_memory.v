`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:57:24 01/17/2016 
// Design Name: 
// Module Name:    mux_data_memory 
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
module mux_data_memory(input [31:0] in_a, input [31:0] in_b, input in_select, output [31:0]out_z);

assign out_z = (in_select == 0) ? in_a : in_b;

endmodule

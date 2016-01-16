`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:05:40 01/14/2016 
// Design Name: 
// Module Name:    cpu 
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
`include "PC.v"
`include "mem_instruction.v"
`include "control.v"
`include "register_mem.v"

module cpu();
	reg clk;
	//reg  [7:0] first_addr = 4096;
	reg  [7:0] first_addr = 0;
	wire [7:0] pc_to_addr;
	wire [31:0] instruction;
	wire [31:0]w_data;
	
	wire reg_write;
	
	wire [5:0]op;
	wire [4:0]r_reg1;
	wire [4:0]r_reg2;
	wire [4:0]w_in_reg;
	//wire IMM_OP;
	wire [15:0]imm;
	wire [4:0]shamt;
	
	//connect to alu
	//wire r_data1 [31:0];
	//wire r_data2 [31:0];
	//	wire rst[4:0];
	//	wire IMM_OP[0:15];
	
	assign op       = instruction[31:26];  // opcode field
   assign r_reg1   = instruction[25:21];  //source register 1
	assign r_reg2   = instruction[20:16];  // source register 2
	assign w_in_reg = instruction[15:11];  // destination register
	assign imm      = instruction[15:0];   //imedia option
	assign shamt	 = instruction[10:6];
	
	wire [31:0]r_data1;
	wire [31:0]r_data2;
	//assign w_data = sortieMux;

	//assign rs2 = instruction[15:11]; //source register 2
	//assign rst = instruction[15:11]; //source register for store op
	
	//assign IMM_OP  = instruction[16];  // IR[16]==1 when source 2 is immediate operand
	assign immed16 = instruction[15:0];
	
	
	//ALU CONTROL WIRE
	wire [3:0] alu_ctrl;
	//wire fonction
	//wire control_command
	
	// ALU WIRE 
	wire [31:0] alu_result;
	wire overflow;
	wire alu_zero;

												
initial 
begin
    clk = 0;
end
  
always begin
	  clk <= 0;
	  #1000;
	  clk <= 1;
	  #1000;
end

PC pc_unit(
.clk(clk),
.in_addr(pc_to_addr),
.out_addr(pc_to_addr)
);

mem_instruction memI(
.clk(clk),
.address(pc_to_addr),
.instruction(instruction)
);

register_mem reg_mem(
.clk(clk),
//input
.r_reg1(r_reg1),
.r_reg2(r_reg2),
.w_reg_addr(w_in_reg),
.w_data(w_data),
.reg_w(reg_write),
//output to alu
.r_data1(r_data1),
.r_data2(r_data2),
//option 
.clr()
);

control control(
//input
.op(op),
//output
.reg_dest(reg_dest), 
.branch(PC), 
.mem_read(mem_read), 
.mem_to_reg(mem_reg),
.alu_ctrl(alu_ctrl),  
.mem_write(mem_write), 
.alu_src(alu_src), 
.reg_write(reg_write) 
);


alu_control alu_c (
.ALUOp(alu_ctrl),
.fonction(),
.ctrl_command()
);



alu alu(
.control(alu_ctrl), 
.oper1(r_data1), 
.oper2(r_data2), 
.result(alu_result), 
.overflow(alu_overflow), 
.zero(alu_zero)
);



endmodule

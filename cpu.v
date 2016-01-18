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
	wire [31:0] pc_to_addr;
	wire [31:0] instruction;
	
	wire [5:0]op;
	wire [4:0]r_reg1;
	wire [4:0]r_reg2;
	wire [4:0]w_in_reg;
	//wire IMM_OP;
	//wire [15:0]imm;
	wire [31:0]sign_extand;
	wire [4:0]shamt;
	wire [5:0]fonction;
	
	//connect to alu
	//wire r_data1 [31:0];
	//wire r_data2 [31:0];
	//	wire rst[4:0];
	//	wire IMM_OP[0:15];
	
	assign op       = instruction[31:26];  // opcode field
   assign r_reg1   = instruction[25:21];  //source register 1
	assign r_reg2   = instruction[20:16];  // source register 2
	assign w_in_reg = instruction[15:11];  // destination register
	//assign imm      = instruction[15:0];   //imedia option
	
	assign sign_extand = instruction[15:0];
	assign shamt	 = instruction[10:6];
	assign fonction = instruction[5:0];
	
	wire [31:0]r_data1_from_reg;
	wire [31:0]r_data2_from_reg;
	//assign w_data = sortieMux
	//assign rs2 = instruction[15:11]; //source register 2
	//assign rst = instruction[15:11]; //source register for store op
	//assign IMM_OP  = instruction[16];  // IR[16]==1 when source 2 is immediate operand
	//assign immed16 = instruction[15:0];
	
	//wire Control output 
	wire reg_dest_control;
	wire PC_control;
	wire mem_reg_control;
	wire [3:0] alu_ctrl_op_from_control;
	wire mem_write_control;
	wire alu_src_control;
	wire reg_write_control;
	
	//ALU CONTROL WIRE output
	wire [3:0] alu_control_from_alu_control;
	
	//Mux reg to alu 
	wire [31:0] mux_register_to_alu_wire;
	
	//wire fonction
	//wire control_command
	
	// ALU WIRE 
	wire [31:0] alu_result;
	wire overflow;
	wire alu_zero;
	
	//wire MUX Register Memory
	wire [4:0] mux_write_addr_in_reg;
	
	//wire MUX Data Memory
	wire [31:0]mux_to_w_data_reg;
	wire [31:0]readed_data_from_data_memory;

integer i;					
initial 
begin
    clk = 0;
	 i = 0;
end

always begin
	  if(i>0);
	  #1000 clk <= ~ clk;
	  
	  i=i+1;
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

mux_reg mux_reg_entree(
.in_a(r_reg2),
.in_b(w_in_reg),
.in_select(reg_dest_control),
.out_z(mux_write_addr_in_reg)
);

register_mem reg_mem(
.clk(clk),
//input
.r_reg1(r_reg1), //addr of reg1
.r_reg2(r_reg2), //addr of reg2
.w_reg_addr(mux_write_addr_in_reg), //addr to write
.w_data(mux_to_w_data_reg), //data to write 
//w_data ???
.reg_w(reg_write_control), //control
//output to alu
.r_data1(r_data1_from_reg),
.r_data2(r_data2_from_reg),
//option 
.clr()
);

mux_register_alu mux_register_to_alu(
.in_a(r_data2_from_reg),
.in_b(sign_extand),
.in_select(alu_src_control),
.out_z(mux_register_to_alu_wire)
);

control control(
//input
.clk(clk),
.op(op),
//output
.reg_dest(reg_dest_control), 
.branch(PC_control), 
.mem_read(mem_read_control), 
.mem_to_reg(mem_reg_control),
.alu_ctrl(alu_ctrl_op_from_control),  
.mem_write(mem_write_control), 
.alu_src(alu_src_control), 
.reg_write(reg_write_control) 
);

alu_control alu_c (
.clk(clk),
.Op_from_control(alu_ctrl_op_from_control), //control from general controls
.fonction(fonction),
//output
.ctrl_command(alu_control_from_alu_control) //output => COMMAND ALU
);

alu alu(
.clk(clk),
.control(alu_control_from_alu_control), //4bit Command from alu_control 
.oper1(r_data1_from_reg), //32bit Value 1
.oper2(mux_register_to_alu_wire), //32bit Value 2
//output
.result(alu_result),     //32bit output
.overflow(alu_overflow), //1bit overflow
.zero(alu_zero)			//1bit zero
);

mux_data_memory mux_data_memory_to_reg(
.in_a(readed_data_from_data_memory),
.in_b(alu_result),
.in_select(mem_reg_control),
.out_z(mux_to_w_data_reg)
);

mem_data mem_data(
.clk(clk),        		//clk 1bit
.addr(alu_result), 		//addr 32bit 
.mem_read_control(mem_read_control),    //mem_read control 1bit 
.write_data_control(mem_write_control), // write_data control 1bit 
.wdata(r_data2_from_reg),			// data to write 32bit
.rdata(readed_data_from_data_memory)				//data readed 32 bit
);

endmodule

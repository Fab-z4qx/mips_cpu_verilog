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
	
	wire [31:0]r_data1_from_reg;
	wire [31:0]r_data2_from_reg;
	
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
	
	assign op       = instruction[31:26];  // opcode field
   assign r_reg1   = instruction[25:21];  //source register 1
	assign r_reg2   = instruction[20:16];  // source register 2
	assign w_in_reg = instruction[15:11];  // destination register
	//assign imm      = instruction[15:0];   //imedia option
	
	assign sign_extand = instruction[15:0];
	assign shamt	 = instruction[10:6];
	assign fonction = instruction[5:0];
	
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
	
   wire reg_dest_control_pipe;
	wire PC_control_pipe;
	wire mem_read_control_pipe;
	wire mem_reg_control_pipe;
	wire [3:0] alu_ctrl_op_from_control_pipe;
	wire mem_write_control_pipe;
	wire alu_src_control_pipe;
	wire reg_write_control_pipe;
	
	wire stall_ID_EX_CONTROL;
	
	wire mem_reg_control_from_MEM_WB;
	wire [31:0] readed_data_from_memory_MEM_WB;
	wire [31:0] r_data2_from_Dmemory_MEM_WB;
	wire [4:0]  write_addr_in_reg_from_MEM_WB;
	wire [31:0] alu_result_from_MEM_WB;
	wire [4:0] write_addr_in_reg_from_MEM_WB_ADDR;
	wire reg_write_control_pipe_MEM_WB;

initial 
begin
    clk = 0;
	 #10000000;
end

always begin
	  #1000 clk <= ~ clk;	  
end

PC pc_unit(
.clk(clk),
.in_addr(pc_to_addr),
.out_addr(pc_to_addr)
);


wire [31:0] instruction_to_pipeline_IF_ID;
wire stall_IF_ID;
wire clear_IF_ID;
 
mem_instruction memI(
.clk(clk),
.address(pc_to_addr),
.instruction(instruction_to_pipeline_IF_ID)
);

reg_pipe #(.N(32)) IF_ID(.clk(clk),
					.hold(stall_s1_s2), .clear(flush_s1),
					.in(instruction_to_pipeline_IF_ID), .out(instruction));


register_mem reg_mem(
.clk(clk),
//input
.r_reg1(r_reg1), //addr of reg1
.r_reg2(r_reg2), //addr of reg2
//.w_reg_addr(mux_write_addr_in_reg), //addr to write
//.w_reg_addr(write_addr_in_reg_from_MEM_WB_ADDR),
.w_reg_addr(write_addr_in_reg_from_MEM_WB),
.w_data(mux_to_w_data_reg), //data to write 
//w_data ???
.reg_w(reg_write_control_pipe), //control
//output to alu
.r_data1(r_data1_from_reg),
.r_data2(r_data2_from_reg),
//option 
.clr()
);

wire stall_ID_EX_REG;
wire [31:0] r_data1_from_ID_EX_REG;
wire [31:0] r_data2_from_ID_EX_REG;
wire [4:0] write_addr_in_reg_from_ID_EX_REG;
wire [31:0] sign_extand_ID_EX_REG;
wire [4:0] r_reg2_ID_EX_REG;

reg_pipe #(.N(106)) ID_EX_REG(.clk(clk), .clear(stall_ID_EX), .hold(1'b0),
			.in({r_data1_from_reg, r_data2_from_reg,r_reg2, w_in_reg, sign_extand }),
			.out({r_data1_from_ID_EX_REG, r_data2_from_ID_EX_REG, r_reg2_ID_EX_REG, write_addr_in_reg_from_ID_EX_REG, sign_extand_ID_EX_REG}));
			
		
mux_reg mux_reg_rdest(
.in_a(r_reg2_ID_EX_REG),
.in_b(write_addr_in_reg_from_ID_EX_REG),
.in_select(reg_dest_control_pipe),
.out_z(mux_write_addr_in_reg)
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

reg_pipe #(.N(11)) ID_EX_CONTROL(.clk(clk), .clear(stall_ID_EX_CONTROL), .hold(1'b0),
			.in({reg_dest_control, 
			PC_control, 
			mem_read_control, 
			mem_reg_control,
			alu_ctrl_op_from_control,
			mem_write_control,
			alu_src_control,
			reg_write_control }),
			
			.out({reg_dest_control_pipe,
			PC_control_pipe,
			mem_read_control_pipe,
			mem_reg_control_pipe,
			alu_ctrl_op_from_control_pipe,
			mem_write_control_pipe, 
			alu_src_control_pipe, 
			reg_write_control_pipe}));

wire [31:0]bypass_1_cycle_out_reg1;
wire [31:0]bypass_1_cycle_out_reg2;


mux_register_alu mux_register_to_alu(
.in_a(r_data2_from_ID_EX_REG),
.in_b(sign_extand_ID_EX_REG),
.in_select(alu_src_control_pipe),
.out_z(mux_register_to_alu_wire)
);

alu_control alu_c (
.clk(clk),
//.Op_from_control(alu_ctrl_op_from_control_pipe), //control from general controls
.Op_from_control(alu_ctrl_op_from_control),
.fonction(fonction),
.reg1(),
.reg2(), 
.outreg1(),
.outreg2(),
//.outreg2(bypass_1_cycle_out_reg2),
//output
.ctrl_command(alu_control_from_alu_control) //output => COMMAND ALU
);

alu alu(
.clk(clk),
.control(alu_control_from_alu_control), //4bit Command from alu_control 
.oper1(r_data1_from_ID_EX_REG), //32bit Value 1
.oper2(mux_register_to_alu_wire), //32bit Value 2

//.oper1(bypass_1_cycle_out_reg1),
//.oper2(bypass_1_cycle_out_reg2), //32bit Value 2

//output
.result(alu_result),     //32bit output
.overflow(alu_overflow), //1bit overflow
.zero(alu_zero)			//1bit zero
);


wire [31:0] alu_result_from_EX_MEM;
wire [31:0] r_data2_from_EX_MEM;
wire mem_read_control_from_EX_MEM;
wire mem_write_control_from_EX_MEM;
wire mem_reg_control_from_EX_MEM;
wire reg_write_control_pipe_EX_MEM;
wire [4:0] write_addr_in_reg_from_EX_MEM;
 
reg_pipe #(.N(73)) EX_MEM(.clk(clk), .clear(stall_EX_MEM), .hold(1'b0),
		.in({alu_result, r_data2_from_ID_EX_REG, mem_read_control_pipe, mem_write_control_pipe, mem_reg_control_pipe, mux_write_addr_in_reg, reg_write_control_pipe}),
		.out({alu_result_from_EX_MEM, r_data2_from_EX_MEM, mem_read_control_from_EX_MEM, mem_write_control_from_EX_MEM, mem_reg_control_from_EX_MEM, write_addr_in_reg_from_EX_MEM, reg_write_control_pipe_EX_MEM}));

mem_data mem_data(
.clk(clk),        		//clk 1bit
.addr(alu_result_from_EX_MEM), 		//addr 32bit 
.mem_read_control(mem_read_control_from_EX_MEM),    //mem_read control 1bit 
.write_data_control(mem_write_control_from_EX_MEM), // write_data control 1bit 
.wdata(r_data2_from_EX_MEM),			// data to write 32bit
.rdata(readed_data_from_data_memory)				//data readed 32 bit
);


reg_pipe #(.N(71)) MEM_WB(.clk(clk), .clear(stall_EX_MEM), .hold(1'b0),
		.in({mem_reg_control_from_EX_MEM, alu_result_from_EX_MEM, readed_data_from_data_memory, write_addr_in_reg_from_EX_MEM, reg_write_control_pipe_EX_MEM}),
	  .out({mem_reg_control_from_MEM_WB, alu_result_from_MEM_WB, readed_data_from_memory_MEM_WB, write_addr_in_reg_from_MEM_WB, reg_write_control_pipe_MEM_WB }));

mux_data_memory mux_data_memory_to_reg(
.in_a(readed_data_from_memory_MEM_WB),
.in_b(alu_result_from_MEM_WB),
.in_select(mem_reg_control_from_MEM_WB),
.out_z(mux_to_w_data_reg)
);

/*
reg_pipe #(.N(5)) MEM_WB_ADDR(.clk(clk), .clear(stall_EX_MEM), .hold(1'b0),
		.in({write_addr_in_reg_from_MEM_WB}),
	  .out({write_addr_in_reg_from_MEM_WB_ADDR}));*/

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:30:02 01/16/2016 
// Design Name: 
// Module Name:    mem_data_test 
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
module mem_data_test();

reg clk;
reg [6:0] addr;
reg rd;
reg wr;
reg [31:0] wdata;
wire [31:0] rdata;

integer i;
initial begin
	clk <= 0;
	for(i=0; i<31; i=i+1) begin
		wdata <= 0;
		if(i<6) begin addr <= 0; end
	end
	rd <= 0;
	wr <= 1;
	wdata <= 555000;
	addr <= 2;
	i=0;
end

always begin
#500 clk = ~clk;
	//rd <= 0;
	//addr <= 2;
	/*if(i==1)begin
		wr <= 1;
		wdata <= 10;
		addr <= 2;
	end
	i = i +1;*/
end;

mem_data mem(
.clk(clk),
.addr(addr),
.rd(rd),
.wr(wr),
.wdata(wdata),

//output
.rdata(rdata)
);

endmodule

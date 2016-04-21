`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:02:26 03/22/2016 
// Design Name: 
// Module Name:    lc3 
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
module lc3(
	input wire clk,
	input wire reset,
	input wire halt,
	output wire [15:0] leds,
   output wire [6:0] out,
   output wire [3:0] select,
	output wire [2:0] vga_red,
	output wire [2:0] vga_green,
	output wire [1:0] vga_blue,
	output wire vga_hs,
	output wire vga_vs
);


wire [15:0] IR;
wire [15:0] MAR;
wire [15:0] MDR;
wire [15:0] mem_data;

wire N, Z, P;
wire [1:0] aluControl, selPC, selEAB2;
wire [2:0] SR1, SR2, DR;
wire enaALU;
wire regWE;
wire enaMARM;
wire selMAR;
wire selEAB1;
wire enaPC;
wire ldPC;
wire ldIR;
wire ldMAR;
wire ldMDR;
wire selMDR;
wire memWE;
wire flagWE;
wire enaMDR;
wire enable;
wire [7:0] vga_color;
wire [11:0] vga_addr;


wire cdiv_out;
clock_divider CDIV(
	.clk_in(clk),
	.clk_out(cdiv_out),
	.reset(reset)
);
assign enable = (~halt) & cdiv_out;

//assign enable = 1'b1;

control C(
	.IR(IR),
	.N(N), .Z(Z), .P(P),
	.clk(clk),
	.reset(reset),
	.enable(enable),
	.aluControl(aluControl), //[1:0]
	.enaALU(enaALU),
	.SR1(SR1), //[2:0] 
	.SR2(SR2), //[2:0] 
	.DR(DR), //[2:0] 
	.regWE(regWE),
	.selPC(selPC), //[1:0] 
	.enaMARM(enaMARM),
	.selMAR(selMAR),
	.selEAB1(selEAB1),
	.selEAB2(selEAB2), //[1:0] 
	.enaPC(enaPC),
	.ldPC(ldPC),
	.ldIR(ldIR),
	.ldMAR(ldMAR),
	.ldMDR(ldMDR),
	.selMDR(selMDR),
	.memWE(memWE),
	.flagWE(flagWE),
	.enaMDR(enaMDR)	
);

datapath DP(
	.aluControl(aluControl), //[1:0]
	.enaALU(enaALU),
	.SR1(SR1), //[2:0] 
	.SR2(SR2), //[2:0] 
	.DR(DR), //[2:0] 
	.regWE(regWE),
	.selPC(selPC), //[1:0] 
	.enaMARM(enaMARM),
	.selMAR(selMAR),
	.selEAB1(selEAB1),
	.selEAB2(selEAB2), //[1:0] 
	.enaPC(enaPC),
	.ldPC(ldPC),
	.ldIR(ldIR),
	.ldMAR(ldMAR),
	.ldMDR(ldMDR),
	.selMDR(selMDR),
	.flagWE(flagWE),
	.enaMDR(enaMDR),	
	.MAR(MAR),
	.MDR(MDR),
	.mem_data(mem_data),
	
	.IR(IR),
	.n(N), .z(Z), .p(P),
	.clk(clk),
	.reset(reset)
);

Memory mc(
	.clk(clk),
	.reset(reset),
	.MDR(MDR),
	.MAR(MAR),
	.mem_out(mem_data),
	.memWE(memWE),
	.io(leds),
   .out(out),
   .select(select),
	.vga_color(vga_color),
	.vga_addr(vga_addr)
);

vga V(
	.red_out(vga_red),
	.green_out(vga_green),
	.blue_out(vga_blue),
	.hs(vga_hs),
	.vs(vga_vs),
	.clk50_in(clk),
	.color(vga_color),
	.addr(vga_addr)
);

endmodule

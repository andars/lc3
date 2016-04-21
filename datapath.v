`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:29:43 03/21/2016 
// Design Name: 
// Module Name:    datapath 
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
module datapath(
	input wire [1:0] aluControl,
	input wire [2:0] SR1,
	input wire [2:0] SR2,
	input wire [2:0] DR,
	input wire [1:0] selPC,
	input wire selEAB1,
	input wire [1:0] selEAB2,
	input wire enaALU,
	input wire regWE,
	input wire enaMARM,
	input wire selMAR,
	input wire enaPC,
	input wire ldPC,
	input wire ldIR,
	input wire ldMAR,
	input wire ldMDR,
	input wire selMDR,
	input wire enaMDR,
	input wire flagWE,
	output wire [15:0] IR,
	output wire n,
	output wire z,
	output wire p,
	output wire [15:0] MAR,
	output wire [15:0] MDR,
	input wire [15:0] mem_data,
	input wire clk,
	input wire reset
);

wire [15:0] bus;
wire [15:0] reg_a;
wire [15:0] reg_b;
wire [15:0] eabOut;
wire [15:0] PC;
wire [15:0] aluOut;
wire [15:0] MARMuxOut;

IR Ir(.IR(IR), .clk(clk), .ldIR(ldIR), .Buss(bus), .reset(reset));

EAB Eab(
	.eabOut(eabOut),
	.IR(IR[10:0]),
	.Ra(reg_a),
	.PC(PC), 
	.selEAB1(selEAB1), 
	.selEAB2(selEAB2)
);

NZP nzp(
	.Buss(bus),
	.N(n),
	.Z(z),
	.P(p),
	.clk(clk),
	.flagWE(flagWE),
	.reset(reset)
);

PC pc(
	.Buss(bus),
	.clk(clk),
	.reset(reset),
	.ldPC(ldPC),
	.eabOut(eabOut),
	.selPC(selPC),
	.PC(PC)
);

ts_driver pc_ts(
	.din(PC),
	.dout(bus),
	.ctrl(enaPC)
);

ALU alu(
	.Ra(reg_a),
	.Rb(reg_b),
	.aluOut(aluOut),
	.aluControl(aluControl),
	.IR(IR[5:0])
);

ts_driver alu_ts(
	.din(aluOut),
	.dout(bus),
	.ctrl(enaALU)
);

MARMux marm(
	.MARMuxOut(MARMuxOut),
	.IR(IR[7:0]),
	.eabOut(eabOut),
	.selMAR(selMAR)
);

ts_driver marm_ts(
	.din(MARMuxOut),
	.dout(bus),
	.ctrl(enaMARM)
);

RegFile rf(
	.Ra(reg_a),
	.Rb(reg_b),
	.Buss(bus),
	.clk(clk),
	.regWE(regWE),
	.reset(reset),
	.DR(DR),
	.SR1(SR1),
	.SR2(SR2)
);

MAR MAR0(
	.Buss(bus),
	.clk(clk),
	.reset(reset),
	.ldMAR(ldMAR), 
	.MAR(MAR)
);

MDR MDR0(
	.Buss(bus),
	.memOut(mem_data),
	.selMDR(selMDR),
	.clk(clk),
	.reset(reset),
	.ldMDR(ldMDR),
	.MDR(MDR)
);



ts_driver mdr_ts(
	.din(MDR),
	.dout(bus),
	.ctrl(enaMDR)
);

endmodule

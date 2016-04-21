`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:58:45 03/14/2016 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
	Ra,
	Rb,
	aluOut,
	aluControl,
	IR
);

input [15:0] Ra;
input [15:0] Rb;
input [5:0] IR;
input [1:0] aluControl;
output [15:0] aluOut;

wire [15:0] input_a;
wire [15:0] input_b;
wire [15:0] imm;

assign imm = { {12{IR[4]}}, IR[4:0] };

assign input_b = IR[5] ? imm : Rb;
assign input_a = Ra;


// "don't forget to include an ALUMux"?

assign aluOut = (aluControl == 0) ? input_a :
					 (aluControl == 1) ? input_a + input_b :
					 (aluControl == 2) ? input_a & input_b :
					 ~input_a;
					 
endmodule

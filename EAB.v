`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:00:57 03/14/2016 
// Design Name: 
// Module Name:    EAB 
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
module EAB(eabOut, IR, Ra, PC, selEAB1, selEAB2);
	input [10:0] IR;
	input [15:0] Ra;
	input [15:0] PC;
	input selEAB1;
	input [1:0] selEAB2;
	output [15:0] eabOut;
	
	wire [15:0] pc_offset9;
	wire [15:0] pc_offset11;
	wire [15:0] offset6;
	wire [15:0] addr2;
	wire [15:0] addr1;
	
	// extract various offsets from IR
	// and sign extend
	assign pc_offset9 = { {7{IR[8]}}, IR[8:0]};
	assign pc_offset11 = { {4{IR[10]}}, IR[10:0]};
	assign offset6 = { {10{IR[5]}}, IR[5:0]};
	
	assign addr2 = (selEAB2 == 0) ? 0 :
						(selEAB2 == 1) ? offset6 :
						(selEAB2 == 2) ? pc_offset9 :
						pc_offset11;
						
	assign addr1 = selEAB1 ? Ra : PC;
	
	assign eabOut = addr1 + addr2;
endmodule

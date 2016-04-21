`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:14:24 03/14/2016 
// Design Name: 
// Module Name:    MARMux 
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
module MARMux(MARMuxOut, IR, eabOut, selMAR);
	input [7:0] IR;
	input [15:0] eabOut;
	input selMAR;
	output [15:0] MARMuxOut;
	
	wire [7:0] zext_ir;
	assign zext_ir = { 8'h0, IR};
	
	assign MARMuxOut = selMAR ? zext_ir : eabOut;
endmodule

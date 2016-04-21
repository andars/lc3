`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:24:39 03/07/2016 
// Design Name: 
// Module Name:    mux41 
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
module mux41(q, a, b, c, d, sel);
	parameter WIDTH=4;
	input [WIDTH-1:0] a, b, c, d;
	input [1:0] sel;
	output [WIDTH-1:0] q;
	
	assign q = (sel == 0) ? a :
				  (sel == 1) ? b :
				  (sel == 2) ? c :
				  d;
endmodule

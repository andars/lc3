`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:06:19 03/07/2016 
// Design Name: 
// Module Name:    mod4 
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
module mod4(clk, reset, incr, q);
	input clk, reset, incr;
	output [1:0] q;
	
	assign n0 = q[0] ^ incr;
	assign n1 = (~incr)&q[1] | q[1] & (~q[0]) | incr & (~q[1]) & q[0];

	ff_dc F0(.q(q[0]), .d(n0), .clr(reset), .clk(clk));
	ff_dc F1(.q(q[1]), .d(n1), .clr(reset), .clk(clk));
endmodule

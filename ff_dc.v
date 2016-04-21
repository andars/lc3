`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:15:19 03/07/2016 
// Design Name: 
// Module Name:    ff_dc 
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
module ff_dc(q, d, clk, clr);
	input clk, d, clr;
	output reg q;
	
	always @(posedge clk)
		if (clr) q <= 0;
		else q <= d;
endmodule

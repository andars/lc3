`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:26:56 03/07/2016 
// Design Name: 
// Module Name:    decoder24 
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
module decoder24(in, out);
	input [1:0] in;
	output [3:0] out;
	
	assign out = ~((4'b0001) << in);
endmodule

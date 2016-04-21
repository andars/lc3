`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:21:42 03/14/2016 
// Design Name: 
// Module Name:    IR 
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
module IR(IR, clk, ldIR, reset, Buss);
	input clk, ldIR, reset;
	input [15:0] Buss;
	output reg [15:0] IR;
	
	always @(posedge clk) begin
		if (reset)
			IR <= 16'd0;
		else if (ldIR)
			IR <= Buss;
	end
endmodule

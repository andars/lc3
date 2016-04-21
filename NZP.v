`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:24:23 03/14/2016 
// Design Name: 
// Module Name:    NZP 
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
module NZP(
				Buss,
				N,
				Z,
				P,
				clk,
				flagWE,
				reset
		);

input [15:0] Buss;
output reg N;
output reg Z;
output reg P;
input clk;
input flagWE;
input reset;

wire n_int, z_int, p_int;

// negative if most significant bit set
assign n_int = Buss[15];

// zero if none of the bits are set
assign z_int = ~(| Buss);

// positive if neither negative or zero
assign p_int = (~n_int) & (~z_int);

always @(posedge clk) begin
	if (reset) begin
		N <= 0;
		Z <= 1;
		P <= 0;
	end
	else if (flagWE) begin
		N <= n_int;
		Z <= z_int;
		P <= p_int;
	end
end

endmodule

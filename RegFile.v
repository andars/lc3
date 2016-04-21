`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:34:35 03/14/2016 
// Design Name: 
// Module Name:    RegFile 
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
module RegFile(
	Ra,
	Rb,
	Buss,
	clk,
	regWE,
	reset,
	DR,
	SR1,
	SR2
);

output [15:0] Ra;
output [15:0] Rb;
input [15:0] Buss;
input clk;
input regWE;
input reset;
input [2:0] DR;
input [2:0] SR1;
input [2:0] SR2;

reg [15:0] registers [0:7];

// asynchronous read
assign Ra = registers[SR1];
assign Rb = registers[SR2];

// synchronous write with reset
integer i;

always @(posedge clk) begin
	if (reset)
	begin
		for (i = 0; i<8; i=i+1) begin
			registers[i] <= 0;
		end
	end
	else if (regWE)
		registers[DR] <= Buss;
end

endmodule

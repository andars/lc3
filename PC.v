`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:05:51 03/14/2016 
// Design Name: 
// Module Name:    PC 
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
module PC(
	Buss,
	clk,
	reset,
	ldPC,
	eabOut,
	selPC,
	PC
);

input [15:0] Buss;
input clk;
input reset;
input ldPC;
input [15:0] eabOut;
input [1:0] selPC;
output reg [15:0] PC;

wire [15:0] pc_next;
assign pc_next = (selPC == 0) ? PC + 1 :
					  (selPC == 1) ? eabOut :
					  (selPC == 2) ? Buss :
					  16'bZ;

always @(posedge clk) begin
	if (reset)
		PC <= 0;
	else if (ldPC)
		PC <= pc_next;
end

endmodule

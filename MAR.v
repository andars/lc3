`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:32:55 03/29/2016 
// Design Name: 
// Module Name:    MAR 
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

module MAR(Buss, clk, reset, ldMAR, MAR);

input [15:0] Buss;
input clk, reset, ldMAR;
output reg [15:0] MAR;
 
  always @(posedge clk or posedge reset) 
    if (reset == 1'b1) 										   
			MAR = 0; 
	else if (ldMAR)
			MAR = Buss;								 					
endmodule	

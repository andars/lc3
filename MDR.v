`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:33:18 03/29/2016 
// Design Name: 
// Module Name:    MDR 
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

module MDR(Buss, memOut, selMDR, clk, reset, ldMDR, MDR);

input [15:0] Buss, memOut;
input clk, reset, ldMDR, selMDR;
output reg [15:0] MDR;

  always @(posedge clk or posedge reset) 
    if (reset == 1'b1) 										   
			MDR = 0; 
	else if (ldMDR)
			MDR = selMDR?memOut:Buss;		
endmodule


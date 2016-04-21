`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:25:17 03/22/2016 
// Design Name: 
// Module Name:    clock_divider 
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
module clock_divider(
		input wire clk_in,
		input wire reset,
		output wire clk_out
);

localparam MAX = 32'd50000;

// painfully slow 32'd10000000;
// pretty slow (each cycle visible): 32'd2000000;
// fast-ish: 32'd50000;
// fast (redraws frame in 30 sec): 32'd5000
// approaching maximum: 32'd10;

reg [31:0] counter;

/* 1kHz => 16'd5000 */

always @(posedge clk_in) begin
	if (reset)
		counter <= 0;
	else if (counter >= MAX)
		counter <= 0;
	else
		counter <= counter + 1;
end

assign clk_out = (counter == MAX);


endmodule

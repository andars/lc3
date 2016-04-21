`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:02:50 03/07/2016 
// Design Name: 
// Module Name:    seven_segment_controller 
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
module seven_segment_controller(d1,d2,d3,d4,out,select,clk,reset);
	input [3:0] d1, d2, d3, d4;
	input clk, reset;
	output [3:0] select;
	output [6:0] out;
	
	wire [1:0] state;
	wire [3:0] digit;
	wire incr;
	
	prog_timer T0(.clk(clk), .reset(reset), .clken(1'b1), .load_number(24'd150000),  .zero(incr));
	
	mod4 M(.clk(clk), .reset(reset), .incr(incr), .q(state));
	
	//select current digit to feed to decoder
	mux41 M1(.q(digit), .d(d1), .c(d2), .b(d3), .a(d4), .sel(state));
	
	//decode the current digit
	seven_segment S(
		.num(digit),
		.out(out)
	);
	
	//low asserted (anode for the seven segments)
	
	decoder24 D0(.in(state), .out(select));
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:28:34 03/24/2016 
// Design Name: 
// Module Name:    seven_segment 
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
module seven_segment(
	input wire [3:0] num,
	output reg [6:0] out
);


always @(*) begin
	case (num)
		4'h0: out = ~7'b1111110;
		4'h1: out = ~7'b0110000;
		4'h2: out = ~7'b1101101;
		4'h3: out = ~7'b1111001;
		4'h4: out = ~7'b0110011;
		4'h5: out = ~7'b1011011;
		4'h6: out = ~7'b1011111;
		4'h7: out = ~7'b1110000;
		4'h8: out = ~7'b1111111;
		4'h9: out = ~7'b1111011;
		4'ha: out = 7'b0001000;
		4'hb: out = 7'b1100000;
		4'hc: out = 7'b0110001;
		4'hd: out = 7'b1000010;
		4'he: out = 7'b0110000;
		4'hf: out = 7'b0111000;
		default: out = 7'b1111111;
	endcase
end

endmodule

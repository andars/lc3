`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:54:35 04/05/2016 
// Design Name: 
// Module Name:    vga 
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
module vga(red_out, green_out, blue_out, hs, vs, clk50_in, color, addr);
// display text resolution: 80 x 30
// character size: 8 x 16
// 12 bit character address in vmem

//TODO: use some of the wasted vmem for commands
// 		e.g. clear screen 
output reg [2:0] red_out;
output reg [2:0] green_out;
output reg [1:0] blue_out;
output reg hs;
output reg vs;
input [7:0] color;
input clk50_in;
output [11:0] addr;

reg clk25;
reg [9:0] hc;
reg [9:0] vc;


wire refr_tick;
wire [9:0] pix_x;
wire [8:0] pix_y;

wire [6:0] char_x;  // 7 bit character x coord (80 column)
wire [4:0] char_y;  // 5 bit character y coord (30 row)
wire [6:0] next_char_x;
wire [3:0] font_row;

wire [11:0] font_addr;

wire [7:0] char;
wire [7:0] font_line;
reg [7:0] curr_col_font;


wire in_frame;
wire char_tick;

wire pixel;

assign pix_x = hc;
assign pix_y = vc;
assign char_x = pix_x[9:3];
assign char_y = pix_y[8:4];

assign in_frame = hc < 640 && vc < 480;
assign char_tick = in_frame & ((pix_x & 10'h7) == 10'h7) & clk25;


assign next_char_x = (in_frame) ? char_x+1 : 0;

// while blanking, need to fetch next row's font
assign font_row = pix_y[3:0] + ((in_frame) ? 0 : 1);

assign addr = next_char_x | (char_y << 7);

assign char = color; // character data from video memory

assign font_addr = {{char, font_row}}; 

assign pixel = curr_col_font[~pix_x[2:0]]; // mux on x location

// font available at time of display
// fetch the corresponding line of the character font

reg [7:0] font_delay;

font_rom FR(
	.addr(font_addr),
	.dout(font_line),
	.clk(clk50_in)
);

always @(posedge clk50_in) begin
	if (clk25 == 0)
		clk25 <= 1;
	else
		clk25 <= 0;
end

always @(posedge clk50_in) begin
	if (((pix_x & 10'h7) == 10'h7) & clk25)
		curr_col_font <= font_line;
end
		

always @(posedge clk50_in) begin
	if (clk25) begin
		
		// order: video, frontporch, sync, backporch
		
		// PREVIOUSLY: order: sync, backporch, video, frontporch
		// 96 + 48 = 144
		// 800 - 16 = 784
		
		
		if (in_frame) begin
			// in displayed frame, output current color
			//red_out <= color[7:5];
			//green_out <= color[4:2];
			//blue_out <= color[1:0];
			
			red_out <= {3{pixel}};
			green_out <= {3{pixel}};
			blue_out <= {2{pixel}};
			
		end else begin
			// out of frame, disable video signals
			red_out <= 3'b0;
			green_out <= 3'b0;
			blue_out <= 2'b0;
		end
		
		
		// hc > 0 && hc < 3
		// 96 pixel hsync pulse, beginning 16 clocks after frame
		if (hc >= 656 && hc <= 751) 
			hs <= 0;
		else
			hs <= 1;
		
		// 2 line vsync pulse, beginning 11 lines after frame
		if (vc >= 491 && vc <= 492)
			vs <= 0;
		else
			vs <= 1;
		
		hc <= hc + 1;
		if (hc == 799) begin
			vc <= vc+1;
			hc <= 0;
		end
		
		if (vc == 523) begin
			vc <= 0;
		end
		
	end
end


endmodule

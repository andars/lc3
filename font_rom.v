`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:19:35 04/07/2016 
// Design Name: 
// Module Name:    font_rom 
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
 
module font_rom(
    // Port A
    input   wire clk,
    input   wire    [11:0]  addr,
    output  reg     [7:0]  dout
);
 

 
// Shared memory
(* RAM_STYLE="BLOCK" *)
reg [7:0] mem [4095:0];

initial
begin
	$readmemb("font.txt", mem, 0, 4095);
end


// Port A
always @(posedge clk) begin
    dout <= mem[addr];
end

endmodule


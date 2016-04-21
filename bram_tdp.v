`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:47:18 04/05/2016 
// Design Name: 
// Module Name:    bram_tdp 
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
// A parameterized, inferable, true dual-port, dual-clock block RAM in Verilog.
 
module bram #(
    parameter DATA = 16,
    parameter ADDR = 12
) (
    // Port A
    input   wire                a_clk,
    input   wire                a_wr,
    input   wire    [ADDR-1:0]  a_addr,
    input   wire    [DATA-1:0]  a_din,
    output  reg     [DATA-1:0]  a_dout
     
);
 

 
// Shared memory
(* RAM_STYLE="BLOCK" *)
reg [DATA-1:0] mem [(2**ADDR)-1:0];


// Port A
always @(posedge a_clk) begin
    a_dout      <= mem[a_addr];
    if(a_wr) begin
        a_dout      <= a_din;
        mem[a_addr] <= a_din;
    end
end
 
endmodule

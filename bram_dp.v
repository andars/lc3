`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:38:57 04/05/2016 
// Design Name: 
// Module Name:    bram_dp 
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
module bram_dp #(
    parameter DATA = 8,
    parameter ADDR = 12
) (
    // Port A
    input   wire                a_clk,
    input   wire                a_wr,
    input   wire    [ADDR-1:0]  a_addr,
    input   wire    [DATA-1:0]  a_din,
    output  reg     [DATA-1:0]  a_dout,
     
    // Port B
    input   wire                b_clk,
    input   wire                b_wr,
    input   wire    [ADDR-1:0]  b_addr,
    input   wire    [DATA-1:0]  b_din,
    output  reg     [DATA-1:0]  b_dout
);
 
// Shared memory
reg [DATA-1:0] dmem [(2**ADDR)-1:0];
 
// Port A
always @(posedge a_clk) begin
    a_dout      <= dmem[a_addr];
    if(a_wr) begin
        a_dout      <= a_din;
        dmem[a_addr] <= a_din;
    end
end
 
// Port B
always @(posedge b_clk) begin
    b_dout      <= dmem[b_addr];
    if(b_wr) begin
        b_dout      <= b_din;
        dmem[b_addr] <= b_din;
    end
end
 
endmodule
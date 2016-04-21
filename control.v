`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:12:40 03/22/2016 
// Design Name: 
// Module Name:    control 
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
module control(
	input wire [15:0] IR,
	input wire N,
	input wire Z,
	input wire P,
	input wire clk,
	input wire reset,
	input wire enable,
	
	output reg [1:0] aluControl,
	output reg enaALU,
	output reg [2:0] SR1,
	output reg [2:0] SR2,
	output reg [2:0] DR,
	output reg regWE,
	output reg [1:0] selPC,
	output reg enaMARM,
	output reg selMAR,
	output reg selEAB1,
	output reg [1:0] selEAB2,
	output reg enaPC,
	output reg ldPC,
	output reg ldIR,
	output reg ldMAR,
	output reg ldMDR,
	output reg selMDR,
	output reg memWE,
	output reg flagWE,
	output reg enaMDR	
);

localparam FETCH0 = 5'h00,
			  FETCH1 = 5'h01,
			  FETCH2 = 5'h02,
			  DECODE = 5'h03,
			  ADD = 5'h04,
			  AND = 5'h05,
			  NOT = 5'h06,
			  BR = 5'h07,
			  JMP = 5'h08,
			  JSR = 5'h09,
			  JSRR = 5'h0a,
			  LD0 = 5'h0b,
			  LD1 = 5'h0c,
			  LD2 = 5'h0d,
			  LDI0 = 5'h0e,
			  LDI1 = 5'h0f,
			  LDI2 = 5'h10,
			  LDR0 = 5'h11,
			  LEA = 5'h12,
			  ST0 = 5'h13,
			  ST1 = 5'h14,
			  ST2 = 5'h15,
			  STI0 = 5'h16,
			  STI1 = 5'h17,
			  STI2 = 5'h18,
			  STR0 = 5'h19,
			  ERROR = 5'h1a;

reg [4:0] state;
reg [4:0] next_state;

wire take_branch;
assign take_branch = (N & IR[11]) | (Z & IR[10]) | (P & IR[9]);

// next state logic & outputs
always @(*) begin
	next_state = state;
	
	// default everything disabled
	enaALU = 0;
	regWE = 0;
	flagWE = 0;
	enaMARM = 0;
	enaPC = 0;
	ldPC = 0;
	ldIR = 0;
	ldMAR = 0;
	ldMDR = 0;
	memWE = 0;
	enaMDR = 0;
	selEAB1 = 0;
	selEAB2 = 0;
	DR = 3'b0;
	SR1 = 3'b0;
	SR2 = 3'b0;
	aluControl = 2'b0;
	selMDR = 0;
	selPC = 2'b0;
	
	//pls don't turn into latch
	
	// if !enable, leave everything disabled and remain in the same state
	
	
	if (enable) begin
		next_state = ERROR;

		case (state)
			FETCH0: begin
				next_state = FETCH1;
				
				enaPC = 1;
				ldMAR = 1;
			end
			FETCH1: begin
				next_state = FETCH2;//FETCH1_5;
				
				selPC = 2'b00;
				ldPC = 1;
				ldMDR = 1;
				selMDR = 1;
			end
			/*
			FETCH1_5: begin
				next_state = FETCH2;
				ldMDR = 1;
				selMDR = 1;
			end
			*/
			FETCH2: begin
				next_state = DECODE;
				
				ldIR = 1;
				enaMDR = 1;
			end
			DECODE: begin
				case (IR[15:12])
					4'b0001: begin
						next_state = ADD;
					end
					4'b0101: begin
						next_state = AND;
					end
					4'b1001: begin
						next_state = NOT;
					end
					4'b0000: begin
						next_state = BR;
					end
					4'b1100: begin
						next_state = JMP;
					end
					4'b0100: begin
						if (IR[11]) next_state = JSR;
						else next_state = JSRR;
					end
					4'b0010: begin
						next_state = LD0;
					end
					4'b1010: begin
						next_state = LDI0;
					end
					4'b0110: begin
						next_state = LDR0;
					end
					4'b1110: begin
						next_state = LEA;
					end
					4'b0011: begin
						next_state = ST0;
					end
					4'b1011: begin
						next_state = STI0;
					end
					4'b0111: begin
						next_state = STR0;
					end
					default: begin
						next_state = ERROR;
					end
				endcase
			end
			// dunno if there is a way to refactor these arithmetic ops
			ADD: begin
				next_state = FETCH0;
				
				aluControl = 2'b01;
				SR1 = IR[8:6];
				SR2 = IR[2:0];
				DR = IR[11:9];
				
				enaALU = 1;
				regWE = 1;
				flagWE = 1;
			end
			AND: begin
				next_state = FETCH0;
				
				aluControl = 2'b10;
				SR1 = IR[8:6];
				SR2 = IR[2:0];
				DR = IR[11:9];
				
				enaALU = 1;
				regWE = 1;
				flagWE = 1;
			end
			NOT: begin
				next_state = FETCH0;
				
				aluControl = 2'b10;
				SR1 = IR[8:6];
				SR2 = IR[2:0];
				DR = IR[11:9];
				
				enaALU = 1;
				regWE = 1;
				flagWE = 1;
			end
			
			BR: begin
				next_state = FETCH0;
				
				selPC = 2'b01;
				selEAB1 = 0;
				selEAB2 = 2'b10;
				
				ldPC = take_branch;
			end
			
			JMP: begin
				next_state = FETCH0;
				
				SR1 = IR[8:6];
				selPC = 2'b01;
				selEAB1 = 1;
				selEAB2 = 2'b00;
				ldPC = 1;
			end
			
			JSR: begin
				next_state = FETCH0;
				
				DR = 3'b111;
				selPC = 2'b01;
				selEAB1 = 0;
				selEAB2 = 2'b11;
				regWE = 1;
				enaPC = 1;
				ldPC = 1;
			end
			
			JSRR: begin
				next_state = FETCH0;
				
				SR1 = IR[8:6];
				DR = 3'b111;
				selPC = 2'b01;
				selEAB1 = 1;
				selEAB2 = 2'b00;
				regWE = 1;
				enaPC = 1;
				ldPC = 1;
			end
				
			LD0: begin
				next_state = LD1;
				
				selEAB1 = 0;
				selEAB2 = 2'b10;
				enaMARM = 1;
				selMAR = 0;
				ldMAR = 1;
			end
			LD1: begin
				next_state = LD2;
				
				ldMDR = 1;
				selMDR = 1;
			end
			LD2: begin
				next_state = FETCH0;
				
				DR = IR[11:9];
				regWE = 1;
				flagWE = 1;
				enaMDR = 1;
			end
			
			LDI0: begin
				next_state = LDI1;
				
				selEAB1 = 0;
				selEAB2 = 2'b10;
				enaMARM = 1;
				ldMAR = 1;
			end
			LDI1: begin
				next_state = LDI2;
				
				ldMDR = 1;
				selMDR = 1;
			end
			LDI2: begin
				next_state = LD1;
				
				ldMAR = 1;
				enaMDR = 1;
			end
			
			LDR0: begin
				next_state = LD1;
				
				SR1 = IR[8:6];
				selEAB1 = 1;
				selEAB2 = 2'b01;
				enaMARM = 1;
				ldMAR = 1;
			end
			
			LEA: begin
				next_state = FETCH0;
				DR = IR[11:9];
				selEAB1 = 0;
				selEAB2 = 2'b10;
				regWE = 1;
				flagWE = 1;
				enaMARM = 1;
			end
			
			ST0: begin
				next_state = ST1;
				
				selEAB1 = 0;
				selEAB2 = 2'b10;
				enaMARM = 1;
				selMAR = 0;
				ldMAR = 1;
			end
			ST1: begin
				next_state = ST2;
				
				aluControl = 2'b00;
				SR1 = IR[11:9];
				enaALU = 1;
				ldMDR = 1;
				selMDR = 0;
			end
			ST2: begin
				next_state = FETCH0;
				
				memWE = 1;
			end
			
			STI0: begin
				next_state = STI1;
				
				selEAB1 = 0;
				selEAB2 = 2'b10;
				enaMARM = 1;
				selMAR = 0;
				ldMAR = 1;
			end
			STI1: begin
				next_state = STI2;
				
				ldMDR = 1;
				selMDR = 1;
			end
			STI2: begin
				next_state = ST1;
				
				ldMAR = 1;
				enaMDR = 1;
			end
			
			STR0: begin
				next_state = ST1;
				
				SR1 = IR[8:6];
				selEAB1 = 1;
				selEAB2 = 2'b01;
				enaMARM = 1;
				selMAR = 0;
				ldMAR = 1;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (reset)
		state <= FETCH0;
	else if (enable)
		state <= next_state;
end
		
endmodule

module Memory(clk, reset, MAR, MDR, mem_out, memWE, io, out, select, vga_color, vga_addr);

input clk, reset, memWE;
input [15:0] MAR, MDR;
output [15:0] io;
output [15:0] mem_out;
output [3:0] select;
output [6:0] out;
output [7:0] vga_color;
input [11:0] vga_addr;

wire [15:0] seven_seg;
reg [15:0] seven_seg_r;

// system ram from 0x0000 to 0x0FFF
bram sys_ram(
	.a_clk(clk),
	.a_wr(memWE & ~MAR[12]),
	.a_addr(MAR[11:0]),
	.a_din(MDR),
	.a_dout(mem_out)
);

// video memory from 0x1000 to 0x1FFF
bram_dp vmem(
	.a_clk(clk),
	.a_wr(memWE & MAR[12]),
	.a_addr(MAR[11:0]),
	.a_din(MDR[7:0]),
	
	.b_clk(clk),
	.b_wr(1'b0), // vga controller only reads
	.b_addr(vga_addr),
	.b_dout(vga_color),
	.b_din()
);


// register seven segment data

always @(posedge clk) 
begin		  	 
	/*
	if (memWE) begin
		my_memory[MAR] <= MDR;
		//if (MAR == 7) seven_seg <= MDR[3:0];
	end
	mem_out <= my_memory[MAR];
	*/

	if (reset) seven_seg_r <= 16'b0;
	else if (16'd0 < MAR && MAR < 16'd16 && memWE) begin
		seven_seg_r <= MDR;
	end
	else if (memWE) seven_seg_r <= MAR;
	
	//io <= my_memory[7];
	//seven_seg <= my_memory[7];
end


assign io = mem_out;
assign seven_seg = seven_seg_r;


seven_segment_controller SSC(
		.d1(seven_seg[15:12]), .d2(seven_seg[11:8]), .d3(seven_seg[7:4]), .d4(seven_seg[3:0]),
		.out(out),
		.select(select),
		.clk(clk), 
		.reset(1'b0)
);

endmodule
			



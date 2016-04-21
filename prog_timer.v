


module prog_timer (clk, reset, clken, load_number, counter, zero, tp); 
  input clk, reset, clken; 
  input [23:0] load_number; 
  output reg [23:0] counter;  
  output reg zero, tp; 
 
  wire cnt0; 

  assign cnt0 = ~(|counter);									// is current count = 0?
  
  always @(posedge clk or posedge reset) 
    if (reset == 1'b1) 										    // on reset
		begin
			counter = load_number-1; 							// initialize counter with preload
			zero = 1'b0;										    // clear ceo output
			tp = 1'b0;											// clear tp output
		end
	else if (cnt0 & clken)										// if count is 0
		begin
			counter = load_number-1;							// initialize counter with preload
			zero = 1'b1;											// set the ceo output
			tp = ~tp;											// toggle the tp output
		end
	else if (clken)		
		begin
      		counter = counter - 24'h000001; 	 				// decrement the counter
			zero = 1'b0;		 									// clear the ceo output
			tp = tp;											// maintain the tp output
		end
					
endmodule 
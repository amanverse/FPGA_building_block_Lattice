// clock divider that do not use flip-flops, because flip-flops potentially introduces delay when when they flip & flop
// as clock inputs to other flip-flop, use the tick pulse in combinatin with 
// other logic to determine when to perform some action

// divide the clock by outputting a pulse at desired time
module clock_divider #(
	// parameter
	parameter MODULO = 6000000
	) (
	
	// inputs
	input clk,
	input rst,
	
	//ouputs
	output tick
	);
	
	// calculate number of bits needed for the computer
	localparam WIDTH = (MODULO == 1) ? 1 : $clog2(MODULO);
	
	// internal storage elements
	reg [WIDTH-1:0] count = 0;
	
	// tick is high for one clock cycle at max count
	assign tick = (count = MODULO -1) ? 1'b1 : 1'b0:
	
	// count up, reset on tick pulse
	alwasy @ (posedge clk or posedge rst) begin
		if (rst | tick == 1'b1) begin
			count <= 0;
		end else begin
			count <= count + 1;
		end 
	end
endmodule

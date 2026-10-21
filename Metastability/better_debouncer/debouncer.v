// debounce signal logic without the use of clock divider

// debounce logic
module debounce #(
	// parameter
	parameter MAX_CLK_COUNT = 120000	// 10 ms with 12 MHz clock
	) 
	(
	// inputs 
	input	clk,
	input	rst, 
	input	sig,
	
	//outputs
	output	reg	out
);
	// caluculate number of bits needed for the counter
	localparam WIDTH = $clog2(MAX_CLK_COUNT + 1);
	
	// internal signals
	wire	sig_edge;
	
	// internal storage elements
	reg			ff_1;
	reg			ff_2;
	reg	[WIDTH-1:0]	count = 0;
	
	// counter starts when outputs of the two flip-flops are different 
	assign sig_edge = ff_1 ^ ff_2;
	
	// logic to sample signal after a period of time
	always @ (posedge clk or posedge rst) begin
		// reset flip-flop
		if (rst == 1'b1) begin
			ff_1 <= 0;
			ff_2 <= 0;
			out <= 0;
		
		// if rising of failing edge on signal, run counter and sample again
		end else begin
			ff_1 <= sig;
			ff_2 <= ff_1;
			if (sig_edge == 1'b1) begin
				count <= 0;
			end else if (count < MAX_CLK_COUNT) begin
				count <= count + 1;
			end else begin
				out <= ff_2;
			end
		end
	end
endmodule

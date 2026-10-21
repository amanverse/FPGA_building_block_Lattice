// sample input waveform and register it
module metastability_test (
	// input
	input		clk_in,
	input		sig_in, 
	
	// outputs
	output		clk_out,
	output	reg	sig_out = 0
);

	//internal storage elements
	reg div_sig;
	reg pipe_0;
	
	// pass inputs clock to output pin
	assign clk_out = clk_in;
	
	always @ (posedge clk_in) begin
		pipe_0 <= sig_in;
		sig_out <= pipe_0;
	end
endmodule

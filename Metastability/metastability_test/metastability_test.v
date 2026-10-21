// input 2 MHz clock and 1 MHz square wave signal. Phase shift the 1 MHz 
// 1 MHz signal to force metastability

// connections
// signal	| Icestick	| AnalogDiscovery 2	|	Osciloscope
// ------------------------------------------------------------------------
// VCC		| 3.3V 		| vary 0.7 to 3.3 V	|
// GND		| GND		| GND			| ground clips
// clk_in	| 87		| W1			| 
// sig_in	| 88		| W2			| ch. 1
// clk_out	| 90		| 			| ch. 2
// sig_out	| 91		| 			| ch. 3

// sample input waveform and register it
module metastability_test (
	// inputs
	input		clk_in,
	input		sig_in,

	// ouputs
	output		clk_out,
	output		sig_out,

	// outputs
	output		clk_in,
	output		sig_out = 0
);

	// internal storage elements
	reg	div_sig;
	reg 	pipe_0;

	// pass input clock to output pin
	assign clk_out = clk_in;

	// register input signal 
	always @ (posedge clk_in) begin
		sig_out <= sig_in;
		//pipe_0 <= sig_in;
		//sig_out <= pipe_0;
	end
endmodule

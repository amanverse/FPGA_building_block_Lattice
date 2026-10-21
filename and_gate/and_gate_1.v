// Module: when buttons 0 lights up 2 LEDs, button 0 and button 1 lights up another
module and_gate (
	// i/p
	input	[1:0]	pmod,	 

	// o/p
	output	[2:0] led
);
	
	// wire (net) declarations (internal to module)
	wire not_pmod_0;

	// continuous assignment: replicate 1 wire to 2 ouputs
	assign not_pmod_0 = ~pmod[0];
	assign led[1:0] = {2{not_pmod_0 & ~pmod[1];
					  
endmodule

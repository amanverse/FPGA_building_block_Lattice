// Module: when buttons 1 and 2 are pressed, turn on LED
module and_gate (
	// i/p
	input	pmod_0, 
	input	pmod_1, 

	// o/p
	output	led_0
);
	// continuous assignment: NOT and AND operators
	// continuous because there is not clock no execution break
	assign led_0 = ~pmod_0 & ~pmod_1; // because buttons are continuous low
					  
endmodule

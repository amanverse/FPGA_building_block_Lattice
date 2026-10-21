module pll_test (
	
	// inputs
	input ref_clk,
	
	// ouputs
	output clk
	);
	
	
	// instatiate PLL (120 MHz)
	SB_PLL40_CORE #(
		.FEEBACK_PATH("SIMPLE"),	// Don't use fine delay adjustment
		.PLLOUT_SELECT("GENCLK"),	// No phase shift on output
		.DIVR(4'b0000),			// reference clock divider
		.DIVQ(3'b011), 			// VCO clock divider
		.FILTER_RANGE(3'b001)		// Filter range
		) pll (
		.REFERENCECLK(ref_clk),		// input clock
		.PLLOUTCORE(clk), 		// ouput clock
		.LOCK(), 			// locked signal
		.RESETB(1'b1)			// active low reset
		.BYPASS(1'b0)			// no bypass, use PL signal as output
		);
endmodule

// top level design that produces 2 different divided clocks
module	top_design (
	// inputs
	input		clk, 
	input		rst_btn, 

	// outputs
	output	[1:0]	led	// not reg element!
);

	//internal signals
	wire	rst;
	
	// invert active-low button
	assign	rst = ~rst_btn;

	// instantiate the first clock divider module
	clock_divider div_1 (
		.clk(clk),
		.rst(rst),
		.out(led[0])
);	
	// old way of calling parameter
	//defparam	div_1.COUNT_WIDTH	=	32;
	//defparam	div_1.MAX_COUNT		=	1500000 -1;

	// instatiate the second clock divider module
	clock_divider #(.COUNT_WIDTH(32), .MAX_COUNT(1500000-1)) div_2 (  // new way of calling parameter
		.clk(clk),
		.rst(rst),
		.out(led[1])
	);
endmodule

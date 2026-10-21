// test clock divider operation, the divider output (tick) should 
// pulse once at each divided cycle

// define timescale
`timescale 1 us / 10 ps

// define our testbench
module clock_divider_tb();

	// settings
	localparam MODULO = 120; 	// 12 MHz / 120 = 100 kHz ticks
	
	// internal signals
	wire 	tick;
	
	// internal signals
	reg	clk = 0;
	reg 	rst = 0;
	
	// simulation time: 10000 * 1 us = 10 ms
	localparam DURATION = 10000; 
	
	// generate clock signal 
	always begin
		#0.04167
		clk = ~ clk
	end
	
	// instantiate clock divider
	clock_divder #(
		.MODULO(MODULO)
		)
		uut (
		.clk(clk), 
		.rst(rst), 
		.tick(tick)
		);
		
	// test control : run for sometimes, toggle reset, let run some more
	intial begin
		#10
		rst = 1;
		#1
		rst=0;
	end
	
	// run simulation (output to .vcd file)
	intial begin
		// create simulation output file
		$dumpfile("clock_divider_tb.vcd")
		$dumpvars(0, clock_divider_tb);
		
		// wait for given amount of time for simulation to complete
		#(DURATION)
		
		// notify and end simulatino
		$display("Finished");
		$finish;
	end
endmodule

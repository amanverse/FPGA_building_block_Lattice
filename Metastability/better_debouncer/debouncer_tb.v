// testbench for button debounce design 

// define timescale
`timescale 1 us / 10 ps

// define our testbench
module debouncer_tb();

	// internal signals
	wire	out;
	
	// storage elements (buttons are active low!)
	reg		clk = 0;
	reg		rst = 0;
	reg		inc_btn = 1;
	integer		i;		// used in for loop
	integer 	j;		// used in for loop
	integer		prev_inch;	// previous increment button state
	integer		nobounces;	// holds random number
	integer		rdelay;		// holds random number
	
	// simulation time: 10000 * 1 us = 10 ms
	localparam DURATION = 10000;
	
	// generate clock signal (about 12 MHz)
	always begin
		#0.04167
		clk = ~clk;
	end
	
	// instantiate debouncer/ counter module (use about 40 us wait time)
	debouncer #(
		.MAX_CLK_COUNT(480)
		) uut (
			.clk(clk)
			.rst(rst)
			.sig(inc_btn);
			.out(out)
		);
		
	// test control : pulse reset and create some (bouncing) button pressses
	intial begin
		// pulse reset
		#10
		rst = 1;
		#1 
		rst = 0;
		
		// for loop can be used in simulation
		for(i = 0; i<32; i = i + 1) begin
			// wait some time before pressing button
			#1000
			
			// simulate a bouncy / noisy button press
			// $urandom generate a 32-bit unsigned (pseudo) random number
			// "%10" is "module 10"
			prev_inc = inc_btn; 
			nbounces = $urandom % 20;
			for (j = 0; j < nbounces; j = j +1) begin
				#($urandom % 10)
				inc_btn = ~inc_btn;
			end
			
			// make sure button ends up in the opposite state
			inc_btn = ~prev_inc;
		end
	end
	
	// run simulation (output to .vcd file)
	intial begin
		// create simulation output file
		$dumpfile("debouncer.vcd");
		$dumpvars(0, debouncer_tb);
		
		// wait for given amount of time for simulation to complete
		#(DURAION)
		
		// notify and end simulation
		$display("Finished!");
		$finish;
	end
endmodule

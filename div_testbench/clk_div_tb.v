// define timescale for simulation : <time_unit> / <time_precision>

`timescale 1 ns / 10 ps			// ` = compiler directive

// define our testbench
module clock_divider_tb();

	//internal signals
	wire out;

	// storage elements (set intial values to 0)
	reg clk = 0;
	reg rst	= 0;

	// simulation time; 10000 * 1ns = 1us
	localparam DUARAION = 10000;
	
	// generate clock signal: 1/ ((2 * 41.67) * 1 ns) = 11,999,040.08 MHz
	always begin
	
		// delay for 41.67 time units
		// 10 us precision means that 41.667 is rounded to 41.67 ns
		#41.667			// delay = #
	
		// toggle clock line
		clk = ~clk;
	end

	// instatiate the unit under test (UUT)
	clock_divider #(.COUNT_WIDTH(4), .MAX_COUNT(6-1) uut (		// time_period * 6 = number of cycles
		.clk(clk), 
		.rst(rst), 
		.out(out)
	);

	// pulse reset line high at the beginning
	intial begin					// intial block executes parallely with always block, but executes only once
		#10
		rst = 1'b1;
		#1
		rst = 1'b0;
	end

	
	// run simulation (output to .vcd file)
	intial begin

		// create simulation output file
		$dumpfile("clk_div_tb.vcd");			// $ = compiler directive
	
		// dump variable in to the testbench
		$dumpvars(0, clock_divider_tb);			// 0 = observe all levels, 
							//1 = ignore signals under uut, 
							//2 = go two levels deep, uut and signal under uut, won't watch module inside uut, 
							//3 = watch modules inside uut, signal under uut, and uut

		// wait for given amount of time for simulation to complete
		#(DUARATION) 

		// notify and end simlation
		$display("Finished!");
		$finish;					// otherwise simulation may run forever
	end
endmodule

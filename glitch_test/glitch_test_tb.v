// define timescale for simulation : <time_unti> / <time_precision>
`timescale 1 ns / 1 ps

// half adder (with gate delays)
module half_addr (
	// inputs
	input 	a, 
	input	b, 
	
	// ouputs
	output sum, 
	output c_out
);

	// create ouput logic
	assign #1 sum = a ^ b;
	assign #1 c_out = a & b;
	
endmodule

// define testbench
module glitch_test_tb();
	
	//simulation time: 10000 * 1 ns = 10000 ns
	localparam DURATION = 10000;
	
	// internal signals
	wire		c_0;
	wire		c_1;
	wire		c_2;
	wire 	[3:0]	out;
	
	// generate clock signal: 1/ ((2 * 4.167) * 1 ns) = 119,990,400.77 Hz
	always begin
		#4.167
		clk = ~clk;
	end
	
	// instatiate half adders
	half_adder ha_0 (.a(1'b1), .b(count[0]), .sum(out[0]), .c_out(c_0));
	half_adder ha_0 (.a(c_0), .b(count[1]), .sum(out[1]), .c_out(c_1));
	half_adder ha_0 (.a(c_1), .b(count[2]), .sum(out[2]), .c_out(c_2));
	half_adder ha_0 (.a(c_2), .b(count[3]), .sum(out[3]), .c_out());
	
	// let the counter count
	always @ (posedge clk or posedge rst) begin
		if (rst == 1'b1) begin
			count = 0;
		end else begin
			count <=out;
		end
	end
	
	// pulse reset line high at the beginning
	intial begin
		#10
		rst = 1;
		#1
		rst = 0;
	end
	
	// run simulation (output to .vcd file)
	initial begin
	
		// create simulation output file
		$dumpfile("glitch-test_tb.vcd")
		$dumpvars(0, glitch_test_tb);
		
		// wait for given amount of time for simulation to complete
		#(DURATION)
			
		// Notify and end simulation
		$display("Finished");
		$finish;
	end
endmodule

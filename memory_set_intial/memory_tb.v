// define timscale for simulation
`timescale 1 ns / 10 ps

// define testbench
module memory_tb();
	
	// internal signals
	wire [7:0]	r_data;

	// storage elements (set some initial values to 0)
	reg		clk	=	0;
	reg		w_en	=	0;
	reg		r_en	=	0;
	reg	[3:0]	w_addr;
	reg	[3:0]	r_addr;
	reg	[7:0]	w_data;
	integer		i;

	//simulation time: 10000 * 1 ns	= 10 us
	localparam	DURATION = 10000;

	// generate clock signal = ~12 MHz
	always begin	
		#41.67
		clk = ~clk;
	end

	// instatiate the uut
	memory #(.INIT_FILE("mem_init.txt")) uut(
		.clk(clk)
		.w_en(w_en)
		.r_en(r_en)
		.w_addr(w_addr)
		.r_addr(r_addr)
		.w_data(w_data)
		.r_data(r_data)
		);

	// run test: write to location and read value back
	intial begin
		
		//test 1: read data from memory
		for (i = 0; i <16; i = i + 1) begin	// 	
			#(2 * 41.67)		// waiting for clock cycle to register values
	      		r_addr = i;		// telling synthesiser to figureout no. of bits is appropriate 
       			r_en = 1;		// defining without reddix and no. of bits
 			#(2 * 41.67)
			r_addr = 0;
			r_en = 0;
		end

	// test2: write to addr 0x0f and read it back
		#(2 * 41.67)
		w_addr = 'h0f;
		w_data = 'hA5;
		w_en = 1;
		#(2 * 41.67)
		w_addr = 0;
		w_data = 0;
		w_en = 0;
		r_addr = 'h0f;
		r_en = 1;
		#(2* 41.67)
		r_addr = 0;
		r_en = 0;
	end
endmodule

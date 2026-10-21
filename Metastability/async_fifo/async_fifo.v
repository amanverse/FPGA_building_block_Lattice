// implementatin of Cliffor Cumming's asynchronous FIFO desing from the paper
// at http://www.sunburst-design.com/papers/CummingsSNUG2002SJ_FIFO1.pdf

// top level asynchronous FIFO module to be used in design

// note: 
// 	w_* : something is in the "write clock domain"
// 	r* : something is in the " read clock domain" 
// 	single memory element is DATA_SIZE bits wide
// 	Memory is 2^ADDR_SIZE elemente deep

// aysnchronous FIFO module
module async_fifo #(
	
	// parameter
	parameter DATA_SIZE = 8, 	// number of data bits
	parameter ADDR_SIZE = 4		// number of bits for addr
	) (
	
	// inputs
	input	[DATA_SIZE-1: 0]	w_data,	// data to be written to FIFO
	input				w_en, 	// write data and increment addr
	input				w_clk, 	// write domain clock
	input				w_rst, 	// write domain reset
	input				r_en, 	// read data and increment addr
	input				r_clk, 	// read domain clock
	input				r_rst, 	// read domain reset
	
	// outputs
	output					w_full, // flag: 1 if FIFO is full
	output	reg	[DATA_SIZE-1: 0]	r_data, // data to be read from FIFO
	output					r_empty	// flag: 1 if FIFO is empty
	);
	
	// contants
	localparam FIFO_DEPTH = (1 << ADDR_SIZE);
	
	// internal signals
	wire	[ADDR_SIZE-1: 0]	w_addr;
	wire 	[ADDR_SIZE: 0]		w_gray;
	wire	[ADDR_SIZE-1: 0]	r_addr;
	wire	[ADDR_SIZE: 0]		r_gray;
	
	// internals storage elements
	reg	[ADDR_SIZE: 0]	w_syn_r_gray;
	reg	[ADDR_SIZE: 0]	w_syn_r_gray_pipe;
	reg	[ADDR_SIZE: 0]	r_syn_w_gray;
	reg	[ADDR_SIZE: 0]	r_syn_w_gray_pipe;
	
	// declare memory
	reg	[DATA_SIZE-1: 0] mem [0: FIFO_DEPTH-1];
	
	//-------------------------------------------------------------------------------
	// dual-port memory (should be inferred as block RAM)
	
	// write data logic for dual port memory (separate write clock)
	// do not write if FIFO is full!
	always @ (posedge w_clk) begin
		if (w_en & ~w_full) begin
			mem[w_addr] <= w_data;
		end
	end
	
	// read data logic for dual-port memory (separate read clock)
	// do not read if FIFO is empty! 
	always @ (posedge r_clk) begin
		if (r_en & ~r_empty) begin
			r_data <= mem[r_addr];
		end
	end
	
	//--------------------------------------------------------------------------------
	// synchronous logic
	
	// pass read-domain gray code pointer to write domain
	always @ (posedge r_clk or posedge r_rst) begin
		if (r_rst == 1'b1) begin
			r_syn_w_gray_pipe <= 0;
			r_sync_w_gray <= 0;
		end else begin
			r_syn_w_gray_pipe <= w_grage;
			r_syn_w_gray <= r_syn_w_gray_pipe;
		end
	end
	
	//--------------------------------------------------------------------------------
	
	// instantiate incrementer and full/ empty checker modules
	
	// write addr increment and full check module
	w_ptr_full #(.ADDR_SIZE(ADDR_SIZE)) w_ptr_full (
		.w_sync_r_gray(w_syn_r_gray),
		.w_inc(w_en),
		.w_clk(w_clk),
		.w_rst(w_rst),
		.w_addr(w_addr),
		.w_gray(w_gray),
		.w_full(w_full)
		);
		
	// read addr increment and empty check module
	r_ptr_empty #(.ADDR_SIZE(ADDR_SIZE)) r_ptr_empty (
		.r_syn_w_gray(r_syn_w_gray),
		.r_inc(r_en),
		.r_clk(r_clk),
		.r_rst(r_rst),
		.r_addr(r_addr),
		.r_gray(r_gray),
		.r_empty(r_empty)
	);
endmodule
	

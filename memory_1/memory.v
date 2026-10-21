// inferred block RAM
module memroy (
	
	// inputs 
	input			clk,
	input			w_en,		//write enable
	input			r_en,		//read enable
	input		[3:0]	w_addr, 	//write addr
	input		[3:0]	r_addr,		//r_addr
	input		[7:0]	w_data,		//data to write

	// ouputs
	output	reg	[7:0]	r_data		//data that was read
);

	//declare memory
	reg	[7:0]	mem	[0:15];

	//interace with the memroy block
	always @ (posedge clk) begin
		
		//write to memory
		if (w_en == 1'b1) begin
			mem[w_addr] <=w_data;
		end

		//read from memory
		if (r_en == 1'b1) begin
			r_data <= mem[r_addr];
		end
	end
endmodule

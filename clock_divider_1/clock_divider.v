//clock divider
module clock_divider #(
	
	// parameters - new way with #(parameters)
	parameter			COUTN_WIDTH	=	24;
	parameter	[COUNT_WIDTH:0]	MAX_COUNT	=	6000000-1;
	
	//input
	input		clk,
	input		rst, 

	//output
	output	reg	out
);

	// parameters - old way
	//parameter			COUNT_WIDTH	=	24;
	//parameter	[COUNT_WIDTH:0]	MAX_COUNT	=	6000000-1;

	// internal signals
	reg	div_clk;
	reg	[COUNT_WIDTH:0]	count;

	// clock divider
	always @ (posedge clk or posedge rst) begi
		if (rst	==	1'b1) begin
			count	<= 0;
			out	<= 0;
		end else if (count == MAX_COUNT) begin
			count	<= 0;
			out	<= ~out;
		end else begin
			count	<= count + 1;
		end
	end
end module;

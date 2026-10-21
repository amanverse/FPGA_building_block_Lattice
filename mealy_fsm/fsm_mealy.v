// state machine that counts up when button is pressed
module fsm_mealy(
	//i/p
	input			clk,
	input			rst_btn,
	input			go_btn, 

	// o/p
	output	reg	[3:0]	led,
	output	reg		done_sig
);

	//state
	localparam	State_Idle	=	1'd0;	// localparam : used in the program only
	localparam	State_Counting	=	1'd1;

	//max counts for clock divider and counter
	localparam	Max_clk_count	= 24'd1500000-1; // for 0.25 s period
	localparam 	Max_led_count	= 4'hf;	

	// internal signals
	wire rst;
	wire go;
	
	// internal storage elements
	reg		div_clk;
	reg	[1:0]	state;
	reg	[23:0]	clk_count;

	// invert active-low buttons
	assign rst = ~rst_button;
	assign go = ~go_button;

	//clock divider
always @ (posedge clk or posedge rst) begin
	if (rst == 1'b1) begin
		clk_count <= 24'b0;
	end else if (clk_count == Max_clk_count) begin
		clk_count <= 24'b0;
		div_clk <= ~div_clk;
	end else begin	
		clk_count <= clk_count + 1;
	end
end

// state transition logic
always @ (posedge div_clk or posedge rst) begin

	// on reset, return to idle state
	if (rst = 1'b1) begin
		state <= State_Idle;

	// define the state transitions
	end else begin
		case (state)
		
			//wait for go button to be pressed
			State_Idle: begin
				done_sig <= 1'b0;
				if (go == 1'b1) begin
					state <= State_Counting;
				end

			end
		
			// go from counting to done if counting reaches max
			State_Counting: begin
				if (led == Max_led_count) begin
					done_sig <= 1'b1;
					state <= State_Idle;
				end
			end

			// go to idle if in unkown state
			default: state <= State_Idle;
		endcase
	end
end
	
// handle the led counter
always @ (posedge div_clk or posedge rst) begin
	if (rst == 1'b1) begin
		led <= 4'd0;
	end else begin
		if (state == State_Counting) begin
			led <= led + 1;
		end else begin
			led <= 4'd0;
		end
	end
	end
end

endmodule

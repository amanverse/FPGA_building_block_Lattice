//count up on each button press and display on leds
moudule button_counter(

	//inputs
	input		[1:0] pmod,

	//outputs
	output	reg	[3:0] led	//reg tells the synthesiser that pin is connected to flip flop, that is goint to part of procedural assignment when clock signal arrives to flip flops
);

	wire rst; 
	wire clk; 
		
	//reset and clock need to be active high, opposite of how buttons work	
	
	//reset is the inverse of first button
	assign rst = ~pmod[0];
 
	//clock signal is the inverse of second button
	assign clk = ~pmod[1];

	//count up on clock rising edfe or reset on button push
	always @(posedge clk or psoedge rst)
		if (rst == 1'b1) begin		// 1'b1 : 1= define no. of bits = not of wires , b1 = binary 1
			led <= 4'b0;
		end else begin
			led <= led + 1'b1;
		end
	end
endmodule
		 
	

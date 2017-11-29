module partOneLFSR(input logic clk, input reset, output logic [4:0] lfsr);
	//logic [4:0] lfsrreg;
	initial lfsr= 5'b11111;
	wire counterreset;
	wire feedback;
	logic [31:0] d1;
	logic newclk;
	
	clockdiv_1hz clklfsr(.d(d1), .clk(clk),.newclock(newclk), .reset(counterreset));
	counter counterlfsr(.clk(clk), .reset(counterreset), .Q(d1));
	
	always_ff @(posedge newclk) begin
			lfsr[3:0]<=lfsr[4:1];
			lfsr[4]<= (lfsr[0] ^ lfsr[2]);
	end
	
endmodule

module partOneLFSR(input logic clk, input reset, output logic [4:0] lfsr);
	wire [4:0] lfsrreg0;
	wire feedback;
	logic [31:0] d1;
	logic newclk;
	
	clockdiv_1hz clklfsr(.d(d1), .clk(clk),.newclock(newclk), .reset(reset));
	
	dFF dFF1(.clk(newclk), .d(lfsrreg0[4]),.q(lfsrreg0[3]));
	dFF dFF2(.clk(newclk), .d(lfsrreg0[3]),.q(lfsrreg0[2]));
	dFF dFF3(.clk(newclk), .d(lfsrreg0[2]),.q(lfsrreg0[1]));
	dFF dFF4(.clk(newclk), .d(lfsrreg0[1]),.q(lfsrreg0[0]));
	dFF dFF5(.clk(newclk), .d(feedback),.q(lfsrreg0[4]));
	
	assign feedback=lfsrreg0[0] ^ lfsrreg0[2];
	assign lfsr[0]=lfsrreg0[0];
	assign lfsr[1]=lfsrreg0[1];
	assign lfsr[2]=lfsrreg0[2];
	assign lfsr[3]=lfsrreg0[3];
	assign lfsr[4]=lfsrreg0[4];
endmodule

module dFF(input logic clk, input logic d, output logic q);
	always_ff @(posedge clk)
		q<=d;
endmodule

module clockdiv_1hz (input logic [31:0] d,input logic clk, output logic newclock,output logic reset);
always_ff @ (posedge (clk))
begin
	if (d==(32'd50000000-32'd1))
		begin
		newclock<=1'b1;
		end
	else if (d==(32'd100000000-32'd1))
		begin
		newclock<=1'b0;
		reset<=1'b1;
		end
	else
		begin
		newclock<= newclock;
		reset<=1'b0;
		end
end
endmodule

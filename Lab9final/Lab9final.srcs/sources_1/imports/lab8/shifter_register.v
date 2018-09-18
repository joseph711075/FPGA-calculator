module shifter_register #(parameter WIDTH = 4)(
	input [WIDTH-1:0] D,
	input leftIn, rightIn, LD, SL, SR, RST, CLK,
	output reg [WIDTH-1:0] Q);
	always@ (posedge CLK, posedge RST) begin
		if(RST) Q <= 0;
		else if (LD) Q <= D;
		else if (SL) Q <= {Q[WIDTH-2:0], rightIn};
		else if (SR) Q <= {leftIn, Q[WIDTH-1:1]};
		else Q = Q;
	end
endmodule
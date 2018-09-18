module ud_counter(
input [3:0] D,
input LD, UDN, CE, RST, CLK,
output reg [3:0] Q);
always@ (posedge CLK, posedge RST) begin
	if (RST) Q <= 4'b0000;
	else if (!CE) Q <= Q;
	else if (LD) Q <= D;
	else if (!UDN) Q <= Q-4'b0001;
	else Q <= Q+1;
	end
endmodule
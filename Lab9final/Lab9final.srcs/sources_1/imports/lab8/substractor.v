module subtractor #(parameter WIDTH = 5)(
input [WIDTH-1:0] a, b,
output reg [WIDTH-1:0] c);

always@ (a,b)
c = a - b;	
	
endmodule


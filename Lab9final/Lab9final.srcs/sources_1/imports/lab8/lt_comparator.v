module lt_comparator #(parameter WIDTH = 5)(
	input [WIDTH-1:0] a,
	input [WIDTH-1:0] b,
	output reg lt);
	always@(a,b)
	begin
	if(a>=b)
	lt =0;
	else
	lt=1;
	end
endmodule
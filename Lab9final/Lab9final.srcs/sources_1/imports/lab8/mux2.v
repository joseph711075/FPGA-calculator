module mux2 #(parameter WIDTH = 4)(
input [WIDTH-1:0] in1, in2,
input sel,
output reg [WIDTH-1:0] out);
	
always@ (in1,in2)
begin
	
if(sel)
out = in2;
else
out =in1;
end
	
endmodule

module ppcalculator(input [3:0] a,input b, output wire [3:0] pp  );

assign pp[0] = a[0]&b;
assign pp[1] = a[1]&b;
assign pp[2] = a[2]&b;
assign pp[3] = a[3]&b;

endmodule



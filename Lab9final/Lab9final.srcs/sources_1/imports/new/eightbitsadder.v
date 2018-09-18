
module eightbitsadder(input [7:0]A,B,   output  [7:0]S ,output cout   );


wire [3:0]s0,s1;
wire c0;


//google {} verilog

fpga f1(A[3:0],B[3:0],1'b0,s0,c0);
fpga f2(A[7:4],B[7:4],c0,s1,cout);
assign S[3:0]=s0;
assign S[7:4]=s1;



endmodule

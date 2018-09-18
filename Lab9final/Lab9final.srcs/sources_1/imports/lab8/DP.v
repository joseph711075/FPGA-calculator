module DP(
input [3:0] x, y, count,
clk,LD, RST,RightInx,SL, LDR, SRR,s1, s2,CTE,
output cnt_out, R_lt_Y, dividezero,
output [3:0] Q,
output [4:0] R);

wire [3:0] yout, xout;
wire [4:0] rout;
wire [4:0] mux1out;
wire [4:0] subOut;
wire [3:0] OUTCT;
	
mux2 #5 mux1(subOut, 5'b00000, s1, mux1out); 

shifter_register #5 sr1(mux1out, 1'b0, xout[3], LDR, SL, SRR, RST, clk, rout); 	
shifter_register sr2(x, 1'b0, RightInx, LD, SL, 1'b0, RST, clk, xout); 	
shifter_register sr3(y, 1'b0, 1'b0, LD, 1'b0, 1'b0, RST, clk, yout);  		
lt_comparator comp(rout, {1'b0, yout}, R_lt_Y);
	
subtractor sub(rout, {1'b0, yout}, subOut);

mux2 #5 mux2 (rout, 5'b0, s2, R); 	
mux2 mux3(xout, 4'b0,s2, Q); 			

ud_counter udc(count, LD, 1'b0, CTE, RST, clk, OUTCT);
	
assign cnt_out = (OUTCT == 4'b0000)? 1:0;
assign dividezero  = (y == 4'b0000)? 1:0;

endmodule



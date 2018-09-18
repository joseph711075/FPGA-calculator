
module TOP_DIVIDER(input GO, clk, rst,input [3:0]x,y,output ERROR, DONE, output [3:0]Q,CSOUT, output [4:0]R);

wire [3:0]count;
wire LD, RST,RightInx,SL, LDR, SRR,s1, s2,CTE;
wire cnt_out, R_lt_Y, dividezero;

CU CU1( cnt_out, R_lt_Y, GO, dividezero, clk, rst,
ERROR, DONE, CTE,LD, RST, RightInx, SL, LDR, SRR, s2, s1,count, CSOUT);

DP DP1(x, y, count,clk,LD, RST,RightInx,SL, LDR, SRR,s1, s2,CTE,
cnt_out, R_lt_Y, dividezero,Q,R);


endmodule

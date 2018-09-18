module DP_FULL(input  [3:0]X,Y,
input [2:0] F,
input [1:0] Op_Calc,Sel_L, input Sel_incre, EN_F,EN_X
,EN_Y,Go_Calc,
Go_DIV,Sel_H,selmuxmul,En_Out_H,En_Out_L,clk,rst,
output [3:0]H,L,
output [2:0]Fout,
output Done_Calc,Done_DIV,ERROR);
 
wire cs,DONE,CSOUT;
wire [3:0] Xout,Yout, ALUout,Qout,Rout,MUXincreout;
wire [7:0] mulout;
wire [3:0] muloutH,muloutL,MUXHout,MUXLout, muxmulin;

Dregister #4 dx (clk,rst,EN_X,X,Xout);
Dregister #4 dy (clk,rst,EN_Y,Y,Yout);
Dregister #3 df (clk,rst,EN_F,F,Fout);

MUX2ALU #4 MUXincre (4'b0001,Yout,Sel_incre ,MUXincreout);

topALU alu (Go_Calc,clk,Op_Calc ,Xout,MUXincreout, cs, Done_Calc, ALUout );

TOP_DIVIDER div( Go_DIV, clk, rst, Xout,Yout, ERROR, Done_DIV, Qout,CSOUT, Rout);


MUX2ALU #4 MUXmul (Xout, Yout,selmuxmul,muxmulin);

multiplier_top mult(clk,Xout,muxmulin,mulout);// 8 bits

assign muloutH=mulout[7:4];
assign muloutL=mulout[3:0];

MUX2ALU #4 MUXH (muloutH, Rout[3:0],Sel_H ,MUXHout);

MUX4 MUXL (4'b0000, ALUout,muloutL,Qout,Sel_L,MUXLout);

Dregister #4 OUT_H (clk,rst,En_Out_H,MUXHout,H);//H
Dregister #4 OUT_L (clk,rst,En_Out_L,MUXLout,L);



endmodule

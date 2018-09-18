
module TOPFULL(input [3:0]X,Y,input [2:0] F, input GO,clk,rst,output [3:0] H,L,CSout, output done);


wire [1:0]Op_Calc,Sel_L;
wire EN_F,EN_X,EN_Y,Go_Calc,Sel_incre,
Go_DIV,Sel_H,selmuxmul,En_Out_H,En_Out_L,Done_Calc,Done_DIV,ERROR,RST;
wire [2:0] Fout;
    
    
DP_FULL DP1(X,Y,F, Op_Calc,Sel_L,Sel_incre, EN_F,EN_X,EN_Y,Go_Calc,
Go_DIV,Sel_H,selmuxmul,En_Out_H,En_Out_L,clk,RST,
H,L,Fout,Done_Calc,Done_DIV,ERROR);
    
    
CU_FULL cu1 ( Fout, GO, clk, rst,Done_Calc,Done_DIV,ERROR, Op_Calc,Sel_L,
Sel_incre,EN_F, EN_X, EN_Y, Go_Calc, Go_DIV, Sel_H, selmuxmul, En_Out_H,
En_Out_L,RST,done,CSout);




endmodule


module TOPCU_TB;

reg [2:0]  F;
reg GO, clk, rst,Done_Calc,Done_DIV,ERROR;
wire [1:0]Op_calc,Sel_L;
wire Sel_incre,EN_F, EN_X, EN_Y, Go_Calc, Go_DIV, Sel_H, selmuxmul, En_out_H,EN_out_L,RST,DONE;	
wire[3:0] CSOUT;
integer a,b;
reg [15:0] control;

CU_FULL testtopcu(
F,GO, clk, rst,Done_Calc,Done_DIV,ERROR,Op_calc,Sel_L,
Sel_incre,EN_F, EN_X, EN_Y, Go_Calc, Go_DIV, Sel_H, selmuxmul, En_out_H,
EN_out_L,RST,DONE,	 CSOUT);


always @(*) control = {Op_calc,Sel_L,Sel_incre,EN_F, EN_X, EN_Y, 
Go_Calc, Go_DIV, Sel_H, selmuxmul, En_out_H,
EN_out_L,RST,DONE} ;
	
task tick; 
begin 
     #5 clk = 1; 
     #5 clk = 0; 
end 
endtask
	
parameter
S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 =5, S6 = 6, S7 = 7, S8 =8, S9=9,S10=10,//S4'
IDLE = 16'b00_00_0_0_0_0_0_0_0_0_0_0_1_0,
s1 = 16'b00_00_0_1_1_1_0_0_0_0_0_0_0_0,
s2 = 16'b00_00_0_0_0_0_0_0_0_0_0_0_0_0,
s2square = 16'b00_00_0_0_0_0_0_0_0_1_0_0_0_0,
s3 = 16'b11_00_0_0_0_0_1_0_0_0_0_0_0_0, //+
s4 = 16'b00_00_0_0_0_0_0_0_0_0_0_0_0_0,
s41 = 16'b00_00_0_0_0_0_0_0_0_0_0_0_0_0,
s5 = 16'b00_00_0_0_0_0_0_1_0_0_0_0_0_0,
s7 = 16'b00_00_0_0_0_0_0_0_0_0_0_0_0_0,
DIVOUT = 16'b00_11_0_0_0_0_0_0_0_0_1_1_0_0,
s6 = 16'b00_00_0_0_0_0_0_0_0_0_0_0_0_0,
s6add = 16'b11_00_0_0_0_0_0_0_0_0_0_0_0_0, //+
s6subtract = 16'b10_00_0_0_0_0_0_0_0_0_0_0_0_0,
s6incre = 16'b11_00_1_0_0_0_0_0_0_0_0_0_0_0,
s6decre = 16'b10_00_1_0_0_0_0_0_0_0_0_0_0_0,
s8 = 16'b00_10_0_0_0_0_0_0_1_0_1_1_0_0,
s9 = 16'b00_00_0_0_0_0_0_0_0_0_0_0_0_1,
CALOUT = 16'b00_01_0_0_0_0_0_0_0_0_0_1_0_0;
   
initial
begin

    
    
    
    rst = 1;				
    tick;
    rst = 0;
    GO = 0;
    
    F=0;
    tick;
    
    if (control!=IDLE)
    begin
        $display("IDLE error");
        $stop;
    end
    
    //testing addition
    
    
    GO=1;
    tick;
    if (control!=s1)
    begin
        $display("s1 error");
        $stop;
    end
    GO = 0;
    tick;
    if (control!=s2)
    begin
        $display("s2 error");
        $stop;
    end
    
    tick;
    if (control!=s3)
    begin
        $display("s3  error");
        $stop;
    end
    
    Done_Calc=0;
    
    tick;
    if (control!=s6add)
    begin
        $display("s6add error");
        $stop;
    end
    
    tick;
    if (control!=s6add)
    begin
        $display("s6add error");
        $stop;
    end
    
    Done_Calc=1;
    tick;
    if (control!=s9||DONE!=1)
    begin
        $display("s9 error");
        $stop;
    end
    
    tick;
    if (control!=IDLE)
    begin
        $display("loop back to state0 error");
        $stop;
    end
    
    
    //testing subtraction
    F=1;
    GO=1;
    tick;
    if (control!=s1)
    begin
        $display("s1 error");
        $stop;
    end
    GO=0;
    tick;
    if (control!=s2)
    begin
        $display("s2 error");
        $stop;
    end
    
    tick;
    if (control!=s3)
    begin
        $display("s3 error");
        $stop;
    end
    
    Done_Calc=0;
    
    tick;
    if (control!=s6subtract)
    begin
        $display("s6subtract error");
        $stop;
    end
    
    tick;
    if (control!=s6subtract)
    begin
        $display("s6subtract error");
        $stop;
    end
    
    Done_Calc=1;
    tick;
    if (control!=s9||DONE!=1)
    begin
        $display("s9 error");
        $stop;
    end
    
    tick;
    if (control!=IDLE)
    begin
        $display("loop back to state0 error");
        $stop;
    end
    
    //test increment 
    
    F=4;
    GO=1;
    tick;
    if (control!=s1)
    begin
        $display("s1 error");
        $stop;
    end
    GO=0;
    tick;
    if (control!=s2)
    begin
        $display("s2 error");
        $stop;
    end
    
    tick;
    if (control!=s3)
    begin
        $display("s3 error");
        $stop;
    end
    
    Done_Calc=0;
    
    tick;
    if (control!=s6incre)
    begin
        $display("s6incre error");
        $stop;
    end
    
    tick;
    if (control!=s6incre)
    begin
        $display("s6incre error");
        $stop;
    end
    
    Done_Calc=1;
    tick;
    if (control!=s9||DONE!=1)
    begin
        $display("s9 error");
        $stop;
    end
    
    tick;
    if (control!=IDLE)
    begin
        $display("loop back to state0 error");
        $stop;
    end
    
    //test decrement 
    
    F=5;
    GO=1;
    tick;
    if (control!=s1)
    begin
        $display("s1 error");
        $stop;
    end
    GO=0;
    tick;
    if (control!=s2)
    begin
        $display("s2 error");
        $stop;
    end
    
    tick;
    if (control!=s3)
    begin
        $display("s3 error");
        $stop;
    end
    
    Done_Calc=0;
    
    tick;
    if (control!=s6decre)
    begin
        $display("s6decre error");
        $stop;
    end
    
    tick;
    if (control!=s6decre)
    begin
        $display("s6decre error");
        $stop;
    end
    
    Done_Calc=1;
    tick;
    if (control!=s9)
    begin
        $display("s9 error");
        $stop;
    end
    
    tick;
    if (control!=IDLE)
    begin
        $display("loop back to state0 error");
        $stop;
    end
    
    
    //test multiply
    
    F=2;
    GO=1;
    tick;
    if (control!=s1)
    begin
        $display("s1 error");
        $stop;
    end
    GO=0;
    tick;
    if (control!=s2)
    begin
        $display("s2 error");
        $stop;
    end
    
    tick;
    if (control!=s4)
    begin
        $display("s4 error");
        $stop;
    end
    
    tick;
    if (control!=s41)
    begin
        $display("s41 error");
        $stop;
    end
    
    tick;
    if (control!=s8)
    begin
        $display("s8 error");
        $stop;
    end
    
    
    
    tick;
    if (control!=s9)
    begin
        $display("s9 error");
        $stop;
    end
    
    tick;
    if (control!=IDLE)
    begin
        $display("loop back to state0 error");
        $stop;
    end
    
    //test DIVIIDE 
    
    
    F=3;
    
    
    GO=1;
    tick;
     
    if (control!=s1)
    begin
        $display("s1 error");
        $stop;
    end
    GO=0;
    tick;
    if (control!=s2)
    begin
        $display("s2 error");
        $stop;
    end
    
    ERROR=0;     
   
    tick;
    if (control!=s5)
    begin
        $display("s5 error");
        $stop;
    end
    
    Done_DIV =0;
    
    
    tick;
    if (control!=s7)
    begin
        $display("s7 error");
        $stop;
    end
    
    tick;
    if (control!=s7)
    begin
        $display("s7 error");
        $stop;
    end
    
    Done_DIV =1;
    
    
    tick;
    if (control!=s9)
    begin
        $display("s9 error");
        $stop;
    end
    
    tick;
    if (control!=IDLE)
    begin
        $display("loop back to state0 error");
        $stop;
    end
    
    
    //testing divide by 0


    GO=1;
    tick;    
        if (control!=s1)
        begin
            $display("s1 error");
            $stop;
        end
        GO=0;
        tick;
        if (control!=s2)
        begin
            $display("s2 error");
            $stop;
        end
        
        ERROR=1;     
       
        tick;
        if (control!=IDLE)
        begin
            $display("s5 error");
            $stop;
        end
        tick;
    
    
    
    
    
    
    
    
    //test square
    
    F=6;
    GO=1;
    tick;
    if (control!=s1)
    begin
        $display("s1 error");
        $stop;
    end
    GO=0;
    tick;
    if (control!=s2square)
    begin
        $display("s2 error");
        $stop;
    end
    
    tick;
    if (control!=s4)
    begin
        $display("s4 error");
        $stop;
    end
    
    tick;
    if (control!=s41)
    begin
        $display("s41 error");
        $stop;
    end
    
    tick;
    if (control!=s8)
    begin
        $display("s8 error");
        $stop;
    end
    
    tick;
    if (control!=s9||DONE!=1)
    begin
        $display("s9 error");
        $stop;
    end
    
    tick;
    if (control!=IDLE)
    begin
        $display("loop back to state0 error");
        $stop;
    end
    

    
    
    
    
    
    
    
    
    $display("NO ERROR");
    $stop;
    
    



end    
    
    
    
    
    
    
    

endmodule

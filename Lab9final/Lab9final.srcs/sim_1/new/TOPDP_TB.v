module TOPDP_TB;

reg [3:0] x,y;
reg [2:0] F;
reg [1:0]  Op_Calc,Sel_L;
reg Sel_incre,EN_F,EN_X,EN_Y,Go_Calc,DONE, Go_DIV,Sel_H,selmuxmul,En_Out_H,En_Out_L,clk,rst;
wire [3:0]H,L;
wire [2:0] Fout;
wire Done_Calc,Done_DIV,ERROR;
reg [15:0] ctrl;
reg [3:0] A_TB,B_TB;
reg [7:0] P_TB;
integer a,b,c;

always @ (ctrl) {Op_Calc,Sel_L,Sel_incre,EN_F, EN_X, EN_Y, 
Go_Calc, Go_DIV, Sel_H, selmuxmul, En_Out_H,
En_Out_L,rst,DONE} = ctrl;



DP_FULL tb (x,y,F, Op_Calc,Sel_L,Sel_incre,EN_F,EN_X,EN_Y,Go_Calc,
Go_DIV,Sel_H,selmuxmul,En_Out_H,En_Out_L,clk,rst,H,L,
Fout, Done_Calc,Done_DIV,ERROR);


task tick;
begin
   #5 ;clk=1;
   #5 ;clk=0;
end
endtask

//	always @ (ctrl) {Op_calc,Sel_L,EN_F, EN_X, EN_Y, 
//	Go_Calc, Go_DIV, Sel_H, selmuxmul, En_out_H,
//	EN_out_L,RST,DONE} = ctrl;


	        parameter
            S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 =5, S6 = 6, S7 = 7, S8 =8, S9=9,S10=10,//S4'
            s0 = 16'b00_00_0_0_0_0_0_0_0_0_0_0_0_0,
            IDLE = 16'b00_00_0_0_0_0_0_0_0_0_0_0_1_0,
            s1 = 16'b00_00_0_1_1_1_0_0_0_0_0_0_0_0,
            s2 = 16'b00_00_0_0_0_0_0_0_0_0_0_0_0_0,
            s2square = 16'b00_00_0_0_0_0_0_0_0_1_0_0_0_0,
            s3 = 16'b00_00_0_0_0_0_1_0_0_0_0_0_0_0, //+
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
    

       for(a=0;a<16;a=a+1)
           for(b=0;b<16;b=b+1)
           begin 
                x=a;
                y=b;





   
                A_TB =a;
                B_TB =b;

                //F1;
                rst=1;
                tick;
                rst=0;
                tick;
                //testing add
                //s1
                ctrl = s1;
                tick;    
                //s2  
                ctrl = s2;
                tick;
    
                 //s3
                ctrl = s3;
                tick;
    
                 //s7
                while(Done_Calc!=1)
                begin
                    ctrl = s6add;
                    tick;    
                end
    
        
                ctrl = CALOUT;    
                tick;
    
   
 
                //s9
                ctrl = s9;
                tick;
    
                if(L!=(A_TB+B_TB))
                begin       
                    $display("X+Y ERROR");
                    $stop;       
                end 
    
                //s0
                ctrl = IDLE;
                tick;
 

                //testing minus


                ctrl = s1;
                tick;   
                //s2  
                ctrl = s2;
                tick;
    
                //s3
                ctrl = s3;
                tick;
    
                //s7
                while(Done_Calc!=1)
                begin
                    ctrl = s6subtract;
                    tick;
                end
    
        
                ctrl = CALOUT;    
                tick;
    
   
 
                //s9
                ctrl = s9;
                tick;
    
                if(L!=(A_TB-B_TB))
                begin
        
                    $display("X-Y ERROR");
                    $stop;
        
        
                end 
    
                //s0
                ctrl = IDLE;
                tick;



                //testing increment
   
                ctrl = s1;
                tick;    
                //s2  
                ctrl = s2;
                tick;
    
                //s3
                ctrl = s3;
                tick;
    
                //s6
                while(Done_Calc!=1)
                begin
                ctrl = s6incre;
                tick;   
                end
    
        
                ctrl = CALOUT;    
                tick;
 
                //s9
                ctrl = s9;
                tick;
    
                if(L!=(A_TB+4'b0001))
                begin
        
                    $display("increment error");
                    $stop;
        
        
                end 
    
                //s0
                ctrl = IDLE;
                tick;
    
                //testing decrement
       
                ctrl = s1;
                tick;    
                //s2  
                ctrl = s2;
                tick;
        
                //s3
                ctrl = s3;
                tick;
        
                //s6
                while(Done_Calc!=1)
                begin
                    ctrl = s6decre;
                    tick;   
                end
        
            
                ctrl = CALOUT;    
                tick;
     
                //s9
                ctrl = s9;
                tick;
        
                if(L!=(A_TB-4'b0001))
                begin
                    $display("decrement error");
                    $stop;  
                end 
        
                //s0
                ctrl = IDLE;
                tick;
    
    
    
    
                //testing multiply
       
              
       
                ctrl = s1;
                tick; 
                ctrl = s2;
                tick;         
                ctrl = s4;
                tick; 
                ctrl = s41;
                tick; 
                ctrl = s8;
                tick; 
                ctrl = s9;
                tick; 
       
                P_TB = a*b;
       
       
                if(L!=P_TB[3:0]&&H!=P_TB[7:4])
                begin
           
                    $display("mutiply error");
                    $stop;
           
           
                end 

                ctrl = IDLE;
                tick;
        
        
                //testing divide
           
                if(b>0)       
                begin
           
                    ctrl = s1;
                    tick; 
                    ctrl = s2;
                    tick;         
                    ctrl = s5;
                    tick; 
           
                    while(Done_DIV!=1)
                    begin
                        ctrl = s7;
                        tick;
                    end
    
                    ctrl = DIVOUT;
                    tick; 
   
           
                    ctrl = s9;
                    tick; 
           
           
           
                    if((x!= L*y+H))
                    begin
                        $display("divid error");
                        $stop;
                    end
           
                    ctrl = IDLE;
                    tick;         
           
                end
           
                //testing square
                ctrl = s1;
                tick; 
                ctrl = s2square;
                tick;         
                ctrl = s4;
                tick; 
                ctrl = s41;
                tick; 
                ctrl = s8;
                tick; 
                ctrl = s9;
                tick; 
           
                P_TB = a*a;
           
           
                if(L!=P_TB[3:0]&&H!=P_TB[7:4])
                begin
               
                    $display("square error");
                    $stop;
                       
                end 
    
                ctrl = IDLE;
                tick;           
           

    
    
    
    end
    
    
       $display("NO ERROR");
       $stop;



end








endmodule

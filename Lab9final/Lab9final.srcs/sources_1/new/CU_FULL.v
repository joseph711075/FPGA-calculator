module CU_FULL(
input [2:0]  F,
input GO, clk, rst,Done_Calc,Done_DIV,ERROR,
output reg [1:0]Op_calc,Sel_L,
output reg Sel_incre,EN_F, EN_X, EN_Y, Go_Calc, Go_DIV, Sel_H, selmuxmul, En_out_H,
EN_out_L,RST,DONE,	
output reg [3:0] CSOUT);
	
reg [3:0] NS, CS;
reg [15:0] ctrl;
	
always @ (ctrl) {Op_calc,Sel_L,Sel_incre,EN_F, EN_X, EN_Y, 
Go_Calc, Go_DIV, Sel_H, selmuxmul, En_out_H,
EN_out_L,RST,DONE} = ctrl;
	
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
s6add = 16'b11_00_0_0_0_0_0_0_0_0_0_0_0_0, //+
s6subtract = 16'b10_00_0_0_0_0_0_0_0_0_0_0_0_0,
s6incre = 16'b11_00_1_0_0_0_0_0_0_0_0_0_0_0,
s6decre = 16'b10_00_1_0_0_0_0_0_0_0_0_0_0_0,
s8 = 16'b00_10_0_0_0_0_0_0_1_0_1_1_0_0,
s9 = 16'b00_00_0_0_0_0_0_0_0_0_0_0_0_1,
CALOUT = 16'b00_01_0_0_0_0_0_0_0_0_0_1_0_0;
	
		
always @(CS)
CSOUT <= CS;	
		
always @(CS, NS, GO, F,Done_Calc,Done_DIV,ERROR) begin
		
	case(CS)				
	
		S0: 
		begin
		    ctrl = IDLE;
		    
		    if(GO==0 ) 
		    begin 
			   NS = S0; 
			   
		    end
		    else if (GO==1) 
		    begin 
			   NS = S1;  
		    end
			    
	    end
			
		S1: 
		begin 				
			NS = S2; 
			ctrl = s1; 
		end
			
		S2: 
		begin 
			if (F==3'b000)
			begin				
			    NS = S3; 
			    ctrl = s2;
			end 
				
			else if (F==3'b001)
			begin
			    NS = S3;
			    ctrl = s2;				
			end				    
			    
		    else if (F==3'b010)
		    begin
			    NS =S4;
			    ctrl =s2;  
		    end
			    
		    else if (F==3'b011)
		    begin
               NS =S5;
               ctrl =s2;  
            end
			
			
		    else if (F==3'b100)
            begin 
                NS =S3;
                ctrl =s2;  
            end	
                
		    else if (F==3'b101)
            begin
                NS =S3;
                ctrl =s2;  
            end
                
            else if (F==3'b110)
            begin 
                NS =S4;
                ctrl =s2square;  
            end
            
            if (F==3'b111)
            begin
            NS =S0;
            ctrl =s2;            
            end
            
         
                
                        		
		end
			
			
			
		S3: 
		begin
   			NS=S6;
       		ctrl=s3;					
		end
			
		S4: 
		begin 		     
			NS = S10;
			ctrl = s4;
		end
			
		S10: //S4'
        begin             
            NS = S8;
            ctrl = s41;
        end
            			
			
		S5: 
		begin
		
		    if(ERROR)
            begin
               ctrl =IDLE;
               NS =S0;
            end
                    
            else if (ERROR==0)
            begin
		  
			ctrl = s5;
			NS = S7;
		    end
		end	
			
			
		S6: 
		begin 
			if(Done_Calc)
			begin
			    ctrl = CALOUT ; 
			    NS = S9;
			end 
			else if(Done_Calc==0)
            begin
                
                if (F==4)
                begin
                    ctrl = s6incre;
                    NS = S6;
                end
                
                else if (F==5)
                begin
                    ctrl = s6decre;
                    NS = S6;
                end
                

                else if (F==0)
                begin
                    ctrl = s6add;
                    NS = S6;
                end
                
                else if (F==1)
                begin
                    ctrl = s6subtract;
                    NS = S6;
                end           
                                              

            end
                            
		end
			
		S7: 
		begin 
			
			
			if(Done_DIV)
            begin
               ctrl = DIVOUT ; 
               NS = S9;
            end 
                
            else if (Done_DIV==0)
            begin
                ctrl = s7;
                NS = S7;                
            end			
            
        end
            
        S8:
        begin
            ctrl = s8;
            NS = S9;   
        end
            
        S9:
        begin            
            ctrl = s9;
            NS = S0;           
        end
            
            
        default: 
        begin 
           ctrl = IDLE; 
           NS = S0; 
        end
            
            
	endcase
end
	
	
always @(posedge clk, posedge rst)
	
CS <= rst? S0:NS;
	
endmodule

module top_tb;


//module TOP_DIVIDER(input GO, clk, rst,input [3:0]x,y,output ERROR, DONE, output [3:0]Q,CSOUT, output [4:0]R);


reg GO,clk,rst;
reg [3:0]x,y;
wire ERROR,DONE;
wire[3:0]Q,CSOUT;
wire[4:0]R;
integer a,b;
//
task tick; 
begin 
	#5 clk = 1; 
	#5 clk = 0; 
end 
endtask

TOP_DIVIDER Test (GO,clk,rst,x,y,ERROR,DONE,Q,CSOUT,R);

initial
begin

//test reset
clk=0;
rst=1;
tick;
if(CSOUT!=0)
    begin
        $display("rst error");
        $stop;
    end
rst=0;
tick;

//test error flag
y=0;
GO=1;
tick;
if(CSOUT!=0&&ERROR!=1)
begin
    $display("divid 0 error");
    $stop;
end

rst=1;
tick;
rst=0;
tick;

//start testing
for (a=0;a<16;a=a+1)
    for (b=0;b<16;b=b+1)
        begin
        
   
    
    
            GO=1;x=a;y=b;
            tick;//state1
        
                if(ERROR==0)
                    begin 
        
                        if(CSOUT!=1)
                            begin
                                $display("state %d error, expect state1",CSOUT);
                                $stop;
                            end
        
                                tick;//state2 cnt=4
                        
                        if(CSOUT!=2)
                            begin
                                $display("state %d error, expect state2",CSOUT);
                                $stop;
                            end                
        
                                tick;//state3 cnt =3
                        
                        if(CSOUT!=3)
                            begin
                                $display("state %d error, expect state3",CSOUT);
                                $stop;
                            end
        
        
                                tick;//state4/5
                        
                        if(CSOUT!=4&&CSOUT!=5)
                            begin
                                $display("state %d error, expect state4/5",CSOUT);
                                $stop;
                            end
                                tick;//state3 cnt =2
                        
                        if(CSOUT!=3)
                            begin
                                $display("state %d error, expect state3",CSOUT);
                                $stop;
                            end
        
                                tick;//state4/5
                        
                        if(CSOUT!=4&&CSOUT!=5)
                            begin
                                $display("state %d error, expect state4/5",CSOUT);
                                $stop;
                            end
                                tick;//state3 cnt =1
                        
                        if(CSOUT!=3)
                            begin
                                $display("state %d error, expect state3",CSOUT);
                                $stop;
                            end
                                tick;//state4/5
                    
                        if(CSOUT!=4&&CSOUT!=5)       
                            begin
                                $display("state %d error, expect state4/5",CSOUT);
                                $stop;
                            end
                        
                                tick;//state3 cnt=0
                        if(CSOUT!=3)
                            begin
                                $display("state %d error, expect state3",CSOUT);
                                $stop;
                            end        
        
                                tick;//state4/5
                    
                        if(CSOUT!=4&&CSOUT!=5)
                            begin
                                $display("state %d error, expect state4/5",CSOUT);
                                $stop;
                            end
      
                                tick;// cnt =0  move on to state6 
                    
                        if(CSOUT!=6)
                            begin
                                $display("state %d error, expect state6",CSOUT);
                                $stop;
                            end        
    
                                tick;//state7 
                        if(CSOUT!=7)
                            begin
                                $display("state %d error, expect state7",CSOUT);
                                $stop;
                            end
                       //checking done flag 
                        if(DONE!=1)
                            begin
                                $display("DONE FLAG ERROR at state %d",CSOUT);
                                $stop;
                            end                
                        //checking Q / R
                        if(x!= Q*y+R)
                            begin
                                $display("%d != %d x %d + %d", x, Q, y, R);
                                $stop;
                            end                
                   
                                tick;//state0   
                    
                        if(CSOUT!=0)
                            begin
                                $display("state0 error");
                                $stop;
                            end
    
        end
      
            
            else if(ERROR==1)//stay in state0
                begin  
                    tick;
                        if(CSOUT!=0)
                        begin
                            $display("ERROR flag error");
                            $stop;
                        end
                end                  
                
    
    end

$display("NO ERROR");
$stop;


end




endmodule

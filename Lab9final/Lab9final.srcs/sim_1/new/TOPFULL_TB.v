module TOPFULL_TB;

reg [3:0]X,Y;
reg [2:0] F;
reg GO,clk,rst;
wire [3:0] H,L,CSout;
wire done;
reg [3:0]a_tb,b_tb;
reg [7:0]p_tb;
integer a,b,c;

TOPFULL TOPFULLtest(X,Y, F,  GO,clk,rst, H,L,CSout, done);

task tick;
begin
   #5 ;clk=1;
   #5 ;clk=0;
end
endtask




initial
begin
    GO=0;
    rst=1;
    tick;
    rst=0;
    tick;
    
    //test go

    GO=0;
    tick;

    if(CSout!=0)
    begin
        $display("GO error");
        $stop;
    end
    




    for(a=0;a<=15;a=a+1)
        for(b=0;b<=15;b=b+1)
            for(c=0;c<8;c=c+1)
            begin
                
                a_tb=a; b_tb=b;
                X=a;Y=b;F=c;
                //testing addition subtraction increment decrerment   
                
                if(c==0||c==1||c==4||c==5)
                begin
                    GO=1;
                    tick;
    
                    if(CSout!=1)
                    begin
                        $display("CS1 error");
                        $stop;
                    end    
    
    
                    tick;
        
                    if(CSout!=2)
                    begin
                        $display("CS2 error");
                        $stop;
                    end    
                    tick;
                    if(CSout!=3)
                    begin
                        $display("CS3 error");
                        $stop;
                    end    
    
                    tick;
                    if(CSout!=6)
                    begin
                        $display("CS3 error");
                        $stop;
                    end    
                    tick;
                    if(CSout!=6)
                    begin        
                        $display("CS6 error");
                        $stop;
                    end
                    tick;
                    if(CSout!=6)
                    begin        
                        $display("CS6 error");
                        $stop;
                    end
    
                    tick;
                    if(CSout!=6)
                    begin        
                        $display("CS6 error");
                        $stop;
                    end
    
                    tick;
                    if(CSout!=6)
                    begin        
                        $display("CS6 error");
                        $stop;
                    end
    
                    tick;
                    if(CSout!=9)
                    begin        
                        $display("CS9 error");
                        $stop;
                    end
                    
                    //check adition
                    if(c==0&&L!=(a_tb+b_tb))
                    begin
                        $display("addtion error");
                        $stop;   
                    end    

                    //check subtraction
                    if(c==1&&L!=(a_tb-b_tb))
                    begin
                        $display("subtraction error");
                        $stop;   
                    end
    
                    //check increment
                    if(c==4&&L!=(a_tb+4'b0001))
                    begin
                        $display("increment error");
                        $stop;   
                    end    

                    //check decrement
                    if(c==5&&L!=(a_tb-4'b0001))
                    begin
                        $display("decrement error");
                        $stop;   
                    end    
                    tick;
                    if(CSout!=0)
                    begin        
                        $display("loopback error");
                        $stop;
                    end
                
                end
                
                if(c==2||c==6)//checking multiply and square
                begin
                
                    GO=1;
                    tick;

                    if(CSout!=1)
                    begin
                        $display("CS1 error");
                        $stop;
                    end    


                    tick;
    
                    if(CSout!=2)
                    begin
                        $display("CS2 error");
                        $stop;
                    end    
                    tick;
                    if(CSout!=4)
                    begin
                        $display("CS4 error");
                        $stop;
                    end    
                    tick;
                    if(CSout!=10)
                    begin
                        $display("CS4' error");
                        $stop;
                    end                
                    tick;
                    if(CSout!=8)
                    begin
                        $display("CS8 error");
                        $stop;
                    end                
                    tick;
                    if(CSout!=9)
                    begin
                        $display("CS9 error");
                        $stop;
                    end                  
                    
                    //check multiplication
                    p_tb=a*b;
                    if(c==2&&(L!=p_tb[3:0]||H!=p_tb[7:4]))
                    begin
                        $display("multiplication error");
                        $stop;               
                    end
                    
                    //check square                
                    p_tb=a*a;
                    if(c==6&&(L!=p_tb[3:0]||H!=p_tb[7:4]))
                    begin
                        $display("square error");
                        $stop;               
                    end
                    
                
                    tick;
                    if(CSout!=0)
                    begin        
                        $display("loopback error");
                        $stop;
                    end
                
                end

                
                if(c==3)//checking division
                begin
                
                    GO=1;
                    tick;

                    if(CSout!=1)
                    begin
                        $display("CS1 error");
                        $stop;
                    end    
                    tick;
    
                    if(CSout!=2)
                    begin
                        $display("CS2 error");
                        $stop;
                    end    
                    
                    tick;
                    

                    if(CSout!=5)
                    begin
                        $display("CS5 error");
                        $stop; 
                    end    
                    
                    //checking divide 0
                    if(b==0)
                    begin
                                                            
                        tick;
                        if(CSout!=0)
                        begin
                            $display("divide 0 error");
                            $stop; 
                        end
                                                           
                    end



                    else if(b>=1)
                    begin                    
                        for(integer i=0;i<12;i=i+1) 
                        begin
                    
                            tick;
                            if(CSout!=7)
                            begin        
                                $display("CS7 error");
                                $stop;
                            end
                        end

    
                        tick;
                        if(CSout!=9)
                        begin        
                            $display("CS9 error");
                            $stop;
                        end
                
                    
                        if((a!= L*b+H))
                        begin
                            $display("divid error");
                            $stop;
                        end
                    
                    
                        tick;
                        if(CSout!=0)
                        begin        
                            $display("loopback error");
                            $stop;
                        end                
                    
                 
                    end    



                if(c==7)//null control
                begin
                
                    GO=1;
                    tick;

                    if(CSout!=1)
                    begin
                        $display("CS1 error");
                        $stop;
                    end    
                    tick;

                    if(CSout!=2)
                    begin
                        $display("CS2 error");
                        $stop;
                    end    
                
                    tick;
                    if(CSout!=0)
                    begin
                        $display("null control error");
                        $stop;
                    end      

                end






               end
                
                                    
    
    
    
    
    
    
    
    
    
    end



  $display("NO ERROR");
  $stop;











end














endmodule
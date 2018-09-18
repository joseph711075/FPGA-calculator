

module dividefpganotworking;


reg [3:0]X,Y;
reg [2:0] F;
reg GO,clk,rst;
wire [3:0] H,L,CSout;
wire done;
reg [3:0]a_tb,b_tb;
reg [7:0]p_tb;
integer a,b,c;

TOPFULL TOPFULLtest2(X,Y, F,  GO,clk,rst, H,L,CSout, done);

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
    
    GO=1;
    X=15;
    Y=4;
    F=3;
    
    tick;$stop;//s1
    
   
    tick;$stop;//s2
    
    
    tick;$stop;//s5
    
    for(integer i =0;i<12;i=i+1)
    begin
        tick;$stop;//s7
    end
    
    tick;$stop;//s9
    
    tick;$stop;//s0
   
   
   
   
   
    
end    
endmodule

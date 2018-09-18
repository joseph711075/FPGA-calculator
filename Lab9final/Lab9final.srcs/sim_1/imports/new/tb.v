module tb();


reg [3:0] in1, in2;
reg [1:0] op;
reg go,clk;
wire [3:0] out;
wire done;
wire [3:0] cs;
integer a,b,c,d;
reg [3:0]a_tb,b_tb;


task tick;
begin
#5;
clk =1;
#5;
clk =0;
end
endtask


topALU test(go,clk,op,in1,in2,cs,done,out );


initial 
begin

for(a=0;a<16;a=a+1) //in1
    for (b=0;b<16;b=b+1) //in2
        for (c=0;c<4;c=c+1) //op
        begin
        
            a_tb =a;
            b_tb =b;
        
            clk =0;
            go =0;
            op =0;
            in1 =a;
            in2 =b;
            tick;

            if(cs!=0)
                begin
                    $display("cs0 error or go error");
                    $stop;
                end

//state 0
            
                go =1;
                tick;

            if(cs!=1)
                begin
                    $display("cs1 error");
                    $stop;
                end
            
            
            
            
//state 1
                tick;
            if(cs!=2)
                begin
                    $display("cs2 error");
                    $stop;
                end


//state 2
                tick;
            if(cs!=3)
                begin
                    $display("cs3 error");
                    $stop;
                end
//state 3
                op =c;
                tick;
            
//state 4,5,6,7

                tick;        
        
//state 8  checking output 

           
           
           if (op==0&&out!=(a^b))
               begin
                 $display ("a^b earror");
                 $stop; 
               end
        
           
           if (op==1&&out!=(a&b))
              begin
                $display ("a&b earror");
                $stop; 
              end        
        
           if (op==2&&out!=(a_tb-b_tb))
              begin
                $display ("a-b earror");
                $stop;            
              end        

           if (op==3&&out!=(a_tb+b_tb))
              begin
                $display ("a+b earror");
                $stop;            
              end        
        
       

end


$display("NO ERROR");
$stop;


end


endmodule

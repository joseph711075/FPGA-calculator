`timescale 100ps / 1ps


module tb_multiplier;

reg [3:0]A_tb,B_tb;
reg clk;
wire [7:0]P_tb;
wire [3:0] A2, B2, A3, B3, A4, B4 ;



integer n,m;
integer o =0;

multiplier_top test1(clk,A_tb,B_tb,P_tb);

Dregister #4 d1(clk,0,1,A_tb,A2);
Dregister #4 d2(clk,0,1,B_tb,B2);

Dregister #4 d3(clk,0,1,A2,A3);
Dregister #4 d4(clk,0,1,B2,B3);

Dregister #4 d5(clk,0,1,A3,A4);
Dregister #4 d6(clk,0,1,B3,B4);


initial clk = 0;
always #50 clk =~clk;

//assign A_tb = n; #5;
    initial 
    begin 
    for(n = 0; n <16; n = n+1)
        for(m = 0; m < 16; m = m +1)
        begin
        
        
         
         
         
            A_tb = n;
            B_tb = m;
            #5; 
            if(P_tb!=A4*B4)
            begin
           
            
                $display("error");
                $stop ;
            
            end
            
     
        end;
        
        
        
        $display("EEEEEEEEEEEEEEEEEEEEEEEROR FREE");
                   $stop;
                   $finish;
        
    end;
        
        
        
        
        





endmodule

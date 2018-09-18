module DPTB;

reg [3:0] x,y, count;
reg RightInx,LD,LDR,CE, CLK, RST,s1,s2, SL, SR;
wire R_it_Y, dividezero;
wire cnt_out; 
wire [3:0]Q; 
wire[4:0] R;

integer a,b,c;

task tick;
    begin
        #5 ;CLK=1;
        #5 ;CLK=0;
    end
endtask


DP TEST(
x,y,count,
CLK,
LD, RST, RightInx,
SL, LDR, SR,s1, s2,CE,
cnt_out, R_it_Y,dividezero,
Q,
R);


initial
    begin


        RST = 0;
        tick;
        RST = 1;
        tick;

        for(a=0;a<16;a=a+1)
        for(b=0;b<16;b=b+1)
        begin

            x=a;y=b;
            //s0
            count =0;RightInx=0;LD=0;LDR=0;CE=0;RST=1;s1=0;s2=0;SL=0;SR=0;

            tick;

            if(dividezero==1'b0)
            begin
            //s1
            count=4'b0100;RightInx=0;LD=1;LDR=1;CE=1;RST=0;s1=0;s2=0;SL=0;SR=0;

            tick;
            //s2
            count=4'b0000;RightInx=0;LD=0;LDR=0;CE=0;RST=0;s1=0;s2=0;SL=1;SR=0;
            tick;

            while (cnt_out!=1)
                begin

                    if(R_it_Y==0)
                        begin
                            //s30
                            count=4'b0;RightInx=0;LD=0;LDR=1;CE=1;RST=0;s1=1;s2=0;SL=0;SR=0;
                            tick;
                            //s4
                            count=4'b0;RightInx=1;LD=0;LDR=0;CE=0;RST=0;s1=0;s2=0;SL=1;SR=0;
                            tick;
                            end
                        else
                        begin
                            //s3            
                            count=4'b0000;RightInx=0;LD=0;LDR=0;CE=1;RST=0;s1=0;s2=0;SL=0;SR=0;
                            tick;            
                            //s5
                            count=4'b0000;RightInx=0;LD=0;LDR=0;CE=0;RST=0;s1=0;s2=0;SL=1;SR=0;
                            tick;
                            end



                end

                            //s6
                            count=4'b0000;RightInx=0;LD=0;LDR=0;CE=0;RST=0;s1=0;s2=0;SL=0;SR=1;
                            tick;

                            //s7
                            count=4'b0000;RightInx=0;LD=0;LDR=0;CE=0;RST=0;s1=0;s2=1;SL=0;SR=0;
                            tick;

                            if(x!= Q*y+R)
                                begin
                                    $display("%d != %d x %d + %d", x, Q, y, R);
                                    $stop;
                                end

                            end






                    end
                            
                            
                            $display ("NO ERROR");

end

endmodule

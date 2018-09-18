module TB2;


reg [2:0] in1, in2;
reg [1:0] s1, wa, raa, rab, c;
reg we, rea, reb, s2, clk,clk2;
wire [2:0] out;
reg [2:0] a_tb,b_tb;
integer a,b;


DP test (in1, in2, s1, clk, wa, we, raa, rea, rab, reb, c, s2, out);

        initial 
        begin
                        for(a=0;a<8;a=a+1)
                        for(b=0;b<8;b=b+1)
                        
                        begin
                                        // storing 3 into RF address 1
                                        a_tb=a;
                                        b_tb=b;
                                        clk=0;
                                        in1=a;in2=b;s1=2'b11;wa=1;we=1;
                                        #5;
                                        
                                        clk=1;
                                        #5;
                                        clk=0;
                                        // storing 2 into RF address 2
                                        s1=2'b10;wa=2;
                                        #5;
                                        clk=1;
                                        #5;
                                        clk=0;// at this point 5 and 4 were save into address 1 and 2 
                                        
                                        rea=0; reb=0;// enable raa and rab
                                        raa=1; rab=2;
                                        
                                        #5;
                                        //#5;
                                        //clk=0;// at this point the stored data was sent out from RF to ALU 
                                        rea = 1; reb = 1;
                                        c=2'b00; //ADD
                                        s2=1;//enable mux2
                                        #5;
                                        
                                        #5;
                                        //clk=0;
                                        if(out!=(a_tb+b_tb))
                                            begin
                                                $display("ADDITION ERROR");
                                                $stop;
                                            end
                                         
                                         
                                         
                                        s1=2'b00;
                                        wa =3;//storing result to address 3
                                        #5;
                                        clk=1;
                                        #5;
                                        clk=0;
                                        
                                        raa=2'b11;
                                        rab=2'b11;
                                        c=2'b10;
                                        #5;
                                        
                                        if(out!=(a_tb+b_tb))
                                            begin
                                                $display("ADDITION ERROR");
                                                $stop;
                                            end
                                          
                                        raa=2'b01;
                                        rab=2'b10;
                                        
                                        #5;
                                        
                                        
                                        
                                        //////////////////////////////////
                                        c=2'b01; //SUBSTRACTION
                                        #5;
                                        #5;
                                        //testing SUBSTRACTION
                                        if(out!=(a_tb-b_tb))
                                            begin
                                                $display("SUBSTRACTION ERROR");
                                                $stop;
                                            end
                                        
                                        wa =3;//storing result to address 3
                                        #5;
                                        clk=1;
                                        #5;
                                        clk=0;

                                        raa=2'b11;
                                        rab=2'b11;
                                        c=2'b10;
                                        #5;
                                        
                                        if(out!=(a_tb-b_tb))
                                            begin
                                                $display("SUBSTRACTION ERROR");
                                                $stop;
                                            end
                                          
                                        raa=2'b01;
                                        rab=2'b10;
                                        
                                        #5;



                                        
                                        
                                        ///////////////////////////////////////
                                        c=2'b10; //AND
                                        #5;
                                        #5;
                                        //testing AND
                                        if(out!=(a_tb&b_tb))
                                            begin
                                                $display("AND ERROR");
                                                $stop;
                                            end
                                        
                                        wa =3;//storing result to address 3
                                        #5;
                                        clk=1;
                                        #5;
                                        clk=0;
                                        
                                     


                                        raa=2'b11;
                                        rab=2'b11;
                                        c=2'b10;
                                        #5;
                                        
                                        if(out!=(a_tb&b_tb))
                                            begin
                                                $display("AND ERROR");
                                                $stop;
                                            end
                                          
                                        raa=2'b01;
                                        rab=2'b10;
                                        
                                        #5;
                                       
                                        
                                        
                                        
                                        
                                        ///////////////////////////////////////////////
                                        c=2'b11; //XOR
                                        #5;
                                        #5;
                                        //testing XOR
                                            if(out!=(a_tb^b_tb))// 
                                                begin
                                                    $display("XOR ERROR");
                                                    $stop;
                                        
                                        wa =3;//storing result to address 3
                                        #5;
                                        clk=1;
                                        #5;
                                        clk=0;
                                        
                                     


                                        raa=2'b11;
                                        rab=2'b11;
                                        c=2'b10;
                                        #5;
                                        
                                            if(out!=(a_tb^b_tb))
                                                begin
                                                    $display("XOR ERROR");
                                                    $stop;
                                                end
                                          
                                        raa=2'b01;
                                        rab=2'b10;
                                        
                                        #5;
                                       
                                        
                                        
                                                                                
       
                                        
                                        
                                        
                                        
                                        
                                        
                                        end
                        
                        
                        
                        
                        end
                        
            $display("ERROR FREE");
            $stop;
        
        end




task clktoggle();  
begin
clk = ~clk;
#5;
end
endtask







endmodule


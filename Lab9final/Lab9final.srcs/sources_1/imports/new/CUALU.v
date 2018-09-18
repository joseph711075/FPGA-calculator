module CUALU(input clk, go, input [1:0] op  ,output reg [3:0] cs, output reg [1:0]sel1,wa,raa,rab,c,output reg we,rea,reb,sel2,done );

integer a;

    reg [3:0] ns; 
    
    always @(go, op, cs)
    begin
        if(cs == 0 && go) ns = 1;
        else if(cs == 0 && go ==0) ns = 0;
        else ns =0;
        
        case(cs)
        1: ns = 2;
        2: ns = 3;
        3: begin
                case(op)
                    0: ns = 7;
                    1: ns = 6;
                    2: ns = 5;
                    3: ns = 4;
                endcase
           end
        4: ns = 8;
        5: ns = 8;
        6: ns = 8;
        7: ns = 8;   
        8: ns = 0;
        endcase
    end

    always @(posedge clk)
        cs <= ns;

    always @ ( cs)
    begin
        case (cs)
        0: begin                   
                sel1 =1; 
                wa =0; 
                we =0;
                raa =0;
                rea =0;
                rab =0;
                reb =0;
                c =0;
                sel2 =0;
                done =0;
           end
        1: begin                   
                   sel1 =3; 
                   wa =1; 
                   we =1;
                   raa =0;
                   rea =1;
                   rab =0;
                   reb =0;
                   c =0;
                   sel2 =0;
                   done =0;
              end
        2: begin                   
                    sel1 =2; 
                    wa =2; 
                    we =1;
                    raa =0;
                    rea =0;
                    rab =0;
                    reb =1;
                    c =0;
                    sel2 =0;
                    done =0;
                  end 
        3: begin                   
                     sel1 =1; 
                     wa =0; 
                     we =0;
                     raa =0;
                     rea =0;
                     rab =0;
                     reb = 0;
                     c =0;
                     sel2 =0;
                     done =0;
                     end        
        4: begin                   
                     sel1 =0; 
                     wa =3; 
                     we =1;
                     raa =1;
                     rea =1;
                     rab =2;
                     reb =1;
                     c =0;
                     sel2 =0;
                     done =0;
                     end 
        5: begin                   
                     sel1 =0; 
                     wa =3; 
                     we =1;
                     raa =1;
                     rea =1;
                     rab =2;
                     reb =1;
                     c =1;
                     sel2 =0;
                     done =0;
                     end                                
        6: begin                   
                     sel1 =0; 
                     wa =3; 
                     we =1;
                     raa =1;
                     rea =1;
                     rab =2;
                     reb =1;
                     c =2;
                     sel2 =0;
                     done =0;
                     end                           
        7: begin                   
                     sel1 =0; 
                     wa =3; 
                     we =1;
                     raa =1;
                     rea =1;
                     rab =2;
                     reb =1;
                     c =3;
                     sel2 =0;
                     done =0;
                     end
     
        8: begin
        
                     sel1 =1; 
                     wa =0; 
                     we =0;
                     raa =3;
                     rea =1;
                     rab =3;
                     reb =1;
                     c =2;
                     sel2 =1;
                     done =1;
                                                      
                                                                                        
                     end
     
        
     
        endcase  

end


endmodule

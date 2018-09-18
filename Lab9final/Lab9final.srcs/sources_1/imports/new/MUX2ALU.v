module MUX2ALU #(parameter width =3) (in1, in2, s2, m2out);



input [width-1:0] in1, in2;
input s2;
output reg [width-1:0] m2out;


always @ (in1, in2, s2)
    
    begin
        if (s2)
            m2out = in1;
        else
            m2out = in2;
    end
        
endmodule //MUX2
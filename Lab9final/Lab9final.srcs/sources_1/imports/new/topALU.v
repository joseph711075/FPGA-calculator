
module topALU(input go,clk,input [1:0] op, input [3:0]in1,in2,output [3:0] cs,output done,output [3:0]out );



wire [1:0] sel1,wa,raa,rab,c; 
wire we,rea,reb,sel2;


CUALU cu1( clk, go, op , cs, sel1,wa,raa,rab,c, we,rea,reb,sel2,done );  
DPALU DP1(in1, in2, sel1, clk, wa, we, raa, rea, rab, reb, c, sel2, out);



endmodule

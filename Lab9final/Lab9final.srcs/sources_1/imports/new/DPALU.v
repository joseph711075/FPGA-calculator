module DPALU(in1, in2, s1, clk, wa, we, raa, rea, rab, reb, c, s2, out);
input [3:0] in1, in2;
input [1:0] s1, wa, raa, rab, c;
input we, rea, reb, s2, clk;
output [3:0] out;
wire [3:0] mux1out;
wire [3:0] douta;
wire [3:0] doutb;
wire [3:0] aluout;
// instantiate the building blocks
MUX1 U0(.in1(in1), .in2(in2), .in3(4'b0000), .in4(aluout), .s1(s1), .m1out(mux1out));

RX U1(.clk(clk), .rea(rea), .reb(reb), .raa(raa), .rab(rab), .we(we), .wa(wa), .din(mux1out), .douta(douta), .doutb(doutb));
ALU U2(.in1(douta), .in2(doutb), .c(c), .aluout(aluout));
MUX2ALU #4 U3(.in1(aluout), .in2(4'b0000), .s2(s2), .m2out(out));
endmodule //DP

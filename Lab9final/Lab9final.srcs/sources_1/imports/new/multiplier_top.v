
module multiplier_top(input clk,input [3:0]A,B, output [7:0]P );




wire [3:0] pp0,pp1,pp2,pp3 ;
wire [7:0] pp0fixed,pp1fixed,pp2fixed,pp3fixed,pp23,pp01,pp23fixed,pp01fixed;
wire [2:0]cout;
wire[3:0] A2,B2;
wire[7:0] P2;




Dregister #4 d1(clk,0,1,A,A2);
Dregister #4 d2(clk,0,1,B,B2);

ppcalculator a1(A2,B2[0],pp0);
ppcalculator a2(A2,B2[1],pp1);
ppcalculator a3(A2,B2[2],pp2);
ppcalculator a4(A2,B2[3],pp3);


assign pp0fixed[3:0] = pp0[3:0];
assign pp0fixed[7:4] = 4'b0000;

shifter1 s1(pp1,pp1fixed);
shifter2 s2(pp2,pp2fixed);
shifter3 s3(pp3,pp3fixed);

//eightbitsadder e0(8'b01011111,8'b01011111,P,cout[0]);


eightbitsadder e1(pp3fixed,pp2fixed,pp23,cout[0]);
eightbitsadder e2(pp0fixed,pp1fixed,pp01,cout[1]);
Dregister #8 d3(clk,0,1,pp23,pp23fixed);
Dregister #8 d4(clk,0,1,pp01,pp01fixed);
eightbitsadder e3(pp23fixed,pp01fixed,P2,cout[3]);
Dregister #8 d5(clk,0,1,P2,P);


endmodule

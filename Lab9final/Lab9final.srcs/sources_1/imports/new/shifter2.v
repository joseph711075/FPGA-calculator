
module shifter2(input [7:0] pp1, output wire [7:0] pp1fixed );



wire [7:0] help ;

assign help [7:4] = 4'b0000;
assign help [3:0] = pp1[3:0];
assign pp1fixed = help<<2;


endmodule

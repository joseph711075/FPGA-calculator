module CLA_generator(input[3:0] P, G, input c0, output reg [4:0] C);
    
    
    integer N;
    always @(P, G, c0)
    begin
        C[0] = c0;
        C[1] = G[0] | (P[0]&C[0]);
        C[2] = G[1] | (P[1]&(G[0] | (P[0]&C[0])));
        C[3] = G[2] | (P[2]&(G[1] | (P[1]&(G[0] | (P[0]&C[0])))));
        C[4] = G[3] | (P[3]&(G[2] | (P[2]&(G[1] | (P[1]& (G[0] | (P[0]&C[0])))))));
        
    end

endmodule

module X_OR(input [4:0] C, input [3:0]P, output reg [3:0] Sum, output reg Cout);
    
    integer N ;
    
    always @(C, P)
    begin
        Cout = C[4];
        for(N = 0; N < 4; N = N + 1)
            Sum[N] = C[N] ^ P[N];
    end
    
endmodule

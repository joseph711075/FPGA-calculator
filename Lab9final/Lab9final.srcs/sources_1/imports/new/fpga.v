module fpga(input [3:0] A, B, input C0, output [3:0] Sum, output Cout);

    wire [3:0] P, G;
    wire [4:0] C;
    
    
    
    
    HA_topmodule adder(A, B, P, G);
    CLA_generator cl_adder(P, G, C0, C);
    X_OR s(C, P, Sum, Cout);
    

endmodule

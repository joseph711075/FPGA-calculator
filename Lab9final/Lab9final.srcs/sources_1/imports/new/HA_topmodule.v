module HA_topmodule(input [3:0]A,B, output[3:0] P,G);
    
    HA bit0(A[0], B[0], P[0], G[0]);
    HA bit1(A[1], B[1], P[1], G[1]);
    HA bit2(A[2], B[2], P[2], G[2]);
    HA bit3(A[3], B[3], P[3], G[3]);

endmodule

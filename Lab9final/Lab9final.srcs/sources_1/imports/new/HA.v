module HA (input A, B, output P, G);
        assign P = A ^ B;
        assign G = A & B;
endmodule

module CU(
	input cnt_out, R_lt_Y, GO, Dividzero, clk, rst,
	output reg ERROR, DONE, CTE,
	output reg LD, RST, RightInx, SL, LDR, SRR, r2MuxSel, r1MuxSel,
	output reg [3:0] CT, CSOUT);
	
	reg [2:0] NS, CS;
	reg [14:0] ctrl;
	
	always @ (ctrl) {ERROR, DONE, LD, RST, RightInx, SL, LDR, SRR, r2MuxSel, r1MuxSel, CT, CTE} = ctrl;
	
	parameter
		S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 =5, S6 = 6, S7 = 7,
		error = 15'b1_0_0_1_0_0_0_0_0_0_0000_0,
		IDLE = 15'b0_0_0_1_0_0_0_0_0_0_0000_0,
		s1 = 15'b0_0_1_0_0_0_1_0_0_0_0100_1,
		s2 = 15'b0_0_0_0_0_1_0_0_0_0_0000_0,
		s3plus = 15'b0_0_0_0_0_0_1_0_1_0_0000_1,
		s3 = 15'b0_0_0_0_0_0_0_0_0_0_0000_1,
		s4 = 15'b0_0_0_0_1_1_0_0_0_0_0000_0,
		s5 = 15'b0_0_0_0_0_1_0_0_0_0_0000_0,
		s6 = 15'b0_0_0_0_0_0_0_1_0_0_0000_0,
		s7 = 15'b0_1_0_0_0_0_0_0_0_1_0000_0;
		
	always @(CS)
	CSOUT <= CS;	
		
	always @(CS, NS, GO, Dividzero, R_lt_Y, cnt_out) begin
		
		case(CS)		
		
		
			S0: begin
				if(!GO && !Dividzero) 
				begin 
					NS = S0; 
					ctrl = IDLE;
				end
				else if (Dividzero) 
				begin 
					NS = S0; 
					ctrl = error; 
				end
				else if (GO&&!Dividzero) 
				begin 
					NS = S1; 
					ctrl = IDLE; 
				end
			end
			S1: 
			begin 
				NS = S2; 
				ctrl = s1; 
			end
			S2: 
			begin 
				NS = S3; 
				ctrl = s2; 
			end
			S3: 
			begin
				if(R_lt_Y) begin 
					NS = S5; 
					ctrl = s3; 
				end
				else 
				begin 
					NS = S4; 
					ctrl = s3plus; 
				end
			end
			S4: 
			begin
				ctrl = s4;
				NS = cnt_out? S6:S3;
			end
			S5: 
			begin
				ctrl = s5;
				NS = cnt_out? S6:S3;
			end
			S6: 
			begin 
				ctrl = s6; 
				NS = S7; 
			end
			S7: 
			begin 
				ctrl = s7; 
				NS = S0; 
			end
			default: 
			begin 
				ctrl = IDLE; 
				NS = S0; 
			end
		endcase
	end
	
	
	always @(posedge clk, posedge rst)
	
	CS <= rst? S0:NS;
	
endmodule
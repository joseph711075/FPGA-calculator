module CU_tb;
	reg Counter_Out, R_lt_Y, GO, ZeroDivisor, clk, rst;
	wire ERROR, DONE, CTE, LD, RST, RightInx, SL, LDR, SR, r2MuxSel, r1MuxSel;
	wire [3:0] Counter, CSOUT;

	CU DUT0(Counter_Out, R_lt_Y, GO, ZeroDivisor, clk, rst, ERROR, DONE, CTE, LD, RST, RightInx, SL, LDR, SR, r2MuxSel, r1MuxSel, Counter,CSOUT);

	reg [14:0] control;

	always @(*) control = {ERROR, DONE, LD, RST, RightInx, SL, LDR, SR, r2MuxSel, r1MuxSel, Counter, CTE};
	task tick; 
		begin 
			#5 clk = 1; 
			#5 clk = 0; 
		end 
	endtask

	parameter
		error =   15'b1_0_0_1_0_0_0_0_0_0_0000_0,
		IDLE =    15'b0_0_0_1_0_0_0_0_0_0_0000_0,
		s1 =      15'b0_0_1_0_0_0_1_0_0_0_0100_1,
		s2 =      15'b0_0_0_0_0_1_0_0_0_0_0000_0,
		s3plus =  15'b0_0_0_0_0_0_1_0_1_0_0000_1,
		s3 =      15'b0_0_0_0_0_0_0_0_0_0_0000_1,
		s4 =      15'b0_0_0_0_1_1_0_0_0_0_0000_0,
		s5 =      15'b0_0_0_0_0_1_0_0_0_0_0000_0,
		s6 =      15'b0_0_0_0_0_0_0_1_0_0_0000_0,
		s7 =      15'b0_1_0_0_0_0_0_0_0_1_0000_0;

	initial begin
		// Test S0 idle 

		
		rst = 0;				
		tick;
		rst = 1;
		GO = 0;
		ZeroDivisor = 0;
		tick;
		if(control != IDLE) 
		begin
			$display("ERROR at S0");

		end
		
		rst = 0;				
		GO = 0;
		ZeroDivisor = 1;
		tick;
		if(control != error) 
		begin
			$display("ERROR at S0, expect ERROR");

		end
		
		GO = 1;					
		ZeroDivisor = 1;
		tick;
		if(control != error) 
		begin
			$display("ERROR at S0");

		end
		
		
		GO = 1;  						
		ZeroDivisor = 0;
		tick;
		if(control != s1) 
		begin
			$display("ERROR at S1");

		end
		GO = 0;
		tick;
		
		if(control != s2) 
		begin
			$display("ERROR at S2");
	
		end
		
		R_lt_Y = 1;
		
		tick;
		if(control != s3) 
		begin
			$display("ERROR at S3 ");

		end
		
		tick;
		if(control != s5) 
		begin
			$display("ERROR at S5");

		end		
		
		
		Counter_Out = 1;
		tick;
		if(control != s6) begin
			$display("ERROR at S6");

		end
		tick;
		if(control != s7) begin
			$display("ERROR at S7");
		end
		GO = 0;
		ZeroDivisor = 0;
		tick;
		if(control != IDLE) begin
			$display("ERROR at S0");

		end
		
		
		
		rst = 1; 
		tick;
		rst =0; 
		tick;
		
		GO = 1;
		ZeroDivisor = 0;
		tick;		
		GO = 0;
		tick;		
		R_lt_Y = 0;
		tick;
		if(control != s3plus) begin
			$display("ERROR at S3 left");

		end
		tick;
		if(control != s4) begin
			$display("ERROR at S4");

		end
		Counter_Out = 1;
		tick;
		tick;
		tick;
		if(control != IDLE) begin
			$display("ERROR at S0, expect IDLE");

		end
		
		$display("NO ERROR");
	end
endmodule
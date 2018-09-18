module TOPFULLFPGA(input button,GO, input clk100MHz,input [2:0] F,input rst,input [3:0]x,y
,output DONE, output [7:0] LEDSEL, LEDOUT);

supply1 [7:0] vcc;                          

wire DONT_USE, clk_5KHz;
wire [7:0] digit1, digit2,digit3,digit4,digit5;         
wire debounced_button;
wire [3:0] H,L,CSout;
wire [3:0] H1,H2,L1,L2,CS1,CS;
clk_gen CLK (clk100MHz, rst, DONT_USE, clk_5KHz);
        
button_debouncer b1(clk_5KHz,button,debounced_button);

TOPFULL T1(x,y,F,GO,debounced_button,rst, H,L,CSout, DONE);

assign H1=(F==2||F==6)?{H,L}%10: H%10;
assign H2=(F==2||F==6)?{H,L}/10%10:H/10;

assign L1=(F==2||F==6)?{H,L}/100:L%10;
assign L2=(F==2||F==6)?0:L/10;










LED7segment LED1 (H1, digit1);
LED7segment LED2 (H2, digit2);
LED7segment LED3 (L1, digit3);
LED7segment LED4 (L2, digit4);
LED7segment LED5 (CSout, digit5);



led_mux LED (clk_5KHz, rst, digit5, vcc, vcc, digit4, digit3, vcc, digit2, digit1,LEDSEL, LEDOUT);










endmodule
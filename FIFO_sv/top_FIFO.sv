module top_FIFO();

bit clk ;
always  #1 clk = ~clk ;

FIFO_if f_if(clk);

FIFO DUT(f_if);

FIFO_tb tb (f_if);

FIFO_monitor mon (f_if);



endmodule
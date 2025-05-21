module SVA (FIFO_if.SVA f1);

always_comb begin 
    if (!f1.rst_n) begin
       p1:assert final(f1.full == 0 && f1.empty == 1 && f1.almostfull == 0 && f1.almostempty == 0 && 
	   f1.underflow == 0 && f1.overflow == 0 && f1.wr_ack == 0 && DUT.rd_ptr == 0 && DUT.wr_ptr == 0 && DUT.count == 0);
    end
end


property p2;
@(posedge f1.clk) disable iff (!f1.rst_n) (f1.wr_en && !f1.full) |-> ##1 (f1.wr_ack == 1);
endproperty

assert property (p2); 
cover property (p2);


property p3;
@(posedge f1.clk) disable iff (!f1.rst_n) (f1.wr_en && f1.full) |-> ##1 (f1.overflow == 1);
endproperty

assert property (p3); 
cover property (p3);


property p4;
@(posedge f1.clk) disable iff (!f1.rst_n) (f1.rd_en && f1.empty) |-> ##1 (f1.underflow == 1);
endproperty

assert property (p4); 
cover property (p4);


property p5;
@(posedge f1.clk) disable iff (!f1.rst_n) (DUT.count == 0) |-> (f1.empty == 1);
endproperty

assert property (p5); 
cover property (p5);


property p6;
@(posedge f1.clk) disable iff (!f1.rst_n) (DUT.count == f1.FIFO_DEPTH) |-> (f1.full == 1);
endproperty

assert property (p6); 
cover property (p6);


property p7;
@(posedge f1.clk) disable iff (!f1.rst_n) (DUT.count == (f1.FIFO_DEPTH - 'b1)) |-> (f1.almostfull == 1);
endproperty

assert property (p7); 
cover property (p7);


property p8;
@(posedge f1.clk) disable iff (!f1.rst_n) (DUT.count == 1) |-> (f1.almostempty == 1);
endproperty

assert property (p8); 
cover property (p8);


property p9;
@(posedge f1.clk) disable iff (!f1.rst_n) ((!f1.rd_en throughout f1.wr_en[->8]) ##0 (DUT.wr_ptr == 0)) |-> (DUT.wr_ptr == 0);
endproperty

assert property (p9); 
cover property (p9);


property p10;
@(posedge f1.clk) disable iff (!f1.rst_n) ((!f1.wr_en throughout f1.rd_en[->8]) ##0 (DUT.rd_ptr == 0)) |-> (DUT.rd_ptr == 0);
endproperty

assert property (p10); 
cover property (p10);



always @(posedge f1.clk) begin
	p11:assert final(DUT.rd_ptr < (f1.FIFO_DEPTH) && DUT.wr_ptr < (f1.FIFO_DEPTH) && DUT.count <= (f1.FIFO_DEPTH));
end

    
endmodule
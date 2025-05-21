
module FIFO(FIFO_if.DUT f1);
 
localparam max_fifo_addr = $clog2(f1.FIFO_DEPTH);

reg [f1.FIFO_WIDTH-1:0] mem [f1.FIFO_DEPTH-1:0];

reg [max_fifo_addr-1:0] wr_ptr, rd_ptr;
reg [max_fifo_addr:0] count;

always @(posedge f1.clk or negedge f1.rst_n) begin
	if (!f1.rst_n) begin
		wr_ptr <= 0;
		f1.wr_ack <= 0;
		f1.overflow <= 0;
	end
	else if (f1.wr_en && count < f1.FIFO_DEPTH) begin
		mem[wr_ptr] <= f1.data_in;
		f1.wr_ack <= 1;
		wr_ptr <= wr_ptr + 1;
	end
	else begin 
		f1.wr_ack <= 0; 
		if (f1.full & f1.wr_en)
			f1.overflow <= 1;
		else
			f1.overflow <= 0;
	end
end

always @(posedge f1.clk or negedge f1.rst_n) begin
	if (!f1.rst_n) begin
		rd_ptr <= 0;
		f1.data_out <= 0;
		f1.underflow <= 0;
	end
	else if (f1.rd_en && count != 0) begin
		f1.data_out <= mem[rd_ptr];
		rd_ptr <= rd_ptr + 1;
	end

	else begin 
		
		if (f1.empty & f1.rd_en)
			f1.underflow <= 1;
		else
			f1.underflow <= 0;
	end

end

always @(posedge f1.clk or negedge f1.rst_n) begin
	if (!f1.rst_n) begin
		count <= 0;
	end
	else begin
		if	( ({f1.wr_en, f1.rd_en} == 2'b10) && !f1.full) 
			count <= count + 1;
		else if ( ({f1.wr_en, f1.rd_en} == 2'b01) && !f1.empty)
			count <= count - 1;
			else if ( ({f1.wr_en, f1.rd_en} == 2'b11) && f1.empty)
			count <= count + 1;
			else if ( ({f1.wr_en, f1.rd_en} == 2'b11) && f1.full)
			count <= count - 1;
			
	end
end

assign f1.full = (count == f1.FIFO_DEPTH)? 1 : 0;
assign f1.empty = (count == 0)? 1 : 0;
assign f1.almostfull = (count == f1.FIFO_DEPTH-1)? 1 : 0; 
assign f1.almostempty = (count == 1)? 1 : 0;




endmodule





package FIFO_scoreboard_pkg;
import FIFO_transaction_pkg::*;
import shared_pkg::*;


    class FIFO_scoreboard;
    parameter FIFO_WIDTH = 16;
    parameter FIFO_DEPTH = 8;
    parameter max_fifo_addr = $clog2(FIFO_DEPTH);

    logic [FIFO_WIDTH-1:0] data_out_ref;
    logic wr_ack_ref, overflow_ref;
    logic full_ref, empty_ref, almostfull_ref, almostempty_ref, underflow_ref;
    
    FIFO_transaction F_txn;



    logic [FIFO_WIDTH-1:0] mem [FIFO_DEPTH-1:0];
    logic [max_fifo_addr-1:0] wr_ptr, rd_ptr;
    logic [max_fifo_addr:0] count;
    

    task check_data(FIFO_transaction F_txn);
        reference_model(F_txn);
        if (F_txn.data_out != data_out_ref) begin
             error_count++;
            $display("Error at %t : data_out = %h, data_out_ref = %h", $time, F_txn.data_out, data_out_ref);
        end
        else begin
            correct_count++;
        end
    endtask 

    task reference_model(FIFO_transaction F_ref);
        
	if (!F_ref.rst_n) begin
		wr_ptr = 0;
		wr_ack_ref = 0;
		underflow_ref = 0;
        rd_ptr = 0;
		data_out_ref = 0;
		overflow_ref = 0;
        count = 0;

	end
	else begin

		 if (F_ref.wr_en && count < F_ref.FIFO_DEPTH) begin
		mem[wr_ptr] = F_ref.data_in;
		wr_ack_ref = 1;
		wr_ptr = wr_ptr + 1;
	end
	else begin 
		wr_ack_ref = 0; 
		if (full_ref & F_ref.wr_en)
			overflow_ref = 1;
		else
			overflow_ref = 0;
	end

	 if (F_ref.rd_en && count != 0) begin
		data_out_ref = mem[rd_ptr];
		rd_ptr = rd_ptr + 1;
	end

	else begin 
		
		if (empty_ref & F_ref.rd_en)
			underflow_ref = 1;
		else
			underflow_ref = 0;
	end

	full_ref = (count == F_ref.FIFO_DEPTH)? 1 : 0;
 empty_ref = (count == 0)? 1 : 0;
 almostfull_ref = (count == F_ref.FIFO_DEPTH-1)? 1 : 0; 
 almostempty_ref = (count == 1)? 1 : 0;
 
    	if	( ({F_ref.wr_en, F_ref.rd_en} == 2'b10) && !full_ref)     
			count = count + 1;
		else if ( ({F_ref.wr_en, F_ref.rd_en} == 2'b01) && !empty_ref)
			count = count - 1;
			else if ( ({F_ref.wr_en, F_ref.rd_en} == 2'b11) && empty_ref)
			count = count + 1;
			else if ( ({F_ref.wr_en, F_ref.rd_en} == 2'b11) && full_ref)
			count = count - 1;

	end
    endtask
    endclass
endpackage
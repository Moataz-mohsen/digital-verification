import FIFO_transaction_pkg::*;
import FIFO_coverage_pkg::*;
import FIFO_scoreboard_pkg::*;
import shared_pkg::*;
module FIFO_monitor(FIFO_if.MONITOR f_if);

FIFO_transaction fxtn;
FIFO_coverage cov;
FIFO_scoreboard sb;

initial begin
    cov = new();
    sb = new();
    fxtn = new();
    forever begin
        wait(t);      begin  
            @(negedge f_if.clk);
            fxtn.data_in = f_if.data_in;
            fxtn.wr_en = f_if.wr_en;
            fxtn.rd_en = f_if.rd_en;
            fxtn.rst_n = f_if.rst_n;
            fxtn.data_out = f_if.data_out;
            fxtn.wr_ack = f_if.wr_ack;
            fxtn.full = f_if.full;
            fxtn.empty = f_if.empty;
            fxtn.almostempty = f_if.almostempty;
            fxtn.almostfull = f_if.almostfull;
            fxtn.overflow = f_if.overflow;
            fxtn.underflow = f_if.underflow;
        
        fork 
        begin
            cov.sample_data(fxtn); 
        end
        begin
            sb.check_data(fxtn);
        end   
        join 
        if (test_finished==1) begin
            
            $display("test finished, error_count = %0d , correct_count = %0d",error_count,correct_count);
            $stop;
   
        end
        end
    end
end
endmodule
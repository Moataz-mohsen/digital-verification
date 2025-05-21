import FIFO_transaction_pkg::*;
import shared_pkg::*;

module FIFO_tb(FIFO_if.TEST f_if);

FIFO_transaction F_txnWrite;
FIFO_transaction F_txnRead;
FIFO_transaction F_txnWriteRead;

task INITIALIZE();
   f_if.rst_n = 1;
   f_if.data_in = 0;
   f_if.wr_en = 0;
   f_if.rd_en = 0;
   test_finished = 0;
endtask 

   task RESET();
   @(negedge f_if.clk);
   f_if.rst_n = 0;
   @(negedge f_if.clk);
   f_if.rst_n = 1;
   
   endtask

initial begin
   F_txnWrite = new();
F_txnRead = new(70,30);
F_txnWriteRead = new(50,50);
   INITIALIZE();
   RESET();
   @(negedge f_if.clk);
   @(negedge f_if.clk);

   repeat(10000) begin
      @(negedge f_if.clk);
      assert (F_txnWrite.randomize()) ;
      f_if.data_in = F_txnWrite.data_in;
      f_if.wr_en = F_txnWrite.wr_en;
      f_if.rd_en = F_txnWrite.rd_en;
      f_if.rst_n = F_txnWrite.rst_n;
      ->t;
   end

   repeat(10000) begin
      @(negedge f_if.clk);
      assert (F_txnRead.randomize()) ;
      f_if.data_in = F_txnRead.data_in;
      f_if.wr_en = F_txnRead.wr_en;
      f_if.rd_en = F_txnRead.rd_en;
      f_if.rst_n = F_txnRead.rst_n;
      ->t;
      
   end

   repeat(10000) begin
      @(negedge f_if.clk);
      assert (F_txnWriteRead.randomize()) ;
      f_if.data_in = F_txnWriteRead.data_in;
      f_if.wr_en = F_txnWriteRead.wr_en;
      f_if.rd_en = F_txnWriteRead.rd_en;
      f_if.rst_n = F_txnWriteRead.rst_n;
      ->t;
      
   end

   test_finished = 1;

end
endmodule
////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: UVM Example
// 
////////////////////////////////////////////////////////////////////////////////


import FIFO_test_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
module top();
  
  bit clk=0;

  initial begin
    forever begin
      #1 clk=~clk;
    end
  end
    FIFO_if f_if(clk);
    
    FIFO DUT(f_if);

    bind FIFO SVA inst(f_if.SVA);

    initial begin
      uvm_config_db #(virtual FIFO_if)::set(null,"uvm_test_top", "FIFO_if", f_if);
      run_test("FIFO_test");
    end

  
endmodule
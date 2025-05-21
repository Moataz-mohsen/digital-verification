package FIFO_read_seq_pkg;
import FIFO_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
 
class FIFO_read_seq extends uvm_sequence #(FIFO_seq_item);
`uvm_object_utils(FIFO_read_seq)

FIFO_seq_item seq_item;

function new(string name="FIFO_read_seq");
    super.new(name);
    
endfunction

task body;
seq_item=FIFO_seq_item::type_id::create("seq_item");
repeat(10000) begin
start_item(seq_item);
seq_item.RD_EN_ON_DIST=85;
seq_item.WR_EN_ON_DIST=15;
assert (seq_item.randomize()) ;


finish_item(seq_item);
end
endtask

endclass
    
endpackage
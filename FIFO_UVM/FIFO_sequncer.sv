package sequencer;
import FIFO_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class mysequncer extends uvm_sequencer #(FIFO_seq_item);
`uvm_component_utils(mysequncer)
    function new(string name ="mysequncer",uvm_component parent=null);
        super.new(name,parent);
    endfunction 
endclass 
endpackage
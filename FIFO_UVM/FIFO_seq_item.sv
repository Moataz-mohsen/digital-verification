package FIFO_seq_item_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"

    
    
class FIFO_seq_item extends uvm_sequence_item;
`uvm_object_utils(FIFO_seq_item)

parameter FIFO_WIDTH = 16;
parameter FIFO_DEPTH = 8;
parameter max_fifo_addr = $clog2(FIFO_DEPTH);
rand logic [FIFO_WIDTH-1:0] data_in;
rand logic rst_n, wr_en, rd_en;
logic [FIFO_WIDTH-1:0] data_out;
logic wr_ack, overflow;
logic full, empty, almostfull, almostempty, underflow;


integer RD_EN_ON_DIST,WR_EN_ON_DIST;

    function new(string name = "FIFO_seq_item");
        super.new(name);

    endfunction 
    
    
    
    constraint rst_n_dist {
        rst_n dist {0:=2 , 1:=98};
    }

    constraint wr_en_dist {
        wr_en dist {0:=100-WR_EN_ON_DIST , 1:=WR_EN_ON_DIST};
    }
    
    constraint rd_en_dist {
        rd_en dist {0:=100-RD_EN_ON_DIST , 1:=RD_EN_ON_DIST};
    }

endclass
    
endpackage
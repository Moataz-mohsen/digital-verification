package FIFO_coverage_pkg;
import FIFO_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_coverage extends uvm_component;
    `uvm_component_utils(FIFO_coverage)
    uvm_analysis_export #(FIFO_seq_item) cov_export;
    uvm_tlm_analysis_fifo #(FIFO_seq_item) cov_fifo;
    FIFO_seq_item cov_seq_item;
    covergroup cvr_gp;
        wr_en: coverpoint cov_seq_item.wr_en{
            bins high = {1};
            bins low = {0};
        }
        rd_en: coverpoint cov_seq_item.rd_en{
            bins high = {1};
            bins low = {0};
        }
        wr_ack: coverpoint cov_seq_item.wr_ack{
            bins high = {1};
            bins low = {0};
        }
        overflow: coverpoint cov_seq_item.overflow{
            bins high = {1};
            bins low = {0};
        }
        full: coverpoint cov_seq_item.full {
            bins high = {1};
            bins low = {0};
        }
        underflow: coverpoint cov_seq_item.underflow{
            bins high = {1};
            bins low = {0};
        }
        empty: coverpoint cov_seq_item.empty;
        almostfull: coverpoint cov_seq_item.almostfull;
        almostempty: coverpoint cov_seq_item.almostempty;

        wr_re_wr_ack: cross wr_en,rd_en,wr_ack {
            ignore_bins B_0x1 = binsof(wr_en.low) && binsof(rd_en) && binsof(wr_ack.high);
        }
        wr_re_overflow: cross wr_en,rd_en,overflow {
            ignore_bins B_0x1 = binsof(wr_en.low) && binsof(rd_en) && binsof(overflow.high);
        }
        wr_re_full: cross wr_en,rd_en,full {
            ignore_bins B_x11 = binsof(wr_en) && binsof(rd_en.high) && binsof(full.high);
        }
        wr_re_underflow: cross wr_en,rd_en,underflow {
            ignore_bins B_x01 = binsof(wr_en) && binsof(rd_en.low) && binsof(underflow.high);
        }
        wr_re_empty: cross wr_en,rd_en,empty;
        wr_re_almostfull: cross wr_en,rd_en,almostfull;
        wr_re_almostempty: cross wr_en,rd_en,almostempty;
    endgroup


    function new(string name="alsu_coverage",uvm_component parent=null);
        super.new(name,parent);
        cvr_gp=new();
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cov_export = new("cov_export",this);
        cov_fifo = new("cov_fifo",this);
        
        endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        cov_export.connect(cov_fifo.analysis_export);
    endfunction
    
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            cov_fifo.get(cov_seq_item);
            cvr_gp.sample();

        end
    endtask


    endclass
    
endpackage
package FIFO_coverage_pkg;
import FIFO_transaction_pkg::*;
class FIFO_coverage;
    FIFO_transaction F_cvg_txn;
covergroup cvr_gp;
        wr_en: coverpoint F_cvg_txn.wr_en{
            bins high = {1};
            bins low = {0};
        }
        rd_en: coverpoint F_cvg_txn.rd_en{
            bins high = {1};
            bins low = {0};
        }
        wr_ack: coverpoint F_cvg_txn.wr_ack{
            bins high = {1};
            bins low = {0};
        }
        overflow: coverpoint F_cvg_txn.overflow{
            bins high = {1};
            bins low = {0};
        }
        full: coverpoint F_cvg_txn.full {
            bins high = {1};
            bins low = {0};
        }
        underflow: coverpoint F_cvg_txn.underflow{
            bins high = {1};
            bins low = {0};
        }
        empty: coverpoint F_cvg_txn.empty;
        almostfull: coverpoint F_cvg_txn.almostfull;
        almostempty: coverpoint F_cvg_txn.almostempty;

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

    function new();
        cvr_gp = new();
    endfunction //new()

    function void sample_data(FIFO_transaction F_txn);
        F_cvg_txn =  F_txn;
        cvr_gp.sample();
    endfunction
endclass //FIFO_coverage
endpackage
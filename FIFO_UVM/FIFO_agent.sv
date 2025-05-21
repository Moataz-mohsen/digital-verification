package FIFO_agent_pkg;
import FIFO_config_pkg::*;
import sequencer::*;
import FIFO_driver_pkg::*;
import FIFO_seq_item_pkg::*;
import FIFO_monitior_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_agent extends uvm_agent;
`uvm_component_utils(FIFO_agent)
FIFO_driver driver;
  mysequncer sqr;
  FIFO_monitor mon;
  FIFO_config_obj FIFO_config;
  uvm_analysis_port #(FIFO_seq_item) agent_ap;

  function new(string name="FIFO_agent",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(FIFO_config_obj)::get(this,"","a2",FIFO_config))
            `uvm_fatal("FIFO_if_DRIVER-002","FIFO_if_if not set")

        sqr=mysequncer::type_id::create("sqr",this);
        driver=FIFO_driver::type_id::create("driver",this);
        mon=FIFO_monitor::type_id::create("mon",this);
        agent_ap=new("agent_ap",this);
        
    endfunction 

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        driver.FIFO_driver_vif=FIFO_config.FIFO_config_vif;
        mon.FIFO_test_vif=FIFO_config.FIFO_config_vif;
        driver.seq_item_port.connect(sqr.seq_item_export);
        mon.mon_ap.connect(agent_ap);
    endfunction

    

endclass
endpackage
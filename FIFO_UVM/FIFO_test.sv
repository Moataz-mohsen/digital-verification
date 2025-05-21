////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: UVM Example
// 
////////////////////////////////////////////////////////////////////////////////
package FIFO_test_pkg;
import FIFO_env_pkg::*;
import FIFO_config_pkg::*;
import FIFO_read_seq_pkg::*;
import FIFO_write_seq_pkg::*;
import FIFO_readnwrite_seq_pkg::*;
import FIFO_reset_seq_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"


class FIFO_test extends uvm_test;
  
  `uvm_component_utils(FIFO_test)

    FIFO_env env;
    FIFO_config_obj FIFO_obj_test;
    FIFO_reset_seq reset_seq;
    FIFO_read_seq read_seq;
    FIFO_write_seq write_seq;
    FIFO_readnwrite_seq  readnwrite_seq;

    function new(string name ="FIFO_test",uvm_component parent=null);
      super.new(name,parent);
      
    endfunction

    function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);


      env=FIFO_env::type_id::create("env",this);
      read_seq=FIFO_read_seq::type_id::create("read_seq");
       reset_seq=FIFO_reset_seq::type_id::create("reset_seq");
       FIFO_obj_test=FIFO_config_obj::type_id::create("FIFO_obj_test");
        write_seq=FIFO_write_seq::type_id::create("write_seq");
        readnwrite_seq=FIFO_readnwrite_seq::type_id::create("readnwrite_seq");

        if(!uvm_config_db#(virtual FIFO_if)::get(this,"","FIFO_if",FIFO_obj_test.FIFO_config_vif))
      ` uvm_fatal("build phase","TEST-unable to get alsu_if");

        uvm_config_db#(FIFO_config_obj)::set(this,"*","a2",FIFO_obj_test);
    endfunction
    

    task run_phase(uvm_phase phase) ;
     super.run_phase(phase);

     phase.raise_objection(this);
     
     
      
    
      `uvm_info("run_phase","reset",UVM_LOW)
      reset_seq.start(env.agt.sqr);
      `uvm_info("run_phase","reset done",UVM_LOW)


        `uvm_info("run_phase","stimuls",UVM_LOW)
        write_seq.start(env.agt.sqr);
      `uvm_info("run_phase","stimuls done",UVM_LOW)
      
    

      `uvm_info("run_phase","stimuls",UVM_LOW)
      read_seq.start(env.agt.sqr);
      `uvm_info("run_phase","stimuls done",UVM_LOW)

      


            `uvm_info("run_phase","stimuls",UVM_LOW)
      readnwrite_seq.start(env.agt.sqr);
      `uvm_info("run_phase","stimuls done",UVM_LOW)

      
    
      

      phase.drop_objection(this);
    endtask :run_phase

  
endclass: FIFO_test
endpackage


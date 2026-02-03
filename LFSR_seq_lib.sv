typedef class LFSR_env;
  
class LFSR_data_sequence extends uvm_sequence#(LFSR_seq_item);    
    `uvm_object_utils(LFSR_data_sequence);
    
    function new(string name="LFSR_data_sequence");
        super.new(name);
    endfunction
    
    task pre_body();
        if(starting_phase != null)
            starting_phase.raise_objection(this);
    endtask
   
    task body();
        req = LFSR_seq_item::type_id::create("req");
        start_item(req);
        assert(req.randomize());
        finish_item(req);
    endtask
    
    task post_body();
        if(starting_phase != null)
        starting_phase.drop_objection(this);
    endtask   
endclass
  
class LFSR_virtual_sequence extends uvm_sequence;
    `uvm_object_utils(LFSR_virtual_sequence);

    LFSR_env LFSR_env_i;
    LFSR_data_sequence LFSR_data_sequence_i;
      
    function new(string name="LFSR_virtual_sequence");
        super.new(name);
    endfunction
      
    function void set_env(LFSR_env LFSR_env_i);
        this.LFSR_env_i=LFSR_env_i;
    endfunction
      
    task pre_body();
        if(starting_phase != null)
            starting_phase.raise_objection(this);
        LFSR_data_sequence_i=LFSR_data_sequence::type_id::create("LFSR_data_sequence_i");
    endtask
      
    task body();
        repeat(500) begin
            LFSR_data_sequence_i.start(LFSR_env_i.LFSE_agent_i.LFSR_sequencer_i);
         end
    endtask
    
    task post_body();  
        if(starting_phase != null)
            starting_phase.drop_objection(this);
    endtask

endclass        
class LFSR_agent extends uvm_agent;
    `uvm_component_utils(LFSR_agent);
    
    LFSR_driver LFSR_driver_i;
    LFSR_sequencer LFSR_sequencer_i;
    LFSR_monitor LFSR_monitor_i;
   
    function new (string name = "LFSR_agent", uvm_component parent);
        super.new(name, parent);
    endfunction : new
  
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        LFSR_driver_i=LFSR_driver::type_id::create("LFSR_driver_i",this);
        LFSR_sequencer_i=LFSR_sequencer::type_id::create("LFSR_sequencer_i",this);
        LFSR_monitor_i=LFSR_monitor::type_id::create("LFSR_monitor_i",this);           
    endfunction

    function void connect_phase(uvm_phase phase);
        LFSR_driver_i.seq_item_port.connect(LFSR_sequencer_i.seq_item_export);
    endfunction
  
endclass
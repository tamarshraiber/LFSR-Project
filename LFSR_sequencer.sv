class LFSR_sequencer extends uvm_sequencer#(LFSR_seq_item);
    `uvm_component_utils(LFSR_sequencer);

    function new(string name = "LFSR_sequencer", uvm_component parent=null);
        super.new(name,parent);
    endfunction

endclass:LFSR_sequencer
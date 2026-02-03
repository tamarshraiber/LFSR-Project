class LFSR_sequence extends uvm_sequence#(LFSR_seq_item);
    `uvm_object_utils(LFSR_sequence);
  
    function new (string name = "LFSR_sequence");
        super.new(name);
    endfunction

    task pre_body();
        if(starting_phase != null)
            starting_phase.raise_objection(this);
    endtask

    task body();
        repeat(500) begin
            `uvm_do(req);
        end
    endtask
  
    task post_body();  
        if(starting_phase != null)
            starting_phase.drop_objection(this);
    endtask
endclass
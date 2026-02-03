class LFSR_test extends uvm_test;
    `uvm_component_utils(LFSR_test);

    LFSR_env LFSR_env_i;
    LFSR_virtual_sequence LFSR_virtual_sequence_i;

    function new (string name = "LFSR_test", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        LFSR_env_i = LFSR_env::type_id::create("LFSR_env_i", this);
        LFSR_virtual_sequence_i=LFSR_virtual_sequence::type_id::create("LFSR_virtual_sequence_i", this);
    endfunction

    function void start_of_simulation_phase(uvm_phase phase);
        LFSR_virtual_sequence_i.set_env(LFSR_env_i);
    endfunction
  
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
	    #10;
  	    LFSR_virtual_sequence_i.start(null);
        #2000
        phase.drop_objection(this);
    endtask  
endclass
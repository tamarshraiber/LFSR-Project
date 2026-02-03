class LFSR_env extends uvm_env;
    `uvm_component_utils(LFSR_env);
  
    LFSR_agent LFSE_agent_i;
    LFSR_scoreboard LFSR_scoreboard_i; 
  
    function new(string name = "LFSR_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        LFSE_agent_i = LFSR_agent::type_id::create("LFSE_agent_i", this);
        LFSR_scoreboard_i = LFSR_scoreboard::type_id::create("LFSR_scoreboard_i", this);
    endfunction
  
    function void connect_phase(uvm_phase phase);
        LFSE_agent_i.LFSR_monitor_i.mon_analysis_port_in.connect(LFSR_scoreboard_i.expected_port);
        LFSE_agent_i.LFSR_monitor_i.mon_analysis_port_out.connect(LFSR_scoreboard_i.actual_port);
    endfunction
endclass

class LFSR_monitor extends uvm_monitor;
   `uvm_component_utils (LFSR_monitor)
  
    virtual LFSR_if LFSR_if_i;
    bit enable_check = 1;

    uvm_analysis_port #(LFSR_seq_item) mon_analysis_port_in;
    uvm_analysis_port #(LFSR_seq_item) mon_analysis_port_out;
  
    LFSR_seq_item item_out;
    LFSR_seq_item item_in;
    function new (string name, uvm_component parent= null);
        super.new (name, parent);
    endfunction
  
    virtual function void build_phase (uvm_phase phase);
        super.build_phase (phase);

        mon_analysis_port_in = new ("mon_analysis_port_in", this);
        mon_analysis_port_out = new ("mon_analysis_port_out", this);
        item_out = LFSR_seq_item::type_id::create("item_out", this);
        item_in = LFSR_seq_item::type_id::create("item_in", this);

        if (! uvm_config_db #(virtual LFSR_if) :: get (this, "", "LFSR_if_i", LFSR_if_i)) begin
            `uvm_error (get_type_name (), "DUT interface not found")
        end
   endfunction

  
    virtual task run_phase (uvm_phase phase);
        item_out = LFSR_seq_item::type_id::create("item_out", this);
        fork
            forever begin
            @(posedge LFSR_if_i.clk);
                if (LFSR_if_i.data_valid_out == 1) begin
                    item_out.data_out       = LFSR_if_i.data_out;
                    item_out.data_valid_out = LFSR_if_i.data_valid_out;
                    mon_analysis_port_out.write(item_out);

                    `uvm_info(get_type_name(), $sformatf("MON >>> OUT: data_out=0x%08h, data_valid_out=%0b",
                    item_out.data_out, item_out.data_valid_out), UVM_MEDIUM)
                end
            end

            forever begin
            @(posedge LFSR_if_i.clk);
                if (LFSR_if_i.data_valid_in == 1) begin
                    item_in.data_in            = LFSR_if_i.data_in;
                    item_in.data_valid_in      = LFSR_if_i.data_valid_in;
                    item_in.polynomial_select  = LFSR_if_i.polynomial_select;
                    item_in.seed_value         = LFSR_if_i.seed_value;
                    item_in.seed_load          = LFSR_if_i.seed_load;
                    mon_analysis_port_in.write(item_in);

                    `uvm_info(get_type_name(), $sformatf("MON >>> IN: data_in=0x%08h, data_valid_in=%0b, seed_load=%0b, seed_value=0x%08h, polynomial_select=%0d",
                        item_in.data_in, item_in.data_valid_in, item_in.seed_load, item_in.seed_value, item_in.polynomial_select), UVM_MEDIUM)
                end
            end
        join_none
    endtask
     
endclass










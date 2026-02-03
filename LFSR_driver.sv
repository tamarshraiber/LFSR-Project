class LFSR_driver extends uvm_driver #(LFSR_seq_item); 
    `uvm_component_utils (LFSR_driver) 
  
    virtual LFSR_if LFSR_if_i; 
  
    function new (string name, uvm_component parent); 
        super.new (name, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase); 
        super.build_phase (phase);
        if (! uvm_config_db #(virtual LFSR_if) :: get (this, "", "LFSR_if_i", LFSR_if_i)) begin
            `uvm_fatal (get_type_name (), "Didn't get handle to virtual interface LFSR_if_i")
        end
    endfunction 
  
    task run_phase (uvm_phase phase); 
        super.run_phase (phase); 

        forever begin       
            seq_item_port.get_next_item (req);
            drive_item (req);
            seq_item_port.item_done ();
        end
    endtask
  
    virtual task drive_item (LFSR_seq_item req);

        if (LFSR_if_i.reset_n) begin
            LFSR_if_i.data_valid_in     <= 1;
            LFSR_if_i.data_in           <= req.data_in;
            LFSR_if_i.polynomial_select <= req.polynomial_select;
            LFSR_if_i.seed_value        <= req.seed_value;
            LFSR_if_i.seed_load         <= req.seed_load;

            `uvm_info(get_type_name(), $sformatf("DRIVE >>> data_in=0x%08h, data_valid_in=%0b, seed_load=%0b, seed_value=0x%08h, polynomial_select=%0d",
                req.data_in, req.data_valid_in, req.seed_load, req.seed_value, req.polynomial_select), UVM_MEDIUM)

            @(posedge LFSR_if_i.clk);

                LFSR_if_i.data_valid_in <= 0;
                LFSR_if_i.seed_load     <= 0;  
        end
    endtask
endclass


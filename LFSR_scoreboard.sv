class LFSR_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(LFSR_scoreboard);
    `uvm_analysis_imp_decl(_actual)
    `uvm_analysis_imp_decl(_expected)

    uvm_analysis_imp_actual#(LFSR_seq_item, LFSR_scoreboard) actual_port;
    uvm_analysis_imp_expected#(LFSR_seq_item, LFSR_scoreboard) expected_port;
  
    virtual LFSR_if LFSR_if_i;

    LFSR_seq_item data_in_q[$];
    LFSR_seq_item data_out_q[$];
  
    function new(string name = "LFSR_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        actual_port = new("actual", this);
        expected_port = new("expected", this);
    
    
        if (!uvm_config_db#(virtual LFSR_if)::get(this, "", "LFSR_if_i", LFSR_if_i)) begin
            `uvm_fatal(get_type_name(), "Could not get LFSR_if from config DB");
        end   
    endfunction
  
    function void write_expected(LFSR_seq_item item);
        LFSR_seq_item cloned_item;
        uvm_object temp_obj;

        static bit [31:0] lfsr = 1;
        bit [31:0] pol_mask;
        bit xor_of_res;
        bit [31:0] next_lfsr;

        case(item.polynomial_select)
            3'b000: pol_mask = 32'b00000000000000000000000001001000;
            3'b001: pol_mask = 32'b00000000000000000110000000000000;
            3'b010: pol_mask = 32'b00000000010000100000000000000000;
            3'b011: pol_mask = 32'b01001000000000000000000000000000;
            default: pol_mask = 32'b00000000000000000000000001001000;
        endcase

        if (!LFSR_if_i.reset_n) begin
            lfsr = 1;
            item.data_out = 0;
            item.data_valid_out = 0;
            item.data_in = 0;
            item.data_valid_in = 0;
        end else begin
            if (item.seed_load)
                next_lfsr = item.seed_value;
            else begin
                xor_of_res = ^(pol_mask & lfsr);
                next_lfsr = {lfsr[30:0], xor_of_res};
            end

            if (item.data_valid_in) begin
                item.data_out = item.data_in ^ next_lfsr;
                item.data_valid_out = 1;
                lfsr = next_lfsr;

            end else begin
                item.data_out = 0;
                item.data_valid_out = 0;
            end

        end

        temp_obj = item.clone();

        if (!$cast(cloned_item, temp_obj)) begin
            `uvm_error("CAST_FAIL", "Failed to cast cloned object to LFSR_seq_item")
            return;
        end

        data_in_q.push_back(cloned_item);
    endfunction
  
    function void write_actual(LFSR_seq_item item);
        LFSR_seq_item cloned_item;
        uvm_object temp_obj;

        LFSR_seq_item expected_item;

        if (data_in_q.size() == 0) begin
            `uvm_error(get_type_name(), "No expected data to compare to");
            return;
        end

        expected_item = data_in_q.pop_front();
    
        if (expected_item.data_out !== item.data_out) begin
            `uvm_error(get_type_name(), $sformatf("Mismatch! expected=%0d, actual=%0d",expected_item.data_out, item.data_out));
        end else begin
            `uvm_info(get_type_name(), $sformatf("Match! data_out=%0d", item.data_out), UVM_LOW);
        end

        temp_obj = item.clone();
        if (!$cast(cloned_item, temp_obj)) begin
            `uvm_error("CAST_FAIL", "Failed to cast cloned object to LFSR_seq_item");
            return;
        end

        data_out_q.push_back(cloned_item);
    endfunction

endclass

























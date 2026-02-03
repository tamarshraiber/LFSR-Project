import uvm_pkg::*;
`include "uvm_macros.svh"

class LFSR_seq_item extends uvm_sequence_item;
    rand    bit     [31:0]  data_in;
            bit             data_valid_in;
            bit     [31:0]  data_out;
            bit             data_valid_out;
    rand    bit     [2:0]   polynomial_select;
    rand    bit     [31:0]  seed_value;
    rand    bit             seed_load;
  
    `uvm_object_utils_begin(LFSR_seq_item);
        `uvm_field_int(data_in,UVM_DEFAULT)
  	    `uvm_field_int(data_valid_in,UVM_DEFAULT)
  	    `uvm_field_int(data_out,UVM_DEFAULT)
        `uvm_field_int(data_valid_out,UVM_DEFAULT)
        `uvm_field_int(polynomial_select,UVM_DEFAULT)
        `uvm_field_int(seed_value,UVM_DEFAULT)
        `uvm_field_int(seed_load,UVM_DEFAULT)
    `uvm_object_utils_end

    constraint polynomial_select_c { 
        polynomial_select >= 0;
        polynomial_select <= 3;
    }

    constraint seed_load_c {
        seed_load dist {0 := 80, 1 := 20};
    }

    constraint seed_value_c {
        seed_value inside {[1:32'hFFFFFFFF]};
    }

    function new(string name = "LFSR_seq_item");
        super.new(name);
    endfunction:new  
endclass

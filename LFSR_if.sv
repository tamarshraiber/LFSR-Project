interface LFSR_if();
    bit clk;
    bit reset_n;
    bit [31:0] data_in;
    bit data_valid_in;
    bit [31:0] data_out;
    bit data_valid_out;
    bit [2:0] polynomial_select;
    bit [31:0] seed_value;
    bit seed_load;
  
endinterface: LFSR_if
  
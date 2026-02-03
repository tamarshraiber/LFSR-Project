import uvm_pkg::*;
`include "LFSR_pkg.sv"

module LFSR_tb;
    bit clk=0;
    always #4.167 clk=~clk;//120 MHz
  
    bit reset_n;
    initial begin
        reset_n=0;
        #10
        reset_n=1;
    end
    
    LFSR_if LFSR_if_i();
    assign LFSR_if_i.clk = clk;
    assign LFSR_if_i.reset_n = reset_n;
    
    LFSR LFSR_i(
        .clk(LFSR_if_i.clk),
        .reset_n(LFSR_if_i.reset_n),
        .data_in(LFSR_if_i.data_in),
        .data_valid_in(LFSR_if_i.data_valid_in),
        .data_out(LFSR_if_i.data_out),
        .data_valid_out(LFSR_if_i.data_valid_out),
        .polynomial_select (LFSR_if_i.polynomial_select ),
        .seed_value(LFSR_if_i.seed_value),
        .seed_load(LFSR_if_i.seed_load)
    );
    
    initial begin
        uvm_config_db#(virtual LFSR_if)::set(null,"*","LFSR_if_i",LFSR_if_i);
        
        $dumpfile("dump.vcd");
        $dumpvars(0, LFSR_tb);
    end

    initial begin
        LFSR_if_i.polynomial_select = 3'b000;
        LFSR_if_i.seed_value = 32'b1;
        LFSR_if_i.seed_load = 1;
        
    end
    
    initial begin
        run_test("LFSR_test");
    end      
endmodule
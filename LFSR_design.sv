module LFSR(
    input  reg clk,
    input reg reset_n,
    input reg [31:0] data_in,
    input reg data_valid_in,
    input reg [2:0] polynomial_select,
    input reg [31:0] seed_value,
    input reg seed_load,
    output reg [31:0] data_out,
    output reg data_valid_out
);

    reg     [31:0]  polinomial_mask;
    reg     [31:0]  lfsr;
    wire            xor_of_res;
    reg     [31:0]  next_lfsr;

    always @(*) begin
        case(polynomial_select)
            3'b000: polinomial_mask = 32'b00000000000000000000000001001000;
            3'b001: polinomial_mask = 32'b00000000000000000110000000000000;
            3'b010: polinomial_mask = 32'b00000000010000100000000000000000;
            3'b011: polinomial_mask = 32'b01001000000000000000000000000000;
            default: polinomial_mask = 32'b00000000000000000000000001001000;
        endcase
    end

    assign xor_of_res = ^(polinomial_mask & lfsr);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            lfsr            <= 1;
            data_out        <= 0;
            data_valid_out  <= 0;
        end else begin
            if (seed_load)
                next_lfsr = seed_value;
            else
                next_lfsr = {lfsr[30:0], xor_of_res};

            if (data_valid_in) begin
                data_out        <= data_in ^ next_lfsr; 
                data_valid_out  <= 1;
            
                lfsr            <= next_lfsr;

            end else begin
                data_out        <= 0;
                data_valid_out  <= 0;
            end
        end
    end
    
endmodule
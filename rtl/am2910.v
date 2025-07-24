module am2910 (
    input             CP,
    input             RESET_N,
    input [3:0]       I,
    input [3:0]       D,
    input             CC,
    input             CCEN,
    input             RLD,
    
    output            FULL,
    output            PL,
    output            MAP,
    output            VECT,
    output [3:0]      Y
);

    wire CI = 1'b1;
    wire OE = 1'b0;

    wire [2:0]  w_mux_sel;
    wire        w_stack_op_push;
    wire        w_stack_op_pop;
    wire        w_stack_op_clear;
    wire        w_r_op_load;
    wire        w_r_op_dec;

    wire [3:0]  w_upc_out;
    wire [3:0]  w_r_out;
    wire [3:0]  w_f_out;
    reg  [3:0]  w_mux_out;
    wire [3:0]  w_upc_next;
    
    wire        w_r_is_zero;
    wire        w_test_passed;
    wire        w_stack_full;

    assign w_test_passed = (~CCEN & ~CC) | CCEN;

    always @(*) begin
        case (w_mux_sel)
            3'b000:  w_mux_out = w_upc_out;
            3'b001:  w_mux_out = w_f_out;
            3'b010:  w_mux_out = D;
            3'b011:  w_mux_out = w_r_out;
            3'b100:  w_mux_out = 4'h0;
            default: w_mux_out = 4'h0;
        endcase
    end

    assign w_upc_next = w_mux_out + CI;
    
    assign Y = (~OE) ? w_mux_out : 4'hZ;
    assign FULL = ~w_stack_full;

    instruction_decoder decoder (
        .I(I),
        .test_passed(w_test_passed),
        .R_is_zero(w_r_is_zero),
        .mux_sel(w_mux_sel),
        .stack_op_push(w_stack_op_push),
        .stack_op_pop(w_stack_op_pop),
        .stack_op_clear(w_stack_op_clear),
        .r_op_load(w_r_op_load),
        .r_op_dec(w_r_op_dec),
        .pl_en(PL),
        .map_en(MAP),
        .vect_en(VECT)
    );

    microprogram_counter upc_reg (
        .clk(CP),
        .reset_n(RESET_N),
        .next_pc_in(w_upc_next),
        .pc_out(w_upc_out)
    );

    register_counter r_reg (
        .clk(CP),
        .reset_n(RESET_N),
        .load_en(w_r_op_load || ~RLD),
        .dec_en(w_r_op_dec && RLD),
        .data_in(D),
        .data_out(w_r_out),
        .is_zero(w_r_is_zero)
    );

    stack stack_file (
        .clk(CP),
        .reset_n(RESET_N),
        .push_en(w_stack_op_push),
        .pop_en(w_stack_op_pop),
        .clear_en(w_stack_op_clear),
        .data_in(w_upc_next),
        .data_out(w_f_out),
        .full(w_stack_full),
        .empty()
    );

endmodule
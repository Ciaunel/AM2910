module instruction_decoder (
    input [3:0]  I,
    input test_passed,
    input R_is_zero,
    output reg [2:0] mux_sel,
    output reg stack_op_push,
    output reg stack_op_pop,
    output reg stack_op_clear,
    output reg r_op_load,
    output reg r_op_dec,
    output reg pl_en,
    output reg map_en,
    output reg vect_en
);

    localparam JZ=4'b0000, CJS=4'b0001, JMAP=4'b0010, CJP=4'b0011, PUSH=4'b0100, JSRP=4'b0101, CJV=4'b0110,
               JRP=4'b0111, RFCT=4'b1000, RPCT=4'b1001, CRTN=4'b1010, CJPP=4'b1011, LDCT=4'b1100, 
               LOOP=4'b1101, CONT=4'b1110, TWB=4'b1111;
               
    localparam MUX_SEL_PC = 3'b000, MUX_SEL_F = 3'b001, MUX_SEL_D = 3'b010, MUX_SEL_R = 3'b011, MUX_SEL_ZERO = 3'b100;

    always @(*) begin
        mux_sel = MUX_SEL_PC;
        stack_op_push = 1'b0; stack_op_pop = 1'b0; stack_op_clear = 1'b0;
        r_op_load = 1'b0; r_op_dec = 1'b0;
        pl_en = 1'b1; map_en = 1'b1; vect_en = 1'b1;

        case (I)
            JZ:   begin mux_sel = MUX_SEL_ZERO; stack_op_clear = 1'b1; pl_en = 1'b0; end
            CJS:  begin if(test_passed) begin mux_sel = MUX_SEL_D; stack_op_push = 1'b1; end else begin mux_sel = MUX_SEL_PC; end pl_en = 1'b0; end
            JMAP: begin mux_sel = MUX_SEL_D; map_en = 1'b0; end
            CJP:  begin mux_sel = test_passed ? MUX_SEL_D : MUX_SEL_PC; pl_en = 1'b0; end
            PUSH: begin mux_sel = MUX_SEL_PC; stack_op_push = 1'b1; r_op_load = test_passed; pl_en = 1'b0; end
            JSRP: begin mux_sel = test_passed ? MUX_SEL_D : MUX_SEL_R; stack_op_push = 1'b1; pl_en = 1'b0; end
            CJV:  begin mux_sel = test_passed ? MUX_SEL_D : MUX_SEL_PC; vect_en = 1'b0; end
            JRP:  begin mux_sel = test_passed ? MUX_SEL_D : MUX_SEL_R; pl_en = 1'b0; end
            RFCT: begin if(!R_is_zero) begin mux_sel = MUX_SEL_F; r_op_dec = 1'b1; end else begin mux_sel = MUX_SEL_PC; stack_op_pop = 1'b1; end pl_en = 1'b0; end
            RPCT: begin if(!R_is_zero) begin mux_sel = MUX_SEL_D; r_op_dec = 1'b1; end else begin mux_sel = MUX_SEL_PC; end pl_en = 1'b0; end
            CRTN: begin if(test_passed) begin mux_sel = MUX_SEL_F; stack_op_pop = 1'b1; end else begin mux_sel = MUX_SEL_PC; end pl_en = 1'b0; end
            CJPP: begin if(test_passed) begin mux_sel = MUX_SEL_D; stack_op_pop = 1'b1; end else begin mux_sel = MUX_SEL_PC; end pl_en = 1'b0; end
            LDCT: begin mux_sel = MUX_SEL_PC; r_op_load = 1'b1; pl_en = 1'b0; end
            LOOP: begin if(test_passed) begin mux_sel = MUX_SEL_PC; stack_op_pop = 1'b1; end else begin mux_sel = MUX_SEL_F; end pl_en = 1'b0; end
            CONT: begin mux_sel = MUX_SEL_PC; pl_en = 1'b0; end
            TWB:  begin if(test_passed) begin mux_sel=MUX_SEL_PC; stack_op_pop=1'b1; end else if(!R_is_zero) begin mux_sel=MUX_SEL_F; r_op_dec=1'b1; end else begin mux_sel=MUX_SEL_D; stack_op_pop=1'b1; end pl_en = 1'b0; end
            default: begin mux_sel = MUX_SEL_PC; pl_en = 1'b0; end
        endcase
    end
endmodule
`timescale 1ns / 1ps

module instruction_decoder (
    // Intrari
    input wire [3:0] i,             // Instruction bits
    input wire cc,                   // Condition code
    input wire ccen_n,               // Condition code enable (active low)
    input wire rc_is_zero,          // Register/Counter is zero flag

    // Iesiri de control
    output reg [1:0] stack_op,     // 00:HOLD, 01:PUSH, 10:POP, 11:RESET
    output reg [1:0] rc_op,        // 00:HOLD, 01:LOAD, 10:DEC
    output reg [1:0] y_mux_sel,    // 00:µPC, 01:D, 10:R, 11:F (Stiva)
    output reg pl_n,
    output reg map_n,
    output reg vect_n
);

    // Definirea starilor pentru operatii pentru claritate
    localparam HOLD  = 2'b00;
    localparam PUSH  = 2'b01;
    localparam POP   = 2'b10;
    localparam RESET = 2'b11;

    localparam RC_HOLD = 2'b00;
    localparam RC_LOAD = 2'b01;
    localparam RC_DEC  = 2'b10;
    
    localparam MUX_PC = 2'b00;
    localparam MUX_D  = 2'b01;
    localparam MUX_R  = 2'b10;
    localparam MUX_F  = 2'b11;

    wire test_passed;
    // Testul trece daca CCEN este dezactivat (HIGH) sau daca CC este activ (LOW)
    assign test_passed = (~ccen_n) || (cc == 1'b0);

    always @(*) begin
        // Valori implicite pentru a evita latch-urile
        stack_op  = HOLD;
        rc_op     = RC_HOLD;
        y_mux_sel = MUX_PC;
        pl_n      = 1'b1;
        map_n     = 1'b1;
        vect_n    = 1'b1;

        case (i)
            4'h0: begin // JZ
                y_mux_sel = MUX_D; // Sursa este 0, gestionata in modulul top
                pl_n = 1'b0;
                stack_op = RESET;
            end
            4'h1: begin // CJS
                pl_n = 1'b0;
                if (test_passed) begin
                    y_mux_sel = MUX_D; 
                    stack_op = PUSH; 
                end else begin
                    y_mux_sel = MUX_PC; 
                end
            end
            4'h2: begin // JMAP
                y_mux_sel = MUX_D;
                map_n = 1'b0;
            end
            4'h3: begin // CJP
                pl_n = 1'b0;
                if (test_passed) begin
                    y_mux_sel = MUX_D;
                end else begin
                    y_mux_sel = MUX_PC;
                end
            end
            4'h4: begin // PUSH
                pl_n = 1'b0;
                y_mux_sel = MUX_PC;
                stack_op = PUSH;
                if (test_passed) begin
                    rc_op = RC_LOAD;
                end
            end
            4'h5: begin // JSRP
                pl_n = 1'b0;
                stack_op = PUSH;
                if (test_passed) begin
                    y_mux_sel = MUX_D;
                end else begin
                    y_mux_sel = MUX_R;
                end
            end
            4'h6: begin // CJV
                vect_n = 1'b0;
                if (test_passed) begin
                    y_mux_sel = MUX_D;
                end else begin
                    y_mux_sel = MUX_PC;
                end
            end
            4'h7: begin // JRP
                pl_n = 1'b0;
                if (test_passed) begin
                    y_mux_sel = MUX_D;
                end else begin
                    y_mux_sel = MUX_R;
                end
            end
            4'h8: begin // RFCT
                pl_n = 1'b0;
                if (!rc_is_zero) begin
                    y_mux_sel = MUX_F;
                    rc_op = RC_DEC;
                end else begin
                    y_mux_sel = MUX_PC;
                    stack_op = POP;
                end
            end
            4'h9: begin // RPCT
                pl_n = 1'b0;
                if (!rc_is_zero) begin
                    y_mux_sel = MUX_D;
                    rc_op = RC_DEC;
                end else begin
                    y_mux_sel = MUX_PC;
                end
            end
            4'hA: begin // CRTN
                pl_n = 1'b0;
                if (test_passed) begin
                    y_mux_sel = MUX_F;
                    stack_op = POP;
                end else begin
                    y_mux_sel = MUX_PC;
                end
            end
            4'hB: begin // CJPP
                pl_n = 1'b0;
                if (test_passed) begin
                    y_mux_sel = MUX_D;
                    stack_op = POP;
                end else begin
                    y_mux_sel = MUX_PC;
                end
            end
            4'hC: begin // LDCT
                pl_n = 1'b0;
                rc_op = RC_LOAD;
                y_mux_sel = MUX_PC;
            end
            4'hD: begin // LOOP
                pl_n = 1'b0;
                if (test_passed) begin
                    y_mux_sel = MUX_PC;
                    stack_op = POP;
                end else begin
                    y_mux_sel = MUX_F;
                end
            end
            4'hE: begin // CONT
                pl_n = 1'b0;
                y_mux_sel = MUX_PC;
            end
            4'hF: begin // TWB
                pl_n = 1'b0;
                if (test_passed) begin
                    y_mux_sel = MUX_PC;
                    stack_op = POP;
                end else begin
                    if (!rc_is_zero) begin
                        y_mux_sel = MUX_F;
                        rc_op = RC_DEC;
                    end else begin
                        y_mux_sel = MUX_D;
                        stack_op = POP;
                    end
                end
            end
            default: begin // Actioneaza ca CONT
                pl_n = 1'b0;
                y_mux_sel = MUX_PC;
            end
        endcase
    end
endmodule
`timescale 1ns / 1ps

module stack (
    input wire clk,
    input wire [1:0] stack_op, // 00:HOLD, 01:PUSH, 10:POP, 11:RESET
    input wire [11:0] din,     // Data for push (from µPC)
    output reg [11:0] dout,    // Output from top of stack
    output wire full_n         // Active low when stack is full
);
    localparam HOLD  = 2'b00;
    localparam PUSH  = 2'b01;
    localparam POP   = 2'b10;
    localparam RESET = 2'b11;

    reg [11:0] mem[0:4];
    reg [2:0] sp; // Stack Pointer

    always @(posedge clk) begin
        case (stack_op)
            PUSH: begin
                if (sp < 5) begin
                    mem[sp] <= din;
                    sp <= sp + 1;
                end
            end
            POP: begin
                if (sp > 0) begin
                    sp <= sp - 1;
                end
            end
            RESET: begin
                sp <= 3'b0;
            end
        endcase
    end
    
    // Combinational output logic
    // SP points to the *next* free location, so Top-Of-Stack is at sp-1.
    always @(*) begin
        if (sp > 0) begin
            dout = mem[sp - 1];
        end else begin
            dout = 12'hxxx; // Stack is empty, output is undefined
        end
    end

    assign full_n = (sp == 5) ? 1'b0 : 1'b1;
endmodule
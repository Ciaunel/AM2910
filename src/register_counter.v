`timescale 1ns / 1ps

module register_counter (
    input wire clk,
    input wire rld_n,      // Register load override (active low)
    input wire [1:0] rc_op, // 00:HOLD, 01:LOAD, 10:DEC
    input wire [11:0] d_in, // Data source for loading
    output reg [11:0] rc_out
);
    localparam RC_HOLD = 2'b00;
    localparam RC_LOAD = 2'b01;
    localparam RC_DEC  = 2'b10;

    always @(posedge clk) begin
        if (rld_n == 1'b0) begin
            rc_out <= d_in;
        end else begin
            case (rc_op)
                RC_LOAD: begin
                    rc_out <= d_in;
                end
                RC_DEC: begin
                    rc_out <= rc_out - 1;
                end
                // For RC_HOLD: no change occurs
            endcase
        end
    end
endmodule
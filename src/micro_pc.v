`timescale 1ns / 1ps

module micro_pc (
    input wire clk,
    input wire ci,         // Carry-In, 1 to increment
    input wire [11:0] y_mux_in, // Input from the main address MUX
    output reg [11:0] pc_out
);
    always @(posedge clk) begin
        if (ci) begin
            pc_out <= y_mux_in + 1;
        end else begin
            pc_out <= y_mux_in;
        end
    end
endmodule
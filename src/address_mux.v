`timescale 1ns / 1ps

module address_mux (
    input wire [11:0] pc_in,
    input wire [11:0] d_in,
    input wire [11:0] r_in,
    input wire [11:0] f_in, // From stack File
    input wire [1:0] sel,    // 00:µPC, 01:D, 10:R, 11:F
    output reg [11:0] y_out
);
    localparam MUX_PC = 2'b00;
    localparam MUX_D  = 2'b01;
    localparam MUX_R  = 2'b10;
    localparam MUX_F  = 2'b11;
    
    always @(*) begin
        case (sel)
            MUX_PC: y_out = pc_in;
            MUX_D:  y_out = d_in;
            MUX_R:  y_out = r_in;
            MUX_F:  y_out = f_in;
            default: y_out = 12'h000;
        endcase
    end
endmodule
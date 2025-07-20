`timescale 1ns / 1ps

module zero_detector (
    input wire [11:0] rc_in,
    output wire is_zero
);
    assign is_zero = (rc_in == 12'h000);
endmodule
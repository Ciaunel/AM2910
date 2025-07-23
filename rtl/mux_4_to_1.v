module mux_4_to_1 (
    input [11:0] in0, // uPC
    input [11:0] in1, // stack (F)
    input [11:0] in2, // Direct (D)
    input [11:0] in3, // Register (R)
    input [1:0]  sel,
    output reg [11:0] out
);

    always @(*) begin
        case (sel)
            2'b00:  out = in0;
            2'b01:  out = in1;
            2'b10:  out = in2;
            2'b11:  out = in3;
            default: out = 12'b000000000000;
        endcase
    end

endmodule
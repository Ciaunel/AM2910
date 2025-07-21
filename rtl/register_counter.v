module register_counter (
    input clk,
    input reset_n,
    input load_en,
    input dec_en,
    input [11:0] data_in,
    output reg [11:0] data_out,
    output is_zero
);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            data_out <= 12'b000000000000;
        end else begin
            if (load_en) begin
                data_out <= data_in;
            end else if (dec_en) begin
                data_out <= data_out - 1;
            end
        end
    end

    assign is_zero = (data_out == 12'b000000000000);

endmodule
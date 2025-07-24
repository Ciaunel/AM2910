module microprogram_counter (
    input clk,
    input reset_n,
    input [3:0] next_pc_in,
    output reg [3:0] pc_out
);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            pc_out <= 12'b000000000000;
        end else begin
            pc_out <= next_pc_in;
        end
    end

endmodule
module stack (
    input  clk,
    input  reset_n,
    input  push_en,
    input  pop_en,
    input  clear_en,
    input  [11:0] data_in,
    output [11:0] data_out,
    output full,
    output empty
);

    reg [11:0] stack_mem [0:4];
    reg [2:0]  stack_pointer;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n || clear_en) begin
            stack_pointer <= 3'b000;
        end else begin
            if (push_en && !full) begin
                stack_mem[stack_pointer] <= data_in;
                stack_pointer <= stack_pointer + 1;
            end else if (pop_en && !empty) begin
                stack_pointer <= stack_pointer - 1;
            end
        end
    end

    assign empty = (stack_pointer == 3'b000);
    assign full = (stack_pointer == 3'b101);
    
    assign data_out = (empty) ? 12'b000000000000 : stack_mem[stack_pointer - 1];

endmodule
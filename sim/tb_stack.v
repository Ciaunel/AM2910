module tb_stack;

    reg clk;
    reg reset_n;
    reg push_en;
    reg pop_en;
    reg clear_en;
    reg [11:0] data_in;
    wire [11:0] data_out;
    wire full;
    wire empty;
    
    stack dut ( .clk(clk), .reset_n(reset_n), .push_en(push_en), .pop_en(pop_en), .clear_en(clear_en), .data_in(data_in), .data_out(data_out), .full(full), .empty(empty) );
    
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end
    
    initial begin 
    
        reset_n = 1'b0;
        push_en = 1'b0;
        pop_en = 1'b0;
        clear_en = 1'b0;
        data_in = 12'h0;
        #15;
        reset_n = 1'b1;
        #10;
        push_en = 1'b1;
        data_in = 12'hAAA;
        #10;
        data_in = 12'hBBB;
        #10;
        data_in = 12'hCCC;
        #10;
        data_in = 12'hDDD;
        #10;
        data_in = 12'hEEE;
        #10;
        
        push_en = 1'b0;
        #20;
        
        pop_en = 1'b1;
        #10;
        
        #10;
        
        #10;
        
        #10;
        
        #10;
        
        pop_en = 1'b0;
        
        push_en = 1'b1;
        data_in = 12'h111;
        #10;
        data_in = 12'h222;
        #10;
        push_en = 1'b0;
        #10;
        clear_en = 1'b1;
        #10;
        clear_en = 1'b0;
        
        #20;
        $finish;
        
    end
    
endmodule
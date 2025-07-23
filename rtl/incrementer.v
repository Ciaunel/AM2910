module incrementer (
    input [11:0] data_in, 
    input carry_in,  
    output [11:0] data_out 
);

    assign data_out = data_in + carry_in;

endmodule
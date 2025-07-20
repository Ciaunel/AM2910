`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2025 07:14:12 PM
// Design Name: 
// Module Name: spram8x12
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module spram8x12(
    input clk,
    input we,
    input [2:0]addr,
    input [11:0]din,
    output reg [11:0]dout
    );
    
    reg [11:0]mem[0:7];
    
    always @(posedge clk)
    begin
        if(we) begin
            mem[addr]<=din;
        end
        dout<=mem[addr];
    end
endmodule

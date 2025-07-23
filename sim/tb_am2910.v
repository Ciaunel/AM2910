`timescale 1ns / 1ps

module tb_am2910;

    reg CP;
    reg RESET_N;
    reg [3:0]  I;
    reg [11:0] D;
    reg CC;
    reg CCEN;
    reg RLD;
    reg CI;
    reg OE;
    
    wire FULL;
    wire PL, MAP, VECT;
    wire [11:0] Y;

    am2910 dut (
        .CP(CP), .RESET_N(RESET_N), .I(I), .D(D), .CC(CC), .CCEN(CCEN),
        .RLD(RLD), .CI(CI), .OE(OE), .FULL(FULL), .PL(PL), .MAP(MAP),
        .VECT(VECT), .Y(Y)
    );

    initial begin
        CP = 1'b0;
        forever #5 CP = ~CP;
    end

    initial begin
        RESET_N = 1'b0;
        I = 4'hE; D = 12'h0; CC = 1'b1; CCEN = 1'b1; 
        RLD = 1'b1; CI = 1'b1; OE = 1'b0;
        #15;
        RESET_N = 1'b1;

        #10;
        #10;
        
        #5;
        I = 4'h4;
        D = 12'd2;
        CC = 1'b0;
        CCEN = 1'b0;
        
        #10;
        
        I = 4'h8;
        CC = 1'b1;
        
        #10;
        #10;
        #10;
        
        #5;
        I = 4'h1;
        D = 12'h100;
        CC = 1'b0;
        CCEN = 1'b0;
        
        #10;
        
        I = 4'hE;
        
        #10;
        
        I = 4'hA;
        CC = 1'b0;
        
        #10;
        
        #40;
        $finish;
    end

endmodule
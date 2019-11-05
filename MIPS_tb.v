`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2019 02:58:37 PM
// Design Name: 
// Module Name: MIPS_tb
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


module MIPS_tb;
    reg clk;
    reg rst;
    
    processor mips(
        .clk(clk),
        .rst(rst));
        
    initial 
    begin
        clk = 0;
        rst = 1;
        
        #2;
        @(posedge clk);
        rst = 0;
        #2;
    end
    
    always clk = #1 ~clk;
endmodule

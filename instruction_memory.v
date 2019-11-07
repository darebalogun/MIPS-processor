`timescale 1ns / 1ps

module instruction_memory (
    input [31:0] address,
    output [31:0] instruction);

    assign instruction = (address == 32'd0) ? {6'b001000, 5'd0, 5'd0, 16'd1}:  //ADDI r0, r0, 1
                         (address == 32'd4) ? {6'b000010, 26'd0}: 32'd0;       //J 0x00000000		         
endmodule

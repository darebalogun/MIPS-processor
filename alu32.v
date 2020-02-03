`timescale 1ns / 1ps

`define ADDI 6'b001000
`define J 6'b000010 

module alu32(
    input [31:0] op1,	
    input [31:0] op2,
    input [2:0] control,
    output reg [31:0] result,
    output zero);

assign zero = (result == 32'd0) ? 1'b1: 1'b0;

always @(*)
    begin
        case(control)
            6'b000: // ADD
                result = op1 + op2;
            6'b001: // SUB
                result = op1 - op2;
            6'b010: // SHIFT
                result = op1 << op2;
            6'b011: // AND
                result = op1 & op2;
            6'b100: // OR
                result = op1 | op2;
            6'b101: // XOR
                result = op1 ^ op2;
            6'b110: // NOR
                result = ~(op1 | op2);
            endcase
    end


endmodule

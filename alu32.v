`timescale 1ns / 1ps

`define ADDI 6'b001000
`define J 6'b000010 

module alu32(
    input [31:0] op1,	
    input [31:0] op2,
    input [5:0] control,
    output [31:0] result,
    output zero);

assign zero = (result == 32'd0) ? 1'b1: 1'b0;

assign result = (control == `ADDI)  ?  op1 + op2 : 32'd0;
                //(control == `J)  ? :
                //fill in here
                //32'd0;


endmodule

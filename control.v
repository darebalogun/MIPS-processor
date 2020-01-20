`include "mips_isa.v"

module control(
    input [5:0] instruction,
    input [5:0] funct,
    input zero,
    output reg_dst,
    output jump,
    output branch,
    output memRead,
    output mem2Reg,
    output[5:0] ALUop,
    output memWrite,
    output ALUsrc,
    output regWrite);


assign reg_dst = (instruction == `ADDI) ? 1'b0 : 1'b1;    

assign jump = (instruction == `J) ? 1'b1 : 1'b0;

assign regWrite = (instruction == `ADDI) ? 1'b1 : 1'b0;

assign ALUop = instruction;

assign ALUsrc = (instruction == `ADDI) ? 1'b1 : 1'b0;

endmodule
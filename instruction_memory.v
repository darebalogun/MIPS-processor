`timescale 1ns / 1ps

module instruction_memory (
    input [31:0] address,
    output [31:0] instruction);
    
    reg [7:0] memory[1024:0];
    
    assign instruction = {memory[address], memory[address + 1], memory[address + 2], memory[address + 3]};
	         
endmodule

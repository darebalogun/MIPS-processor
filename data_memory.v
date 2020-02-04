`timescale 1ns / 1ps

module data_memory(
   input clk,
   input [31:0] address,
   input [31:0] write_data,
   output [31:0] read_data,
   input write);

reg [31:0] memory [1023:0];

assign read_data = {memory[address], memory[address + 1], memory[address + 2], memory[address + 3]}; //Verilog might allow or not

always@(posedge clk)
begin
    if(write)
    begin
        memory[address]     <= write_data[31:24];
        memory[address + 1] <= write_data[23:16];
        memory[address + 2] <= write_data[15:8];
        memory[address + 3] <= write_data[7:0];
    end
end	

endmodule

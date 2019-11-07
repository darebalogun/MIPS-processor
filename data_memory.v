`timescale 1ns / 1ps

module data_memory(
   input clk,
   input [31:0] address,
   input [31:0] write_data,
   output [31:0] read_data,
   input write);

reg[31:0] mem[1023:0];

assign read_data = mem[address]; //Verilog might allow or not

always@(posedge clk)
begin
    if(write)
    begin
        mem[address] <= write_data;
    end
end	

endmodule

`timescale 1ns / 1ps
module register_file(
    input clk,
    input [4:0] reg1_address,
    input [4:0] reg2_address,
    input [4:0] regw_address, 
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2,
    input write);

reg [31:0] registers[31:0];

// Initialize registers to 0
integer i;
initial 
   for (i = 0; i < 32; i = i + 1)
   begin
       registers[i] = 32'b0;
   end

assign read_data1 = registers[reg1_address]; 
assign read_data2 = registers[reg2_address]; 

always@(posedge clk)
begin
    if(write)
    begin
        registers[regw_address] <= write_data;
    end
end	

endmodule

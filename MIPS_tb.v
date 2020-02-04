`timescale 1ns / 1ps


module MIPS_tb;
    reg clk;
    reg rst;
    
    mips_top mips(
        .clk(clk),
        .rst(rst));
        
    initial 
    begin
        mips.my_ins_mem.memory[0] = 8'b00100000;
        mips.my_ins_mem.memory[1] = 8'b00000000;
        mips.my_ins_mem.memory[2] = 8'b00000000;
        mips.my_ins_mem.memory[3] = 8'b00000001;
        
        mips.my_ins_mem.memory[4] = 8'b00001000;
        mips.my_ins_mem.memory[5] = 8'b00000000;
        mips.my_ins_mem.memory[6] = 8'b00000000;
        mips.my_ins_mem.memory[7] = 8'b00000000;
    
        clk = 0;
        rst = 1;
        
        #2;
        @(posedge clk);
        rst = 0;
        $write("Register 0: %h", mips.my_reg_file.registers[0]);
        #2;
    end
    always clk = #1 ~clk;
endmodule


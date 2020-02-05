`timescale 1ns / 1ps


module MIPS_tb;
    reg clk;
    reg rst;
    
    mips_top mips(
        .clk(clk),
        .rst(rst));
        
    initial 
    begin
        // Load 0 into data memory
        mips.data_mem.memory[0] = 8'd0;
        mips.data_mem.memory[1] = 8'd0;
        mips.data_mem.memory[2] = 8'd0;
        mips.data_mem.memory[3] = 8'd0;
        // Load 1 into data memory
        mips.data_mem.memory[4] = 8'd0;
        mips.data_mem.memory[5] = 8'd0;
        mips.data_mem.memory[6] = 8'd0;
        mips.data_mem.memory[7] = 8'd1;
        
        // Load 0 from data memory[0] into R0
        // 100011 00000 00000 0000000000000000
        mips.my_ins_mem.memory[0] = 8'b10001100;
        mips.my_ins_mem.memory[1] = 8'b10000000;
        mips.my_ins_mem.memory[2] = 8'b00000000;
        mips.my_ins_mem.memory[3] = 8'b00000000;
        
        // Load 1 from data memory[4] into R1
        // 100011 00100 00001 0000000000000000
        mips.my_ins_mem.memory[4] = 8'b10001100;
        mips.my_ins_mem.memory[5] = 8'b10000001;
        mips.my_ins_mem.memory[6] = 8'b00000000;
        mips.my_ins_mem.memory[7] = 8'b00000100;
        
        // R2 = R1 + R0
        // 000000 00000 00001 00010 00000000000
        mips.my_ins_mem.memory[8] = 8'b00000000;
        mips.my_ins_mem.memory[9] = 8'b00000001;
        mips.my_ins_mem.memory[10] = 8'b00010000;
        mips.my_ins_mem.memory[11] = 8'b00100000;
        
        // Store R1 in data memory[0]
        // 101011 00000 00001 0000000000000000
        mips.my_ins_mem.memory[12] = 8'b10101100;
        mips.my_ins_mem.memory[13] = 8'b10000001;
        mips.my_ins_mem.memory[14] = 8'b00000000;
        mips.my_ins_mem.memory[15] = 8'b00000000;
        
        // Store R2 in data memory[4]
        // 101011 00001 00010 0000000000000000
        mips.my_ins_mem.memory[16] = 8'b10101100;
        mips.my_ins_mem.memory[17] = 8'b10000010;
        mips.my_ins_mem.memory[18] = 8'b00000000;
        mips.my_ins_mem.memory[19] = 8'b00000100;
        
        // Jump to beginning
        // 000010 00000000000000000000000000
        mips.my_ins_mem.memory[20] = 8'b00001000;
        mips.my_ins_mem.memory[21] = 8'b00000000;
        mips.my_ins_mem.memory[22] = 8'b00000000;
        mips.my_ins_mem.memory[23] = 8'b00000000;
        
        clk = 0;
        rst = 1;
        
        #2;
        @(posedge clk);
        rst = 0;
        
        #2;
    end
    always
        begin 
            clk = #1 ~clk;
            if (mips.my_reg_file.registers[2] == 32'd2971215073)
                $stop;
        end
endmodule


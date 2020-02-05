
module mips_top(
    input clk,
    input rst);

// Control Wires
wire reg_dst;
wire jump;
wire branch;
wire memRead;
wire mem2Reg;
wire signXtend;
wire memWrite;
wire ALUsrc;
wire regWrite;
wire [2:0] ALUop;

// PC + Instruction Memory Wires
reg [31:0]      pc;
wire [31:0]     new_pc;
wire [31:0]     pcplus4 = pc + 4;
wire [31:0]     instruction;
wire [5:0]      opCode = instruction[31:26];
wire [31:0]     jump_address = {pc[31:28], instruction[25:0], 2'b0};
wire [4:0]      src_addr = instruction[25:21];
wire [4:0]      trgt_addr = instruction[20:16];
wire [4:0]      dest_addr = instruction[15:11];
wire [31:0]     const = (signXtend) ? {{16{instruction[15]}}, instruction[15:0]} : instruction[15:0];
wire [5:0]      funct = instruction[5:0];

// Data Memory
wire [31:0] read_data;

// ALU
wire [31:0] ALUresult;
wire zero;

// REGISTER WIRES
wire [4:0] reg_file_write_address = (reg_dst) ? dest_addr : trgt_addr;
wire [31:0] reg_file_write_data = (mem2Reg) ? read_data : ALUresult;
wire [31:0] reg_file_out1;
wire [31:0] reg_file_out2;

wire [31:0] ALUop2 = (ALUsrc) ? const : reg_file_out2;


assign new_pc = (jump) ? jump_address : pcplus4;
assign reg_file_write_address = (reg_dst) ? instruction[15:11] : instruction[20:16];

always@(posedge clk)
begin
    if(rst)
        pc <= 32'd0;
    else
        pc <= new_pc;
end

// Instantiation
register_file my_reg_file(.clk(clk), 
                     .reg1_address(instruction[25:21]), 
                     .reg2_address(instruction[20:16]), 
                     .regw_address(reg_file_write_address), 
                     .write_data(reg_file_write_data), 
                     .read_data1(reg_file_out1), 
                     .read_data2(reg_file_out2), 
                     .write(regWrite));
                     
alu32 my_alu32(.op1(reg_file_out1), .op2(ALUop2), .control(ALUop), .result(ALUresult), .zero(zero));

control my_control(
        .instruction(opCode), 
        .funct(funct), 
        .zero(zero), 
        .reg_dst(reg_dst), 
        .jump(jump),
        .branch(branch),
        .memRead(memRead),
        .mem2Reg(mem2Reg),
        .memWrite(memWrite),
        .regWrite(regWrite),
        .ALUop(ALUop),
        .ALUsrc(ALUsrc),
        .signXtend(signXtend));
            
instruction_memory my_ins_mem(.address(pc), .instruction(instruction));

data_memory data_mem(.clk(clk), .address(ALUresult), .write_data(reg_file_out2), .read_data(read_data), .write(memWrite));
endmodule







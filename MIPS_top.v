
module mips_top(
    input clk,
    input rst);

reg [31:0] pc;
wire [31:0] new_pc;

always@(posedge clk)
begin
    if(rst)
        pc <= 32'd0;
    else
    begin
        pc <= new_pc;
    end
end

wire [31:0] pcplus4 = pc + 4;

wire [31:0] instruction;

wire [31:0] jump_address = {pc[31:28], instruction[25:0],2'b0};

wire jump;

assign new_pc = (jump) ? jump_address : pcplus4;

wire reg_dst;

wire [4:0] reg_file_write_address;
assign reg_file_write_address = (reg_dst) ? instruction[15:11] : instruction[20:16];

wire [31:0] alu_result;

// REGISTER WIRES
wire [31:0] reg_file_write_data = alu_result;
wire [31:0] reg_file_out1;
wire [31:0] reg_file_out2;
wire reg_write;
wire ALUsrc;
wire zero;

// ALU WIRES
//wire [31:0] extented_inst = {{16{instruction[15:0]}}
wire signed [31:0] operand2 = (ALUsrc) ? { {16{instruction[15]}}, instruction[15:0]} : reg_file_out2;
wire [5:0] control;

// Instantiation
register_file my_reg_file(.clk(clk), 
                     .reg1_address(instruction[25:21]), 
                     .reg2_address(instruction[20:16]), 
                     .regw_address(reg_file_write_address), 
                     .write_data(reg_file_write_data), 
                     .read_data1(reg_file_out1), 
                     .read_data2(reg_file_out2), 
                     .write(reg_write));
                     
alu32 my_alu32(.op1(reg_file_out1), .op2(operand2), .control(control), .result(alu_result), .zero(zero));

control my_control(.instruction(instruction[31:26]), 
        .funct(instruction[5:0]), 
        .zero(zero), 
        .reg_dst(reg_dst), 
        .jump(jump),
        .regWrite(reg_write),
        .ALUop(control),
        .ALUsrc(ALUsrc));
            
instruction_memory my_ins_mem(.address(pc), .instruction(instruction));
endmodule







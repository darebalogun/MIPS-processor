

	module ins_mem (
        input [31:0] address,
        output [31:0] instruction);
    
        assign instruction = (address == 32'd0) ? {6'b001000, 5'd0, 5'd0, 16'd1}:  //ADDI r0, r0, 1
                             (address == 32'd4) ? {6'b000010, 26'd0}: 32'd0;       //J 0x00000000		         
	endmodule

	module data_mem(
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


	module reg_file(
        input clk,
        input [4:0] reg1_address,
        input [4:0] reg2_address,
        input [4:0] regw_address, 
        input [31:0] write_data,
        output [31:0] read_data1,
        output [31:0] read_data2,
        input write);
	
	reg [31:0] registers[31:0];
	
	integer i;
	initial 
	   for (i = 0; i < 32; i = i + 1)
	   begin
	       registers[i] = 32'b0;
	   end

	assign read_data1 = registers[reg1_address]; //Verilog might allow or not
	assign read_data2 = registers[reg2_address]; //Verilog might allow or not


	always@(posedge clk)
	begin
		if(write)
		begin
			registers[regw_address] <= write_data;
		end
	end	

	endmodule


	`define ADDI 6'b001000
	`define J 6'b000010 


	module ALU(
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

	module processor(
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
	reg_file my_reg_file(.clk(clk), 
	                     .reg1_address(instruction[25:21]), 
	                     .reg2_address(instruction[20:16]), 
	                     .regw_address(reg_file_write_address), 
	                     .write_data(reg_file_write_data), 
	                     .read_data1(reg_file_out1), 
	                     .read_data2(reg_file_out2), 
	                     .write(reg_write));
	                     
	ALU alu(.op1(reg_file_out1), .op2(operand2), .control(control), .result(alu_result), .zero(zero));
	
	control my_control(.instruction(instruction[31:26]), 
	        .funct(instruction[5:0]), 
	        .zero(zero), 
	        .reg_dst(reg_dst), 
	        .jump(jump),
	        .regWrite(reg_write),
	        .ALUop(control),
	        .ALUsrc(ALUsrc));
	         	
	ins_mem my_ins_mem(.address(pc), .instruction(instruction));
	endmodule







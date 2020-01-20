// Arithmethic and Logic Instructions
`define ADD     6'b100000
`define ADDU    6'b100001
`define ADDIU   6'b001001
`define ADDI    6'b001000
`define ANDI    6'b001100
`define DIV     6'b011010
`define AND     6'b100100
`define MULT    6'b011000
`define DIVU    6'b011011
`define NOR     6'b100111
`define MULTU   6'b011001
`define ORI     6'b001101
`define OR      6'b100101
`define SLLV    6'b000100
`define SLL     6'b000000
`define SRAV    6'b000111
`define SRA     6'b000011
`define SRLV    6'b000110
`define SRL     6'b000010
`define SUBU    6'b100011
`define SUB     6'b100010
`define XORI    6'b001110
`define XOR     6'b100110

// Comparison Instructions
`define SLT     6'b101010
`define SLTU    6'b101001
`define SLTI    6'b001010
`define SLTIU   6'b001001

// Branch Instructions
`define BEQ     6'b000100
`define BGTZ    6'b000111
`define BLEZ    6'b000110
`define BNE     6'b000101

// Jump Instructions
`define J       6'b000010 
`define JAL     6'b000011
`define JALR    6'b001001
`define JR      6'b001000

// Load Instructions
`define LB      6'b100000
`define LBU     6'b100100
`define LH      6'b100001
`define LHU     6'b100101
`define LW      6'b100011

// Store Instructions
`define SB      6'b101000
`define SH      6'b101001
`define SW      6'b101011
//////////////////////////
///// R Instructions /////
`define R_TYPE  6'b000000
/////////////////////////
// Add
`define ADD     6'b100000
`define ADDU    6'b100001
// Subtract
`define SUB     6'b100010
`define SUBU    6'b100011
// Multiply
`define MULT    6'b011000
`define MULTU   6'b011001
// Divide
`define DIV     6'b011010
`define DIVU    6'b011011
// Move Hi/Lo
`define MFHI    6'b010000
`define MTHI    6'b010001
`define MFLO    6'b010010
`define MTLO    6'b010011
// Shifts
`define SLL     6'b000000
`define SRL     6'b000010
`define SRA     6'b000011
`define SLLV    6'b000100
`define SRLV    6'b000110
`define SRAV    6'b000111
// Compare
`define SLT     6'b101010
`define SLTU    6'b101001
// Logic
`define AND     6'b100100
`define OR      6'b100101
`define XOR     6'b100110
`define NOR     6'b100111
// Jump
`define JR      6'b001000
`define JALR    6'b001001
// Conditional move
`define MOVZ    6'b001010
`define MOVN    6'b001011

///////////////////////////
///// RI Instructions /////
`define RI_TYPE 6'b000001
//////////////////////////
// Branch
`define BLTZ    5'b00000
`define BGEZ    5'b00001
`define BLTZAL  5'b10000
`define BGEZAL  5'b10001

//////////////////////////
///// I Instructions /////
//////////////////////////
// Add
`define ADDI    6'b001000
`define ADDIU   6'b001001
// Compare
`define SLTI    6'b001010
`define SLTIU   6'b001001
// Logic
`define ANDI    6'b001100
`define ORI     6'b001101
`define XORI    6'b001110
`define LUI     6'b001111
// Branch Instructions
`define BEQ     6'b000100
`define BNE     6'b000101
`define BLEZ    6'b000110
`define BGTZ    6'b000111
// Load
`define LB      6'b100000
`define LH      6'b100001
`define LWL     6'b100010
`define LW      6'b100011
`define LBU     6'b100100
`define LHU     6'b100101
`define LWR     6'b100010
// Store
`define SB      6'b101000
`define SH      6'b101001
`define SWL     6'b101010
`define SW      6'b101011

//////////////////////////   
///// J Instructions /////
//////////////////////////
`define J       6'b000010 
`define JAL     6'b000011


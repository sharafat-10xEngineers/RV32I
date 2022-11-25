`ifndef CUSTOM_DEFINE
`define CUSTOM_DEFINE

// Parameters
// `define {name} {value}

/////////////
// IF UNIT //
/////////////

// Instruction Memory

`define IMEM_ADDR_WIDTH 32  // address bits of instruction memory
`define IMEM_DATA_WIDTH 32  // output port width of IMEM
`define IMEM_WIDTH 8        // data bits of each memory unit
`define IMEM_DEPTH 256      // num of memory unit

// Adder_Subtractor

`define ADDER_WIDTH 64

`define INSTRUCTION_WIDTH 32

// Program Counter

`define PC_WIDTH 32

// Include memory in Core
`define MEM_IN_CORE 1

/////////////
// ID UNIT //
/////////////

// Register File

`define REG_WIDTH 32
`define REG_DEPTH 32
`define REG_ADDR_WIDTH 5

// Immediate Generation
`define IMM_WIDTH 32

`define R_TYPE 3'b000
`define I_TYPE 3'b001
`define S_TYPE 3'b010
`define SB_TYPE 3'b011
`define U_TYPE 3'b100
`define UJ_TYPE 3'b101

// 

////////////////////
// EXECUTION UNIT //
////////////////////

// ALU

`define OPERANDS_WIDTH 32
`define ALU_SEL_WIDTH 4

`define ALU_OP_ADD		4'b0000		
`define ALU_OP_SUB		4'b0001
`define ALU_OP_SLL		4'b0010
`define ALU_OP_SLT 		4'b0011
`define ALU_OP_SLTU		4'b0100
`define ALU_OP_XOR		4'b0101
`define ALU_OP_SRL		4'b0110
`define ALU_OP_SRA		4'b0111
`define ALU_OP_OR 		4'b1000
`define ALU_OP_AND		4'b1001
`define ALU_OP_LUI      4'b1010

///////////////////
// Memory Access //
///////////////////

`define DMEM_ADDR_WIDTH 32  // address bits of instruction memory
`define DMEM_DATA_WIDTH 32  // output port width of IMEM
`define DMEM_WIDTH 8        // data bits of each memory unit
`define DMEM_DEPTH 256      // num of memory locations

////////////////
// WRITE BACK //
////////////////

`endif

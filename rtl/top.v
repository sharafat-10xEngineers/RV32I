//    name    = top.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = To Instantiate all five stages of our single cycle processor
//    Potential Improvements = Convert this single cycle to 5-stage pipeline. 

// `include "../defines.vh"
// `include "../rtl/inst_fetch/IF_unit.v"
// `include "./inst_decode/imm_gen.v"
// `include "./inst_decode/regfile.v"
// `include "./inst_decode/controller.v"
// `include "./inst_execute/branch_comp.v"
// `include "./inst_execute/alu.v"
// `include "./mem_access/MA_unit.v"
// `include "./write_back/WB_unit.v"


module top (
    input clk,
    input reset,
    output [31:0] result
);

// IF wires
wire PCSel;
wire [`INSTRUCTION_WIDTH-1:0] inst;
wire [`PC_WIDTH-1:0] pc_out;
wire [`PC_WIDTH-1:0] pc_plus_4;

// ID wires
wire [2:0] ImmSel;
wire [(`IMM_WIDTH)-1:0] imm;
wire RegWEn;
wire [`REG_WIDTH-1:0] rs1;
wire [`REG_WIDTH-1:0] rs2;
wire [`REG_WIDTH-1:0] WBSel_out;
    // controller
    wire BrEq;
    wire BrLT;
    wire BrUn;
    wire Bsel;
    wire Asel;
    wire [`ALU_SEL_WIDTH-1:0] ALUSel;
    wire MemRW;
    wire [1:0] WBSel;

// Execute stage wires
wire [`OPERANDS_WIDTH-1:0] Asel_out;
wire [`OPERANDS_WIDTH-1:0] Bsel_out;
wire [`OPERANDS_WIDTH-1:0] alu_out;

assign result = alu_out;

// Memory Access wires
wire [`DMEM_DATA_WIDTH-1:0] dmem_out;

// Instruction Fetch
IF_unit instFetch (
    .clk(clk),
    .reset(reset),
    .PCSel(PCSel),
    .from_alu(alu_out),
    .pc_plus_4(pc_plus_4),
    .pc_out(pc_out),
    .inst(inst)
);

// Instruction Decode

imm_gen immGen (
    .sub_instr(inst[31:7]),
    .ImmSel(ImmSel),
    .imm(imm)
);

regfile regFile (
    .clk(clk),
    .reset(reset),
    .RegWEn(RegWEn),
    .addrA(inst[19:15]),
    .addrB(inst[24:20]),
    .addrD(inst[11:7]),
    .dataD(WBSel_out),
    .dataA(rs1),
    .dataB(rs2)
);

controller Controller (
    .inst(inst),
    .BrEq(BrEq),
    .BrLT(BrLT),
    .PCSel(PCSel),
    .ImmSel(ImmSel),
    .RegWEn(RegWEn),
    .BrUn(BrUn),
    .Bsel(Bsel),
    .Asel(Asel),
    .ALUSel(ALUSel),
    .MemRW(MemRW),
    .WBSel(WBSel)
    );

// Execute stage

branch_comp branchComp (
    .rs1(rs1),    // operand 1
    .rs2(rs2),    // operand 2
    .BrUn(BrUn), // 1: unsigned instruction
    .BrEq(BrEq),    // 
    .BrLT(BrLT)
);

alu Alu (
    .A(Asel_out),
    .B(Bsel_out),
    .ALUSel(ALUSel),
    .result(alu_out) 
);

assign Asel_out = (Asel == 1'b1) ? pc_out : rs1;
assign Bsel_out = (Bsel == 1'b1) ? imm : rs2;

// Memory Access stage

MA_unit memAccess (
    .clk(clk),
    .MemRW(MemRW),
    .addr(alu_out),
    .data_in(rs2),
    .data_out(dmem_out)
);


// Write Back stage

WB_unit writeBack (
    .WBSel(WBSel),
    .from_dmem(dmem_out),
    .from_alu(alu_out),
    .pc_plus_4(pc_plus_4),
    .to_regfile(WBSel_out)
);

endmodule //top

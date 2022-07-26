//    name    = controller.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Controller

// `include "../../defines.vh"

module controller (
    input [`INSTRUCTION_WIDTH-1:0] inst,
    input BrEq,
    input BrLT,
    output reg PCSel,
    output reg [2:0] ImmSel,
    output reg RegWEn,
    output reg BrUn,
    output reg Bsel,
    output reg Asel,
    output reg [`ALU_SEL_WIDTH-1:0] ALUSel,
    output reg MemRW,
    output reg [1:0] WBSel
);


parameter   OPCODE_U_LUI 	= 7'b0110111,
     		OPCODE_U_AUIPC 	= 7'b0010111,
     		OPCODE_J_JAL 	= 7'b1101111,
     		OPCODE_I_JALR	= 7'b1100111,
     		OPCODE_B_BRANCH = 7'b1100011,
     		OPCODE_I_LOAD 	= 7'b0000011,
     		OPCODE_S_STORE 	= 7'b0100011,  
     		OPCODE_I_IMM 	= 7'b0010011,
     		OPCODE_R_ALU 	= 7'b0110011;

parameter   f3_0 = 3'd0,
            f3_1 = 3'd1,
            f3_2 = 3'd2,
            f3_3 = 3'd3,
            f3_4 = 3'd4,
            f3_5 = 3'd5,
            f3_6 = 3'd6,
            f3_7 = 3'd7;

wire func7;
wire [2:0] func3;
wire [6:0] opcode; 

assign func7 = inst[30];
assign func3 = inst[14:12];
assign opcode = inst[6:0];
always @(*) begin
    casez ({func7, func3, opcode})
        // lb
        {1'b?, f3_0, OPCODE_I_LOAD}: begin
            PCSel = 1'b0;
            ImmSel = `I_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_ADD;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // lh
        {1'b?, f3_1, OPCODE_I_LOAD}: begin
            PCSel = 1'b0;
            ImmSel = `I_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_ADD;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // lw
        {1'b?, f3_2, OPCODE_I_LOAD}: begin
            PCSel = 1'b0;
            ImmSel = `I_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_ADD;
            MemRW = 0;
            WBSel = 2'd0;
        end
        // lbu
        {1'b?, f3_4, OPCODE_I_LOAD}: begin
            PCSel = 1'b0;
            ImmSel = `I_TYPE;
            RegWEn = 1;
            BrUn = 1;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_ADD;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // lhu
        {1'b?, f3_5, OPCODE_I_LOAD}: begin
            PCSel = 1'b0;
            ImmSel = `I_TYPE;
            RegWEn = 1;
            BrUn = 1;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_ADD;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // addi
        {1'b?, f3_0, OPCODE_I_IMM}: begin
            PCSel = 1'b0;
            ImmSel = `I_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_ADD;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // slli
        {1'b0, f3_1, OPCODE_I_IMM}: begin
            PCSel = 1'b0;
            ImmSel = `I_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_SLL;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // slti
        {1'b?, f3_2, OPCODE_I_IMM}: begin
            PCSel = 1'b0;
            ImmSel = `I_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_SLT;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // sltiu
        {1'b?, f3_3, OPCODE_I_IMM}: begin
            PCSel = 1'b0;
            ImmSel = `I_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_SLTU;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // xori
        {1'b?, f3_4, OPCODE_I_IMM}: begin
            PCSel = 1'b0;
            ImmSel = `I_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_XOR;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // srli
        {1'b0, f3_5, OPCODE_I_IMM}: begin
            PCSel = 1'b0;
            ImmSel = `I_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_SRL;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // srai
        {1'b1, f3_5, OPCODE_I_IMM}: begin
            PCSel = 1'b0;
            ImmSel = `I_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_SRA;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // ori 
        {1'b0, f3_6, OPCODE_I_IMM}: begin
            PCSel = 1'b0;
            ImmSel = `I_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_OR;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // andi
        {1'b0, f3_7, OPCODE_I_IMM}: begin
            PCSel = 1'b0;
            ImmSel = `I_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_AND;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // AUIPC
        {1'b?, 3'b???, OPCODE_U_AUIPC}: begin
            PCSel = 1'b0;
            ImmSel = `U_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 1;
            Asel = 1;
            ALUSel = `ALU_OP_ADD;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // SB
        {1'b?, f3_0, OPCODE_S_STORE}: begin
            PCSel = 1'b0;
            ImmSel = `S_TYPE;
            RegWEn = 0;
            BrUn = 0;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_ADD;
            MemRW = 1;
            WBSel = 2'd1;
        end
        // SH
        {1'b?, f3_1, OPCODE_S_STORE}: begin
            PCSel = 1'b0;
            ImmSel = `S_TYPE;
            RegWEn = 0;
            BrUn = 0;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_ADD;
            MemRW = 1;
            WBSel = 2'd1;
        end
        // SW
        {1'b?, f3_2, OPCODE_S_STORE}: begin
            PCSel = 1'b0;
            ImmSel = `S_TYPE;
            RegWEn = 0;
            BrUn = 0;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_ADD;
            MemRW = 1;
            WBSel = 2'd1;
        end
        // ADD
        {1'b0, f3_0, OPCODE_R_ALU}: begin
            PCSel = 1'b0;
            ImmSel = `R_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 0;
            Asel = 0;
            ALUSel = `ALU_OP_ADD;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // SUB
        {1'b1, f3_0, OPCODE_R_ALU}: begin
            PCSel = 1'b0;
            ImmSel = `R_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 0;
            Asel = 0;
            ALUSel = `ALU_OP_SUB;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // SLL
        {1'b0, f3_1, OPCODE_R_ALU}: begin
            PCSel = 1'b0;
            ImmSel = `R_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 0;
            Asel = 0;
            ALUSel = `ALU_OP_SLL;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // SLT
        {1'b0, f3_2, OPCODE_R_ALU}: begin
            PCSel = 1'b0;
            ImmSel = `R_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 0;
            Asel = 0;
            ALUSel = `ALU_OP_SLT;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // SLTU
        {1'b0, f3_3, OPCODE_R_ALU}: begin
            PCSel = 1'b0;
            ImmSel = `R_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 0;
            Asel = 0;
            ALUSel = `ALU_OP_SLTU;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // XOR
        {1'b0, f3_4, OPCODE_R_ALU}: begin
            PCSel = 1'b0;
            ImmSel = `R_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 0;
            Asel = 0;
            ALUSel = `ALU_OP_XOR;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // SRL
        {1'b0, f3_5, OPCODE_R_ALU}: begin
            PCSel = 1'b0;
            ImmSel = `R_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 0;
            Asel = 0;
            ALUSel = `ALU_OP_SRL;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // SRA
        {1'b1, f3_5, OPCODE_R_ALU}: begin
            PCSel = 1'b0;
            ImmSel = `R_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 0;
            Asel = 0;
            ALUSel = `ALU_OP_SRA;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // OR
        {1'b0, f3_6, OPCODE_R_ALU}: begin
            PCSel = 1'b0;
            ImmSel = `R_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 0;
            Asel = 0;
            ALUSel = `ALU_OP_OR;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // AND
        {1'b0, f3_7, OPCODE_R_ALU}: begin
            PCSel = 1'b0;
            ImmSel = `R_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 0;
            Asel = 0;
            ALUSel = `ALU_OP_AND;
            MemRW = 0;
            WBSel = 2'd1;
        end
        // LUI
        {1'b?, 3'b???, OPCODE_U_LUI}: begin
            PCSel = 1'b0;
            ImmSel = `U_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_LUI;
            MemRW = 0;
            WBSel = 2'd1;
        end

        //  BEQ
        {1'b?, f3_0, OPCODE_B_BRANCH}: begin
            PCSel = (BrEq == 1'b1) ? 1'b1: 1'b0;
            ImmSel = `SB_TYPE;
            RegWEn = 0;
            BrUn = 0;
            Bsel = 1;
            Asel = 1;
            ALUSel = `ALU_OP_ADD;
            MemRW = 0;
            WBSel = 2'd0;
        end
        //  BNE
        {1'b?, f3_1, OPCODE_B_BRANCH}: begin
            PCSel = (BrEq == 1'b0) ? 1'b1: 1'b0;
            ImmSel = `SB_TYPE;
            RegWEn = 0;
            BrUn = 0;
            Bsel = 1;
            Asel = 1;
            ALUSel = `ALU_OP_ADD;
            MemRW = 0;
            WBSel = 2'd0;
        end
        //  BLT
        {1'b?, f3_4, OPCODE_B_BRANCH}: begin
            PCSel = (BrLT == 1'b1) ? 1'b1: 1'b0;
            ImmSel = `SB_TYPE;
            RegWEn = 0;
            BrUn = 0;
            Bsel = 1;
            Asel = 1;
            ALUSel = `ALU_OP_ADD;
            MemRW = 0;
            WBSel = 2'd0;
        end
        //  BGE
        {1'b?, f3_5, OPCODE_B_BRANCH}: begin
            PCSel = (BrLT == 1'b0) ? 1'b1: 1'b0;
            ImmSel = `SB_TYPE;
            RegWEn = 0;
            BrUn = 0;
            Bsel = 1;
            Asel = 1;
            ALUSel = `ALU_OP_ADD;
            MemRW = 0;
            WBSel = 2'd0;
        end
        //  BLTU
        {1'b?, f3_6, OPCODE_B_BRANCH}: begin
            PCSel = (BrLT == 1'b1) ? 1'b1: 1'b0;
            ImmSel = `SB_TYPE;
            RegWEn = 0;
            BrUn = 1;
            Bsel = 1;
            Asel = 1;
            ALUSel = `ALU_OP_ADD;
            MemRW = 0;
            WBSel = 2'd0;
        end
        //  BGEU
        {1'b?, f3_7, OPCODE_B_BRANCH}: begin
            PCSel = (BrLT == 1'b0) ? 1'b1: 1'b0;
            ImmSel = `SB_TYPE;
            RegWEn = 0;
            BrUn = 1;
            Bsel = 1;
            Asel = 1;
            ALUSel = `ALU_OP_ADD;
            MemRW = 0;
            WBSel = 2'd0;
        end
        // JALR
        {1'b?, f3_0, OPCODE_I_JALR}: begin
            PCSel = 1'b1;
            ImmSel = `I_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 1;
            Asel = 0;
            ALUSel = `ALU_OP_ADD;
            MemRW = 0;
            WBSel = 2'd2;
        end

        // JAL
        {1'b?, 3'b???, OPCODE_J_JAL}: begin
            PCSel = 1'b1;
            ImmSel = `UJ_TYPE;
            RegWEn = 1;
            BrUn = 0;
            Bsel = 1;
            Asel = 1;
            ALUSel = `ALU_OP_ADD;
            MemRW = 0;
            WBSel = 2'd2;
        end

        default: begin
            PCSel = 1'bx;
            ImmSel = 3'bxxx;
            RegWEn = 1'bx;
            BrUn = 1'bx;
            Bsel = 1'bx;
            Asel = 1'bx;
            ALUSel = 4'bxxxx;
            MemRW = 1'bx;
            WBSel = 2'bxx;
        end

    endcase
end

endmodule //controller

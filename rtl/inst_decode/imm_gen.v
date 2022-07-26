//    name    = imm_gen.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Sign extends Immediates of all types of instruction into 32 bit immediates
//    Potential Improvements = -

// `include "../../defines.vh"

module imm_gen
(
    input [31:7] sub_instr, // part of instruction
    input [2:0] ImmSel,     // Select type of instruction
    output reg [(`IMM_WIDTH)-1:0] imm // 32 bit immediate
);

always @(sub_instr, ImmSel) begin
    case (ImmSel)
        `R_TYPE:    imm =   { `IMM_WIDTH{1'b0} };
        `I_TYPE:    imm =   { {20{sub_instr[31]}}, sub_instr[31:20] };
        `S_TYPE:    imm =   { {20{sub_instr[31]}}, sub_instr[31:25], sub_instr[11:7] };
        `SB_TYPE:   imm =   { {19{sub_instr[31]}}, sub_instr[31], sub_instr[7], sub_instr[30:25], sub_instr[11:8], 1'b0 };
        `U_TYPE:    imm =   { sub_instr[31:12], 12'b0 };
        `UJ_TYPE:   imm =   { {12{sub_instr[31]}}, sub_instr[19:12], sub_instr[20], sub_instr[30:21], 1'b0 };
    endcase
end

endmodule

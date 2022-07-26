//    name    = alu.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Perform operation based on ALUSel
//    Potential Improvements = -

// `include "../../defines.vh"
module alu
(
    input [`OPERANDS_WIDTH-1:0] A,
    input [`OPERANDS_WIDTH-1:0] B,
    input [`ALU_SEL_WIDTH-1:0] ALUSel,
    output reg [`OPERANDS_WIDTH-1:0] result 
);

    reg carry; // Subtraction if 1'b1 else addition. 

    always @(A, B, ALUSel) begin
        case (ALUSel)
            // `ALU_OP_ADD, `ALU_OP_SUB : begin
            //     if (ALUSel == `ALU_OP_ADD)
            //         carry = 1'b0;   // Addition
            //     else
            //         carry = 1'b1;   // Subtraction
                
            //     adder_subtractor ADDER (
            //         .A(A),
            //         .B(B),
            //         .Cin(carry),
            //         .sum(result)
            //     );
            // end
            `ALU_OP_ADD: result = A+B;
            `ALU_OP_SUB: result = A-B;
            `ALU_OP_SLL: result = A << B[4:0];          
            `ALU_OP_SLT: result = {{`REG_WIDTH{1'b0}}, $signed(A) < $signed(B)};
            `ALU_OP_SLTU: result = {{`REG_WIDTH{1'b0}}, A < B};
            `ALU_OP_XOR: result = A ^ B;
            `ALU_OP_SRL: result = A >> B[4:0];
            `ALU_OP_SRA: result = $signed(A) >>> B[4:0];
            `ALU_OP_OR: result = A | B;
            `ALU_OP_AND: result = A & B;
            `ALU_OP_LUI: result = B;
            default :
                result = 0;
        endcase
    end
endmodule

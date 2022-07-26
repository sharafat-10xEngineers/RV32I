//    name    = branch_comp.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Compare rs1 and rs2 to find branch is taken or not.
//    Potential Improvements = -

// `include "../../defines.vh"

module branch_comp

(
    input [`REG_WIDTH-1:0] rs1,    // operand 1
    input [`REG_WIDTH-1:0] rs2,    // operand 2
    input BrUn, // 1: unsigned instruction
    output BrEq,    // 
    output reg BrLT
);

    reg BrLT_temp;
    assign BrEq = (rs1 == rs2);
    
    always @ (*) begin
        BrLT_temp = rs1 < rs2;
        if (BrUn == 1'b0)
            if (rs1[31] != rs2[31])
                BrLT = ~BrLT_temp;
            else
                BrLT = BrLT_temp;
        else 
            BrLT = BrLT_temp;
    end

    

endmodule

//    name    = WB_unit.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Guide requried signal to by stored in destinatio registor.

// `include "../../defines.vh"

module WB_unit

(
    input [1:0] WBSel,
    input [`DMEM_DATA_WIDTH-1:0] from_dmem,
    input [`OPERANDS_WIDTH-1:0] from_alu,
    input [`PC_WIDTH-1:0] pc_plus_4,
    output reg [`REG_WIDTH-1:0] to_regfile
);

always @ (*) begin
    case (WBSel)
        2'b00: to_regfile = from_dmem;
        2'b01: to_regfile = from_alu;
        2'b10: to_regfile = pc_plus_4;
    endcase
end


endmodule

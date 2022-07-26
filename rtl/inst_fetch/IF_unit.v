//    name    = IF_unit.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Containes Instructiom mem, Adder+4, Program counter, PCsel Mux
//    Potential Improvements = Updata ripple carry adder with Carry Look-Ahead Adder.

// `include "../defines.vh"
// `include "./registor.v"
// `include "../inst_fetch/mux.v"
// `include "../../memory/IMEM.v"

module IF_unit 
    `ifdef CUSTOM_DEFINE
        #(
            parameter   INSTRUCTION_WIDTH = `INSTRUCTION_WIDTH,
                        PC_WIDTH = `PC_WIDTH
        )
    `else 
        #(
            parameter   INSTRUCTION_WIDTH = 32,
                        PC_WIDTH 32
        )
    `endif
(
    input clk, 
    input reset,
    input PCSel,
    input [31:0] from_alu,
    output [PC_WIDTH-1:0] pc_plus_4,
    output [PC_WIDTH-1:0] pc_out,
    output [INSTRUCTION_WIDTH-1:0] inst
);
    wire [PC_WIDTH-1:0] if_mux_out; // mux out wire

    registor PC (
        .clk(clk),
        .reset(reset),
        .data_in(if_mux_out),
        .data_out(pc_out)
    );

    `ifdef MEM_IN_CORE
        IMEM instruction_memory (
            .addr(pc_out),
            .data_out(inst)
        );
    `endif

    assign pc_plus_4 = pc_out + 4;  // 4 increment adder

    mux if_mux (
        .port0(pc_plus_4),
        .port1(from_alu),
        .sel(PCSel),
        .result(if_mux_out)
    );


endmodule

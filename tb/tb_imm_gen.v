//    name    = tb_imm_gen.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Testing Immediate Generation Unit.
//    Potential Improvements = -

`timescale 1ns/1ps

`include "../rtl/inst_decode/imm_gen.v"
// `include "../defines.vh"

module tb_imm_gen;
    reg [31:7] sub_instr;   // part of instruction
    reg [2:0] ImmSel;       // Select instruction type
    wire [`IMM_WIDTH-1:0] imm;  // 32 bit immediate

    // Unit Under Test
    imm_gen uut (
        .sub_instr(sub_instr),
        .ImmSel(ImmSel),
        .imm(imm)
    );

    initial begin
        $dumpfile("test.vcd");
        $dumpvars;
    end

    initial begin
        sub_instr = 25'b1111_0000_0000_0000_0000_0000_0;
        ImmSel = `I_TYPE;
        #20
        $finish;        
    end
endmodule

//    name    = tb_branch_comp.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Testing Immediate Branch Comparison unit.
//    Potential Improvements = -

`timescale 1ns/1ps

`include "../rtl/inst_execute/branch_comp.v"
// `include "../defines.vh"

module tb_branch_comp;
    reg [`REG_WIDTH-1:0] rs1;    // operand 1
    reg [`REG_WIDTH-1:0] rs2;    // operand 2
    reg BrUn; // 1: unsigned instruction
    wire BrEq;    // 
    wire BrLT;
    // Unit Under Test
    branch_comp uut (
        .rs1(rs1),
        .rs2(rs2),
        .BrUn(BrUn),
        .BrEq(BrEq),
        .BrLT(BrLT)
    );

    initial begin
        $dumpfile("test.vcd");
        $dumpvars;
    end

    initial begin
        BrUn = 1;
        rs1 = 'd3;
        rs2 = 'd3;
        #10
        BrUn = 1;
        rs1 = 'd3;
        rs2 = 'd4;
        #10
        BrUn = 0;
        rs1 = 100;
        rs2 = -100;
        #10
        BrUn = 0;
        rs1 = 'd3;
        rs2 = 'd6;
        #10
        $finish;        
    end
endmodule

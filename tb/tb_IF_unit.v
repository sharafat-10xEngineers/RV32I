//    name    = tb_IF_unit.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Testing Instruction Fetch Unit.
//    Potential Improvements = -

`timescale 1ns/1ps

`include "../rtl/inst_fetch/IF_unit.v"
// `include "../defines.vh"

module tb_IF_unit;

    `ifdef CUSTOM_DEFINE
            parameter   INSTRUCTION_WIDTH = `INSTRUCTION_WIDTH,
                        PC_WIDTH = `PC_WIDTH;
    `else 
            parameter   INSTRUCTION_WIDTH = 32,
                        PC_WIDTH 32;
    `endif

    reg clk;
    reg reset;
    reg PCSel;
    reg [31:0] from_alu;    // still need parameterization
    wire [PC_WIDTH-1:0] pc_plus_4;
    wire [PC_WIDTH-1:0] pc_out;
    wire [INSTRUCTION_WIDTH-1:0] inst;
    
    // Unit Under Test
    IF_unit uut (
        .clk(clk),
        .reset(reset),
        .PCSel(PCSel),
        .from_alu(from_alu),
        .pc_plus_4(pc_plus_4),
        .pc_out(pc_out),
        .inst(inst)
    );

    always begin
        clk = 0;
        forever #5  clk = ~clk;
    end

    initial begin
        $dumpfile("test.vcd");
        $dumpvars;
    end

    initial begin
        reset = 1;
        #4
        reset = 0;
        PCsel = 0;
        from_alu = 32'h0000000C;
        #10
        PCsel = 1;
        from_alu = 32'h0000000C;
        #20
        $finish;        
    end
endmodule

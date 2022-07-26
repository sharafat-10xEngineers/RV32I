//    name    = tb_alu.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Testing Arithmatic Logical Unit.
//    Potential Improvements = -

`timescale 1ns/1ps

`include "../rtl/inst_execute/alu.v"
module tb_alu;

    // `include "../defines.vh"
    reg [`OPERANDS_WIDTH-1:0] A;
    reg [`OPERANDS_WIDTH-1:0] B;
    reg [`ALU_SEL_WIDTH-1:0] ALUSel;
    wire [`OPERANDS_WIDTH-1:0] result; 
    // Unit Under Test
    alu uut (
        .A(A),
        .B(B),
        .ALUSel(ALUSel),
        .result(result)
    );

    initial begin
        $dumpfile("test.vcd");
        $dumpvars;
    end

    initial begin
        A = 0;
        B = 5;
        ALUSel = 0;
        #10
        A = 40;
        B = -50;
        ALUSel = 1;
        #10
        A = -5;
        B = 10;
        ALUSel = 3;
        #10
        A = -4;
        B = 1;
        ALUSel = 7;
        #10
        

        $finish;        
    end
endmodule

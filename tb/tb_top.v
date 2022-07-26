//    name    = imm_gen.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Tesing top module of single cycle processor.
//    Potential Improvements = -

`timescale 1ns/1ps

`include "../rtl/top.v"

module tb_top;
    reg clk;
    reg reset;
    wire [31:0] result;

    top dut(
        .clk(clk),
        .reset(reset),
        .result(result)
    );

    always begin
        clk = 0;
        forever #5  clk = ~clk;
    end

    initial begin
        $dumpfile("test.vcd");
        $dumpvars;
    end

        integer i;
    initial begin
        reset = 1;
        #10
        reset = 0;
        // $monitor("Reg[8] = %d, Reg[9] = %d", dut.regFile.Reg[8], dut.regFile.Reg[9]);
        // $monitor("Reg[3] = %d, Reg[4] = %d", dut.regFile.Reg[3], dut.regFile.Reg[4]);
        #400
        // for (i =0; i<181; i = i+1)
        //     $display("Mem[%d] = %d",i, dut.memAccess.dataMemory.dmem[i]);
        // $monitor("Mem[100]", dut.memAccess.dataMemory.dmem[100]);
        
        for (i =0; i<32; i = i+1)   
            $display("Mem[%d] = %d",i, dut.regFile.Reg[i]);
        
        #500
        
        $finish;        
    end
endmodule
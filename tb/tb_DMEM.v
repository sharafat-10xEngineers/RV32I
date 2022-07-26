//    name    = tb_DMEM.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Testbench for IMEM module (../rtl/IMEM.v).


`include "../memory/DMEM.v"

module tb_DMEM;
    reg clk;
    reg MemRW;
    reg   [31:0]  addr;
    reg   [31:0]  data_in;
    wire  [31:0]  data_out;
    
    DMEM memoryB (
        .clk(clk),
        .MemRW(MemRW),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial begin
        clk = 0;
        #500 $finish;
    end
    always #5 clk = ~clk;

    initial begin
        MemRW = 0;
        addr = 0;
        data_in = 0;
        #10
        MemRW = 1;
        addr = 4;
        data_in = 55;
        #10
        MemRW = 0;
        addr = 4;
        data_in = 0;
        
    end

    initial begin
        $dumpfile("sim.vcd");
        $dumpvars;
    end
endmodule

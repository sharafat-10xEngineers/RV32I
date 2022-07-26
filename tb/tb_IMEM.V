//    name    = tb_IMEM.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Testbench for IMEM module (../rtl/IMEM.v).


`include "../memory/IMEM.v"

module tb_IMEM;
    reg   [31:0]  addr;
    // reg   [31:0]  data_in;
    wire  [31:0]  data_out;
    
    IMEM memoryA (
        .addr(addr),
        // .data_in(data_in),
        .data_out(data_out)
    );

    // initial begin
    //     clk = 0;
    //     #500 $finish;
    // end
    // always #5 clk = ~clk;
    integer i;
    initial begin
        addr = 0;
        // data_in = 0;

        for (i = 0; i < 50; i++) begin
            $display ("mem[%d] = %h",i, memoryA.imem[i]);
        end
        
        #20

        addr = 0;#20
        addr = 4;#20
        addr = 8;#20
        addr = 12;
    end

    initial begin
        $dumpfile("sim.vcd");
        $dumpvars;
    end
endmodule

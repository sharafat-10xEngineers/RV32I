//    name    = tb_mux.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Testbench for adder module (../mux.v).


`include "../rtl/inst_fetch/mux.v"
// `include "../defines.vh"
module tb_mux;

    reg [31:0] port0;
    reg [31:0] port1;
    reg sel;
    wire [31:0] result;

    mux DUT (
        .port0(port0),
        .port1(port1),
        .sel(sel),
        .result(result)
    );

    // initial begin
    //     clk = 0;
    //     #500 $finish;
    // end
    // always #5 clk = ~clk;
    initial begin
        sel = 0;
        port0 = 32'hFFFFFFFF;
        port1 = 32'h11111111;
        
        #20
        sel = 1;
        port0 = 32'hFFFFFFFF;
        port1 = 32'h11111111;
        
     
        #100 $finish;
    end

    initial begin
        $dumpfile("sim.vcd");
        $dumpvars;
    end
endmodule

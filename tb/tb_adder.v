//    name    = tb_adder.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Testbench for adder module (../adder.v).


`include "../rtl/inst_execute/adder_subtractor.v"
// `include "../defines.vh"
module tb_IMEM;

    `ifdef CUSTOM_DEFINE
        
            parameter   ADDER_WIDTH = `ADDER_WIDTH;
        
    `else
        
            parameter   ADDER_WIDTH = 32;
        
    `endif

    reg [ADDER_WIDTH-1:0] A;
    reg [ADDER_WIDTH-1:0] B;
    reg Cin;
    wire [ADDER_WIDTH-1:0] sum;
    // wire Cout;

    adder_subtractor DUT (
        .A(A),
        .B(B),
        .Cin(Cin),
        .sum(sum),
        // .Cout(Cout)
    );
    // initial begin
    //     clk = 0;
    //     #500 $finish;
    // end
    // always #5 clk = ~clk;
    initial begin
        A = 0;
        B = 0;
        Cin = 0;
        #20
        Cin = 1;
        A = 64'hAAAAAAAAFFFFFFFF;
        B = 64'h1;

        // #20
        // Cin      
        #100 $finish;
    end

    initial begin
        $dumpfile("sim.vcd");
        $dumpvars;
    end
endmodule

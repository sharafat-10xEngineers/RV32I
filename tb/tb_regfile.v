//    name    = tb_regfile.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Testing regfile
//    Potential Improvements = -

`timescale 1ns/1ps

`include "../rtl/inst_decode/regfile.v"
`include "../defines.vh"

module tb_regfile;
    `ifdef CUSTOM_DEFINE
        parameter   REG_WIDTH = `REG_WIDTH,
                    REG_DEPTH = `REG_DEPTH,
                    REG_ADDR_WIDTH = `REG_ADDR_WIDTH;
    `else
        parameter   REG_WIDTH = 32,
                    REG_DEPTH = 32,
                    REG_ADDR_WIDTH = 5;
    `endif

    reg clk;
    reg reset;
    reg RegWEn;   // write dataD when high at addD
    reg [REG_ADDR_WIDTH-1:0] addrA;   // address of rs1
    reg [REG_ADDR_WIDTH-1:0] addrB;   // address of rs2
    reg [REG_ADDR_WIDTH-1:0] addrD;   // address of dest. registor
    reg [REG_WIDTH-1:0] dataD;    // Data to write
    wire [REG_WIDTH-1:0] dataA;   // rs1
    wire [REG_WIDTH-1:0] dataB;    // rs2    
    integer i;  // loop varialbe
    // Unit Under Test
    regfile uut (
        .clk(clk),
        .reset(reset),
        .RegWEn(RegWEn),
        .addrA(addrA),
        .addrB(addrB),
        .addrD(addrD),
        .dataD(dataD),
        .dataA(dataA),
        .dataB(dataB)
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
        #10 
        reset = 0;
        RegWEn = 1;
        dataD = 255;
        addrD = 5'd1;
        addrA = 0;
        addrB = 0;
        #10
        RegWEn = 1;
        dataD = 254;
        addrD = 5'd2;
        addrA = 0;
        addrB = 0;
        #10
        RegWEn = 0;
        dataD = 255;
        addrD = 5'd1;
        addrA = 5'd1;
        addrB = 5'd2;
        #10

        RegWEn = 1;
        dataD = 32'hFFFF;
        addrD = 5'd0;
        addrA = 0;
        addrB = 0;
        #10
        RegWEn = 0;
        dataD = 254;
        addrD = 5'd2;
        addrA = 0;
        addrB = 0;
        #10

        for (i = 0; i < 32; i++)
            $display ("Reg[%d] = %d", i, uut.Reg[i]);
        
        $finish;        
    end
endmodule

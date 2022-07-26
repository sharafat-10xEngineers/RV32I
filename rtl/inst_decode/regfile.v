//    name    = regile.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = 32 r0-r31  General purpose registor with r0 = 32'd0 
//    Potential Improvements = -

module regfile
    `ifdef CUSTOM_DEFINE
    #(
        parameter   REG_WIDTH = `REG_WIDTH,
                    REG_DEPTH = `REG_DEPTH,
                    REG_ADDR_WIDTH = `REG_ADDR_WIDTH
    )
    `else
    #(
        parameter   REG_WIDTH = 32,
                    REG_DEPTH = 32,
                    REG_ADDR_WIDTH = 5
    )
    `endif
(
    input clk,
    input reset,
    input RegWEn,   // write dataD when high at addD
    input [REG_ADDR_WIDTH-1:0] addrA,   // address of rs1
    input [REG_ADDR_WIDTH-1:0] addrB,   // address of rs2
    input [REG_ADDR_WIDTH-1:0] addrD,   // address of dest. registor
    input [REG_WIDTH-1:0] dataD,    // Data to write in Registor
    output reg[REG_WIDTH-1:0] dataA,   // rs1
    output reg [REG_WIDTH-1:0] dataB    // rs2
);
    
    reg [REG_WIDTH-1:0] Reg [REG_DEPTH-1:0];    // REG_WIDTH x REG_DEPTH 
    reg [REG_ADDR_WIDTH:0] i;     // loop variable
    
    always @(*) begin
        if (addrA == {REG_ADDR_WIDTH{1'b0}})
            dataA = {REG_WIDTH{1'b0}};
        else
            dataA = Reg[addrA];

        if (addrB == {REG_ADDR_WIDTH{1'b0}})
            dataB = {REG_WIDTH{1'b0}};
        else
            dataB = Reg[addrB];
    end

    always @(posedge clk ) begin
        // Initializing all registor to 0 with asynchrounus reset.
        if (reset)
            for (i = 0; i <= { REG_ADDR_WIDTH { 1'b1 } }; i++)
                Reg[i] = {REG_WIDTH{1'b0}};
        else if (RegWEn == 1'b1)    // Write data to registor.
            Reg[addrD] <= dataD;
    end

endmodule

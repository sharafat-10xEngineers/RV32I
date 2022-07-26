//    name    = DMEM.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Async read and sync write.

// `include "../defines.vh"

module DMEM
    `ifdef CUSTOM_DEFINE
        #(
            parameter   DMEM_ADDR_WIDTH = `DMEM_ADDR_WIDTH,
                        DMEM_DATA_WIDTH = `DMEM_DATA_WIDTH,
                        DMEM_WIDTH = `DMEM_WIDTH,
                        DMEM_DEPTH = `DMEM_DEPTH
        )
    `else
        #(
            parameter   DMEM_ADDR_WIDTH = 32,
                        DMEM_DATA_WIDTH = 32,
                        DMEM_WIDTH = 8,
                        DMEM_DEPTH = 256
        )
    `endif
         
(
    input clk,
    input MemRW,
    input   [DMEM_ADDR_WIDTH-1:0]  addr,
    input   [DMEM_DATA_WIDTH-1:0]  data_in,
    output  [DMEM_DATA_WIDTH-1:0]  data_out
);
    
    reg [DMEM_WIDTH-1:0] dmem [DMEM_DEPTH-1:0];     // 8 x 256 memory
    
    // asynchronus read of 32 bit data from byte align memory
    assign data_out = { dmem[addr], dmem[addr+1], dmem[addr+2], dmem[addr+3] };  

    always @(posedge clk) begin
        if (MemRW == 1'b1)
            { dmem[addr], dmem[addr+1], dmem[addr+2], dmem[addr+3] } <= data_in;
    end

endmodule
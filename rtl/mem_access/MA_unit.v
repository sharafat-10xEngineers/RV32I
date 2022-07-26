//    name    = MA_unit.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Guide requried signal to by stored in destinatio registor.

// `include "../../defines.vh"
// `include "../../memory/DMEM.v"

module MA_unit

(
    input clk,
    input MemRW,
    input   [`DMEM_ADDR_WIDTH-1:0]  addr,
    input   [`DMEM_DATA_WIDTH-1:0]  data_in,
    output  [`DMEM_DATA_WIDTH-1:0]  data_out

);

    DMEM dataMemory (
        .clk(clk),
        .MemRW(MemRW),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

endmodule

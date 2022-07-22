//    name    = IMEM.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Design to store riscv machine instruction read
//              by PC registor. Instruction are loaded from file
//              name "instructions.txt" in hexadeciamal notation.

module IMEM
    `ifdef CUSTOM_DEFINE
        #(
            parameter   IMEM_ADDR_WIDTH = IMEM_ADDR_WIDTH,
                        IMEM_DATA_WIDTH = IMEM_DATA_WIDTH,
                        IMEM_WIDTH = IMEM_WIDTH,
                        IMEM_DEPTH = IMEM_DEPTH
        )
    `else
        #(
            parameter   IMEM_ADDR_WIDTH = 32,
                        IMEM_DATA_WIDTH = 32,
                        IMEM_WIDTH = 8,
                        IMEM_DEPTH = 256
        )
    `endif
         

 (
    input   [IMEM_ADDR_WIDTH-1:0]  addr,
    // input   [IMEM_DATA_WIDTH-1:0]  data_in,
    output  [IMEM_DATA_WIDTH-1:0]  data_out
);
    
    reg [IMEM_WIDTH:0] imem [0:IMEM_DEPTH];     // 8 x 256 memory
    
    // asynchronus read of 32 bit data from byte align memory
    assign data_out = { imem[addr], imem[addr+1], imem[addr+2], imem[addr+3] };  

    // initalizaing memory with machine code placed in "instruction.mem" file.
    initial begin
        $readmemh ("../instructions.mem", imem);
    end

endmodule
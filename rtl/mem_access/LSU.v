//    name    = LSU.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Load Store unit for data memory to support lb, lh, lw, lbu, lhu, lwu, sb, sh, sw instruction.

`include "../defines.vh"
`include "../memory/DMEM.v"

module LSU

(
    input clk,
    input MemRW,    // from controller
    input [3:0] dmem_type, // from controller
    input [DMEM_DATA_WIDTH-1:0] DM_ReadData,
    input   [`DMEM_ADDR_WIDTH-1:0]  addr,
    input   [`DMEM_DATA_WIDTH-1:0]  data_in,
    output reg  [`DMEM_DATA_WIDTH-1:0]  data_out    
);
    // wire [`DMEM_DATA_WIDTH-1:0] buffer;
    // reg [`DMEM_DATA_WIDTH-1:0] shifted_data, write_data;
    // reg [3:0] byte_en
    // always @(*) begin
    //     if (dmem_type[1:0] == 2'b10)
    //         shifted_data = buffer;
    //     else if (dmem_type[1:0] == 2'b01)
    //         shifted_data = (addr[1:0] == 2'b10) ? (32'hFFFF0000) & buffer : (32'h0000FFFF) & buffer
    //     else if (dmem_type[1:0] == 2'b00)
    //         if (addr[1:0] == 2'b00)
    //             shifted_data = 32'h000000FF & buffer;  // bit masking for 
    //         else if (addr[1:0] == 2'b01)
    //             shifted_data = 32'h0000FF00 & buffer;  // bit masking for 
    //         else if (addr[1:0] == 2'b10)
    //             shifted_data = 32'h00FF0000 & buffer;  // bit masking for 
    //         else 
    //             shifted_data = 32'hFF000000 & buffer;  // bit masking for 
    //     else shifted_data = buffer;
    // end

    // case(dmem_type) 
    //     4'b0000 : data_out = {{`DMEM_DATA_WIDTH-8{shifted_data[7]}}, shifted_data[7:0]}; 		// LB
    //     4'b0001 : data_out = {{`DMEM_DATA_WIDTH-16{shifted_data[15]}}, shifted_data[15:0]}; 	// LH
    //     4'b0100 : data_out = {{`DMEM_DATA_WIDTH-8 {1'b0}}, shifted_data[7:0]}; 				// LBU
    //     4'b0101 : data_out = {{`DMEM_DATA_WIDTH-16{1'b0}}, shifted_data[15:0]}; 				// LHU
    //     default : data_out = shifted_data;
    // endcase

    
    // always @(*) begin
    //     case (dmem_type)
    //         3'b0110: begin
    //             if (addr[1:0] == 2'b00)

    //                 write_data = data_in & buffer;  // bit masking for 
    //             else if (addr[1:0] == 2'b01)
    //                 shifted_data = 32'h0000FF00 & buffer;  // bit masking for 
    //             else if (addr[1:0] == 2'b10)
    //                 shifted_data = 32'h00FF0000 & buffer;  // bit masking for 
    //             else 
    //                 shifted_data = 32'hFF000000 & buffer;  // bit masking for
    //         end
    //         3'b0111:
    //         3'b1000:
    //     endcase
    // end
    reg [`REG_WIDTH-1:0] read_data, shifted_rd, wr_data;
	reg ex_ld_addr, ex_st_addr;
	wire ex; 
	reg [3:0] byte_en;
    assign data_out = read_data;

    assign o_DM_Wd      = wr_data;
	assign o_DM_Addr    = {i_addr[`XLEN-1:2], 2'b00};
    case(func3[1:0])
        2'b00 : begin
            byte_en[0] = i_addr[1:0] == 2'b00;  
            byte_en[1] = i_addr[1:0] == 2'b01;  
            byte_en[2] = i_addr[1:0] == 2'b10;  
            byte_en[3] = i_addr[1:0] == 2'b11;  
        end
        2'b01 : begin
            byte_en[1:0] = (i_addr[1] == 1'b0) ? 2'b11 : 2'b00;
            byte_en[3:2] = (i_addr[1] == 1'b1) ? 2'b11 : 2'b00;
        end
        2'b10 : begin
            byte_en = 4'b1111;
        end
        default: byte_en = 4'b0000;
    endcase

    // Read data handler.
    case(byte_en)
        4'b0010 : shifted_rd = i_DM_ReadData >> 8;
        4'b0100 : shifted_rd = i_DM_ReadData >> 16;
        4'b1100 : shifted_rd = i_DM_ReadData >> 16;
        4'b1000 : shifted_rd = i_DM_ReadData >> 24;
        default : shifted_rd = i_DM_ReadData;
    endcase

    case(func3) 
        3'b000 : read_data = {{`REG_WIDTH-8{shifted_rd[7]}}, shifted_rd[7:0]}; 		// LB
        3'b001 : read_data = {{`REG_WIDTH-16{shifted_rd[15]}}, shifted_rd[15:0]}; 	// LH
        3'b100 : read_data = {{`REG_WIDTH-8 {1'b0}}, shifted_rd[7:0]}; 				// LBU
        3'b101 : read_data = {{`REG_WIDTH-16{1'b0}}, shifted_rd[15:0]}; 				// LHU
        default : read_data = shifted_rd;
    endcase 

    // Write data handler
    // Checking which bytes must be written (SB, SH, SW).
    // Shifting the data to be written since the two LSB bits of
    // the accessed address are always 2'b00. 
    case(byte_en)
        4'b0010 : wr_data = i_wr_data << 8;
        4'b0100 : wr_data = i_wr_data << 16;
        4'b1100 : wr_data = i_wr_data << 16;
        4'b1000 : wr_data = i_wr_data << 24;
        default : wr_data = i_wr_data;
    endcase
    
    DMEM dataMemory (
        .clk(clk),
        .MemRW(MemRW),
        .addr(addr),
        .data_in({data_in[31:2], 2'b00}),
        .data_out(buffer)
    );



endmodule

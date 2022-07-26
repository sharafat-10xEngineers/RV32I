//    name    = registor.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Parameterized Registor
//    Potential Improvements = -


module registor (
    input clk,
    input reset,
    input [31:0] data_in,
    output reg [31:0] data_out
);
    
    always @ (posedge clk) 
        if (reset == 1'b1)
            data_out <= 0;
        else
            data_out <= data_in;           
endmodule //registor with reset
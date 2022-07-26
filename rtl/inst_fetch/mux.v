//    name    = mux.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = 2 to 1 Multiplexor
//    Potential Improvements = -

module mux #(
    parameter WIDTH = 32
) (
    input [WIDTH-1:0] port0,
    input [WIDTH-1:0] port1,
    input sel,
    output [WIDTH-1:0] result
);

    assign result = sel ? port1 : port0;
endmodule
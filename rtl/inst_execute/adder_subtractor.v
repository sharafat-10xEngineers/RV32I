//    name    = adder.v
//    author  = Sharafat Hussain
//    email   = sharafat.hussain@10xengineers.ai
//    purpose = Add/subtract two Numbers based on Cin.
//    Potential Improvements = Updata ripple carry adder with carry Carry Look-Ahead Adder.

// `include "../../defines.vh"

module adder_subtractor
    `ifdef CUSTOM_DEFINE
        #(
            parameter   ADDER_WIDTH = `ADDER_WIDTH
        )
    `else
        #(
            parameter   ADDER_WIDTH = 32
        )
    `endif

(
    input [ADDER_WIDTH-1:0] A,
    input [ADDER_WIDTH-1:0] B,
    input Cin,
    output [ADDER_WIDTH-1:0] sum
    // output Cout
);
    wire Cout;
    wire rippleCarry[(ADDER_WIDTH/4): 0];

    assign rippleCarry[0] = Cin;
    assign Cout = rippleCarry[ADDER_WIDTH/4];

    genvar i;   // loop variable generate for

    generate
        for (i = 0; i < (ADDER_WIDTH); i = i+4) begin : adder32bit
            adder_subtractor_4bit as4bit (
                .A(A[i+3:i]),
                .B(B[i+3:i]),
                .Cin(rippleCarry[(i/4)]),
                .Cout(rippleCarry[(i/4)+1]),
                .sum(sum[i+3:i])
            );
        end
    endgenerate

endmodule

module adder_subtractor_4bit(
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output Cout,
    output [3:0] sum
);
    wire b_xor_0;   // xor of B[0]
    wire b_xor_1;   // xor of B[1]
    wire b_xor_2;   // xor of B[2]
    wire b_xor_3;   // xor of B[3]

    wire Cout_0;    // Carry out FA0
    wire Cout_1;    // Carry out FA1
    wire Cout_2;    // Carry out FA2   
                    // Cout Carry out FA3

    xor b_xor_cin_0 (b_xor_0, B[0], Cin);
    xor b_xor_cin_1 (b_xor_1, B[1], Cin);
    xor b_xor_cin_2 (b_xor_2, B[2], Cin);
    xor b_xor_cin_3 (b_xor_3, B[3], Cin);
    
    full_adder fa_0 (
        .X1(A[0]),
        .X2(b_xor_0),
        .Cin(Cin),
        .S(sum[0]),
        .Cout(Cout_0)
    );

    full_adder fa_1 (
        .X1(A[1]),
        .X2(b_xor_1),
        .Cin(Cout_0),
        .S(sum[1]),
        .Cout(Cout_1)
    );

    full_adder fa_2 (
        .X1(A[2]),
        .X2(b_xor_2),
        .Cin(Cout_1),
        .S(sum[2]),
        .Cout(Cout_2)
    );

    full_adder fa_3 (
        .X1(A[3]),
        .X2(b_xor_3),
        .Cin(Cout_2),
        .S(sum[3]),
        .Cout(Cout)
    );

endmodule

module full_adder( 
    input X1,
    input X2,
    input Cin, 
    output S,
    output Cout
    );

    wire a1, a2, a3;

    assign Cout = X1 && X2 || X2 && Cin || Cin && X1;
    assign S = X1 ^ X2 ^ Cin;

endmodule


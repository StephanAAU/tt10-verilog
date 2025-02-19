`default_nettype none

module datapath #(parameter W = 16)
    (
    input wire clk,
    input wire reset,

    input  wire [15:0] AB,
    output wire [15:0] C,

    input wire ABorALU,
    input wire LDA,
    input wire LDB,

    output wire N,
    output wire Z,

    input wire [1:0] FN
    );

    wire [W-1:0] C_int, Y, RegA_int, RegB_int;

    buff #(.N(W)) output_buffer (
        .data_in(C_int), 
        .data_out(C)
    );

    mux #(.N(W)) input_mux (
        .data_in1(Y),
        .data_in2(AB),
        .s(ABorALU),
        .data_out(C_int)
    );

    regi #(.N(W)) regA (
        .clk(clk),
        .en(LDA),
        .data_in(C_int),
        .data_out(RegA_int)
    );

    regi #(.N(W)) regB (
        .clk(clk),
        .en(LDB),
        .data_in(C_int),
        .data_out(RegB_int)
    );

    alu #(.W(W+1)) alu_comp (
        .A({1'b0, RegA_int}),
        .B({1'b0, RegB_int}),
        .fn(FN),
        .C[17](1'b0),
        .C[16:0](Y),
        .Z(Z),
        .N(N)
    );
endmodule
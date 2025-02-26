// Lab 3 exercise
// Greatest common divisor (GCD) computation

`default_nettype none

module gcd_module
    (
        input wire        reset,
        input wire        clk,

        input wire        req,
        input wire [15:0] AB,

        output wire        ack,
        output wire [15:0] C
    );

    wire        ABorALU_int, LDA_int, LDB_int, N_int, Z_int;
    wire [1:0]  FN_int;

    fsm fsm_comp (
        .clk(clk),
        .reset(reset),
        
        .req(req),
        .ack(ack),

        .ABorALU(ABorALU_int),
        .LDA(LDA_int),
        .LDB(LDB_int),
        .N(N_int),
        .Z(Z_int),

        .FN(FN_int)
    );

    datapath datapath_comp (
        .clk(clk),
//        .reset(reset),

        .AB(AB),
        .C(C),

        .ABorALU(ABorALU_int),
        .LDA(LDA_int),
        .LDB(LDB_int),

        .N(N_int),
        .Z(Z_int),
        
        .FN(FN_int)
    );

endmodule
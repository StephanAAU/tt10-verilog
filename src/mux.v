`default_nettype none

// 2 to 1 multiplexor

module mux #(parameter N = 16)
    (
        input   wire [N-1:0] data_in1,
        input   wire [N-1:0] data_in2,
        input   wire         s,
        output  wire [N-1:0] data_out
    );

    assign data_out = s ? data_in2 : data_in1;

endmodule
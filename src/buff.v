`default_nettype none

// Buffer components.
module buff #(parameter N = 16)
    (
        input   wire [N-1:0] data_in,
        output  wire [N-1:0] data_out
    );

    assign data_out = data_in;

endmodule
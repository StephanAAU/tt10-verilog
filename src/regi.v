`default_nettype none

// Pos edge reg with en
module regi #(parameter N = 16)
    (
        input   wire         clk,
        input   wire         en,    
        input   wire [N-1:0] data_in,
        output  reg [N-1:0] data_out
    );

    always @(posedge clk)
    begin
        if (en)
            data_out <= data_in;
    end
endmodule

`default_nettype none

// Pos edge reg with en
module regi #(parameter N = 16)
    (
        input   wire         clk,
        input   wire         en,    
        input   wire         rst,
        input   wire [N-1:0] data_in,
        output  reg [N-1:0] data_out
    );

    always @(posedge clk or posedge rst)
    begin
        if (rst == 1) begin
            data_out <= 0;
        end
        else if (en == 1) begin
            data_out <= data_in;
        end
        else begin
            data_out <= data_out;
        end
    end
endmodule

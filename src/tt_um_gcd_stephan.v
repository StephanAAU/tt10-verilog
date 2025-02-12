// Wrapper for GCD module

module tt_um_gcd_stephan (
    input wire clk,
    input wire rst_n,
    input wire ena,

    input wire [7:0] ui_in,
    input wire [7:0] uio_in,
    output wire [7:0] uo_out,
    output wire [7:0] uio_out,
    output reg [7:0] uio_oe
    );

    wire [15:0] AB;
    wire [6:0] C;
    wire req;
    wire ack;
    reg rst;
    wire imNothing = 8'b0;

    assign AB = {imNothing, uio_in[6:0], ui_in};
    assign req = ui_in[7];
    assign ack = uio_in[7];
    assign uo_out[6:0] = C[6:0];
    assign uo_out[7] = ack;

    assign uio_out = imNothing;
    
    always @ * begin
    end

    assign rst = ~rst_n | ~ena;

    gcd_module gcd_module_inst (
        .reset(rst),
        .clk(clk),
        .req(req),
        .AB(AB),
        .ack(ack),
        .C(C)
    );
endmodule
// Wrapper for GCD module

module tt_um_gcd_stephan (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
    );

    wire [15:0] AB;
    /* verilator lint_off UNUSEDSIGNAL */
    reg [15:0] C; 
    /* verilator lint_on UNUSEDSIGNAL */
    wire req_w;
    wire ack_w;
    reg rst;
    wire zero_bit_wire = 1'b0;

    assign AB = {zero_bit_wire, uio_in[6:0], ui_in[7:0]};
    assign req_w = uio_in[7];

    assign uo_out[6:0] = C[6:0];
    assign uo_out[7] = ack_w;
    
    assign uio_oe = 8'b0; //{zero_bit_wire, zero_bit_wire, zero_bit_wire, zero_bit_wire, zero_bit_wire, zero_bit_wire, zero_bit_wire, zero_bit_wire};
    assign uio_out = 8'b0; //{zero_bit_wire, zero_bit_wire, zero_bit_wire, zero_bit_wire, zero_bit_wire, zero_bit_wire, zero_bit_wire, zero_bit_wire};

    assign rst = ~rst_n;

    wire _unused = &{ena, 1'b0};

    gcd_module gcd_module_inst (
        .reset(rst),
        .clk(clk),
        .req(req_w),
        .AB(AB),
        .ack(ack_w),
        .C(C)
    );
endmodule
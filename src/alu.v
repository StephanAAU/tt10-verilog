`default_nettype none

// Simple ALU twos complement
// FN selects function:
// fn = 00 : C = A - B
// fn = 01 : C = B - A
// fn = 10 : C = A
// fn = 11 : C = B
// The ALU sets the two flags "Z" and "N" which indicates if the result was zero or negative.
module alu #(parameter W = 16)
    (
        input wire  [W-1:0] A,
        input wire  [W-1:0] B,
        input wire  [1:0] fn,
        output reg [W-1:0] C,
        output reg Z,
        output reg N
    );

    always @(*) begin
        case (fn)
            2'b00: C = A - B;
            2'b01: C = B - A;
            2'b10: C = A;
            2'b11: C = B;
            default: C = 0;
        endcase
    end;

    always @(*) begin
        if (C) begin
            Z = 0;
        end
        else 
        begin
            Z = 1;
        end
            
    end;
    always @(*) begin
        if (C[W-1] == 1) begin
            N = 1;
        end
        else
        begin
            N = 0;
        end
    end

endmodule

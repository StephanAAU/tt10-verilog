`default_nettype none

module fsm (
    input wire clk,
    input wire reset,

    input  wire req,
    output reg ack,

    output reg ABorALU,
    output reg LDA,
    output reg LDB,

    input  wire N,
    input  wire Z,

    output reg [1:0] FN
    );

    reg [2:0] state, next_state;

    parameter ready_a   = 0,
              load_a    = 1,
              ready_b   = 2,
              load_b    = 3,
              calc      = 4,
              calc_done = 5,
              sub_ba    = 6,
              sub_ab    = 7,
              store_reg = 8;

    // Registers for the state machine
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            state = 2'b000;
        else
            state = next_state;
    end

    // State machine logic
    always @(*) 
    begin
        case (state) 

        ready_a: begin
            FN  = 2'b10;
            ack = 0;

            if (req == 1)
                next_state = load_a;
        end
        load_a: begin
            FN          = 2'b10;
            ABorALU     = 1;
            LDA         = 1;
            ack         = 1;

            if (req == 1'b0)
                next_state = ready_b;
        end
        ready_b: begin
            ABorALU     = 0;
            LDA         = 0;
            ack         = 0;

            if (req == 1'b1)
                next_state = load_b;
        end

        load_b: begin
            FN          = 2'b11;
            ABorALU     = 1;
            LDB         = 1;

            if (req == 1'b1)
                next_state = calc;
        end

        calc: begin
            FN          = 2'b00;
            ABorALU     = 0;
            LDA         = 0;
            LDB         = 0;

            if (Z == 1)
                next_state = calc_done;
            else if (N == 1)
                next_state = sub_ba;
            else
                next_state = sub_ab;
        end

        calc_done: begin
            FN          = 2'b10;
            ack         = 1;
            if (req == 0)
                next_state = ready_a;
        end

        sub_ba: begin
            FN          = 2'b01;
            LDB         = 1;
            
            next_state  = calc;
        end

        sub_ab: begin
            FN          = 2'b00;
            LDA         = 1;

            next_state = calc;
        end

        default:
            next_state = ready_a;

        endcase
    end

endmodule
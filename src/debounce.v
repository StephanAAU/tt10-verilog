module debounce
  (input  clk,
   input  reset,
   input  sw,
   output db_level,
   output db_tick);
  wire [1:0] state_reg;
  wire [1:0] state_next;
  wire [19:0] q_reg;
  wire [19:0] q_next;
  wire q_load;
  wire q_dec;
  wire q_zero;
  wire sw_reg1;
  wire sw_reg2;
  wire [19:0] n23_o;
  wire [19:0] n25_o;
  wire [19:0] n26_o;
  wire n29_o;
  wire n30_o;
  wire [1:0] n35_o;
  wire n38_o;
  wire n40_o;
  wire n43_o;
  wire [1:0] n45_o;
  wire n47_o;
  wire [1:0] n49_o;
  wire n52_o;
  wire n54_o;
  wire n55_o;
  wire [1:0] n57_o;
  wire n60_o;
  wire n62_o;
  wire n63_o;
  wire [1:0] n65_o;
  wire [1:0] n67_o;
  wire n70_o;
  wire n72_o;
  wire [3:0] n73_o;
  reg n79_o;
  reg n82_o;
  reg [1:0] n85_o;
  reg n88_o;
  reg n92_o;
  reg [1:0] n95_q;
  reg [19:0] n96_q;
  reg n97_q;
  reg n98_q;
  assign db_level = n79_o;
  assign db_tick = n82_o;
  /* debounce.vhd:19:16  */
  assign state_reg = n95_q; // (signal)
  /* debounce.vhd:19:27  */
  assign state_next = n85_o; // (signal)
  /* debounce.vhd:20:16  */
  assign q_reg = n96_q; // (signal)
  /* debounce.vhd:20:23  */
  assign q_next = n23_o; // (signal)
  /* debounce.vhd:21:16  */
  assign q_load = n88_o; // (signal)
  /* debounce.vhd:21:24  */
  assign q_dec = n92_o; // (signal)
  /* debounce.vhd:21:31  */
  assign q_zero = n30_o; // (signal)
  /* debounce.vhd:22:16  */
  assign sw_reg1 = n97_q; // (signal)
  /* debounce.vhd:22:25  */
  assign sw_reg2 = n98_q; // (signal)
  /* debounce.vhd:49:35  */
  assign n23_o = q_load ? 20'b11111111111111111111 : n26_o;
  /* debounce.vhd:50:23  */
  assign n25_o = q_reg - 20'b00000000000000000001;
  /* debounce.vhd:49:51  */
  assign n26_o = q_dec ? n25_o : q_reg;
  /* debounce.vhd:52:34  */
  assign n29_o = q_next == 20'b00000000000000000000;
  /* debounce.vhd:52:23  */
  assign n30_o = n29_o ? 1'b1 : 1'b0;
  /* debounce.vhd:65:33  */
  assign n35_o = sw_reg2 ? 2'b11 : state_reg;
  /* debounce.vhd:65:33  */
  assign n38_o = sw_reg2 ? 1'b1 : 1'b0;
  /* debounce.vhd:63:25  */
  assign n40_o = state_reg == 2'b00;
  /* debounce.vhd:73:41  */
  assign n43_o = q_zero ? 1'b1 : 1'b0;
  /* debounce.vhd:73:41  */
  assign n45_o = q_zero ? 2'b10 : state_reg;
  /* debounce.vhd:71:33  */
  assign n47_o = sw_reg2 ? n43_o : 1'b0;
  /* debounce.vhd:71:33  */
  assign n49_o = sw_reg2 ? n45_o : 2'b00;
  /* debounce.vhd:71:33  */
  assign n52_o = sw_reg2 ? 1'b1 : 1'b0;
  /* debounce.vhd:69:25  */
  assign n54_o = state_reg == 2'b11;
  /* debounce.vhd:82:43  */
  assign n55_o = ~sw_reg2;
  /* debounce.vhd:82:33  */
  assign n57_o = n55_o ? 2'b01 : state_reg;
  /* debounce.vhd:82:33  */
  assign n60_o = n55_o ? 1'b1 : 1'b0;
  /* debounce.vhd:80:25  */
  assign n62_o = state_reg == 2'b10;
  /* debounce.vhd:88:43  */
  assign n63_o = ~sw_reg2;
  /* debounce.vhd:90:41  */
  assign n65_o = q_zero ? 2'b00 : state_reg;
  /* debounce.vhd:88:33  */
  assign n67_o = n63_o ? n65_o : 2'b10;
  /* debounce.vhd:88:33  */
  assign n70_o = n63_o ? 1'b1 : 1'b0;
  /* debounce.vhd:86:25  */
  assign n72_o = state_reg == 2'b01;
  assign n73_o = {n72_o, n62_o, n54_o, n40_o};
  /* debounce.vhd:62:17  */
  always @*
    case (n73_o)
      4'b1000: n79_o = 1'b1;
      4'b0100: n79_o = 1'b1;
      4'b0010: n79_o = 1'b0;
      4'b0001: n79_o = 1'b0;
      default: n79_o = 1'bX;
    endcase
  /* debounce.vhd:62:17  */
  always @*
    case (n73_o)
      4'b1000: n82_o = 1'b0;
      4'b0100: n82_o = 1'b0;
      4'b0010: n82_o = n47_o;
      4'b0001: n82_o = 1'b0;
      default: n82_o = 1'bX;
    endcase
  /* debounce.vhd:62:17  */
  always @*
    case (n73_o)
      4'b1000: n85_o = n67_o;
      4'b0100: n85_o = n57_o;
      4'b0010: n85_o = n49_o;
      4'b0001: n85_o = n35_o;
      default: n85_o = 2'bX;
    endcase
  /* debounce.vhd:62:17  */
  always @*
    case (n73_o)
      4'b1000: n88_o = 1'b0;
      4'b0100: n88_o = n60_o;
      4'b0010: n88_o = 1'b0;
      4'b0001: n88_o = n38_o;
      default: n88_o = 1'bX;
    endcase
  /* debounce.vhd:62:17  */
  always @*
    case (n73_o)
      4'b1000: n92_o = n70_o;
      4'b0100: n92_o = 1'b0;
      4'b0010: n92_o = n52_o;
      4'b0001: n92_o = 1'b0;
      default: n92_o = 1'bX;
    endcase
  /* debounce.vhd:42:17  */
  always @(posedge clk or posedge reset)
    if (reset)
      n95_q <= 2'b00;
    else
      n95_q <= state_next;
  /* debounce.vhd:42:17  */
  always @(posedge clk or posedge reset)
    if (reset)
      n96_q <= 20'b00000000000000000000;
    else
      n96_q <= q_next;
  /* debounce.vhd:30:17  */
  always @(posedge clk or posedge reset)
    if (reset)
      n97_q <= 1'b0;
    else
      n97_q <= sw;
  /* debounce.vhd:30:17  */
  always @(posedge clk or posedge reset)
    if (reset)
      n98_q <= 1'b0;
    else
      n98_q <= sw_reg1;
endmodule


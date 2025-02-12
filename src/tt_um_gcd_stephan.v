module tt_um_gcd_stephan
  (input  clk,
   input  reset,
   input  req,
   input  [15:0] AB,
   output ack,
   output [15:0] C);
  wire [15:0] reg_a;
  wire [15:0] next_reg_a;
  wire [15:0] next_reg_b;
  wire [15:0] reg_b;
  wire [15:0] c_int;
  wire [15:0] y;
  wire [3:0] state;
  wire [3:0] next_state;
  wire [3:0] n5_o;
  wire n7_o;
  wire n9_o;
  wire n10_o;
  wire [3:0] n13_o;
  wire n15_o;
  wire [3:0] n18_o;
  wire n20_o;
  wire n22_o;
  wire n23_o;
  wire [3:0] n26_o;
  wire n28_o;
  wire n29_o;
  wire [3:0] n32_o;
  wire n34_o;
  wire [15:0] n35_o;
  wire n37_o;
  wire [15:0] n38_o;
  wire n40_o;
  wire n42_o;
  wire n45_o;
  wire [10:0] n46_o;
  reg n51_o;
  reg [15:0] n54_o;
  reg [15:0] n57_o;
  reg [15:0] n60_o;
  reg [3:0] n69_o;
  wire [15:0] n75_o;
  wire [15:0] n77_o;
  wire [15:0] n79_o;
  wire [3:0] n81_o;
  reg [15:0] n87_q;
  reg [15:0] n88_q;
  reg [15:0] n89_q;
  reg [3:0] n90_q;
  assign ack = n51_o;
  assign C = c_int;
  /* gcd.vhd:43:10  */
  assign reg_a = n87_q; // (signal)
  /* gcd.vhd:43:17  */
  assign next_reg_a = n54_o; // (signal)
  /* gcd.vhd:43:29  */
  assign next_reg_b = n57_o; // (signal)
  /* gcd.vhd:43:41  */
  assign reg_b = n88_q; // (signal)
  /* gcd.vhd:43:48  */
  assign c_int = n89_q; // (signal)
  /* gcd.vhd:43:55  */
  assign y = n60_o; // (signal)
  /* gcd.vhd:44:10  */
  assign state = n90_q; // (signal)
  /* gcd.vhd:44:17  */
  assign next_state = n69_o; // (signal)
  /* gcd.vhd:64:9  */
  assign n5_o = req ? 4'b0001 : 4'b0000;
  /* gcd.vhd:63:7  */
  assign n7_o = state == 4'b0000;
  /* gcd.vhd:68:7  */
  assign n9_o = state == 4'b0001;
  /* gcd.vhd:74:17  */
  assign n10_o = ~req;
  /* gcd.vhd:74:9  */
  assign n13_o = n10_o ? 4'b0011 : 4'b0000;
  /* gcd.vhd:72:7  */
  assign n15_o = state == 4'b0010;
  /* gcd.vhd:80:9  */
  assign n18_o = req ? 4'b0100 : 4'b0000;
  /* gcd.vhd:78:7  */
  assign n20_o = state == 4'b0011;
  /* gcd.vhd:84:7  */
  assign n22_o = state == 4'b0100;
  /* gcd.vhd:89:19  */
  assign n23_o = reg_a != reg_b;
  /* gcd.vhd:89:9  */
  assign n26_o = n23_o ? 4'b0110 : 4'b1001;
  /* gcd.vhd:88:7  */
  assign n28_o = state == 4'b0101;
  /* gcd.vhd:96:19  */
  assign n29_o = $unsigned(reg_a) > $unsigned(reg_b);
  /* gcd.vhd:96:9  */
  assign n32_o = n29_o ? 4'b0111 : 4'b1000;
  /* gcd.vhd:95:7  */
  assign n34_o = state == 4'b0110;
  /* gcd.vhd:103:29  */
  assign n35_o = reg_a - reg_b;
  /* gcd.vhd:102:7  */
  assign n37_o = state == 4'b0111;
  /* gcd.vhd:107:29  */
  assign n38_o = reg_b - reg_a;
  /* gcd.vhd:106:7  */
  assign n40_o = state == 4'b1000;
  /* gcd.vhd:110:7  */
  assign n42_o = state == 4'b1001;
  /* gcd.vhd:115:7  */
  assign n45_o = state == 4'b1010;
  assign n46_o = {n45_o, n42_o, n40_o, n37_o, n34_o, n28_o, n22_o, n20_o, n15_o, n9_o, n7_o};
  /* gcd.vhd:62:5  */
  always @*
    case (n46_o)
      11'b10000000000: n51_o = 1'b0;
      11'b01000000000: n51_o = 1'b1;
      11'b00100000000: n51_o = 1'b0;
      11'b00010000000: n51_o = 1'b0;
      11'b00001000000: n51_o = 1'b0;
      11'b00000100000: n51_o = 1'b0;
      11'b00000010000: n51_o = 1'b0;
      11'b00000001000: n51_o = 1'b0;
      11'b00000000100: n51_o = 1'b1;
      11'b00000000010: n51_o = 1'b0;
      11'b00000000001: n51_o = 1'b0;
      default: n51_o = 1'b0;
    endcase
  /* gcd.vhd:62:5  */
  always @*
    case (n46_o)
      11'b10000000000: n54_o = 16'b0000000000000000;
      11'b01000000000: n54_o = 16'b0000000000000000;
      11'b00100000000: n54_o = 16'b0000000000000000;
      11'b00010000000: n54_o = n35_o;
      11'b00001000000: n54_o = 16'b0000000000000000;
      11'b00000100000: n54_o = 16'b0000000000000000;
      11'b00000010000: n54_o = 16'b0000000000000000;
      11'b00000001000: n54_o = 16'b0000000000000000;
      11'b00000000100: n54_o = 16'b0000000000000000;
      11'b00000000010: n54_o = AB;
      11'b00000000001: n54_o = 16'b0000000000000000;
      default: n54_o = 16'b0000000000000000;
    endcase
  /* gcd.vhd:62:5  */
  always @*
    case (n46_o)
      11'b10000000000: n57_o = 16'b0000000000000000;
      11'b01000000000: n57_o = 16'b0000000000000000;
      11'b00100000000: n57_o = n38_o;
      11'b00010000000: n57_o = 16'b0000000000000000;
      11'b00001000000: n57_o = 16'b0000000000000000;
      11'b00000100000: n57_o = 16'b0000000000000000;
      11'b00000010000: n57_o = AB;
      11'b00000001000: n57_o = 16'b0000000000000000;
      11'b00000000100: n57_o = 16'b0000000000000000;
      11'b00000000010: n57_o = 16'b0000000000000000;
      11'b00000000001: n57_o = 16'b0000000000000000;
      default: n57_o = 16'b0000000000000000;
    endcase
  /* gcd.vhd:62:5  */
  always @*
    case (n46_o)
      11'b10000000000: n60_o = 16'b0000000000000000;
      11'b01000000000: n60_o = reg_a;
      11'b00100000000: n60_o = 16'b0000000000000000;
      11'b00010000000: n60_o = 16'b0000000000000000;
      11'b00001000000: n60_o = 16'b0000000000000000;
      11'b00000100000: n60_o = 16'b0000000000000000;
      11'b00000010000: n60_o = 16'b0000000000000000;
      11'b00000001000: n60_o = 16'b0000000000000000;
      11'b00000000100: n60_o = 16'b0000000000000000;
      11'b00000000010: n60_o = 16'b0000000000000000;
      11'b00000000001: n60_o = 16'b0000000000000000;
      default: n60_o = 16'b0000000000000000;
    endcase
  /* gcd.vhd:62:5  */
  always @*
    case (n46_o)
      11'b10000000000: n69_o = 4'b0000;
      11'b01000000000: n69_o = 4'b1010;
      11'b00100000000: n69_o = 4'b0101;
      11'b00010000000: n69_o = 4'b0101;
      11'b00001000000: n69_o = n32_o;
      11'b00000100000: n69_o = n26_o;
      11'b00000010000: n69_o = 4'b0101;
      11'b00000001000: n69_o = n18_o;
      11'b00000000100: n69_o = n13_o;
      11'b00000000010: n69_o = 4'b0010;
      11'b00000000001: n69_o = n5_o;
      default: n69_o = 4'b0000;
    endcase
  /* gcd.vhd:133:7  */
  assign n75_o = reset ? 16'b0000000000000000 : next_reg_a;
  /* gcd.vhd:133:7  */
  assign n77_o = reset ? 16'b0000000000000000 : next_reg_b;
  /* gcd.vhd:133:7  */
  assign n79_o = reset ? 16'b0000000000000000 : y;
  /* gcd.vhd:133:7  */
  assign n81_o = reset ? 4'b0000 : next_state;
  /* gcd.vhd:132:5  */
  always @(posedge clk)
    n87_q <= n75_o;
  /* gcd.vhd:132:5  */
  always @(posedge clk)
    n88_q <= n77_o;
  /* gcd.vhd:132:5  */
  always @(posedge clk)
    n89_q <= n79_o;
  /* gcd.vhd:132:5  */
  always @(posedge clk)
    n90_q <= n81_o;
endmodule


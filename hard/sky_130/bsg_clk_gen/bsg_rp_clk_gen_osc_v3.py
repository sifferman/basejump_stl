from __future__ import print_function
import sys

num_rows_p = int(sys.argv[1])
num_cols_p = int(sys.argv[2])
num_dly_p  = int(sys.argv[3])

num_taps_p = num_rows_p*num_cols_p

print("""
// ## AUTOGENERATED; DO NOT MODIFY
// ## num_rows_p = {num_rows_p}
// ## num_cols_p = {num_cols_p}
// ## num_dly_p = {num_dly_p}
""".format(num_rows_p=num_rows_p, num_cols_p=num_cols_p, num_dly_p=num_dly_p))

print("""
module bsg_rp_clk_gen_osc_v3
  (input async_reset_i
   , input trigger_i
   , input [{ctl_width_p_m1}:0] ctl_one_hot_i
   , output clk_o
   );
  wire lobit, hibit;
  sky130_fd_sc_hd__conb_1 T0 (.HI(hibit), .LO(lobit));
  wire async_reset_neg;
  sky130_fd_sc_hd__inv_1 I0 (.Y(async_reset_neg), .A(async_reset_i));
  wire fb_inv, fb, fb_rst;
  sky130_fd_sc_hd__clkinv_1 I1 (.Y(fb_inv), .A(fb));

  sky130_fd_sc_hd__nand2_1 N0 (.Y(fb_rst), .A(fb_inv), .B(async_reset_neg));
  wire [{num_dly_p}:0] n;
  assign n[0] = fb_rst;
""".format(ctl_width_p_m1=num_cols_p*num_rows_p-1, num_dly_p=num_dly_p))
for i in range(0, num_dly_p):
    print("""
    sky130_fd_sc_hd__clkbuf_1 B{i} (.X(n[{ip1}]), .A(n[{i}]));
""".format(i=i, ip1=i+1))
print("""
  // Synthesize as blackbox
  wire fb_dly;
  bsg_nonsynth_delay_line fb_dly_BSG_DONT_TOUCH (.o(fb_dly), .i(n[{num_dly_p}]));
  sky130_fd_sc_hd__clkinv_1 I2 (.Y(clk_o), .A(fb_dly));
  wire fb_gate;
  sky130_fd_sc_hd__clkinv_1 I3 (.Y(fb_gate), .A(fb_dly));
  wire gate_en_sync_1_r, gate_en_sync_2_r;
  sky130_fd_sc_hd__dfxtp_1 S1 (.D(trigger_i), .CLK(fb_gate), .Q(gate_en_sync_1_r));
  sky130_fd_sc_hd__dfxtp_1 S2 (.D(gate_en_sync_1_r), .CLK(fb_gate), .Q(gate_en_sync_2_r));
  wire fb_gated;
  // Size to 1/4 of number of taps
  sky130_fd_sc_hd__dlclkp_1 CG0 (.GCLK(fb_gated), .CLK(fb_gate), .GATE(gate_en_sync_2_r));
  wire [{num_cols_p}:0] fb_col;
  assign fb_col[0] = 1'b0;
""".format(num_rows_p=num_rows_p, num_cols_p=num_cols_p, num_dly_p=num_dly_p))
for i in range(0, num_cols_p):
    print("""
      bsg_rp_clk_gen_osc_v3_col col_{i}_BSG_DONT_TOUCH
       (.async_reset_i(async_reset_i)
        ,.clkgate_i(fb_gated)
        ,.clkdly_i(fb_dly)
        ,.clkfb_i(fb_col[{i}])
        ,.ctl_one_hot_i(ctl_one_hot_i[{ip1_num_rows_p}:{i_num_rows_p}])
        ,.clk_o(fb_col[{ip1}])
        );
""".format(num_rows_p=num_rows_p, num_cols_p=num_cols_p, i=i, ip1=i+1, i_num_rows_p=i*num_rows_p, ip1_num_rows_p=(i+1)*num_rows_p-1))
print("""
  assign fb = fb_col[{num_cols_p}];
endmodule
""".format(num_cols_p=num_cols_p))

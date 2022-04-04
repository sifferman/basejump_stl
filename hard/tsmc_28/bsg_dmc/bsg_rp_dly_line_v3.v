
// ## AUTOGENERATED; DO NOT MODIFY
// ## num_rows_p = 8
// ## num_cols_p = 8
// ## num_dly_p = 8


  module bsg_rp_dly_line_unit_v3
      (input async_reset_i
      , input trigger_i
      , input [63:0] ctl_one_hot_i
      , input  clk_i
      , output clk_o
      );
      wire lobit;
      TIELBWP7T30P140ULVT T0 (.ZN(lobit));
      wire hibit;
      TIEHBWP7T30P140ULVT T1 (.Z(hibit));
  

  wire fb_inv;
  CKND1BWP7T30P140ULVT I0 (.ZN(fb_inv), .I(clk_i));
  wire gate_en_sync_1_r, gate_en_sync_2_r;
  DFQD1BWP7T30P140ULVT S1 (.D(trigger_i), .CP(fb_inv), .Q(gate_en_sync_1_r));
  DFQD1BWP7T30P140ULVT S2 (.D(gate_en_sync_1_r), .CP(fb_inv), .Q(gate_en_sync_2_r));
  wire fb_gated;
  CKLNQD20BWP7T30P140ULVT CG0 (.Q(fb_gated), .CP(fb_inv), .E(gate_en_sync_2_r), .TE(lobit));
  wire [8:0] fb_col;
  assign fb_col[0] = 1'b0;


      bsg_rp_clk_gen_osc_v3_col col_0_BSG_DONT_TOUCH
       (.async_reset_i(async_reset_i)
        ,.clkgate_i(fb_gated)
        ,.clkdly_i(fb_inv)
        ,.clkfb_i(fb_col[0])
        ,.ctl_one_hot_i(ctl_one_hot_i[7:0])
        ,.clk_o(fb_col[1])
        );


      bsg_rp_clk_gen_osc_v3_col col_1_BSG_DONT_TOUCH
       (.async_reset_i(async_reset_i)
        ,.clkgate_i(fb_gated)
        ,.clkdly_i(fb_inv)
        ,.clkfb_i(fb_col[1])
        ,.ctl_one_hot_i(ctl_one_hot_i[15:8])
        ,.clk_o(fb_col[2])
        );


      bsg_rp_clk_gen_osc_v3_col col_2_BSG_DONT_TOUCH
       (.async_reset_i(async_reset_i)
        ,.clkgate_i(fb_gated)
        ,.clkdly_i(fb_inv)
        ,.clkfb_i(fb_col[2])
        ,.ctl_one_hot_i(ctl_one_hot_i[23:16])
        ,.clk_o(fb_col[3])
        );


      bsg_rp_clk_gen_osc_v3_col col_3_BSG_DONT_TOUCH
       (.async_reset_i(async_reset_i)
        ,.clkgate_i(fb_gated)
        ,.clkdly_i(fb_inv)
        ,.clkfb_i(fb_col[3])
        ,.ctl_one_hot_i(ctl_one_hot_i[31:24])
        ,.clk_o(fb_col[4])
        );


      bsg_rp_clk_gen_osc_v3_col col_4_BSG_DONT_TOUCH
       (.async_reset_i(async_reset_i)
        ,.clkgate_i(fb_gated)
        ,.clkdly_i(fb_inv)
        ,.clkfb_i(fb_col[4])
        ,.ctl_one_hot_i(ctl_one_hot_i[39:32])
        ,.clk_o(fb_col[5])
        );


      bsg_rp_clk_gen_osc_v3_col col_5_BSG_DONT_TOUCH
       (.async_reset_i(async_reset_i)
        ,.clkgate_i(fb_gated)
        ,.clkdly_i(fb_inv)
        ,.clkfb_i(fb_col[5])
        ,.ctl_one_hot_i(ctl_one_hot_i[47:40])
        ,.clk_o(fb_col[6])
        );


      bsg_rp_clk_gen_osc_v3_col col_6_BSG_DONT_TOUCH
       (.async_reset_i(async_reset_i)
        ,.clkgate_i(fb_gated)
        ,.clkdly_i(fb_inv)
        ,.clkfb_i(fb_col[6])
        ,.ctl_one_hot_i(ctl_one_hot_i[55:48])
        ,.clk_o(fb_col[7])
        );


      bsg_rp_clk_gen_osc_v3_col col_7_BSG_DONT_TOUCH
       (.async_reset_i(async_reset_i)
        ,.clkgate_i(fb_gated)
        ,.clkdly_i(fb_inv)
        ,.clkfb_i(fb_col[7])
        ,.ctl_one_hot_i(ctl_one_hot_i[63:56])
        ,.clk_o(fb_col[8])
        );


  assign clk_o = fb_col[8];
endmodule


  module bsg_rp_dly_line_v3
   (input async_reset_i
    , input clk_i
    , output clk_o
    );
  wire async_reset_neg;
  INVD1BWP7T30P140ULVT I0 (.ZN(async_reset_neg), .I(async_reset_i));
  // State machine
  // Trigger off
  wire trigger_off, trigger_on;
  DFSNQD1BWP7T30P140ULVT D0 (.Q(trigger_off), .CP(clk_i), .D(trigger_on), .SDN(async_reset_neg));
  // Change counter
  wire counter_en;
  DFCNQD1BWP7T30P140ULVT D1 (.Q(counter_en), .CP(clk_i), .D(trigger_off), .CDN(async_reset_neg));
  // Pause
  wire pause;
  DFCNQD1BWP7T30P140ULVT D2 (.Q(pause), .CP(clk_i), .D(counter_en), .CDN(async_reset_neg));
  // Trigger on
  DFCNQD1BWP7T30P140ULVT D3 (.Q(trigger_on), .CP(clk_i), .D(pause), .CDN(async_reset_neg));
  wire [64-1:0] ctl_n, ctl_r;
  wire clk_90;
  bsg_rp_dly_line_unit_v3 d90_BSG_DONT_TOUCH
   (.async_reset_i(async_reset_i)
    ,.trigger_i(trigger_on)
    ,.ctl_one_hot_i(ctl_r[63:0])
    ,.clk_i(clk_i)
    ,.clk_o(clk_90)
    );
  bsg_rp_dly_line_unit_v3 d180_BSG_DONT_TOUCH
   (.async_reset_i(async_reset_i)
    ,.trigger_i(trigger_on)
    ,.ctl_one_hot_i(ctl_r[63:0])
    ,.clk_i(clk_90)
    ,.clk_o(clk_180)
    );
  wire meta;
  DFNCND1BWP7T30P140ULVT meta_r (.Q(meta), .QN(), .CPN(clk_i), .CDN(async_reset_neg), .D(clk_180));
  wire meta_sync, meta_sync_sync, meta_sync_sync_inv;
  DFCND1BWP7T30P140ULVT bsg_SYNC_1_r (.Q(meta_sync), .QN(), .CP(clk_i), .D(meta), .CDN(async_reset_neg));
  DFCND1BWP7T30P140ULVT bsg_SYNC_2_r (.Q(meta_sync_sync), .QN(meta_sync_sync_inv), .CP(clk_i), .D(meta_sync), .CDN(async_reset_neg));
  wire shift_left = meta_sync_sync;
  wire shift_right = meta_sync_sync_inv;
  wire [64-1:0] set_right, set_left, set;


    AN2D1BWP7T30P140ULVT A01 (.A1(shift_left), .A2(ctl_r[0]), .Z(set_left[0]));
    TIELBWP7T30P140ULVT T1 (.ZN(set_right[0]));
    OR2D1BWP7T30P140ULVT O01 (.A1(set_left[0]), .A2(set_right[0]), .Z(set[0]));
    MUX2D1BWP7T30P140ULVT M0 (.Z(ctl_n[0]), .S(counter_en), .I0(ctl_r[0]), .I1(set[0]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_0 (.Q(ctl_r[0]), .CP(clk_i), .D(ctl_n[0]), .CDN(async_reset_neg));


    AN2D1BWP7T30P140ULVT A11 (.A1(shift_right), .A2(ctl_r[0]), .Z(set_right[1]));
    AN2D1BWP7T30P140ULVT A12 (.A1(shift_left), .A2(ctl_r[2]), .Z(set_left[1]));
    OR2D1BWP7T30P140ULVT O11 (.A1(set_left[1]), .A2(set_right[1]), .Z(set[1]));
    MUX2D1BWP7T30P140ULVT M1 (.Z(ctl_n[1]), .S(counter_en), .I0(ctl_r[1]), .I1(set[1]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_1 (.Q(ctl_r[1]), .CP(clk_i), .D(ctl_n[1]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A21 (.A1(shift_right), .A2(ctl_r[1]), .Z(set_right[2]));
    AN2D1BWP7T30P140ULVT A22 (.A1(shift_left), .A2(ctl_r[3]), .Z(set_left[2]));
    OR2D1BWP7T30P140ULVT O21 (.A1(set_left[2]), .A2(set_right[2]), .Z(set[2]));
    MUX2D1BWP7T30P140ULVT M2 (.Z(ctl_n[2]), .S(counter_en), .I0(ctl_r[2]), .I1(set[2]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_2 (.Q(ctl_r[2]), .CP(clk_i), .D(ctl_n[2]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A31 (.A1(shift_right), .A2(ctl_r[2]), .Z(set_right[3]));
    AN2D1BWP7T30P140ULVT A32 (.A1(shift_left), .A2(ctl_r[4]), .Z(set_left[3]));
    OR2D1BWP7T30P140ULVT O31 (.A1(set_left[3]), .A2(set_right[3]), .Z(set[3]));
    MUX2D1BWP7T30P140ULVT M3 (.Z(ctl_n[3]), .S(counter_en), .I0(ctl_r[3]), .I1(set[3]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_3 (.Q(ctl_r[3]), .CP(clk_i), .D(ctl_n[3]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A41 (.A1(shift_right), .A2(ctl_r[3]), .Z(set_right[4]));
    AN2D1BWP7T30P140ULVT A42 (.A1(shift_left), .A2(ctl_r[5]), .Z(set_left[4]));
    OR2D1BWP7T30P140ULVT O41 (.A1(set_left[4]), .A2(set_right[4]), .Z(set[4]));
    MUX2D1BWP7T30P140ULVT M4 (.Z(ctl_n[4]), .S(counter_en), .I0(ctl_r[4]), .I1(set[4]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_4 (.Q(ctl_r[4]), .CP(clk_i), .D(ctl_n[4]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A51 (.A1(shift_right), .A2(ctl_r[4]), .Z(set_right[5]));
    AN2D1BWP7T30P140ULVT A52 (.A1(shift_left), .A2(ctl_r[6]), .Z(set_left[5]));
    OR2D1BWP7T30P140ULVT O51 (.A1(set_left[5]), .A2(set_right[5]), .Z(set[5]));
    MUX2D1BWP7T30P140ULVT M5 (.Z(ctl_n[5]), .S(counter_en), .I0(ctl_r[5]), .I1(set[5]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_5 (.Q(ctl_r[5]), .CP(clk_i), .D(ctl_n[5]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A61 (.A1(shift_right), .A2(ctl_r[5]), .Z(set_right[6]));
    AN2D1BWP7T30P140ULVT A62 (.A1(shift_left), .A2(ctl_r[7]), .Z(set_left[6]));
    OR2D1BWP7T30P140ULVT O61 (.A1(set_left[6]), .A2(set_right[6]), .Z(set[6]));
    MUX2D1BWP7T30P140ULVT M6 (.Z(ctl_n[6]), .S(counter_en), .I0(ctl_r[6]), .I1(set[6]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_6 (.Q(ctl_r[6]), .CP(clk_i), .D(ctl_n[6]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A71 (.A1(shift_right), .A2(ctl_r[6]), .Z(set_right[7]));
    AN2D1BWP7T30P140ULVT A72 (.A1(shift_left), .A2(ctl_r[8]), .Z(set_left[7]));
    OR2D1BWP7T30P140ULVT O71 (.A1(set_left[7]), .A2(set_right[7]), .Z(set[7]));
    MUX2D1BWP7T30P140ULVT M7 (.Z(ctl_n[7]), .S(counter_en), .I0(ctl_r[7]), .I1(set[7]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_7 (.Q(ctl_r[7]), .CP(clk_i), .D(ctl_n[7]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A81 (.A1(shift_right), .A2(ctl_r[7]), .Z(set_right[8]));
    AN2D1BWP7T30P140ULVT A82 (.A1(shift_left), .A2(ctl_r[9]), .Z(set_left[8]));
    OR2D1BWP7T30P140ULVT O81 (.A1(set_left[8]), .A2(set_right[8]), .Z(set[8]));
    MUX2D1BWP7T30P140ULVT M8 (.Z(ctl_n[8]), .S(counter_en), .I0(ctl_r[8]), .I1(set[8]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_8 (.Q(ctl_r[8]), .CP(clk_i), .D(ctl_n[8]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A91 (.A1(shift_right), .A2(ctl_r[8]), .Z(set_right[9]));
    AN2D1BWP7T30P140ULVT A92 (.A1(shift_left), .A2(ctl_r[10]), .Z(set_left[9]));
    OR2D1BWP7T30P140ULVT O91 (.A1(set_left[9]), .A2(set_right[9]), .Z(set[9]));
    MUX2D1BWP7T30P140ULVT M9 (.Z(ctl_n[9]), .S(counter_en), .I0(ctl_r[9]), .I1(set[9]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_9 (.Q(ctl_r[9]), .CP(clk_i), .D(ctl_n[9]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A101 (.A1(shift_right), .A2(ctl_r[9]), .Z(set_right[10]));
    AN2D1BWP7T30P140ULVT A102 (.A1(shift_left), .A2(ctl_r[11]), .Z(set_left[10]));
    OR2D1BWP7T30P140ULVT O101 (.A1(set_left[10]), .A2(set_right[10]), .Z(set[10]));
    MUX2D1BWP7T30P140ULVT M10 (.Z(ctl_n[10]), .S(counter_en), .I0(ctl_r[10]), .I1(set[10]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_10 (.Q(ctl_r[10]), .CP(clk_i), .D(ctl_n[10]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A111 (.A1(shift_right), .A2(ctl_r[10]), .Z(set_right[11]));
    AN2D1BWP7T30P140ULVT A112 (.A1(shift_left), .A2(ctl_r[12]), .Z(set_left[11]));
    OR2D1BWP7T30P140ULVT O111 (.A1(set_left[11]), .A2(set_right[11]), .Z(set[11]));
    MUX2D1BWP7T30P140ULVT M11 (.Z(ctl_n[11]), .S(counter_en), .I0(ctl_r[11]), .I1(set[11]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_11 (.Q(ctl_r[11]), .CP(clk_i), .D(ctl_n[11]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A121 (.A1(shift_right), .A2(ctl_r[11]), .Z(set_right[12]));
    AN2D1BWP7T30P140ULVT A122 (.A1(shift_left), .A2(ctl_r[13]), .Z(set_left[12]));
    OR2D1BWP7T30P140ULVT O121 (.A1(set_left[12]), .A2(set_right[12]), .Z(set[12]));
    MUX2D1BWP7T30P140ULVT M12 (.Z(ctl_n[12]), .S(counter_en), .I0(ctl_r[12]), .I1(set[12]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_12 (.Q(ctl_r[12]), .CP(clk_i), .D(ctl_n[12]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A131 (.A1(shift_right), .A2(ctl_r[12]), .Z(set_right[13]));
    AN2D1BWP7T30P140ULVT A132 (.A1(shift_left), .A2(ctl_r[14]), .Z(set_left[13]));
    OR2D1BWP7T30P140ULVT O131 (.A1(set_left[13]), .A2(set_right[13]), .Z(set[13]));
    MUX2D1BWP7T30P140ULVT M13 (.Z(ctl_n[13]), .S(counter_en), .I0(ctl_r[13]), .I1(set[13]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_13 (.Q(ctl_r[13]), .CP(clk_i), .D(ctl_n[13]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A141 (.A1(shift_right), .A2(ctl_r[13]), .Z(set_right[14]));
    AN2D1BWP7T30P140ULVT A142 (.A1(shift_left), .A2(ctl_r[15]), .Z(set_left[14]));
    OR2D1BWP7T30P140ULVT O141 (.A1(set_left[14]), .A2(set_right[14]), .Z(set[14]));
    MUX2D1BWP7T30P140ULVT M14 (.Z(ctl_n[14]), .S(counter_en), .I0(ctl_r[14]), .I1(set[14]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_14 (.Q(ctl_r[14]), .CP(clk_i), .D(ctl_n[14]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A151 (.A1(shift_right), .A2(ctl_r[14]), .Z(set_right[15]));
    AN2D1BWP7T30P140ULVT A152 (.A1(shift_left), .A2(ctl_r[16]), .Z(set_left[15]));
    OR2D1BWP7T30P140ULVT O151 (.A1(set_left[15]), .A2(set_right[15]), .Z(set[15]));
    MUX2D1BWP7T30P140ULVT M15 (.Z(ctl_n[15]), .S(counter_en), .I0(ctl_r[15]), .I1(set[15]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_15 (.Q(ctl_r[15]), .CP(clk_i), .D(ctl_n[15]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A161 (.A1(shift_right), .A2(ctl_r[15]), .Z(set_right[16]));
    AN2D1BWP7T30P140ULVT A162 (.A1(shift_left), .A2(ctl_r[17]), .Z(set_left[16]));
    OR2D1BWP7T30P140ULVT O161 (.A1(set_left[16]), .A2(set_right[16]), .Z(set[16]));
    MUX2D1BWP7T30P140ULVT M16 (.Z(ctl_n[16]), .S(counter_en), .I0(ctl_r[16]), .I1(set[16]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_16 (.Q(ctl_r[16]), .CP(clk_i), .D(ctl_n[16]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A171 (.A1(shift_right), .A2(ctl_r[16]), .Z(set_right[17]));
    AN2D1BWP7T30P140ULVT A172 (.A1(shift_left), .A2(ctl_r[18]), .Z(set_left[17]));
    OR2D1BWP7T30P140ULVT O171 (.A1(set_left[17]), .A2(set_right[17]), .Z(set[17]));
    MUX2D1BWP7T30P140ULVT M17 (.Z(ctl_n[17]), .S(counter_en), .I0(ctl_r[17]), .I1(set[17]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_17 (.Q(ctl_r[17]), .CP(clk_i), .D(ctl_n[17]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A181 (.A1(shift_right), .A2(ctl_r[17]), .Z(set_right[18]));
    AN2D1BWP7T30P140ULVT A182 (.A1(shift_left), .A2(ctl_r[19]), .Z(set_left[18]));
    OR2D1BWP7T30P140ULVT O181 (.A1(set_left[18]), .A2(set_right[18]), .Z(set[18]));
    MUX2D1BWP7T30P140ULVT M18 (.Z(ctl_n[18]), .S(counter_en), .I0(ctl_r[18]), .I1(set[18]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_18 (.Q(ctl_r[18]), .CP(clk_i), .D(ctl_n[18]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A191 (.A1(shift_right), .A2(ctl_r[18]), .Z(set_right[19]));
    AN2D1BWP7T30P140ULVT A192 (.A1(shift_left), .A2(ctl_r[20]), .Z(set_left[19]));
    OR2D1BWP7T30P140ULVT O191 (.A1(set_left[19]), .A2(set_right[19]), .Z(set[19]));
    MUX2D1BWP7T30P140ULVT M19 (.Z(ctl_n[19]), .S(counter_en), .I0(ctl_r[19]), .I1(set[19]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_19 (.Q(ctl_r[19]), .CP(clk_i), .D(ctl_n[19]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A201 (.A1(shift_right), .A2(ctl_r[19]), .Z(set_right[20]));
    AN2D1BWP7T30P140ULVT A202 (.A1(shift_left), .A2(ctl_r[21]), .Z(set_left[20]));
    OR2D1BWP7T30P140ULVT O201 (.A1(set_left[20]), .A2(set_right[20]), .Z(set[20]));
    MUX2D1BWP7T30P140ULVT M20 (.Z(ctl_n[20]), .S(counter_en), .I0(ctl_r[20]), .I1(set[20]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_20 (.Q(ctl_r[20]), .CP(clk_i), .D(ctl_n[20]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A211 (.A1(shift_right), .A2(ctl_r[20]), .Z(set_right[21]));
    AN2D1BWP7T30P140ULVT A212 (.A1(shift_left), .A2(ctl_r[22]), .Z(set_left[21]));
    OR2D1BWP7T30P140ULVT O211 (.A1(set_left[21]), .A2(set_right[21]), .Z(set[21]));
    MUX2D1BWP7T30P140ULVT M21 (.Z(ctl_n[21]), .S(counter_en), .I0(ctl_r[21]), .I1(set[21]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_21 (.Q(ctl_r[21]), .CP(clk_i), .D(ctl_n[21]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A221 (.A1(shift_right), .A2(ctl_r[21]), .Z(set_right[22]));
    AN2D1BWP7T30P140ULVT A222 (.A1(shift_left), .A2(ctl_r[23]), .Z(set_left[22]));
    OR2D1BWP7T30P140ULVT O221 (.A1(set_left[22]), .A2(set_right[22]), .Z(set[22]));
    MUX2D1BWP7T30P140ULVT M22 (.Z(ctl_n[22]), .S(counter_en), .I0(ctl_r[22]), .I1(set[22]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_22 (.Q(ctl_r[22]), .CP(clk_i), .D(ctl_n[22]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A231 (.A1(shift_right), .A2(ctl_r[22]), .Z(set_right[23]));
    AN2D1BWP7T30P140ULVT A232 (.A1(shift_left), .A2(ctl_r[24]), .Z(set_left[23]));
    OR2D1BWP7T30P140ULVT O231 (.A1(set_left[23]), .A2(set_right[23]), .Z(set[23]));
    MUX2D1BWP7T30P140ULVT M23 (.Z(ctl_n[23]), .S(counter_en), .I0(ctl_r[23]), .I1(set[23]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_23 (.Q(ctl_r[23]), .CP(clk_i), .D(ctl_n[23]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A241 (.A1(shift_right), .A2(ctl_r[23]), .Z(set_right[24]));
    AN2D1BWP7T30P140ULVT A242 (.A1(shift_left), .A2(ctl_r[25]), .Z(set_left[24]));
    OR2D1BWP7T30P140ULVT O241 (.A1(set_left[24]), .A2(set_right[24]), .Z(set[24]));
    MUX2D1BWP7T30P140ULVT M24 (.Z(ctl_n[24]), .S(counter_en), .I0(ctl_r[24]), .I1(set[24]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_24 (.Q(ctl_r[24]), .CP(clk_i), .D(ctl_n[24]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A251 (.A1(shift_right), .A2(ctl_r[24]), .Z(set_right[25]));
    AN2D1BWP7T30P140ULVT A252 (.A1(shift_left), .A2(ctl_r[26]), .Z(set_left[25]));
    OR2D1BWP7T30P140ULVT O251 (.A1(set_left[25]), .A2(set_right[25]), .Z(set[25]));
    MUX2D1BWP7T30P140ULVT M25 (.Z(ctl_n[25]), .S(counter_en), .I0(ctl_r[25]), .I1(set[25]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_25 (.Q(ctl_r[25]), .CP(clk_i), .D(ctl_n[25]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A261 (.A1(shift_right), .A2(ctl_r[25]), .Z(set_right[26]));
    AN2D1BWP7T30P140ULVT A262 (.A1(shift_left), .A2(ctl_r[27]), .Z(set_left[26]));
    OR2D1BWP7T30P140ULVT O261 (.A1(set_left[26]), .A2(set_right[26]), .Z(set[26]));
    MUX2D1BWP7T30P140ULVT M26 (.Z(ctl_n[26]), .S(counter_en), .I0(ctl_r[26]), .I1(set[26]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_26 (.Q(ctl_r[26]), .CP(clk_i), .D(ctl_n[26]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A271 (.A1(shift_right), .A2(ctl_r[26]), .Z(set_right[27]));
    AN2D1BWP7T30P140ULVT A272 (.A1(shift_left), .A2(ctl_r[28]), .Z(set_left[27]));
    OR2D1BWP7T30P140ULVT O271 (.A1(set_left[27]), .A2(set_right[27]), .Z(set[27]));
    MUX2D1BWP7T30P140ULVT M27 (.Z(ctl_n[27]), .S(counter_en), .I0(ctl_r[27]), .I1(set[27]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_27 (.Q(ctl_r[27]), .CP(clk_i), .D(ctl_n[27]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A281 (.A1(shift_right), .A2(ctl_r[27]), .Z(set_right[28]));
    AN2D1BWP7T30P140ULVT A282 (.A1(shift_left), .A2(ctl_r[29]), .Z(set_left[28]));
    OR2D1BWP7T30P140ULVT O281 (.A1(set_left[28]), .A2(set_right[28]), .Z(set[28]));
    MUX2D1BWP7T30P140ULVT M28 (.Z(ctl_n[28]), .S(counter_en), .I0(ctl_r[28]), .I1(set[28]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_28 (.Q(ctl_r[28]), .CP(clk_i), .D(ctl_n[28]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A291 (.A1(shift_right), .A2(ctl_r[28]), .Z(set_right[29]));
    AN2D1BWP7T30P140ULVT A292 (.A1(shift_left), .A2(ctl_r[30]), .Z(set_left[29]));
    OR2D1BWP7T30P140ULVT O291 (.A1(set_left[29]), .A2(set_right[29]), .Z(set[29]));
    MUX2D1BWP7T30P140ULVT M29 (.Z(ctl_n[29]), .S(counter_en), .I0(ctl_r[29]), .I1(set[29]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_29 (.Q(ctl_r[29]), .CP(clk_i), .D(ctl_n[29]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A301 (.A1(shift_right), .A2(ctl_r[29]), .Z(set_right[30]));
    AN2D1BWP7T30P140ULVT A302 (.A1(shift_left), .A2(ctl_r[31]), .Z(set_left[30]));
    OR2D1BWP7T30P140ULVT O301 (.A1(set_left[30]), .A2(set_right[30]), .Z(set[30]));
    MUX2D1BWP7T30P140ULVT M30 (.Z(ctl_n[30]), .S(counter_en), .I0(ctl_r[30]), .I1(set[30]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_30 (.Q(ctl_r[30]), .CP(clk_i), .D(ctl_n[30]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A311 (.A1(shift_right), .A2(ctl_r[30]), .Z(set_right[31]));
    AN2D1BWP7T30P140ULVT A312 (.A1(shift_left), .A2(ctl_r[32]), .Z(set_left[31]));
    OR2D1BWP7T30P140ULVT O311 (.A1(set_left[31]), .A2(set_right[31]), .Z(set[31]));
    MUX2D1BWP7T30P140ULVT M31 (.Z(ctl_n[31]), .S(counter_en), .I0(ctl_r[31]), .I1(set[31]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_31 (.Q(ctl_r[31]), .CP(clk_i), .D(ctl_n[31]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A321 (.A1(shift_right), .A2(ctl_r[31]), .Z(set_right[32]));
    AN2D1BWP7T30P140ULVT A322 (.A1(shift_left), .A2(ctl_r[33]), .Z(set_left[32]));
    OR2D1BWP7T30P140ULVT O321 (.A1(set_left[32]), .A2(set_right[32]), .Z(set[32]));
    MUX2D1BWP7T30P140ULVT M32 (.Z(ctl_n[32]), .S(counter_en), .I0(ctl_r[32]), .I1(set[32]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_32 (.Q(ctl_r[32]), .CP(clk_i), .D(ctl_n[32]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A331 (.A1(shift_right), .A2(ctl_r[32]), .Z(set_right[33]));
    AN2D1BWP7T30P140ULVT A332 (.A1(shift_left), .A2(ctl_r[34]), .Z(set_left[33]));
    OR2D1BWP7T30P140ULVT O331 (.A1(set_left[33]), .A2(set_right[33]), .Z(set[33]));
    MUX2D1BWP7T30P140ULVT M33 (.Z(ctl_n[33]), .S(counter_en), .I0(ctl_r[33]), .I1(set[33]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_33 (.Q(ctl_r[33]), .CP(clk_i), .D(ctl_n[33]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A341 (.A1(shift_right), .A2(ctl_r[33]), .Z(set_right[34]));
    AN2D1BWP7T30P140ULVT A342 (.A1(shift_left), .A2(ctl_r[35]), .Z(set_left[34]));
    OR2D1BWP7T30P140ULVT O341 (.A1(set_left[34]), .A2(set_right[34]), .Z(set[34]));
    MUX2D1BWP7T30P140ULVT M34 (.Z(ctl_n[34]), .S(counter_en), .I0(ctl_r[34]), .I1(set[34]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_34 (.Q(ctl_r[34]), .CP(clk_i), .D(ctl_n[34]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A351 (.A1(shift_right), .A2(ctl_r[34]), .Z(set_right[35]));
    AN2D1BWP7T30P140ULVT A352 (.A1(shift_left), .A2(ctl_r[36]), .Z(set_left[35]));
    OR2D1BWP7T30P140ULVT O351 (.A1(set_left[35]), .A2(set_right[35]), .Z(set[35]));
    MUX2D1BWP7T30P140ULVT M35 (.Z(ctl_n[35]), .S(counter_en), .I0(ctl_r[35]), .I1(set[35]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_35 (.Q(ctl_r[35]), .CP(clk_i), .D(ctl_n[35]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A361 (.A1(shift_right), .A2(ctl_r[35]), .Z(set_right[36]));
    AN2D1BWP7T30P140ULVT A362 (.A1(shift_left), .A2(ctl_r[37]), .Z(set_left[36]));
    OR2D1BWP7T30P140ULVT O361 (.A1(set_left[36]), .A2(set_right[36]), .Z(set[36]));
    MUX2D1BWP7T30P140ULVT M36 (.Z(ctl_n[36]), .S(counter_en), .I0(ctl_r[36]), .I1(set[36]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_36 (.Q(ctl_r[36]), .CP(clk_i), .D(ctl_n[36]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A371 (.A1(shift_right), .A2(ctl_r[36]), .Z(set_right[37]));
    AN2D1BWP7T30P140ULVT A372 (.A1(shift_left), .A2(ctl_r[38]), .Z(set_left[37]));
    OR2D1BWP7T30P140ULVT O371 (.A1(set_left[37]), .A2(set_right[37]), .Z(set[37]));
    MUX2D1BWP7T30P140ULVT M37 (.Z(ctl_n[37]), .S(counter_en), .I0(ctl_r[37]), .I1(set[37]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_37 (.Q(ctl_r[37]), .CP(clk_i), .D(ctl_n[37]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A381 (.A1(shift_right), .A2(ctl_r[37]), .Z(set_right[38]));
    AN2D1BWP7T30P140ULVT A382 (.A1(shift_left), .A2(ctl_r[39]), .Z(set_left[38]));
    OR2D1BWP7T30P140ULVT O381 (.A1(set_left[38]), .A2(set_right[38]), .Z(set[38]));
    MUX2D1BWP7T30P140ULVT M38 (.Z(ctl_n[38]), .S(counter_en), .I0(ctl_r[38]), .I1(set[38]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_38 (.Q(ctl_r[38]), .CP(clk_i), .D(ctl_n[38]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A391 (.A1(shift_right), .A2(ctl_r[38]), .Z(set_right[39]));
    AN2D1BWP7T30P140ULVT A392 (.A1(shift_left), .A2(ctl_r[40]), .Z(set_left[39]));
    OR2D1BWP7T30P140ULVT O391 (.A1(set_left[39]), .A2(set_right[39]), .Z(set[39]));
    MUX2D1BWP7T30P140ULVT M39 (.Z(ctl_n[39]), .S(counter_en), .I0(ctl_r[39]), .I1(set[39]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_39 (.Q(ctl_r[39]), .CP(clk_i), .D(ctl_n[39]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A401 (.A1(shift_right), .A2(ctl_r[39]), .Z(set_right[40]));
    AN2D1BWP7T30P140ULVT A402 (.A1(shift_left), .A2(ctl_r[41]), .Z(set_left[40]));
    OR2D1BWP7T30P140ULVT O401 (.A1(set_left[40]), .A2(set_right[40]), .Z(set[40]));
    MUX2D1BWP7T30P140ULVT M40 (.Z(ctl_n[40]), .S(counter_en), .I0(ctl_r[40]), .I1(set[40]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_40 (.Q(ctl_r[40]), .CP(clk_i), .D(ctl_n[40]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A411 (.A1(shift_right), .A2(ctl_r[40]), .Z(set_right[41]));
    AN2D1BWP7T30P140ULVT A412 (.A1(shift_left), .A2(ctl_r[42]), .Z(set_left[41]));
    OR2D1BWP7T30P140ULVT O411 (.A1(set_left[41]), .A2(set_right[41]), .Z(set[41]));
    MUX2D1BWP7T30P140ULVT M41 (.Z(ctl_n[41]), .S(counter_en), .I0(ctl_r[41]), .I1(set[41]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_41 (.Q(ctl_r[41]), .CP(clk_i), .D(ctl_n[41]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A421 (.A1(shift_right), .A2(ctl_r[41]), .Z(set_right[42]));
    AN2D1BWP7T30P140ULVT A422 (.A1(shift_left), .A2(ctl_r[43]), .Z(set_left[42]));
    OR2D1BWP7T30P140ULVT O421 (.A1(set_left[42]), .A2(set_right[42]), .Z(set[42]));
    MUX2D1BWP7T30P140ULVT M42 (.Z(ctl_n[42]), .S(counter_en), .I0(ctl_r[42]), .I1(set[42]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_42 (.Q(ctl_r[42]), .CP(clk_i), .D(ctl_n[42]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A431 (.A1(shift_right), .A2(ctl_r[42]), .Z(set_right[43]));
    AN2D1BWP7T30P140ULVT A432 (.A1(shift_left), .A2(ctl_r[44]), .Z(set_left[43]));
    OR2D1BWP7T30P140ULVT O431 (.A1(set_left[43]), .A2(set_right[43]), .Z(set[43]));
    MUX2D1BWP7T30P140ULVT M43 (.Z(ctl_n[43]), .S(counter_en), .I0(ctl_r[43]), .I1(set[43]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_43 (.Q(ctl_r[43]), .CP(clk_i), .D(ctl_n[43]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A441 (.A1(shift_right), .A2(ctl_r[43]), .Z(set_right[44]));
    AN2D1BWP7T30P140ULVT A442 (.A1(shift_left), .A2(ctl_r[45]), .Z(set_left[44]));
    OR2D1BWP7T30P140ULVT O441 (.A1(set_left[44]), .A2(set_right[44]), .Z(set[44]));
    MUX2D1BWP7T30P140ULVT M44 (.Z(ctl_n[44]), .S(counter_en), .I0(ctl_r[44]), .I1(set[44]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_44 (.Q(ctl_r[44]), .CP(clk_i), .D(ctl_n[44]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A451 (.A1(shift_right), .A2(ctl_r[44]), .Z(set_right[45]));
    AN2D1BWP7T30P140ULVT A452 (.A1(shift_left), .A2(ctl_r[46]), .Z(set_left[45]));
    OR2D1BWP7T30P140ULVT O451 (.A1(set_left[45]), .A2(set_right[45]), .Z(set[45]));
    MUX2D1BWP7T30P140ULVT M45 (.Z(ctl_n[45]), .S(counter_en), .I0(ctl_r[45]), .I1(set[45]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_45 (.Q(ctl_r[45]), .CP(clk_i), .D(ctl_n[45]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A461 (.A1(shift_right), .A2(ctl_r[45]), .Z(set_right[46]));
    AN2D1BWP7T30P140ULVT A462 (.A1(shift_left), .A2(ctl_r[47]), .Z(set_left[46]));
    OR2D1BWP7T30P140ULVT O461 (.A1(set_left[46]), .A2(set_right[46]), .Z(set[46]));
    MUX2D1BWP7T30P140ULVT M46 (.Z(ctl_n[46]), .S(counter_en), .I0(ctl_r[46]), .I1(set[46]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_46 (.Q(ctl_r[46]), .CP(clk_i), .D(ctl_n[46]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A471 (.A1(shift_right), .A2(ctl_r[46]), .Z(set_right[47]));
    AN2D1BWP7T30P140ULVT A472 (.A1(shift_left), .A2(ctl_r[48]), .Z(set_left[47]));
    OR2D1BWP7T30P140ULVT O471 (.A1(set_left[47]), .A2(set_right[47]), .Z(set[47]));
    MUX2D1BWP7T30P140ULVT M47 (.Z(ctl_n[47]), .S(counter_en), .I0(ctl_r[47]), .I1(set[47]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_47 (.Q(ctl_r[47]), .CP(clk_i), .D(ctl_n[47]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A481 (.A1(shift_right), .A2(ctl_r[47]), .Z(set_right[48]));
    AN2D1BWP7T30P140ULVT A482 (.A1(shift_left), .A2(ctl_r[49]), .Z(set_left[48]));
    OR2D1BWP7T30P140ULVT O481 (.A1(set_left[48]), .A2(set_right[48]), .Z(set[48]));
    MUX2D1BWP7T30P140ULVT M48 (.Z(ctl_n[48]), .S(counter_en), .I0(ctl_r[48]), .I1(set[48]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_48 (.Q(ctl_r[48]), .CP(clk_i), .D(ctl_n[48]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A491 (.A1(shift_right), .A2(ctl_r[48]), .Z(set_right[49]));
    AN2D1BWP7T30P140ULVT A492 (.A1(shift_left), .A2(ctl_r[50]), .Z(set_left[49]));
    OR2D1BWP7T30P140ULVT O491 (.A1(set_left[49]), .A2(set_right[49]), .Z(set[49]));
    MUX2D1BWP7T30P140ULVT M49 (.Z(ctl_n[49]), .S(counter_en), .I0(ctl_r[49]), .I1(set[49]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_49 (.Q(ctl_r[49]), .CP(clk_i), .D(ctl_n[49]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A501 (.A1(shift_right), .A2(ctl_r[49]), .Z(set_right[50]));
    AN2D1BWP7T30P140ULVT A502 (.A1(shift_left), .A2(ctl_r[51]), .Z(set_left[50]));
    OR2D1BWP7T30P140ULVT O501 (.A1(set_left[50]), .A2(set_right[50]), .Z(set[50]));
    MUX2D1BWP7T30P140ULVT M50 (.Z(ctl_n[50]), .S(counter_en), .I0(ctl_r[50]), .I1(set[50]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_50 (.Q(ctl_r[50]), .CP(clk_i), .D(ctl_n[50]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A511 (.A1(shift_right), .A2(ctl_r[50]), .Z(set_right[51]));
    AN2D1BWP7T30P140ULVT A512 (.A1(shift_left), .A2(ctl_r[52]), .Z(set_left[51]));
    OR2D1BWP7T30P140ULVT O511 (.A1(set_left[51]), .A2(set_right[51]), .Z(set[51]));
    MUX2D1BWP7T30P140ULVT M51 (.Z(ctl_n[51]), .S(counter_en), .I0(ctl_r[51]), .I1(set[51]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_51 (.Q(ctl_r[51]), .CP(clk_i), .D(ctl_n[51]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A521 (.A1(shift_right), .A2(ctl_r[51]), .Z(set_right[52]));
    AN2D1BWP7T30P140ULVT A522 (.A1(shift_left), .A2(ctl_r[53]), .Z(set_left[52]));
    OR2D1BWP7T30P140ULVT O521 (.A1(set_left[52]), .A2(set_right[52]), .Z(set[52]));
    MUX2D1BWP7T30P140ULVT M52 (.Z(ctl_n[52]), .S(counter_en), .I0(ctl_r[52]), .I1(set[52]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_52 (.Q(ctl_r[52]), .CP(clk_i), .D(ctl_n[52]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A531 (.A1(shift_right), .A2(ctl_r[52]), .Z(set_right[53]));
    AN2D1BWP7T30P140ULVT A532 (.A1(shift_left), .A2(ctl_r[54]), .Z(set_left[53]));
    OR2D1BWP7T30P140ULVT O531 (.A1(set_left[53]), .A2(set_right[53]), .Z(set[53]));
    MUX2D1BWP7T30P140ULVT M53 (.Z(ctl_n[53]), .S(counter_en), .I0(ctl_r[53]), .I1(set[53]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_53 (.Q(ctl_r[53]), .CP(clk_i), .D(ctl_n[53]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A541 (.A1(shift_right), .A2(ctl_r[53]), .Z(set_right[54]));
    AN2D1BWP7T30P140ULVT A542 (.A1(shift_left), .A2(ctl_r[55]), .Z(set_left[54]));
    OR2D1BWP7T30P140ULVT O541 (.A1(set_left[54]), .A2(set_right[54]), .Z(set[54]));
    MUX2D1BWP7T30P140ULVT M54 (.Z(ctl_n[54]), .S(counter_en), .I0(ctl_r[54]), .I1(set[54]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_54 (.Q(ctl_r[54]), .CP(clk_i), .D(ctl_n[54]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A551 (.A1(shift_right), .A2(ctl_r[54]), .Z(set_right[55]));
    AN2D1BWP7T30P140ULVT A552 (.A1(shift_left), .A2(ctl_r[56]), .Z(set_left[55]));
    OR2D1BWP7T30P140ULVT O551 (.A1(set_left[55]), .A2(set_right[55]), .Z(set[55]));
    MUX2D1BWP7T30P140ULVT M55 (.Z(ctl_n[55]), .S(counter_en), .I0(ctl_r[55]), .I1(set[55]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_55 (.Q(ctl_r[55]), .CP(clk_i), .D(ctl_n[55]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A561 (.A1(shift_right), .A2(ctl_r[55]), .Z(set_right[56]));
    AN2D1BWP7T30P140ULVT A562 (.A1(shift_left), .A2(ctl_r[57]), .Z(set_left[56]));
    OR2D1BWP7T30P140ULVT O561 (.A1(set_left[56]), .A2(set_right[56]), .Z(set[56]));
    MUX2D1BWP7T30P140ULVT M56 (.Z(ctl_n[56]), .S(counter_en), .I0(ctl_r[56]), .I1(set[56]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_56 (.Q(ctl_r[56]), .CP(clk_i), .D(ctl_n[56]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A571 (.A1(shift_right), .A2(ctl_r[56]), .Z(set_right[57]));
    AN2D1BWP7T30P140ULVT A572 (.A1(shift_left), .A2(ctl_r[58]), .Z(set_left[57]));
    OR2D1BWP7T30P140ULVT O571 (.A1(set_left[57]), .A2(set_right[57]), .Z(set[57]));
    MUX2D1BWP7T30P140ULVT M57 (.Z(ctl_n[57]), .S(counter_en), .I0(ctl_r[57]), .I1(set[57]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_57 (.Q(ctl_r[57]), .CP(clk_i), .D(ctl_n[57]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A581 (.A1(shift_right), .A2(ctl_r[57]), .Z(set_right[58]));
    AN2D1BWP7T30P140ULVT A582 (.A1(shift_left), .A2(ctl_r[59]), .Z(set_left[58]));
    OR2D1BWP7T30P140ULVT O581 (.A1(set_left[58]), .A2(set_right[58]), .Z(set[58]));
    MUX2D1BWP7T30P140ULVT M58 (.Z(ctl_n[58]), .S(counter_en), .I0(ctl_r[58]), .I1(set[58]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_58 (.Q(ctl_r[58]), .CP(clk_i), .D(ctl_n[58]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A591 (.A1(shift_right), .A2(ctl_r[58]), .Z(set_right[59]));
    AN2D1BWP7T30P140ULVT A592 (.A1(shift_left), .A2(ctl_r[60]), .Z(set_left[59]));
    OR2D1BWP7T30P140ULVT O591 (.A1(set_left[59]), .A2(set_right[59]), .Z(set[59]));
    MUX2D1BWP7T30P140ULVT M59 (.Z(ctl_n[59]), .S(counter_en), .I0(ctl_r[59]), .I1(set[59]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_59 (.Q(ctl_r[59]), .CP(clk_i), .D(ctl_n[59]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A601 (.A1(shift_right), .A2(ctl_r[59]), .Z(set_right[60]));
    AN2D1BWP7T30P140ULVT A602 (.A1(shift_left), .A2(ctl_r[61]), .Z(set_left[60]));
    OR2D1BWP7T30P140ULVT O601 (.A1(set_left[60]), .A2(set_right[60]), .Z(set[60]));
    MUX2D1BWP7T30P140ULVT M60 (.Z(ctl_n[60]), .S(counter_en), .I0(ctl_r[60]), .I1(set[60]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_60 (.Q(ctl_r[60]), .CP(clk_i), .D(ctl_n[60]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A611 (.A1(shift_right), .A2(ctl_r[60]), .Z(set_right[61]));
    AN2D1BWP7T30P140ULVT A612 (.A1(shift_left), .A2(ctl_r[62]), .Z(set_left[61]));
    OR2D1BWP7T30P140ULVT O611 (.A1(set_left[61]), .A2(set_right[61]), .Z(set[61]));
    MUX2D1BWP7T30P140ULVT M61 (.Z(ctl_n[61]), .S(counter_en), .I0(ctl_r[61]), .I1(set[61]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_61 (.Q(ctl_r[61]), .CP(clk_i), .D(ctl_n[61]), .CDN(async_reset_neg));
  

    AN2D1BWP7T30P140ULVT A621 (.A1(shift_right), .A2(ctl_r[61]), .Z(set_right[62]));
    AN2D1BWP7T30P140ULVT A622 (.A1(shift_left), .A2(ctl_r[63]), .Z(set_left[62]));
    OR2D1BWP7T30P140ULVT O621 (.A1(set_left[62]), .A2(set_right[62]), .Z(set[62]));
    MUX2D1BWP7T30P140ULVT M62 (.Z(ctl_n[62]), .S(counter_en), .I0(ctl_r[62]), .I1(set[62]));
    DFCNQD1BWP7T30P140ULVT ctl_reg_62 (.Q(ctl_r[62]), .CP(clk_i), .D(ctl_n[62]), .CDN(async_reset_neg));
  

    TIELBWP7T30P140ULVT T63 (.ZN(set_left[63]));
    AN2D1BWP7T30P140ULVT A632 (.A1(shift_right), .A2(ctl_r[63]), .Z(set_right[63]));
    OR2D1BWP7T30P140ULVT O631 (.A1(set_left[63]), .A2(set_right[63]), .Z(set[63]));
    MUX2D1BWP7T30P140ULVT M63 (.Z(ctl_n[63]), .S(counter_en), .I0(ctl_r[63]), .I1(set[63]));
    DFSNQD1BWP7T30P140ULVT ctl_reg_63 (.Q(ctl_r[63]), .CP(clk_i), .D(ctl_n[63]), .SDN(async_reset_neg));


    assign clk_o = clk_90;

  endmodule


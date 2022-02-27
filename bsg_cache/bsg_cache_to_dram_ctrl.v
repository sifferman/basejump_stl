/**
 *  bsg_cache_to_dram_ctrl.v
 *
 *  @author tommy
 *
 */

`include "bsg_defines.v"
`include "bsg_cache.vh"
`include "bsg_dmc.vh"

module bsg_cache_to_dram_ctrl
  import bsg_cache_pkg::*;
  import bsg_dmc_pkg::*;
  #(parameter `BSG_INV_PARAM(num_cache_p)
    , parameter `BSG_INV_PARAM(addr_width_p)
    , parameter `BSG_INV_PARAM(data_width_p)
    , parameter `BSG_INV_PARAM(block_size_in_words_p)
    , parameter `BSG_INV_PARAM(dram_ctrl_burst_len_p)
    
    , localparam mask_width_lp=(data_width_p>>3)
    , localparam dma_pkt_width_lp=`bsg_cache_dma_pkt_width(addr_width_p)

    , localparam num_req_lp=(block_size_in_words_p/dram_ctrl_burst_len_p)
  )
  (
    input clk_i
    , input reset_i
    
    // dram size selection
    // {0:256Mb, 1:512Mb, 2:1Gb, 3:2Gb, 4:4Gb}
    , input [2:0] dram_size_i

    // cache side
    , input [dma_pkt_width_lp-1:0] dma_pkt_i
    , input dma_pkt_v_i
    , output logic dma_pkt_yumi_o

    , output logic [data_width_p-1:0] dma_data_o
    , output logic dma_data_v_o
    , input dma_data_ready_i

    , input [data_width_p-1:0] dma_data_i
    , input dma_data_v_i
    , output logic dma_data_yumi_o

    // dmc side
    , output logic app_en_o
    , input app_rdy_i
    , output app_cmd_e app_cmd_o
    , output logic [addr_width_p-1:0] app_addr_raw_o

    , output logic app_wdf_wren_o
    , input app_wdf_rdy_i
    , output logic [data_width_p-1:0] app_wdf_data_o
    , output logic [mask_width_lp-1:0] app_wdf_mask_o
    , output logic app_wdf_end_o

    , input app_rd_data_valid_i
    , input [data_width_p-1:0] app_rd_data_i
    , input app_rd_data_end_i
  );

  // round robin for dma pkts
  //
  `declare_bsg_cache_dma_pkt_s(addr_width_p);
  bsg_cache_dma_pkt_s dma_pkt;
  assign dma_pkt = dma_pkt_i;

  // rx module
  //
  logic rx_v_li;
  logic rx_ready_lo;

  bsg_cache_to_dram_ctrl_rx #(
    .num_cache_p(num_cache_p)
    ,.data_width_p(data_width_p)
    ,.block_size_in_words_p(block_size_in_words_p)
    ,.dram_ctrl_burst_len_p(dram_ctrl_burst_len_p)
  ) rx (
    .clk_i(clk_i)
    ,.reset_i(reset_i)

    ,.v_i(rx_v_li)
    ,.ready_o(rx_ready_lo)

    ,.dma_data_o(dma_data_o)
    ,.dma_data_v_o(dma_data_v_o)
    ,.dma_data_ready_i(dma_data_ready_i)

    ,.app_rd_data_valid_i(app_rd_data_valid_i)
    ,.app_rd_data_i(app_rd_data_i)
    ,.app_rd_data_end_i(app_rd_data_end_i)
  );

  // tx module
  //
  logic tx_v_li;
  logic tx_ready_lo;

  bsg_cache_to_dram_ctrl_tx #(
    .num_cache_p(num_cache_p)
    ,.data_width_p(data_width_p)
    ,.block_size_in_words_p(block_size_in_words_p)
    ,.dram_ctrl_burst_len_p(dram_ctrl_burst_len_p)
  ) tx (
    .clk_i(clk_i)
    ,.reset_i(reset_i)
    ,.v_i(tx_v_li)
    ,.ready_o(tx_ready_lo)
    ,.dma_data_i(dma_data_i)
    ,.dma_data_v_i(dma_data_v_i)
    ,.dma_data_yumi_o(dma_data_yumi_o)
    ,.app_wdf_wren_o(app_wdf_wren_o)
    ,.app_wdf_rdy_i(app_wdf_rdy_i)
    ,.app_wdf_data_o(app_wdf_data_o)
    ,.app_wdf_mask_o(app_wdf_mask_o)
    ,.app_wdf_end_o(app_wdf_end_o)
  );

  // dma request
  //
  typedef enum logic {
    WAIT,
    SEND_REQ
  } req_state_e;

  req_state_e req_state_r, req_state_n;
  logic [addr_width_p-1:0] addr_r, addr_n;
  logic write_not_read_r, write_not_read_n;
  logic [`BSG_SAFE_CLOG2(num_req_lp)-1:0] req_cnt_r, req_cnt_n;

  always_comb begin
    app_en_o = 1'b0;
    app_cmd_o = WR;
    dma_pkt_yumi_o = 1'b0;
    write_not_read_n = write_not_read_r;
    rx_v_li = 1'b0;
    tx_v_li = 1'b0;
    req_state_n = req_state_r;
    req_cnt_n = req_cnt_r;
    addr_n = addr_r;
    
    case (req_state_r)
      WAIT: begin
        if (dma_pkt_v_i) begin
          dma_pkt_yumi_o = 1'b1;
          addr_n = dma_pkt.addr;
          write_not_read_n = dma_pkt.write_not_read;
          req_cnt_n = '0;
          req_state_n = SEND_REQ;
        end
      end

      SEND_REQ: begin
        app_en_o = (write_not_read_r
          ? tx_ready_lo
          : rx_ready_lo);
        app_cmd_o = write_not_read_r
          ? WR
          : RD;

        rx_v_li = ~write_not_read_r & rx_ready_lo & app_rdy_i;
        tx_v_li = write_not_read_r & tx_ready_lo & app_rdy_i;

        addr_n = (app_rdy_i & app_en_o)
          ? addr_r + (1 << `BSG_SAFE_CLOG2(dram_ctrl_burst_len_p*data_width_p/8))
          : addr_r;
        req_cnt_n = (app_rdy_i & app_en_o)
          ? req_cnt_r + 1
          : req_cnt_r;
        req_state_n = app_rdy_i & app_en_o & (req_cnt_r == num_req_lp-1)
          ? WAIT
          : SEND_REQ;
      end
    endcase
  end

  assign app_addr_raw_o = addr_r;

  // sequential
  //
  always_ff @ (posedge clk_i) begin
    if (reset_i) begin
      req_state_r <= WAIT;
      addr_r <= '0;
      req_cnt_r <= '0;
      write_not_read_r <= 1'b0;
    end
    else begin
      req_state_r <= req_state_n;
      addr_r <= addr_n;
      req_cnt_r <= req_cnt_n;
      write_not_read_r <= write_not_read_n;
    end
  end


endmodule

`BSG_ABSTRACT_MODULE(bsg_cache_to_dram_ctrl)

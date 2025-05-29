//////////////////////////////////////////////////////////////////////////////
// © Copyright 2022 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, Inc.
// All Rights Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 2021.1
//  \   \        Application: Isolation Design Flow + Dynamic Function eXchange tutorial
//  /   /        Filename: timer_flag.v
// /___/   /\    Date Last Modified: 15 AUG 2022
// \   \  /  \
//  \___\/\___\
//
//
//
// Board:  ZCU102
// Device: zu9eg
// Design Name: project_idf_dfx_zcu102
// Purpose: Isolation Design Flow + Dynamic Function eXchange Example
module timer_flag (
  input      clk,
  input      vs_shift_decouple,
  input      vs_count_decouple,
  output     vs_shift_capture,
  output     vs_count_capture
  );

edge_det edge_det_count (
  .clk(clk),
  .din(vs_count_decouple),
  .rise_edge(),
  .fall_edge(vs_count_capture)
  );

edge_det edge_det_shift (
  .clk(clk),
  .din(vs_shift_decouple),
  .rise_edge(),
  .fall_edge(vs_shift_capture)
  );

endmodule

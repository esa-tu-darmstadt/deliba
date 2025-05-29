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
//  /   /        Filename: edge_det.v
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
module edge_det (
  input       clk,
  input       din,
  output reg  rise_edge,
  output reg  fall_edge
  );

reg [1:0] shift;

always @(posedge clk)
begin
  shift <= {shift[0], din};

  if (shift == 2'b01)
    rise_edge <= 1'b1;
  else 
    rise_edge <= 1'b0;

  if (shift == 2'b10)
    fall_edge <= 1'b1;
  else 
    fall_edge <= 1'b0;
end

endmodule


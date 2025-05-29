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
//  /   /        Filename: shift_addr.v
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
module shift_addr (
   rst,
   clk,
   addr_out
);

   input rst;                // Active high reset
   input clk;                // 100MHz input clock
   output [11:0] addr_out;   // Output to shift
   
   reg [34:0]  count_value;
   
always @(posedge clk)
begin
  if (rst)
    count_value <= 0;
  else
    count_value <= count_value + 1'b1;

end

assign addr_out = count_value[34:23];

endmodule

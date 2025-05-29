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
//  /   /        Filename: icap_wrapper.v
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
module icap_wrapper (
   input  CLK,
   input  err_inj,
   output err_inserted,

  (* X_INTERFACE_INFO = "xilinx.com:interface:icap:1.0 ICAP avail" *)   output        AVAIL,
  (* X_INTERFACE_INFO = "xilinx.com:interface:icap:1.0 ICAP o" *)       output [31:0] O,
  (* X_INTERFACE_INFO = "xilinx.com:interface:icap:1.0 ICAP prdone" *)  output        PRDONE,
  (* X_INTERFACE_INFO = "xilinx.com:interface:icap:1.0 ICAP prerror" *) output        PRERROR,
  (* X_INTERFACE_INFO = "xilinx.com:interface:icap:1.0 ICAP csib" *)    input         CSIB,
  (* X_INTERFACE_INFO = "xilinx.com:interface:icap:1.0 ICAP i" *)       input [31:0]  I,
  (* X_INTERFACE_INFO = "xilinx.com:interface:icap:1.0 ICAP rdwrb" *)   input         RDWRB
  );

reg       crc_cmd, crc_cmd_d1;
reg       far_cmd, far_cmd_d1, far_cmd_d2, far_cmd_d3;

reg [1:0] err_inj_shift;
reg       err_inj_rise;
reg       err_inj_latch;


   ICAPE3 u_icap (
      .AVAIL(AVAIL),          // 1-bit output: Availability status of ICAP
      .O(O),                  // 32-bit output: Configuration data output bus
      .PRDONE(PRDONE),        // 1-bit output: Indicates completion of Partial Reconfiguration
      .PRERROR(PRERROR),      // 1-bit output: Indicates Error during Partial Reconfiguration
      .CLK(CLK),              // 1-bit input: Clock input
      .CSIB(CSIB),            // 1-bit input: Active-Low ICAP enable
      .I({I[31:1], I0_mod}),  // 32-bit input: Configuration data input bus
      .RDWRB(RDWRB)           // 1-bit input: Read/Write Select input
   );


//Err injection
assign I0_mod       = (crc_cmd && far_cmd_d2)? ~I[0] : I[0];
assign err_inserted = crc_cmd & far_cmd_d2;

always @(posedge CLK)
begin
  err_inj_shift <= {err_inj_shift[0], err_inj};

  if (err_inj_shift == 2'b01)
    err_inj_rise <= 1'b1;
  else
    err_inj_rise <= 1'b0;
end

always @(posedge CLK)
begin
  if (err_inj_rise)
    err_inj_latch <= 1'b1;
  else if (err_inserted)
    err_inj_latch <= 1'b0;
  else
    err_inj_latch <= err_inj_latch;
end
//----

//FAR command search
always @(posedge CLK)
begin
  if (CSIB==0)
  begin
    far_cmd_d1 <= far_cmd;
    far_cmd_d2 <= far_cmd_d1;
    far_cmd_d3 <= far_cmd_d2;

    if (I==32'h0C000480 && err_inj_latch == 1'b1)
      far_cmd <= 1;
    else
      far_cmd <= 0;
  end
end

//CRC command search
always @(posedge CLK)
begin
  if (CSIB==1'b0)
  begin
    crc_cmd_d1 <= crc_cmd;

    if (I==32'h0C000080 && err_inj_latch == 1'b1)
      crc_cmd <= 1;
    else
      crc_cmd <= 0;
  end
end

endmodule

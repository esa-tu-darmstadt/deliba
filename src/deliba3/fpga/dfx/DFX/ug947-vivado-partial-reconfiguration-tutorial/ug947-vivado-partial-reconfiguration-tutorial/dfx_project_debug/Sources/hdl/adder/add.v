//////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2005-2020 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, Inc.
// All Rights Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 1.0
//  \   \        Application: Dynamic Function eXchange
//  /   /        Filename: top.v
// /___/   /\    Date Last Modified: 14 FEB 2020
// \   \  /  \
//  \___\/\___\
//
// Board:  KCU105 Rev 1.0 and others
// Device: xcku040-ffva1156-2 and others
// Design Name: project_debug
// Purpose: Dynamic Function eXchange Tutorial
///////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
//  math_rp, reconfigurable top for add function
//////////////////////////////////////////////////////////////////////////////

module math_rp(
    in1,
    in2,
    clk,
    reset_vio,
    out,
    S_BSCAN_drck,
    S_BSCAN_shift,
    S_BSCAN_tdi,
    S_BSCAN_update,
    S_BSCAN_sel,   
    S_BSCAN_tdo,
    S_BSCAN_tms,
    S_BSCAN_tck,
    S_BSCAN_runtest,
    S_BSCAN_reset,
    S_BSCAN_capture,
    S_BSCAN_bscanid_en
    );        
    
  input [3:0] in1;
  input [3:0] in2;
  input clk;
  input reset_vio;
  output reg [7:0] out;
  input  S_BSCAN_drck; 
  input  S_BSCAN_shift;     
  input  S_BSCAN_tdi;       
  input  S_BSCAN_update;    
  input  S_BSCAN_sel;       
  output S_BSCAN_tdo;       
  input  S_BSCAN_tms;       
  input  S_BSCAN_tck;       
  input  S_BSCAN_runtest;   
  input  S_BSCAN_reset;     
  input  S_BSCAN_capture;   
  input  S_BSCAN_bscanid_en;
  
// BSCAN interface metadata on ports
// This is an alternate method to be used ONLY when the RP port names are NOT the exact S_BSCAN_* naming convention used above.
// Do not change the attributes listed here.
//  (* X_INTERFACE_INFO = "xilinx.com:interface:bscan:1.0 S_BSCAN drck" *) (* DEBUG="true" *)       input  my_drck; 
//  (* X_INTERFACE_INFO = "xilinx.com:interface:bscan:1.0 S_BSCAN shift" *) (* DEBUG="true" *)      input  my_shift;          
//  (* X_INTERFACE_INFO = "xilinx.com:interface:bscan:1.0 S_BSCAN tdi" *) (* DEBUG="true" *)        input  my_tdi;            
//  (* X_INTERFACE_INFO = "xilinx.com:interface:bscan:1.0 S_BSCAN update" *) (* DEBUG="true" *)     input  my_update;         
//  (* X_INTERFACE_INFO = "xilinx.com:interface:bscan:1.0 S_BSCAN sel" *) (* DEBUG="true" *)        input  my_sel;            
//  (* X_INTERFACE_INFO = "xilinx.com:interface:bscan:1.0 S_BSCAN tdo" *) (* DEBUG="true" *)        output my_tdo;            
//  (* X_INTERFACE_INFO = "xilinx.com:interface:bscan:1.0 S_BSCAN tms" *) (* DEBUG="true" *)        input  my_tms;            
//  (* X_INTERFACE_INFO = "xilinx.com:interface:bscan:1.0 S_BSCAN tck" *) (* DEBUG="true" *)        input  my_tck;            
//  (* X_INTERFACE_INFO = "xilinx.com:interface:bscan:1.0 S_BSCAN runtest" *) (* DEBUG="true" *)    input  my_runtest;        
//  (* X_INTERFACE_INFO = "xilinx.com:interface:bscan:1.0 S_BSCAN reset" *) (* DEBUG="true" *)      input  my_reset;          
//  (* X_INTERFACE_INFO = "xilinx.com:interface:bscan:1.0 S_BSCAN capture" *) (* DEBUG="true" *)    input  my_capture;        
//  (* X_INTERFACE_INFO = "xilinx.com:interface:bscan:1.0 S_BSCAN bscanid_en" *) (* DEBUG="true" *) input  my_bscanid_en; 
                        
  wire [5:0] outtmp1;
  wire [5:0] outtmp2; 
                        
c_addsub_0 adder_ip_instance0 (
  .A({1'b0,in1}),  // input wire [4 : 0] A
  .B({1'b0,in2}),  // input wire [4 : 0] B
  .S(outtmp1)  // output wire [5 : 0] S
);                                     

c_addsub_0 adder_ip_instance1 (
  .A(outtmp1[4:0]),  // input wire [4 : 0] A
  .B({1'b0,in1}),  // input wire [4 : 0] B
  .S(outtmp2)  // output wire [5 : 0] S
);

ila_add my_add_ila (
        .clk(clk), // input wire clk
        .probe0({2'b0,outtmp2}) // input wire [5:0] probe0
);

always @(posedge clk)
begin
  if (reset_vio == 1'b1) begin
    out <= 7'b0;
  end else begin
    out <= {2'b0,outtmp2};
  end
end

endmodule
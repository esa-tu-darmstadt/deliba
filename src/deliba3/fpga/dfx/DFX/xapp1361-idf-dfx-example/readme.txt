*************************************************************************
   ____  ____ 
  /   /\/   / 
 /___/  \  /   
 \   \   \/    © Copyright 2021-2022 Xilinx, Inc. All rights reserved.
  \   \        This file contains confidential and proprietary 
  /   /        information of Xilinx, Inc. and is protected under U.S. 
 /___/   /\    and international copyright and other intellectual 
 \   \  /  \   property laws. 
  \___\/\___\ 
 
*************************************************************************

Vendor: Xilinx 
Current readme.txt Version: 2.0
Date Last Modified:  15AUG2022
Date Created: 06JUN2021

Associated Filename: xapp1361-idf-dfx-example.zip
Associated Document: XAPP1361, Isolation Design Flow + Dynamic Function eXchange Example

Supported Device(s): ZCU102
   
*************************************************************************

Disclaimer: 

      This disclaimer is not a license and does not grant any rights to 
      the materials distributed herewith. Except as otherwise provided in 
      a valid license issued to you by Xilinx, and to the maximum extent 
      permitted by applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE 
      "AS IS" AND WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL 
      WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, 
      INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, 
      NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and 
      (2) Xilinx shall not be liable (whether in contract or tort, 
      including negligence, or under any other theory of liability) for 
      any loss or damage of any kind or nature related to, arising under 
      or in connection with these materials, including for any direct, or 
      any indirect, special, incidental, or consequential loss or damage 
      (including loss of data, profits, goodwill, or any type of loss or 
      damage suffered as a result of any action brought by a third party) 
      even if such damage or loss was reasonably foreseeable or Xilinx 
      had been advised of the possibility of the same.

Critical Applications:

      Xilinx products are not designed or intended to be fail-safe, or 
      for use in any application requiring fail-safe performance, such as 
      life-support or safety devices or systems, Class III medical 
      devices, nuclear facilities, applications related to the deployment 
      of airbags, or any other applications that could lead to death, 
      personal injury, or severe property or environmental damage 
      (individually and collectively, "Critical Applications"). Customer 
      assumes the sole risk and liability of any use of Xilinx products 
      in Critical Applications, subject only to applicable laws and 
      regulations governing limitations on product liability.

THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS 
FILE AT ALL TIMES.

*************************************************************************

This readme file contains these sections:

1. REVISION HISTORY
2. OVERVIEW
3. SOFTWARE TOOLS AND SYSTEM REQUIREMENTS
4. DESIGN FILE HIERARCHY
5. INSTALLATION AND OPERATING INSTRUCTIONS
6. OTHER INFORMATION (OPTIONAL)
7. SUPPORT


1. REVISION HISTORY 

            Readme  
Date        Version      Revision Description
=========================================================================
06JUN2021   1.0          Initial Xilinx release.
15AUG2022   2.0          Changed to BDC flow and New Vivado/Vitis Releases
=========================================================================



2. OVERVIEW

This readme describes how to use the files that come with XAPP1361

This reference design contains two reconfigurable partitions (RP), and under 
each RP, there is an isolated module (IM). There is one more isolated module 
in the static region.

The design uses a simple bare metal application running in PS to load 
partial bitstreams. The partial bitstreams are placed into a PS-DDR memory 
and loaded into the device using an application running on the Cortex®-A53.
The application uses xilfpga library to load the partial bitstreams through the
Processor Configuration Access Port (PCAP). More information on the xilfpga 
library can be found in the Zynq UltraScale+ MPSoC: Software Developers 
Guide (UG1137).

The design static IM contains a MicroBlaze and the ICAP to show isolation 
capabilities. This lab uses RTL files from Lab 7 of Vivado Design Suite 
Tutorial: Dynamic Function eXchange (UG947). This lab operates with the 
assumption that the user is familiar with the DFX design creation covered 
through the labs in Vivado Design Suite Tutorial: Dynamic Function 
eXchange (UG947).

3. SOFTWARE TOOLS AND SYSTEM REQUIREMENTS

* Xilinx Vivado 2021.1 or higher
  Note: This is verified with 2021.1, 2021.2 and 2022.1
* Xilinx ZCU102 Evaluation Board (revision 1.0 with production silicon)
* AC to DC power adapter (12 VDC)
* USB Type-A to Micro-B USB cable for UART communication
* Secure Digital (SD-MMC) card 32 GB
* Integrating LogiCORE SEM IP. Refer to Integrating LogiCORE SEM IP 
  in Zynq UltraScale+ Devices (XAPP1298) and the associated Reference 
  Design Files of the application note.
* Xilinx Vitis Unifies Software Development Platform 2021.1 or later
  Note: This is verified with 2021.1, 2021.2 and 2022.1
* Serial communication terminal application (Tera Term or PuTTY)

4. DESIGN FILE HIERARCHY

\project_idf_dfx_zcu102.tcl
 |   TCL file to create the project
\sources
 |      This directory conatins files for wrapper files, constraint files
 |      TCL hoook script files.
 +----- \[count_up, count_down, shift_left, shift_right]
 |       These directories contains verilog files for respective 
 |       modules.
 +----- \dfx_demo
 |      This directory contains files for the software application
 |      to load partial Bitstreams via PCAP

5. INSTALLATION AND OPERATING INSTRUCTIONS 

1) Install the Xilinx Vivado 2021.1 or later tools.
2) Follow the steps in XAPP1361 to build the design


6. OTHER INFORMATION

1) Warnings
        None

2) Design Notes
	None

3) Fixes
	None

4) Known Issues
        None

7. SUPPORT

To obtain technical support for this reference design, go to 
www.xilinx.com/support to locate answers to known issues in the Xilinx
Answers Database.

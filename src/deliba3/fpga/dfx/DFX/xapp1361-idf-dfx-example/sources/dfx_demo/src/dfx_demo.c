/******************************************************************************
*
* Copyright (C) 2009 - 2022 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * dfx_demo.c: simple application to load partial bitstreams
 *
 * This application configures UART 16550 to baud rate 115200.
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xilfpga.h"
#include "dfx_demo.h"


int main()
{
	XFpga XFpgaInstance = {0U};
	s32 Status = 0;
	u32 Option = 1;
	u32 Exit = 0;
	u32 LoadRM = 0;
	u64 Size = PARTIAL_SHIFT_LEFT_RM_SIZE;
	u64 Addr = PARTIAL_DDR_SHIFT_LEFT_ADDR;

    init_platform();

    Status = XFpga_Initialize(&XFpgaInstance);
    if (Status != XST_SUCCESS) {
    	print("XFpga init failed\n\r");
    }

    print("\n\r\n\r*** Dynamic Function eXchange SW Trigger ***\n\r");

    while(Exit != 1) {
      do {
        print ("------------------ Menu ------------------\n\r");
        print ("    1: Shift Left\n\r");
        print ("    2: Shift Right\n\r");
        print ("    3: Count Up\n\r");
        print ("    4: Count Down\n\r");
        print ("    0: Exit\n\r");
        print ("> ");

        Option = inbyte();

        if (isalpha(Option)) {
          Option = toupper(Option);
        }

        xil_printf("%c\n\r", Option);

      } while (!isdigit(Option));
          print ("\n\r");

      switch (Option) {
        case '0' :
          Exit = 1;
          LoadRM = 0;
          print("Exiting from Reconfiguration wizard...\n\r\n\r");
          break;

        case '1' :
          print("Reconfiguring Shift Left...\n\r\n\r");
          Addr = PARTIAL_DDR_SHIFT_LEFT_ADDR;
          Size = PARTIAL_SHIFT_LEFT_RM_SIZE;
          LoadRM = 1;
          break;

        case '2' :
          print("Reconfiguring Shift Right...\n\r\n\r");
          Addr = PARTIAL_DDR_SHIFT_RIGHT_ADDR;
          Size = PARTIAL_SHIFT_RIGHT_RM_SIZE;
          LoadRM = 1;
          break;

        case '3' :
          print("Reconfiguring Count Up...\n\r\n\r");
          Addr = PARTIAL_DDR_COUNT_UP_ADDR;
          Size = PARTIAL_COUNT_UP_RM_SIZE;
          LoadRM = 1;
          break;

        case '4' :
          print("Reconfiguring Count Down...\n\r\n\r");
          Addr = PARTIAL_DDR_COUNT_DOWN_ADDR;
          Size = PARTIAL_COUNT_DOWN_RM_SIZE;
          LoadRM = 1;
          break;

        default:
          LoadRM = 0;
          break;
      }

      if (LoadRM == 1) {
        UINTPTR KeyAddr = (UINTPTR)NULL;
        Status = XFpga_BitStream_Load(&XFpgaInstance, Addr, KeyAddr, Size, XFPGA_PARTIAL_EN);

        if (Status == XFPGA_SUCCESS) {
      	  xil_printf("Partial Reconfiguration Bitstream loaded into the PL successfully\n\r");
        } else {
      	  xil_printf("Partial Reconfiguration Bitstream loading into the PL failed, Status: %d\n\r",Status);
          Exit = 1;
        }

        LoadRM = 0;
      }
    }

    cleanup_platform();
    return 0;
}

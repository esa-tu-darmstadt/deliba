/******************************************************************************
*
* Copyright (C) 2009 - 2020 Xilinx, Inc.  All rights reserved.
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
 * dfxc_demo.c: simple dfxc_demo application
 *
 * This application configures UART 16550 to baud rate 115200.
 */

#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "xtmrctr.h"
#include "xprc.h"
#include "dfxc_demo.h"


int main()
{

  u32 copy_status;

  u32 Exit   = 0;
  u32 Option = 1;

  char reconfig_type[]  = "Normal CRC from QSPI";
  char reconfig_type1[] = "Normal CRC from DDR4";
  char reconfig_type2[] = "per Frame CRC from DDR4";
  char reconfig_type3[] = "Normal CRC from QSPI";
  char reconfig_type4[] = "per Frame CRC from QSPI";

  //For DFX Controller
  u32 prc_init;
  u32 prc_status;
  u32 prc_status_state;
  u32 prc_status_last_state;
  u32 prc_status_err;
  XPrc Prc;
  XPrc_Config *XPrcCfgPtr;

  u32 rm_loading    = 0;
  u32 shift_loading = 0;
  u32 count_loading = 0;
  u32 use_pfcrc     = 0;
  u32 use_ddr       = 0;

  //For Timer
  u32 timer_init;
  u32 timer_start_shift;
  u32 timer_start_count;
  u32 timer_end_shift;
  u32 timer_end_count;
  u32 timer_skip = 0;
  XTmrCtr TimerCounter; /* The instance of the Tmrctr Device */
  XTmrCtr *TmrCtrInstancePtr = &TimerCounter;


  init_platform();

  //Timer Setting
  timer_init = XTmrCtr_Initialize(TmrCtrInstancePtr, TMRCTR_DEVICE_ID);
  if (timer_init != XST_SUCCESS) {
    print("Timer Initialization Fails\r\n");
    return XST_FAILURE;
  }

  XTmrCtr_SetOptions(TmrCtrInstancePtr, TIMER_COUNTER_0, XTC_CAPTURE_MODE_OPTION+XTC_AUTO_RELOAD_OPTION);
  XTmrCtr_Start     (TmrCtrInstancePtr, TIMER_COUNTER_0);
  XTmrCtr_SetOptions(TmrCtrInstancePtr, TIMER_COUNTER_1, XTC_CAPTURE_MODE_OPTION+XTC_AUTO_RELOAD_OPTION);
  XTmrCtr_Start     (TmrCtrInstancePtr, TIMER_COUNTER_1);
  //

  //DFX Controller Driver initialize
  XPrcCfgPtr = XPrc_LookupConfig(XDFXC_DEVICE_ID);
  if (NULL == XPrcCfgPtr) {
    return XST_FAILURE;
  }

  prc_init = XPrc_CfgInitialize(&Prc, XPrcCfgPtr, XPrcCfgPtr->BaseAddress);
  if (prc_init != XST_SUCCESS) {
    return XST_FAILURE;
  }
  //

  //DFX Controller initial setting (QSPI, non per frame CRC)
  XPrc_SendShutdownCommand(&Prc, XDFXC_VS_SHIFT_ID);
  while(XPrc_IsVsmInShutdown(&Prc, XDFXC_VS_SHIFT_ID)==XPRC_SR_SHUTDOWN_OFF);
  XPrc_SendShutdownCommand(&Prc, XDFXC_VS_COUNT_ID);
  while(XPrc_IsVsmInShutdown(&Prc, XDFXC_VS_COUNT_ID)==XPRC_SR_SHUTDOWN_OFF);

  XPrc_SetBsSize   (&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_LEFT_ID,  PARTIAL_SHIFT_LEFT_RM_SIZE);
  XPrc_SetBsSize   (&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_RIGHT_ID, PARTIAL_SHIFT_RIGHT_RM_SIZE);
  XPrc_SetBsSize   (&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_UP_ID,    PARTIAL_COUNT_UP_RM_SIZE);
  XPrc_SetBsSize   (&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_DOWN_ID,  PARTIAL_COUNT_DOWN_RM_SIZE);
  XPrc_SetBsAddress(&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_LEFT_ID,  PARTIAL_SPI_SHIFT_LEFT_ADDR);
  XPrc_SetBsAddress(&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_RIGHT_ID, PARTIAL_SPI_SHIFT_RIGHT_ADDR);
  XPrc_SetBsAddress(&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_UP_ID,    PARTIAL_SPI_COUNT_UP_ADDR);
  XPrc_SetBsAddress(&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_DOWN_ID,  PARTIAL_SPI_COUNT_DOWN_ADDR);

  XPrc_SendRestartWithNoStatusCommand(&Prc, XDFXC_VS_SHIFT_ID);
  while(XPrc_IsVsmInShutdown(&Prc, XDFXC_VS_SHIFT_ID)==XPRC_SR_SHUTDOWN_ON);
  XPrc_SendRestartWithNoStatusCommand(&Prc, XDFXC_VS_COUNT_ID);
  while(XPrc_IsVsmInShutdown(&Prc, XDFXC_VS_COUNT_ID)==XPRC_SR_SHUTDOWN_ON);
  //

  //Copy QSPI data to DDR4
  print("\r\nCopying QSPI content to DDR4...\r\n");
  copy_status = memcpy(PARTIAL_DDR_SHIFT_LEFT_ADDR, PARTIAL_SPI_SHIFT_LEFT_ADDR, PARTIAL_DATA_SIZE);
  if (copy_status != PARTIAL_DDR_SHIFT_LEFT_ADDR) {
    return XST_FAILURE;
  }

  print("\n\r\n\r*** Dynamic Function eXchange SW Trigger ***\n\r");

  while(Exit != 1) {
    do {
      print ("------------------ Menu ------------------\n\r");
      xil_printf ("  Reconfig Type: %s\n\r", reconfig_type);
      print ("    1: Shift Left\n\r");
      print ("    2: Shift Right\n\r");
      print ("    3: Count Up\n\r");
      print ("    4: Count Down\n\r");
      print ("    5: Put RPs in Active mode\n\r");
      print ("    6: Put RPs in Shutdown mode\n\r");
      print ("    7: Change CRC type of Partial bit\n\r");
      print ("    8: Change Storage of Partial bit\n\r");
      print ("    9: Report Status\n\r");
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
        break;

      case '1' :
        print("Reconfiguring Shift Left...\n\r\n\r");
        if (XPrc_IsSwTriggerPending(&Prc, XDFXC_VS_SHIFT_ID, NULL)==XPRC_NO_SW_TRIGGER_PENDING) {
          print ("Starting Reconfiguration\n\r");
          XPrc_SendSwTrigger(&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_LEFT_ID);
        }
        shift_loading=1; rm_loading=1;
        break;

      case '2' :
        print("Reconfiguring Shift Right...\n\r\n\r");
        if (XPrc_IsSwTriggerPending(&Prc, XDFXC_VS_SHIFT_ID, NULL)==XPRC_NO_SW_TRIGGER_PENDING) {
          print ("Starting Reconfiguration\n\r");
          XPrc_SendSwTrigger(&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_RIGHT_ID);
        }
        shift_loading=1; rm_loading=1;
        break;

      case '3' :
        print("Reconfiguring Count Up...\n\r\n\r");
        if (XPrc_IsSwTriggerPending(&Prc, XDFXC_VS_COUNT_ID, NULL)==XPRC_NO_SW_TRIGGER_PENDING) {
          print ("Starting Reconfiguration\n\r");
          XPrc_SendSwTrigger(&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_UP_ID);
        }
        count_loading=1; rm_loading=1;
        break;

      case '4' :
        print("Reconfiguring Count Down...\n\r\n\r");
        if (XPrc_IsSwTriggerPending(&Prc, XDFXC_VS_COUNT_ID, NULL)==XPRC_NO_SW_TRIGGER_PENDING) {
          print ("Starting Reconfiguration\n\r");
          XPrc_SendSwTrigger(&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_DOWN_ID);
        }
        count_loading=1; rm_loading=1;
        break;

      case '5' :
        print("Putting RPs in Active Mode\n\r\n\r");
        XPrc_SendRestartWithNoStatusCommand(&Prc, XDFXC_VS_SHIFT_ID);
        while(XPrc_IsVsmInShutdown(&Prc, XDFXC_VS_SHIFT_ID)==XPRC_SR_SHUTDOWN_ON);
        XPrc_SendRestartWithNoStatusCommand(&Prc, XDFXC_VS_COUNT_ID);
        while(XPrc_IsVsmInShutdown(&Prc, XDFXC_VS_COUNT_ID)==XPRC_SR_SHUTDOWN_ON);
        timer_skip = 1;
        break;

      case '6' :
        print("Putting RPs in Shutdown Mode\n\r\n\r");
        XPrc_SendShutdownCommand(&Prc, XDFXC_VS_SHIFT_ID);
        while(XPrc_IsVsmInShutdown(&Prc, XDFXC_VS_SHIFT_ID)==XPRC_SR_SHUTDOWN_OFF);
        XPrc_SendShutdownCommand(&Prc, XDFXC_VS_COUNT_ID);
        while(XPrc_IsVsmInShutdown(&Prc, XDFXC_VS_COUNT_ID)==XPRC_SR_SHUTDOWN_OFF);
        timer_skip = 1;
        break;

      case '7' :
        if (use_pfcrc == 0) {
          use_pfcrc = 1;
          timer_skip = 1;
        }
        else {
          use_pfcrc = 0;
          timer_skip = 1;
        }

        //Inverting DDR setting in advance because it will be inverted in Case8
        if (use_ddr == 0) {
          use_ddr = 1;
        }
        else {
          use_ddr = 0;
        }
        //break; move to case8

      case '8' :
        print("Putting RPs in Shutdown mode\n\r");
        XPrc_SendShutdownCommand(&Prc, XDFXC_VS_SHIFT_ID);
        while(XPrc_IsVsmInShutdown(&Prc, XDFXC_VS_SHIFT_ID)==XPRC_SR_SHUTDOWN_OFF);
        XPrc_SendShutdownCommand(&Prc, XDFXC_VS_COUNT_ID);
        while(XPrc_IsVsmInShutdown(&Prc, XDFXC_VS_COUNT_ID)==XPRC_SR_SHUTDOWN_OFF);
        print("  RPs are shutdown\n\r");

        if (use_ddr == 0){
          use_ddr = 1;
          if (use_pfcrc == 0) {
            print("  Change DFX Controller setting to reconfig from DDR4\n\r");
            strcpy(reconfig_type, reconfig_type1);
            XPrc_SetBsSize   (&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_LEFT_ID,  PARTIAL_SHIFT_LEFT_RM_SIZE);
            XPrc_SetBsSize   (&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_RIGHT_ID, PARTIAL_SHIFT_RIGHT_RM_SIZE);
            XPrc_SetBsSize   (&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_UP_ID,    PARTIAL_COUNT_UP_RM_SIZE);
            XPrc_SetBsSize   (&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_DOWN_ID,  PARTIAL_COUNT_DOWN_RM_SIZE);
            XPrc_SetBsAddress(&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_LEFT_ID,  PARTIAL_DDR_SHIFT_LEFT_ADDR);
            XPrc_SetBsAddress(&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_RIGHT_ID, PARTIAL_DDR_SHIFT_RIGHT_ADDR);
            XPrc_SetBsAddress(&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_UP_ID,    PARTIAL_DDR_COUNT_UP_ADDR);
            XPrc_SetBsAddress(&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_DOWN_ID,  PARTIAL_DDR_COUNT_DOWN_ADDR);
            }
          else {
            print("  Change DFX Controller setting to reconfig with per Frame CRC from DDR4\n\r");
            strcpy(reconfig_type, reconfig_type2);
            XPrc_SetBsSize   (&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_LEFT_ID,  PARTIAL_SHIFT_LEFT_PFCRC_RM_SIZE);
            XPrc_SetBsSize   (&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_RIGHT_ID, PARTIAL_SHIFT_RIGHT_PFCRC_RM_SIZE);
            XPrc_SetBsSize   (&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_UP_ID,    PARTIAL_COUNT_UP_PFCRC_RM_SIZE);
            XPrc_SetBsSize   (&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_DOWN_ID,  PARTIAL_COUNT_DOWN_PFCRC_RM_SIZE);
            XPrc_SetBsAddress(&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_LEFT_ID,  PARTIAL_DDR_SHIFT_LEFT_PFCRC_ADDR);
            XPrc_SetBsAddress(&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_RIGHT_ID, PARTIAL_DDR_SHIFT_RIGHT_PFCRC_ADDR);
            XPrc_SetBsAddress(&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_UP_ID,    PARTIAL_DDR_COUNT_UP_PFCRC_ADDR);
            XPrc_SetBsAddress(&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_DOWN_ID,  PARTIAL_DDR_COUNT_DOWN_PFCRC_ADDR);
          }
        }
        else{
          use_ddr = 0;
          if (use_pfcrc == 0) {
            print("  Change DFX Controller setting to reconfig from QSPI\n\r");
            strcpy(reconfig_type, reconfig_type3);
            XPrc_SetBsSize   (&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_LEFT_ID,  PARTIAL_SHIFT_LEFT_RM_SIZE);
            XPrc_SetBsSize   (&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_RIGHT_ID, PARTIAL_SHIFT_RIGHT_RM_SIZE);
            XPrc_SetBsSize   (&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_UP_ID,    PARTIAL_COUNT_UP_RM_SIZE);
            XPrc_SetBsSize   (&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_DOWN_ID,  PARTIAL_COUNT_DOWN_RM_SIZE);
            XPrc_SetBsAddress(&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_LEFT_ID,  PARTIAL_SPI_SHIFT_LEFT_ADDR);
            XPrc_SetBsAddress(&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_RIGHT_ID, PARTIAL_SPI_SHIFT_RIGHT_ADDR);
            XPrc_SetBsAddress(&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_UP_ID,    PARTIAL_SPI_COUNT_UP_ADDR);
            XPrc_SetBsAddress(&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_DOWN_ID,  PARTIAL_SPI_COUNT_DOWN_ADDR);
          }
          else {
            print("  Change DFX Controller setting to reconfig with per Frame CRC from QSPI\n\r");
            strcpy(reconfig_type, reconfig_type4);
            XPrc_SetBsSize   (&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_LEFT_ID,  PARTIAL_SHIFT_LEFT_PFCRC_RM_SIZE);
            XPrc_SetBsSize   (&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_RIGHT_ID, PARTIAL_SHIFT_RIGHT_PFCRC_RM_SIZE);
            XPrc_SetBsSize   (&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_UP_ID,    PARTIAL_COUNT_UP_PFCRC_RM_SIZE);
            XPrc_SetBsSize   (&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_DOWN_ID,  PARTIAL_COUNT_DOWN_PFCRC_RM_SIZE);
            XPrc_SetBsAddress(&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_LEFT_ID,  PARTIAL_SPI_SHIFT_LEFT_PFCRC_ADDR);
            XPrc_SetBsAddress(&Prc, XDFXC_VS_SHIFT_ID, XDFXC_VS_SHIFT_RM_SHIFT_RIGHT_ID, PARTIAL_SPI_SHIFT_RIGHT_PFCRC_ADDR);
            XPrc_SetBsAddress(&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_UP_ID,    PARTIAL_SPI_COUNT_UP_PFCRC_ADDR);
            XPrc_SetBsAddress(&Prc, XDFXC_VS_COUNT_ID, XDFXC_VS_COUNT_RM_COUNT_DOWN_ID,  PARTIAL_SPI_COUNT_DOWN_PFCRC_ADDR);
          }
        }

        print("Putting RPs in Active mode\n\r\n\r");
        XPrc_SendRestartWithNoStatusCommand(&Prc, XDFXC_VS_SHIFT_ID);
        while(XPrc_IsVsmInShutdown(&Prc, XDFXC_VS_SHIFT_ID)==XPRC_SR_SHUTDOWN_ON);
        XPrc_SendRestartWithNoStatusCommand(&Prc, XDFXC_VS_COUNT_ID);
        while(XPrc_IsVsmInShutdown(&Prc, XDFXC_VS_COUNT_ID)==XPRC_SR_SHUTDOWN_ON);
        timer_skip = 1;
        break;

      case '9' :
        print("Virtual Socket : SHIFT Status\n\r");
        Prc_PrintVsmStatus(&Prc, XDFXC_VS_SHIFT_ID, NULL);
        print("\n\rVirtual Socket : COUNT Status\n\r");
        Prc_PrintVsmStatus(&Prc, XDFXC_VS_COUNT_ID, NULL);
        print("\n\r");
        timer_skip=1;
        break;

      default:
        break;
    }

    //Timer Value when reconfig start
    timer_start_shift = XTmrCtr_GetValue(TmrCtrInstancePtr, TIMER_COUNTER_0);
    timer_start_count = XTmrCtr_GetValue(TmrCtrInstancePtr, TIMER_COUNTER_1);

    while (rm_loading) {
      if (shift_loading==1) {
        prc_status=XPrc_ReadStatusReg(&Prc, XDFXC_VS_SHIFT_ID);
      }
      else {
        prc_status=XPrc_ReadStatusReg(&Prc, XDFXC_VS_COUNT_ID);
      }

      prc_status_state    =prc_status&0x07;
      prc_status_err      =prc_status&0xf8;

      switch(prc_status_err) {
        case (0x80) : print("RP is in Shutdown Mode!\n\r");
                      print("Make RP Active mode to reconfig!\n\r\n\r");
                      timer_skip=1; shift_loading=0; count_loading=0; rm_loading=0;
                      break;
        case (0x90) : print("CRC Error is Found!\n\r\n\r");
                      prc_status_err=1; shift_loading=0; count_loading=0; rm_loading=0;
                      break;
        case (0xC0) : print("Incorrect compressed bit format is Found!\n\r");
                      print("Make RP Active mode and reconfig with correct bit!\n\r\n\r");
                      timer_skip=1; shift_loading=0; count_loading=0; rm_loading=0;
                      break;
        case (0xB8) : print("Incorrect compressed bit size is Found!\n\r");
                      print("Make RP Active mode and reconfig with correct bit!\n\r\n\r");
                      timer_skip=1; shift_loading=0; count_loading=0; rm_loading=0;
                      break;
        default     : break;
      }


      while (prc_status_state != prc_status_last_state) {
        switch(prc_status_state) {
          case 7  : print("  RM is successfully loaded\n\r"); rm_loading=0; break;
          case 6  : print("  RM is being reset\n\r");                       break;
          case 5  : print("  Software start-up step\n\r");                  break;
          case 4  : print("  Loading new RM\n\r");                          break;
          case 2  : print("  Software Shutdown\n\r");                       break;
          case 1  : print("  Hardware Shutdown\n\r");                       break;
          default : break;
        }
        prc_status_last_state = prc_status_state;
      }
    }

    if ((timer_skip==0) && (prc_status_err==0)) {
      timer_end_shift = XTmrCtr_GetCaptureValue(TmrCtrInstancePtr, TIMER_COUNTER_0);
      timer_end_count = XTmrCtr_GetCaptureValue(TmrCtrInstancePtr, TIMER_COUNTER_1);
      if (shift_loading)
        xil_printf ("  PR Time = %d[us]\n\r", (timer_end_shift-timer_start_shift)*5/1000);
      else if (count_loading)
        xil_printf ("  PR Time = %d[us]\n\r", (timer_end_count-timer_start_count)*5/1000);

      shift_loading=0; count_loading=0;
      print("Dynamic Function eXchange Done!\n\r\n\r");
    }

    else {
      timer_skip=0; prc_status_err=0;
    }

  }

  cleanup_platform();
  return 0;
}

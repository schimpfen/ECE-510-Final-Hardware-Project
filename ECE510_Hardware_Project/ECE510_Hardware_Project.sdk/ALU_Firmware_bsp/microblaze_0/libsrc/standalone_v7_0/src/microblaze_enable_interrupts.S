/******************************************************************************
*
* Copyright (C) 2004 - 2019 Xilinx, Inc. All rights reserved.
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
/******************************************************************************
* @file microblaze_enable_interrupts.S
*
* @addtogroup microblaze_pseudo_asm_macro
* @{
* <h2> microblaze_enable_interrupts.S </h2>
*  - API to Enable Interrupts: void microblaze_enable_interrupts(void)
*
* This API Enables interrupts on the MicroBlaze processor. When the MicroBlaze
* processor starts up, interrupts are disabled. Interrupts must be explicitly
* turned on using this function.
*
* <pre>
*
* File   : microblaze_enable_interrupts.s
* Date   : 2002, March 20.
* Company: Xilinx
* Group  : Emerging Software Technologies
*
* Summary:
* Enable interrupts on the microblaze.
* </pre>
*
******************************************************************************/

#include "xparameters.h"

	.text
	.globl	microblaze_enable_interrupts
	.ent	microblaze_enable_interrupts
	.align	2
microblaze_enable_interrupts:
#if XPAR_MICROBLAZE_USE_MSR_INSTR == 1
	rtsd	r15, 8
	msrset  r0, 0x2
	nop
#else /*XPAR_MICROBLAZE_USE_MSR_INSTR == 1*/
	#Read the MSR register
	mfs	r12, rmsr
	#Set the interrupt enable bit
	ori	r12, r12, 0x2
	#Save the MSR register
	mts	rmsr, r12
	#Return
	rtsd	r15, 8
	nop
#endif /*XPAR_MICROBLAZE_USE_MSR_INSTR == 1*/
	.end	microblaze_enable_interrupts
/**
* @} End of "addtogroup microblaze_pseudo_asm_macro".
*/

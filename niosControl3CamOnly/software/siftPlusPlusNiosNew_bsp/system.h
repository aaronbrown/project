/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'cpu_0' in SOPC Builder design 'niosSystemCamControl'
 * SOPC Builder design path: C:/Users/Justin/Documents/eec181/project/niosControl3CamOnly/niosSystemCamControl.sopcinfo
 *
 * Generated: Sat Jun 01 21:24:51 PDT 2013
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x1108820
#define ALT_CPU_CPU_FREQ 100000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x0
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x19
#define ALT_CPU_DCACHE_LINE_SIZE 32
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_DCACHE_SIZE 8192
#define ALT_CPU_EXCEPTION_ADDR 0x1109220
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 100000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 1
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 32
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_ICACHE_SIZE 8192
#define ALT_CPU_INITDA_SUPPORTED
#define ALT_CPU_INST_ADDR_WIDTH 0x19
#define ALT_CPU_NAME "cpu_0"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_RESET_ADDR 0x1109200


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x1108820
#define NIOS2_CPU_FREQ 100000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x0
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x19
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_SIZE 8192
#define NIOS2_EXCEPTION_ADDR 0x1109220
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 1
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_ICACHE_SIZE 8192
#define NIOS2_INITDA_SUPPORTED
#define NIOS2_INST_ADDR_WIDTH 0x19
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_RESET_ADDR 0x1109200


/*
 * Custom instruction macros
 *
 */

#define ALT_CI_ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT_INST(n,A,B) __builtin_custom_inii(ALT_CI_ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT_INST_N+(n&ALT_CI_ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT_INST_N_MASK),(A),(B))
#define ALT_CI_ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT_INST_N 0xfc
#define ALT_CI_ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT_INST_N_MASK ((1<<2)-1)


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID
#define __ALTERA_AVALON_UART
#define __ALTERA_NIOS2
#define __ALTERA_NIOS_CUSTOM_INSTR_FLOATING_POINT
#define __SRAM_16BIT_512K


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "CYCLONEII"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart_0"
#define ALT_STDERR_BASE 0x1109460
#define ALT_STDERR_DEV jtag_uart_0
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart_0"
#define ALT_STDIN_BASE 0x1109460
#define ALT_STDIN_DEV jtag_uart_0
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart_0"
#define ALT_STDOUT_BASE 0x1109460
#define ALT_STDOUT_DEV jtag_uart_0
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "niosSystemCamControl"


/*
 * fp_op_type configuration
 *
 */

#define ALT_MODULE_CLASS_fp_op_type altera_avalon_pio
#define FP_OP_TYPE_BASE 0x1109450
#define FP_OP_TYPE_BIT_CLEARING_EDGE_REGISTER 0
#define FP_OP_TYPE_BIT_MODIFYING_OUTPUT_REGISTER 0
#define FP_OP_TYPE_CAPTURE 0
#define FP_OP_TYPE_DATA_WIDTH 8
#define FP_OP_TYPE_DO_TEST_BENCH_WIRING 0
#define FP_OP_TYPE_DRIVEN_SIM_VALUE 0x0
#define FP_OP_TYPE_EDGE_TYPE "NONE"
#define FP_OP_TYPE_FREQ 100000000u
#define FP_OP_TYPE_HAS_IN 0
#define FP_OP_TYPE_HAS_OUT 1
#define FP_OP_TYPE_HAS_TRI 0
#define FP_OP_TYPE_IRQ -1
#define FP_OP_TYPE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FP_OP_TYPE_IRQ_TYPE "NONE"
#define FP_OP_TYPE_NAME "/dev/fp_op_type"
#define FP_OP_TYPE_RESET_VALUE 0x0
#define FP_OP_TYPE_SPAN 16
#define FP_OP_TYPE_TYPE "altera_avalon_pio"


/*
 * fp_operand configuration
 *
 */

#define ALT_MODULE_CLASS_fp_operand altera_avalon_pio
#define FP_OPERAND_BASE 0x1109430
#define FP_OPERAND_BIT_CLEARING_EDGE_REGISTER 0
#define FP_OPERAND_BIT_MODIFYING_OUTPUT_REGISTER 0
#define FP_OPERAND_CAPTURE 0
#define FP_OPERAND_DATA_WIDTH 32
#define FP_OPERAND_DO_TEST_BENCH_WIRING 0
#define FP_OPERAND_DRIVEN_SIM_VALUE 0x0
#define FP_OPERAND_EDGE_TYPE "NONE"
#define FP_OPERAND_FREQ 100000000u
#define FP_OPERAND_HAS_IN 0
#define FP_OPERAND_HAS_OUT 1
#define FP_OPERAND_HAS_TRI 0
#define FP_OPERAND_IRQ -1
#define FP_OPERAND_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FP_OPERAND_IRQ_TYPE "NONE"
#define FP_OPERAND_NAME "/dev/fp_operand"
#define FP_OPERAND_RESET_VALUE 0x0
#define FP_OPERAND_SPAN 16
#define FP_OPERAND_TYPE "altera_avalon_pio"


/*
 * fp_result configuration
 *
 */

#define ALT_MODULE_CLASS_fp_result altera_avalon_pio
#define FP_RESULT_BASE 0x1109440
#define FP_RESULT_BIT_CLEARING_EDGE_REGISTER 0
#define FP_RESULT_BIT_MODIFYING_OUTPUT_REGISTER 0
#define FP_RESULT_CAPTURE 0
#define FP_RESULT_DATA_WIDTH 32
#define FP_RESULT_DO_TEST_BENCH_WIRING 0
#define FP_RESULT_DRIVEN_SIM_VALUE 0x0
#define FP_RESULT_EDGE_TYPE "NONE"
#define FP_RESULT_FREQ 100000000u
#define FP_RESULT_HAS_IN 1
#define FP_RESULT_HAS_OUT 0
#define FP_RESULT_HAS_TRI 0
#define FP_RESULT_IRQ -1
#define FP_RESULT_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FP_RESULT_IRQ_TYPE "NONE"
#define FP_RESULT_NAME "/dev/fp_result"
#define FP_RESULT_RESET_VALUE 0x0
#define FP_RESULT_SPAN 16
#define FP_RESULT_TYPE "altera_avalon_pio"


/*
 * hal configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart_0 configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart_0 altera_avalon_jtag_uart
#define JTAG_UART_0_BASE 0x1109460
#define JTAG_UART_0_IRQ 0
#define JTAG_UART_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_0_NAME "/dev/jtag_uart_0"
#define JTAG_UART_0_READ_DEPTH 64
#define JTAG_UART_0_READ_THRESHOLD 8
#define JTAG_UART_0_SPAN 8
#define JTAG_UART_0_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_0_WRITE_DEPTH 64
#define JTAG_UART_0_WRITE_THRESHOLD 8


/*
 * onchip_cache configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_cache altera_avalon_onchip_memory2
#define ONCHIP_CACHE_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_CACHE_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_CACHE_BASE 0x1104000
#define ONCHIP_CACHE_CONTENTS_INFO ""
#define ONCHIP_CACHE_DUAL_PORT 0
#define ONCHIP_CACHE_GUI_RAM_BLOCK_TYPE "Automatic"
#define ONCHIP_CACHE_INIT_CONTENTS_FILE "onchip_cache"
#define ONCHIP_CACHE_INIT_MEM_CONTENT 1
#define ONCHIP_CACHE_INSTANCE_ID "NONE"
#define ONCHIP_CACHE_IRQ -1
#define ONCHIP_CACHE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_CACHE_NAME "/dev/onchip_cache"
#define ONCHIP_CACHE_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_CACHE_RAM_BLOCK_TYPE "Auto"
#define ONCHIP_CACHE_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_CACHE_SINGLE_CLOCK_OP 0
#define ONCHIP_CACHE_SIZE_MULTIPLE 1
#define ONCHIP_CACHE_SIZE_VALUE 16384u
#define ONCHIP_CACHE_SPAN 16384
#define ONCHIP_CACHE_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_CACHE_WRITABLE 1


/*
 * onchip_reset_and_exception configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_reset_and_exception altera_avalon_onchip_memory2
#define ONCHIP_RESET_AND_EXCEPTION_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_RESET_AND_EXCEPTION_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_RESET_AND_EXCEPTION_BASE 0x1109200
#define ONCHIP_RESET_AND_EXCEPTION_CONTENTS_INFO ""
#define ONCHIP_RESET_AND_EXCEPTION_DUAL_PORT 0
#define ONCHIP_RESET_AND_EXCEPTION_GUI_RAM_BLOCK_TYPE "Automatic"
#define ONCHIP_RESET_AND_EXCEPTION_INIT_CONTENTS_FILE "onchip_reset_and_exception"
#define ONCHIP_RESET_AND_EXCEPTION_INIT_MEM_CONTENT 1
#define ONCHIP_RESET_AND_EXCEPTION_INSTANCE_ID "NONE"
#define ONCHIP_RESET_AND_EXCEPTION_IRQ -1
#define ONCHIP_RESET_AND_EXCEPTION_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_RESET_AND_EXCEPTION_NAME "/dev/onchip_reset_and_exception"
#define ONCHIP_RESET_AND_EXCEPTION_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_RESET_AND_EXCEPTION_RAM_BLOCK_TYPE "Auto"
#define ONCHIP_RESET_AND_EXCEPTION_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_RESET_AND_EXCEPTION_SINGLE_CLOCK_OP 0
#define ONCHIP_RESET_AND_EXCEPTION_SIZE_MULTIPLE 1
#define ONCHIP_RESET_AND_EXCEPTION_SIZE_VALUE 512u
#define ONCHIP_RESET_AND_EXCEPTION_SPAN 512
#define ONCHIP_RESET_AND_EXCEPTION_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_RESET_AND_EXCEPTION_WRITABLE 1


/*
 * procHasControl configuration
 *
 */

#define ALT_MODULE_CLASS_procHasControl altera_avalon_pio
#define PROCHASCONTROL_BASE 0x1109420
#define PROCHASCONTROL_BIT_CLEARING_EDGE_REGISTER 0
#define PROCHASCONTROL_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PROCHASCONTROL_CAPTURE 0
#define PROCHASCONTROL_DATA_WIDTH 1
#define PROCHASCONTROL_DO_TEST_BENCH_WIRING 0
#define PROCHASCONTROL_DRIVEN_SIM_VALUE 0x0
#define PROCHASCONTROL_EDGE_TYPE "NONE"
#define PROCHASCONTROL_FREQ 100000000u
#define PROCHASCONTROL_HAS_IN 0
#define PROCHASCONTROL_HAS_OUT 1
#define PROCHASCONTROL_HAS_TRI 0
#define PROCHASCONTROL_IRQ -1
#define PROCHASCONTROL_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PROCHASCONTROL_IRQ_TYPE "NONE"
#define PROCHASCONTROL_NAME "/dev/procHasControl"
#define PROCHASCONTROL_RESET_VALUE 0x0
#define PROCHASCONTROL_SPAN 16
#define PROCHASCONTROL_TYPE "altera_avalon_pio"


/*
 * sdram_0 configuration
 *
 */

#define ALT_MODULE_CLASS_sdram_0 altera_avalon_new_sdram_controller
#define SDRAM_0_BASE 0x800000
#define SDRAM_0_CAS_LATENCY 3
#define SDRAM_0_CONTENTS_INFO ""
#define SDRAM_0_INIT_NOP_DELAY 0.0
#define SDRAM_0_INIT_REFRESH_COMMANDS 2
#define SDRAM_0_IRQ -1
#define SDRAM_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_0_IS_INITIALIZED 1
#define SDRAM_0_NAME "/dev/sdram_0"
#define SDRAM_0_POWERUP_DELAY 100.0
#define SDRAM_0_REFRESH_PERIOD 15.625
#define SDRAM_0_REGISTER_DATA_IN 1
#define SDRAM_0_SDRAM_ADDR_WIDTH 0x16
#define SDRAM_0_SDRAM_BANK_WIDTH 2
#define SDRAM_0_SDRAM_COL_WIDTH 8
#define SDRAM_0_SDRAM_DATA_WIDTH 16
#define SDRAM_0_SDRAM_NUM_BANKS 4
#define SDRAM_0_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_0_SDRAM_ROW_WIDTH 12
#define SDRAM_0_SHARED_DATA 0
#define SDRAM_0_SIM_MODEL_BASE 0
#define SDRAM_0_SPAN 8388608
#define SDRAM_0_STARVATION_INDICATOR 0
#define SDRAM_0_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_0_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_0_T_AC 5.5
#define SDRAM_0_T_MRD 3
#define SDRAM_0_T_RCD 20.0
#define SDRAM_0_T_RFC 70.0
#define SDRAM_0_T_RP 20.0
#define SDRAM_0_T_WR 14.0


/*
 * sram_16bit_512k_0 configuration
 *
 */

#define ALT_MODULE_CLASS_sram_16bit_512k_0 sram_16bit_512k
#define SRAM_16BIT_512K_0_BASE 0x1080000
#define SRAM_16BIT_512K_0_IRQ -1
#define SRAM_16BIT_512K_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SRAM_16BIT_512K_0_NAME "/dev/sram_16bit_512k_0"
#define SRAM_16BIT_512K_0_SPAN 524288
#define SRAM_16BIT_512K_0_TYPE "sram_16bit_512k"


/*
 * sysid configuration
 *
 */

#define ALT_MODULE_CLASS_sysid altera_avalon_sysid
#define SYSID_BASE 0x1109468
#define SYSID_ID 0u
#define SYSID_IRQ -1
#define SYSID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_NAME "/dev/sysid"
#define SYSID_SPAN 8
#define SYSID_TIMESTAMP 1370140082u
#define SYSID_TYPE "altera_avalon_sysid"


/*
 * uart_0 configuration
 *
 */

#define ALT_MODULE_CLASS_uart_0 altera_avalon_uart
#define UART_0_BASE 0x1109400
#define UART_0_BAUD 115200
#define UART_0_DATA_BITS 8
#define UART_0_FIXED_BAUD 1
#define UART_0_FREQ 100000000u
#define UART_0_IRQ 1
#define UART_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define UART_0_NAME "/dev/uart_0"
#define UART_0_PARITY 'N'
#define UART_0_SIM_CHAR_STREAM ""
#define UART_0_SIM_TRUE_BAUD 0
#define UART_0_SPAN 32
#define UART_0_STOP_BITS 1
#define UART_0_SYNC_REG_DEPTH 2
#define UART_0_TYPE "altera_avalon_uart"
#define UART_0_USE_CTS_RTS 0
#define UART_0_USE_EOP_REGISTER 0

#endif /* __SYSTEM_H_ */

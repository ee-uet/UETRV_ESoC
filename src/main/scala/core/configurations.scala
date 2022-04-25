/*********************************************************************
 * Filename :    Configurations.scala
 * Date     :    28-03-2020
 * Author   :    Muhammad Tahir
 *
 * Description:  Global configurations file.
*********************************************************************/

package UETRV_ECore

import chisel3._
import chisel3.util.log2Ceil


trait Config {
  // Path to executable for pre-initializing instruction memory for testing purpose
  val imem_init_file = "src/test/resources/main.txt"
  val bmem_init_file = "src/test/resources/bootloader.txt"

  // Global config parameters
  val BLEN           = 8
  val HLEN           = 16
  val BUSW           = 16
  val WLEN           = 32
  val XLEN           = 32
  val INST_MEM_LEN   = 2048    // Memory size in words (1024 words = 4096 Bytes)
  val IMEM_SIZE      = log2Ceil(INST_MEM_LEN)-2      // 512 words
  val REG_LEN        = 5
  val REGFILE_LEN    = 32
  val OPCODE_LEN     = 7
  val DATA_MEM_LEN   = 2048     // Memory size in bytes and is word addressable
  val DMEM_SIZE      = log2Ceil(DATA_MEM_LEN)-2     // 256 words
  val BOOT_MEM_LEN   = 1024    // Memory size in bytes and is byte addressable


  // Bit widths for different control signals
  val REG_WRITE_SIG_LEN      = 1
  val ALU_SRC_SIG_LEN       = 1
  val ALUOP_SIG_LEN         = 4
  val MEM_WRITE_SIG_LEN     = 1
  val MEM_READ_SIG_LEN      = 1
  val STORE_SIZE_SIG_LEN    = 2
  val LOAD_TYPE_SIG_LEN     = 3

  // Wishbone related
  val WB_SEL_SIZE           = 4
  val WB_IMEM_ADDR_LOW      = 12
  val WB_IMEM_ADDR_HIGH     = 15
  val WB_DMEM_ADDR_LOW      = 12
  val WB_DMEM_ADDR_HIGH     = 15
  val WB_UART_ADDR_LOW      = 12
  val WB_UART_ADDR_HIGH     = 15
  val WB_SPI_ADDR_LOW       = 12
  val WB_SPI_ADDR_HIGH      = 15
  val WB_MOTOR_ADDR_LOW     = 12
  val WB_MOTOR_ADDR_HIGH    = 15

  // Boot memory related
  val BMEM_ADDR_LOW         = 12
  val BMEM_ADDR_HIGH        = 15
  val BMEM_BASE             = 7

  // Instruction memory relted
  val IMEM_ADDR_LOW      = 12
  val IMEM_ADDR_HIGH     = 15

}


object CONSTANTS {
  val Y        = true.B
  val N        = false.B

  // Program counter and exception vector values at reset
  val PC_START = 0x7000
  val PC_EVEC  = 0x09  // vectored interrupt handling by default (mode = 1)

  // pc_sel
  val PC_4     = 0.U(2.W)
  val PC_ALU   = 1.U(2.W)
  val PC_0     = 2.U(2.W)
  val PC_EPC   = 3.U(2.W)

  // A_sel
  val A_XXX    = 0.U(1.W)
  val A_PC     = 0.U(1.W)
  val A_RS1    = 1.U(1.W)

  // B_sel
  val B_XXX    = 0.U(1.W)
  val B_IMM    = 0.U(1.W)
  val B_RS2    = 1.U(1.W)

  // imm_sel
  val IMM_X    = 0.U(3.W)
  val IMM_I    = 1.U(3.W)
  val IMM_S    = 2.U(3.W)
  val IMM_U    = 3.U(3.W)
  val IMM_J    = 4.U(3.W)
  val IMM_B    = 5.U(3.W)
  val IMM_Z    = 6.U(3.W)

  // br_type
  val BR_XXX   = 0.U(3.W)
  val BR_LTU   = 1.U(3.W)
  val BR_LT    = 2.U(3.W)
  val BR_EQ    = 3.U(3.W)
  val BR_GEU   = 4.U(3.W)
  val BR_GE    = 5.U(3.W)
  val BR_NE    = 6.U(3.W)

  // st_type
  val ST_XXX   = 0.U(2.W)
  val ST_SW    = 1.U(2.W)
  val ST_SH    = 2.U(2.W)
  val ST_SB    = 3.U(2.W)

  // ld_type
  val LD_XXX   = 0.U(3.W)
  val LD_LW    = 1.U(3.W)
  val LD_LH    = 2.U(3.W)
  val LD_LB    = 3.U(3.W)
  val LD_LHU   = 4.U(3.W)
  val LD_LBU   = 5.U(3.W)

  // wb_sel
  val WB_ALU   = 0.U(2.W)
  val WB_MEM   = 1.U(2.W)
  val WB_PC4   = 2.U(2.W)
  val WB_CSR   = 3.U(2.W)

  val WB_WORD_SEL     = 0xF.U(4.W)
  val WB_HW_LOW_SEL   = 0x3.U(4.W)
  val WB_HW_HIGH_SEL  = 0xC.U(4.W)
  val WB_BYTE0_SEL    = 0x1.U(4.W)
  val WB_BYTE1_SEL    = 0x2.U(4.W)
  val WB_BYTE2_SEL    = 0x4.U(4.W)
  val WB_BYTE3_SEL    = 0x8.U(4.W)
}



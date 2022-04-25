/*********************************************************************
 * Filename :    Control.scala
 * Date     :    28-03-2020
 * Author   :    Muhammad Tahir
 *
 * Description:  Added support to handle load-use hazards and to avoid
 *               unnecessary NOPs to improve performance. Derived
 *               from riscv mini.
*********************************************************************/

package UETRV_ECore

import chisel3._
import chisel3.util.ListLookup

import Instructions._
import ALUOP._
import CSR._
import CONSTANTS._


object Control {

  val default =
    //                                                            kill                        wb_en  illegal?  en_rs2
    //            pc_sel  A_sel   B_sel  imm_sel   alu_op   br_type |  st_type ld_type wb_sel  | csr_cmd | en_rs1 |
    //              |       |       |     |          |          |   |     |       |       |    |  |      |  |    |
             List(PC_4,   A_XXX,  B_XXX, IMM_X, ALU_XXX   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, N, CSR.Z, Y, N,   N)
  val map = Array(
    LUI   -> List(PC_4  , A_PC,   B_IMM, IMM_U, ALU_COPY_B, BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, N,   N),
    AUIPC -> List(PC_4  , A_PC,   B_IMM, IMM_U, ALU_ADD   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, N,   N),
    JAL   -> List(PC_ALU, A_PC,   B_IMM, IMM_J, ALU_ADD   , BR_XXX, Y, ST_XXX, LD_XXX, WB_PC4, Y, CSR.Z, N, N,   N),
    JALR  -> List(PC_ALU, A_RS1,  B_IMM, IMM_I, ALU_ADD   , BR_XXX, Y, ST_XXX, LD_XXX, WB_PC4, Y, CSR.Z, N, Y,   N),

    BEQ   -> List(PC_4  , A_PC,   B_IMM, IMM_B, ALU_ADD   , BR_EQ , N, ST_XXX, LD_XXX, WB_ALU, N, CSR.Z, N, Y,   Y),
    BNE   -> List(PC_4  , A_PC,   B_IMM, IMM_B, ALU_ADD   , BR_NE , N, ST_XXX, LD_XXX, WB_ALU, N, CSR.Z, N, Y,   Y),
    BLT   -> List(PC_4  , A_PC,   B_IMM, IMM_B, ALU_ADD   , BR_LT , N, ST_XXX, LD_XXX, WB_ALU, N, CSR.Z, N, Y,   Y),
    BGE   -> List(PC_4  , A_PC,   B_IMM, IMM_B, ALU_ADD   , BR_GE , N, ST_XXX, LD_XXX, WB_ALU, N, CSR.Z, N, Y,   Y),
    BLTU  -> List(PC_4  , A_PC,   B_IMM, IMM_B, ALU_ADD   , BR_LTU, N, ST_XXX, LD_XXX, WB_ALU, N, CSR.Z, N, Y,   Y),
    BGEU  -> List(PC_4  , A_PC,   B_IMM, IMM_B, ALU_ADD   , BR_GEU, N, ST_XXX, LD_XXX, WB_ALU, N, CSR.Z, N, Y,   Y),

    LB    -> List(PC_4  , A_RS1,  B_IMM, IMM_I, ALU_ADD   , BR_XXX, N, ST_XXX, LD_LB , WB_MEM, Y, CSR.Z, N, Y,   N),
    LH    -> List(PC_4  , A_RS1,  B_IMM, IMM_I, ALU_ADD   , BR_XXX, N, ST_XXX, LD_LH , WB_MEM, Y, CSR.Z, N, Y,   N),
    LW    -> List(PC_4  , A_RS1,  B_IMM, IMM_I, ALU_ADD   , BR_XXX, N, ST_XXX, LD_LW , WB_MEM, Y, CSR.Z, N, Y,   N),
    LBU   -> List(PC_4  , A_RS1,  B_IMM, IMM_I, ALU_ADD   , BR_XXX, N, ST_XXX, LD_LBU, WB_MEM, Y, CSR.Z, N, Y,   N),
    LHU   -> List(PC_4  , A_RS1,  B_IMM, IMM_I, ALU_ADD   , BR_XXX, N, ST_XXX, LD_LHU, WB_MEM, Y, CSR.Z, N, Y,   N),
    SB    -> List(PC_4  , A_RS1,  B_IMM, IMM_S, ALU_ADD   , BR_XXX, N, ST_SB , LD_XXX, WB_ALU, N, CSR.Z, N, Y,   Y),
    SH    -> List(PC_4  , A_RS1,  B_IMM, IMM_S, ALU_ADD   , BR_XXX, N, ST_SH , LD_XXX, WB_ALU, N, CSR.Z, N, Y,   Y),
    SW    -> List(PC_4  , A_RS1,  B_IMM, IMM_S, ALU_ADD   , BR_XXX, N, ST_SW , LD_XXX, WB_ALU, N, CSR.Z, N, Y,   Y),

    ADDI  -> List(PC_4  , A_RS1,  B_IMM, IMM_I, ALU_ADD   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   N),
    SLTI  -> List(PC_4  , A_RS1,  B_IMM, IMM_I, ALU_SLT   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   N),
    SLTIU -> List(PC_4  , A_RS1,  B_IMM, IMM_I, ALU_SLTU  , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   N),
    XORI  -> List(PC_4  , A_RS1,  B_IMM, IMM_I, ALU_XOR   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   N),
    ORI   -> List(PC_4  , A_RS1,  B_IMM, IMM_I, ALU_OR    , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   N),
    ANDI  -> List(PC_4  , A_RS1,  B_IMM, IMM_I, ALU_AND   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   N),
    SLLI  -> List(PC_4  , A_RS1,  B_IMM, IMM_I, ALU_SLL   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   N),
    SRLI  -> List(PC_4  , A_RS1,  B_IMM, IMM_I, ALU_SRL   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   N),
    SRAI  -> List(PC_4  , A_RS1,  B_IMM, IMM_I, ALU_SRA   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   N),

    ADD   -> List(PC_4  , A_RS1,  B_RS2, IMM_X, ALU_ADD   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   Y),
    SUB   -> List(PC_4  , A_RS1,  B_RS2, IMM_X, ALU_SUB   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   Y),
    SLL   -> List(PC_4  , A_RS1,  B_RS2, IMM_X, ALU_SLL   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   Y),
    SLT   -> List(PC_4  , A_RS1,  B_RS2, IMM_X, ALU_SLT   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   Y),
    SLTU  -> List(PC_4  , A_RS1,  B_RS2, IMM_X, ALU_SLTU  , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   Y),
    XOR   -> List(PC_4  , A_RS1,  B_RS2, IMM_X, ALU_XOR   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   Y),
    SRL   -> List(PC_4  , A_RS1,  B_RS2, IMM_X, ALU_SRL   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   Y),
    SRA   -> List(PC_4  , A_RS1,  B_RS2, IMM_X, ALU_SRA   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   Y),
    OR    -> List(PC_4  , A_RS1,  B_RS2, IMM_X, ALU_OR    , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   Y),
    AND   -> List(PC_4  , A_RS1,  B_RS2, IMM_X, ALU_AND   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, Y, CSR.Z, N, Y,   Y),

    FENCE -> List(PC_4  , A_XXX,  B_XXX, IMM_X, ALU_XXX   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, N, CSR.Z, N, N,   N),
    FENCEI-> List(PC_0  , A_XXX,  B_XXX, IMM_X, ALU_XXX   , BR_XXX, Y, ST_XXX, LD_XXX, WB_ALU, N, CSR.Z, N, N,   N),

    CSRRW -> List(PC_4  , A_RS1,  B_XXX, IMM_X, ALU_COPY_A, BR_XXX, N, ST_XXX, LD_XXX, WB_CSR, Y, CSR.W, N, Y,   N),
    CSRRS -> List(PC_4  , A_RS1,  B_XXX, IMM_X, ALU_COPY_A, BR_XXX, N, ST_XXX, LD_XXX, WB_CSR, Y, CSR.S, N, Y,   N),
    CSRRC -> List(PC_4  , A_RS1,  B_XXX, IMM_X, ALU_COPY_A, BR_XXX, N, ST_XXX, LD_XXX, WB_CSR, Y, CSR.C, N, Y,   N),
    CSRRWI-> List(PC_4  , A_XXX,  B_XXX, IMM_Z, ALU_XXX   , BR_XXX, N, ST_XXX, LD_XXX, WB_CSR, Y, CSR.W, N, N,   N),
    CSRRSI-> List(PC_4  , A_XXX,  B_XXX, IMM_Z, ALU_XXX   , BR_XXX, N, ST_XXX, LD_XXX, WB_CSR, Y, CSR.S, N, N,   N),
    CSRRCI-> List(PC_4  , A_XXX,  B_XXX, IMM_Z, ALU_XXX   , BR_XXX, N, ST_XXX, LD_XXX, WB_CSR, Y, CSR.C, N, N,   N),

    ECALL -> List(PC_4  , A_XXX,  B_XXX, IMM_X, ALU_XXX   , BR_XXX, N, ST_XXX, LD_XXX, WB_CSR, N, CSR.P, N, N,   N),
    EBREAK-> List(PC_4  , A_XXX,  B_XXX, IMM_X, ALU_XXX   , BR_XXX, N, ST_XXX, LD_XXX, WB_CSR, N, CSR.P, N, N,   N),
    MRET  -> List(PC_EPC, A_XXX,  B_XXX, IMM_X, ALU_XXX   , BR_XXX, Y, ST_XXX, LD_XXX, WB_CSR, N, CSR.P, N, N,   N),
    WFI   -> List(PC_4  , A_XXX,  B_XXX, IMM_X, ALU_XXX   , BR_XXX, N, ST_XXX, LD_XXX, WB_ALU, N, CSR.Z, N, N,   N))
}

class Control_SignalsIO extends Bundle with Config {
  val inst       = Input(UInt(XLEN.W))
  val pc_sel     = Output(UInt(2.W))
  val inst_kill  = Output(Bool())
  val a_sel      = Output(UInt(1.W))
  val b_sel      = Output(UInt(1.W))
  val imm_sel    = Output(UInt(3.W))
  val alu_op     = Output(UInt(5.W))
  val br_type    = Output(UInt(3.W))
  val st_type    = Output(UInt(2.W))
  val ld_type    = Output(UInt(3.W))
  val wb_mux_sel = Output(UInt(2.W))
  val wb_en      = Output(Bool())
  val csr_cmd    = Output(UInt(3.W))
  val illegal    = Output(Bool())
  val en_rs1     = Output(Bool())
  val en_rs2     = Output(Bool())
}

class Control extends Module {
  val io = IO(new Control_SignalsIO)
  val ctrlSignals = ListLookup(io.inst, Control.default, Control.map)

  // Control signals for fetch
  io.pc_sel    := ctrlSignals(0)
  io.inst_kill := ctrlSignals(6).toBool 

  // Control signals for execute
  io.a_sel      := ctrlSignals(1)
  io.b_sel      := ctrlSignals(2)
  io.imm_sel    := ctrlSignals(3)
  io.alu_op     := ctrlSignals(4)
  io.br_type    := ctrlSignals(5)
  io.st_type    := ctrlSignals(7)

  // Control signals for write back
  io.ld_type    := ctrlSignals(8)
  io.wb_mux_sel := ctrlSignals(9)
  io.wb_en      := ctrlSignals(10).toBool
  io.csr_cmd    := ctrlSignals(11)
  io.illegal    := ctrlSignals(12)
  io.en_rs1     := ctrlSignals(13)
  io.en_rs2     := ctrlSignals(14)
}


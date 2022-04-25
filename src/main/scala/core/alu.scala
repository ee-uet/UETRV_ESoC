/*********************************************************************
 * Filename :    ALU.scala
 * Date     :    28-03-2020
 *
 * Description:  Basic integer arithmetic implementation.
*********************************************************************/

package UETRV_ECore

import chisel3._
import chisel3.util._
//import chisel3.util.MuxLookup

//import CONSTANTS._
import ALUOP._

object ALUOP {
  // ALU operations, may be expanded in future
  val ALU_ADD    = 0.U(4.W)
  val ALU_SUB    = 1.U(4.W)
  val ALU_AND    = 2.U(4.W)
  val ALU_OR     = 3.U(4.W)
  val ALU_XOR    = 4.U(4.W)
  val ALU_SLT    = 5.U(4.W)
  val ALU_SLL    = 6.U(4.W)
  val ALU_SLTU   = 7.U(4.W)
  val ALU_SRL    = 8.U(4.W)
  val ALU_SRA    = 9.U(4.W)
  val ALU_COPY_A = 10.U(4.W)
  val ALU_COPY_B = 11.U(4.W)
  val ALU_XXX    = 15.U(4.W)
}

class ALU_IO extends Bundle with Config {
  val in_a      = Input(UInt(WLEN.W))
  val in_b      = Input(UInt(WLEN.W))
  val alu_op    = Input(UInt(ALUOP_SIG_LEN.W))
  val out       = Output(UInt(WLEN.W))
  val sum       = Output(UInt(WLEN.W))
}

class ALU extends Module with Config {
  val io = IO(new ALU_IO)

  val sum    = io.in_a + Mux(io.alu_op(0), -io.in_b, io.in_b)
  val cmp    = Mux(io.in_a (XLEN-1) === io.in_b(XLEN-1), sum(XLEN-1),
                   Mux(io.alu_op(1), io.in_b(XLEN-1), io.in_a(XLEN-1)))
  val shamt  = io.in_b(4,0).asUInt
  val shin   = Mux(io.alu_op(3), io.in_a, Reverse(io.in_a))
  val shiftr = (Cat(io.alu_op(0) && shin(XLEN-1), shin).asSInt >> shamt)(XLEN-1, 0)
  val shiftl = Reverse(shiftr)

  val out = 
    Mux(io.alu_op === ALU_ADD || io.alu_op === ALU_SUB, sum,
    Mux(io.alu_op === ALU_SLT || io.alu_op === ALU_SLTU, cmp,
    Mux(io.alu_op === ALU_SRA || io.alu_op === ALU_SRL, shiftr,
    Mux(io.alu_op === ALU_SLL, shiftl,
    Mux(io.alu_op === ALU_AND, (io.in_a & io.in_b),
    Mux(io.alu_op === ALU_OR,  (io.in_a | io.in_b),
    Mux(io.alu_op === ALU_XOR, (io.in_a ^ io.in_b),
    Mux(io.alu_op === ALU_COPY_A, io.in_a, io.in_b))))))))

  io.out := out
  io.sum := sum
}

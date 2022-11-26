/*********************************************************************
 * Filename :    multiplier.scala
 * Date     :    28-03-2020
 * Author   :    Muhammad Tahir
 *
 * Description:  Multiplier module used by the PID controller.
 *********************************************************************/

package MC_Module

import chisel3._
import chisel3.util.Cat

class vedic2IO extends Bundle {
  val a = Input(UInt(2.W))
  val b = Input(UInt(2.W))
  val c = Output(UInt(4.W))

}

class vedic_2x2 extends Module {
 val io = IO(new vedic2IO)

  // Stage 1: Multiplication operations of bits according to vedic logic
  val result0 = io.a(0) & io.b(0)
  val a1b0   = io.a(1) & io.b(0)
  val a0b1   = io.a(0) & io.b(1)
  val a1b1   = io.a(1) & io.b(1)

  // Stage 2: Two half adders
  val result1 = a1b0 ^ a0b1
  val carry1   = a1b0 & a0b1

  val result2 = a1b1 ^ carry1
  val result3 = a1b1 & carry1

  io.c        := Cat(result3, result2, result1, result0)
}

class vedic4IO extends Bundle {
  val a = Input(UInt(4.W))
  val b = Input(UInt(4.W))
  val c = Output(UInt(8.W))
}

class vedic_4x4 extends Module {
  val io      = IO(new vedic4IO)

  val pp_ll      = Wire(UInt(4.W))  // partial product (low_bits x low_bits)
  val pp_hl      = Wire(UInt(4.W))  // partial product (high_bits x low_bits)
  val pp_lh      = Wire(UInt(4.W))  // partial product (low_bits x high_bits)
  val pp_hh      = Wire(UInt(4.W))  // partial product (high_bits x high_bits)

  val psum_1      = Wire(UInt(4.W))
  val psum_2      = Wire(UInt(6.W))
  val psum_3      = Wire(UInt(6.W))

    // Using 4 2x2 multipliers
  val pp_1      = Module(new vedic_2x2)
  pp_1.io.a     := io.a(1,0)
  pp_1.io.b     := io.b(1,0)
  pp_ll          := pp_1.io.c

  val pp_2      = Module(new vedic_2x2)
  pp_2.io.a     := io.a(3,2)
  pp_2.io.b     := io.b(1,0)
  pp_hl          := pp_2.io.c
  val pp_3      = Module(new vedic_2x2)
  pp_3.io.a     := io.a(1,0)
  pp_3.io.b     := io.b(3,2)
  pp_lh          := pp_3.io.c

  val pp_4      = Module(new vedic_2x2)
  pp_4.io.a     := io.a(3,2)
  pp_4.io.b     := io.b(3,2)
  pp_hh         := pp_4.io.c

  // stage 1 and 2 adders
  psum_1        := pp_hl(3,0) + Cat("b0".U(2.W), pp_ll(3,2).asUInt)
  psum_2        := Cat(pp_hh(3,0).asUInt, "b0".U(2.W)) + Cat("b0".U(2.W), pp_lh(3,0))
  psum_3        := Cat("b0".U(2.W), psum_1(3,0).asUInt) + psum_2 // final output assignment

  val result1 = pp_ll(1,0)
  val result2 = psum_3(5,0)

  io.c        := Cat(result2, result1)
}

class vedic8IO_signed extends Bundle {
  val a = Input(SInt(9.W))
  val b = Input(UInt(8.W))
  val c = Output(SInt(16.W))
}

class vedic_8x8_signed extends Module {
  val io = IO(new vedic8IO_signed)

  val pp_ll             = Wire(UInt(16.W))
  val pp_hl             = Wire(UInt(16.W))
  val pp_lh             = Wire(UInt(16.W))
  val pp_hh             = Wire(UInt(16.W))

  val psum_1                = Wire(UInt(8.W))
  val psum_2                = Wire(UInt(12.W))
  val psum_3                = Wire(UInt(12.W))

  val in1_complement    = (~io.a).asUInt() + 1.U
  val input1            = Mux(io.a(8), in1_complement(7,0), io.a(7,0).asUInt())

  // using 4 2x2 multipliers
  val pp_1                = Module(new vedic_4x4) // using 4 2x2 multipliers

  pp_1.io.a               := input1(3,0)
  pp_1.io.b               := io.b(3,0)
  pp_ll                 := pp_1.io.c
  val pp_2                = Module(new vedic_4x4)
  pp_2.io.a               := input1(7,4)
  pp_2.io.b               := io.b(3,0)
  pp_hl                 := pp_2.io.c
  val pp_3                = Module(new vedic_4x4)
  pp_3.io.a               := input1(3,0)
  pp_3.io.b               := io.b(7,4)
  pp_lh                 := pp_3.io.c
  val pp_4                = Module(new vedic_4x4)
  pp_4.io.a               := input1(7,4)
  pp_4.io.b               := io.b(7,4)
  pp_hh                 := pp_4.io.c

  // Stage 1 and 2 adders
  psum_1       := pp_hl(7,0) + Cat("b0".U(4.W), pp_ll(7,4).asUInt)
  psum_2       := Cat(pp_hh(7,0).asUInt, "b0".U(4.W)) + Cat("b0".U(4.W), pp_lh(7,0))
  psum_3       := Cat("b0".U(4.W), psum_1(7,0).asUInt) + psum_2 // final output assignment

  val result1   = pp_ll(3,0)
  val result2   = psum_3(11,0)

  val result            = Cat(result2, result1)
  val result_complement = (~result).asSInt() + 1.S

  val result_final      = Mux(io.a(8), result_complement, result.asSInt())

  io.c                  := result_final
}

class vedic8IO extends Bundle {
  val a = Input(UInt(8.W))
  val b = Input(UInt(8.W))
  val c = Output(UInt(16.W))
}

class vedic_8x8 extends Module {
  val io = IO(new vedic8IO)

  val pp_ll     = Wire(UInt(16.W))
  val pp_hl     = Wire(UInt(16.W))
  val pp_lh     = Wire(UInt(16.W))
  val pp_hh     = Wire(UInt(16.W))

  val psum_1     = Wire(UInt(8.W))
  val psum_2     = Wire(UInt(12.W))
  val psum_3     = Wire(UInt(12.W))

  val input1 = io.a(7,0)

  // using 4 2x2 multipliers
  val pp_1     = Module(new vedic_4x4) // using 4 2x2 multipliers
  pp_1.io.a    := input1(3,0)
  pp_1.io.b    := io.b(3,0)
  pp_ll         := pp_1.io.c

  val pp_2     = Module(new vedic_4x4)
  pp_2.io.a    := input1(7,4)
  pp_2.io.b    := io.b(3,0)
  pp_hl         := pp_2.io.c

  val pp_3     = Module(new vedic_4x4)
  pp_3.io.a    := input1(3,0)
  pp_3.io.b    := io.b(7,4)
  pp_lh         := pp_3.io.c

  val pp_4     = Module(new vedic_4x4)
  pp_4.io.a    := input1(7,4)
  pp_4.io.b    := io.b(7,4)
  pp_hh         := pp_4.io.c


  // stage 1 and 2 adders
  psum_1         := pp_hl(7,0) + Cat("b0".U(4.W), pp_ll(7,4).asUInt)
  psum_2         := Cat(pp_hh(7,0).asUInt, "b0".U(4.W)) + Cat("b0".U(4.W), pp_lh(7,0))
  psum_3         := Cat("b0".U(4.W), psum_1(7,0).asUInt) + psum_2 // final output assignment

  val result1 = pp_ll(3,0)
  val result2 = psum_3(11,0)
  val op_final = Cat(result2, result1)

  io.c        := op_final
}

class vedic16IO extends Bundle {
  val a = Input(SInt(16.W))
  val b = Input(UInt(16.W))
  val c = Output(SInt(32.W))
}

class vedic_16x16 extends Module {
  val io = IO(new vedic16IO)

  val pp_ll             = Wire(UInt(16.W))
  val pp_hl             = Wire(UInt(16.W))
  val pp_lh             = Wire(UInt(16.W))
  val pp_hh             = Wire(UInt(16.W))

  val psum_1             = Wire(UInt(16.W))
  val psum_2             = Wire(UInt(24.W))
  val psum_3             = Wire(UInt(24.W))

  val in1_complement = (~io.a).asUInt() + 1.U
  val input1         = Mux(io.a(15), in1_complement(15,0), io.a(15,0).asUInt())

  // using 4 8x8 multipliers
  val pp_1             = Module(new vedic_8x8) // using 4 8x8 multipliers
  pp_1.io.a            := input1(7,0)
  pp_1.io.b            := io.b(7,0)
  pp_ll                 := pp_1.io.c

  val pp_2             = Module(new vedic_8x8)
  pp_2.io.a            := input1(15,8)
  pp_2.io.b            := io.b(7,0)
  pp_hl                 := pp_2.io.c

  val pp_3             = Module(new vedic_8x8)
  pp_3.io.a            := input1(7,0)
  pp_3.io.b            := io.b(15,8)
  pp_lh                 := pp_3.io.c

  val pp_4             = Module(new vedic_4x4)
  pp_4.io.a            := input1(15,8)
  pp_4.io.b            := io.b(15,8)
  pp_hh                 := pp_4.io.c

  // stage 1 and 2 adders
  psum_1     := pp_hl(15,0) + Cat("b0".U(8.W), pp_ll(15,8).asUInt)
  psum_2     := Cat(pp_hh(15,0).asUInt, "b0".U(8.W)) + Cat("b0".U(8.W), pp_lh(15,0))
  psum_3     := Cat("b0".U(8.W), psum_1(15,0).asUInt)  + psum_2 // final output assignment

  val result1        = pp_ll(7,0)
  val result2        = psum_3(23,0)
  val result         = Cat(result2, result1)
  val result_complement = (~result).asSInt() + 1.S

  val result_final   = Mux(io.a(15), result_complement, result.asSInt())
  io.c               := result_final
}


/*********************************************************************
 * Filename :    csr.scala
 * Date     :    28-03-2020
 * Author   :    Muhammad Tahir
 *
 * Description:  Conforms to Privileged Spec. 1.11 and supports machine
 *               mode only. Current implementation is an extension of
 *               riscv mini. Added support for external interrupts along
 *               with vectored interrupts.
*********************************************************************/

package UETRV_ECore

import chisel3._
import chisel3.util._

import CONSTANTS._

// MT -- interrupt exception cause definitions
object Cause {
  val CAUSE_WIDTH         = 30
  val InstAddrMisaligned  = 0x0.U(CAUSE_WIDTH.W)
  val IllegalInst         = 0x2.U(CAUSE_WIDTH.W)
  val Breakpoint          = 0x3.U(CAUSE_WIDTH.W)
  val LoadAddrMisaligned  = 0x4.U(CAUSE_WIDTH.W)
  val StoreAddrMisaligned = 0x6.U(CAUSE_WIDTH.W)
  val mEcall              = 0x8.U(CAUSE_WIDTH.W)
  val mSoftware           = 0x3.U(CAUSE_WIDTH.W)
  val mTimer              = 0x7.U(CAUSE_WIDTH.W)
  val mExternal           = 0xB.U(CAUSE_WIDTH.W)
  val mUart               = 0x10.U(CAUSE_WIDTH.W)   // MT -- defined for testing, should be >= 0x10
  val mSpi                = 0x11.U(CAUSE_WIDTH.W)
  val mMotor1             = 0x12.U(CAUSE_WIDTH.W)
  val mMotor2             = 0x13.U(CAUSE_WIDTH.W)
  val mMotor3             = 0x14.U(CAUSE_WIDTH.W)
}

object CSR {
  val Z          = 0.U(3.W)
  val W          = 1.U(3.W)
  val S          = 2.U(3.W)
  val C          = 3.U(3.W)
  val P          = 4.U(3.W)

  // MT -- Supports machine mode. User mode only executes the user code and does not
  // service user mode interrupt requests (see Standard extension N for user mode interrupts)
  val PRV_U      = 0x0.U(2.W)
  val PRV_M      = 0x3.U(2.W)

  // MT -- All the registers with CSR address bits(11:10) set, are read only registers
  val CYCLE      = 0xC00.U(12.W)
  val TIME       = 0xC01.U(12.W)
  val INSTRET    = 0xC02.U(12.W)
  val CYCLEH     = 0xC80.U(12.W)
  val TIMEH      = 0xC81.U(12.W)
  val INSTRETH   = 0xC82.U(12.W)

  /* Machine-level CSR address definitions */
  // machine information registers (read only)
  val MVENDORID  = 0xF11.U(12.W)
  val MARCHID    = 0xF12.U(12.W)
  val MIMPID     = 0xF13.U(12.W)
  val MHARTID    = 0xF14.U(12.W)

  // Machine trap setup related address definitions. Interrupt/exception delegation is not supported
  val MSTATUS    = 0x300.U(12.W)
  val MISA       = 0x301.U(12.W)
  val MIE        = 0x304.U(12.W)
  val MTVEC      = 0x305.U(12.W)

  // Machine trap handling related register address definitions
  val MSCRATCH   = 0x340.U(12.W)
  val MEPC       = 0x341.U(12.W)
  val MCAUSE     = 0x342.U(12.W)
  val MTVAL      = 0x343.U(12.W)
  val MIP        = 0x344.U(12.W)

  // Machine time (timer) is required to be implemented as memory mapped
}

// MT -- IO interfaces for class CSR
class CSRIO extends Bundle with Config {
  val stall      = Input(Bool())
  val cmd        = Input(UInt(3.W))
  val in         = Input(UInt(XLEN.W))
  val out        = Output(UInt(XLEN.W))
  // Exception related IOs
  val pc         = Input(UInt(XLEN.W))
  val addr       = Input(UInt(XLEN.W))
  val inst       = Input(UInt(XLEN.W))
  val illegal    = Input(Bool())
  val st_type    = Input(UInt(2.W))
  val ld_type    = Input(UInt(3.W))
  val pc_check   = Input(Bool())
  val expt       = Output(Bool())
  val evec       = Output(UInt(XLEN.W))
  val epc        = Output(UInt(XLEN.W))
  // MT -- added support for external interrupts using bit 16 and above of mip/mie registers
  val irq        = new IrqIO

  // MT added to fix the exception and conditional branch occuring at the same time
  val br_taken      = Input(Bool())
}

class CSR extends Module with Config {
  val io         = IO(new CSRIO)
  val stall_csr  = io.stall
  val csr_addr   = io.inst(31, 20)
  val rs1_addr   = io.inst(19, 15)

  /* User mode time/counters registers */
  val time       = RegInit(0.U(XLEN.W))
  val timeh      = RegInit(0.U(XLEN.W))
  val cycle      = RegInit(0.U(XLEN.W))
  val cycleh     = RegInit(0.U(XLEN.W))
  val instret    = RegInit(0.U(XLEN.W))
  val instreth   = RegInit(0.U(XLEN.W))

  /* MT -- Machine mode register definitions and initializations */
  // readonly registers
  val mvendorid  = 0.U(XLEN.W)   // should be updated with the finalized vendor ID
  val marchid    = 0.U(XLEN.W)   // not implemented
  val mimpid     = 0.U(XLEN.W)   // not implemented
  val mhartid    = 0.U(XLEN.W)   // only one hart, not implemented

  /* MT -- currently MLEN = 32 and RV32I based ISA is supported. This register is
  readonly in the current implementation */
  val misa       = (0x40000100.U(XLEN.W))

  // MT -- the bitfield definitions for the following three registers are in CSRdefs.scala
  val mstatus    = Reg(new MstatusCsr)
  val mie        = Reg(new MieCsr)
  val mip_reg    = Reg(new MipCsr)  // RegInit(MipCsr.default)
  val mip        = RegInit(mip_reg)

  /* MT -- mtvec initialization to default value at reset with vectored interrupt enabled by default (see
     PC_EVEC in Datapath.scala) */
  val mtvec      = RegInit(CONSTANTS.PC_EVEC.U(XLEN.W))

  // MT -- Definitions for other exception/interrupt related registers
  val mscratch   = Reg(Bits(XLEN.W))
  val mepc       = Reg(Bits(XLEN.W))
  val mcause     = Reg(Bits(XLEN.W))
  val mtval      = Reg(Bits(XLEN.W))

  // MT -- configure the critical register fields on reset
  when(reset.asBool)
  {
    mie.motor3ie  := false.B
    mie.motor2ie  := true.B
    mie.motor1ie  := true.B
    mie.spiie    := false.B
    mie.uartie   := true.B
    mstatus.mie  := true.B
    mstatus.prv  := CSR.PRV_M
    mstatus.mpp  := CSR.PRV_M
  }

  // CSR register file
  val csrFile = Seq(
    BitPat(CSR.CYCLE)     -> cycle,
    BitPat(CSR.TIME)      -> time,
    BitPat(CSR.INSTRET)   -> instret,
    BitPat(CSR.CYCLEH)    -> cycleh,
    BitPat(CSR.TIMEH)     -> timeh,
    BitPat(CSR.INSTRETH)  -> instreth,
    BitPat(CSR.MTVEC)     -> mtvec,
    BitPat(CSR.MIE)       -> mie.asUInt,
    BitPat(CSR.MSCRATCH)  -> mscratch,
    BitPat(CSR.MEPC)      -> mepc,
    BitPat(CSR.MCAUSE)    -> mcause,
    BitPat(CSR.MTVAL)     -> mtval,
    BitPat(CSR.MIP)       -> mip.asUInt,
    BitPat(CSR.MSTATUS)   -> mstatus.asUInt,
    BitPat(CSR.MISA)      -> misa
  )

  // reading CSR
  io.out := Lookup(csr_addr, 0.U, csrFile).asUInt

  // MT -- Determine the exception source
  val privValid     = csr_addr(9, 8) <= mstatus.prv
  val privInst      = io.cmd === CSR.P
  val isEcall       = privInst && !csr_addr(0) && !csr_addr(8)
  val isEbreak      = privInst &&  csr_addr(0) && !csr_addr(8)
  val isEret        = privInst && !csr_addr(0) &&  csr_addr(8)
  val iaddrInvalid  = io.pc_check && io.addr(1)
  val laddrInvalid  = MuxLookup(io.ld_type, false.B, Seq(
                                LD_LW -> io.addr(1, 0).orR, LD_LH -> io.addr(0), LD_LHU -> io.addr(0)))
  val saddrInvalid  = MuxLookup(io.st_type, false.B, Seq(
                                ST_SW -> io.addr(1, 0).orR, ST_SH -> io.addr(0)))
  // MT -- Determine the external interrupt source
  val isMotor1      =  mip.motor1ip && mie.motor1ie
  val isMotor2      =  mip.motor2ip && mie.motor2ie
  val isMotor3      =  mip.motor3ip && mie.motor3ie
  val isSpi         =  mip.spiip  && mie.spiie
  val isUart        =  mip.uartip  && mie.uartie
  val isTimer       =  mip.mtip    && mie.mtie
  val isExternal    =  mip.meip    && mie.meie
  val isSoftware    =  mip.msip    && mie.msie

  // MT -- Determine whether CSR address is valid, is it readonly (RO) and if write to CSR is requested
  val csrValid      = csrFile map (_._1 === csr_addr) reduce (_ || _)
  val csrRO         = csr_addr(11, 10).andR
  val wen           = io.cmd === CSR.W || io.cmd(1) && rs1_addr.orR
  val wdata         = MuxLookup(io.cmd, 0.U, Seq( CSR.W -> io.in,
                                                  CSR.S -> (io.out | io.in),
                                                  CSR.C -> (io.out & ~io.in)))

  // MT -- determine the cause of exceptions
  val causeExpt = Mux(iaddrInvalid, Cause.InstAddrMisaligned,
                  Mux(laddrInvalid, Cause.LoadAddrMisaligned,
                  Mux(saddrInvalid, Cause.StoreAddrMisaligned,
                  Mux(isEcall,      Cause.mEcall + mstatus.prv,
                  Mux(isEbreak,     Cause.Breakpoint, Cause.IllegalInst )))))
  // MT -- determine the cause of interrupts
  val causeInt =  Mux(isSoftware,     Cause.mSoftware,
                  Mux(isExternal,     Cause.mExternal,
                  Mux(isTimer,        Cause.mTimer,
                  Mux(isUart,         Cause.mUart,
                  Mux(isSpi,          Cause.mSpi,
                  Mux(isMotor1,       Cause.mMotor1,
                  Mux(isMotor2,       Cause.mMotor2, Cause.mMotor3 )))))))

  // MT -- finalizing the cause as interrupt or exception
  val isInt      = (isMotor1 || isMotor2 || isMotor3 || isSpi || isUart || isTimer || isExternal || isSoftware) && mstatus.mie
  val cause      = Mux(isInt, causeInt, causeExpt)

  // MT -- vectored interrupt handling
  val base       = mtvec >> 2 << 2
  val mode       = mtvec(1, 0)
  io.evec        := Mux(isInt && mode(0), base + (cause << 2) , base)

  // MT -- extended for external interrupts using 'isInt' signal. Rest are exceptions
  io.expt        := (io.illegal || iaddrInvalid || laddrInvalid || saddrInvalid ||
                     io.cmd(1, 0).orR && (!csrValid || !privValid) || wen && csrRO ||
                     (privInst && !privValid) || isEcall || isEbreak || isInt)
  io.epc         := mepc

  // MT -- Updating time/count registers (64 bit)
  time           := time + 1.U
  when(time.andR) {
    timeh        := timeh + 1.U }

  cycle          := cycle + 1.U
  when(cycle.andR) {
    cycleh       := cycleh + 1.U }

  val isInstRet  = io.inst =/= Instructions.NOP && (!io.expt || isEcall || isEbreak) && !stall_csr

  when(isInstRet) {
    instret      := instret + 1.U }

  when(isInstRet && instret.andR) {
    instreth     := instreth + 1.U }

  // MT -- resolve interrupt tailing. This happens while returning from an interrupt service routine,
  // another interrupt is already pending.
  val wasEret     = RegInit(false.B)
  wasEret         := isEret

  // Exception handling when a conditional branching was in progress
  val br_taken          = Reg(Bool())
  val br_taken_delayed  = Reg(Bool())
  br_taken             := io.br_taken
  br_taken_delayed     := br_taken

  when(!stall_csr) {
    when(io.expt) {
      // MT -- mepc is not updated in case of tailing interrupt, this happens when a new interrupt
      // request (from any source) is pending while returning from an ISR corresponding to a previous
      // interrupt.
      when(!wasEret)
      { mepc         := (Mux(br_taken_delayed, io.pc - 4.U, io.pc)) >> 2 << 2 }

      // MT -- updated to Privilege Spec. 1.11
      mcause         := Cat(Mux(isInt, true.B, false.B), false.B, cause)
      mstatus.prv    := CSR.PRV_M
      mstatus.mie    := false.B
      mstatus.mpp    := mstatus.prv
      mstatus.mpie   := mstatus.mie
      when(iaddrInvalid || laddrInvalid || saddrInvalid) { mtval := io.addr }
    }.elsewhen(isEret) {
      mstatus.prv    := mstatus.mpp
      mstatus.mie    := mstatus.mpie
      mstatus.mpp    := CSR.PRV_M
      mstatus.mpie   := true.B
    }.elsewhen(wen) {
      when(csr_addr === CSR.MSTATUS) {
        mstatus.mpp  := wdata(12, 11)
        mstatus.mpie := wdata(7)
        mstatus.prv  := wdata(24, 23)
        mstatus.mie  := wdata(3)
      }
      .elsewhen(csr_addr === CSR.MIP) {
        mip.motor3ip := wdata(20)
        mip.motor2ip := wdata(19)
        mip.motor1ip := wdata(18)
        mip.spiip    := wdata(17)
        mip.uartip   := wdata(16)
        mip.mtip     := wdata(7)
        mip.msip     := wdata(3)
      }
      .elsewhen(csr_addr === CSR.MIE) {
        mie.motor3ie := wdata(20)
        mie.motor2ie := wdata(19)
        mie.motor1ie := wdata(18)
        mie.spiie    := wdata(17)
        mie.uartie   := wdata(16)
        mie.mtie     := wdata(7)
        mie.msie     := wdata(3)
      }
      .elsewhen(csr_addr === CSR.MTVEC) { mtvec := wdata }
      .elsewhen(csr_addr === CSR.MSCRATCH) { mscratch := wdata }
      .elsewhen(csr_addr === CSR.MEPC) { mepc := wdata >> 2.U << 2.U }
      .elsewhen(csr_addr === CSR.MCAUSE) { mcause := wdata & (BigInt(1) << (XLEN-1) | 0xf).U } // MT -- to be done
      .elsewhen(csr_addr === CSR.MTVAL) { mtval := wdata }
    }
    // MT -- Make sure external interrupts be connected to appropriate mip register bit-fields
    mip.uartip      := io.irq.uart_irq    // Uart external interrupt
    mip.spiip       := io.irq.spi_irq     // SPI external interrupt
    mip.motor1ip    := io.irq.m1_irq      // Motor M1 external interrupt
    mip.motor2ip    := io.irq.m2_irq      // Motor M2 external interrupt
    mip.motor3ip    := io.irq.m3_irq      // Motor M3 external interrupt
    // MT -- Connect other external interrupts here
  }
}

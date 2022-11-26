/******************************************************************************
 * Filename :   pipeline.scala
 * Date     :   28-03-2020
 * Author   :   Muhammad Tahir
 *
 * Description: Modified cache memory interfaces to simple Inst/Data memory
 *              interfaces, resolved load-use hazards by stalling and added
 *              support for external interrupts
 *
 * 5-05-2020    The load operation loads data in a temporary register 'ld_data'
 *              at the start of cycle 3 of pipelined operation and is loaded to
 *              register file at the start of cycle 4. There is one cycle
 *              pipeline stall for load instructions in case of load use hazard.
 *******************************************************************************/

package UETRV_ECore

import chisel3._
import chisel3.util._

import CONSTANTS._
import CSR._

class DatapathIO extends Bundle {
 // val debug      = new DebugIO
  val irq        = new IrqIO
  val ibus       = Flipped(new IBusIO)
  val dbus       = Flipped(new DBusIO)
  val ctrl       = Flipped(new Control_SignalsIO)
}

class Datapath extends Module with Config {
  val io         = IO(new DatapathIO)
  val csr        = Module(new CSR)
  val reg_file   = Module(new RegFile)
  val alu        = Module(new ALU)
  val gen_imm    = Module(new Imm)
  val cond_br    = Module(new Branch)


  /***** Fetch / Execute Registers *****/
  val fet_exe_inst  = RegInit(Instructions.NOP)
  val fet_exe_pc    = Reg(UInt())

  /***** Execute / Write Back Registers *****/
  val exe_wb_inst      = RegInit(Instructions.NOP)
  val exe_wb_pc        = Reg(UInt())
  val exe_wb_alu       = Reg(UInt())
  val csr_in           = Reg(UInt())

  /********** Control signals *********/
  val ctrl_st_type     = Reg(io.ctrl.st_type.cloneType)
  val ctrl_ld_type     = Reg(io.ctrl.ld_type.cloneType)
  val ctrl_wb_mux_sel  = Reg(io.ctrl.wb_mux_sel.cloneType)
  val ctrl_wb_en       = Reg(Bool())
  val ctrl_csr_cmd     = Reg(io.ctrl.csr_cmd.cloneType)
  val ctrl_illegal     = Reg(Bool())
  val ctrl_pc_check    = Reg(Bool())
 
  /****** Fetch *****/
  val notstarted = RegNext(reset.asBool)
  // MT stall is used to stall the pipeline due to load-use hazard or dbus/ibus delayed ack
  val stall      = WireInit(false.B)
  val pc         = RegInit(CONSTANTS.PC_START.U(XLEN.W) - 4.U(XLEN.W))
  val npc        = WireInit(0.U(XLEN.W))
  npc           := Mux(stall || !io.ibus.valid , pc, Mux(csr.io.expt, csr.io.evec,
                   Mux(io.ctrl.pc_sel === PC_EPC,  csr.io.epc,
                   Mux(io.ctrl.pc_sel === PC_ALU || cond_br.io.br_taken, alu.io.sum >> 1.U << 1.U,
                   Mux(io.ctrl.pc_sel === PC_0, pc, pc + 4.U)))))

  // MT -- verify the use of "io.ibus.valid" here to insert NOP
  val inst       = Mux(notstarted || io.ctrl.inst_kill || cond_br.io.br_taken || csr.io.expt || !io.ibus.valid,
                       Instructions.NOP, io.ibus.inst)
  pc             := npc
  io.ibus.addr   := npc  // address for next instruction fetch from instruction memory

 
  // Pipelining
  // updating fetch-execute pipeline registers
  when (!stall) {
    fet_exe_pc    := Mux((io.ctrl.inst_kill || cond_br.io.br_taken || csr.io.expt), fet_exe_pc, pc)
    fet_exe_inst  := inst
  }

  /********** Decode and execute stage ***********/
  // Decoding the instruction
  io.ctrl.inst       := fet_exe_inst

  // Reading the register file
  val rd_addr         = fet_exe_inst(11, 7)
  val rs1_addr        = fet_exe_inst(19, 15)
  val rs2_addr        = fet_exe_inst(24, 20)
  reg_file.io.raddr_1 := rs1_addr
  reg_file.io.raddr_2 := rs2_addr

  // Generate immediate value for execution
  gen_imm.io.inst    := fet_exe_inst
  gen_imm.io.imm_sel     := io.ctrl.imm_sel

  /*********** Hazard detection, forwarding and stalling of the pipeline **********/
  // Hazard detection
  val wrbk_rd_addr   = exe_wb_inst(11, 7)
  val rs1hazard      = ctrl_wb_en && rs1_addr.orR && (rs1_addr === wrbk_rd_addr)
  val rs2hazard      = ctrl_wb_en && rs2_addr.orR && (rs2_addr === wrbk_rd_addr)

  // Forwarding to resolve RAW hazard
  val rs1            = Mux(ctrl_wb_mux_sel === WB_ALU && rs1hazard, exe_wb_alu, reg_file.io.rdata_1)
  val rs2            = Mux(ctrl_wb_mux_sel === WB_ALU && rs2hazard, exe_wb_alu, reg_file.io.rdata_2)

  // MT -- load-use and CSRs hazard detection. The pipeline is stalled since the hazard can not be resolved using
  // forwarding/bypassing
  val hazard_stall   = WireInit(false.B)
  hazard_stall       := (ctrl_ld_type.orR || ctrl_csr_cmd =/= CSR.Z) && ((io.ctrl.en_rs1 && rs1hazard) || (io.ctrl.en_rs2 && rs2hazard))

  // MT -- read valid is asserted on receiving ack_i from dmem (wishbone slave i.e. io.dmem.valid),
  // when a read operation (ld_type.orR) was performed
  val is_load_store  = ctrl_ld_type.orR || ctrl_st_type.orR
  val dmem_stall     = WireInit(false.B)
  dmem_stall         := !((io.dbus.valid && is_load_store) || !is_load_store)
  stall              := hazard_stall || dmem_stall

  // MT -- stall during Load-use hazard while performing a data memory store operation
  io.dbus.wr_en      := Mux(hazard_stall, ST_XXX.orR, io.ctrl.st_type.orR)
  io.dbus.st_type    := io.ctrl.st_type

  // Executing the operation
  alu.io.in_a        := Mux(io.ctrl.a_sel === A_RS1, rs1, fet_exe_pc)
  alu.io.in_b        := Mux(io.ctrl.b_sel === B_RS2, rs2, gen_imm.io.imm_out)
  alu.io.alu_op      := io.ctrl.alu_op

  // Branch condition calculation
  cond_br.io.in_a     := rs1
  cond_br.io.in_b     := rs2
  cond_br.io.br_type := io.ctrl.br_type

  /*********  Data bus load store operations using LS module  **********/
  val lsu = Module(new LS_Unit)

  // Store operation using data bus
  lsu.io.lsu_st_type  := io.ctrl.st_type
  lsu.io.lsu_wdata_in := rs2
  io.dbus.wdata       := lsu.io.lsu_wdata_out

  //  Load operation using data bus
  io.dbus.rd_en       := io.ctrl.ld_type.orR
  io.dbus.ld_type     := io.ctrl.ld_type
  lsu.io.lsu_ld_type  := ctrl_ld_type
  lsu.io.lsu_rdata_in := io.dbus.rdata
  val dbus_rdata      = lsu.io.lsu_rdata_out

  // Data bus address updation
  io.dbus.addr        := alu.io.sum

  /**************   Stall and exception handling of the pipeline ************/
  // MT Pipelining control signals updation for exception/interrupt, stall and normal conditions
  // MT -- TO DO -- what if we have stall and exception simultaneously?
  when(reset.asBool || !stall && csr.io.expt) {
    ctrl_st_type      := 0.U
    ctrl_ld_type      := 0.U
    ctrl_wb_en        := false.B
    ctrl_csr_cmd      := 0.U
    ctrl_illegal      := false.B
    ctrl_pc_check     := false.B
  }.elsewhen(!stall && !csr.io.expt) {
    // updating execute-writeback pipeline registers
    exe_wb_pc         := fet_exe_pc
    exe_wb_inst       := fet_exe_inst
    exe_wb_alu        := alu.io.out
    // updating control signals for writeback stage
    csr_in            := Mux(io.ctrl.imm_sel === IMM_Z, gen_imm.io.imm_out, rs1)
    ctrl_st_type      := io.ctrl.st_type
    ctrl_ld_type      := io.ctrl.ld_type
    ctrl_wb_mux_sel   := io.ctrl.wb_mux_sel
    ctrl_wb_en        := io.ctrl.wb_en
    ctrl_csr_cmd      := io.ctrl.csr_cmd
    ctrl_illegal      := io.ctrl.illegal
    ctrl_pc_check     := io.ctrl.pc_sel === PC_ALU
  }.elsewhen(hazard_stall) {  // MT (&& !csr.io.expt) removed from condition to handle simultaneous stall and csr.io.expt conditions
    // MT clearing wirteback signals to stop stalled instruction from updating register-files and memory, rather
    // they will be updated in the next cycle with correct data from the preceding instruction (which was the
    // source of stalling)
    ctrl_st_type      := ST_XXX
    ctrl_ld_type      := LD_XXX
    ctrl_wb_en        := false.B
    ctrl_csr_cmd      := CSR.Z
  }

  /************** Integrating CSRs to the datapath  *************/
  // CSR access
  csr.io.stall     := stall
  csr.io.in        := csr_in
  csr.io.cmd       := ctrl_csr_cmd
  csr.io.inst      := exe_wb_inst
  csr.io.pc        := exe_wb_pc
  csr.io.addr      := exe_wb_alu
  csr.io.illegal   := ctrl_illegal
  csr.io.pc_check  := ctrl_pc_check
  csr.io.ld_type   := ctrl_ld_type
  csr.io.st_type   := ctrl_st_type
  csr.io.br_taken  := cond_br.io.br_taken

  // MT Added support for external interrupts (IRQs)
  csr.io.irq       <> io.irq


 /********** Write back to the register file at stage 3 of pipeline *********/
  // Write to the register file
  val reg_file_wdata = MuxLookup(ctrl_wb_mux_sel, exe_wb_alu.zext,
                           Seq( WB_MEM -> dbus_rdata,
                                WB_PC4 -> (exe_wb_pc + 4.U).zext,
                                WB_CSR -> csr.io.out.zext) ).asUInt

  reg_file.io.wen    := ctrl_wb_en && !csr.io.expt
  reg_file.io.waddr  := wrbk_rd_addr
  reg_file.io.wdata  := reg_file_wdata

}




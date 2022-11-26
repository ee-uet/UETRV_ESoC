/******************************************************************************
 * Filename :    wb_interconnect.scala
 * Date     :    2-03-2021
 * Author   :    Muhammad Tahir
 *
 * Description:  Wishbone shared bus interface standard (ver. B4) based
 *               implementation.
 *
 *
 * 21-05-2021    Current implementation supports single master and only
 *               pipelined Read/Write operations.
 *******************************************************************************/

package wishbone

import chisel3._
import chisel3.util._
import UETRV_ECore.{CONSTANTS, Config, DBusIO, IBusIO}
import memories.{DMem_Interface, IMem_Interface}
import uart.UART
import spi.SPI
import MC_Module.{MotorGPIO, Motor_Top}


object WB_InterConnect {
  // Address mapping for wishbone slaves
  val IMEM     = 0x0.U(4.W)
  val DMEM     = 0x1.U(4.W)
  val UART     = 0x2.U(4.W)
  val SPI      = 0x3.U(4.W)
  val MOTOR1   = 0x4.U(4.W)
  val MOTOR2    = 0x5.U(4.W)
  val MOTOR3    = 0x6.U(4.W)
}

class WB_InterConnectIO extends Bundle {
  val dbus     = new DBusIO
  val ibus     = new IBusIO

  // Uart input/output signals
  val uart_tx   = Output(Bool())
  val uart_rx   = Input(Bool())
  val uart_irq  = Output(Bool())

  // SPI input/output signals
  val spi_cs     = Output(Bool())
  val spi_clk    = Output(Bool())
  val spi_mosi   = Output(Bool())
  val spi_miso   = Input(Bool())
  val spi_irq    = Output(Bool())

  // Motor module IO signals
  val m1_io      = new MotorGPIO
  val m2_io      = new MotorGPIO
  val m3_io      = new MotorGPIO

  val m1_irq     = Output(Bool())
  val m2_irq     = Output(Bool())
  val m3_irq     = Output(Bool())
}

class WB_InterConnect extends Module with Config {
  val io = IO(new WB_InterConnectIO)

  val dmem     = Module(new DMem_Interface)
  val imem     = Module(new IMem_Interface)
  val wbm_dbus = Module(new WBM_DBus)
  val uart     = Module(new UART)
  val spi      = Module(new SPI)
  val m1       = Module(new Motor_Top)
  val m2       = Module(new Motor_Top)
  val m3       = Module(new Motor_Top)

  // Inst/Data Memory interface for Processor Core
  wbm_dbus.io.dbus <> io.dbus
  imem.io.ibus     <> io.ibus

  // partial address decoding for the connected slaves
  val address          = wbm_dbus.io.wbm.m2s.addr(WB_IMEM_ADDR_HIGH, WB_IMEM_ADDR_LOW)
  val imem_addr_match  = address  === WB_InterConnect.IMEM
  val dmem_addr_match  = address  === WB_InterConnect.DMEM
  val uart_addr_match  = address  === WB_InterConnect.UART
  val spi_addr_match   = address  === WB_InterConnect.SPI
  val m1_addr_match    = address  === WB_InterConnect.MOTOR1
  val m2_addr_match    = address  === WB_InterConnect.MOTOR2
  val m3_addr_match    = address  === WB_InterConnect.MOTOR3

  // MT -- connect Data RAM to core using Wishbone shared bus interface
  dmem.io.wbs.m2s  <> wbm_dbus.io.wbm.m2s

  // MT -- connect Inst. Memory to core using Wishbone shared bus interface for reading constant and NOT instructions.
  // Instructions are read using dedicated IMemIO interface
  imem.io.wbs.m2s  <> wbm_dbus.io.wbm.m2s

  // Uart WB peripheral interface
  uart.io.wbs.m2s  <> wbm_dbus.io.wbm.m2s

  // SPI WB peripheral partial interface connection
  spi.io.wbs.m2s  <> wbm_dbus.io.wbm.m2s

  // Motor WB peripheral interface
  m1.io.wbs.m2s <> wbm_dbus.io.wbm.m2s
  m2.io.wbs.m2s <> wbm_dbus.io.wbm.m2s
  m3.io.wbs.m2s <> wbm_dbus.io.wbm.m2s

  // MT -- Data read Mux when reading data from one of the slaves
  val imem_sel  = Reg(Bool())
  val dmem_sel  = Reg(Bool())
  val uart_sel  = Reg(Bool())
  val spi_sel   = Reg(Bool())
  val m1_sel    = Reg(Bool())
  val m2_sel    = Reg(Bool())
  val m3_sel    = Reg(Bool())

  imem_sel  := imem_addr_match && imem.io.wbs.m2s.stb
  dmem_sel  := dmem_addr_match &&  dmem.io.wbs.m2s.stb   // MT  && !dmem.io.wbs.we_i
  uart_sel  := uart_addr_match &&  uart.io.wbs.m2s.stb   // MT  && !uart.io.wbs.we_i
  spi_sel   := spi_addr_match   &&  spi.io.wbs.m2s.stb   // MT  && !spi.io.wbs.we_i
  m1_sel    := m1_addr_match &&  m1.io.wbs.m2s.stb
  m2_sel    := m2_addr_match &&  m2.io.wbs.m2s.stb
  m3_sel    := m3_addr_match &&  m3.io.wbs.m2s.stb

  wbm_dbus.io.wbm.data_i := Mux(dmem_sel, dmem.io.wbs.data_o,
                               Mux(imem_sel, imem.io.wbs.data_o,
                                 Mux(uart_sel, uart.io.wbs.data_o,
                                   Mux(spi_sel, spi.io.wbs.data_o,
                                     Mux(m1_sel, m1.io.wbs.data_o,
                                       Mux(m2_sel, m2.io.wbs.data_o,
                                         Mux(m3_sel, m3.io.wbs.data_o, 0.U)))))))
  wbm_dbus.io.wbm.ack_i  := Mux(dmem_sel, dmem.io.wbs.ack_o,
                               Mux(imem_sel, imem.io.wbs.ack_o,
                                 Mux(uart_sel, uart.io.wbs.ack_o,
                                   Mux(spi_sel, spi.io.wbs.ack_o,
                                     Mux(m1_sel, m1.io.wbs.ack_o,
                                       Mux(m2_sel, m2.io.wbs.ack_o,
                                         Mux(m3_sel, m3.io.wbs.ack_o, 0.U)))))))


  // UART IO connectivity
  uart.io.uart_select  := uart_addr_match
  uart.io.rxd          := io.uart_rx
  io.uart_tx           := uart.io.txd
  io.uart_irq          := uart.io.uartInt

  // SPI IO connectivity
  spi.io.spi_select    := spi_addr_match
  spi.io.spi_miso      := io.spi_miso
  io.spi_cs            := spi.io.spi_cs
  io.spi_clk           := spi.io.spi_clk
  io.spi_mosi          := spi.io.spi_mosi
  io.spi_irq           := spi.io.spi_intr

  // Motor IO connectivity
  m1.io.motor_gpio     <> io.m1_io
  m1.io.motor_select   := m1_addr_match
  io.m1_irq            := m1.io.motor_irq

  m2.io.motor_gpio     <> io.m2_io
  m2.io.motor_select   := m2_addr_match
  io.m2_irq            := m2.io.motor_irq

  m3.io.motor_gpio     <> io.m3_io
  m3.io.motor_select   := m3_addr_match
  io.m3_irq            := m3.io.motor_irq
}

/*********************************************************************
 * Filename :    soc_tile.scala
 * Date     :    28-03-2020
 * Author   :    Muhammad Tahir
 *
 * Description:  Top module for the SoC integrating the processor core
 *               with the memories and peripherals (Uart, Motor Control,
 *               etc.).
 *
 * 13-04-2020    The DebugIO interface can be used for testing.
*********************************************************************/


package UETRV_ECore

import chisel3._
import MC_Module.MotorGPIO
import wishbone.WB_InterConnect

class TileIO extends Bundle {
 // val debug     = new DebugIO

  // UART IO interface
  val uart_tx   = Output(Bool())
  val uart_rx   = Input(Bool())

  // SPI IO interface
  val spi_cs   = Output(Bool())
  val spi_clk   = Output(Bool())
  val spi_mosi   = Output(Bool())
  val spi_miso   = Input(Bool())

  // Motor modules IO signals
  val m1_io       = new MotorGPIO
  val m2_io       = new MotorGPIO
  val m3_io       = new MotorGPIO

}

trait Tile_Base extends chisel3.experimental.BaseModule {
  def io: TileIO
  def clock: Clock
  def reset: Reset
}

class SoC_Tile extends Module with Tile_Base {
  val io               = IO(new TileIO)
  val core             = Module(new Core)
  val wb_inter_connect = Module(new WB_InterConnect)
 
 // io.debug             <> core.io.debug
  core.io.ibus         <> wb_inter_connect.io.ibus
  core.io.dbus         <> wb_inter_connect.io.dbus

  // Connection for UART interface
  io.uart_tx                   := wb_inter_connect.io.uart_tx
  wb_inter_connect.io.uart_rx  := io.uart_rx
  core.io.irq.uart_irq         := wb_inter_connect.io.uart_irq

  // Connection for SPI interface
  io.spi_cs                    := wb_inter_connect.io.spi_cs
  io.spi_clk                   := wb_inter_connect.io.spi_clk
  io.spi_mosi                  := wb_inter_connect.io.spi_mosi
  wb_inter_connect.io.spi_miso := io.spi_miso
  core.io.irq.spi_irq          := wb_inter_connect.io.spi_irq

  // Connection for Motor interface
  io.m1_io <> wb_inter_connect.io.m1_io
  io.m2_io <> wb_inter_connect.io.m2_io
  io.m3_io <> wb_inter_connect.io.m3_io

  // MT: Assigned separate IRQ to each motor
  core.io.irq.m1_irq := wb_inter_connect.io.m1_irq
  core.io.irq.m2_irq := wb_inter_connect.io.m2_irq
  core.io.irq.m3_irq := wb_inter_connect.io.m3_irq
}

object SoC_Tile_Driver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new SoC_Tile, Array("--target-dir", "rtl/"))
}


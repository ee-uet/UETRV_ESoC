
.equ CSR_MSTATUS, 0x300
.equ MSTATUS_MIE, 0x00000008
.equ CSR_MTVEC,   0x305


 # Main interrupt vector table entries.

.global vtable
.type vtable, %object
.section .vector_table,"a",%progbits
 # this entry is to align reset_handler at address 0x04
  .word 0x00000013        
  j        reset_handler
  .align 2
vtable:
# Assembly 'reset handler' function to initialize core CPU registers.
.section .text.default_interrupt_handler,"ax",%progbits

.global reset_handler
.type reset_handler,@function

reset_handler:
# set mstatus.MIE=1 (enable M mode interrupt)
#  li      t0, 8
#  csrrs   zero, CSR_MSTATUS, t0

# Load the initial stack pointer value.
  la   sp, _sp

# Set the vector table's base address.
#  la   a0, vtable
#  addi a0, a0, 1
#  csrw CSR_MTVEC, a0

# Call user 'main(0,0)' (.data/.bss sections initialized there)
  li   a0, 0
  li   a1, 0
  call main

# A 'default' interrupt handler, in case an interrupt triggers without its handler defined
#default_interrupt_handler:
#  j default_interrupt_handler

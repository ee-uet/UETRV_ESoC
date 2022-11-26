# RISC-V Interrupt Service Routines (ISRs) 
# ALL supported ISRs should be put here

.section .text.isr

# Uart interrupt handler
.globl uart_handler
uart_handler:
  addi   sp,sp,-16
  sw	 a5,4(sp)
  sw	 a4,8(sp)
  sw	 ra,12(sp)
  call   UART_Isr
  lw	 ra,12(sp)
  lw	 a4,8(sp)  
  lw	 a5,4(sp)
  addi   sp,sp,16
  mret
  nop
  nop

# Stepper motor PWM interrupt handler
.globl stepper_motor_pwm_handler
stepper_motor_pwm_handler:
  addi   sp,sp,-16
  sw	 a5,4(sp)
  sw	 a4,8(sp)
  sw	 ra,12(sp)
  call   Stepper_Motor_PWM_Isr
  lw	 ra,12(sp)
  lw	 a4,8(sp)  
  lw	 a5,4(sp)
  addi   sp,sp,16
  mret
  nop
  nop



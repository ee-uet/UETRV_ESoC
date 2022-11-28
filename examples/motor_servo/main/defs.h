
#ifndef DEFS_H
#define DEFS_H


// Defines related to motor module
#define MOTOR_PWM_CFG_R        *(volatile char *)(0x4000)
#define MOTOR_PWM_RELOAD_R     *(volatile int  *)(0x4004)
#define MOTOR_PWM_DUTY_R       *(volatile int  *)(0x400C)


#define MOTOR_PID_REF_CFG_R    *(volatile int  *)(0x420C)
#define MOTOR_SPEED_VAL_R      *(volatile int  *)(0x4104)

#define MOTOR_SPEED_HIGH       20
#define MOTOR_SPEED_LOW        10

void Motor_Speed(char speed_cmd);
void Speed_Display(void);

#endif
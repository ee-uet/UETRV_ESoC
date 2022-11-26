
#ifndef DEFS_H
#define DEFS_H


// Defines related to motor module
#define MOTOR_PWM_CFG_R        *(volatile char *)(0x4000)
#define MOTOR_PWM_RELOAD_R     *(volatile int  *)(0x4004)
#define MOTOR_PWM_DUTY_R       *(volatile int  *)(0x400C)
#define MOTOR_PID_REF_CFG_R    *(volatile int  *)(0x420C)
#define MOTOR_SPEED_VAL_R      *(volatile int  *)(0x4104)

#define MOTOR_STEP_CFG_R       *(volatile int  *)(0x5010)

#define MOTOR2_PWM_CFG_R        *(volatile char *)(0x5000)
#define MOTOR2_PWM_RELOAD_R     *(volatile int  *)(0x5004)
#define MOTOR2_PWM_DUTY_R       *(volatile int  *)(0x500C)
#define MOTOR2_PID_REF_CFG_R    *(volatile int  *)(0x520C)
#define MOTOR2_SPEED_VAL_R      *(volatile int  *)(0x5104)

#define MOTOR3_PWM_CFG_R        *(volatile char *)(0x6000)
#define MOTOR3_PWM_RELOAD_R     *(volatile int  *)(0x6004)
#define MOTOR3_PWM_DUTY_R       *(volatile int  *)(0x600C)
#define MOTOR3_PID_REF_CFG_R    *(volatile int  *)(0x620C)
#define MOTOR3_SPEED_VAL_R      *(volatile int  *)(0x6104)


#define MOTOR_SPEED_HIGH       20
#define MOTOR_SPEED_LOW        10

void draw_command(char draw_cmd);
void Speed_Display(void);

#endif

/* ********************************************************************//* 
 * @file   main.c
 * @author M Tahir
 * @brief  Main test application program.
 **************************************************************************/

// Header files
#include <stdint.h>
#include "../interfaces/uart.h"
#include "./defs.h"

// #define len(str)		(sizeof(str)/sizeof(char))
// #define p(str)			(UART_Tx_str(str, len(str)))
#define LIFT				32000
#define DROP				18000
#define PEN_STATE  	MOTOR_PWM_DUTY_R
#define NOT_HOMED_Y (MOTOR_STEP_CFG_R & 0x2)
#define NOT_HOMED_X (MOTOR_STEP_CFG_R & 0x1)
#define dir					MOTOR_STEP_CFG_R
#define UP					0x00
#define DOWN				0x14
#define LEFT				0x04
#define RIGHT				0x10
#define UP_BOUND    2000	// vertical   bound with 1/4 micro-stepping is 4000, but operate in half, out of caution i.e. use 2000 as horizontal bound
#define LEFT_BOUND  3000	// horizontal bound with 1/4 micro-stepping is 6000, but operate in half, out of caution i.e. use 3000 as horizontal bound

// Strings for UART message display 
// const char Message[] = "Hello\n\r";   
// const char Str1[16] = "Motor Speed is: ";
// const char Str2[12] = "Set speed: ";
// const char Str3[4] = "\n\r";
volatile char c;
// volatile int k;
volatile char homed;
volatile short x;
volatile short y;
// volatile short steps;

// void UART_Tx_str(const char *str, int len) {
// 		char z=0;
// 		for(z=0; z < len; z++){
// 			UART_Tx(str[z
// 			+ 8		// jugarh because of unknown bug? data seems to be misplaced by 8 bytes, hence added 8 to the pointer
// 			]);
// 		}
// }

void transmit_position(void) {
	UART_Tx(x);
	UART_Tx(x >> 8);
	UART_Tx(y);
	UART_Tx(y >> 8);
}

void steppers_on(void) {
	MOTOR3_PWM_RELOAD_R = 25000;
	// MOTOR3_PWM_DUTY_R = MOTOR3_PWM_RELOAD_R >> 1;
	MOTOR3_PWM_DUTY_R = 12000;
	MOTOR3_PWM_CFG_R = 0x23;

 	// MOTOR2_PWM_RELOAD_R = 12500;		// period = 1ms
 	MOTOR2_PWM_RELOAD_R = 25000;
	// MOTOR2_PWM_DUTY_R = MOTOR2_PWM_RELOAD_R >> 1;
	MOTOR2_PWM_DUTY_R = 12000;
	// MOTOR2_PWM_CFG_R = 0x23;		// interrupt disabled
	MOTOR2_PWM_CFG_R = 0x27;	// the statement that starts the interrupt is kept at the end of the function
}

void steppers_off(void) {
  MOTOR2_PWM_CFG_R = 0;
  MOTOR3_PWM_CFG_R = 0;
}

void servo(unsigned int pen_state){
	unsigned int old_pen_state;
	old_pen_state = PEN_STATE;

	// PWM configuration

	// Reload register configuration for desired PWM frequency  
	// MOTOR_PWM_RELOAD_R = 0xFFF;
	// MOTOR_PWM_RELOAD_R = 12500000;	// period = 1s
	MOTOR_PWM_RELOAD_R = 250000;	// period = 20ms
	// MOTOR_PWM_DUTY_R = 18000;				// duty cycle for servo position that drops pen
	PEN_STATE = pen_state;		// duty cycle for servo position that lifts pen
	// MOTOR_PWM_CFG_R = 0x27;			// duty cycle of PWM written manually instead of selecting pid module's output
	MOTOR_PWM_CFG_R = 0x23;					// interrupt disabled, and duty cycle of PWM written manually instead of selecting pid module's output

	if (old_pen_state != pen_state) {
		for (int k = 0; k < 1000000; k++);  // wait for pen to be lifted or dropped
	}
}

char main(void)
{
	// declare variables
	// int mduty = 0;
	char z=0;
	// char units,tens;
	homed = 0;
	x = -1;
	y = -1;
	// steps = 1;

	// Initialize UART with desired baudrate
	UART_Init(UART_BAUD_DIV);
	
	c = '0';

	servo(LIFT);	// lift pen; this function includes delay to wait while pen is being lifted (or dropped)
								// the servo(LIFT); statement is manually commented when building code for simulation, to 
								// avoid the delay of approximately 1 s
	
	// homing of stepper motors
  steppers_on();
  dir = DOWN;
  while (NOT_HOMED_Y);
  x = 0;
  dir = RIGHT;
  while (NOT_HOMED_X);
  y = 0;
  steppers_off();

  homed = 1;
  UART_INT_MASK_R = 1;
  transmit_position();	// tell computer we are ready to receive commands

  // for simulation with loopback
  // UART_Tx('l');
  // while (steps);
  // for (int k = 0; k < 10000; k++);
  // UART_Tx('l');

  // measuring plotter length
  // k = 0;
  // dir = LEFT;
  // steppers_on();

	while(1){ 
		// delay
		// for (int k = 0; k < 5000000; k++);
		// for (int k = 0; k < 1000000; k++);
 	  // for (int k = 0; k < 10; k++);

    c++;
    // UART_Tx(c);
	}; 

	return z;
}

void draw_command(char cmd) 
{ 
	switch (cmd) {
		case 'L':	servo(LIFT);	transmit_position();							   break;
		case 'D': servo(DROP);	transmit_position();	               break;
		case 'u': dir = UP;			if (y < UP_BOUND)		 steppers_on();  break;
		case 'd': dir = DOWN; 	if (y > 0) 					 steppers_on();	 break;
		case 'l': dir = LEFT;		if (x < LEFT_BOUND)  steppers_on();	 break;
		case 'r': dir = RIGHT;  if (x > 0) 					 steppers_on();  break;
	}
	
	UART_Tx(cmd);	// loopback for debugging
}

// void Motor_PWM_Isr(void){	// ISR for motor 1's PWM; since it is being used to control servo, no need for its interrupt, hence its interrupt is disabled and ISR not defined
// }

void Stepper_Motor_PWM_Isr(void){

	// measuring plotter length
	// k++;
	// if (k == 3000) steppers_off();

	if (homed) {
		// change coordinates according to direction
		switch (dir & 0x14) {	// take only the two bits representing direction from the step configuration register
			case UP:			y += 1;  break;
			case LEFT:		x += 1;	 break;
			case DOWN:		y -= 1;  break;
			case RIGHT:		x -= 1;  break;
		}
		steppers_off();
		transmit_position();
	}

	// UART_Tx('0');
}

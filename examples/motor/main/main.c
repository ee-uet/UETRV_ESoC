/* ********************************************************************//* 
 * @file   main.c
 * @author M Tahir
 * @brief  Main test application program.
 **************************************************************************/

// Header files
#include <stdint.h>
#include "../interfaces/uart.h"
#include "./defs.h"

// Strings for UART message display 
const char Message[8] = "Hello\n\r";   
const char Str1[16] = "Motor Speed is: ";
const char Str2[12] = "Set speed: ";
const char Str3[4] = "\n\r";


void Motor_Init(void){
	// PWM configuration 
	MOTOR_PWM_CFG_R = 0x2F;
	// Reload register configuration for desired PWM frequency  
	MOTOR_PWM_RELOAD_R = 0xFFF;
} 

char main(void)
{
	// declare variables
	int mduty = 0;
	char z=0;

	// Initialize UART with desired baudrate
	UART_Init(UART_BAUD_DIV);

	// Initialize the motor module
	Motor_Init();

	// Print the "Hello" message at the terminal
	for(z=0; z < 8; z++){
		UART_Tx(Message[z]);
	}
	
	// Display the motor speed and ask the use for 
	// speed selection. 'h' for high speed and 
	// 'l' for low speed
	Speed_Display();
	
  while(1){}; 

	return z;
}

void Speed_Display(void){
	// declare variables
	int mduty = 0;
	char z=0, unit, tens;

	for(z=0; z < 2; z++){
		UART_Tx(Str3[z]);
	}
	
	for(z=0; z < 16; z++){
		UART_Tx(Str1[z]);
	}
	
	// Get the current speed
	mduty = (MOTOR_SPEED_VAL_R) & 0x3F;
	
	// Conversion to BCD
	unit = mduty %10 + '0';
	tens = (mduty /10)%10 + '0';

	UART_Tx(tens);
	UART_Tx(unit);	

	for(z=0; z < 2; z++){
		UART_Tx(Str3[z]);
	}

	for(z=0; z < 11; z++){
		UART_Tx(Str2[z]);
	}
}


void Motor_Speed(char speed_cmd) 
{ 
  if(speed_cmd == 'h'){
		 MOTOR_PID_REF_CFG_R = MOTOR_SPEED_HIGH;
	}
	if(speed_cmd == 'l'){
		 MOTOR_PID_REF_CFG_R = MOTOR_SPEED_LOW;
	}
	
	Speed_Display();
}

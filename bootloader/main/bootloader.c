
/* ********************************************************************//* 
 * @file          bootloader.c
 * @author        M Tahir
 * @brief         UETRV_ECore bootloader.
 **************************************************************************/

// Libraries
#include <stdint.h>
#include "../interfaces/spi.h"
#include "../interfaces/uart.h"
#include "./bootloader.h"


/* ********************************************************************//* 
 * Bootloader main function.
 **************************************************************************/
int main(void) {

  // Initialize UART with desired baudrate
  UART_Init(UART_BAUD_DIV);
  
	// SPI initilization
  SPI_Init(FLASH_CLK_PRSC);

  Transfer_Executable();
	UPRINT_CHAR('O');
	UPRINT_CHAR('k');
	
  Start_App_Program();

  return 0; // bootloader should never return
}

/**********************************************************************//**
 * Start application program execution from the beginning of instruction 
 * memory space.
 **************************************************************************/
void Start_App_Program(void) {

  // Instruction memory base address is 0x0000 (defined by IMEM_BASE_ADDR)
  asm volatile ("  lui t0, 0x0;"
	              "  jr t0;");
  // while (1);
}


/************************************************************************
 * Transfer the executable file to the Instruction Mmeory.
 *
 ***********************************************************************/
void Transfer_Executable(void) {

	  // flash image base address
  uint32_t addr = (uint32_t)SPI_BOOT_BASE_ADDR;
	
	uint32_t *imem_pnt = (uint32_t*)(IMEM_BASE_ADDR); // UETRV32_SYSINFO.ISPACE_BASE
  uint32_t instr_code = 0, i = 0;
  
  // Read the file signature for authentication
  uint32_t signature = Flash_Read_Word(addr);

  // Get the executable image size 
  uint32_t size  = Flash_Read_Word(addr + EXE_OFFSET_SIZE); // Executable size is in bytes

  // Transfer program data
  addr = addr + EXE_OFFSET_DATA;  // Update the address to start data transfer
	
	while (i < (size/4)) {          // Size in words for loop count
    instr_code = Flash_Read_Word(addr);
    imem_pnt[i++] = instr_code;
    addr += 4;
  }

}

/************************************************************************
 * Read word from Flash using the address parameter
 *
 * @param addr Address to access SPI flash.
 * @return 32-bit data word.
 ***********************************************************************/
uint32_t Flash_Read_Word(uint32_t addr) {

  union {
    uint32_t word;
    uint8_t  byte[sizeof(uint32_t)];
  } data;

  uint32_t i;
	
 //	Assert chip select signal
	SPI_CS_EN();

  SPI_Transfer(FLASH_CMD_READ);
  Flash_Write_Addr(addr);
	
	for (i=0; i<4; i++) {
     data.byte[i] = (uint8_t) SPI_Transfer(0);  
  }

 //	De-assert chip select signal
	SPI_CS_DIS();
	
  return data.word;
}


/* ********************************************************************** 
 * Send address to flash memory (address size is three bytes).
 *
 * @param  addr Address word.
 ***********************************************************************/
void Flash_Write_Addr(uint32_t addr) {

  union {
    uint32_t word;
    uint8_t  byte[sizeof(uint32_t)];
  } address;

  address.word = addr;

  int i;
  for (i=2; i>=0; i--) {
    SPI_Transfer(address.byte[i]);
  }
}


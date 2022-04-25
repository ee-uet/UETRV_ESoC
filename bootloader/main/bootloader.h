
/* ---- UART interface configuration ---- */

/*  Set to 0 to disable UART interface */
#ifndef UART_EN
  #define UART_EN 1
#endif


/* ---- SPI configuration ---- */
/*  Enable SPI module */
#ifndef SPI_EN
  #define SPI_EN 1
#endif

/*  SPI flash chip select */
#ifndef FLASH_CS
  #define FLASH_CS 1
#endif

/*  SPI flash sector size in bytes */
#ifndef FLASH_SECTOR_SIZE
  #define FLASH_SECTOR_SIZE 65536 // default = 64kB
#endif

/*  SPI flash clock pre-scaler */
#ifndef FLASH_CLK_PRSC
  #define FLASH_CLK_PRSC  0x8
#endif

/*  SPI flash boot base address */
#ifndef SPI_BOOT_BASE_ADDR
  #define SPI_BOOT_BASE_ADDR 0x00000000
#endif

/*  IMem base address */
#ifndef IMEM_BASE_ADDR
  #define IMEM_BASE_ADDR 0x00000000
#endif



/* ********************************************************************//* 
 * Error codes
 **************************************************************************/
enum ERROR_CODES {
  ERROR_SIGNATURE = 1, /* < 0: Wrong signature in executable */
  ERROR_SIZE      = 2, /* < 1: Insufficient instruction memory capacity */
  ERROR_FLASH     = 3  /* < 3: SPI flash access error */
};


/* ********************************************************************//* 
 * SPI flash memory commands
 **************************************************************************/
enum FLASH_CMD {
  FLASH_CMD_PAGE_PROGRAM = 0x02, /* < Program page */
  FLASH_CMD_READ         = 0x03, /* < Read data */
  FLASH_CMD_READ_STATUS  = 0x05, /* < Get status register */
  FLASH_CMD_WRITE_ENABLE = 0x06, /* < Allow write access */
  FLASH_CMD_READ_ID      = 0x9E, /* < Read manufacturer ID */
  FLASH_CMD_SECTOR_ERASE = 0xD8  /* < Erase complete sector */
};


/* ********************************************************************//* 
 * Address offsets used when transferring the executable
 **************************************************************************/
enum EXECUTABLE_OFFSETS {
  EXE_OFFSET_SIZE      = 4, 
  EXE_OFFSET_DATA      = 8 
};


/* ********************************************************************//* 
 * Valid executable identification signature.
 **************************************************************************/
#define EXE_SIGNATURE 0x55aa33cc


/* ********************************************************************//* 
 * Helper macros
 **************************************************************************/
/*  Print to UART */
#define UPRINT_CHAR(a) UART_Tx(a)

#if (UART_EN != 0)
  #define UPRINT_STRING(...) UETrv32_Uart_Print(__VA_ARGS__)
  
#else
  #define PRINT_TEXT(...)
  #define PRINT_XNUM(a)
  #define PRINT_GETC(a) 0
  #define PRINT_PUTC(a)
#endif

// Function prototypes
void Start_App_Program(void);
void Transfer_Executable(void);
uint32_t Flash_Read_Word(uint32_t addr);
void Flash_Write_Addr(uint32_t addr);




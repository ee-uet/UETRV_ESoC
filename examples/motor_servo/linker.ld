OUTPUT_ARCH( "riscv" )
ENTRY( reset_handler )

MEMORY
{ 
  FLASH_INST (rx) : ORIGIN = 0x00000000, LENGTH = 2K
  FLASH_BOOT (rx) : ORIGIN = 0x00007000, LENGTH = 2K
  RAM       (rwx) : ORIGIN = 0x00001000, LENGTH = 256
}


SECTIONS
{
  __stack_size = DEFINED(__stack_size) ? __stack_size : 100;

  .text :
  {
    KEEP (*(SORT_NONE(.vector_table)))
  } >FLASH_INST 

  .text :
  { *(.text .text.*)
    *(.rodata .rodata.*)  
    *(.srodata .srodata.*)    
  } >FLASH_INST 

  . = ALIGN(4);

  PROVIDE (__etext = .);
  PROVIDE (_etext = .);
  PROVIDE (etext = .);

  _sidata = .;
  .data : AT( _sidata )
  {
    _sdata = .;
    *(.rdata) 
    *(.data .data.*)
    *(.sdata .sdata.*)
    . = ALIGN(4);
    _edata = .;
  } >RAM

  PROVIDE( _edata = . );
  PROVIDE( edata = . );
  PROVIDE( _fbss = . );
  PROVIDE( __bss_start = . );

  .bss :
  {
    _sbss = .;
    *(.sbss*)
    *(.bss .bss.*)
    *(COMMON)
    . = ALIGN(4);
    _ebss = .;
  } >RAM

  . = ALIGN(8);
  PROVIDE( _end = . );
  PROVIDE( end = . );

  .stack ORIGIN(RAM) + LENGTH(RAM) - __stack_size :
  {
    PROVIDE( _heap_end = . ); 
    . = __stack_size;  
    PROVIDE( _sp = . ); 
  } >RAM
}
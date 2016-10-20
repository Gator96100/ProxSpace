/***********************************/
/* NINTENDO E-READER LINKER SCRIPT */
/***********************************/
/* Author  : Tim Schuerewegen      */
/* Version : 1.0                   */
/***********************************/

OUTPUT_FORMAT( "elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
OUTPUT_ARCH( arm)
ENTRY( _start)

SECTIONS
{
	.  = 0x02000000;

	.init :
	{
		*(.init)
		. = ALIGN(4);
	} = 0xff

	.text :
	{
		*(.text)
		. = ALIGN(4);
	} = 0xff

	.rodata :
	{
		*(.rodata)
		. = ALIGN(4);
	} = 0xff

	.data :
	{
		*(.data)
		. = ALIGN(4);
	} = 0xff

	.bss :
	{
		__bss_start = .;
		*(.bss)
		. = ALIGN(4);
		__bss_end__ = ABSOLUTE(.);
		__end__ = ABSOLUTE(.);
	}
}


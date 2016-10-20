/* Linker Script Original v1.3 by Jeff Frohwein     */
/*  v1.0 - Original release                         */
/*  v1.1 - Added proper .data section support       */
/*  v1.2 - Added support for c++ & iwram overlays   */
/*       - Major contributions by Jason Wilkins.    */
/*  v1.3 - .ewram section now can be used when      */
/*         compiling for MULTIBOOT mode. This fixes */
/*         malloc() in DevKitAdvance which depends  */
/*         on __eheap_start instead of end to define*/
/*         the starting location of heap space.     */
/*         External global variable __gba_iwram_heap*/
/*         support added to allow labels end, _end, */
/*         & __end__ to point to end of iwram or    */
/*         the end of ewram.                        */
/*	Additions by WinterMute	               	*/
/* v1.4 -	.sbss section added for unitialised		*/
/*		    data in ewram 							*/
/* v1.5 -	padding section added to stop EZF 		*/
/*		    stripping important data				*/
/* v1.6 -	added memory sections			 		*/

/* This file is released into the public domain		*/
/* for commercial or non-commercial use with no		*/
/* restrictions placed upon it.						*/

/* NOTE!!!: This linker script defines the RAM &  */
/*   ROM start addresses. In order for it to work */
/*   properly, remove -Ttext and -Tbss linker     */
/*   options from your makefile if they are       */
/*   present.                                     */

/* You can use the following to view section      */
/* addresses in your .elf file:                   */
/*   objdump -h file.elf                          */
/* Please note that empty sections may incorrectly*/
/* list the lma address as the vma address for    */
/* some versions of objdump.                      */

OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)

MEMORY {

	rom	: ORIGIN = 0x08000000, LENGTH = 32M
	iwram	: ORIGIN = 0x03000000, LENGTH = 32K
	ewram	: ORIGIN = 0x02000000, LENGTH = 256K
}



__text_start	=	ORIGIN(ewram);
__eheap_end	=	ORIGIN(ewram) + LENGTH(ewram);
__iwram_start	=	ORIGIN(iwram);
__iwram_top	=	ORIGIN(iwram) + LENGTH(iwram);;

__sp_irq	=	__iwram_top - 0x060;
__sp_usr	=	__sp_irq - 0x0a0;
__irq_flags	=	0x03007ff8;

SECTIONS
{
	. = __text_start;
	.init :
	{
		KEEP (*(.init))
		. = ALIGN(4);
	} >ewram =0xff

	.plt :
 	{
		*(.plt)
		. = ALIGN(4);   /* REQUIRED. LD is flaky without it. */
	} >ewram

	.text  ALIGN (4):
	{
		*(EXCLUDE_FILE (*.iwram*) .text)
		*(.text .stub .text.* .gnu.linkonce.t.*)
		KEEP (*(.text.*personality*))
		/* .gnu.warning sections are handled specially by elf32.em.  */
		*(.gnu.warning)
		*(.glue_7t) *(.glue_7) *(.vfp11_veneer)
		. = ALIGN(4);  /* REQUIRED. LD is flaky without it. */
	} >ewram = 0xff

	__text_end = .;
	.fini           :
	{
		KEEP (*(.fini))
		. = ALIGN(4);   /* REQUIRED. LD is flaky without it. */
	} >ewram =0

	.rodata :
	{
		*(.rodata)
		*all.rodata*(*)
		*(.roda)
		*(.rodata.*)
		*(.gnu.linkonce.r*)
		SORT(CONSTRUCTORS)
		. = ALIGN(4);   /* REQUIRED. LD is flaky without it. */
	} >ewram = 0xff

  .ARM.extab   : { *(.ARM.extab* .gnu.linkonce.armextab.*) } >ewram
   __exidx_start = .;
  .ARM.exidx   : { *(.ARM.exidx* .gnu.linkonce.armexidx.*) } >ewram
   __exidx_end = .;
  /* Ensure the __preinit_array_start label is properly aligned.  We
     could instead move the label definition inside the section, but
     the linker would then create the section even if it turns out to
     be empty, which isn't pretty.  */
  . = ALIGN(32 / 8);
  PROVIDE (__preinit_array_start = .);
  .preinit_array     : { KEEP (*(.preinit_array)) } >ewram = 0xff
  PROVIDE (__preinit_array_end = .);
  PROVIDE (__init_array_start = .);
  .init_array     : { KEEP (*(.init_array)) } >ewram = 0xff
  PROVIDE (__init_array_end = .);
  PROVIDE (__fini_array_start = .);
  .fini_array     : { KEEP (*(.fini_array)) } >ewram = 0xff
  PROVIDE (__fini_array_end = .);
	.ctors :
	{
		/*	gcc uses crtbegin.o to find the start of the constructors, so
			we make sure it is first.  Because this is a wildcard, it
			doesn't matter if the user does not actually link against
			crtbegin.o; the linker won't look for a file to match a
			wildcard.  The wildcard also means that it doesn't matter which
			directory crtbegin.o is in.  */
		KEEP (*crtbegin.o(.ctors))
		KEEP (*(EXCLUDE_FILE (*crtend.o) .ctors))
		KEEP (*(SORT(.ctors.*)))
		KEEP (*(.ctors))
		. = ALIGN(4);   /* REQUIRED. LD is flaky without it. */
	} >ewram = 0

	.dtors :
	{
		KEEP (*crtbegin.o(.dtors))
		KEEP (*(EXCLUDE_FILE (*crtend.o) .dtors))
		KEEP (*(SORT(.dtors.*)))
		KEEP (*(.dtors))
		. = ALIGN(4);   /* REQUIRED. LD is flaky without it. */
	} >ewram = 0

	.jcr            : { KEEP (*(.jcr)) } >ewram
	.eh_frame :
	{
		KEEP (*(.eh_frame))
	. = ALIGN(4);   /* REQUIRED. LD is flaky without it. */
	} >ewram = 0

	.gcc_except_table :
	{
		*(.gcc_except_table)
		. = ALIGN(4);   /* REQUIRED. LD is flaky without it. */
	} >ewram = 0

	__iwram_lma = .;

	.iwram __iwram_start : AT (__iwram_lma)
	{
		__iwram_start__ = ABSOLUTE(.) ;
		*(.iwram)
		*iwram.*(.text)
		. = ALIGN(4);   /* REQUIRED. LD is flaky without it. */
		__iwram_end__ = ABSOLUTE(.) ;
	} >iwram = 0xff

	__data_lma = __iwram_lma + SIZEOF(.iwram) ;

	.bss ALIGN(4) (NOLOAD):
	{
		__bss_start__ = ABSOLUTE(.);
		*(.dynbss)
		*(.gnu.linkonce.b*)
		*(.bss*)
		*(COMMON)
		. = ALIGN(4);    /* REQUIRED. LD is flaky without it. */
		__bss_end__ = ABSOLUTE(.) ;
	}

	.data ALIGN(4) : AT (__data_lma)
	{
		__data_start__ = ABSOLUTE(.);
		*(.data)
		*(.data.*)
		*(.gnu.linkonce.d*)
		CONSTRUCTORS
		. = ALIGN(4);  /* REQUIRED. LD is flaky without it. */
		__data_end__  =  ABSOLUTE(.);
	} >iwram = 0xff

	__iwram_overlay_lma = __data_lma + SIZEOF(.data);

	PROVIDE (edata = .);
	__iwram_overlay_start = . ;

	OVERLAY ALIGN(4) : NOCROSSREFS AT (__iwram_overlay_lma)
	{
	   .iwram0 { *(.iwram0) . = ALIGN(4);}
	   .iwram1 { *(.iwram1) . = ALIGN(4);}
	   .iwram2 { *(.iwram2) . = ALIGN(4);}
	   .iwram3 { *(.iwram3) . = ALIGN(4);}
	   .iwram4 { *(.iwram4) . = ALIGN(4);}
	   .iwram5 { *(.iwram5) . = ALIGN(4);}
	   .iwram6 { *(.iwram6) . = ALIGN(4);}
	   .iwram7 { *(.iwram7) . = ALIGN(4);}
	   .iwram8 { *(.iwram8) . = ALIGN(4);}
	   .iwram9 { *(.iwram9) . = ALIGN(4);}
	} >iwram = 0xff

	__ewram_lma = LOADADDR(.iwram0) + SIZEOF(.iwram0)+SIZEOF(.iwram1)+SIZEOF(.iwram2)+SIZEOF(.iwram3)+SIZEOF(.iwram4)+SIZEOF(.iwram5)+SIZEOF(.iwram6)+SIZEOF(.iwram7)+SIZEOF(.iwram8)+SIZEOF(.iwram9);

	__iwram_overlay_end = __ewram_lma ;

	/* v1.3 */
	__ewram_start =  __ewram_lma ;

	.ewram __ewram_start : AT (__ewram_lma)
	{
		*(.ewram)
		. = ALIGN(4);  /* REQUIRED. LD is flaky without it. */
		__ewram_end = ABSOLUTE(.);
	} >ewram = 0xff

	__ewram_overlay_lma = __ewram_lma + SIZEOF(.ewram);

	.sbss ALIGN(4)(NOLOAD):
 	{
		__sbss_start__ = ABSOLUTE(.);
		*(.sbss)
		. = ALIGN(4);
		__sbss_end__  = ABSOLUTE(.);
		__end__ = ABSOLUTE(.);
		__eheap_start = ABSOLUTE(.);
	}

	OVERLAY ALIGN(4): NOCROSSREFS AT (__ewram_overlay_lma)
	{
		.ewram0 { *(.ewram0) . = ALIGN(4);}
		.ewram1 { *(.ewram1) . = ALIGN(4);}
		.ewram2 { *(.ewram2) . = ALIGN(4);}
		.ewram3 { *(.ewram3) . = ALIGN(4);}
		.ewram4 { *(.ewram4) . = ALIGN(4);}
		.ewram5 { *(.ewram5) . = ALIGN(4);}
		.ewram6 { *(.ewram6) . = ALIGN(4);}
		.ewram7 { *(.ewram7) . = ALIGN(4);}
		.ewram8 { *(.ewram8) . = ALIGN(4);}
		.ewram9 { *(.ewram9) . = ALIGN(4);}
	} >ewram = 0xff
	__ewram_overlay_end  = ABSOLUTE(.);

	__eheap_start = __ewram_overlay_end ;

	_end = __ewram_overlay_end;
	__end__ = __ewram_overlay_end;
	__rom_end__ = __ewram_overlay_end;

	/* Stabs debugging sections.  */
	.stab 0 : { *(.stab) }
	.stabstr 0 : { *(.stabstr) }
	.stab.excl 0 : { *(.stab.excl) }
	.stab.exclstr 0 : { *(.stab.exclstr) }
	.stab.index 0 : { *(.stab.index) }
	.stab.indexstr 0 : { *(.stab.indexstr) }
	.comment 0 : { *(.comment) }
	/* DWARF debug sections.
	   Symbols in the DWARF debugging sections are relative to the beginning
	   of the section so we begin them at 0.  */
	/* DWARF 1 */
	.debug          0 : { *(.debug) }
	.line           0 : { *(.line) }
	/* GNU DWARF 1 extensions */
	.debug_srcinfo  0 : { *(.debug_srcinfo) }
	.debug_sfnames  0 : { *(.debug_sfnames) }
	/* DWARF 1.1 and DWARF 2 */
	.debug_aranges  0 : { *(.debug_aranges) }
	.debug_pubnames 0 : { *(.debug_pubnames) }
	/* DWARF 2 */
	.debug_info     0 : { *(.debug_info) }
	.debug_abbrev   0 : { *(.debug_abbrev) }
	.debug_line     0 : { *(.debug_line) }
	.debug_frame    0 : { *(.debug_frame) }
	.debug_str      0 : { *(.debug_str) }
	.debug_loc      0 : { *(.debug_loc) }
	.debug_macinfo  0 : { *(.debug_macinfo) }
	/* SGI/MIPS DWARF 2 extensions */
	.debug_weaknames 0 : { *(.debug_weaknames) }
	.debug_funcnames 0 : { *(.debug_funcnames) }
	.debug_typenames 0 : { *(.debug_typenames) }
	.debug_varnames  0 : { *(.debug_varnames) }
	.stack 0x80000 : { _stack = .; *(.stack) }
	/* These must appear regardless of  .  */
}

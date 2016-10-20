@****************************************************
@*    gp32 crt0.S v1.0 by Jeff F                    *
@****************************************************

@ v1.0 - Original release
@
@ This file is released into the public domain for commercial
@ or non-commercial usage with no restrictions placed upon it.

    .TEXT

@ Note: Normally it is the job of crt0.S to clear the BSS
@ (Zero Initialized) section to 0x00, but in the case of
@ the gp32 we do not have to do this because it is done
@ by the gp32 bios after it loads the app.

@ The official sdt dev kit uses 'Main ()' as the entry
@ point. If you would rather use 'main ()' instead then
@ comment out the next line.
@
@ You have to use 'main ()' at some point in your program
@ if you want to do c++ code. GCC will do a call to constructor
@ setup before executing 'main ()'. Using 'main ()' also increases
@ your program size by ~5500 bytes.

@ .equ __OfficialEntry, 1

@ The official sdt dev kit initializes various things in init.o
@ Crt0.S performs similar tasks for compatibility. If you don't
@ wish to use the official libs, or those that are compatible,
@ then you need to comment out the next line to prevent link errors.

 .equ __OfficialInits, 1


    .GLOBAL     _start
_start:
        .ALIGN
        .CODE 32

    @ Start Vector

        b       _GpInit

        .word   __text_start    @ Start of text (Read Only) section
_roe:   .word   __ro_end        @ End "
_rws:   .word   __data_start    @ Start of data (Read/Write) section
        .word   __bss_end       @ End of bss (this is the way sdt does it for some reason)
_zis:   .word   __bss_start     @ Start of bss (Zero Initialized) section
_zie:   .word   __bss_end       @ End "

        .word   0x44450011
        .word   0x44450011

        .word   0x01234567
        .word   0x12345678
        .word   0x23456789
        .word   0x34567890
        .word   0x45678901
        .word   0x56789012
        .word   0x23456789
        .word   0x34567890
        .word   0x45678901
        .word   0x56789012
        .word   0x23456789
        .word   0x34567890
        .word   0x45678901
        .word   0x56789012

_GpInit:
        mrs r0,CPSR
        orr r0,r0,#0xc0
        msr CPSR_fsxc,r0

.ifdef __OfficialInits

@ Call function in user_init.s
@        bl  asm_user_entry

@ Get pointer to GpSurfaceSet routine
        mov r0,#0
        swi 0xb
        ldr r1,=GpSurfaceSet
        ldr r2,=GpSurfaceFlip
        str r0,[r1]
        str r0,[r2]

@ Get time passed
        mov r0,#6
        swi 0xb
        ldr r1,=_timepassed
        str r0,[r1]

@ Get button stuff
        mov r0,#0
        swi 0x10
        ldr r2,=_reg_io_key_a
        ldr r3,=_reg_io_key_b
        str r0,[r2]
        str r1,[r3]

@ Set heap start location
        ldr r0,_zie
        ldr r1,=HEAPSTART
        str r0,[r1]

@ Set heap end location
        mov r0,#5
        swi 0xb
        ldr r1,=HEAPEND
        sub r0,r0,#255
        bic r0,r0,#3
        str r0,[r1]

@ Set App Argument
        swi 0x15

        mov r10,r0
        mov r11,r1       @ possibly not needed but left in anyway

        mrs r0,CPSR
        bic r0,r0,#192
        orr r0,r0,#64
        msr CPSR_fsxc,r0

        mov r0,r10
        mov r1,r11       @ possibly not needed but left in anyway
.endif

@ Jump to Main ()

.ifdef __OfficialEntry
        ldr     r3,=Main
.else
        ldr     r3,=main
.endif
        bx  r3           @ Init.o uses 'mov pc,r3' but
                         @ 'bx r3' is used here instead. This way
                         @ the main function can be ARM or Thumb.

.ifdef __OfficialInits

    swi   0x12
		orr		r1,r1,r2
    and   r1,r1,r3
		eor		r1,r1,r4
		mov		r5,r1,lsr #4
		add		r1,r1,r7
    sub   r7,r7,r1
		mov		r8,#0
		mov		pc,r8
    b   .
		b		.
		b		.
		b		.
		b		.
		b		.
		b		.
		b		.
		b		.
		b		.
		b		.
		b		.
		nop
		nop
		nop
		nop
		nop
		nop

        .GLOBAL _fw_init_for_dbg
_fw_init_for_dbg:
		stmdb	sp!,{r0-r12}

		mov		r10,lr
		mov		r11,sp

    bic   r0,r0,#31      @ 0x1f
    orr   r1,r0,#17      @ 0x11
    orr   r2,r0,#19      @ 0x13
		msr		cpsr_cxsf,r1
		mov		r12,#4
		add		r12,r12,pc
		msr		cpsr_cxsf,r2
    swi   0x1ff

@		bl		asm_user_entry_path

		mov		r0,r11
		mov		r1,r10
		add		r0,r0,#52
		ldr		r2,[r0]
		mov		lr,r1
		stmdb	sp!,{r2}
		stmdb	sp!,{r0-r12,lr}

@ Copy RW Base - ZI Base
    ldr   r0,=_roe         @ |Image$$RO$$Limit|
    ldr   r3,=_zis         @ |Image$$ZI$$Base|
    ldr   r2,=_rws         @ |Image$$RW$$Base|
		sub	 	r3,r3,r2
CopyRWData:
		cmp	 	r3,#36
    blt   CopyRWData2
		ldmia	r0!,{r4-r12}
		stmia	r2!,{r4-r12}
		sub	 	r3,r3,#36
		b		CopyRWData
CopyRWData2:
		cmp	 	r3,#0
    ble   CopyRWData3
		ldr	 	r4,[r0],#4
		str	 	r4,[r2],#4
		sub	 	r3,r3,#4
    b   CopyRWData2
CopyRWData3:

@ Clear ZI section
    ldr   r1,=_zie         @ |Image$$ZI$$Limit|
    ldr   r0,=_zis         @ |Image$$ZI$$Base|
		mov	 	r2,#0
		mov	 	r3,r2
		mov	 	r4,r2
		mov	 	r5,r2
		mov	 	r6,r2
		mov	 	r7,r2
		mov	 	r8,r2
		mov	 	r9,r2
		mov	 	r10,r2
		mov	 	r11,r2
		mov	 	r12,r2
CopyZIData:
		stmia	r0!,{r2-r12}
		cmp	 	r0,r1
		blt	 	CopyZIData

		ldmia	sp!,{r0-r12,pc}

.endif

    .ALIGN
    .POOL


    .END


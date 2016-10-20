@---------------------------------------------------------------------------------
	.section ".init"
	.global _start
	.arm
@---------------------------------------------------------------------------------
_start:
@---------------------------------------------------------------------------------
	b	rom_header_end

@---------------------------------------------------------------------------------
	.fill   156,1,0				@ Nintendo Logo Character Data (8000004h)
	.fill	16,1,0				@ Game Title
	.byte   0x30,0x31			@ Maker Code (80000B0h)
	.byte   0x96				@ Fixed Value (80000B2h)
	.byte   0x00				@ Main Unit Code (80000B3h)
	.byte   0x00				@ Device Type (80000B4h)
	.fill	7,1,0				@ unused
	.byte	0x00				@ Software Version No (80000BCh)
	.byte	0xf0				@ Complement Check (80000BDh)
	.byte	0x00,0x00    			@ Checksum (80000BEh)

rom_header_end:
	b	start_vector			@ This branch must be here for proper
						@ positioning of the following header.

	.GLOBAL	__boot_method, __slave_number
__boot_method:
	.byte   0				@ boot method (0=ROM boot, 3=Multiplay boot)
__slave_number:
	.byte   0				@ slave # (1=slave#1, 2=slave#2, 3=slave#3)

	.byte   0 				@ reserved
	.byte   0 				@ reserved
	.word   0    				@ reserved
	.word   0				@ reserved
	.word   0    				@ reserved
	.word   0    				@ reserved
	.word   0    				@ reserved
	.word   0    				@ reserved
@---------------------------------------------------------------------------------
	.align	4
	.arm
@---------------------------------------------------------------------------------
start_vector:
@---------------------------------------------------------------------------------
	mov	r0, #0x04000000		@ IME = 0;
	str	r0, [r0, #0x208]

	mov	r0, #0x12		@ Switch to IRQ Mode
	msr	cpsr, r0
	ldr	sp, =__sp_irq		@ Set IRQ stack

	mov	r0, #0x13		@ Switch to SVC Mode
	msr	cpsr, r0
	ldr	sp, =__sp_svc		@ Set SVC stack


	mov	r0, #0x1F		@ Switch to System Mode
	msr	cpsr, r0
	ldr	sp, =__sp_usr		@ Set user stack

	mov	r1, #0x42
	strb	r1, [r7], #1
	mov	r1, #0x35
	strb	r1, [r7], #1
	mov	r1, #0x2B
	strb	r1, [r7], #1
	mov	r1, #0x2B
	strb	r1, [r7], #1

	ldr	r1, =__data_lma		@ Copy initialized data (data section) from LMA to VMA (ROM to RAM)
	ldr	r2, =__data_start
	ldr	r4, =__data_end
	bl	CopyMemChk

	ldr	r1, =__iwram_lma	@ Copy internal work ram (iwram section) from LMA to VMA (ROM to RAM)
	ldr	r2, =__iwram_start
	ldr	r4, =__iwram_end
	bl	CopyMemChk

	ldr	r0, =__bss_start	@ Clear BSS section to 0x00
	ldr	r1, =__bss_end
	sub	r1, r1, r0
	bl	ClearMem

	ldr	r0, =__sbss_start	@ Clear SBSS section to 0x00
	ldr	r1, =__sbss_end
	sub	r1, r1, r0
	bl	ClearMem

	ldr	r1, =fake_heap_end	@ set heap end
	ldr	r0, =__eheap_end
	str	r0, [r1]
	
	ldr	r3, =__libc_init_array	@ global constructors
	bl	_call_via_r3

	mov	r0, #0			@ int argc
	mov	r1, #0			@ char *argv[]
	ldr	r3, =main
	bl	_call_via_r3		@ jump to user code


@---------------------------------------------------------------------------------
@ Clear memory to 0x00 if length != 0
@  r0 = Start Address
@  r1 = Length
@---------------------------------------------------------------------------------
ClearMem:
	mov	r2, #3			@ Round down to nearest word boundary
	add	r1, r1, r2		@ Shouldn't be needed
	bics	r1, r1, r2		@ Clear 2 LSB (and set Z)
	bxeq	lr			@ Quit if copy size is 0

	mov	r2, #0
@---------------------------------------------------------------------------------
ClrLoop:
@---------------------------------------------------------------------------------
	stmia	r0!, {r2}
	subs	r1, r1, #4
	bne	ClrLoop
	bx	lr

@---------------------------------------------------------------------------------
@ Copy memory if length	!= 0
@  r1 = Source Address
@  r2 = Dest Address
@  r4 = Dest Address + Length
@---------------------------------------------------------------------------------
CopyMemChk:
@---------------------------------------------------------------------------------
	sub	r3, r4, r2		@ Is there any data to copy?
@---------------------------------------------------------------------------------
@ Copy memory
@  r1 = Source Address
@  r2 = Dest Address
@  r3 = Length
@---------------------------------------------------------------------------------
CopyMem:
@---------------------------------------------------------------------------------
	mov	r0, #3			@ These commands are used in cases where
	add	r3, r3, r0		@ the length is not a multiple of 4,
	bics	r3, r3, r0		@ even though it should be.
	bxeq	lr			@ Length is zero so exit

@---------------------------------------------------------------------------------
CIDLoop:
@---------------------------------------------------------------------------------
	ldmia	r1!, {r0}
	stmia	r2!, {r0}
	subs	r3, r3, #4
	bne	CIDLoop
	bx	lr
@---------------------------------------------------------------------------------
	.align
	.pool
@---------------------------------------------------------------------------------
	.end
@---------------------------------------------------------------------------------


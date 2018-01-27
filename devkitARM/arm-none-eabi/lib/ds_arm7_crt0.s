@---------------------------------------------------------------------------------
	.section ".crt0","ax"
	.global _start
@---------------------------------------------------------------------------------
	.align	4
	.arm
@---------------------------------------------------------------------------------
_start:
@---------------------------------------------------------------------------------
	mov	r0, #0x04000000		@ IME = 0;
	mov	r1, #0
	str	r1, [r0, #0x208]

	mov	r0, #0x12		@ Switch to IRQ Mode
	msr	cpsr, r0
	ldr	sp, =__sp_irq		@ Set IRQ stack

	mov	r0, #0x13		@ Switch to SVC Mode
	msr	cpsr, r0
	ldr	sp, =__sp_svc		@ Set SVC stack

	mov	r0, #0x1F		@ Switch to System Mode
	msr	cpsr, r0
	ldr	sp, =__sp_usr		@ Set user stack

#ifndef VRAM
	adr	r1, __sync_start	@ Perform ARM7<->ARM9 sync code
	ldr	r2, =__arm7_start__
	mov	r3, #(__sync_end-__sync_start)
	mov	r8, r2
	bl	CopyMem
	mov	r3, r8
	bl	_blx_r3_stub

@---------------------------------------------------------------------------------
@ Copy arm7 binary from LMA to VMA (EWRAM to IWRAM)
@---------------------------------------------------------------------------------
	adr	r0, arm7lma		@ Calculate ARM7 LMA
	ldr	r1, [r0]
	add	r1, r1, r0
	ldr	r2, =__arm7_start__
	ldr	r4, =__arm7_end__
	bl	CopyMemCheck

#else
	bl	__sync_start
#endif

	ldr	r0, =__bss_start__	@ Clear BSS section to 0x00
	ldr	r1, =__bss_end__
	sub	r1, r1, r0
	bl	ClearMem

#ifndef VRAM
	cmp	r10, #1
	bne	NotTWL
	ldr	r1, =__dsimode		@ set DSi mode flag
	strb	r10, [r1]

	ldr	r1, =0x02ffe1d8		@ Get ARM7i LMA from header
	ldr	r1, [r1]
	ldr	r2, =__arm7i_start__
	ldr	r4, =__arm7i_end__
	bl	CopyMemCheck

	ldr	r0, =__twl_bss_start__	@ Clear TWL BSS section to 0x00
	ldr	r1, =__twl_bss_end__
	sub	r1, r1, r0
	bl	ClearMem
#endif

NotTWL:
	ldr	r3, =__libc_init_array	@ global constructors
	bl	_blx_r3_stub

	mov	r0, #0			@ int argc
	mov	r1, #0			@ char *argv[]
	ldr	r3, =main
	ldr	lr,=__libnds_exit
	mov	r12, #0x4000000		@ tell arm9 we are ready
	mov	r9, #0
	str	r9, [r12, #0x180]
_blx_r3_stub:
	bx	r3

#ifndef VRAM
arm7lma:
	.word	__arm7_lma__ - .
#endif
	.pool

@---------------------------------------------------------------------------------
@ ARM7<->ARM9 synchronization code
@---------------------------------------------------------------------------------

__sync_start:
	push	{lr}
	mov	r12, #0x4000000
	mov	r9, #0x0
	bl	IPCSync
	mov	r9, #(0x9<<8)
	str	r9, [r12, #0x180]
	mov	r9, #0xA
	bl	IPCSync
	mov	r9, #(0xB<<8)
	str	r9, [r12, #0x180]
	mov	r9, #0xC
	bl	IPCSync
	mov	r9, #(0xD<<8)
	str	r9, [r12, #0x180]
IPCRecvFlag:
	ldr	r10, [r12, #0x180]
	and	r10, r10, #0xF
	cmp	r10, #0xC
	beq	IPCRecvFlag
	pop	{pc}
IPCSync:
	ldr	r10, [r12, #0x180]
	and	r10, r10, #0xF
	cmp	r10, r9
	bne	IPCSync
	bx	lr
__sync_end:

@---------------------------------------------------------------------------------
@ Clear memory to 0x00 if length != 0
@  r0 = Start Address
@  r1 = Length
@---------------------------------------------------------------------------------
ClearMem:
@---------------------------------------------------------------------------------
	mov	r2, #3			@ Round down to nearest word boundary
	add	r1, r1, r2		@ Shouldn't be needed
	bics	r1, r1, r2		@ Clear 2 LSB (and set Z)
	bxeq	lr			@ Quit if copy size is 0

	mov	r2, #0
ClrLoop:
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
CopyMemCheck:
@---------------------------------------------------------------------------------
	cmp	r1, r2
	bxeq	lr

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
	bxeq	lr			@ Length is zero, so exit
CIDLoop:
	ldmia	r1!, {r0}
	stmia	r2!, {r0}
	subs	r3, r3, #4
	bne	CIDLoop
	bx	lr

@---------------------------------------------------------------------------------
	.align
	.pool
	.end
@---------------------------------------------------------------------------------

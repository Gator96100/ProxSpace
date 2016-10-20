@---------------------------------------------------------------------------------
@ nintendo e-reader startup code
@---------------------------------------------------------------------------------
@ author  : tim schuerewegen
@ version : 1.0
@---------------------------------------------------------------------------------
	.section	".init"
	.global     _start
	.align
	.arm
@---------------------------------------------------------------------------------
_start:
@---------------------------------------------------------------------------------
	b	start_vector
	.long 0
	.long 0x02000000

start_vector:
	@ enter thumb mode
	adr		r0, _start_thumb + 1
	bx		r0

	.thumb

_start_thumb:

	@ save return address (rom)
	mov		r3, lr

	@ clear bss section
	ldr		r0, =__bss_start
	ldr		r1, =__bss_end
	mov		r2, #0
_loop_bss_clear:
	strb	r2, [r0]
	add		r0, #1
	cmp		r0, r1
	blt		_loop_bss_clear

	@ set return address (rom)
	mov		lr, r3

	@ jump to main
	ldr		r3, =main
	bx		r3

	.align

	.pool

	.end

	.align
	.pool
	.end


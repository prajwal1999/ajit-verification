	.file	"checker.c"
	.section	".rodata"
	.align 8
.LC0:
	.asciz	"------------------------Starting tests-------------------\n"
	.align 8
.LC1:
	.asciz	">>> Tests for Instruction with opcode 0x%x\n"
	.align 8
.LC2:
	.asciz	"Test failed - %d/%d\n"
	.align 8
.LC3:
	.asciz	"Expected Output 0x%x, 0x%x\n"
	.align 8
.LC4:
	.asciz	"result_msb 0x%x\n"
	.align 8
.LC5:
	.asciz	"Actual result 0x%x\n"
	.align 8
.LC6:
	.asciz	"Actual Output 0x%x, 0x%x\n"
	.align 8
.LC7:
	.asciz	"Test %d passed\n"
	.section	".text"
	.align 4
	.global checker
	.type	checker, #function
	.proc	04
checker:
	save	%sp, -136, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	mov	59, %g1
	st	%g1, [%fp-12]
	mov	3, %o0
	call	__ajit_write_serial_control_register__, 0
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC1), %g1
	or	%g1, %lo(.LC1), %o0
	mov	16, %o1
	call	ee_printf, 0
	 nop
	st	%g0, [%fp-4]
	b	.L2
	 nop
.L8:
	ld	[%fp-4], %g1
	sll	%g1, 5, %g1
	add	%g1, 4, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	st	%g1, [%fp-16]
	ld	[%fp-4], %g1
	sll	%g1, 5, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	st	%g1, [%fp-20]
	ld	[%fp-4], %g1
	sll	%g1, 5, %g1
	add	%g1, 20, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	st	%g1, [%fp-24]
	ld	[%fp-4], %g1
	sll	%g1, 5, %g1
	add	%g1, 24, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	st	%g1, [%fp-28]
	ld	[%fp-4], %g1
	sll	%g1, 5, %g1
	add	%g1, 8, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	st	%g1, [%fp-32]
	ld	[%fp-4], %g1
	sll	%g1, 5, %g1
	add	%g1, 12, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	st	%g1, [%fp-36]
	stb	%g0, [%fp-5]
	stb	%g0, [%fp-6]
	ld	[%fp-16], %g2
	ld	[%fp-24], %g1
	cmp	%g2, %g1
	bne	.L3
	 nop
	mov	1, %g1
	stb	%g1, [%fp-5]
	b	.L4
	 nop
.L3:
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	sethi	%hi(.LC2), %g2
	or	%g2, %lo(.LC2), %o0
	mov	%g1, %o1
	ld	[%fp-12], %o2
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC3), %g1
	or	%g1, %lo(.LC3), %o0
	ld	[%fp-16], %o1
	ld	[%fp-20], %o2
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC4), %g1
	or	%g1, %lo(.LC4), %o0
	ld	[%fp-32], %o1
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC5), %g1
	or	%g1, %lo(.LC5), %o0
	ld	[%fp-36], %o1
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC6), %g1
	or	%g1, %lo(.LC6), %o0
	ld	[%fp-24], %o1
	ld	[%fp-28], %o2
	call	ee_printf, 0
	 nop
#APP
! 45 "checker.c" 1
	 ta 0 
	 
! 0 "" 2
#NO_APP
.L4:
	ld	[%fp-20], %g2
	ld	[%fp-28], %g1
	cmp	%g2, %g1
	bne	.L5
	 nop
	mov	1, %g1
	stb	%g1, [%fp-6]
	b	.L6
	 nop
.L5:
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	sethi	%hi(.LC2), %g2
	or	%g2, %lo(.LC2), %o0
	mov	%g1, %o1
	ld	[%fp-12], %o2
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC3), %g1
	or	%g1, %lo(.LC3), %o0
	ld	[%fp-16], %o1
	ld	[%fp-20], %o2
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC4), %g1
	or	%g1, %lo(.LC4), %o0
	ld	[%fp-32], %o1
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC5), %g1
	or	%g1, %lo(.LC5), %o0
	ld	[%fp-36], %o1
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC6), %g1
	or	%g1, %lo(.LC6), %o0
	ld	[%fp-24], %o1
	ld	[%fp-28], %o2
	call	ee_printf, 0
	 nop
#APP
! 57 "checker.c" 1
	 ta 0 
	 
! 0 "" 2
#NO_APP
.L6:
	ldub	[%fp-5], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	be	.L7
	 nop
	ldub	[%fp-6], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	be	.L7
	 nop
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	sethi	%hi(.LC7), %g2
	or	%g2, %lo(.LC7), %o0
	mov	%g1, %o1
	call	ee_printf, 0
	 nop
.L7:
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L2:
	ld	[%fp-4], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bl	.L8
	 nop
	mov	0, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	checker, .-checker
	.ident	"GCC: (Buildroot 2014.08-g54f60c9) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

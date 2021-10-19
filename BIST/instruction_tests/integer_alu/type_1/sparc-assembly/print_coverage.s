	.file	"print_coverage.c"
	.section	".rodata"
	.align 8
.LC0:
	.asciz	"\n"
	.align 8
.LC1:
	.asciz	">>> Coverage for Instruction with opcode 0x%x\n"
	.align 8
.LC2:
	.asciz	">>> Inputs seed is %d\n"
	.align 8
.LC3:
	.asciz	">>> Register seed is %d\n"
	.align 8
.LC4:
	.asciz	">>> Register Coverage\n"
	.align 8
.LC5:
	.asciz	">>> r%d --- rs1 - %d, rs2 - %d, rd - %d\n"
	.align 8
.LC6:
	.asciz	">>> Data Grid\n"
	.align 8
.LC7:
	.asciz	">>> "
	.align 8
.LC8:
	.asciz	"%d   "
	.align 8
.LC9:
	.asciz	">>> n Grid\n"
	.align 8
.LC10:
	.asciz	">>> z Grid\n"
	.align 8
.LC11:
	.asciz	">>> v Grid\n"
	.align 8
.LC12:
	.asciz	">>> c Grid\n"
	.section	".text"
	.align 4
	.global print_coverage
	.type	print_coverage, #function
	.proc	04
print_coverage:
	save	%sp, -112, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	st	%i3, [%fp+80]
	st	%i4, [%fp+84]
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
	sethi	%hi(.LC2), %g1
	or	%g1, %lo(.LC2), %o0
	ld	[%fp+80], %o1
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC3), %g1
	or	%g1, %lo(.LC3), %o0
	ld	[%fp+84], %o1
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC4), %g1
	or	%g1, %lo(.LC4), %o0
	call	ee_printf, 0
	 nop
	st	%g0, [%fp-4]
	b	.L2
	 nop
.L3:
	ld	[%fp-4], %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sll	%g1, 2, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g4
	ld	[%fp-4], %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sll	%g1, 2, %g1
	add	%g1, 4, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g3
	ld	[%fp-4], %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sll	%g1, 2, %g1
	add	%g1, 8, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	sethi	%hi(.LC5), %g2
	or	%g2, %lo(.LC5), %o0
	ld	[%fp-4], %o1
	mov	%g4, %o2
	mov	%g3, %o3
	mov	%g1, %o4
	call	ee_printf, 0
	 nop
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L2:
	ld	[%fp-4], %g1
	cmp	%g1, 31
	ble	.L3
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	call	ee_printf, 0
	 nop
	mov	8, %g1
	st	%g1, [%fp-12]
	sethi	%hi(.LC6), %g1
	or	%g1, %lo(.LC6), %o0
	call	ee_printf, 0
	 nop
	st	%g0, [%fp-4]
	b	.L4
	 nop
.L7:
	sethi	%hi(.LC7), %g1
	or	%g1, %lo(.LC7), %o0
	call	ee_printf, 0
	 nop
	st	%g0, [%fp-8]
	b	.L5
	 nop
.L6:
	ld	[%fp-4], %g2
	ld	[%fp-12], %g1
	smul	%g2, %g1, %g1
	mov	%g1, %g2
	ld	[%fp-8], %g1
	add	%g2, %g1, %g1
	sll	%g1, 2, %g1
	ld	[%fp+72], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	sethi	%hi(.LC8), %g2
	or	%g2, %lo(.LC8), %o0
	mov	%g1, %o1
	call	ee_printf, 0
	 nop
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L5:
	ld	[%fp-8], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bl	.L6
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	call	ee_printf, 0
	 nop
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L4:
	ld	[%fp-4], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bl	.L7
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC9), %g1
	or	%g1, %lo(.LC9), %o0
	call	ee_printf, 0
	 nop
	st	%g0, [%fp-4]
	b	.L8
	 nop
.L11:
	sethi	%hi(.LC7), %g1
	or	%g1, %lo(.LC7), %o0
	call	ee_printf, 0
	 nop
	st	%g0, [%fp-8]
	b	.L9
	 nop
.L10:
	ld	[%fp-4], %g2
	ld	[%fp-12], %g1
	smul	%g2, %g1, %g1
	sll	%g1, 4, %g1
	mov	%g1, %g2
	ld	[%fp-8], %g1
	sll	%g1, 4, %g1
	add	%g2, %g1, %g1
	ld	[%fp+76], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	sethi	%hi(.LC8), %g2
	or	%g2, %lo(.LC8), %o0
	mov	%g1, %o1
	call	ee_printf, 0
	 nop
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L9:
	ld	[%fp-8], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bl	.L10
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	call	ee_printf, 0
	 nop
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L8:
	ld	[%fp-4], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bl	.L11
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC10), %g1
	or	%g1, %lo(.LC10), %o0
	call	ee_printf, 0
	 nop
	st	%g0, [%fp-4]
	b	.L12
	 nop
.L15:
	sethi	%hi(.LC7), %g1
	or	%g1, %lo(.LC7), %o0
	call	ee_printf, 0
	 nop
	st	%g0, [%fp-8]
	b	.L13
	 nop
.L14:
	ld	[%fp-4], %g2
	ld	[%fp-12], %g1
	smul	%g2, %g1, %g1
	sll	%g1, 4, %g1
	mov	%g1, %g2
	ld	[%fp-8], %g1
	sll	%g1, 4, %g1
	add	%g2, %g1, %g1
	add	%g1, 4, %g1
	ld	[%fp+76], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	sethi	%hi(.LC8), %g2
	or	%g2, %lo(.LC8), %o0
	mov	%g1, %o1
	call	ee_printf, 0
	 nop
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L13:
	ld	[%fp-8], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bl	.L14
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	call	ee_printf, 0
	 nop
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L12:
	ld	[%fp-4], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bl	.L15
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC11), %g1
	or	%g1, %lo(.LC11), %o0
	call	ee_printf, 0
	 nop
	st	%g0, [%fp-4]
	b	.L16
	 nop
.L19:
	sethi	%hi(.LC7), %g1
	or	%g1, %lo(.LC7), %o0
	call	ee_printf, 0
	 nop
	st	%g0, [%fp-8]
	b	.L17
	 nop
.L18:
	ld	[%fp-4], %g2
	ld	[%fp-12], %g1
	smul	%g2, %g1, %g1
	sll	%g1, 4, %g1
	mov	%g1, %g2
	ld	[%fp-8], %g1
	sll	%g1, 4, %g1
	add	%g2, %g1, %g1
	add	%g1, 8, %g1
	ld	[%fp+76], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	sethi	%hi(.LC8), %g2
	or	%g2, %lo(.LC8), %o0
	mov	%g1, %o1
	call	ee_printf, 0
	 nop
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L17:
	ld	[%fp-8], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bl	.L18
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	call	ee_printf, 0
	 nop
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L16:
	ld	[%fp-4], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bl	.L19
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC12), %g1
	or	%g1, %lo(.LC12), %o0
	call	ee_printf, 0
	 nop
	st	%g0, [%fp-4]
	b	.L20
	 nop
.L23:
	sethi	%hi(.LC7), %g1
	or	%g1, %lo(.LC7), %o0
	call	ee_printf, 0
	 nop
	st	%g0, [%fp-8]
	b	.L21
	 nop
.L22:
	ld	[%fp-4], %g2
	ld	[%fp-12], %g1
	smul	%g2, %g1, %g1
	sll	%g1, 4, %g1
	mov	%g1, %g2
	ld	[%fp-8], %g1
	sll	%g1, 4, %g1
	add	%g2, %g1, %g1
	add	%g1, 12, %g1
	ld	[%fp+76], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	sethi	%hi(.LC8), %g2
	or	%g2, %lo(.LC8), %o0
	mov	%g1, %o1
	call	ee_printf, 0
	 nop
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L21:
	ld	[%fp-8], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bl	.L22
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	call	ee_printf, 0
	 nop
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L20:
	ld	[%fp-4], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bl	.L23
	 nop
	mov	1, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	print_coverage, .-print_coverage
	.ident	"GCC: (Buildroot 2014.08-g54f60c9) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

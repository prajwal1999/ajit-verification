	.file	"generate_input_output.c"
	.section	".text"
	.align 4
	.global prbs
	.type	prbs, #function
	.proc	03
prbs:
	save	%sp, -104, %sp
	mov	%i0, %g1
	sth	%g1, [%fp+68]
	lduh	[%fp+68], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	sra	%g1, 31, %g2
	lduh	[%fp+68], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	sra	%g1, 28, %g1
	xor	%g2, %g1, %g2
	lduh	[%fp+68], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	sra	%g1, 18, %g1
	xor	%g2, %g1, %g2
	lduh	[%fp+68], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	sra	%g1, 5, %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	xor	%g2, %g1, %g1
	and	%g1, 1, %g1
	xor	%g1, 0, %g1
	subcc	%g0, %g1, %g0
	addx	%g0, 0, %g1
	stb	%g1, [%fp-1]
	lduh	[%fp+68], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	sra	%g1, 1, %g1
	mov	%g1, %g2
	ldub	[%fp-1], %g1
	and	%g1, 0xff, %g1
	sll	%g1, 12, %g1
	or	%g2, %g1, %g1
	sth	%g1, [%fp+68]
	lduh	[%fp+68], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	prbs, .-prbs
	.align 4
	.global prbs_32
	.type	prbs_32, #function
	.proc	016
prbs_32:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	ld	[%fp+68], %g1
	srl	%g1, 31, %g2
	ld	[%fp+68], %g1
	srl	%g1, 30, %g1
	xor	%g2, %g1, %g2
	ld	[%fp+68], %g1
	srl	%g1, 25, %g1
	xor	%g2, %g1, %g2
	ld	[%fp+68], %g1
	srl	%g1, 26, %g1
	xor	%g2, %g1, %g1
	and	%g1, 1, %g1
	xor	%g1, 0, %g1
	subcc	%g0, %g1, %g0
	addx	%g0, 0, %g1
	stb	%g1, [%fp-1]
	ld	[%fp+68], %g1
	sll	%g1, 31, %g2
	srl	%g1, 1, %g1
	or	%g2, %g1, %g1
	st	%g1, [%fp+68]
	ld	[%fp+68], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	prbs_32, .-prbs_32
	.section	".rodata"
	.align 8
.LC0:
	.asciz	"lfsr is 0xffffffff"
	.align 8
.LC1:
	.asciz	"--------------------Inputs Outputs Generated----------------------\n"
	.section	".text"
	.align 4
	.global generate_input_output
	.type	generate_input_output, #function
	.proc	04
generate_input_output:
	save	%sp, -120, %sp
	st	%i0, [%fp+68]
	mov	%sp, %g1
	mov	%g1, %i1
	mov	3, %o0
	call	__ajit_write_serial_control_register__, 0
	 nop
	mov	900, %g1
	st	%g1, [%fp-12]
	ld	[%fp-12], %g1
	add	%g1, %g1, %g1
	add	%g1, -1, %g2
	st	%g2, [%fp-16]
	mov	%g1, %g2
	mov	%g2, %g3
	mov	0, %g2
	srl	%g3, 27, %g4
	sll	%g2, 5, %i2
	or	%g4, %i2, %i2
	sll	%g3, 5, %i3
	mov	%g1, %g2
	mov	%g2, %g3
	mov	0, %g2
	srl	%g3, 27, %g4
	sll	%g2, 5, %i4
	or	%g4, %i4, %i4
	sll	%g3, 5, %i5
	sll	%g1, 2, %g1
	add	%g1, 3, %g1
	add	%g1, 7, %g1
	srl	%g1, 3, %g1
	sll	%g1, 3, %g1
	sub	%sp, %g1, %sp
	add	%sp, 92, %g1
	add	%g1, 3, %g1
	srl	%g1, 2, %g1
	sll	%g1, 2, %g1
	st	%g1, [%fp-20]
	sethi	%hi(-1765964800), %g1
	or	%g1, 61, %g1
	st	%g1, [%fp-24]
	ld	[%fp-24], %g1
	st	%g1, [%fp-4]
	st	%g0, [%fp-8]
	b	.L6
	 nop
.L8:
	ld	[%fp-4], %g1
	mov	%g1, %o0
	call	prbs_32, 0
	 nop
	mov	%o0, %g1
	st	%g1, [%fp-4]
	ld	[%fp-4], %g3
	ld	[%fp-20], %g2
	ld	[%fp-8], %g1
	sll	%g1, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-4], %g1
	mov	%g1, %o0
	call	prbs_32, 0
	 nop
	mov	%o0, %g1
	st	%g1, [%fp-4]
	ld	[%fp-12], %g2
	ld	[%fp-8], %g1
	add	%g2, %g1, %g1
	ld	[%fp-4], %g3
	ld	[%fp-20], %g2
	sll	%g1, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-4], %g1
	cmp	%g1, -1
	bne	.L7
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	call	ee_printf, 0
	 nop
.L7:
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L6:
	ld	[%fp-8], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bl	.L8
	 nop
	st	%g0, [%fp-8]
	b	.L9
	 nop
.L10:
	ld	[%fp-8], %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sll	%g1, 3, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%fp-20], %g3
	ld	[%fp-8], %g2
	sll	%g2, 2, %g2
	ld	[%g3+%g2], %g2
	st	%g2, [%g1]
	ld	[%fp-8], %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sll	%g1, 3, %g1
	add	%g1, 4, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%fp-12], %g3
	ld	[%fp-8], %g2
	add	%g3, %g2, %g2
	ld	[%fp-20], %g3
	sll	%g2, 2, %g2
	ld	[%g3+%g2], %g2
	st	%g2, [%g1]
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L9:
	ld	[%fp-8], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bl	.L10
	 nop
	sethi	%hi(.LC1), %g1
	or	%g1, %lo(.LC1), %o0
	call	ee_printf, 0
	 nop
	mov	1, %g1
	mov	%i1, %sp
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	generate_input_output, .-generate_input_output
	.ident	"GCC: (Buildroot 2014.08-g1414aea) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

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
	sra	%g1, 16, %g2
	lduh	[%fp+68], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	sra	%g1, 2, %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	xor	%g2, %g1, %g2
	lduh	[%fp+68], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	sra	%g1, 3, %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
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
	.section	".rodata"
	.align 8
.LC0:
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
	ld	[%fp+68], %g1
	add	%g1, -1, %g2
	st	%g2, [%fp-12]
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
	st	%g1, [%fp-16]
	mov	16, %g1
	sth	%g1, [%fp-18]
	lduh	[%fp-18], %g1
	sth	%g1, [%fp-2]
	st	%g0, [%fp-8]
	b	.L4
	 nop
.L5:
	lduh	[%fp-2], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	mov	%g1, %o0
	call	prbs, 0
	 nop
	mov	%o0, %g1
	sth	%g1, [%fp-2]
	lduh	[%fp-2], %g1
	sll	%g1, 16, %g1
	srl	%g1, 16, %g3
	ld	[%fp-16], %g2
	ld	[%fp-8], %g1
	sll	%g1, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L4:
	ld	[%fp-8], %g2
	ld	[%fp+68], %g1
	cmp	%g2, %g1
	bl	.L5
	 nop
#APP
! 37 "generate_input_output.c" 1
	 set results_section, %l0
	 
! 0 "" 2
#NO_APP
	st	%g0, [%fp-8]
	b	.L6
	 nop
.L7:
	ld	[%fp-16], %g2
	ld	[%fp-8], %g1
	sll	%g1, 2, %g1
	ld	[%g2+%g1], %g1
#APP
! 39 "generate_input_output.c" 1
	 mov %g1, %l1 
	 
! 0 "" 2
! 40 "generate_input_output.c" 1
	 st %l1, [%l0] 
	 
! 0 "" 2
! 41 "generate_input_output.c" 1
	 add %l0, 0x4, %l0
	 
! 0 "" 2
#NO_APP
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L6:
	ld	[%fp+68], %g1
	add	%g1, %g1, %g1
	mov	%g1, %g2
	ld	[%fp-8], %g1
	cmp	%g2, %g1
	bg	.L7
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	call	ee_printf, 0
	 nop
	mov	0, %g1
	mov	%i1, %sp
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	generate_input_output, .-generate_input_output
	.ident	"GCC: (Buildroot 2014.08-gacf8924) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

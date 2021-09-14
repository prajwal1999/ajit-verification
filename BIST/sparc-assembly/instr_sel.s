	.file	"instr_sel.c"
	.section	".text"
	.align 4
	.global generate_opcode_10
	.type	generate_opcode_10, #function
	.proc	016
generate_opcode_10:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	st	%i3, [%fp+80]
	mov	%i4, %g2
	mov	%i5, %g1
	stb	%g2, [%fp+84]
	sth	%g1, [%fp+88]
	sethi	%hi(-2147483648), %g1
	st	%g1, [%fp-4]
	ld	[%fp+68], %g1
	sll	%g1, 25, %g1
	ld	[%fp-4], %g2
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp+80], %g1
	sll	%g1, 19, %g1
	ld	[%fp-4], %g2
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp+72], %g1
	sll	%g1, 14, %g1
	ld	[%fp-4], %g2
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp-4], %g2
	ld	[%fp+76], %g1
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp-4], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	generate_opcode_10, .-generate_opcode_10
	.align 4
	.global generate_opcode_11
	.type	generate_opcode_11, #function
	.proc	016
generate_opcode_11:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	st	%i3, [%fp+80]
	mov	%i4, %g2
	mov	%i5, %g1
	stb	%g2, [%fp+84]
	sth	%g1, [%fp+88]
	sethi	%hi(-1073741824), %g1
	st	%g1, [%fp-4]
	ld	[%fp+68], %g1
	sll	%g1, 25, %g1
	ld	[%fp-4], %g2
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp+80], %g1
	sll	%g1, 19, %g1
	ld	[%fp-4], %g2
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp+72], %g1
	sll	%g1, 14, %g1
	ld	[%fp-4], %g2
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ldub	[%fp+84], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 1
	bne	.L4
	 nop
	ld	[%fp-4], %g2
	sethi	%hi(8192), %g1
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	lduh	[%fp+88], %g1
	sll	%g1, 16, %g1
	srl	%g1, 16, %g1
	ld	[%fp-4], %g2
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	b	.L5
	 nop
.L4:
	ld	[%fp-4], %g2
	ld	[%fp+76], %g1
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
.L5:
	ld	[%fp-4], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	generate_opcode_11, .-generate_opcode_11
	.align 4
	.global instr_sel
	.type	instr_sel, #function
	.proc	02
instr_sel:
	save	%sp, -96, %sp
	st	%i0, [%fp+68]
	ld	[%fp+68], %g1
	cmp	%g1, 0
	bne	.L8
	 nop
	mov	0, %g1
	b	.L9
	 nop
.L8:
	ld	[%fp+68], %g1
	cmp	%g1, 1
	bne	.L10
	 nop
	mov	4, %g1
	b	.L9
	 nop
.L10:
	ld	[%fp+68], %g1
	cmp	%g1, 2
	bne	.L11
	 nop
	mov	10, %g1
	b	.L9
	 nop
.L11:
	ld	[%fp+68], %g1
	cmp	%g1, 3
	bne	.L12
	 nop
	mov	14, %g1
	b	.L9
	 nop
.L12:
	b	.L7
	 nop
.L9:
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
.L7:
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	instr_sel, .-instr_sel
	.align 4
	.global bring_complement_instr_1
	.type	bring_complement_instr_1, #function
	.proc	016
bring_complement_instr_1:
	save	%sp, -96, %sp
	mov	%i0, %g4
	mov	%i1, %g3
	mov	%i2, %g2
	mov	%i3, %g1
	stb	%g4, [%fp+68]
	stb	%g3, [%fp+72]
	stb	%g2, [%fp+76]
	stb	%g1, [%fp+80]
	ldub	[%fp+68], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	bne	.L14
	 nop
	ldub	[%fp+72], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g3
	ldub	[%fp+80], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	ldub	[%fp+76], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	mov	%g3, %o0
	mov	%g2, %o1
	mov	%g1, %o2
	mov	4, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g1
	b	.L15
	 nop
.L14:
	ldub	[%fp+68], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 4
	bne	.L16
	 nop
	ldub	[%fp+72], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g3
	ldub	[%fp+80], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	ldub	[%fp+76], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	mov	%g3, %o0
	mov	%g2, %o1
	mov	%g1, %o2
	mov	0, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g1
	b	.L15
	 nop
.L16:
	ldub	[%fp+68], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 14
	bne	.L17
	 nop
	ldub	[%fp+72], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g3
	ldub	[%fp+80], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	ldub	[%fp+76], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	mov	%g3, %o0
	mov	%g2, %o1
	mov	%g1, %o2
	mov	10, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g1
	b	.L15
	 nop
.L17:
	ldub	[%fp+68], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 10
	bne	.L18
	 nop
	ldub	[%fp+72], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g3
	ldub	[%fp+80], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	ldub	[%fp+76], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	mov	%g3, %o0
	mov	%g2, %o1
	mov	%g1, %o2
	mov	14, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g1
	b	.L15
	 nop
.L18:
	b	.L13
	 nop
.L15:
.L13:
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	bring_complement_instr_1, .-bring_complement_instr_1
	.align 4
	.global bring_complement_instr_2
	.type	bring_complement_instr_2, #function
	.proc	016
bring_complement_instr_2:
	save	%sp, -96, %sp
	mov	%i0, %g4
	mov	%i1, %g3
	mov	%i2, %g2
	mov	%i3, %g1
	stb	%g4, [%fp+68]
	stb	%g3, [%fp+72]
	stb	%g2, [%fp+76]
	stb	%g1, [%fp+80]
	ldub	[%fp+68], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	bne	.L20
	 nop
	ldub	[%fp+76], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g3
	ldub	[%fp+80], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	ldub	[%fp+72], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	mov	%g3, %o0
	mov	%g2, %o1
	mov	%g1, %o2
	mov	4, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g1
	b	.L21
	 nop
.L20:
	ldub	[%fp+68], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 4
	bne	.L22
	 nop
	ldub	[%fp+76], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g3
	ldub	[%fp+72], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	ldub	[%fp+80], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	mov	%g3, %o0
	mov	%g2, %o1
	mov	%g1, %o2
	mov	4, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g1
	b	.L21
	 nop
.L22:
	ldub	[%fp+68], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 14
	bne	.L23
	 nop
	ldub	[%fp+76], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g3
	ldub	[%fp+72], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	ldub	[%fp+80], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	mov	%g3, %o0
	mov	%g2, %o1
	mov	%g1, %o2
	mov	14, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g1
	b	.L21
	 nop
.L23:
	ldub	[%fp+68], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 10
	bne	.L24
	 nop
	ldub	[%fp+76], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g3
	ldub	[%fp+80], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	ldub	[%fp+72], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	mov	%g3, %o0
	mov	%g2, %o1
	mov	%g1, %o2
	mov	14, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g1
	b	.L21
	 nop
.L24:
	b	.L19
	 nop
.L21:
.L19:
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	bring_complement_instr_2, .-bring_complement_instr_2
	.ident	"GCC: (Buildroot 2014.08-gacf8924) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

	.file	"add.c"
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
	ldub	[%fp+84], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 1
	bne	.L2
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
	b	.L3
	 nop
.L2:
	ld	[%fp-4], %g2
	ld	[%fp+76], %g1
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
.L3:
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
	bne	.L6
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
	b	.L7
	 nop
.L6:
	ld	[%fp-4], %g2
	ld	[%fp+76], %g1
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
.L7:
	ld	[%fp-4], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	generate_opcode_11, .-generate_opcode_11
	.align 4
	.global generate_opcode_00
	.type	generate_opcode_00, #function
	.proc	016
generate_opcode_00:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	mov	%i1, %g1
	st	%i2, [%fp+76]
	stb	%g1, [%fp+72]
	st	%g0, [%fp-4]
	ld	[%fp+68], %g1
	sll	%g1, 25, %g1
	ld	[%fp-4], %g2
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ldub	[%fp+72], %g1
	and	%g1, 0xff, %g1
	sll	%g1, 22, %g1
	ld	[%fp-4], %g2
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp+76], %g1
	srl	%g1, 10, %g1
	ld	[%fp-4], %g2
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp-4], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	generate_opcode_00, .-generate_opcode_00
	.align 4
	.global prbs_3
	.type	prbs_3, #function
	.proc	014
prbs_3:
	save	%sp, -104, %sp
	mov	%i0, %g1
	stb	%g1, [%fp+68]
	ldub	[%fp+68], %g1
	and	%g1, 1, %g1
	stb	%g1, [%fp-1]
	ldub	[%fp+68], %g1
	and	%g1, 0xff, %g1
	and	%g1, 2, %g1
	sra	%g1, 1, %g1
	stb	%g1, [%fp-2]
	ldub	[%fp+68], %g1
	and	%g1, 0xff, %g1
	srl	%g1, 1, %g1
	mov	%g1, %g2
	ldub	[%fp-1], %g3
	ldub	[%fp-2], %g1
	xor	%g3, %g1, %g1
	and	%g1, 0xff, %g1
	sll	%g1, 2, %g1
	or	%g2, %g1, %g1
	stb	%g1, [%fp+68]
	ldub	[%fp+68], %g1
	and	%g1, 0xff, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	prbs_3, .-prbs_3
	.section	".rodata"
	.align 8
.LC0:
	.asciz	"------------------- Instructions generation done -------------------\n"
	.section	".text"
	.align 4
	.global add
	.type	add, #function
	.proc	04
add:
	save	%sp, -152, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	mov	900, %g1
	st	%g1, [%fp-12]
	mov	3, %o0
	call	__ajit_write_serial_control_register__, 0
	 nop
	mov	16, %g1
	stb	%g1, [%fp-40]
	mov	4, %g1
	stb	%g1, [%fp-39]
	nop
	stb	%g0, [%fp-49]
	stb	%g0, [%fp-48]
	stb	%g0, [%fp-47]
	stb	%g0, [%fp-46]
	stb	%g0, [%fp-45]
	stb	%g0, [%fp-44]
	stb	%g0, [%fp-43]
	stb	%g0, [%fp-42]
	stb	%g0, [%fp-41]
	mov	100, %g1
	stb	%g1, [%fp-49]
	mov	116, %g1
	stb	%g1, [%fp-48]
	sth	%g0, [%fp-56]
	stb	%g0, [%fp-54]
	mov	4, %g1
	stb	%g1, [%fp-55]
	mov	2, %g1
	stb	%g1, [%fp-13]
	ld	[%fp+68], %o0
	call	generate_input_output, 0
	 nop
	ld	[%fp-12], %g1
	add	%g1, %g1, %g1
	sll	%g1, 2, %g2
	add	%g1, %g2, %g1
	add	%g1, 6, %g1
	st	%g1, [%fp-20]
	ld	[%fp-20], %g1
	mov	%sp, %g2
	mov	%g2, %i1
	add	%g1, -1, %g2
	st	%g2, [%fp-24]
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
	st	%g1, [%fp-28]
	ld	[%fp-28], %g1
	sethi	%hi(-1646019584), %g2
	or	%g2, 928, %g2
	st	%g2, [%g1]
	ld	[%fp+68], %g1
	and	%g1, -1024, %g1
	st	%g1, [%fp-32]
	ldub	[%fp-13], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	mov	%g1, %o0
	mov	4, %o1
	ld	[%fp-32], %o2
	call	generate_opcode_00, 0
	 nop
	mov	%o0, %g2
	ld	[%fp-28], %g1
	st	%g2, [%g1+4]
	ld	[%fp+68], %g1
	sll	%g1, 22, %g1
	sra	%g1, 22, %g1
	st	%g1, [%fp-32]
	ldub	[%fp-13], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g3
	ldub	[%fp-13], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	ld	[%fp-32], %g1
	sll	%g1, 16, %g1
	srl	%g1, 16, %g1
	mov	%g3, %o0
	mov	%g2, %o1
	mov	0, %o2
	mov	2, %o3
	mov	1, %o4
	mov	%g1, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g2
	ld	[%fp-28], %g1
	st	%g2, [%g1+8]
	mov	4, %g1
	stb	%g1, [%fp-5]
	st	%g0, [%fp-4]
	b	.L14
	 nop
.L15:
	ldub	[%fp-5], %g1
	and	%g1, 0xff, %g1
	mov	%g1, %o0
	call	prbs_3, 0
	 nop
	mov	%o0, %g1
	stb	%g1, [%fp-5]
	ldub	[%fp-5], %g1
	or	%g1, 16, %g1
	stb	%g1, [%fp-33]
	ldub	[%fp-5], %g1
	and	%g1, 0xff, %g1
	mov	%g1, %o0
	call	prbs_3, 0
	 nop
	mov	%o0, %g1
	stb	%g1, [%fp-5]
	ldub	[%fp-5], %g1
	or	%g1, 16, %g1
	stb	%g1, [%fp-34]
	ldub	[%fp-5], %g1
	and	%g1, 0xff, %g1
	mov	%g1, %o0
	call	prbs_3, 0
	 nop
	mov	%o0, %g1
	stb	%g1, [%fp-5]
	ldub	[%fp-5], %g1
	or	%g1, 16, %g1
	stb	%g1, [%fp-35]
	ld	[%fp-4], %g1
	add	%g1, %g1, %g1
	sll	%g1, 2, %g2
	add	%g1, %g2, %g1
	add	%g1, 3, %i5
	ldub	[%fp-34], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g3
	ldub	[%fp-13], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	ldub	[%fp-56], %g1
	and	%g1, 0xff, %g1
	mov	%g3, %o0
	mov	%g2, %o1
	mov	0, %o2
	mov	%g1, %o3
	mov	1, %o4
	mov	0, %o5
	call	generate_opcode_11, 0
	 nop
	mov	%o0, %g3
	ld	[%fp-28], %g2
	sll	%i5, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-4], %g1
	add	%g1, %g1, %g1
	sll	%g1, 2, %g2
	add	%g1, %g2, %g1
	add	%g1, 4, %i5
	ldub	[%fp-35], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g3
	ldub	[%fp-13], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	ldub	[%fp-56], %g1
	and	%g1, 0xff, %g1
	mov	%g3, %o0
	mov	%g2, %o1
	mov	0, %o2
	mov	%g1, %o3
	mov	1, %o4
	mov	4, %o5
	call	generate_opcode_11, 0
	 nop
	mov	%o0, %g3
	ld	[%fp-28], %g2
	sll	%i5, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-4], %g1
	add	%g1, %g1, %g1
	sll	%g1, 2, %g2
	add	%g1, %g2, %g1
	add	%g1, 5, %i5
	ldub	[%fp-33], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g4
	ldub	[%fp-34], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g3
	ldub	[%fp-35], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	ldub	[%fp-40], %g1
	and	%g1, 0xff, %g1
	mov	%g4, %o0
	mov	%g3, %o1
	mov	%g2, %o2
	mov	%g1, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g3
	ld	[%fp-28], %g2
	sll	%i5, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-4], %g1
	add	%g1, %g1, %g1
	sll	%g1, 2, %g2
	add	%g1, %g2, %g1
	add	%g1, 6, %i5
	mov	4, %o0
	mov	0, %o1
	mov	0, %o2
	mov	41, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g3
	ld	[%fp-28], %g2
	sll	%i5, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-4], %g1
	add	%g1, %g1, %g1
	sll	%g1, 2, %g2
	add	%g1, %g2, %g1
	add	%g1, 7, %i5
	ldub	[%fp-13], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	ldub	[%fp-55], %g1
	and	%g1, 0xff, %g1
	mov	4, %o0
	mov	%g2, %o1
	mov	0, %o2
	mov	%g1, %o3
	mov	1, %o4
	mov	16, %o5
	call	generate_opcode_11, 0
	 nop
	mov	%o0, %g3
	ld	[%fp-28], %g2
	sll	%i5, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-4], %g1
	add	%g1, %g1, %g1
	sll	%g1, 2, %g2
	add	%g1, %g2, %g1
	add	%g1, 8, %i5
	ldub	[%fp-34], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g4
	ldub	[%fp-33], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g3
	ldub	[%fp-34], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	ldub	[%fp-39], %g1
	and	%g1, 0xff, %g1
	mov	%g4, %o0
	mov	%g3, %o1
	mov	%g2, %o2
	mov	%g1, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g3
	ld	[%fp-28], %g2
	sll	%i5, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-4], %g1
	add	%g1, %g1, %g1
	sll	%g1, 2, %g2
	add	%g1, %g2, %g1
	add	%g1, 9, %i5
	ldub	[%fp-35], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g4
	ldub	[%fp-33], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g3
	ldub	[%fp-35], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	ldub	[%fp-39], %g1
	and	%g1, 0xff, %g1
	mov	%g4, %o0
	mov	%g3, %o1
	mov	%g2, %o2
	mov	%g1, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g3
	ld	[%fp-28], %g2
	sll	%i5, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	add	%g1, %g1, %g1
	sll	%g1, 2, %g2
	add	%g1, %g2, %i5
	ldub	[%fp-34], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g3
	ldub	[%fp-13], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	ldub	[%fp-55], %g1
	and	%g1, 0xff, %g1
	mov	%g3, %o0
	mov	%g2, %o1
	mov	0, %o2
	mov	%g1, %o3
	mov	1, %o4
	mov	8, %o5
	call	generate_opcode_11, 0
	 nop
	mov	%o0, %g3
	ld	[%fp-28], %g2
	sll	%i5, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-4], %g1
	add	%g1, %g1, %g1
	sll	%g1, 2, %g2
	add	%g1, %g2, %g1
	add	%g1, 11, %i5
	ldub	[%fp-35], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g3
	ldub	[%fp-13], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	ldub	[%fp-55], %g1
	and	%g1, 0xff, %g1
	mov	%g3, %o0
	mov	%g2, %o1
	mov	0, %o2
	mov	%g1, %o3
	mov	1, %o4
	mov	12, %o5
	call	generate_opcode_11, 0
	 nop
	mov	%o0, %g3
	ld	[%fp-28], %g2
	sll	%i5, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-4], %g1
	add	%g1, %g1, %g1
	sll	%g1, 2, %g2
	add	%g1, %g2, %g1
	add	%g1, 12, %i5
	ldub	[%fp-13], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	ldub	[%fp-13], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	mov	%g2, %o0
	mov	%g1, %o1
	mov	0, %o2
	mov	0, %o3
	mov	1, %o4
	mov	24, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g3
	ld	[%fp-28], %g2
	sll	%i5, 2, %g1
	st	%g3, [%g2+%g1]
	ldub	[%fp-34], %g1
	and	%g1, 0xff, %g1
	and	%g1, 7, %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sll	%g1, 2, %g1
	ld	[%fp+72], %g2
	add	%g2, %g1, %g3
	ldub	[%fp-34], %g1
	and	%g1, 0xff, %g1
	and	%g1, 7, %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sll	%g1, 2, %g1
	ld	[%fp+72], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	add	%g1, 1, %g1
	st	%g1, [%g3]
	ldub	[%fp-35], %g1
	and	%g1, 0xff, %g1
	and	%g1, 7, %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sll	%g1, 2, %g1
	add	%g1, 4, %g1
	ld	[%fp+72], %g2
	add	%g2, %g1, %g3
	ldub	[%fp-35], %g1
	and	%g1, 0xff, %g1
	and	%g1, 7, %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sll	%g1, 2, %g1
	add	%g1, 4, %g1
	ld	[%fp+72], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	add	%g1, 1, %g1
	st	%g1, [%g3]
	ldub	[%fp-33], %g1
	and	%g1, 0xff, %g1
	and	%g1, 7, %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sll	%g1, 2, %g1
	add	%g1, 8, %g1
	ld	[%fp+72], %g2
	add	%g2, %g1, %g3
	ldub	[%fp-33], %g1
	and	%g1, 0xff, %g1
	and	%g1, 7, %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sll	%g1, 2, %g1
	add	%g1, 8, %g1
	ld	[%fp+72], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	add	%g1, 1, %g1
	st	%g1, [%g3]
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L14:
	ld	[%fp-4], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bl	.L15
	 nop
	ld	[%fp-20], %g1
	add	%g1, -3, %g1
	ld	[%fp-28], %g2
	sll	%g1, 2, %g1
	sethi	%hi(-2115502080), %g3
	st	%g3, [%g2+%g1]
	ld	[%fp-20], %g1
	add	%g1, -2, %g1
	ld	[%fp-28], %g2
	sll	%g1, 2, %g1
	sethi	%hi(-2117869568), %g3
	or	%g3, 8, %g3
	st	%g3, [%g2+%g1]
	ld	[%fp-20], %g1
	add	%g1, -1, %g1
	ld	[%fp-28], %g2
	sll	%g1, 2, %g1
	sethi	%hi(16777216), %g3
	st	%g3, [%g2+%g1]
#APP
! 147 "add/add.c" 1
	 set instr_section, %l0
	 
! 0 "" 2
#NO_APP
	st	%g0, [%fp-4]
	b	.L16
	 nop
.L17:
	ld	[%fp-28], %g2
	ld	[%fp-4], %g1
	sll	%g1, 2, %g1
	ld	[%g2+%g1], %g1
#APP
! 149 "add/add.c" 1
	 mov %g1, %l1 
	 
! 0 "" 2
! 150 "add/add.c" 1
	 st %l1, [%l0] 
	 
! 0 "" 2
! 151 "add/add.c" 1
	 add %l0, 0x4, %l0
	 
! 0 "" 2
#NO_APP
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L16:
	ld	[%fp-4], %g2
	ld	[%fp-20], %g1
	cmp	%g2, %g1
	bl	.L17
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	call	ee_printf, 0
	 nop
	mov	1, %g1
	mov	%i1, %sp
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	add, .-add
	.ident	"GCC: (Buildroot 2014.08-g1414aea) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

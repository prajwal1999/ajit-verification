	.file	"instr_sel.c"
	.section	".text"
	.align 4
	.global instr_sel
	.type	instr_sel, #function
	.proc	02
instr_sel:
	save	%sp, -96, %sp
	st	%i0, [%fp+68]
	ld	[%fp+68], %g1
	cmp	%g1, 0
	bne	.L2
	 nop
	mov	0, %g1
	b	.L3
	 nop
.L2:
	ld	[%fp+68], %g1
	cmp	%g1, 1
	bne	.L4
	 nop
	mov	4, %g1
	b	.L3
	 nop
.L4:
	ld	[%fp+68], %g1
	cmp	%g1, 2
	bne	.L5
	 nop
	mov	10, %g1
	b	.L3
	 nop
.L5:
	ld	[%fp+68], %g1
	cmp	%g1, 3
	bne	.L6
	 nop
	mov	14, %g1
	b	.L3
	 nop
.L6:
	b	.L1
	 nop
.L3:
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
.L1:
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	instr_sel, .-instr_sel
	.align 4
	.global bring_complement_instr
	.type	bring_complement_instr, #function
	.proc	02
bring_complement_instr:
	save	%sp, -96, %sp
	mov	%i0, %g1
	stb	%g1, [%fp+68]
	ldub	[%fp+68], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	bne	.L8
	 nop
	mov	4, %g1
	b	.L9
	 nop
.L8:
	ldub	[%fp+68], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 4
	bne	.L10
	 nop
	mov	0, %g1
	b	.L9
	 nop
.L10:
	ldub	[%fp+68], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 14
	bne	.L11
	 nop
	mov	10, %g1
	b	.L9
	 nop
.L11:
	ldub	[%fp+68], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 10
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
	.size	bring_complement_instr, .-bring_complement_instr
	.ident	"GCC: (Buildroot 2014.08-gacf8924) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

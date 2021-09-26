	.file	"main.c"
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
	.align 4
	.global prbs_4
	.type	prbs_4, #function
	.proc	014
prbs_4:
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
	sll	%g1, 3, %g1
	or	%g2, %g1, %g1
	stb	%g1, [%fp+68]
	ldub	[%fp+68], %g1
	and	%g1, 0xff, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	prbs_4, .-prbs_4
	.global instr_types
	.section	".data"
	.type	instr_types, #object
	.size	instr_types, 60
instr_types:
	.asciz	"branch"
	.skip	8
	.asciz	"logical"
	.skip	7
	.asciz	"arithmetic"
	.skip	4
	.asciz	"load_store"
	.skip	4
	.global branch
	.type	branch, #object
	.size	branch, 50
branch:
	.asciz	"ba"
	.skip	2
	.asciz	"bn"
	.skip	2
	.asciz	"bne"
	.skip	1
	.asciz	"be"
	.skip	2
	.skip	30
	.global logical
	.type	logical, #object
	.size	logical, 105
logical:
	.asciz	"and"
	.skip	3
	.asciz	"andcc"
	.skip	1
	.asciz	"andncc"
	.asciz	"andn"
	.skip	2
	.asciz	"or"
	.skip	4
	.asciz	"orn"
	.skip	3
	.asciz	"orncc"
	.skip	1
	.asciz	"orcc"
	.skip	2
	.asciz	"xor"
	.skip	3
	.asciz	"xorcc"
	.skip	1
	.asciz	"xnorcc"
	.asciz	"xnor"
	.skip	2
	.asciz	"sll"
	.skip	3
	.asciz	"srl"
	.skip	3
	.asciz	"sra"
	.skip	3
	.global arithmetic
	.type	arithmetic, #object
	.size	arithmetic, 91
arithmetic:
	.asciz	"add"
	.skip	3
	.asciz	"addcc"
	.skip	1
	.asciz	"subcc"
	.skip	1
	.asciz	"sub"
	.skip	3
	.asciz	"mulscc"
	.asciz	"umulcc"
	.asciz	"umul"
	.skip	2
	.asciz	"smul"
	.skip	2
	.asciz	"smulcc"
	.asciz	"udiv"
	.skip	2
	.asciz	"udivcc"
	.asciz	"sdivcc"
	.asciz	"sdiv"
	.skip	2
	.global r_arithmetic
	.type	r_arithmetic, #object
	.size	r_arithmetic, 91
r_arithmetic:
	.asciz	"sub"
	.skip	3
	.asciz	"subcc"
	.skip	1
	.asciz	"addcc"
	.skip	1
	.asciz	"add"
	.skip	3
	.asciz	"mulscc"
	.asciz	"udivcc"
	.asciz	"udiv"
	.skip	2
	.asciz	"sdiv"
	.skip	2
	.asciz	"sdivcc"
	.asciz	"umul"
	.skip	2
	.asciz	"umulcc"
	.asciz	"smulcc"
	.asciz	"umul"
	.skip	2
	.global load_store
	.type	load_store, #object
	.size	load_store, 60
load_store:
	.asciz	"ldsh"
	.skip	1
	.asciz	"lduh"
	.skip	1
	.asciz	"ld"
	.skip	3
	.asciz	"st"
	.skip	3
	.asciz	"std"
	.skip	2
	.asciz	"ldsb"
	.skip	1
	.asciz	"ldd"
	.skip	2
	.asciz	"sth"
	.skip	2
	.asciz	"stb"
	.skip	2
	.asciz	"ldub"
	.skip	1
	.global l_regs
	.type	l_regs, #object
	.size	l_regs, 27
l_regs:
	.asciz	"l0"
	.asciz	"l1"
	.asciz	"l2"
	.asciz	"l3"
	.asciz	"l4"
	.asciz	"l5"
	.asciz	"l6"
	.asciz	"l7"
	.asciz	""
	.skip	2
	.section	".rodata"
	.align 8
.LC0:
	.asciz	"%s %s, %s, %s    %s %s, %s, %s\n"
	.section	".text"
	.align 4
	.global main
	.type	main, #function
	.proc	04
main:
	save	%sp, -3160, %sp
	mov	3, %o0
	call	__ajit_write_serial_control_register__, 0
	 nop
	mov	20, %g1
	st	%g1, [%fp-16]
	sethi	%hi(17408), %g1
	or	%g1, 310, %g1
	sth	%g1, [%fp-2]
	st	%g0, [%fp-20]
	st	%g0, [%fp-24]
	mov	5, %g1
	stb	%g1, [%fp-3]
	st	%g0, [%fp-8]
	mov	13, %g1
	stb	%g1, [%fp-9]
	b	.L6
	 nop
.L22:
	lduh	[%fp-2], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	mov	%g1, %o0
	call	prbs, 0
	 nop
	mov	%o0, %g1
	sth	%g1, [%fp-2]
	lduh	[%fp-2], %g1
	and	%g1, 15, %g1
	sth	%g1, [%fp-26]
	lduh	[%fp-26], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	cmp	%g1, 0
	be	.L7
	 nop
	lduh	[%fp-26], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	cmp	%g1, 4
	be	.L7
	 nop
	lduh	[%fp-26], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	cmp	%g1, 5
	be	.L7
	 nop
	lduh	[%fp-26], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	cmp	%g1, 11
	be	.L7
	 nop
	lduh	[%fp-26], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	cmp	%g1, 14
	be	.L7
	 nop
	lduh	[%fp-26], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	cmp	%g1, 15
	bne	.L8
	 nop
.L7:
	ldub	[%fp-9], %g1
	and	%g1, 0xff, %g1
	mov	%g1, %o0
	call	prbs_4, 0
	 nop
	mov	%o0, %g1
	stb	%g1, [%fp-9]
	ldub	[%fp-9], %g1
	and	%g1, 0xff, %g1
	cmp	%g1, 14
	bgu	.L9
	 nop
	ldub	[%fp-9], %g1
	and	%g1, 0xff, %g1
	b	.L10
	 nop
.L9:
	mov	0, %g1
.L10:
	sth	%g1, [%fp-42]
	b	.L11
	 nop
.L8:
	lduh	[%fp-26], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	cmp	%g1, 1
	be	.L12
	 nop
	lduh	[%fp-26], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	cmp	%g1, 3
	be	.L12
	 nop
	lduh	[%fp-26], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	cmp	%g1, 7
	be	.L12
	 nop
	lduh	[%fp-26], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	cmp	%g1, 10
	be	.L12
	 nop
	lduh	[%fp-26], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	cmp	%g1, 12
	be	.L12
	 nop
	lduh	[%fp-26], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	cmp	%g1, 13
	bne	.L13
	 nop
.L12:
	ldub	[%fp-9], %g1
	and	%g1, 0xff, %g1
	mov	%g1, %o0
	call	prbs_4, 0
	 nop
	mov	%o0, %g1
	stb	%g1, [%fp-9]
	ldub	[%fp-9], %g1
	and	%g1, 0xff, %g1
	cmp	%g1, 13
	bgu	.L14
	 nop
	ldub	[%fp-9], %g1
	and	%g1, 0xff, %g1
	b	.L15
	 nop
.L14:
	mov	0, %g1
.L15:
	sth	%g1, [%fp-32]
	ldub	[%fp-3], %g1
	and	%g1, 0xff, %g1
	mov	%g1, %o0
	call	prbs_4, 0
	 nop
	mov	%o0, %g1
	stb	%g1, [%fp-3]
	ldub	[%fp-3], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	sra	%g2, 31, %g1
	srl	%g1, 29, %g1
	add	%g2, %g1, %g2
	and	%g2, 7, %g2
	sub	%g2, %g1, %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sethi	%hi(l_regs), %g2
	or	%g2, %lo(l_regs), %g2
	add	%g1, %g2, %g1
	st	%g1, [%fp-36]
	ldub	[%fp-3], %g1
	and	%g1, 0xff, %g1
	mov	%g1, %o0
	call	prbs_4, 0
	 nop
	mov	%o0, %g1
	stb	%g1, [%fp-3]
	ldub	[%fp-3], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	sra	%g2, 31, %g1
	srl	%g1, 29, %g1
	add	%g2, %g1, %g2
	and	%g2, 7, %g2
	sub	%g2, %g1, %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sethi	%hi(l_regs), %g2
	or	%g2, %lo(l_regs), %g2
	add	%g1, %g2, %g1
	st	%g1, [%fp-40]
	lduh	[%fp-32], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g2
	mov	%g2, %g1
	sll	%g1, 3, %g1
	sub	%g1, %g2, %g1
	sethi	%hi(arithmetic), %g2
	or	%g2, %lo(arithmetic), %g2
	add	%g1, %g2, %g3
	lduh	[%fp-32], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g2
	mov	%g2, %g1
	sll	%g1, 3, %g1
	sub	%g1, %g2, %g1
	sethi	%hi(r_arithmetic), %g2
	or	%g2, %lo(r_arithmetic), %g2
	add	%g1, %g2, %g1
	ld	[%fp-36], %g2
	st	%g2, [%sp+92]
	ld	[%fp-40], %g2
	st	%g2, [%sp+96]
	ld	[%fp-36], %g2
	st	%g2, [%sp+100]
	sethi	%hi(.LC0), %g2
	or	%g2, %lo(.LC0), %o0
	mov	%g3, %o1
	ld	[%fp-36], %o2
	ld	[%fp-40], %o3
	ld	[%fp-36], %o4
	mov	%g1, %o5
	call	ee_printf, 0
	 nop
	b	.L11
	 nop
.L13:
	lduh	[%fp-26], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	cmp	%g1, 2
	be	.L16
	 nop
	lduh	[%fp-26], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	cmp	%g1, 6
	be	.L16
	 nop
	lduh	[%fp-26], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	cmp	%g1, 8
	bne	.L17
	 nop
.L16:
	ldub	[%fp-9], %g1
	and	%g1, 0xff, %g1
	mov	%g1, %o0
	call	prbs_4, 0
	 nop
	mov	%o0, %g1
	stb	%g1, [%fp-9]
	ldub	[%fp-9], %g1
	and	%g1, 0xff, %g1
	cmp	%g1, 10
	bgu	.L18
	 nop
	ldub	[%fp-9], %g1
	and	%g1, 0xff, %g1
	b	.L19
	 nop
.L18:
	mov	0, %g1
.L19:
	sth	%g1, [%fp-30]
	b	.L11
	 nop
.L17:
	lduh	[%fp-26], %g1
	sll	%g1, 16, %g1
	sra	%g1, 16, %g1
	cmp	%g1, 9
	bne	.L11
	 nop
	ldub	[%fp-9], %g1
	and	%g1, 0xff, %g1
	mov	%g1, %o0
	call	prbs_4, 0
	 nop
	mov	%o0, %g1
	stb	%g1, [%fp-9]
	ldub	[%fp-9], %g1
	and	%g1, 0xff, %g1
	cmp	%g1, 10
	bgu	.L20
	 nop
	ldub	[%fp-9], %g1
	and	%g1, 0xff, %g1
	b	.L21
	 nop
.L20:
	mov	0, %g1
.L21:
	sth	%g1, [%fp-28]
.L11:
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L6:
	ld	[%fp-8], %g2
	ld	[%fp-16], %g1
	cmp	%g2, %g1
	bl	.L22
	 nop
	mov	1, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	main, .-main
	.ident	"GCC: (Buildroot 2014.08-g230601f) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

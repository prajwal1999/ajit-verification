	.file	"ee_printf.c"
	.section	".rodata"
	.align 8
.LC0:
	.asciz	"0123456789abcdefghijklmnopqrstuvwxyz"
	.section	".data"
	.align 4
	.type	digits, #object
	.size	digits, 4
digits:
	.long	.LC0
	.section	".rodata"
	.align 8
.LC1:
	.asciz	"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	.section	".data"
	.align 4
	.type	upper_digits, #object
	.size	upper_digits, 4
upper_digits:
	.long	.LC1
	.section	".text"
	.align 4
	.type	strnlen, #function
	.proc	016
strnlen:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	ld	[%fp+68], %g1
	st	%g1, [%fp-4]
	b	.L2
	 nop
.L4:
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L2:
	ld	[%fp-4], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	be	.L3
	 nop
	ld	[%fp+72], %g1
	xor	%g1, 0, %g1
	subcc	%g0, %g1, %g0
	addx	%g0, 0, %g1
	ld	[%fp+72], %g2
	add	%g2, -1, %g2
	st	%g2, [%fp+72]
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	bne	.L4
	 nop
.L3:
	ld	[%fp-4], %g2
	ld	[%fp+68], %g1
	sub	%g2, %g1, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	strnlen, .-strnlen
	.align 4
	.type	skip_atoi, #function
	.proc	04
skip_atoi:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%g0, [%fp-4]
	b	.L7
	 nop
.L9:
	ld	[%fp-4], %g1
	add	%g1, %g1, %g1
	sll	%g1, 2, %g2
	add	%g1, %g2, %g3
	ld	[%fp+68], %g1
	ld	[%g1], %g1
	ldub	[%g1], %g2
	sll	%g2, 24, %g2
	sra	%g2, 24, %g2
	add	%g3, %g2, %g2
	add	%g2, -48, %g2
	st	%g2, [%fp-4]
	add	%g1, 1, %g2
	ld	[%fp+68], %g1
	st	%g2, [%g1]
.L7:
	ld	[%fp+68], %g1
	ld	[%g1], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 47
	ble	.L8
	 nop
	ld	[%fp+68], %g1
	ld	[%g1], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 57
	ble	.L9
	 nop
.L8:
	ld	[%fp-4], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	skip_atoi, .-skip_atoi
	.align 4
	.type	number, #function
	.proc	0102
number:
	save	%sp, -176, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	st	%i3, [%fp+80]
	st	%i4, [%fp+84]
	st	%i5, [%fp+88]
	sethi	%hi(digits), %g1
	or	%g1, %lo(digits), %g1
	ld	[%g1], %g1
	st	%g1, [%fp-8]
	ld	[%fp+88], %g1
	and	%g1, 64, %g1
	cmp	%g1, 0
	be	.L12
	 nop
	sethi	%hi(upper_digits), %g1
	or	%g1, %lo(upper_digits), %g1
	ld	[%g1], %g1
	st	%g1, [%fp-8]
.L12:
	ld	[%fp+88], %g1
	and	%g1, 16, %g1
	cmp	%g1, 0
	be	.L13
	 nop
	ld	[%fp+88], %g1
	and	%g1, -2, %g1
	st	%g1, [%fp+88]
.L13:
	ld	[%fp+76], %g1
	cmp	%g1, 1
	ble	.L14
	 nop
	ld	[%fp+76], %g1
	cmp	%g1, 36
	ble	.L15
	 nop
.L14:
	mov	0, %g1
	b	.L45
	 nop
.L15:
	ld	[%fp+88], %g1
	and	%g1, 1, %g1
	cmp	%g1, 0
	be	.L17
	 nop
	mov	48, %g1
	b	.L18
	 nop
.L17:
	mov	32, %g1
.L18:
	stb	%g1, [%fp-13]
	stb	%g0, [%fp-1]
	ld	[%fp+88], %g1
	and	%g1, 2, %g1
	cmp	%g1, 0
	be	.L19
	 nop
	ld	[%fp+72], %g1
	cmp	%g1, 0
	bge	.L20
	 nop
	mov	45, %g1
	stb	%g1, [%fp-1]
	ld	[%fp+72], %g1
	sub	%g0, %g1, %g1
	st	%g1, [%fp+72]
	ld	[%fp+80], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp+80]
	b	.L19
	 nop
.L20:
	ld	[%fp+88], %g1
	and	%g1, 4, %g1
	cmp	%g1, 0
	be	.L21
	 nop
	mov	43, %g1
	stb	%g1, [%fp-1]
	ld	[%fp+80], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp+80]
	b	.L19
	 nop
.L21:
	ld	[%fp+88], %g1
	and	%g1, 8, %g1
	cmp	%g1, 0
	be	.L19
	 nop
	mov	32, %g1
	stb	%g1, [%fp-1]
	ld	[%fp+80], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp+80]
.L19:
	ld	[%fp+88], %g1
	and	%g1, 32, %g1
	cmp	%g1, 0
	be	.L22
	 nop
	ld	[%fp+76], %g1
	cmp	%g1, 16
	bne	.L23
	 nop
	ld	[%fp+80], %g1
	add	%g1, -2, %g1
	st	%g1, [%fp+80]
	b	.L22
	 nop
.L23:
	ld	[%fp+76], %g1
	cmp	%g1, 8
	bne	.L22
	 nop
	ld	[%fp+80], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp+80]
.L22:
	st	%g0, [%fp-12]
	ld	[%fp+72], %g1
	cmp	%g1, 0
	bne	.L26
	 nop
	ld	[%fp-12], %g1
	add	%fp, %g1, %g1
	mov	48, %g2
	stb	%g2, [%g1-80]
	ld	[%fp-12], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-12]
	b	.L25
	 nop
.L27:
	ld	[%fp+72], %g1
	ld	[%fp+76], %g2
	wr	%g0, 0, %y
	nop
	nop
	nop
	udiv	%g1, %g2, %g3
	smul	%g3, %g2, %g2
	sub	%g1, %g2, %g1
	ld	[%fp-8], %g2
	add	%g2, %g1, %g1
	ldub	[%g1], %g2
	ld	[%fp-12], %g1
	add	%fp, %g1, %g1
	stb	%g2, [%g1-80]
	ld	[%fp-12], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-12]
	ld	[%fp+72], %g3
	ld	[%fp+76], %g2
	wr	%g0, 0, %y
	nop
	nop
	nop
	udiv	%g3, %g2, %g1
	st	%g1, [%fp+72]
.L26:
	ld	[%fp+72], %g1
	cmp	%g1, 0
	bne	.L27
	 nop
.L25:
	ld	[%fp-12], %g2
	ld	[%fp+84], %g1
	cmp	%g2, %g1
	ble	.L28
	 nop
	ld	[%fp-12], %g1
	st	%g1, [%fp+84]
.L28:
	ld	[%fp+80], %g2
	ld	[%fp+84], %g1
	sub	%g2, %g1, %g1
	st	%g1, [%fp+80]
	ld	[%fp+88], %g1
	and	%g1, 17, %g1
	cmp	%g1, 0
	bne	.L29
	 nop
	b	.L30
	 nop
.L31:
	ld	[%fp+68], %g1
	mov	32, %g2
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
.L30:
	ld	[%fp+80], %g1
	sra	%g1, 31, %g2
	ld	[%fp+80], %g1
	sub	%g2, %g1, %g1
	srl	%g1, 31, %g1
	ld	[%fp+80], %g2
	add	%g2, -1, %g2
	st	%g2, [%fp+80]
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	bne	.L31
	 nop
.L29:
	ldub	[%fp-1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	be	.L32
	 nop
	ld	[%fp+68], %g1
	ldub	[%fp-1], %g2
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
.L32:
	ld	[%fp+88], %g1
	and	%g1, 32, %g1
	cmp	%g1, 0
	be	.L33
	 nop
	ld	[%fp+76], %g1
	cmp	%g1, 8
	bne	.L34
	 nop
	ld	[%fp+68], %g1
	mov	48, %g2
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
	b	.L33
	 nop
.L34:
	ld	[%fp+76], %g1
	cmp	%g1, 16
	bne	.L33
	 nop
	ld	[%fp+68], %g1
	mov	48, %g2
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
	sethi	%hi(digits), %g1
	or	%g1, %lo(digits), %g1
	ld	[%g1], %g1
	ldub	[%g1+33], %g2
	ld	[%fp+68], %g1
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
.L33:
	ld	[%fp+88], %g1
	and	%g1, 16, %g1
	cmp	%g1, 0
	bne	.L46
	 nop
	b	.L36
	 nop
.L37:
	ld	[%fp+68], %g1
	ldub	[%fp-13], %g2
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
.L36:
	ld	[%fp+80], %g1
	sra	%g1, 31, %g2
	ld	[%fp+80], %g1
	sub	%g2, %g1, %g1
	srl	%g1, 31, %g1
	ld	[%fp+80], %g2
	add	%g2, -1, %g2
	st	%g2, [%fp+80]
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	bne	.L37
	 nop
	b	.L46
	 nop
.L40:
	ld	[%fp+68], %g1
	mov	48, %g2
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
	b	.L38
	 nop
.L46:
	nop
.L38:
	mov	1, %g1
	ld	[%fp+84], %g3
	ld	[%fp-12], %g2
	cmp	%g3, %g2
	bg	.L39
	 nop
	mov	0, %g1
.L39:
	ld	[%fp+84], %g2
	add	%g2, -1, %g2
	st	%g2, [%fp+84]
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	bne	.L40
	 nop
	b	.L41
	 nop
.L42:
	ld	[%fp-12], %g1
	add	%fp, %g1, %g1
	ldub	[%g1-80], %g2
	ld	[%fp+68], %g1
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
.L41:
	ld	[%fp-12], %g1
	sra	%g1, 31, %g2
	ld	[%fp-12], %g1
	sub	%g2, %g1, %g1
	srl	%g1, 31, %g1
	ld	[%fp-12], %g2
	add	%g2, -1, %g2
	st	%g2, [%fp-12]
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	bne	.L42
	 nop
	b	.L43
	 nop
.L44:
	ld	[%fp+68], %g1
	mov	32, %g2
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
.L43:
	ld	[%fp+80], %g1
	sra	%g1, 31, %g2
	ld	[%fp+80], %g1
	sub	%g2, %g1, %g1
	srl	%g1, 31, %g1
	ld	[%fp+80], %g2
	add	%g2, -1, %g2
	st	%g2, [%fp+80]
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	bne	.L44
	 nop
	ld	[%fp+68], %g1
.L45:
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	number, .-number
	.align 4
	.type	eaddr, #function
	.proc	0102
eaddr:
	save	%sp, -136, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	st	%i3, [%fp+80]
	st	%i4, [%fp+84]
	sethi	%hi(digits), %g1
	or	%g1, %lo(digits), %g1
	ld	[%g1], %g1
	st	%g1, [%fp-4]
	ld	[%fp+84], %g1
	and	%g1, 64, %g1
	cmp	%g1, 0
	be	.L48
	 nop
	sethi	%hi(upper_digits), %g1
	or	%g1, %lo(upper_digits), %g1
	ld	[%g1], %g1
	st	%g1, [%fp-4]
.L48:
	st	%g0, [%fp-12]
	st	%g0, [%fp-8]
	b	.L49
	 nop
.L51:
	ld	[%fp-8], %g1
	cmp	%g1, 0
	be	.L50
	 nop
	ld	[%fp-12], %g1
	add	%fp, %g1, %g1
	mov	58, %g2
	stb	%g2, [%g1-40]
	ld	[%fp-12], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-12]
.L50:
	ld	[%fp-8], %g1
	ld	[%fp+72], %g2
	add	%g2, %g1, %g1
	ldub	[%g1], %g1
	and	%g1, 0xff, %g1
	srl	%g1, 4, %g1
	and	%g1, 0xff, %g1
	ld	[%fp-4], %g2
	add	%g2, %g1, %g1
	ldub	[%g1], %g2
	ld	[%fp-12], %g1
	add	%fp, %g1, %g1
	stb	%g2, [%g1-40]
	ld	[%fp-12], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-12]
	ld	[%fp-8], %g1
	ld	[%fp+72], %g2
	add	%g2, %g1, %g1
	ldub	[%g1], %g1
	and	%g1, 0xff, %g1
	and	%g1, 15, %g1
	ld	[%fp-4], %g2
	add	%g2, %g1, %g1
	ldub	[%g1], %g2
	ld	[%fp-12], %g1
	add	%fp, %g1, %g1
	stb	%g2, [%g1-40]
	ld	[%fp-12], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-12]
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L49:
	ld	[%fp-8], %g1
	cmp	%g1, 5
	ble	.L51
	 nop
	ld	[%fp+84], %g1
	and	%g1, 16, %g1
	cmp	%g1, 0
	bne	.L52
	 nop
	b	.L53
	 nop
.L55:
	ld	[%fp+68], %g1
	mov	32, %g2
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
.L53:
	mov	1, %g1
	ld	[%fp+76], %g3
	ld	[%fp-12], %g2
	cmp	%g3, %g2
	bg	.L54
	 nop
	mov	0, %g1
.L54:
	ld	[%fp+76], %g2
	add	%g2, -1, %g2
	st	%g2, [%fp+76]
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	bne	.L55
	 nop
.L52:
	st	%g0, [%fp-8]
	b	.L56
	 nop
.L57:
	ld	[%fp-8], %g1
	add	%fp, %g1, %g1
	ldub	[%g1-40], %g2
	ld	[%fp+68], %g1
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L56:
	ld	[%fp-8], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bl	.L57
	 nop
	b	.L58
	 nop
.L60:
	ld	[%fp+68], %g1
	mov	32, %g2
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
.L58:
	mov	1, %g1
	ld	[%fp+76], %g3
	ld	[%fp-12], %g2
	cmp	%g3, %g2
	bg	.L59
	 nop
	mov	0, %g1
.L59:
	ld	[%fp+76], %g2
	add	%g2, -1, %g2
	st	%g2, [%fp+76]
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	bne	.L60
	 nop
	ld	[%fp+68], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	eaddr, .-eaddr
	.align 4
	.type	iaddr, #function
	.proc	0102
iaddr:
	save	%sp, -136, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	st	%i3, [%fp+80]
	st	%i4, [%fp+84]
	st	%g0, [%fp-12]
	st	%g0, [%fp-4]
	b	.L63
	 nop
.L69:
	ld	[%fp-4], %g1
	cmp	%g1, 0
	be	.L64
	 nop
	ld	[%fp-12], %g1
	add	%fp, %g1, %g1
	mov	46, %g2
	stb	%g2, [%g1-40]
	ld	[%fp-12], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-12]
.L64:
	ld	[%fp-4], %g1
	ld	[%fp+72], %g2
	add	%g2, %g1, %g1
	ldub	[%g1], %g1
	and	%g1, 0xff, %g1
	st	%g1, [%fp-8]
	ld	[%fp-8], %g1
	cmp	%g1, 0
	bne	.L65
	 nop
	sethi	%hi(digits), %g1
	or	%g1, %lo(digits), %g1
	ld	[%g1], %g1
	ldub	[%g1], %g2
	ld	[%fp-12], %g1
	add	%fp, %g1, %g1
	stb	%g2, [%g1-40]
	ld	[%fp-12], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-12]
	b	.L66
	 nop
.L65:
	ld	[%fp-8], %g1
	cmp	%g1, 99
	ble	.L67
	 nop
	sethi	%hi(digits), %g1
	or	%g1, %lo(digits), %g1
	ld	[%g1], %g2
	ld	[%fp-8], %g1
	sra	%g1, 31, %g3
	wr	%g3, 0, %y
	nop
	nop
	nop
	sdiv	%g1, 100, %g1
	add	%g2, %g1, %g1
	ldub	[%g1], %g2
	ld	[%fp-12], %g1
	add	%fp, %g1, %g1
	stb	%g2, [%g1-40]
	ld	[%fp-12], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-12]
	ld	[%fp-8], %g1
	sra	%g1, 31, %g3
	wr	%g3, 0, %y
	nop
	nop
	nop
	sdiv	%g1, 100, %g2
	smul	%g2, 100, %g2
	sub	%g1, %g2, %g1
	st	%g1, [%fp-8]
	sethi	%hi(digits), %g1
	or	%g1, %lo(digits), %g1
	ld	[%g1], %g2
	ld	[%fp-8], %g1
	sra	%g1, 31, %g3
	wr	%g3, 0, %y
	nop
	nop
	nop
	sdiv	%g1, 10, %g1
	add	%g2, %g1, %g1
	ldub	[%g1], %g2
	ld	[%fp-12], %g1
	add	%fp, %g1, %g1
	stb	%g2, [%g1-40]
	ld	[%fp-12], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-12]
	ld	[%fp-8], %g2
	sra	%g2, 31, %g3
	wr	%g3, 0, %y
	nop
	nop
	nop
	sdiv	%g2, 10, %g1
	add	%g1, %g1, %g1
	sll	%g1, 2, %g3
	add	%g1, %g3, %g1
	sub	%g2, %g1, %g1
	st	%g1, [%fp-8]
	b	.L68
	 nop
.L67:
	ld	[%fp-8], %g1
	cmp	%g1, 9
	ble	.L68
	 nop
	sethi	%hi(digits), %g1
	or	%g1, %lo(digits), %g1
	ld	[%g1], %g2
	ld	[%fp-8], %g1
	sra	%g1, 31, %g3
	wr	%g3, 0, %y
	nop
	nop
	nop
	sdiv	%g1, 10, %g1
	add	%g2, %g1, %g1
	ldub	[%g1], %g2
	ld	[%fp-12], %g1
	add	%fp, %g1, %g1
	stb	%g2, [%g1-40]
	ld	[%fp-12], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-12]
	ld	[%fp-8], %g2
	sra	%g2, 31, %g3
	wr	%g3, 0, %y
	nop
	nop
	nop
	sdiv	%g2, 10, %g1
	add	%g1, %g1, %g1
	sll	%g1, 2, %g3
	add	%g1, %g3, %g1
	sub	%g2, %g1, %g1
	st	%g1, [%fp-8]
.L68:
	sethi	%hi(digits), %g1
	or	%g1, %lo(digits), %g1
	ld	[%g1], %g2
	ld	[%fp-8], %g1
	add	%g2, %g1, %g1
	ldub	[%g1], %g2
	ld	[%fp-12], %g1
	add	%fp, %g1, %g1
	stb	%g2, [%g1-40]
	ld	[%fp-12], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-12]
.L66:
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L63:
	ld	[%fp-4], %g1
	cmp	%g1, 3
	ble	.L69
	 nop
	ld	[%fp+84], %g1
	and	%g1, 16, %g1
	cmp	%g1, 0
	bne	.L70
	 nop
	b	.L71
	 nop
.L73:
	ld	[%fp+68], %g1
	mov	32, %g2
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
.L71:
	mov	1, %g1
	ld	[%fp+76], %g3
	ld	[%fp-12], %g2
	cmp	%g3, %g2
	bg	.L72
	 nop
	mov	0, %g1
.L72:
	ld	[%fp+76], %g2
	add	%g2, -1, %g2
	st	%g2, [%fp+76]
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	bne	.L73
	 nop
.L70:
	st	%g0, [%fp-4]
	b	.L74
	 nop
.L75:
	ld	[%fp-4], %g1
	add	%fp, %g1, %g1
	ldub	[%g1-40], %g2
	ld	[%fp+68], %g1
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L74:
	ld	[%fp-4], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bl	.L75
	 nop
	b	.L76
	 nop
.L78:
	ld	[%fp+68], %g1
	mov	32, %g2
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
.L76:
	mov	1, %g1
	ld	[%fp+76], %g3
	ld	[%fp-12], %g2
	cmp	%g3, %g2
	bg	.L77
	 nop
	mov	0, %g1
.L77:
	ld	[%fp+76], %g2
	add	%g2, -1, %g2
	st	%g2, [%fp+76]
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	bne	.L78
	 nop
	ld	[%fp+68], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	iaddr, .-iaddr
	.section	".rodata"
	.align 8
.LC2:
	.asciz	"<NULL>"
	.section	".text"
	.align 4
	.type	ee_vsprintf, #function
	.proc	04
ee_vsprintf:
	save	%sp, -136, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	ld	[%fp+68], %g1
	st	%g1, [%fp-16]
	b	.L81
	 nop
.L136:
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 37
	be	.L82
	 nop
	ld	[%fp+72], %g1
	ldub	[%g1], %g2
	ld	[%fp-16], %g1
	stb	%g2, [%g1]
	ld	[%fp-16], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-16]
	b	.L83
	 nop
.L82:
	st	%g0, [%fp-24]
.L84:
	ld	[%fp+72], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+72]
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	add	%g1, -32, %g1
	cmp	%g1, 16
	bgu	.L85
	 nop
	sll	%g1, 2, %g2
	sethi	%hi(.L91), %g1
	or	%g1, %lo(.L91), %g1
	ld	[%g2+%g1], %g1
	jmp	%g1
	 nop
	.section	".rodata"
	.section	".text"
.L89:
	ld	[%fp-24], %g1
	or	%g1, 16, %g1
	st	%g1, [%fp-24]
	b	.L84
	 nop
.L88:
	ld	[%fp-24], %g1
	or	%g1, 4, %g1
	st	%g1, [%fp-24]
	b	.L84
	 nop
.L86:
	ld	[%fp-24], %g1
	or	%g1, 8, %g1
	st	%g1, [%fp-24]
	b	.L84
	 nop
.L87:
	ld	[%fp-24], %g1
	or	%g1, 32, %g1
	st	%g1, [%fp-24]
	b	.L84
	 nop
.L90:
	ld	[%fp-24], %g1
	or	%g1, 1, %g1
	st	%g1, [%fp-24]
	b	.L84
	 nop
.L85:
	mov	-1, %g1
	st	%g1, [%fp-28]
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 47
	ble	.L92
	 nop
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 57
	bg	.L92
	 nop
	add	%fp, 72, %g1
	mov	%g1, %o0
	call	skip_atoi, 0
	 nop
	st	%o0, [%fp-28]
	b	.L93
	 nop
.L92:
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 42
	bne	.L93
	 nop
	ld	[%fp+72], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+72]
	ld	[%fp+76], %g1
	ld	[%g1], %g1
	st	%g1, [%fp-28]
	ld	[%fp+76], %g1
	add	%g1, 4, %g1
	st	%g1, [%fp+76]
	ld	[%fp-28], %g1
	cmp	%g1, 0
	bge	.L93
	 nop
	ld	[%fp-28], %g1
	sub	%g0, %g1, %g1
	st	%g1, [%fp-28]
	ld	[%fp-24], %g1
	or	%g1, 16, %g1
	st	%g1, [%fp-24]
.L93:
	mov	-1, %g1
	st	%g1, [%fp-32]
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 46
	bne	.L94
	 nop
	ld	[%fp+72], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+72]
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 47
	ble	.L95
	 nop
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 57
	bg	.L95
	 nop
	add	%fp, 72, %g1
	mov	%g1, %o0
	call	skip_atoi, 0
	 nop
	st	%o0, [%fp-32]
	b	.L96
	 nop
.L95:
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 42
	bne	.L96
	 nop
	ld	[%fp+72], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+72]
	ld	[%fp+76], %g1
	ld	[%g1], %g1
	st	%g1, [%fp-32]
	ld	[%fp+76], %g1
	add	%g1, 4, %g1
	st	%g1, [%fp+76]
.L96:
	ld	[%fp-32], %g1
	cmp	%g1, 0
	bge	.L94
	 nop
	st	%g0, [%fp-32]
.L94:
	mov	-1, %g1
	st	%g1, [%fp-36]
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 108
	be	.L97
	 nop
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 76
	bne	.L98
	 nop
.L97:
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	st	%g1, [%fp-36]
	ld	[%fp+72], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+72]
.L98:
	mov	10, %g1
	st	%g1, [%fp-12]
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	add	%g1, -65, %g1
	cmp	%g1, 55
	bgu	.L99
	 nop
	sll	%g1, 2, %g2
	sethi	%hi(.L110), %g1
	or	%g1, %lo(.L110), %g1
	ld	[%g2+%g1], %g1
	jmp	%g1
	 nop
	.section	".rodata"
	.section	".text"
.L103:
	ld	[%fp-24], %g1
	and	%g1, 16, %g1
	cmp	%g1, 0
	bne	.L111
	 nop
	b	.L112
	 nop
.L113:
	ld	[%fp-16], %g1
	mov	32, %g2
	stb	%g2, [%g1]
	ld	[%fp-16], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-16]
.L112:
	ld	[%fp-28], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp-28]
	ld	[%fp-28], %g1
	cmp	%g1, 0
	bg	.L113
	 nop
.L111:
	ld	[%fp+76], %g1
	ld	[%g1], %g1
	mov	%g1, %g2
	ld	[%fp-16], %g1
	stb	%g2, [%g1]
	ld	[%fp-16], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-16]
	ld	[%fp+76], %g1
	add	%g1, 4, %g1
	st	%g1, [%fp+76]
	b	.L114
	 nop
.L115:
	ld	[%fp-16], %g1
	mov	32, %g2
	stb	%g2, [%g1]
	ld	[%fp-16], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-16]
.L114:
	ld	[%fp-28], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp-28]
	ld	[%fp-28], %g1
	cmp	%g1, 0
	bg	.L115
	 nop
	b	.L83
	 nop
.L107:
	ld	[%fp+76], %g1
	ld	[%g1], %g1
	st	%g1, [%fp-20]
	ld	[%fp+76], %g1
	add	%g1, 4, %g1
	st	%g1, [%fp+76]
	ld	[%fp-20], %g1
	cmp	%g1, 0
	bne	.L116
	 nop
	sethi	%hi(.LC2), %g1
	or	%g1, %lo(.LC2), %g1
	st	%g1, [%fp-20]
.L116:
	ld	[%fp-32], %g1
	ld	[%fp-20], %o0
	mov	%g1, %o1
	call	strnlen, 0
	 nop
	mov	%o0, %g1
	st	%g1, [%fp-40]
	ld	[%fp-24], %g1
	and	%g1, 16, %g1
	cmp	%g1, 0
	bne	.L117
	 nop
	b	.L118
	 nop
.L120:
	ld	[%fp-16], %g1
	mov	32, %g2
	stb	%g2, [%g1]
	ld	[%fp-16], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-16]
.L118:
	mov	1, %g1
	ld	[%fp-28], %g3
	ld	[%fp-40], %g2
	cmp	%g3, %g2
	bg	.L119
	 nop
	mov	0, %g1
.L119:
	ld	[%fp-28], %g2
	add	%g2, -1, %g2
	st	%g2, [%fp-28]
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	bne	.L120
	 nop
.L117:
	st	%g0, [%fp-8]
	b	.L121
	 nop
.L122:
	ld	[%fp-20], %g1
	ldub	[%g1], %g2
	ld	[%fp-16], %g1
	stb	%g2, [%g1]
	ld	[%fp-16], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-16]
	ld	[%fp-20], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-20]
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L121:
	ld	[%fp-8], %g2
	ld	[%fp-40], %g1
	cmp	%g2, %g1
	bl	.L122
	 nop
	b	.L123
	 nop
.L125:
	ld	[%fp-16], %g1
	mov	32, %g2
	stb	%g2, [%g1]
	ld	[%fp-16], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-16]
.L123:
	mov	1, %g1
	ld	[%fp-28], %g3
	ld	[%fp-40], %g2
	cmp	%g3, %g2
	bg	.L124
	 nop
	mov	0, %g1
.L124:
	ld	[%fp-28], %g2
	add	%g2, -1, %g2
	st	%g2, [%fp-28]
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	bne	.L125
	 nop
	b	.L83
	 nop
.L106:
	ld	[%fp-28], %g1
	cmp	%g1, -1
	bne	.L126
	 nop
	mov	8, %g1
	st	%g1, [%fp-28]
	ld	[%fp-24], %g1
	or	%g1, 1, %g1
	st	%g1, [%fp-24]
.L126:
	ld	[%fp+76], %g1
	ld	[%g1], %g1
	ld	[%fp+76], %g2
	add	%g2, 4, %g2
	st	%g2, [%fp+76]
	ld	[%fp-16], %o0
	mov	%g1, %o1
	mov	16, %o2
	ld	[%fp-28], %o3
	ld	[%fp-32], %o4
	ld	[%fp-24], %o5
	call	number, 0
	 nop
	st	%o0, [%fp-16]
	b	.L83
	 nop
.L100:
	ld	[%fp-24], %g1
	or	%g1, 64, %g1
	st	%g1, [%fp-24]
.L102:
	ld	[%fp-36], %g1
	cmp	%g1, 108
	bne	.L127
	 nop
	ld	[%fp+76], %g1
	ld	[%g1], %g1
	ld	[%fp+76], %g2
	add	%g2, 4, %g2
	st	%g2, [%fp+76]
	ld	[%fp-16], %o0
	mov	%g1, %o1
	ld	[%fp-28], %o2
	ld	[%fp-32], %o3
	ld	[%fp-24], %o4
	call	eaddr, 0
	 nop
	st	%o0, [%fp-16]
	b	.L83
	 nop
.L127:
	ld	[%fp+76], %g1
	ld	[%g1], %g1
	ld	[%fp+76], %g2
	add	%g2, 4, %g2
	st	%g2, [%fp+76]
	ld	[%fp-16], %o0
	mov	%g1, %o1
	ld	[%fp-28], %o2
	ld	[%fp-32], %o3
	ld	[%fp-24], %o4
	call	iaddr, 0
	 nop
	st	%o0, [%fp-16]
	b	.L83
	 nop
.L105:
	mov	8, %g1
	st	%g1, [%fp-12]
	b	.L129
	 nop
.L101:
	ld	[%fp-24], %g1
	or	%g1, 64, %g1
	st	%g1, [%fp-24]
.L109:
	mov	16, %g1
	st	%g1, [%fp-12]
	b	.L129
	 nop
.L104:
	ld	[%fp-24], %g1
	or	%g1, 2, %g1
	st	%g1, [%fp-24]
	b	.L138
	 nop
.L99:
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 37
	be	.L130
	 nop
	ld	[%fp-16], %g1
	mov	37, %g2
	stb	%g2, [%g1]
	ld	[%fp-16], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-16]
.L130:
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	be	.L131
	 nop
	ld	[%fp+72], %g1
	ldub	[%g1], %g2
	ld	[%fp-16], %g1
	stb	%g2, [%g1]
	ld	[%fp-16], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-16]
	b	.L83
	 nop
.L131:
	ld	[%fp+72], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp+72]
	b	.L83
	 nop
.L138:
	nop
.L129:
	ld	[%fp-36], %g1
	cmp	%g1, 108
	bne	.L133
	 nop
	ld	[%fp+76], %g1
	ld	[%g1], %g1
	st	%g1, [%fp-4]
	ld	[%fp+76], %g1
	add	%g1, 4, %g1
	st	%g1, [%fp+76]
	b	.L134
	 nop
.L133:
	ld	[%fp-24], %g1
	and	%g1, 2, %g1
	cmp	%g1, 0
	be	.L135
	 nop
	ld	[%fp+76], %g1
	ld	[%g1], %g1
	st	%g1, [%fp-4]
	ld	[%fp+76], %g1
	add	%g1, 4, %g1
	st	%g1, [%fp+76]
	b	.L134
	 nop
.L135:
	ld	[%fp+76], %g1
	ld	[%g1], %g1
	st	%g1, [%fp-4]
	ld	[%fp+76], %g1
	add	%g1, 4, %g1
	st	%g1, [%fp+76]
.L134:
	ld	[%fp-4], %g1
	ld	[%fp-16], %o0
	mov	%g1, %o1
	ld	[%fp-12], %o2
	ld	[%fp-28], %o3
	ld	[%fp-32], %o4
	ld	[%fp-24], %o5
	call	number, 0
	 nop
	st	%o0, [%fp-16]
.L83:
	ld	[%fp+72], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+72]
.L81:
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	bne	.L136
	 nop
	ld	[%fp-16], %g1
	stb	%g0, [%g1]
	ld	[%fp-16], %g2
	ld	[%fp+68], %g1
	sub	%g2, %g1, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.align 4
	.subsection	-1
	.align 4
.L110:
	.word	.L100
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L101
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L102
	.word	.L99
	.word	.L103
	.word	.L104
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L104
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L99
	.word	.L105
	.word	.L106
	.word	.L99
	.word	.L99
	.word	.L107
	.word	.L99
	.word	.L138
	.word	.L99
	.word	.L99
	.word	.L109
	.previous
	.subsection	-1
	.align 4
.L91:
	.word	.L86
	.word	.L85
	.word	.L85
	.word	.L87
	.word	.L85
	.word	.L85
	.word	.L85
	.word	.L85
	.word	.L85
	.word	.L85
	.word	.L85
	.word	.L88
	.word	.L85
	.word	.L89
	.word	.L85
	.word	.L85
	.word	.L90
	.previous
	.size	ee_vsprintf, .-ee_vsprintf
	.align 4
	.global uart_send_char
	.type	uart_send_char, #function
	.proc	020
uart_send_char:
	save	%sp, -104, %sp
	mov	%i0, %g1
	stb	%g1, [%fp+68]
	b	.L142
	 nop
.L144:
	nop
.L142:
	ldub	[%fp+68], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	mov	%g1, %o0
	call	__ajit_serial_putchar__, 0
	 nop
	st	%o0, [%fp-4]
	ld	[%fp-4], %g1
	cmp	%g1, 0
	be	.L144
	 nop
	nop
	b	.L141
	 nop
.L145:
	nop
.L141:
	st	%g0, [%fp-8]
	sethi	%hi(-53248), %g1
	or	%g1, 512, %g1
#APP
! 624 "/home/prajwal/Ajit/ajit-toolchain/AjitPublicResources/tools/minimal_printf_timer/src/ee_printf.c" 1
	lda [%g1] 32, %i5
	
! 0 "" 2
#NO_APP
	st	%i5, [%fp-8]
	ld	[%fp-8], %g1
	and	%g1, 8, %g1
	cmp	%g1, 0
	be	.L139
	 nop
	ld	[%fp-8], %g1
	and	%g1, 1, %g1
	cmp	%g1, 0
	bne	.L145
	 nop
.L139:
	restore
	jmp	%o7+8
	 nop
	.size	uart_send_char, .-uart_send_char
	.align 4
	.global ee_printf
	.type	ee_printf, #function
	.proc	04
ee_printf:
	save	%sp, -1136, %sp
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	st	%i3, [%fp+80]
	st	%i4, [%fp+84]
	st	%i5, [%fp+88]
	st	%i0, [%fp+68]
	st	%g0, [%fp-8]
	add	%fp, 72, %g1
	st	%g1, [%fp-1036]
	ld	[%fp-1036], %g1
	add	%fp, -1032, %g2
	mov	%g2, %o0
	ld	[%fp+68], %o1
	mov	%g1, %o2
	call	ee_vsprintf, 0
	 nop
	add	%fp, -1032, %g1
	st	%g1, [%fp-4]
	b	.L147
	 nop
.L148:
	ld	[%fp-4], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	mov	%g1, %o0
	call	uart_send_char, 0
	 nop
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L147:
	ld	[%fp-4], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	bne	.L148
	 nop
	ld	[%fp-8], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	ee_printf, .-ee_printf
	.ident	"GCC: (Buildroot 2014.08-g230601f) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

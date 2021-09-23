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
	.align 4
	.type	ee_bufcpy, #function
	.proc	020
ee_bufcpy:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	ld	[%fp+76], %g1
	ld	[%fp+72], %g2
	add	%g2, %g1, %g1
	st	%g1, [%fp-4]
	b	.L81
	 nop
.L82:
	ld	[%fp+72], %g1
	ldub	[%g1], %g2
	ld	[%fp+68], %g1
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
	ld	[%fp+72], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+72]
.L81:
	ld	[%fp+72], %g2
	ld	[%fp-4], %g1
	cmp	%g2, %g1
	bne	.L82
	 nop
	restore
	jmp	%o7+8
	 nop
	.size	ee_bufcpy, .-ee_bufcpy
	.section	".rodata"
	.align 8
.LC2:
	.long	0
	.long	0
	.section	".text"
	.align 4
	.type	parse_float, #function
	.proc	020
parse_float:
	save	%sp, -216, %sp
	std	%i0, [%fp-120]
	st	%i2, [%fp+76]
	mov	%i3, %g1
	st	%i4, [%fp+84]
	stb	%g1, [%fp+80]
	st	%g0, [%fp-12]
	st	%g0, [%fp-16]
	ldub	[%fp+80], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 71
	be	.L84
	 nop
	ldub	[%fp+80], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 69
	bne	.L85
	 nop
.L84:
	mov	1, %g1
	st	%g1, [%fp-16]
	ldub	[%fp+80], %g1
	add	%g1, 32, %g1
	stb	%g1, [%fp+80]
.L85:
	ldub	[%fp+80], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 103
	bne	.L86
	 nop
	add	%fp, -24, %g3
	add	%fp, -28, %g2
	add	%fp, -112, %g1
	ldd	[%fp-120], %o0
	ld	[%fp+84], %o2
	mov	%g3, %o3
	mov	%g2, %o4
	mov	%g1, %o5
	call	ecvtbuf, 0
	 nop
	st	%o0, [%fp-12]
	ld	[%fp-24], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp-20]
	ld	[%fp-20], %g1
	cmp	%g1, -4
	bl	.L87
	 nop
	ld	[%fp+84], %g1
	add	%g1, -1, %g2
	ld	[%fp-20], %g1
	cmp	%g2, %g1
	bge	.L88
	 nop
.L87:
	mov	101, %g1
	stb	%g1, [%fp+80]
	ld	[%fp+84], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp+84]
	b	.L86
	 nop
.L88:
	mov	102, %g1
	stb	%g1, [%fp+80]
	ld	[%fp-24], %g1
	ld	[%fp+84], %g2
	sub	%g2, %g1, %g1
	st	%g1, [%fp+84]
.L86:
	ldub	[%fp+80], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 101
	bne	.L89
	 nop
	ld	[%fp+84], %g1
	add	%g1, 1, %g4
	add	%fp, -24, %g3
	add	%fp, -28, %g2
	add	%fp, -112, %g1
	ldd	[%fp-120], %o0
	mov	%g4, %o2
	mov	%g3, %o3
	mov	%g2, %o4
	mov	%g1, %o5
	call	ecvtbuf, 0
	 nop
	st	%o0, [%fp-12]
	ld	[%fp-28], %g1
	cmp	%g1, 0
	be	.L90
	 nop
	ld	[%fp+76], %g1
	mov	45, %g2
	stb	%g2, [%g1]
	ld	[%fp+76], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+76]
.L90:
	ld	[%fp-12], %g1
	ldub	[%g1], %g2
	ld	[%fp+76], %g1
	stb	%g2, [%g1]
	ld	[%fp+76], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+76]
	ld	[%fp+84], %g1
	cmp	%g1, 0
	ble	.L91
	 nop
	ld	[%fp+76], %g1
	mov	46, %g2
	stb	%g2, [%g1]
	ld	[%fp+76], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+76]
.L91:
	ld	[%fp-12], %g1
	add	%g1, 1, %g1
	ld	[%fp+76], %o0
	mov	%g1, %o1
	ld	[%fp+84], %o2
	call	ee_bufcpy, 0
	 nop
	ld	[%fp+84], %g1
	ld	[%fp+76], %g2
	add	%g2, %g1, %g1
	st	%g1, [%fp+76]
	ld	[%fp-16], %g1
	cmp	%g1, 0
	be	.L92
	 nop
	mov	69, %g1
	b	.L93
	 nop
.L92:
	mov	101, %g1
.L93:
	ld	[%fp+76], %g2
	stb	%g1, [%g2]
	ld	[%fp+76], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+76]
	ld	[%fp-24], %g1
	cmp	%g1, 0
	bne	.L94
	 nop
	ldd	[%fp-120], %f10
	sethi	%hi(.LC2), %g1
	or	%g1, %lo(.LC2), %g1
	ldd	[%g1], %f8
	fcmpd	%f10, %f8
	nop
	fbne	.L95
	 nop
	st	%g0, [%fp-4]
	b	.L96
	 nop
.L95:
	mov	-1, %g1
	st	%g1, [%fp-4]
	b	.L96
	 nop
.L94:
	ld	[%fp-24], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp-4]
.L96:
	ld	[%fp-4], %g1
	cmp	%g1, 0
	bge	.L97
	 nop
	ld	[%fp+76], %g1
	mov	45, %g2
	stb	%g2, [%g1]
	ld	[%fp+76], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+76]
	ld	[%fp-4], %g1
	sub	%g0, %g1, %g1
	st	%g1, [%fp-4]
	b	.L98
	 nop
.L97:
	ld	[%fp+76], %g1
	mov	43, %g2
	stb	%g2, [%g1]
	ld	[%fp+76], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+76]
.L98:
	ld	[%fp+76], %g1
	add	%g1, 2, %g3
	ld	[%fp-4], %g2
	sra	%g2, 31, %g4
	wr	%g4, 0, %y
	nop
	nop
	nop
	sdiv	%g2, 10, %g1
	add	%g1, %g1, %g1
	sll	%g1, 2, %g4
	add	%g1, %g4, %g1
	sub	%g2, %g1, %g1
	add	%g1, 48, %g1
	stb	%g1, [%g3]
	ld	[%fp-4], %g1
	sra	%g1, 31, %g2
	wr	%g2, 0, %y
	nop
	nop
	nop
	sdiv	%g1, 10, %g1
	st	%g1, [%fp-4]
	ld	[%fp+76], %g1
	add	%g1, 1, %g3
	ld	[%fp-4], %g2
	sra	%g2, 31, %g4
	wr	%g4, 0, %y
	nop
	nop
	nop
	sdiv	%g2, 10, %g1
	add	%g1, %g1, %g1
	sll	%g1, 2, %g4
	add	%g1, %g4, %g1
	sub	%g2, %g1, %g1
	add	%g1, 48, %g1
	stb	%g1, [%g3]
	ld	[%fp-4], %g1
	sra	%g1, 31, %g2
	wr	%g2, 0, %y
	nop
	nop
	nop
	sdiv	%g1, 10, %g1
	st	%g1, [%fp-4]
	ld	[%fp-4], %g2
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
	add	%g1, 48, %g1
	mov	%g1, %g2
	ld	[%fp+76], %g1
	stb	%g2, [%g1]
	ld	[%fp+76], %g1
	add	%g1, 3, %g1
	st	%g1, [%fp+76]
	b	.L99
	 nop
.L89:
	ldub	[%fp+80], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 102
	bne	.L99
	 nop
	add	%fp, -24, %g3
	add	%fp, -28, %g2
	add	%fp, -112, %g1
	ldd	[%fp-120], %o0
	ld	[%fp+84], %o2
	mov	%g3, %o3
	mov	%g2, %o4
	mov	%g1, %o5
	call	fcvtbuf, 0
	 nop
	st	%o0, [%fp-12]
	ld	[%fp-28], %g1
	cmp	%g1, 0
	be	.L100
	 nop
	ld	[%fp+76], %g1
	mov	45, %g2
	stb	%g2, [%g1]
	ld	[%fp+76], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+76]
.L100:
	ld	[%fp-12], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	be	.L101
	 nop
	ld	[%fp-24], %g1
	cmp	%g1, 0
	bg	.L102
	 nop
	ld	[%fp+76], %g1
	mov	48, %g2
	stb	%g2, [%g1]
	ld	[%fp+76], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+76]
	ld	[%fp+76], %g1
	mov	46, %g2
	stb	%g2, [%g1]
	ld	[%fp+76], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+76]
	st	%g0, [%fp-8]
	b	.L103
	 nop
.L104:
	ld	[%fp+76], %g1
	mov	48, %g2
	stb	%g2, [%g1]
	ld	[%fp+76], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+76]
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L103:
	ld	[%fp-24], %g1
	sub	%g0, %g1, %g2
	ld	[%fp-8], %g1
	cmp	%g2, %g1
	bg	.L104
	 nop
	b	.L105
	 nop
.L106:
	ld	[%fp-12], %g1
	ldub	[%g1], %g2
	ld	[%fp+76], %g1
	stb	%g2, [%g1]
	ld	[%fp+76], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+76]
	ld	[%fp-12], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-12]
.L105:
	ld	[%fp-12], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	bne	.L106
	 nop
	b	.L99
	 nop
.L102:
	st	%g0, [%fp-8]
	b	.L107
	 nop
.L109:
	ld	[%fp-24], %g1
	ld	[%fp-8], %g2
	xor	%g2, %g1, %g1
	subcc	%g0, %g1, %g0
	subx	%g0, -1, %g1
	ld	[%fp-8], %g2
	add	%g2, 1, %g2
	st	%g2, [%fp-8]
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	be	.L108
	 nop
	ld	[%fp+76], %g1
	mov	46, %g2
	stb	%g2, [%g1]
	ld	[%fp+76], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+76]
.L108:
	ld	[%fp-12], %g1
	ldub	[%g1], %g2
	ld	[%fp+76], %g1
	stb	%g2, [%g1]
	ld	[%fp+76], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+76]
	ld	[%fp-12], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-12]
.L107:
	ld	[%fp-12], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	bne	.L109
	 nop
	b	.L99
	 nop
.L101:
	ld	[%fp+76], %g1
	mov	48, %g2
	stb	%g2, [%g1]
	ld	[%fp+76], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+76]
	ld	[%fp+84], %g1
	cmp	%g1, 0
	ble	.L99
	 nop
	ld	[%fp+76], %g1
	mov	46, %g2
	stb	%g2, [%g1]
	ld	[%fp+76], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+76]
	st	%g0, [%fp-8]
	b	.L110
	 nop
.L111:
	ld	[%fp+76], %g1
	mov	48, %g2
	stb	%g2, [%g1]
	ld	[%fp+76], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+76]
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L110:
	ld	[%fp-8], %g2
	ld	[%fp+84], %g1
	cmp	%g2, %g1
	bl	.L111
	 nop
.L99:
	ld	[%fp+76], %g1
	stb	%g0, [%g1]
	restore
	jmp	%o7+8
	 nop
	.size	parse_float, .-parse_float
	.align 4
	.type	decimal_point, #function
	.proc	020
decimal_point:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	b	.L113
	 nop
.L117:
	ld	[%fp+68], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 46
	be	.L121
	 nop
.L114:
	ld	[%fp+68], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 101
	be	.L116
	 nop
	ld	[%fp+68], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 69
	be	.L116
	 nop
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
.L113:
	ld	[%fp+68], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	bne	.L117
	 nop
.L116:
	ld	[%fp+68], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	be	.L118
	 nop
	ld	[%fp+68], %o0
	mov	256, %o1
	call	strnlen, 0
	 nop
	mov	%o0, %g1
	st	%g1, [%fp-4]
	b	.L119
	 nop
.L120:
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%fp-4], %g2
	ld	[%fp+68], %g3
	add	%g3, %g2, %g2
	ldub	[%g2], %g2
	stb	%g2, [%g1]
	ld	[%fp-4], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp-4]
.L119:
	ld	[%fp-4], %g1
	cmp	%g1, 0
	bg	.L120
	 nop
	ld	[%fp+68], %g1
	mov	46, %g2
	stb	%g2, [%g1]
	b	.L112
	 nop
.L118:
	ld	[%fp+68], %g1
	mov	46, %g2
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
	ld	[%fp+68], %g1
	stb	%g0, [%g1]
	b	.L112
	 nop
.L121:
	nop
.L112:
	restore
	jmp	%o7+8
	 nop
	.size	decimal_point, .-decimal_point
	.align 4
	.type	cropzeros, #function
	.proc	020
cropzeros:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	b	.L123
	 nop
.L125:
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
.L123:
	ld	[%fp+68], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	be	.L124
	 nop
	ld	[%fp+68], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 46
	bne	.L125
	 nop
.L124:
	ld	[%fp+68], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	xor	%g1, 0, %g1
	subcc	%g0, %g1, %g0
	addx	%g0, 0, %g1
	ld	[%fp+68], %g2
	add	%g2, 1, %g2
	st	%g2, [%fp+68]
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	be	.L122
	 nop
	b	.L127
	 nop
.L129:
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
.L127:
	ld	[%fp+68], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	be	.L128
	 nop
	ld	[%fp+68], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 101
	be	.L128
	 nop
	ld	[%fp+68], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 69
	bne	.L129
	 nop
.L128:
	ld	[%fp+68], %g1
	st	%g1, [%fp-4]
	ld	[%fp+68], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp+68]
	b	.L130
	 nop
.L131:
	ld	[%fp+68], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp+68]
.L130:
	ld	[%fp+68], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 48
	be	.L131
	 nop
	ld	[%fp+68], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 46
	bne	.L133
	 nop
	ld	[%fp+68], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp+68]
	b	.L133
	 nop
.L134:
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
	ld	[%fp+68], %g1
	stb	%g0, [%g1]
.L133:
	ld	[%fp+68], %g2
	ld	[%fp-4], %g1
	cmp	%g2, %g1
	bne	.L134
	 nop
.L122:
	restore
	jmp	%o7+8
	 nop
	.size	cropzeros, .-cropzeros
	.section	".rodata"
	.align 8
.LC3:
	.long	0
	.long	0
	.section	".text"
	.align 4
	.type	flt, #function
	.proc	0102
flt:
	save	%sp, -200, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp-104]
	st	%i2, [%fp-100]
	st	%i3, [%fp+80]
	st	%i4, [%fp+84]
	mov	%i5, %g1
	stb	%g1, [%fp+88]
	ld	[%fp+92], %g1
	and	%g1, 16, %g1
	cmp	%g1, 0
	be	.L136
	 nop
	ld	[%fp+92], %g1
	and	%g1, -2, %g1
	st	%g1, [%fp+92]
.L136:
	ld	[%fp+92], %g1
	and	%g1, 1, %g1
	cmp	%g1, 0
	be	.L137
	 nop
	mov	48, %g1
	b	.L138
	 nop
.L137:
	mov	32, %g1
.L138:
	stb	%g1, [%fp-9]
	stb	%g0, [%fp-1]
	ld	[%fp+92], %g1
	and	%g1, 2, %g1
	cmp	%g1, 0
	be	.L139
	 nop
	ldd	[%fp-104], %f10
	sethi	%hi(.LC3), %g1
	or	%g1, %lo(.LC3), %g1
	ldd	[%g1], %f8
	fcmped	%f10, %f8
	nop
	fbuge	.L159
	 nop
.L158:
	mov	45, %g1
	stb	%g1, [%fp-1]
	ldd	[%fp-104], %f8
	fnegs	%f8, %f8
	std	%f8, [%fp-104]
	ld	[%fp+80], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp+80]
	b	.L139
	 nop
.L159:
	ld	[%fp+92], %g1
	and	%g1, 4, %g1
	cmp	%g1, 0
	be	.L142
	 nop
	mov	43, %g1
	stb	%g1, [%fp-1]
	ld	[%fp+80], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp+80]
	b	.L139
	 nop
.L142:
	ld	[%fp+92], %g1
	and	%g1, 8, %g1
	cmp	%g1, 0
	be	.L139
	 nop
	mov	32, %g1
	stb	%g1, [%fp-1]
	ld	[%fp+80], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp+80]
.L139:
	ld	[%fp+84], %g1
	cmp	%g1, 0
	bge	.L143
	 nop
	mov	6, %g1
	st	%g1, [%fp+84]
.L143:
	add	%fp, -96, %g2
	ldub	[%fp+88], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	ldd	[%fp-104], %o0
	mov	%g2, %o2
	mov	%g1, %o3
	ld	[%fp+84], %o4
	call	parse_float, 0
	 nop
	ld	[%fp+92], %g1
	and	%g1, 32, %g1
	cmp	%g1, 0
	be	.L144
	 nop
	ld	[%fp+84], %g1
	cmp	%g1, 0
	bne	.L144
	 nop
	add	%fp, -96, %g1
	mov	%g1, %o0
	call	decimal_point, 0
	 nop
.L144:
	ldub	[%fp+88], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 103
	bne	.L145
	 nop
	ld	[%fp+92], %g1
	and	%g1, 32, %g1
	cmp	%g1, 0
	bne	.L145
	 nop
	add	%fp, -96, %g1
	mov	%g1, %o0
	call	cropzeros, 0
	 nop
.L145:
	add	%fp, -96, %g1
	mov	%g1, %o0
	mov	256, %o1
	call	strnlen, 0
	 nop
	mov	%o0, %g1
	st	%g1, [%fp-16]
	ld	[%fp+80], %g2
	ld	[%fp-16], %g1
	sub	%g2, %g1, %g1
	st	%g1, [%fp+80]
	ld	[%fp+92], %g1
	and	%g1, 17, %g1
	cmp	%g1, 0
	bne	.L146
	 nop
	b	.L147
	 nop
.L148:
	ld	[%fp+68], %g1
	mov	32, %g2
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
.L147:
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
	bne	.L148
	 nop
.L146:
	ldub	[%fp-1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	be	.L149
	 nop
	ld	[%fp+68], %g1
	ldub	[%fp-1], %g2
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
.L149:
	ld	[%fp+92], %g1
	and	%g1, 16, %g1
	cmp	%g1, 0
	bne	.L150
	 nop
	b	.L151
	 nop
.L152:
	ld	[%fp+68], %g1
	ldub	[%fp-9], %g2
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
.L151:
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
	bne	.L152
	 nop
.L150:
	st	%g0, [%fp-8]
	b	.L153
	 nop
.L154:
	ld	[%fp-8], %g1
	add	%fp, %g1, %g1
	ldub	[%g1-96], %g2
	ld	[%fp+68], %g1
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L153:
	ld	[%fp-8], %g2
	ld	[%fp-16], %g1
	cmp	%g2, %g1
	bl	.L154
	 nop
	b	.L155
	 nop
.L156:
	ld	[%fp+68], %g1
	mov	32, %g2
	stb	%g2, [%g1]
	ld	[%fp+68], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+68]
.L155:
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
	bne	.L156
	 nop
	ld	[%fp+68], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	flt, .-flt
	.section	".rodata"
	.align 8
.LC4:
	.asciz	"<NULL>"
	.section	".text"
	.align 4
	.type	ee_vsprintf, #function
	.proc	04
ee_vsprintf:
	save	%sp, -160, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	ld	[%fp+68], %g1
	st	%g1, [%fp-16]
	b	.L161
	 nop
.L217:
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 37
	be	.L162
	 nop
	ld	[%fp+72], %g1
	ldub	[%g1], %g2
	ld	[%fp-16], %g1
	stb	%g2, [%g1]
	ld	[%fp-16], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-16]
	b	.L163
	 nop
.L162:
	st	%g0, [%fp-24]
.L164:
	ld	[%fp+72], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+72]
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	add	%g1, -32, %g1
	cmp	%g1, 16
	bgu	.L165
	 nop
	sll	%g1, 2, %g2
	sethi	%hi(.L171), %g1
	or	%g1, %lo(.L171), %g1
	ld	[%g2+%g1], %g1
	jmp	%g1
	 nop
	.section	".rodata"
	.section	".text"
.L169:
	ld	[%fp-24], %g1
	or	%g1, 16, %g1
	st	%g1, [%fp-24]
	b	.L164
	 nop
.L168:
	ld	[%fp-24], %g1
	or	%g1, 4, %g1
	st	%g1, [%fp-24]
	b	.L164
	 nop
.L166:
	ld	[%fp-24], %g1
	or	%g1, 8, %g1
	st	%g1, [%fp-24]
	b	.L164
	 nop
.L167:
	ld	[%fp-24], %g1
	or	%g1, 32, %g1
	st	%g1, [%fp-24]
	b	.L164
	 nop
.L170:
	ld	[%fp-24], %g1
	or	%g1, 1, %g1
	st	%g1, [%fp-24]
	b	.L164
	 nop
.L165:
	mov	-1, %g1
	st	%g1, [%fp-28]
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 47
	ble	.L172
	 nop
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 57
	bg	.L172
	 nop
	add	%fp, 72, %g1
	mov	%g1, %o0
	call	skip_atoi, 0
	 nop
	st	%o0, [%fp-28]
	b	.L173
	 nop
.L172:
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 42
	bne	.L173
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
	bge	.L173
	 nop
	ld	[%fp-28], %g1
	sub	%g0, %g1, %g1
	st	%g1, [%fp-28]
	ld	[%fp-24], %g1
	or	%g1, 16, %g1
	st	%g1, [%fp-24]
.L173:
	mov	-1, %g1
	st	%g1, [%fp-32]
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 46
	bne	.L174
	 nop
	ld	[%fp+72], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+72]
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 47
	ble	.L175
	 nop
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 57
	bg	.L175
	 nop
	add	%fp, 72, %g1
	mov	%g1, %o0
	call	skip_atoi, 0
	 nop
	st	%o0, [%fp-32]
	b	.L176
	 nop
.L175:
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 42
	bne	.L176
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
.L176:
	ld	[%fp-32], %g1
	cmp	%g1, 0
	bge	.L174
	 nop
	st	%g0, [%fp-32]
.L174:
	mov	-1, %g1
	st	%g1, [%fp-36]
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 108
	be	.L177
	 nop
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 76
	bne	.L178
	 nop
.L177:
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	st	%g1, [%fp-36]
	ld	[%fp+72], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+72]
.L178:
	mov	10, %g1
	st	%g1, [%fp-12]
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	add	%g1, -65, %g1
	cmp	%g1, 55
	bgu	.L179
	 nop
	sll	%g1, 2, %g2
	sethi	%hi(.L191), %g1
	or	%g1, %lo(.L191), %g1
	ld	[%g2+%g1], %g1
	jmp	%g1
	 nop
	.section	".rodata"
	.section	".text"
.L183:
	ld	[%fp-24], %g1
	and	%g1, 16, %g1
	cmp	%g1, 0
	bne	.L192
	 nop
	b	.L193
	 nop
.L194:
	ld	[%fp-16], %g1
	mov	32, %g2
	stb	%g2, [%g1]
	ld	[%fp-16], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-16]
.L193:
	ld	[%fp-28], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp-28]
	ld	[%fp-28], %g1
	cmp	%g1, 0
	bg	.L194
	 nop
.L192:
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
	b	.L195
	 nop
.L196:
	ld	[%fp-16], %g1
	mov	32, %g2
	stb	%g2, [%g1]
	ld	[%fp-16], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-16]
.L195:
	ld	[%fp-28], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp-28]
	ld	[%fp-28], %g1
	cmp	%g1, 0
	bg	.L196
	 nop
	b	.L163
	 nop
.L188:
	ld	[%fp+76], %g1
	ld	[%g1], %g1
	st	%g1, [%fp-20]
	ld	[%fp+76], %g1
	add	%g1, 4, %g1
	st	%g1, [%fp+76]
	ld	[%fp-20], %g1
	cmp	%g1, 0
	bne	.L197
	 nop
	sethi	%hi(.LC4), %g1
	or	%g1, %lo(.LC4), %g1
	st	%g1, [%fp-20]
.L197:
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
	bne	.L198
	 nop
	b	.L199
	 nop
.L201:
	ld	[%fp-16], %g1
	mov	32, %g2
	stb	%g2, [%g1]
	ld	[%fp-16], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-16]
.L199:
	mov	1, %g1
	ld	[%fp-28], %g3
	ld	[%fp-40], %g2
	cmp	%g3, %g2
	bg	.L200
	 nop
	mov	0, %g1
.L200:
	ld	[%fp-28], %g2
	add	%g2, -1, %g2
	st	%g2, [%fp-28]
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	bne	.L201
	 nop
.L198:
	st	%g0, [%fp-8]
	b	.L202
	 nop
.L203:
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
.L202:
	ld	[%fp-8], %g2
	ld	[%fp-40], %g1
	cmp	%g2, %g1
	bl	.L203
	 nop
	b	.L204
	 nop
.L206:
	ld	[%fp-16], %g1
	mov	32, %g2
	stb	%g2, [%g1]
	ld	[%fp-16], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-16]
.L204:
	mov	1, %g1
	ld	[%fp-28], %g3
	ld	[%fp-40], %g2
	cmp	%g3, %g2
	bg	.L205
	 nop
	mov	0, %g1
.L205:
	ld	[%fp-28], %g2
	add	%g2, -1, %g2
	st	%g2, [%fp-28]
	and	%g1, 0xff, %g1
	cmp	%g1, 0
	bne	.L206
	 nop
	b	.L163
	 nop
.L187:
	ld	[%fp-28], %g1
	cmp	%g1, -1
	bne	.L207
	 nop
	mov	8, %g1
	st	%g1, [%fp-28]
	ld	[%fp-24], %g1
	or	%g1, 1, %g1
	st	%g1, [%fp-24]
.L207:
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
	b	.L163
	 nop
.L180:
	ld	[%fp-24], %g1
	or	%g1, 64, %g1
	st	%g1, [%fp-24]
.L182:
	ld	[%fp-36], %g1
	cmp	%g1, 108
	bne	.L208
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
	b	.L163
	 nop
.L208:
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
	b	.L163
	 nop
.L186:
	mov	8, %g1
	st	%g1, [%fp-12]
	b	.L210
	 nop
.L181:
	ld	[%fp-24], %g1
	or	%g1, 64, %g1
	st	%g1, [%fp-24]
.L190:
	mov	16, %g1
	st	%g1, [%fp-12]
	b	.L210
	 nop
.L184:
	ld	[%fp-24], %g1
	or	%g1, 2, %g1
	st	%g1, [%fp-24]
	b	.L219
	 nop
.L185:
	add	%fp, -48, %g2
	ld	[%fp+76], %g1
	mov	%g2, %g3
	mov	%g1, %g2
	mov	8, %g1
	mov	%g3, %o0
	mov	%g2, %o1
	mov	%g1, %o2
	call	memcpy, 0
	 nop
	ldd	[%fp-48], %f8
	ld	[%fp+76], %g1
	add	%g1, 8, %g1
	st	%g1, [%fp+76]
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	ld	[%fp-24], %g2
	or	%g2, 2, %g2
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	st	%g2, [%sp+92]
	ld	[%fp-16], %o0
	std	%f8, [%fp-56]
	ldd	[%fp-56], %g2
	mov	%g2, %o1
	mov	%g3, %o2
	ld	[%fp-28], %o3
	ld	[%fp-32], %o4
	mov	%g1, %o5
	call	flt, 0
	 nop
	st	%o0, [%fp-16]
	b	.L163
	 nop
.L179:
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 37
	be	.L211
	 nop
	ld	[%fp-16], %g1
	mov	37, %g2
	stb	%g2, [%g1]
	ld	[%fp-16], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-16]
.L211:
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	be	.L212
	 nop
	ld	[%fp+72], %g1
	ldub	[%g1], %g2
	ld	[%fp-16], %g1
	stb	%g2, [%g1]
	ld	[%fp-16], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-16]
	b	.L163
	 nop
.L212:
	ld	[%fp+72], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp+72]
	b	.L163
	 nop
.L219:
	nop
.L210:
	ld	[%fp-36], %g1
	cmp	%g1, 108
	bne	.L214
	 nop
	ld	[%fp+76], %g1
	ld	[%g1], %g1
	st	%g1, [%fp-4]
	ld	[%fp+76], %g1
	add	%g1, 4, %g1
	st	%g1, [%fp+76]
	b	.L215
	 nop
.L214:
	ld	[%fp-24], %g1
	and	%g1, 2, %g1
	cmp	%g1, 0
	be	.L216
	 nop
	ld	[%fp+76], %g1
	ld	[%g1], %g1
	st	%g1, [%fp-4]
	ld	[%fp+76], %g1
	add	%g1, 4, %g1
	st	%g1, [%fp+76]
	b	.L215
	 nop
.L216:
	ld	[%fp+76], %g1
	ld	[%g1], %g1
	st	%g1, [%fp-4]
	ld	[%fp+76], %g1
	add	%g1, 4, %g1
	st	%g1, [%fp+76]
.L215:
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
.L163:
	ld	[%fp+72], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp+72]
.L161:
	ld	[%fp+72], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	bne	.L217
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
.L191:
	.word	.L180
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L181
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L182
	.word	.L179
	.word	.L183
	.word	.L184
	.word	.L179
	.word	.L185
	.word	.L179
	.word	.L179
	.word	.L184
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L179
	.word	.L186
	.word	.L187
	.word	.L179
	.word	.L179
	.word	.L188
	.word	.L179
	.word	.L219
	.word	.L179
	.word	.L179
	.word	.L190
	.previous
	.subsection	-1
	.align 4
.L171:
	.word	.L166
	.word	.L165
	.word	.L165
	.word	.L167
	.word	.L165
	.word	.L165
	.word	.L165
	.word	.L165
	.word	.L165
	.word	.L165
	.word	.L165
	.word	.L168
	.word	.L165
	.word	.L169
	.word	.L165
	.word	.L165
	.word	.L170
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
	b	.L223
	 nop
.L225:
	nop
.L223:
	ldub	[%fp+68], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	mov	%g1, %o0
	call	__ajit_serial_putchar__, 0
	 nop
	st	%o0, [%fp-4]
	ld	[%fp-4], %g1
	cmp	%g1, 0
	be	.L225
	 nop
	nop
	b	.L222
	 nop
.L226:
	nop
.L222:
	st	%g0, [%fp-8]
	sethi	%hi(-53248), %g1
	or	%g1, 512, %g1
#APP
! 625 "/home/shailee/Desktop/AJIT/ajit-toolchain/AjitPublicResources/tools/minimal_printf_timer/src/ee_printf.c" 1
	lda [%g1] 32, %i5
	
! 0 "" 2
#NO_APP
	st	%i5, [%fp-8]
	ld	[%fp-8], %g1
	and	%g1, 8, %g1
	cmp	%g1, 0
	be	.L220
	 nop
	ld	[%fp-8], %g1
	and	%g1, 1, %g1
	cmp	%g1, 0
	bne	.L226
	 nop
.L220:
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
	b	.L228
	 nop
.L229:
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
.L228:
	ld	[%fp-4], %g1
	ldub	[%g1], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 0
	bne	.L229
	 nop
	ld	[%fp-8], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	ee_printf, .-ee_printf
	.ident	"GCC: (Buildroot 2014.08-gacf8924) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

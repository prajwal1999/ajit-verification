	.file	"checker.c"
	.section	".rodata"
	.align 8
.LC0:
	.asciz	"------------------------Starting tests-------------------\n"
	.align 8
.LC1:
	.asciz	"Test failed - %d/%d\n"
	.align 8
.LC2:
	.asciz	"Expected Output 0x%x, 0x%x\n"
	.align 8
.LC3:
	.asciz	"Actual Output 0x%x, 0x%x\n"
	.align 8
.LC4:
	.asciz	"----------------------------------------------------\n"
	.align 8
.LC5:
	.asciz	"Test %d passed\n"
	.align 8
.LC6:
	.long	1073741824
	.long	0
	.align 8
.LC7:
	.long	1077739520
	.long	0
	.align 8
.LC8:
	.long	1077870592
	.long	0
	.section	".text"
	.align 4
	.global checker
	.type	checker, #function
	.proc	04
checker:
	save	%sp, -184, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	mov	900, %g1
	st	%g1, [%fp-12]
	mov	3, %o0
	call	__ajit_write_serial_control_register__, 0
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	call	ee_printf, 0
	 nop
	st	%g0, [%fp-4]
	b	.L2
	 nop
.L8:
	ld	[%fp-4], %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sll	%g1, 3, %g1
	add	%g1, 4, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	st	%g1, [%fp-16]
	ld	[%fp-4], %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sll	%g1, 3, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	st	%g1, [%fp-20]
	ld	[%fp-4], %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sll	%g1, 3, %g1
	add	%g1, 8, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	st	%g1, [%fp-24]
	ld	[%fp-4], %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sll	%g1, 3, %g1
	add	%g1, 12, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	st	%g1, [%fp-28]
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
	sethi	%hi(.LC1), %g2
	or	%g2, %lo(.LC1), %o0
	mov	%g1, %o1
	ld	[%fp-12], %o2
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC2), %g1
	or	%g1, %lo(.LC2), %o0
	ld	[%fp-16], %o1
	ld	[%fp-20], %o2
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC3), %g1
	or	%g1, %lo(.LC3), %o0
	ld	[%fp-24], %o1
	ld	[%fp-28], %o2
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC4), %g1
	or	%g1, %lo(.LC4), %o0
	call	ee_printf, 0
	 nop
#APP
! 33 "checker.c" 1
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
	sethi	%hi(.LC1), %g2
	or	%g2, %lo(.LC1), %o0
	mov	%g1, %o1
	ld	[%fp-12], %o2
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC2), %g1
	or	%g1, %lo(.LC2), %o0
	ld	[%fp-16], %o1
	ld	[%fp-20], %o2
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC3), %g1
	or	%g1, %lo(.LC3), %o0
	ld	[%fp-24], %o1
	ld	[%fp-28], %o2
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC4), %g1
	or	%g1, %lo(.LC4), %o0
	call	ee_printf, 0
	 nop
#APP
! 43 "checker.c" 1
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
	st	%g1, [%fp-76]
	ld	[%fp-76], %f10
	fitod	%f10, %f8
	std	%f8, [%fp-88]
	ldd	[%fp-88], %o0
	call	log2, 0
	 nop
	fmovs	%f0, %f8
	fmovs	%f1, %f9
	std	%f8, [%fp-88]
	ldd	[%fp-88], %o0
	call	ceil, 0
	 nop
	std	%f0, [%fp-72]
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-76]
	ld	[%fp-76], %f11
	fitod	%f11, %f8
	std	%f8, [%fp-88]
	ldd	[%fp-88], %o0
	call	log2, 0
	 nop
	fmovs	%f0, %f8
	fmovs	%f1, %f9
	std	%f8, [%fp-88]
	ldd	[%fp-88], %o0
	call	floor, 0
	 nop
	fmovs	%f0, %f8
	fmovs	%f1, %f9
	ldd	[%fp-72], %f10
	fcmpd	%f10, %f8
	nop
	fbne	.L7
	 nop
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	sethi	%hi(.LC5), %g2
	or	%g2, %lo(.LC5), %o0
	mov	%g1, %o1
	call	ee_printf, 0
	 nop
.L7:
	ld	[%fp-4], %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sll	%g1, 3, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	st	%g1, [%fp-32]
	ld	[%fp-4], %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sll	%g1, 3, %g1
	add	%g1, 4, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	st	%g1, [%fp-36]
	sethi	%hi(.LC6), %g1
	or	%g1, %lo(.LC6), %g1
	ldd	[%g1], %f10
	sethi	%hi(.LC7), %g1
	or	%g1, %lo(.LC7), %g1
	ldd	[%g1], %f8
	std	%f10, [%fp-88]
	ldd	[%fp-88], %o0
	std	%f8, [%fp-88]
	ldd	[%fp-88], %o2
	call	pow, 0
	 nop
	fmovs	%f0, %f8
	fmovs	%f1, %f9
	fdtoi	%f8, %f11
	st	%f11, [%fp-76]
	ld	[%fp-76], %g1
	st	%g1, [%fp-40]
	mov	8, %g1
	st	%g1, [%fp-44]
	sethi	%hi(.LC6), %g1
	or	%g1, %lo(.LC6), %g1
	ldd	[%g1], %f10
	sethi	%hi(.LC8), %g1
	or	%g1, %lo(.LC8), %g1
	ldd	[%g1], %f8
	std	%f10, [%fp-88]
	ldd	[%fp-88], %o0
	std	%f8, [%fp-88]
	ldd	[%fp-88], %o2
	call	pow, 0
	 nop
	fmovs	%f0, %f8
	fmovs	%f1, %f9
	fdtoi	%f8, %f10
	st	%f10, [%fp-76]
	ld	[%fp-76], %g2
	ld	[%fp-32], %g1
	add	%g2, %g1, %g1
	mov	%g1, %g3
	ld	[%fp-40], %g2
	wr	%g0, 0, %y
	nop
	nop
	nop
	udiv	%g3, %g2, %g1
	st	%g1, [%fp-48]
	sethi	%hi(.LC6), %g1
	or	%g1, %lo(.LC6), %g1
	ldd	[%g1], %f10
	sethi	%hi(.LC8), %g1
	or	%g1, %lo(.LC8), %g1
	ldd	[%g1], %f8
	std	%f10, [%fp-88]
	ldd	[%fp-88], %o0
	std	%f8, [%fp-88]
	ldd	[%fp-88], %o2
	call	pow, 0
	 nop
	fmovs	%f0, %f8
	fmovs	%f1, %f9
	fdtoi	%f8, %f11
	st	%f11, [%fp-76]
	ld	[%fp-76], %g2
	ld	[%fp-36], %g1
	add	%g2, %g1, %g1
	mov	%g1, %g3
	ld	[%fp-40], %g2
	wr	%g0, 0, %y
	nop
	nop
	nop
	udiv	%g3, %g2, %g1
	st	%g1, [%fp-52]
	ld	[%fp-48], %g2
	ld	[%fp-44], %g1
	smul	%g2, %g1, %g1
	mov	%g1, %g2
	ld	[%fp-52], %g1
	add	%g2, %g1, %g1
	sll	%g1, 2, %g1
	ld	[%fp+72], %g2
	add	%g2, %g1, %g1
	ld	[%fp-48], %g3
	ld	[%fp-44], %g2
	smul	%g3, %g2, %g2
	mov	%g2, %g3
	ld	[%fp-52], %g2
	add	%g3, %g2, %g2
	sll	%g2, 2, %g2
	ld	[%fp+72], %g3
	add	%g3, %g2, %g2
	ld	[%g2], %g2
	add	%g2, 1, %g2
	st	%g2, [%g1]
	ld	[%fp-4], %g2
	mov	%g2, %g1
	add	%g1, %g1, %g1
	add	%g1, %g2, %g1
	sll	%g1, 3, %g1
	add	%g1, 16, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	st	%g1, [%fp-56]
	ld	[%fp-56], %g2
	sethi	%hi(15728640), %g1
	and	%g2, %g1, %g1
	srl	%g1, 20, %g1
	st	%g1, [%fp-60]
	ld	[%fp-48], %g2
	ld	[%fp-44], %g1
	smul	%g2, %g1, %g1
	sll	%g1, 4, %g1
	mov	%g1, %g2
	ld	[%fp-52], %g1
	sll	%g1, 4, %g1
	add	%g2, %g1, %g1
	ld	[%fp+76], %g2
	add	%g2, %g1, %g1
	ld	[%fp-48], %g3
	ld	[%fp-44], %g2
	smul	%g3, %g2, %g2
	sll	%g2, 4, %g2
	mov	%g2, %g3
	ld	[%fp-52], %g2
	sll	%g2, 4, %g2
	add	%g3, %g2, %g2
	ld	[%fp+76], %g3
	add	%g3, %g2, %g2
	ld	[%g2], %g2
	mov	%g2, %g3
	ld	[%fp-60], %g2
	and	%g2, 8, %g2
	srl	%g2, 3, %g2
	add	%g3, %g2, %g2
	st	%g2, [%g1]
	ld	[%fp-48], %g2
	ld	[%fp-44], %g1
	smul	%g2, %g1, %g1
	sll	%g1, 4, %g1
	mov	%g1, %g2
	ld	[%fp-52], %g1
	sll	%g1, 4, %g1
	add	%g2, %g1, %g1
	add	%g1, 4, %g1
	ld	[%fp+76], %g2
	add	%g2, %g1, %g1
	ld	[%fp-48], %g3
	ld	[%fp-44], %g2
	smul	%g3, %g2, %g2
	sll	%g2, 4, %g2
	mov	%g2, %g3
	ld	[%fp-52], %g2
	sll	%g2, 4, %g2
	add	%g3, %g2, %g2
	add	%g2, 4, %g2
	ld	[%fp+76], %g3
	add	%g3, %g2, %g2
	ld	[%g2], %g2
	mov	%g2, %g3
	ld	[%fp-60], %g2
	and	%g2, 4, %g2
	srl	%g2, 2, %g2
	add	%g3, %g2, %g2
	st	%g2, [%g1]
	ld	[%fp-48], %g2
	ld	[%fp-44], %g1
	smul	%g2, %g1, %g1
	sll	%g1, 4, %g1
	mov	%g1, %g2
	ld	[%fp-52], %g1
	sll	%g1, 4, %g1
	add	%g2, %g1, %g1
	add	%g1, 8, %g1
	ld	[%fp+76], %g2
	add	%g2, %g1, %g1
	ld	[%fp-48], %g3
	ld	[%fp-44], %g2
	smul	%g3, %g2, %g2
	sll	%g2, 4, %g2
	mov	%g2, %g3
	ld	[%fp-52], %g2
	sll	%g2, 4, %g2
	add	%g3, %g2, %g2
	add	%g2, 8, %g2
	ld	[%fp+76], %g3
	add	%g3, %g2, %g2
	ld	[%g2], %g2
	mov	%g2, %g3
	ld	[%fp-60], %g2
	and	%g2, 2, %g2
	srl	%g2, 1, %g2
	add	%g3, %g2, %g2
	st	%g2, [%g1]
	ld	[%fp-48], %g2
	ld	[%fp-44], %g1
	smul	%g2, %g1, %g1
	sll	%g1, 4, %g1
	mov	%g1, %g2
	ld	[%fp-52], %g1
	sll	%g1, 4, %g1
	add	%g2, %g1, %g1
	add	%g1, 12, %g1
	ld	[%fp+76], %g2
	add	%g2, %g1, %g1
	ld	[%fp-48], %g3
	ld	[%fp-44], %g2
	smul	%g3, %g2, %g2
	sll	%g2, 4, %g2
	mov	%g2, %g3
	ld	[%fp-52], %g2
	sll	%g2, 4, %g2
	add	%g3, %g2, %g2
	add	%g2, 12, %g2
	ld	[%fp+76], %g3
	add	%g3, %g2, %g2
	ld	[%g2], %g2
	mov	%g2, %g3
	ld	[%fp-60], %g2
	and	%g2, 1, %g2
	add	%g3, %g2, %g2
	st	%g2, [%g1]
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
	.ident	"GCC: (Buildroot 2014.08-g1414aea) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

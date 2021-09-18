	.file	"main.c"
	.section	".text"
	.align 4
	.global prbs
	.type	prbs, #function
	.proc	04
prbs:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	ld	[%fp+68], %g1
	sra	%g1, 31, %g2
	ld	[%fp+68], %g1
	sra	%g1, 30, %g1
	xor	%g2, %g1, %g2
	ld	[%fp+68], %g1
	sra	%g1, 25, %g1
	xor	%g2, %g1, %g2
	ld	[%fp+68], %g1
	sra	%g1, 26, %g1
	xor	%g2, %g1, %g1
	and	%g1, 1, %g1
	xor	%g1, 0, %g1
	subcc	%g0, %g1, %g0
	addx	%g0, 0, %g1
	stb	%g1, [%fp-1]
	ld	[%fp+68], %g1
	sra	%g1, 1, %g2
	ld	[%fp+68], %g1
	sll	%g1, 31, %g1
	or	%g2, %g1, %g1
	st	%g1, [%fp+68]
	ld	[%fp+68], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	prbs, .-prbs
	.global __floatundidf
	.section	".rodata"
	.align 8
.LC0:
	.long	1044740494
	.long	3794832442
	.section	".text"
	.align 4
	.global run_test
	.type	run_test, #function
	.proc	04
run_test:
	save	%sp, -136, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	st	%i3, [%fp+80]
	st	%g0, [%fp-12]
	st	%g0, [%fp-4]
	st	%g0, [%fp-16]
	st	%g0, [%fp-8]
	b	.L4
	 nop
.L5:
	ld	[%fp-8], %g1
	add	%g1, %g1, %g1
	mov	%g1, %g2
	ld	[%fp-8], %g1
	sll	%g1, 2, %g1
	ld	[%fp+72], %g3
	add	%g3, %g1, %g1
	mov	%g2, %o0
	mov	%g1, %o1
	call	__ajit_store_word_mmu_bypass__, 0
	 nop
	ld	[%fp-8], %g1
	add	%g1, %g1, %g1
	add	%g1, 1, %g1
	mov	%g1, %g2
	ld	[%fp-8], %g1
	sll	%g1, 2, %g1
	ld	[%fp+76], %g3
	add	%g3, %g1, %g1
	mov	%g2, %o0
	mov	%g1, %o1
	call	__ajit_store_word_mmu_bypass__, 0
	 nop
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L4:
	ld	[%fp-8], %g2
	ld	[%fp+68], %g1
	cmp	%g2, %g1
	bl	.L5
	 nop
	call	__ajit_get_clock_time, 0
	 nop
	std	%o0, [%fp-24]
	st	%g0, [%fp-8]
	b	.L6
	 nop
.L10:
	ld	[%fp-8], %g1
	sll	%g1, 2, %g1
	ld	[%fp+72], %g2
	add	%g2, %g1, %g1
	mov	%g1, %o0
	call	__ajit_load_word_mmu_bypass__, 0
	 nop
	st	%o0, [%fp-28]
	ld	[%fp-8], %g1
	sll	%g1, 2, %g1
	ld	[%fp+76], %g2
	add	%g2, %g1, %g1
	mov	%g1, %o0
	call	__ajit_load_word_mmu_bypass__, 0
	 nop
	st	%o0, [%fp-32]
	ld	[%fp-28], %g1
	and	%g1, 1, %g1
	cmp	%g1, 0
	bne	.L7
	 nop
	ld	[%fp-32], %g1
	and	%g1, 1, %g1
	cmp	%g1, 0
	be	.L7
	 nop
	ld	[%fp-4], %g1
	cmp	%g1, 0
	be	.L8
	 nop
.L7:
	mov	1, %g1
	b	.L9
	 nop
.L8:
	mov	0, %g1
.L9:
	st	%g1, [%fp-4]
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L6:
	ld	[%fp-8], %g2
	ld	[%fp+68], %g1
	cmp	%g2, %g1
	bl	.L10
	 nop
	call	__ajit_get_clock_time, 0
	 nop
	std	%o0, [%fp-40]
	ldd	[%fp-40], %i4
	ldd	[%fp-24], %g2
	subcc	%i5, %g3, %g3
	subx	%i4, %g2, %g2
	mov	%g2, %o0
	mov	%g3, %o1
	call	__floatundidf, 0
	 nop
	fmovs	%f0, %f10
	fmovs	%f1, %f11
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %g1
	ldd	[%g1], %f8
	fmuld	%f10, %f8, %f8
	ld	[%fp+80], %g1
	std	%f8, [%g1]
	ld	[%fp-4], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	run_test, .-run_test
	.section	".rodata"
	.align 8
.LC1:
	.asciz	"0x%X\n"
	.section	".text"
	.align 4
	.global main
	.type	main, #function
	.proc	04
main:
	save	%sp, -112, %sp
	mov	3, %o0
	call	__ajit_write_serial_control_register__, 0
	 nop
	sethi	%hi(655360), %g1
	or	%g1, 1, %g1
	st	%g1, [%fp-12]
	ld	[%fp-12], %g1
	st	%g1, [%fp-4]
	ld	[%fp-4], %g1
	mov	%g1, %o0
	call	prbs, 0
	 nop
	mov	%o0, %g1
	st	%g1, [%fp-4]
	ld	[%fp-4], %g1
	st	%g1, [%fp-16]
	st	%g0, [%fp-8]
	b	.L13
	 nop
.L14:
	ld	[%fp-4], %g1
	mov	%g1, %o0
	call	prbs, 0
	 nop
	mov	%o0, %g1
	st	%g1, [%fp-4]
	sethi	%hi(.LC1), %g1
	or	%g1, %lo(.LC1), %o0
	ld	[%fp-4], %o1
	call	ee_printf, 0
	 nop
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L13:
	ld	[%fp-8], %g1
	cmp	%g1, 49
	ble	.L14
	 nop
	mov	0, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	main, .-main
	.ident	"GCC: (Buildroot 2014.08-gacf8924) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

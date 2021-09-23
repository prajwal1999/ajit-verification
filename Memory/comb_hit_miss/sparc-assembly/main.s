	.file	"main.c"
	.section	".text"
	.align 4
	.global prbs
	.type	prbs, #function
	.proc	016
prbs:
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
	sll	%g1, 2, %g1
	st	%g1, [%fp+68]
	ld	[%fp+68], %g2
	sethi	%hi(1074003968), %g1
	or	%g2, %g1, %g1
	st	%g1, [%fp+68]
	ld	[%fp+68], %g2
	sethi	%hi(2147482624), %g1
	or	%g1, 1023, %g1
	and	%g2, %g1, %g1
	st	%g1, [%fp+68]
	ld	[%fp+68], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	prbs, .-prbs
	.global __floatundidf
	.align 4
	.global init_src_array
	.type	init_src_array, #function
	.proc	04
init_src_array:
	save	%sp, -136, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	call	__ajit_get_clock_time, 0
	 nop
	mov	%o0, %g2
	mov	%o1, %g3
	mov	%g2, %o0
	mov	%g3, %o1
	call	__floatundidf, 0
	 nop
	fmovs	%f0, %f8
	fmovs	%f1, %f9
	std	%f8, [%fp-16]
	st	%g0, [%fp-4]
	b	.L4
	 nop
.L5:
	ld	[%fp-4], %g1
	sll	%g1, 2, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%fp-4], %g2
	st	%g2, [%g1]
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L4:
	ld	[%fp-4], %g2
	ld	[%fp+72], %g1
	cmp	%g2, %g1
	bl	.L5
	 nop
	call	__ajit_get_clock_time, 0
	 nop
	mov	%o0, %g2
	mov	%o1, %g3
	mov	%g2, %o0
	mov	%g3, %o1
	call	__floatundidf, 0
	 nop
	fmovs	%f0, %f8
	fmovs	%f1, %f9
	std	%f8, [%fp-24]
	ldd	[%fp-24], %f10
	ldd	[%fp-16], %f8
	fsubd	%f10, %f8, %f8
	std	%f8, [%fp-32]
	ldd	[%fp-32], %f8
	fdtoi	%f8, %f10
	st	%f10, [%fp-36]
	ld	[%fp-36], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	init_src_array, .-init_src_array
	.align 4
	.global run_test
	.type	run_test, #function
	.proc	04
run_test:
	save	%sp, -144, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	call	__ajit_get_clock_time, 0
	 nop
	mov	%o0, %g2
	mov	%o1, %g3
	mov	%g2, %o0
	mov	%g3, %o1
	call	__floatundidf, 0
	 nop
	fmovs	%f0, %f8
	fmovs	%f1, %f9
	std	%f8, [%fp-16]
	st	%g0, [%fp-4]
	b	.L8
	 nop
.L9:
	ld	[%fp-4], %g1
	sll	%g1, 2, %g1
	ld	[%fp+72], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g1
	st	%g1, [%fp-20]
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L8:
	ld	[%fp-4], %g2
	ld	[%fp+68], %g1
	cmp	%g2, %g1
	bl	.L9
	 nop
	call	__ajit_get_clock_time, 0
	 nop
	mov	%o0, %g2
	mov	%o1, %g3
	mov	%g2, %o0
	mov	%g3, %o1
	call	__floatundidf, 0
	 nop
	fmovs	%f0, %f8
	fmovs	%f1, %f9
	std	%f8, [%fp-32]
	ldd	[%fp-32], %f10
	ldd	[%fp-16], %f8
	fsubd	%f10, %f8, %f8
	std	%f8, [%fp-40]
	ldd	[%fp-40], %f8
	fdtoi	%f8, %f10
	st	%f10, [%fp-44]
	ld	[%fp-44], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	run_test, .-run_test
	.section	".rodata"
	.align 8
.LC1:
	.asciz	"Time elapsed in stores = %f\n "
	.align 8
.LC2:
	.asciz	"Time elapsed in loads = %f\n "
	.align 8
.LC0:
	.long	1044740494
	.long	3794832442
	.section	".text"
	.align 4
	.global main
	.type	main, #function
	.proc	04
main:
	save	%sp, -136, %sp
	mov	3, %o0
	call	__ajit_write_serial_control_register__, 0
	 nop
	call	__ajit_get_clock_time, 0
	 nop
	mov	%o0, %g2
	mov	%o1, %g3
	st	%g3, [%fp-8]
	ld	[%fp-8], %o0
	call	prbs, 0
	 nop
	st	%o0, [%fp-8]
	ld	[%fp-8], %g1
	st	%g1, [%fp-12]
	st	%g0, [%fp-4]
	b	.L12
	 nop
.L13:
	ld	[%fp-12], %o0
	ld	[%fp-4], %o1
	call	init_src_array, 0
	 nop
	mov	%o0, %g1
	st	%g1, [%fp-36]
	ld	[%fp-36], %f8
	fitod	%f8, %f10
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %g1
	ldd	[%g1], %f8
	fmuld	%f10, %f8, %f8
	std	%f8, [%fp-24]
	ld	[%fp-4], %o0
	ld	[%fp-12], %o1
	call	run_test, 0
	 nop
	mov	%o0, %g1
	st	%g1, [%fp-36]
	ld	[%fp-36], %f8
	fitod	%f8, %f10
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %g1
	ldd	[%g1], %f8
	fmuld	%f10, %f8, %f8
	std	%f8, [%fp-32]
	sethi	%hi(.LC1), %g1
	or	%g1, %lo(.LC1), %o0
	ld	[%fp-24], %o1
	ld	[%fp-20], %o2
	call	ee_printf, 0
	 nop
	sethi	%hi(.LC2), %g1
	or	%g1, %lo(.LC2), %o0
	ld	[%fp-32], %o1
	ld	[%fp-28], %o2
	call	ee_printf, 0
	 nop
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L12:
	ld	[%fp-4], %g1
	cmp	%g1, 255
	ble	.L13
	 nop
	mov	0, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	main, .-main
	.ident	"GCC: (Buildroot 2014.08-gacf8924) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

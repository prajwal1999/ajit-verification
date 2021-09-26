	.file	"test.c"
	.section	".text"
	.align 4
	.global prbs
	.type	prbs, #function
	.proc	016
prbs:
	sethi	%hi(2147482624), %g1
	or	%g1, 1023, %g1
	srl	%o0, 1, %o0
	sll	%o0, 2, %o0
	and	%o0, %g1, %o0
	sethi	%hi(1074003968), %g1
	jmp	%o7+8
	 or	%o0, %g1, %o0
	.size	prbs, .-prbs
	.global __floatundidf
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC4:
	.asciz	"Avg miss penalty = %f usec \n"
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	0
	.align 8
.LC1:
	.long	1072693248
	.long	0
	.align 8
.LC2:
	.long	1044740494
	.long	3794832442
	.align 8
.LC3:
	.long	1069128089
	.long	2576980378
	.align 8
.LC5:
	.long	1065646817
	.long	1202590843
	.section	".text"
	.align 4
	.global init_src_array
	.type	init_src_array, #function
	.proc	06
init_src_array:
	save	%sp, -128, %sp
	sethi	%hi(.LC0), %g1
	sethi	%hi(.LC1), %l2
	ldd	[%g1+%lo(.LC0)], %f8
	sethi	%hi(.LC2), %l1
	fmovs	%f8, %f10
	fmovs	%f9, %f11
	sethi	%hi(.LC3), %l0
	sll	%i2, 2, %i3
	std	%f8, [%fp-16]
	std	%f10, [%fp-8]
	or	%l2, %lo(.LC1), %l2
	or	%l1, %lo(.LC2), %l1
	or	%l0, %lo(.LC3), %l0
.L4:
	call	__ajit_get_clock_time, 0
	 nop
	mov	%i0, %g2
	mov	%o0, %i4
	mov	%o1, %i5
	cmp	%i1, 0
	ble	.L7
	 mov	0, %g1
.L11:
	st	%g1, [%g2]
	add	%g1, %i2, %g1
	cmp	%i1, %g1
	bg	.L11
	 add	%g2, %i3, %g2
.L7:
	call	__ajit_get_clock_time, 0
	 nop
	subcc	%o1, %i5, %o1
	call	__floatundidf, 0
	 subx	%o0, %i4, %o0
	ldd	[%fp-8], %f12
	faddd	%f12, %f0, %f12
	std	%f12, [%fp-8]
	ldd	[%fp-8], %f14
	ldd	[%l2], %f8
	ldd	[%l1], %f12
	fmuld	%f14, %f12, %f12
	ldd	[%fp-16], %f14
	faddd	%f14, %f8, %f14
	ldd	[%l0], %f10
	fcmped	%f12, %f10
	nop
	fbl	.L4
	 std	%f14, [%fp-16]
	mov	0, %i3
.L10:
	call	__ajit_get_clock_time, 0
	 nop
	cmp	%i1, 0
	mov	%o0, %i4
	ble	.L8
	 mov	%o1, %i5
	mov	0, %g1
	add	%g1, %i2, %g1
.L18:
	cmp	%i1, %g1
	bg	.L18
	 add	%g1, %i2, %g1
.L8:
	call	__ajit_get_clock_time, 0
	 add	%i3, 1, %i3
	subcc	%o1, %i5, %o1
	call	__floatundidf, 0
	 subx	%o0, %i4, %o0
	ldd	[%fp-8], %f8
	fsubd	%f8, %f0, %f8
	st	%i3, [%fp-20]
	std	%f8, [%fp-8]
	ld	[%fp-20], %f10
	ldd	[%fp-16], %f12
	fitod	%f10, %f8
	fcmped	%f12, %f8
	nop
	fbg	.L10
	 ldd	[%fp-8], %f14
	sethi	%hi(.LC5), %g1
	fdivd	%f14, %f12, %f10
	ldd	[%g1+%lo(.LC5)], %f8
	fmuld	%f10, %f8, %f8
	std	%f8, [%fp-32]
	ldd	[%fp-32], %g2
	sethi	%hi(.LC4), %o0
	mov	%g2, %o1
	mov	%g3, %o2
	call	ee_printf, 0
	 or	%o0, %lo(.LC4), %o0
	ldd	[%fp-8], %f8
	fdtos	%f8, %f0
	jmp	%i7+8
	 restore
	.size	init_src_array, .-init_src_array
	.section	.rodata.cst8
	.align 8
.LC6:
	.long	0
	.long	0
	.align 8
.LC7:
	.long	1072693248
	.long	0
	.align 8
.LC8:
	.long	1044740494
	.long	3794832442
	.align 8
.LC9:
	.long	1069128089
	.long	2576980378
	.align 8
.LC10:
	.long	1065646817
	.long	1202590843
	.section	".text"
	.align 4
	.global run_test
	.type	run_test, #function
	.proc	04
run_test:
	save	%sp, -128, %sp
	sethi	%hi(.LC6), %g1
	sll	%i0, 2, %g2
	ldd	[%g1+%lo(.LC6)], %f8
	add	%g2, 10, %g2
	fmovs	%f8, %f10
	and	%g2, -8, %g2
	fmovs	%f9, %f11
	sub	%sp, %g2, %sp
	sethi	%hi(.LC7), %l3
	sethi	%hi(.LC8), %l2
	sethi	%hi(.LC9), %l1
	add	%sp, 92, %l0
	sll	%i1, 2, %i3
	std	%f8, [%fp-16]
	std	%f10, [%fp-8]
	or	%l3, %lo(.LC7), %l3
	or	%l2, %lo(.LC8), %l2
	or	%l1, %lo(.LC9), %l1
.L21:
	call	__ajit_get_clock_time, 0
	 nop
	mov	0, %g1
	mov	%o0, %i4
	mov	%o1, %i5
	cmp	%i0, 0
	ble	.L23
	 mov	0, %g2
.L28:
	ld	[%i2+%g1], %g3
	st	%g3, [%l0+%g1]
	add	%g2, %i1, %g2
	cmp	%i0, %g2
	bg	.L28
	 add	%g1, %i3, %g1
.L23:
	call	__ajit_get_clock_time, 0
	 nop
	subcc	%o1, %i5, %o1
	call	__floatundidf, 0
	 subx	%o0, %i4, %o0
	ldd	[%fp-8], %f12
	faddd	%f12, %f0, %f12
	std	%f12, [%fp-8]
	ldd	[%fp-8], %f14
	ldd	[%l3], %f8
	ldd	[%l2], %f12
	fmuld	%f14, %f12, %f12
	ldd	[%fp-16], %f14
	faddd	%f14, %f8, %f14
	ldd	[%l1], %f10
	fcmped	%f12, %f10
	nop
	fbl	.L21
	 std	%f14, [%fp-16]
	mov	0, %i3
.L26:
	call	__ajit_get_clock_time, 0
	 nop
	cmp	%i0, 0
	mov	%o0, %i4
	ble	.L24
	 mov	%o1, %i5
	mov	0, %g1
	add	%g1, %i1, %g1
.L34:
	cmp	%i0, %g1
	bg	.L34
	 add	%g1, %i1, %g1
.L24:
	call	__ajit_get_clock_time, 0
	 add	%i3, 1, %i3
	subcc	%o1, %i5, %o1
	call	__floatundidf, 0
	 subx	%o0, %i4, %o0
	ldd	[%fp-8], %f8
	fsubd	%f8, %f0, %f8
	st	%i3, [%fp-20]
	std	%f8, [%fp-8]
	ld	[%fp-20], %f10
	ldd	[%fp-16], %f12
	fitod	%f10, %f8
	fcmped	%f8, %f12
	nop
	fbl	.L26
	 ldd	[%fp-8], %f14
	sethi	%hi(.LC10), %g1
	fdivd	%f14, %f12, %f10
	ldd	[%g1+%lo(.LC10)], %f8
	fmuld	%f10, %f8, %f8
	std	%f8, [%fp-32]
	ldd	[%fp-32], %g2
	sethi	%hi(.LC4), %o0
	mov	%g2, %o1
	mov	%g3, %o2
	call	ee_printf, 0
	 or	%o0, %lo(.LC4), %o0
	ldd	[%fp-8], %f8
	fdtoi	%f8, %f9
	st	%f9, [%fp-20]
	ld	[%fp-20], %i0
	jmp	%i7+8
	 restore
	.size	run_test, .-run_test
	.ident	"GCC: (Buildroot 2014.08-gacf8924) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

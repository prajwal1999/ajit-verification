	.file	"checker.c"
	.section	".rodata"
	.align 8
.LC0:
	.asciz	"------------------------Starting tests-------------------\n"
	.align 8
.LC1:
	.asciz	"Test ran successfuuly - %d/%d\n"
	.align 8
.LC2:
	.asciz	"Test failed - %d/%d\n"
	.section	".text"
	.align 4
	.global checker
	.type	checker, #function
	.proc	04
checker:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
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
.L5:
	ld	[%fp+72], %g2
	ld	[%fp-4], %g1
	add	%g2, %g1, %g1
	sll	%g1, 2, %g1
	ld	[%fp+68], %g2
	add	%g2, %g1, %g1
	ld	[%g1], %g2
	ld	[%fp+72], %g1
	add	%g1, %g1, %g1
	mov	%g1, %g3
	ld	[%fp-4], %g1
	add	%g3, %g1, %g1
	sll	%g1, 2, %g1
	ld	[%fp+68], %g3
	add	%g3, %g1, %g1
	ld	[%g1], %g1
	cmp	%g2, %g1
	bne	.L3
	 nop
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	sethi	%hi(.LC1), %g2
	or	%g2, %lo(.LC1), %o0
	mov	%g1, %o1
	ld	[%fp+72], %o2
	call	ee_printf, 0
	 nop
	b	.L4
	 nop
.L3:
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	sethi	%hi(.LC2), %g2
	or	%g2, %lo(.LC2), %o0
	mov	%g1, %o1
	ld	[%fp+72], %o2
	call	ee_printf, 0
	 nop
#APP
! 18 "checker.c" 1
	 ta 0 
	 
! 0 "" 2
#NO_APP
.L4:
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L2:
	ld	[%fp-4], %g2
	ld	[%fp+72], %g1
	cmp	%g2, %g1
	bl	.L5
	 nop
	mov	0, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	checker, .-checker
	.ident	"GCC: (Buildroot 2014.08-gacf8924) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

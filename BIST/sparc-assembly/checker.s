	.file	"checker.c"
	.section	".rodata"
	.align 8
.LC0:
	.asciz	"Test ran successfuuly - 1/2\n"
	.align 8
.LC1:
	.asciz	"Test failed - 1/2\n"
	.align 8
.LC2:
	.asciz	"Test ran successfuuly - 2/2\n"
	.section	".text"
	.align 4
	.global checker
	.type	checker, #function
	.proc	04
checker:
	save	%sp, -112, %sp
	st	%i0, [%fp+68]
	mov	3, %o0
	call	__ajit_write_serial_control_register__, 0
	 nop
	ld	[%fp+68], %g1
	ld	[%g1+8], %g1
	st	%g1, [%fp-4]
	ld	[%fp+68], %g1
	ld	[%g1+12], %g1
	st	%g1, [%fp-8]
	ld	[%fp+68], %g1
	ld	[%g1+16], %g1
	st	%g1, [%fp-12]
	ld	[%fp+68], %g1
	ld	[%g1+20], %g1
	st	%g1, [%fp-16]
	ld	[%fp-4], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bne	.L2
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	call	ee_printf, 0
	 nop
	b	.L3
	 nop
.L2:
	sethi	%hi(.LC1), %g1
	or	%g1, %lo(.LC1), %o0
	call	ee_printf, 0
	 nop
#APP
! 18 "checker.c" 1
	 ta 0 
	 
! 0 "" 2
#NO_APP
.L3:
	ld	[%fp-8], %g2
	ld	[%fp-16], %g1
	cmp	%g2, %g1
	bne	.L4
	 nop
	sethi	%hi(.LC2), %g1
	or	%g1, %lo(.LC2), %o0
	call	ee_printf, 0
	 nop
	b	.L5
	 nop
.L4:
	sethi	%hi(.LC1), %g1
	or	%g1, %lo(.LC1), %o0
	call	ee_printf, 0
	 nop
#APP
! 25 "checker.c" 1
	 ta 0 
	 
! 0 "" 2
#NO_APP
.L5:
	mov	0, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	checker, .-checker
	.ident	"GCC: (Buildroot 2014.08-gacf8924) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

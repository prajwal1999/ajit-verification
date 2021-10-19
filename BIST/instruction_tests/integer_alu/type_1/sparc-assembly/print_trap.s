	.file	"print_trap.c"
	.section	".rodata"
	.align 8
.LC0:
	.asciz	"trap occured %x\n"
	.section	".text"
	.align 4
	.global print_trap
	.type	print_trap, #function
	.proc	04
print_trap:
	save	%sp, -96, %sp
	st	%i0, [%fp+68]
	mov	3, %o0
	call	__ajit_write_serial_control_register__, 0
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	ld	[%fp+68], %o1
	call	ee_printf, 0
	 nop
	mov	1, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	print_trap, .-print_trap
	.ident	"GCC: (Buildroot 2014.08-g54f60c9) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

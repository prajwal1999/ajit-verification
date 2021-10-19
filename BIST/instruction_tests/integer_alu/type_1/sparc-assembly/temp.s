	.file	"temp.c"
	.section	".rodata"
	.align 8
.LC0:
	.asciz	"reached here\n"
	.section	".text"
	.align 4
	.global temp
	.type	temp, #function
	.proc	04
temp:
	save	%sp, -96, %sp
	mov	3, %o0
	call	__ajit_write_serial_control_register__, 0
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	call	ee_printf, 0
	 nop
	mov	1, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	temp, .-temp
	.ident	"GCC: (Buildroot 2014.08-g54f60c9) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

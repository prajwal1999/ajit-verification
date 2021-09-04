	.file	"generate_input_output.c"
	.section	".text"
	.align 4
	.global generate_input_output
	.type	generate_input_output, #function
	.proc	04
generate_input_output:
	save	%sp, -120, %sp
	mov	256, %g1
	st	%g1, [%fp-24]
	mov	512, %g1
	st	%g1, [%fp-20]
	st	%g0, [%fp-16]
	mov	1, %g1
	st	%g1, [%fp-12]
	mov	512, %g1
	st	%g1, [%fp-8]
	mov	256, %g1
	st	%g1, [%fp-4]
	add	%fp, -24, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	generate_input_output, .-generate_input_output
	.ident	"GCC: (Buildroot 2014.08-g230601f) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

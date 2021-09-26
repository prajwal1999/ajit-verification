	.file	"main.c"
	.section	.text.startup,"ax",@progbits
	.align 4
	.global main
	.type	main, #function
	.proc	04
main:
	save	%sp, -96, %sp
	call	__ajit_write_serial_control_register__, 0
	 mov	3, %o0
	mov	8, %o1
	sethi	%hi(1074020352), %o2
	call	run_test, 0
	 sethi	%hi(4096), %o0
	sethi	%hi(4096), %o1
	mov	8, %o2
	call	init_src_array, 0
	 sethi	%hi(1074020352), %o0
	mov	8, %o1
	sethi	%hi(1074020352), %o2
	call	run_test, 0
	 sethi	%hi(8192), %o0
	mov	8, %o1
	sethi	%hi(1074020352), %o2
	call	run_test, 0
	 sethi	%hi(16384), %o0
	mov	8, %o1
	sethi	%hi(1074020352), %o2
	call	run_test, 0
	 sethi	%hi(32768), %o0
	mov	0, %i0
	mov	8, %o1
	sethi	%hi(1074020352), %o2
	call	run_test, 0
	 sethi	%hi(65536), %o0
	jmp	%i7+8
	 restore
	.size	main, .-main
	.ident	"GCC: (Buildroot 2014.08-gacf8924) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

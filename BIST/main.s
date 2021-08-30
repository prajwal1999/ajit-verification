	.file	"main.c"
	.globl	instr_types
	.data
	.align 32
	.type	instr_types, @object
	.size	instr_types, 100
instr_types:
	.string	"control_transfer"
	.zero	3
	.string	"data_transfer"
	.zero	6
	.string	"floating_point"
	.zero	5
	.string	"integer_alu"
	.zero	8
	.string	"misc"
	.zero	15
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$1, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits

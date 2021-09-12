	.file	"main.c"
	.section	".text"
	.align 4
	.global instr_select
	.type	instr_select, #function
	.proc	04
instr_select:
	save	%sp, -96, %sp
	st	%i0, [%fp+68]
	ld	[%fp+68], %g1
	cmp	%g1, 0
	bne	.L2
	 nop
	mov	0, %g1
	b	.L3
	 nop
.L2:
	mov	4, %g1
.L3:
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	instr_select, .-instr_select
	.align 4
	.global bring_complement_instr
	.type	bring_complement_instr, #function
	.proc	04
bring_complement_instr:
	save	%sp, -96, %sp
	st	%i0, [%fp+68]
	ld	[%fp+68], %g1
	cmp	%g1, 0
	bne	.L5
	 nop
	mov	4, %g1
	b	.L6
	 nop
.L5:
	ld	[%fp+68], %g1
	cmp	%g1, 4
	bne	.L7
	 nop
	mov	0, %g1
	b	.L6
	 nop
.L7:
	b	.L4
	 nop
.L6:
.L4:
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	bring_complement_instr, .-bring_complement_instr
	.align 4
	.global generate_opcode_10
	.type	generate_opcode_10, #function
	.proc	016
generate_opcode_10:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	st	%i3, [%fp+80]
	mov	%i4, %g2
	mov	%i5, %g1
	stb	%g2, [%fp+84]
	sth	%g1, [%fp+88]
	sethi	%hi(-2147483648), %g1
	st	%g1, [%fp-4]
	ld	[%fp+68], %g1
	sll	%g1, 25, %g1
	ld	[%fp-4], %g2
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp+80], %g1
	sll	%g1, 19, %g1
	ld	[%fp-4], %g2
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp+72], %g1
	sll	%g1, 14, %g1
	ld	[%fp-4], %g2
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp-4], %g2
	ld	[%fp+76], %g1
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp-4], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	generate_opcode_10, .-generate_opcode_10
	.align 4
	.global generate_opcode_11
	.type	generate_opcode_11, #function
	.proc	016
generate_opcode_11:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	st	%i3, [%fp+80]
	mov	%i4, %g2
	mov	%i5, %g1
	stb	%g2, [%fp+84]
	sth	%g1, [%fp+88]
	sethi	%hi(-1073741824), %g1
	st	%g1, [%fp-4]
	ld	[%fp+68], %g1
	sll	%g1, 25, %g1
	ld	[%fp-4], %g2
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp+80], %g1
	sll	%g1, 19, %g1
	ld	[%fp-4], %g2
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp+72], %g1
	sll	%g1, 14, %g1
	ld	[%fp-4], %g2
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ldub	[%fp+84], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 1
	bne	.L11
	 nop
	ld	[%fp-4], %g2
	sethi	%hi(8192), %g1
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	lduh	[%fp+88], %g1
	sll	%g1, 16, %g1
	srl	%g1, 16, %g1
	ld	[%fp-4], %g2
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	b	.L12
	 nop
.L11:
	ld	[%fp-4], %g2
	ld	[%fp+76], %g1
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
.L12:
	ld	[%fp-4], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	generate_opcode_11, .-generate_opcode_11
	.align 4
	.global DFG_for_output_0
	.type	DFG_for_output_0, #function
	.proc	04
DFG_for_output_0:
	save	%sp, -96, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	mov	0, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	DFG_for_output_0, .-DFG_for_output_0
	.global regs
	.section	".data"
	.align 8
	.type	regs, #object
	.size	regs, 8
regs:
	.byte	16
	.byte	17
	.byte	18
	.byte	19
	.byte	20
	.byte	21
	.byte	22
	.byte	23
	.global instr_types
	.type	instr_types, #object
	.size	instr_types, 100
instr_types:
	.asciz	"control_transfer"
	.skip	3
	.asciz	"data_transfer"
	.skip	6
	.asciz	"floating_point"
	.skip	5
	.asciz	"integer_alu"
	.skip	8
	.asciz	"misc"
	.skip	15
	.global alu_mnemonic
	.type	alu_mnemonic, #object
	.size	alu_mnemonic, 6
alu_mnemonic:
	.byte	100
	.byte	98
	.skip	1
	.skip	3
	.common	alu_op_codes,2,8
	.common	complement_instr,2,8
	.global mem_mnemonic
	.type	mem_mnemonic, #object
	.size	mem_mnemonic, 6
mem_mnemonic:
	.byte	100
	.byte	116
	.skip	1
	.skip	3
	.global mem_op_codes
	.align 8
	.type	mem_op_codes, #object
	.size	mem_op_codes, 2
mem_op_codes:
	.byte	0
	.byte	4
	.section	".rodata"
	.align 8
.LC0:
	.asciz	"Hey There ................................\n"
	.section	".text"
	.align 4
	.global main
	.type	main, #function
	.proc	04
main:
	save	%sp, -128, %sp
	st	%i0, [%fp+68]
	mov	%sp, %g1
	mov	%g1, %i1
	mov	3, %o0
	call	__ajit_write_serial_control_register__, 0
	 nop
	mov	11, %g1
	st	%g1, [%fp-12]
	mov	16, %g1
	sth	%g1, [%fp-14]
	lduh	[%fp-14], %g1
	sth	%g1, [%fp-2]
	ld	[%fp-12], %g1
	add	%g1, -1, %g2
	st	%g2, [%fp-20]
	mov	%g1, %g2
	mov	%g2, %g3
	mov	0, %g2
	srl	%g3, 27, %g4
	sll	%g2, 5, %i2
	or	%g4, %i2, %i2
	sll	%g3, 5, %i3
	mov	%g1, %g2
	mov	%g2, %g3
	mov	0, %g2
	srl	%g3, 27, %g4
	sll	%g2, 5, %i4
	or	%g4, %i4, %i4
	sll	%g3, 5, %i5
	sll	%g1, 2, %g1
	add	%g1, 3, %g1
	add	%g1, 7, %g1
	srl	%g1, 3, %g1
	sll	%g1, 3, %g1
	sub	%sp, %g1, %sp
	add	%sp, 92, %g1
	add	%g1, 3, %g1
	srl	%g1, 2, %g1
	sll	%g1, 2, %g1
	st	%g1, [%fp-24]
	mov	18, %g1
	stb	%g1, [%fp-25]
	mov	16, %g1
	stb	%g1, [%fp-26]
	mov	17, %g1
	stb	%g1, [%fp-27]
	stb	%g0, [%fp-28]
	st	%g0, [%fp-8]
	b	.L17
	 nop
.L18:
	lduh	[%fp-2], %g1
	sll	%g1, 16, %g1
	srl	%g1, 16, %g1
	mov	%g1, %o0
	call	prbs, 0
	 nop
	mov	%o0, %g1
	sth	%g1, [%fp-2]
	lduh	[%fp-2], %g1
	sll	%g1, 16, %g1
	srl	%g1, 16, %g1
	mov	%g1, %o0
	call	prbs, 0
	 nop
	mov	%o0, %g1
	and	%g1, 1, %g1
	mov	%g1, %o0
	call	instr_select, 0
	 nop
	mov	%o0, %g1
	mov	%g1, %g2
	sethi	%hi(alu_op_codes), %g1
	or	%g1, %lo(alu_op_codes), %g3
	ld	[%fp-8], %g1
	add	%g3, %g1, %g1
	stb	%g2, [%g1]
	sethi	%hi(alu_op_codes), %g1
	or	%g1, %lo(alu_op_codes), %g2
	ld	[%fp-8], %g1
	add	%g2, %g1, %g1
	ldub	[%g1], %g1
	and	%g1, 0xff, %g1
	mov	%g1, %o0
	call	bring_complement_instr, 0
	 nop
	mov	%o0, %g1
	mov	%g1, %g2
	sethi	%hi(complement_instr), %g1
	or	%g1, %lo(complement_instr), %g3
	ld	[%fp-8], %g1
	add	%g3, %g1, %g1
	stb	%g2, [%g1]
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L17:
	ld	[%fp-8], %g1
	cmp	%g1, 1
	ble	.L18
	 nop
	ld	[%fp-24], %g1
	sethi	%hi(-1646019584), %g2
	or	%g2, 928, %g2
	st	%g2, [%g1]
	ldub	[%fp-26], %g1
	and	%g1, 0xff, %g4
	ldub	[%fp-28], %g1
	and	%g1, 0xff, %g3
	sethi	%hi(mem_op_codes), %g1
	or	%g1, %lo(mem_op_codes), %g1
	ldub	[%g1], %g1
	and	%g1, 0xff, %g2
	ld	[%fp+68], %g1
	sll	%g1, 16, %g1
	srl	%g1, 16, %g1
	mov	%g4, %o0
	mov	%g3, %o1
	mov	0, %o2
	mov	%g2, %o3
	mov	1, %o4
	mov	%g1, %o5
	call	generate_opcode_11, 0
	 nop
	mov	%o0, %g2
	ld	[%fp-24], %g1
	st	%g2, [%g1+4]
	ldub	[%fp-27], %g1
	and	%g1, 0xff, %g4
	ldub	[%fp-28], %g1
	and	%g1, 0xff, %g3
	sethi	%hi(mem_op_codes), %g1
	or	%g1, %lo(mem_op_codes), %g1
	ldub	[%g1], %g1
	and	%g1, 0xff, %g2
	ld	[%fp+68], %g1
	add	%g1, 4, %g1
	sll	%g1, 16, %g1
	srl	%g1, 16, %g1
	mov	%g4, %o0
	mov	%g3, %o1
	mov	0, %o2
	mov	%g2, %o3
	mov	1, %o4
	mov	%g1, %o5
	call	generate_opcode_11, 0
	 nop
	mov	%o0, %g2
	ld	[%fp-24], %g1
	st	%g2, [%g1+8]
	ldub	[%fp-25], %g1
	and	%g1, 0xff, %g4
	ldub	[%fp-26], %g1
	and	%g1, 0xff, %g3
	ldub	[%fp-27], %g1
	and	%g1, 0xff, %g2
	sethi	%hi(alu_op_codes), %g1
	or	%g1, %lo(alu_op_codes), %g1
	ldub	[%g1], %g1
	and	%g1, 0xff, %g1
	mov	%g4, %o0
	mov	%g3, %o1
	mov	%g2, %o2
	mov	%g1, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g2
	ld	[%fp-24], %g1
	st	%g2, [%g1+12]
	ldub	[%fp-26], %g1
	and	%g1, 0xff, %g4
	ldub	[%fp-25], %g1
	and	%g1, 0xff, %g3
	ldub	[%fp-26], %g1
	and	%g1, 0xff, %g2
	sethi	%hi(complement_instr), %g1
	or	%g1, %lo(complement_instr), %g1
	ldub	[%g1], %g1
	and	%g1, 0xff, %g1
	mov	%g4, %o0
	mov	%g3, %o1
	mov	%g2, %o2
	mov	%g1, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g2
	ld	[%fp-24], %g1
	st	%g2, [%g1+16]
	ldub	[%fp-27], %g1
	and	%g1, 0xff, %g4
	ldub	[%fp-25], %g1
	and	%g1, 0xff, %g3
	ldub	[%fp-27], %g1
	and	%g1, 0xff, %g2
	sethi	%hi(complement_instr), %g1
	or	%g1, %lo(complement_instr), %g1
	ldub	[%g1], %g1
	and	%g1, 0xff, %g1
	mov	%g4, %o0
	mov	%g3, %o1
	mov	%g2, %o2
	mov	%g1, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g2
	ld	[%fp-24], %g1
	st	%g2, [%g1+20]
	ldub	[%fp-26], %g1
	and	%g1, 0xff, %g4
	ldub	[%fp-28], %g1
	and	%g1, 0xff, %g3
	sethi	%hi(mem_op_codes), %g1
	or	%g1, %lo(mem_op_codes), %g1
	ldub	[%g1+1], %g1
	and	%g1, 0xff, %g2
	ld	[%fp+68], %g1
	add	%g1, 16, %g1
	sll	%g1, 16, %g1
	srl	%g1, 16, %g1
	mov	%g4, %o0
	mov	%g3, %o1
	mov	0, %o2
	mov	%g2, %o3
	mov	1, %o4
	mov	%g1, %o5
	call	generate_opcode_11, 0
	 nop
	mov	%o0, %g2
	ld	[%fp-24], %g1
	st	%g2, [%g1+24]
	ldub	[%fp-27], %g1
	and	%g1, 0xff, %g4
	ldub	[%fp-28], %g1
	and	%g1, 0xff, %g3
	sethi	%hi(mem_op_codes), %g1
	or	%g1, %lo(mem_op_codes), %g1
	ldub	[%g1+1], %g1
	and	%g1, 0xff, %g2
	ld	[%fp+68], %g1
	add	%g1, 20, %g1
	sll	%g1, 16, %g1
	srl	%g1, 16, %g1
	mov	%g4, %o0
	mov	%g3, %o1
	mov	0, %o2
	mov	%g2, %o3
	mov	1, %o4
	mov	%g1, %o5
	call	generate_opcode_11, 0
	 nop
	mov	%o0, %g2
	ld	[%fp-24], %g1
	st	%g2, [%g1+28]
	ld	[%fp-24], %g1
	sethi	%hi(-2115502080), %g2
	st	%g2, [%g1+32]
	ld	[%fp-24], %g1
	sethi	%hi(-2117869568), %g2
	or	%g2, 8, %g2
	st	%g2, [%g1+36]
	ld	[%fp-24], %g1
	sethi	%hi(16777216), %g2
	st	%g2, [%g1+40]
#APP
! 111 "main.c" 1
	 set instr_section, %l0
	 
! 0 "" 2
#NO_APP
	st	%g0, [%fp-8]
	st	%g0, [%fp-8]
	b	.L19
	 nop
.L20:
	ld	[%fp-24], %g2
	ld	[%fp-8], %g1
	sll	%g1, 2, %g1
	ld	[%g2+%g1], %g1
#APP
! 114 "main.c" 1
	 mov %g1, %l1 
	 
! 0 "" 2
! 115 "main.c" 1
	 st %l1, [%l0] 
	 
! 0 "" 2
! 116 "main.c" 1
	 add %l0, 0x4, %l0
	 
! 0 "" 2
#NO_APP
	ld	[%fp-8], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-8]
.L19:
	ld	[%fp-8], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bl	.L20
	 nop
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %o0
	call	ee_printf, 0
	 nop
	mov	1, %g1
	mov	%i1, %sp
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	main, .-main
	.ident	"GCC: (Buildroot 2014.08-gacf8924) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

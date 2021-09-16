	.file	"add_sub.c"
	.section	".text"
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
	ldub	[%fp+84], %g1
	sll	%g1, 24, %g1
	sra	%g1, 24, %g1
	cmp	%g1, 1
	bne	.L2
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
	b	.L3
	 nop
.L2:
	ld	[%fp-4], %g2
	ld	[%fp+76], %g1
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
.L3:
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
	bne	.L6
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
	b	.L7
	 nop
.L6:
	ld	[%fp-4], %g2
	ld	[%fp+76], %g1
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
.L7:
	ld	[%fp-4], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	generate_opcode_11, .-generate_opcode_11
	.align 4
	.global store_instr_in_instr_area_immediate
	.type	store_instr_in_instr_area_immediate, #function
	.proc	020
store_instr_in_instr_area_immediate:
	save	%sp, -96, %sp
	st	%i0, [%fp+68]
	ld	[%fp+68], %g1
#APP
! 43 "instruction_tests/integer_alu/Arithmetic/add_sub.c" 1
	 mov %g1, %l1 
	 
! 0 "" 2
! 44 "instruction_tests/integer_alu/Arithmetic/add_sub.c" 1
	 st %l1, [%l0] 
	 
! 0 "" 2
! 45 "instruction_tests/integer_alu/Arithmetic/add_sub.c" 1
	 add %l0, 0x4, %l0
	 
! 0 "" 2
#NO_APP
	restore
	jmp	%o7+8
	 nop
	.size	store_instr_in_instr_area_immediate, .-store_instr_in_instr_area_immediate
	.section	".rodata"
	.align 8
.LC0:
	.asciz	"------------------- Instructions generation done -------------------\n"
	.section	".text"
	.align 4
	.global add_sub
	.type	add_sub, #function
	.proc	04
add_sub:
	save	%sp, -136, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	mov	%sp, %g1
	mov	%g1, %i1
	mov	3, %o0
	call	__ajit_write_serial_control_register__, 0
	 nop
	sth	%g0, [%fp-26]
	sth	%g0, [%fp-24]
	sth	%g0, [%fp-22]
	mov	100, %g1
	stb	%g1, [%fp-26]
	mov	98, %g1
	stb	%g1, [%fp-25]
	stb	%g0, [%fp-32]
	mov	4, %g1
	stb	%g1, [%fp-31]
	sth	%g0, [%fp-38]
	sth	%g0, [%fp-36]
	sth	%g0, [%fp-34]
	mov	100, %g1
	stb	%g1, [%fp-38]
	mov	116, %g1
	stb	%g1, [%fp-37]
	stb	%g0, [%fp-40]
	mov	4, %g1
	stb	%g1, [%fp-39]
	mov	18, %g1
	stb	%g1, [%fp-5]
	mov	16, %g1
	stb	%g1, [%fp-6]
	mov	17, %g1
	stb	%g1, [%fp-7]
	stb	%g0, [%fp-8]
	ld	[%fp+72], %o0
	call	generate_input_output, 0
	 nop
	ld	[%fp+72], %g2
	mov	%g2, %g1
	sll	%g1, 3, %g1
	sub	%g1, %g2, %g1
	add	%g1, 4, %g1
	st	%g1, [%fp-12]
	ld	[%fp-12], %g1
	add	%g1, -1, %g2
	st	%g2, [%fp-16]
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
	st	%g1, [%fp-20]
	ld	[%fp-20], %g1
	sethi	%hi(-1646019584), %g2
	or	%g2, 928, %g2
	st	%g2, [%g1]
	st	%g0, [%fp-4]
	b	.L11
	 nop
.L12:
	ld	[%fp-4], %g2
	mov	%g2, %g1
	sll	%g1, 3, %g1
	sub	%g1, %g2, %g1
	add	%g1, 1, %i5
	ldub	[%fp-6], %g1
	and	%g1, 0xff, %g4
	ldub	[%fp-8], %g1
	and	%g1, 0xff, %g3
	ldub	[%fp-40], %g1
	and	%g1, 0xff, %g2
	ld	[%fp-4], %g1
	sll	%g1, 3, %g1
	mov	%g1, %i4
	ld	[%fp+68], %g1
	add	%i4, %g1, %g1
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
	mov	%o0, %g3
	ld	[%fp-20], %g2
	sll	%i5, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-4], %g2
	mov	%g2, %g1
	sll	%g1, 3, %g1
	sub	%g1, %g2, %g1
	add	%g1, 2, %i5
	ldub	[%fp-7], %g1
	and	%g1, 0xff, %g4
	ldub	[%fp-8], %g1
	and	%g1, 0xff, %g3
	ldub	[%fp-40], %g1
	and	%g1, 0xff, %g2
	ld	[%fp-4], %g1
	sll	%g1, 3, %g1
	mov	%g1, %i4
	ld	[%fp+68], %g1
	add	%i4, %g1, %g1
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
	mov	%o0, %g3
	ld	[%fp-20], %g2
	sll	%i5, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-4], %g2
	mov	%g2, %g1
	sll	%g1, 3, %g1
	sub	%g1, %g2, %g1
	add	%g1, 3, %i5
	ldub	[%fp-5], %g1
	and	%g1, 0xff, %g4
	ldub	[%fp-6], %g1
	and	%g1, 0xff, %g3
	ldub	[%fp-7], %g1
	and	%g1, 0xff, %g2
	ldub	[%fp-32], %g1
	and	%g1, 0xff, %g1
	mov	%g4, %o0
	mov	%g3, %o1
	mov	%g2, %o2
	mov	%g1, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g3
	ld	[%fp-20], %g2
	sll	%i5, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-4], %g2
	mov	%g2, %g1
	sll	%g1, 3, %g1
	sub	%g1, %g2, %g1
	add	%g1, 4, %i5
	ldub	[%fp-6], %g1
	and	%g1, 0xff, %g4
	ldub	[%fp-5], %g1
	and	%g1, 0xff, %g3
	ldub	[%fp-6], %g1
	and	%g1, 0xff, %g2
	ldub	[%fp-31], %g1
	and	%g1, 0xff, %g1
	mov	%g4, %o0
	mov	%g3, %o1
	mov	%g2, %o2
	mov	%g1, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g3
	ld	[%fp-20], %g2
	sll	%i5, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-4], %g2
	mov	%g2, %g1
	sll	%g1, 3, %g1
	sub	%g1, %g2, %g1
	add	%g1, 5, %i5
	ldub	[%fp-7], %g1
	and	%g1, 0xff, %g4
	ldub	[%fp-5], %g1
	and	%g1, 0xff, %g3
	ldub	[%fp-7], %g1
	and	%g1, 0xff, %g2
	ldub	[%fp-31], %g1
	and	%g1, 0xff, %g1
	mov	%g4, %o0
	mov	%g3, %o1
	mov	%g2, %o2
	mov	%g1, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_10, 0
	 nop
	mov	%o0, %g3
	ld	[%fp-20], %g2
	sll	%i5, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-4], %g2
	mov	%g2, %g1
	sll	%g1, 3, %g1
	sub	%g1, %g2, %g1
	add	%g1, 6, %i5
	ldub	[%fp-6], %g1
	and	%g1, 0xff, %g4
	ldub	[%fp-8], %g1
	and	%g1, 0xff, %g3
	ldub	[%fp-39], %g1
	and	%g1, 0xff, %g2
	ld	[%fp+72], %g1
	mov	%g1, %i4
	ld	[%fp-4], %g1
	add	%i4, %g1, %g1
	sll	%g1, 3, %g1
	mov	%g1, %i4
	ld	[%fp+68], %g1
	add	%i4, %g1, %g1
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
	mov	%o0, %g3
	ld	[%fp-20], %g2
	sll	%i5, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-4], %g1
	add	%g1, 1, %g2
	mov	%g2, %g1
	sll	%g1, 3, %g1
	sub	%g1, %g2, %i5
	ldub	[%fp-7], %g1
	and	%g1, 0xff, %g4
	ldub	[%fp-8], %g1
	and	%g1, 0xff, %g3
	ldub	[%fp-39], %g1
	and	%g1, 0xff, %g2
	ld	[%fp+72], %g1
	mov	%g1, %i4
	ld	[%fp-4], %g1
	add	%i4, %g1, %g1
	sll	%g1, 3, %g1
	mov	%g1, %i4
	ld	[%fp+68], %g1
	add	%i4, %g1, %g1
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
	mov	%o0, %g3
	ld	[%fp-20], %g2
	sll	%i5, 2, %g1
	st	%g3, [%g2+%g1]
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L11:
	ld	[%fp-4], %g2
	ld	[%fp+72], %g1
	cmp	%g2, %g1
	bl	.L12
	 nop
	ld	[%fp-12], %g1
	add	%g1, -3, %g1
	ld	[%fp-20], %g2
	sll	%g1, 2, %g1
	sethi	%hi(-2115502080), %g3
	st	%g3, [%g2+%g1]
	ld	[%fp-12], %g1
	add	%g1, -2, %g1
	ld	[%fp-20], %g2
	sll	%g1, 2, %g1
	sethi	%hi(-2117869568), %g3
	or	%g3, 8, %g3
	st	%g3, [%g2+%g1]
	ld	[%fp-12], %g1
	add	%g1, -1, %g1
	ld	[%fp-20], %g2
	sll	%g1, 2, %g1
	sethi	%hi(16777216), %g3
	st	%g3, [%g2+%g1]
#APP
! 94 "instruction_tests/integer_alu/Arithmetic/add_sub.c" 1
	 set instr_section, %l0
	 
! 0 "" 2
#NO_APP
	st	%g0, [%fp-4]
	b	.L13
	 nop
.L14:
	ld	[%fp-20], %g2
	ld	[%fp-4], %g1
	sll	%g1, 2, %g1
	ld	[%g2+%g1], %g1
#APP
! 96 "instruction_tests/integer_alu/Arithmetic/add_sub.c" 1
	 mov %g1, %l1 
	 
! 0 "" 2
! 97 "instruction_tests/integer_alu/Arithmetic/add_sub.c" 1
	 st %l1, [%l0] 
	 
! 0 "" 2
! 98 "instruction_tests/integer_alu/Arithmetic/add_sub.c" 1
	 add %l0, 0x4, %l0
	 
! 0 "" 2
#NO_APP
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L13:
	ld	[%fp-4], %g2
	ld	[%fp-12], %g1
	cmp	%g2, %g1
	bl	.L14
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
	.size	add_sub, .-add_sub
	.ident	"GCC: (Buildroot 2014.08-g230601f) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

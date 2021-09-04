	.file	"main.c"
	.section	".text"
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
	.size	generate_opcode_11, .-generate_opcode_11
	.global instr_types
	.section	".data"
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
	.section	".rodata"
	.align 8
.LC1:
	.asciz	"Hey There................................\n"
	.align 8
.LC0:
	.byte	16
	.byte	17
	.byte	18
	.byte	19
	.byte	20
	.byte	21
	.byte	22
	.byte	23
	.section	".text"
	.align 4
	.global main
	.type	main, #function
	.proc	04
main:
	save	%sp, -136, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	mov	3, %o0
	call	__ajit_write_serial_control_register__, 0
	 nop
	sth	%g0, [%fp-14]
	sth	%g0, [%fp-12]
	sth	%g0, [%fp-10]
	mov	100, %g1
	stb	%g1, [%fp-14]
	mov	98, %g1
	stb	%g1, [%fp-13]
	stb	%g0, [%fp-16]
	mov	4, %g1
	stb	%g1, [%fp-15]
	mov	1, %g1
	stb	%g1, [%fp-5]
	sethi	%hi(.LC0), %g1
	or	%g1, %lo(.LC0), %g1
	add	%fp, -24, %g3
	mov	%g1, %g2
	mov	8, %g1
	mov	%g3, %o0
	mov	%g2, %o1
	mov	%g1, %o2
	call	memcpy, 0
	 nop
	st	%g0, [%fp-4]
	st	%g0, [%fp-4]
	b	.L4
	 nop
.L5:
	mov	4, %g1
	stb	%g1, [%fp-6]
	mov	2, %g1
	stb	%g1, [%fp-7]
	mov	3, %g1
	stb	%g1, [%fp-8]
	ldub	[%fp-6], %g1
	and	%g1, 0xff, %g4
	ldub	[%fp-7], %g1
	and	%g1, 0xff, %g3
	ldub	[%fp-8], %g1
	and	%g1, 0xff, %g2
	ldub	[%fp-16], %g1
	and	%g1, 0xff, %g1
	mov	%g4, %o0
	mov	%g3, %o1
	mov	%g2, %o2
	mov	%g1, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_11, 0
	 nop
	mov	%o0, %g1
	st	%g1, [%fp-36]
	ldub	[%fp-7], %g1
	and	%g1, 0xff, %g4
	ldub	[%fp-6], %g1
	and	%g1, 0xff, %g3
	ldub	[%fp-7], %g1
	and	%g1, 0xff, %g2
	ldub	[%fp-15], %g1
	and	%g1, 0xff, %g1
	mov	%g4, %o0
	mov	%g3, %o1
	mov	%g2, %o2
	mov	%g1, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_11, 0
	 nop
	mov	%o0, %g1
	st	%g1, [%fp-32]
	ldub	[%fp-8], %g1
	and	%g1, 0xff, %g4
	ldub	[%fp-6], %g1
	and	%g1, 0xff, %g3
	ldub	[%fp-8], %g1
	and	%g1, 0xff, %g2
	ldub	[%fp-15], %g1
	and	%g1, 0xff, %g1
	mov	%g4, %o0
	mov	%g3, %o1
	mov	%g2, %o2
	mov	%g1, %o3
	mov	0, %o4
	mov	0, %o5
	call	generate_opcode_11, 0
	 nop
	mov	%o0, %g1
	st	%g1, [%fp-28]
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L4:
	ldub	[%fp-5], %g1
	and	%g1, 0xff, %g2
	ld	[%fp-4], %g1
	cmp	%g2, %g1
	bg	.L5
	 nop
#APP
! 38 "main.c" 1
	 set instr_section, %l0
	 
! 0 "" 2
#NO_APP
	st	%g0, [%fp-4]
	st	%g0, [%fp-4]
	b	.L6
	 nop
.L7:
	ld	[%fp-4], %g1
	sll	%g1, 2, %g1
	add	%fp, %g1, %g1
	ld	[%g1-36], %g1
#APP
! 41 "main.c" 1
	 mov %g1, %l1 
	 
! 0 "" 2
! 42 "main.c" 1
	 st %l1, [%l0] 
	 
! 0 "" 2
! 43 "main.c" 1
	 add %l0, 0x4, %l0
	 
! 0 "" 2
#NO_APP
	ld	[%fp-4], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-4]
.L6:
	ld	[%fp-4], %g1
	cmp	%g1, 2
	ble	.L7
	 nop
	sethi	%hi(.LC1), %g1
	or	%g1, %lo(.LC1), %o0
	call	ee_printf, 0
	 nop
	mov	1, %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	main, .-main
	.ident	"GCC: (Buildroot 2014.08-g230601f) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

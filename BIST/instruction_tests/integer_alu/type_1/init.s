.global _start;
.section .text.ajitstart
_start:
	set 0xfff01ff8, %sp
  	set 0xfff01f00, %fp
	!clr %fp

	set 0x1, %l0		! window 0 is marked invalid...  we start at window 7
	wr %l0, 0x0, %wim	!

	! trap table.
	set	trap_table_base, %l0
	wr	%l0, 0x0, %tbr

	! set up virtual -> physical map.
	call page_table_setup 	
	nop

	! set context table pointer.
	call set_context_table_pointer
	nop

	! enable traps.
	set 0x10E0, %l0	
	wr %l0, %psr

  	! enable mmu.
	set 0x1, %o0
	sta %o0, [%g0] 0xa   
    

	!-------------------------------
loop:

	set 0x1, %l1				! seed for generating input pairs
	set 0x1, %l2				! seed for register - register_seed
	set instr_arr_base, %l0
	set 0x0, %l3				! instr_arr counter


	set results_section, %o0
	mov %l1, %o1 				! seed for generating input pairs
	call generate_input_output
	nop

	set test_program, %o0
	set results_section, %o1
	set register_coverage, %o2
	mov %l2, %o3				! seed for register - register_seed
	ldub [%l0 + %l3], %o4
	call main
	nop	
		
	ta 0
	nop

	call test_program
	nop


	set results_section, %o0
	set data_coverage, %o1
	set ccr_coverage, %o2
	mov %l1, %o3
	mov %l2, %o4
	ldub [%l0 + %l3], %o5
	call checker
	nop

	ba print
	nop
	ta 0

print:
	set register_coverage, %o0
	set data_coverage, %o1
	set ccr_coverage, %o2
	mov %l1, %o3
	mov %l2, %o4
	call print_coverage
	
	!increment seed
	add %l1, 0x1, %l1
	add %l2, 0x1, %l2

	add %l3, 0x1, %l3
	cmp %l3, 0xc
	be rewind


	nop
	ba loop
	nop
	ta 0

rewind:
	set instr_arr_base, %l0
	nop
	ba loop
	nop
	ta 0
!-------------------------------------------

	.align 4
	.global test_program
	test_program:
	.skip	6000


	!.data

	.align 16
	instr_arr_base:
	add: 	.byte 0x00
	addcc: 	.byte 0x10
	sub:	.byte 0x04
	subcc:	.byte 0x14
	xor:	.byte 0x03
	xorcc:	.byte 0x13
	xnor:	.byte 0x07
	xnorcc:	.byte 0x17
	umul:	.byte 0x0a
	umulcc:	.byte 0x1a
	smul:	.byte 0x0b
	smulcc:	.byte 0x1b


	.align 8
	.global results_section 
	results_section:
	.skip	4000

!------------------------------------------
	.align 4
	.global coverage_section
	coverage_section:

	.global register_coverage
	register_coverage:
	.skip 384
	
	.global data_coverage
	data_coverage:
	.skip 16384
	
	.global ccr_coverage
	ccr_coverage:
	.skip 65536



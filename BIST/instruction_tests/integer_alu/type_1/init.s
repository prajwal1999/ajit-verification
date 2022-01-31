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


	!addcc two negative numbers
	set -2, %l0
	set -3, %l1
	addcc %l0, %l1, %o2	! Expected o2=0xFFFFFFFB


	set test_program, %o0
	set results_section, %o1
	set register_coverage, %o2
	set data_coverage, %o3
    set save_registers, %o4
	set instr_count, %o5
	
	call wrapper
	nop


!------------------------------------------


!-------------------------------------------

	ta 0
	nop

	.align 4
	.global test_program
	test_program:
	.skip 64000


	!.data

	.align 4
	.global results_section 
	results_section:
	.skip	34000

	.align 4
    .global save_registers
    save_registers:
    .skip 16

!------------------------------------------
	.align 4
	.global coverage_section
	coverage_section:

	.global register_coverage
	register_coverage:
	.skip 512
	
	.global data_coverage
	data_coverage:
	.skip 16384

	.global instr_count
	instr_count:
	add:   .skip 4
	addcc: .skip 4 
	addx:  .skip 4  
	sub:   .skip 4    
	subcc: .skip 4 
	subx:  .skip 4  
	xor:   .skip 4   
	xorcc: .skip 4 
	xnor:  .skip 4  
	xnorcc:.skip 4 
	umul:  .skip 4  
	umulcc:.skip 4 
	smul:  .skip 4  
	smulcc:.skip 4




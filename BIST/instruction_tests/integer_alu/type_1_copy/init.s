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


	set test_program, %o0
	set results_section, %o1
	set register_coverage, %o2
	set data_coverage, %o3
	call wrapper
	nop

	!-------------------------------



!-------------------------------------------

	.align 4
	.global test_program
	test_program:
	.skip	54000


	!.data


	.align 8
	.global results_section 
	results_section:
	.skip	32000

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




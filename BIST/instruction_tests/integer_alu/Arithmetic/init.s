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
	set 0x10E7, %l0	
	wr %l0, %psr

  	! enable mmu.
	set 0x1, %o0
	sta %o0, [%g0] 0xa   
    

	!-------------------------------
loop:
	set results_section, %o0
	set register_coverage, %o1
	call add
	nop

	call instr_section
	nop

	set results_section, %o0
	set register_coverage, %o1
	set data_coverage, %o2
	call checker
	nop

	!ba loop
	nop
	ta 0
!-------------------------------------------

	.align 8
	.global instr_section
	instr_section:
	.skip	4000

	.align 2
	.global results_section 
	results_section:
	.skip	2400

!------------------------------------------
	.align 4
	.global coverage_section
	coverage_section:

	.global register_coverage
	register_coverage:
	.skip 96
	
	.global data_coverage
	data_coverage:
	.skip 4096
	
	.global ccr_coverage
	ccr_coverage:
	.skip 16384 


	

	ta 0



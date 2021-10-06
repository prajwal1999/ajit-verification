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
	
	set results_section, %o0
	set 0x1, %l1
	mov %l1, %o1 				! seed for generating input pairs
	call generate_input_output
	nop

	set instr_section, %o0
	set results_section, %o1
	set register_coverage, %o2
	set 0x1, %l2				
	mov %l2, %o3				! seed for register - register_seed
	call main
	nop

	call instr_section
	nop

	set results_section, %o0
	set data_coverage, %o1
	set ccr_coverage, %o2
	call checker
	nop
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

	nop
	ba loop
	nop
	ta 0
!-------------------------------------------

	.align 8
	.global instr_section
	instr_section:
	.skip	48000

	.align 2
	.global results_section 
	results_section:
	.skip	28000

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


	

	ta 0



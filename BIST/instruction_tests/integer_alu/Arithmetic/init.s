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

	set 0x0, %g2
	set 0x0, %g3
	set 0x0, %g4

	sethi %hi(0x0), %g2
	or %g2, 0x1098, %g3
	add %g2, 0x1098, %g4
	ta 0 



	set results_section, %o0
	set number_of_inputs, %l1 
    ld [%l1], %o1
	call add_sub
	nop

	call instr_section
	nop

	ta 0

	set results_section, %o0
	set number_of_inputs, %l1 
    ld [%l1], %o1
	call checker
	nop

	ba loop
	nop
	ta 0
	!----------------------------------

	.align 8
	.global instr_section
	instr_section:
	.skip	0x1000

	.align 2
	.global results_section 
	results_section:
	.skip	0x1000

	.align 4
	.global number_of_inputs
    number_of_inputs: .word 0x1
	



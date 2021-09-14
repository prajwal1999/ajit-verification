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
    
	set number_of_inputs, %l1 
    ld [%l1], %o0
	call generate_input_output
	nop
	
    set results_section, %o0
	set number_of_inputs, %l1 
    ld [%l1], %o1
	set number_of_instrs, %l1 
    ld [%l1], %o2
	call main
	nop 

	call instr_section
	nop

	set results_section, %o0
	set number_of_inputs, %l1 
    ld [%l1], %o1
	set instr_section, %o2
	set number_of_instrs, %l1 
    ld [%l1], %o3
	call checker
	nop

	ta 0

	.align 8
	.global instr_section
	instr_section:
	.skip	0x1ff

	.align 2
	.global results_section 
	results_section:
	.skip	0xff

	.align 4
	.global number_of_inputs
    number_of_inputs: .word 0x8
	.global number_of_instrs
    number_of_instrs: .word 0x4
	




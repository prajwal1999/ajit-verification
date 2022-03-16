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
	
	set results_section, %g2

	ld [%g2 + 0], %g3
	add %g3, 0x8e9, %g5

	ld [%g2 + 32], %g3
	add %g3, 0x5f3, %g6

	ld [%g2 + 64], %l1
	add %l1, 0x477, %g7



	ta 0
	nop
!-------------------------------------------

	.align 4
	.global results_section 
	results_section:
	.word 0x0
	.word 0x8e9
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0

	.word 0x1
	.word 0x5f3
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0

	.word 0x0
	.word 0x477
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0
	

!------------------------------------------

	ta 0
	nop



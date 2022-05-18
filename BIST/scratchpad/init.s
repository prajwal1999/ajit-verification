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
!------------------------------------------
	set 0xcf181136, %g4
	set 0x6ae84289, %g5
	set 0x0, %g6
	taddcc %g4, %g5, %g6
	!nop
	!call print2

	

!------------------------------------------------	
	!set A, %l3		
	!set B, %l4
	!set C, %l5
	!set D, %l6		
	!set E, %l7		

	!ld [%l3], %f10		
	!ld [%l4], %f11		
	!fsubs %f10, %f11, %f12
	!fsubs %f12, %f10, %f10
	!fsubs %f12, %f11, %f11	
	!st %f12, [%l5]
	!st %f10, [%l7]
	!st %f11, [%l6]


	!set test_program, %o0
	!call print
	nop
	nop
	nop




!-------------------------------------------

	ta 0
	nop

	.align 8
	.global test_program
	test_program:
	A: .word 0xcf181136 	!inp1
	B: .word 0x6ae84289  	!inp2
	C: .word 0x0			!res
	D: .word 0x0		!inp1
	E: .word 0x0		!inp2

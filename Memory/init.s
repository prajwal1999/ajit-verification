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

	 
loop:
	!set start_state, %l1
	!ld [%l1], %o0
	!add %o0,1,%o0
	!st %o0, [%l1]
	call main
	nop 
	ba loop

	nop
	ta 0
	!----------------------------------

	!.align 2
	!.global start_state
    !start_state: .word 0x000A
	!.word 0xA000





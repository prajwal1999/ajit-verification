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


	set Zero, %l0; ld [%l0], %f0
	fmovs %f0, %f1  ; fmovs %f0, %f2  ; fmovs %f0, %f3  ; fmovs %f0, %f4  ;
	fmovs %f0, %f5  ; fmovs %f0, %f6  ; fmovs %f0, %f7  ; fmovs %f0, %f8  ;
	fmovs %f0, %f9  ; fmovs %f0, %f10 ; fmovs %f0, %f11 ; fmovs %f0, %f12 ;
	fmovs %f0, %f13 ; fmovs %f0, %f14 ; fmovs %f0, %f15 ; fmovs %f0, %f16 ;
	fmovs %f0, %f17 ; fmovs %f0, %f18 ; fmovs %f0, %f19 ; fmovs %f0, %f20 ;
	fmovs %f0, %f21 ; fmovs %f0, %f22 ; fmovs %f0, %f23 ; fmovs %f0, %f24 ;
	fmovs %f0, %f25 ; fmovs %f0, %f26 ; fmovs %f0, %f27 ; fmovs %f0, %f28 ;
	fmovs %f0, %f29 ; fmovs %f0, %f30 ; fmovs %f0, %f31 ; 
	nop

!--------------------------------------------------------------------------------
	set test_program, %o0
	set results_section, %o1
	set register_coverage, %o2
	set data_coverage, %o3
    set save_registers, %o4
	call wrapper
	nop


!--------------------------------------------------------------------------------

	.align 4
	.global test_program
	test_program:
	.skip 5400


	!.data
	.align 4
	Zero: .word 0

	.align 32
	.global results_section 
	results_section:
	.skip	3200

	.align 16
    .global save_registers
    save_registers:
    .skip 16

	!------------------------------------------
	.align 4
	.global coverage_section
	coverage_section:

	.global register_coverage
	register_coverage:
	.skip 384
	
	.global data_coverage
	data_coverage:
	.skip 4
	!.skip 16384





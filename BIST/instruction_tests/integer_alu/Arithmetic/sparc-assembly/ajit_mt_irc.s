	.file	"ajit_mt_irc.c"
	.section	".text"
	.align 4
	.global readInterruptControlRegister
	.type	readInterruptControlRegister, #function
	.proc	016
readInterruptControlRegister:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	ld	[%fp+68], %g1
	add	%g1, %g1, %g1
	mov	%g1, %g2
	ld	[%fp+72], %g1
	add	%g2, %g1, %g1
	sll	%g1, 2, %g1
	mov	%g1, %g2
	sethi	%hi(-53248), %g1
	add	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp-4], %o0
	call	__ajit_load_word_mmu_bypass__, 0
	 nop
	st	%o0, [%fp-8]
	ld	[%fp-8], %g1
	mov	%g1, %i0
	restore
	jmp	%o7+8
	 nop
	.size	readInterruptControlRegister, .-readInterruptControlRegister
	.align 4
	.global writeInterruptControlRegister
	.type	writeInterruptControlRegister, #function
	.proc	020
writeInterruptControlRegister:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	ld	[%fp+68], %g1
	add	%g1, %g1, %g1
	mov	%g1, %g2
	ld	[%fp+72], %g1
	add	%g2, %g1, %g1
	sll	%g1, 2, %g1
	mov	%g1, %g2
	sethi	%hi(-53248), %g1
	add	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp-4], %o0
	ld	[%fp+76], %o1
	call	__ajit_store_word_mmu_bypass__, 0
	 nop
	restore
	jmp	%o7+8
	 nop
	.size	writeInterruptControlRegister, .-writeInterruptControlRegister
	.align 4
	.global enableInterruptController
	.type	enableInterruptController, #function
	.proc	020
enableInterruptController:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	ld	[%fp+68], %o0
	ld	[%fp+72], %o1
	call	readInterruptControlRegister, 0
	 nop
	st	%o0, [%fp-4]
	ld	[%fp-4], %g1
	or	%g1, 1, %g1
	st	%g1, [%fp-4]
	ld	[%fp+68], %o0
	ld	[%fp+72], %o1
	ld	[%fp-4], %o2
	call	writeInterruptControlRegister, 0
	 nop
	restore
	jmp	%o7+8
	 nop
	.size	enableInterruptController, .-enableInterruptController
	.align 4
	.global disableInterruptController
	.type	disableInterruptController, #function
	.proc	020
disableInterruptController:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	ld	[%fp+68], %o0
	ld	[%fp+72], %o1
	call	readInterruptControlRegister, 0
	 nop
	st	%o0, [%fp-4]
	ld	[%fp-4], %g1
	and	%g1, -2, %g1
	st	%g1, [%fp-4]
	ld	[%fp+68], %o0
	ld	[%fp+72], %o1
	ld	[%fp-4], %o2
	call	writeInterruptControlRegister, 0
	 nop
	restore
	jmp	%o7+8
	 nop
	.size	disableInterruptController, .-disableInterruptController
	.align 4
	.global enableInterrupt
	.type	enableInterrupt, #function
	.proc	020
enableInterrupt:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	ld	[%fp+68], %o0
	ld	[%fp+72], %o1
	call	readInterruptControlRegister, 0
	 nop
	st	%o0, [%fp-4]
	mov	1, %g2
	ld	[%fp+76], %g1
	sll	%g2, %g1, %g1
	ld	[%fp-4], %g2
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp+68], %o0
	ld	[%fp+72], %o1
	ld	[%fp-4], %o2
	call	writeInterruptControlRegister, 0
	 nop
	restore
	jmp	%o7+8
	 nop
	.size	enableInterrupt, .-enableInterrupt
	.align 4
	.global enableAllInterrupts
	.type	enableAllInterrupts, #function
	.proc	020
enableAllInterrupts:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	ld	[%fp+68], %o0
	ld	[%fp+72], %o1
	call	readInterruptControlRegister, 0
	 nop
	st	%o0, [%fp-4]
	ld	[%fp-4], %g2
	sethi	%hi(64512), %g1
	or	%g1, 1022, %g1
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp+68], %o0
	ld	[%fp+72], %o1
	ld	[%fp-4], %o2
	call	writeInterruptControlRegister, 0
	 nop
	restore
	jmp	%o7+8
	 nop
	.size	enableAllInterrupts, .-enableAllInterrupts
	.align 4
	.global setInterruptMask
	.type	setInterruptMask, #function
	.proc	020
setInterruptMask:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	ld	[%fp+68], %o0
	ld	[%fp+72], %o1
	call	readInterruptControlRegister, 0
	 nop
	st	%o0, [%fp-4]
	sethi	%hi(64512), %g1
	or	%g1, 1022, %g1
	st	%g1, [%fp-8]
	ld	[%fp-8], %g1
	xnor	%g0, %g1, %g2
	ld	[%fp-4], %g1
	and	%g2, %g1, %g2
	ld	[%fp-8], %g3
	ld	[%fp+76], %g1
	and	%g3, %g1, %g1
	or	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp+68], %o0
	ld	[%fp+72], %o1
	ld	[%fp-4], %o2
	call	writeInterruptControlRegister, 0
	 nop
	restore
	jmp	%o7+8
	 nop
	.size	setInterruptMask, .-setInterruptMask
	.align 4
	.global disableInterrupt
	.type	disableInterrupt, #function
	.proc	020
disableInterrupt:
	save	%sp, -104, %sp
	st	%i0, [%fp+68]
	st	%i1, [%fp+72]
	st	%i2, [%fp+76]
	ld	[%fp+68], %o0
	ld	[%fp+72], %o1
	call	readInterruptControlRegister, 0
	 nop
	st	%o0, [%fp-4]
	mov	1, %g2
	ld	[%fp+76], %g1
	sll	%g2, %g1, %g1
	xnor	%g0, %g1, %g1
	ld	[%fp-4], %g2
	and	%g2, %g1, %g1
	st	%g1, [%fp-4]
	ld	[%fp+68], %o0
	ld	[%fp+72], %o1
	ld	[%fp-4], %o2
	call	writeInterruptControlRegister, 0
	 nop
	restore
	jmp	%o7+8
	 nop
	.size	disableInterrupt, .-disableInterrupt
	.ident	"GCC: (Buildroot 2014.08-g230601f) 4.7.4"
	.section	.note.GNU-stack,"",@progbits

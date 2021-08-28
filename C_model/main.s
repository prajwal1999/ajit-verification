.global main
main:
    save
    ! run given function
    set store_data_base, %g4 ! head of inputs data structure
    set number_of_inputs, %g5 
    ld [%g5], %g5 ! total number of inputs
    umul %g5, 0x32, %g6
!loop:
    ldd [%g4], %l0
    ldd [%g4 + 0x8], %l2
    !add %l0, %l2, %l4
    !rd %psr, %i0
    !std %o0, [%g4 + 0x16]
    !st %i0, [%g4 + 0x24]
    !add %g4, 0x40, %g4
    !cmp %g4, %g6
    !bne loop
    !call serial
    ta 0
    nop
    nop

    ! End of test
    !======================================

    !control should NOT reach here
    not_reached:
    set 0xDEAD, %g5
    ta 0
    nop
    nop



   
.global main
main:
    save
    ! run given function
    set store_data_base, %g7 ! head of inputs data structure
    set number_of_inputs, %l1 
    ld [%l1], %l1 ! total number of inputs
    umul %l1, 0x16, %g4
    add %g7, %g4, %g4
    set 0x0, %g2
    set 0x0, %g3
    set 0x0, %g5
    set 0x0, %g6
loop:
    ld [%g7], %g2
    ld [%g7 + 0x4], %g3
    add %g2, %g3, %g5
    rd %psr, %g6
    st %g5, [%g7 + 0x8]
    st %g6, [%g7 + 0xc]
    add %g7, 0x10, %g7
    cmp %g7, %g4
    bne loop
    nop
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



   
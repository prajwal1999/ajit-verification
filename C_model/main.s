.global main
main:
    ! run given function
    set store_data_base, %g0 ! head of inputs data structure
    set number_of_inputs, %g1 ! total number of inputs
    umul %g1, 0x40, %g2
loop:
    ldd [%g0], %l0
    ldd [%g0 + 0x10], %l2
    udivdcc %l0, %l2, %o0
    rd %psr, %i0
    std %o0, [%g0 + 0x20]
    st %i0, [%g0 + 0x30]
    add %g0, 0x40, %g0
    cmp %g0, %g2
    bne loop
    !call serial
    ta 0
    nop
    nop

    ! End of test
    !======================================

    !control should NOT reach here
    not_reached:
    set 0xDEAD, %g1
    ta 0
    nop
    nop



   
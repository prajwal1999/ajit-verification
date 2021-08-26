main:
    ! AND complementary bits
    set 0xAAAAAAAA,%g2
    set 0xAAAAAAAA,%g3
    set 0x55555555,%g6
    set 0x55555555,%g7
    rd %psr, %i0
    and %g2,%g6,%g4
    rd %psr, %i1 

    ! AND same bits
    set 0xAAAAAAAA,%l0
    set 0xAAAAAAAA,%l1
    and %l0,%l0,%l2 
    rd %psr, %i2	


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



    .align 4
    data_A: .word 0x0A
    data_B: .word 0x0B
    data_C: .word 0x3FCE
    data_D: .word 0x2EC1



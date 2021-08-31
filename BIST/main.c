#include<stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include "core_portme.h"
#include "ajit_access_routines.h"

char instr_types[5][20] = {"control_transfer", "data_transfer", "floating_point", "integer_alu", "misc"};
// char control_instrs[]

int main () {
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);
    unsigned char mnemonic[2][3] = {'add', 'sub'};
    unsigned char op_codes[2] = {0x00, 0x04};
    unsigned char n_tests = 1;
    unsigned char regs[8] = {0b10000, 0b10001, 0b10010, 0b10011, 0b10100, 0b10101, 0b10110, 0b10111};
    unsigned int tests[3];
    int i=0;
    for(i=0; i<n_tests; i++) {
        // __asm__ __volatile__( " add %l0, %l1, %l2\n\t ");
        unsigned char rd = 0b10010;
        unsigned char rs1 = 0b10000;
        unsigned char rs2 = 0b10001;
        unsigned int test = 0x80000000;
        test |= rd << 25;
        test |= op_codes[0] << 19;
        test |= rs1 << 14;
        test |= rs2;
        tests[0] = test;

        test = 0x80000000;
        test |= rs1 << 25;
        test |= op_codes[1] << 19;
        test |= rd << 14;
        test |= rs1;
        tests[1] = test;

        test = 0x80000000;
        test |= rs2 << 25;
        test |= op_codes[1] << 19;
        test |= rd << 14;
        test |= rs2;
        tests[2] = test;
    }

    __asm__ __volatile__( " set instr_section, %l0\n\t " );
    i=0;
    for(i=0; i<3; i++) {
        __asm__ __volatile__( " mov %0, %%l1 \n\t " : : "r" (tests[i]) );
        __asm__ __volatile__( " st %l1, [%l0] \n\t " );
        __asm__ __volatile__( " add %l0, 0x4, %l0\n\t " );
    }

    ee_printf("Hey There\n");
    return(1);
}

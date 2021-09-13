#include<stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include "instr_select.h"


unsigned int generate_opcode_10(unsigned int rd, unsigned int rs1, unsigned int rs2, 
                unsigned int op_code, char i, unsigned short imm)
{
    unsigned int test = 0x80000000;
    test |= rd << 25;
    test |= op_code << 19;
    test |= rs1 << 14;
    test |= rs2;
    // ee_printf("%i, %i, %i, %x\n", rd, rs1, rs2, test);
    return test;
}

unsigned int generate_opcode_11(unsigned int rd, unsigned int rs1, unsigned int rs2, 
                unsigned int op_code, char i, unsigned short imm)
{
    unsigned int test = 0xc0000000;
    test |= rd << 25;
    test |= op_code << 19;
    test |= rs1 << 14;
    if(i==1) {
        test |= 1 << 13;
        test |= imm;
    } else {
        test |= rs2;
    }
    return test;
}

int DFG_for_output_0(int rs1, int rs2) {

    return(0);
}

unsigned char regs[8] = {0b10000, 0b10001, 0b10010, 0b10011, 0b10100, 0b10101, 0b10110, 0b10111};
char instr_types[5][20] = {"control_transfer", "data_transfer", "floating_point", "integer_alu", "misc"};
unsigned char alu_mnemonic[2][3] = {'add', 'sub'};
unsigned char alu_op_codes[2];
unsigned char complement_instr[2];

unsigned char mem_mnemonic[2][3] = {'ld', 'st'};
unsigned char mem_op_codes[2] = {0x00, 0x04};


int main (int *results_section_ptr, int no_of_inputs) {
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);
    
    int n_instr = no_of_inputs/2;
    int n_tests = 7*n_instr+4;
    uint16_t start_state = 0x10;  /* Any nonzero start state will work. */
    uint16_t lfsr = start_state;
    unsigned int tests[n_tests];
    unsigned int test_instr;
    unsigned char rd = 0b10010;
    unsigned char rs1 = 0b10000;
    unsigned char rs2 = 0b10001;
    unsigned char g0 = 0b00000;
    int i,j=0;

    // save instruction 
    tests[0] = 0x9de3bfa0;
    lfsr = 0xAD;

    for(i=0; i<n_instr; i++) {
        lfsr = prbs(lfsr);
        alu_op_codes[i] =  instr_sel(lfsr & 0x3);
        complement_instr[i] = bring_complement_instr(alu_op_codes[i]);
        
        // load inputs in rs1 and rs2
        tests[j+1] = generate_opcode_11(rs1, g0, 0, mem_op_codes[0], 1, (results_section_ptr+2*i));
        tests[j+2] = generate_opcode_11(rs2, g0, 0, mem_op_codes[0], 1, (results_section_ptr+2*i+1));

        //  run add sub operation
        tests[j+3] = generate_opcode_10(rd, rs1, rs2, alu_op_codes[i], 0, 0);
        tests[j+4] = generate_opcode_10(rs1, rd, rs2, complement_instr[i], 0, 0);
        tests[j+5] = generate_opcode_10(rs2, rd, rs1, complement_instr[i], 0, 0);

        // store inputs in rs1 and rs2
        tests[j+6] = generate_opcode_11(rs1, g0, 0, mem_op_codes[1], 1, (results_section_ptr+no_of_inputs*2+2*i));
        tests[j+7] = generate_opcode_11(rs2, g0, 0, mem_op_codes[1], 1, (results_section_ptr+no_of_inputs*2+2*i+1));

        j = 7*(i+1);
    }
 
    // instruction restore; retl; nop
    tests[n_tests-3] = 0x81e80000;
    tests[n_tests-2] = 0x81c3e008;
    tests[n_tests-1] = 0x01000000;

    __asm__ __volatile__( " set instr_section, %l0\n\t " );
    i=0;
    for(i=0; i<n_tests; i++) {
        __asm__ __volatile__( " mov %0, %%l1 \n\t " : : "r" (tests[i]) );
        __asm__ __volatile__( " st %l1, [%l0] \n\t " );
        __asm__ __volatile__( " add %l0, 0x4, %l0\n\t " );
    }

    ee_printf("---------Operations done-------------------\n");
    return(1);
}
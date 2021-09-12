#include<stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>

int instr_select(uint random_no)
{
    if (random_no == 0){
        return 0x00;
    }
    else{
        return 0x04;
    }
}

int bring_complement_instr(uint instr)
{
    if (instr == 0x00){
        return 0x04;
    }
    if (instr == 0x04){
        return 0x00;
    }
}

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


int main (int *results_section_ptr) {
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);
    int n_tests = 11;
    uint16_t start_state = 0x10;  /* Any nonzero start state will work. */
    uint16_t lfsr = start_state;
    unsigned int tests[n_tests];
    unsigned int test_instr;
    unsigned char rd = 0b10010;
    unsigned char rs1 = 0b10000;
    unsigned char rs2 = 0b10001;
    unsigned char g0 = 0b00000;
    int i;

    for(i=0; i<2; i++) {
        lfsr = prbs(lfsr);
        alu_op_codes[i] =  instr_select(prbs(lfsr) & 0x1);
        complement_instr[i] = bring_complement_instr(alu_op_codes[i]);
    } 
    
    // save instruction 
    tests[0] = 0x9de3bfa0;

    // load inputs in rs1 and rs2
    tests[1] = generate_opcode_11(rs1, g0, 0, mem_op_codes[0], 1, results_section_ptr);
    tests[2] = generate_opcode_11(rs2, g0, 0, mem_op_codes[0], 1, (results_section_ptr+1));
    
    //  run add sub operation
    tests[3] = generate_opcode_10(rd, rs1, rs2, alu_op_codes[0], 0, 0);
    tests[4] = generate_opcode_10(rs1, rd, rs1, complement_instr[0], 0, 0);
    tests[5] = generate_opcode_10(rs2, rd, rs2, complement_instr[0], 0, 0);

    // store inputs in rs1 and rs2
    tests[6] = generate_opcode_11(rs1, g0, 0, mem_op_codes[1], 1, (results_section_ptr+4));
    tests[7] = generate_opcode_11(rs2, g0, 0, mem_op_codes[1], 1, (results_section_ptr+5));

    // instruction restore; retl; nop
    tests[8] = 0x81e80000;
    tests[9] = 0x81c3e008;
    tests[10] = 0x01000000;

    __asm__ __volatile__( " set instr_section, %l0\n\t " );
    i=0;
    for(i=0; i<n_tests; i++) {
        __asm__ __volatile__( " mov %0, %%l1 \n\t " : : "r" (tests[i]) );
        __asm__ __volatile__( " st %l1, [%l0] \n\t " );
        __asm__ __volatile__( " add %l0, 0x4, %l0\n\t " );
    }

    ee_printf("Hey There ................................\n");
    return(1);
}


#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>

unsigned int generate_opcode_10(unsigned int rd, unsigned int rs1, unsigned int rs2, 
                unsigned int op_code, char i, unsigned short imm)
{
    unsigned int test = 0x80000000;
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

unsigned int generate_opcode_00(unsigned int rd, unsigned char op_code, unsigned int imm22)
{
    unsigned int test = 0x00000000;
    test |= rd << 25;
    test |= op_code << 22;
    test |= (imm22 >> 10 );
    return test;
}

unsigned char prbs_3(unsigned char lfsr_3)
{
    unsigned char bit_0 = lfsr_3 & 1;
    unsigned char bit_1 = ((lfsr_3 & 2)>>1); 
    lfsr_3 = (lfsr_3 >> 1) | ( (bit_0 ^ bit_1) << 2);
    return lfsr_3;
}


int add_sub (int results_section_ptr, int number_of_inputs)
{
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    unsigned char alu_mnemonic[2][3] = {'add', 'sub', 'or'};
    unsigned char alu_op_codes[2] = {0x00, 0x04, 0x02};

    unsigned char mem_mnemonic[2][3] = {'ld', 'st'};
    unsigned char mem_op_codes[2] = {0x00, 0x04};

    char g2 =  0b00010; // g2

    generate_input_output(number_of_inputs);
    unsigned int test;
    int n_tests = 7*number_of_inputs+6;
    unsigned int tests[n_tests];

    // save instruction
    tests[0] = 0x9de3bfa0; 
    unsigned int result_section_base = (results_section_ptr >> 10) << 10;
    // ee_printf("results_section_ptr 0x%x and result_section_ptr >> 10 = 0x%x\n", results_section_ptr, result_section_base);
    tests[1] = generate_opcode_00(g2, 0b100, result_section_base); //sethi %hi(0x40000000), %g2
    result_section_base = (results_section_ptr << 22) >> 22;
    tests[2] = generate_opcode_10(g2, g2, 0, alu_op_codes[2], 1, result_section_base); // or %g2, 0x2a8, %g2
    int i;
    char seed_3 = 4;
    char rd, rs1, rs2;
    for(i=0; i<number_of_inputs; i++)
    {
        seed_3 = prbs_3(seed_3);
        rd = seed_3 | 16;
        seed_3 = prbs_3(seed_3);
        rs1 = seed_3 | 16;
        seed_3 = prbs_3(seed_3);
        rs2 = seed_3 | 16;

        // load inputs in rs1 and rs2
        tests[7*i+3] = generate_opcode_11(rs1, g2, 0, mem_op_codes[0], 1, (16*i));
        tests[7*i+4] = generate_opcode_11(rs2, g2, 0, mem_op_codes[0], 1, (16*i + 4));
        // ee_printf("data loaded from 0x%x and 0x%x\n", 16*i, 16*i + 4);

        //  run add sub operation
        tests[7*i+5] = generate_opcode_10(rd, rs1, rs2, alu_op_codes[0], 0, 0);
        tests[7*i+6] = generate_opcode_10(rs1, rd, rs1, alu_op_codes[1], 0, 0);
        tests[7*i+7] = generate_opcode_10(rs2, rd, rs2, alu_op_codes[1], 0, 0);

        // store inputs in rs1 and rs2
        tests[7*i+8] = generate_opcode_11(rs1, g2, 0, mem_op_codes[1], 1, (16*i + 8));
        tests[7*i+9] = generate_opcode_11(rs2, g2, 0, mem_op_codes[1], 1, (16*i + 0xc));    
        // ee_printf("data stored into 0x%x and 0x%x\n", 16*i + 8, 16*i + 0xc);
    }

    // instruction restore; retl; nop
    tests[n_tests-3] = 0x81e80000;
    tests[n_tests-2] = 0x81c3e008;
    tests[n_tests-1] = 0x01000000;

    __asm__ __volatile__( " set instr_section, %l0\n\t " );
    for(i=0; i<n_tests; i++) {
        __asm__ __volatile__( " mov %0, %%l1 \n\t " : : "r" (tests[i]) );
        __asm__ __volatile__( " st %l1, [%l0] \n\t " );
        __asm__ __volatile__( " add %l0, 0x4, %l0\n\t " );
        // ee_printf("stored 0x%x in instructions section\n", tests[i]);
    }

    ee_printf("------------------- Instructions generation done -------------------\n");


    return(1);

}


int store_in_result_section(int *results_section_ptr)
{
    __asm__ __volatile__( " sethi %hi(0x5566), %g2 \n\t " );
    *results_section_ptr = 0x15;
    *(results_section_ptr + 1) = 0x30;
    *(results_section_ptr + 2) = 0x45;
    *(results_section_ptr + 3) = 0x60;
    return(1);
}
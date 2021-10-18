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

unsigned char prbs_5(unsigned char x)
{
    // ee_printf("input to 3 bit prbs = %x ", x);
    x ^= x << 2;
    x &= 0b11111;
    x ^= x >> 1;
    x &= 0b11111;
    if(x==14 || x==15 || x==30 || x==31 || x==2 || x==1 || x==0 ) x=prbs_5(x);
    // ee_printf("output = %x \n", x);
    return x;
}


int main (int *instr_section_ptr, int results_section_ptr, int *register_coverage, int register_seed)
{   
    int number_of_inputs = N_INPUTS;
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    unsigned char alu_op_codes[2];

    switch(INSTR_OP) {
        case 0x00:
            alu_op_codes[0] = 0x00; // add
            alu_op_codes[1] = 0x04; // sub
            break;
        case 0x10:
             alu_op_codes[0] = 0x10; // addcc
             alu_op_codes[1] = 0x04; // sub
            break;
        case 0x04:
            alu_op_codes[0] = 0x04; // sub
            alu_op_codes[1] = 0x00; // add
            break;
        case 0x14:
            alu_op_codes[0] = 0x14; // subcc
            alu_op_codes[1] = 0x00; // add
            break;
        case 0x03:
            alu_op_codes[0] = 0x03; // xor
            alu_op_codes[1] = 0x03; // xor
            break;
        case 0x13:
            alu_op_codes[0] = 0x13; // xorcc
            alu_op_codes[1] = 0x03; // xor
            break;
        case 0x07:
            alu_op_codes[0] = 0x07; // xnor
            alu_op_codes[1] = 0x07; // xnor
            break;
        case 0x17:
            alu_op_codes[0] = 0x17; // xnorcc
            alu_op_codes[1] = 0x07; // xnor
            break;
        case 0x0a:
            alu_op_codes[0] = 0x0a; // umul
            alu_op_codes[1] = 0x0e; // udiv
            break;
        case 0x1a:
            alu_op_codes[0] = 0x1a; // umulcc
            alu_op_codes[1] = 0x0e; // udiv
            break;
        case 0x0b:
            alu_op_codes[0] = 0x0b; // smul
            alu_op_codes[1] = 0x0f; // sdiv
            break;
        case 0x1b:
            alu_op_codes[0] = 0x1b; // smulcc
            alu_op_codes[1] = 0x0f; // sdiv
            break;
    }

    unsigned char mem_mnemonic[3][3] = {'ld', 'st'};
    unsigned char mem_op_codes[3] = {0x00, 0x04};
    char g2 =  0b00010; // g2

    // generate_input_output(results_section_ptr);

    unsigned int test;
    int n_tests = 13*number_of_inputs+6;
    unsigned int tests[n_tests];

    // save instruction
    tests[0] = 0x9de3bfa0; // save %o6, -96, %o6
    // ee_printf("results_section_ptr 0x%x\n", results_section_ptr);
    unsigned int result_section_base = (results_section_ptr >> 10) << 10;
    // ee_printf("result_section_base 0x%x\n", result_section_base);
    tests[1] = generate_opcode_00(g2, 0b100, result_section_base); //sethi %hi(0x40000000), %g2
    result_section_base = (results_section_ptr << 22) >> 22;
    result_section_base &= 0x000003ff; 
    // ee_printf("result_section_base 0x%x\n", result_section_base);
    tests[2] = generate_opcode_10(g2, g2, 0, 0x02, 1, result_section_base); // or %g2, 0x2a8, %g2
    int i;
    char seed_5 = register_seed;
    char rd, rs1, rs2;
    for(i=0; i<number_of_inputs; i++)
    {
        seed_5 = prbs_5(seed_5);
        rs1 = seed_5;
        seed_5 = prbs_5(seed_5);
        rs2 = seed_5;
        seed_5 = prbs_5(seed_5);
        rd = seed_5;
        // ee_printf("mul %d %d %d\n", rs1, rs2, rd);

        // load inputs in rs1 and rs2
        tests[13*i+3] = generate_opcode_11(rs1, g2, 0, mem_op_codes[0], 1, 0);
        tests[13*i+4] = generate_opcode_11(rs2, g2, 0, mem_op_codes[0], 1, 4);

        //  run main instruction operation
        tests[13*i+5] = generate_opcode_10(rd, rs1, rs2, alu_op_codes[0], 0, 0);
        //store result msb which is in Y for some instructions
        tests[13*i+6] = generate_opcode_10(0b00001, 0, 0, 0b101000, 0, 0);
        tests[13*i+7] = generate_opcode_11(0b00001, g2, 0, mem_op_codes[1], 1, 8);
        //store result
        tests[13*i+8] = generate_opcode_11(rd, g2, 0, mem_op_codes[1], 1, 12);
        // store psr
        tests[13*i+9] = generate_opcode_10(0b00001, 0, 0, 0b101001, 0, 0);
        tests[13*i+10] = generate_opcode_11(0b00001, g2, 0, mem_op_codes[1], 1, 16);

        if(INSTR_OP==0x04 || INSTR_OP==0x14 || INSTR_OP==0x0e || INSTR_OP==0x1e) {
            //  run inverse instruction operation without CCR code update
            tests[13*i+11] = generate_opcode_10(rs1, rs1, rd, alu_op_codes[0], 0, 0);
            tests[13*i+12] = generate_opcode_10(rs2, rd, rs2, alu_op_codes[1], 0, 0);
        }
        else {
            //  run inverse instruction operation without CCR code update
            tests[13*i+11] = generate_opcode_10(rs1, rd, rs1, alu_op_codes[1], 0, 0);
            tests[13*i+12] = generate_opcode_10(rs2, rd, rs2, alu_op_codes[1], 0, 0);
        }

        // store inputs in rs1 and rs2
        tests[13*i+13] = generate_opcode_11(rs1, g2, 0, mem_op_codes[1], 1, 20);
        tests[13*i+14] = generate_opcode_11(rs2, g2, 0, mem_op_codes[1], 1, 24); 

        // increment g2 = g2 + 24
        tests[13*i+15] = generate_opcode_10(g2, g2, 0, 0b000000, 1, 32); 



        // store register coverage
        *(register_coverage + (rs1 & 0x1f)*3 ) += 1;
        *(register_coverage + (rs2 & 0x1f)*3 + 1) += 1;
        *(register_coverage + (rd & 0x1f)*3 + 2) += 1;
        // ee_printf("----------------------------------------------------\n");

    }

    // instruction restore; retl; nop
    tests[n_tests-3] = 0x81e80000;
    tests[n_tests-2] = 0x81c3e008;
    tests[n_tests-1] = 0x01000000;

    // __asm__ __volatile__( " set instr_section, %l0\n\t " );
    for(i=0; i<n_tests; i++) {
        *(instr_section_ptr + i) = tests[i];
        // __asm__ __volatile__( " mov %0, %%l1 \n\t " : : "r" (tests[i]) );
        // __asm__ __volatile__( " st %l1, [%l0] \n\t " );
        // __asm__ __volatile__( " add %l0, 0x4, %l0\n\t " );
    }
    ee_printf("last address written 0x%x\n", instr_section_ptr+n_tests-1);
    ee_printf("------------------- Instructions generation done -------------------\n");
    return(1);

}


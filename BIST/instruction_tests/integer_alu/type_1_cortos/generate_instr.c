#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>


int generate_opcode_10(char rd, char rs1, char rs2, char op_code, int i, int imm);
int generate_opcode_11(char rd, char rs1, char rs2, char op_code, char i, int imm);
int generate_opcode_00(char rd, char op_code, unsigned int imm22);



int generate_instr(int *test_program_ptr, int results_section_ptr, int *register_coverage_ptr, int register_seed, char instr_opcode, int *save_register_ptr, int number_of_inputs, int iterations)
{   

    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);
    ee_printf(">>> Tests for Instruction with opcode 0x%x\n", instr_opcode);
    ee_printf(">>> Register seed is %d\n", register_seed);
    char inv_op_code;

    if(instr_opcode == 0x00 || instr_opcode == 0x10) inv_op_code = 0x04; // add, addcc
    else if(instr_opcode == 0x04 || instr_opcode == 0x14) inv_op_code = 0x00; // sub, subcc
    else if(instr_opcode == 0x03 || instr_opcode == 0x13) inv_op_code = 0x03; // xor, xorcc
    else if(instr_opcode == 0x07 || instr_opcode == 0x17) inv_op_code = 0x07; // xnor, xnorcc
    else if(instr_opcode == 0x0a || instr_opcode == 0x1a) inv_op_code = 0x0e; // umul, umulcc
    else if(instr_opcode == 0x0b || instr_opcode == 0x1b) inv_op_code = 0x0f; // smul, smulcc
    else if(instr_opcode == 0x08 || instr_opcode == 0x18) inv_op_code = 0x0c; // addx addxcc
    else if(instr_opcode == 0x0c || instr_opcode == 0x1c) inv_op_code = 0x08; // subx subxcc

    

    char mem_mnemonic[3][3] = {'ld', 'st'};
    char mem_op_codes[3] = {0x00, 0x04};

    char seed_5 = register_seed;
    int *store_instr_at = test_program_ptr;
    *store_instr_at = 0x9de3bfa0; store_instr_at++; // save %o6, -96, %o6

    if(seed_5==14 || seed_5==15 || seed_5==30 || seed_5==31 ) seed_5 = prbs_5(seed_5, 0);
    // store_instr_at = save_registers_14_15_30_31(save_register_ptr, store_instr_at, seed_5, register_coverage_ptr); // save register 14 15 30 31

    // set result section address
    seed_5 = prbs_5(seed_5, 0);
    char result_sec_base_reg = seed_5;
    store_instr_at = load_result_section_base(results_section_ptr, 1, 32, store_instr_at, result_sec_base_reg, register_coverage_ptr);

    int i;
    char rd, rs1, rs2, temp_r;
    int immediate = 0; // immediate value
    int is_imm = 0;

    for(i=0; i<number_of_inputs; i++)
    {
        // ee_printf("i = %d\n", i);
        seed_5 = prbs_5(seed_5, result_sec_base_reg);   rs1 = seed_5;

        is_imm = *(int *)(results_section_ptr + 32*i + 8);
        if(is_imm) {
            immediate = *(int*)(results_section_ptr + 32*i + 4);
            // ee_printf("immediate value is %x\n", immediate);
        } else {
            immediate = 0;
        }

        // ee_printf("i. %d, imm is %d, addr is 0x%x\n",i, is_imm, (int *)(results_section_ptr + 32*i + 8) );
        
        // seed_5 = prbs_5(seed_5, result_sec_base_reg);   rs2 = seed_5;
        // seed_5 = prbs_5(seed_5, result_sec_base_reg);   rd = seed_5;
        // seed_5 = prbs_5(seed_5, result_sec_base_reg);   temp_r = seed_5;
        rd = 0x07;
        // ee_printf("%d. op %d %d %d\n",i+1, rs1, rs2, rd);

        // load inputs in rs1 and rs2
        // *store_instr_at = generate_opcode_11(rs1, result_sec_base_reg, 0, mem_op_codes[0], 1, 0); store_instr_at++;
        // *store_instr_at = generate_opcode_11(rs2, result_sec_base_reg, 0, mem_op_codes[0], 1, 4); store_instr_at++;

        // store initial psr
        // *store_instr_at = generate_opcode_10(temp_r, 0, 0, 0b101001, 0, 0); store_instr_at++;
        // *store_instr_at = generate_opcode_11(temp_r, result_sec_base_reg, 0, mem_op_codes[1], 1, 8); store_instr_at++;

        //  run main instruction operation
        *store_instr_at = generate_opcode_10(rd, 0, 0, instr_opcode, is_imm, immediate); store_instr_at++;
        *store_instr_at = generate_opcode_10(rd, 0, 0, instr_opcode, is_imm, iterations); store_instr_at++;
        
        ee_printf("i. %d, main instr %x \n", i+1, *(store_instr_at-1));
        //store result msb which is in Y for some instructions
        // *store_instr_at = generate_opcode_10(temp_r, 0, 0, 0b101000, 0, 0); store_instr_at++;
        // *store_instr_at = generate_opcode_11(temp_r, result_sec_base_reg, 0, mem_op_codes[1], 1, 12); store_instr_at++;
        //store result
        // *store_instr_at = generate_opcode_11(rd, result_sec_base_reg, 0, mem_op_codes[1], 1, 16); store_instr_at++;
        // store final psr
        // *store_instr_at = generate_opcode_10(temp_r, 0, 0, 0b101001, 0, 0); store_instr_at++;
        // *store_instr_at = generate_opcode_11(temp_r, result_sec_base_reg, 0, mem_op_codes[1], 1, 20); store_instr_at++;

        if(instr_opcode==0x04 || instr_opcode==0x14 || instr_opcode==0x0c || instr_opcode==0x1c) {
            //  run inverse instruction operation without CCR code update
            // *store_instr_at = generate_opcode_10(rs1, rs1, rd, instr_opcode, 0, 0); store_instr_at++;
            // *store_instr_at = generate_opcode_10(rs2, rd, rs2, inv_op_code, is_imm, immediate); store_instr_at++;
        }
        else {
            //  run inverse instruction operation without CCR code update
            // *store_instr_at = generate_opcode_10(rs1, rd, rs1, inv_op_code, 0, 0); store_instr_at++;
            // *store_instr_at = generate_opcode_10(rs2, rd, rs2, inv_op_code, is_imm, immediate); store_instr_at++;
        }

        // store inputs in rs1 and rs2
        // *store_instr_at = generate_opcode_11(rs1, result_sec_base_reg, 0, mem_op_codes[1], 1, 24); store_instr_at++;
        // *store_instr_at = generate_opcode_11(rs2, result_sec_base_reg, 0, mem_op_codes[1], 1, 28); store_instr_at++;

        // increment result_sec_base_reg = result_sec_base_reg + 32
        // *store_instr_at = generate_opcode_10(result_sec_base_reg, result_sec_base_reg, 0, 0b000000, 1, 32); store_instr_at++;


        // store register coverage
        *(register_coverage_ptr + (rs1 & 0x1f)*4 + 0) += 1;
        *(register_coverage_ptr + (rs2 & 0x1f)*4 + 1) += 1;
        *(register_coverage_ptr + (rd & 0x1f)*4 + 2) += 1;
        *(register_coverage_ptr + (temp_r & 0x1f)*4 + 3) += 3;
        // ee_printf("----------------------------------------------------\n");
        // ee_printf("ended at 0x%x\n", store_instr_at-1);
    }


    // load registers back
    seed_5 = prbs_5(seed_5, 0);
    if(seed_5==14 || seed_5==15 || seed_5==30 || seed_5==31 ) seed_5 = prbs_5(seed_5, 0);
    // store_instr_at = load_registers_14_15_30_31(save_register_ptr, store_instr_at, seed_5, register_coverage_ptr);

    // instruction restore; retl; nop
    *store_instr_at = 0x81e80000; store_instr_at++;
    *store_instr_at = 0x81c3e008; store_instr_at++;
    *store_instr_at = 0x01000000; store_instr_at++;


    ee_printf("last address written 0x%x\n", (store_instr_at-1));
    ee_printf("------------------- Instructions generation done -------------------\n");
    return seed_5;

}


int generate_opcode_10(char rd, char rs1, char rs2, char op_code, int is_imm, int imm) {
    int test = 0x80000000;
    test |= rd << 25;
    test |= op_code << 19;
    test |= rs1 << 14;
    if(is_imm==1) {
        // ee_printf("immediate val is %x\n", imm);
        test |= 1 << 13;
        test |= (imm & 0x1fff);
    } else {
        test |= rs2;
    }
    return test;
}


int generate_opcode_11(char rd, char rs1, char rs2, char op_code, char i, int imm)
{
    int test = 0xc0000000;
    test |= rd << 25;
    test |= op_code << 19;
    test |= rs1 << 14;
    if(i==1) {
        test |= 1 << 13;
        test |= (imm & 0x1fff);
    } else {
        test |= rs2;
    }
    return test;
}


int generate_opcode_00(char rd, char op_code, unsigned int imm22)
{
    int test = 0x00000000;
    test |= rd << 25;
    test |= op_code << 22;
    test |= (imm22 >> 10 );
    return test;
}



        // __asm__ __volatile__( " set instr_section, %l0\n\t " );
        // __asm__ __volatile__( " mov %0, %%l1 \n\t " : : "r" (tests[i]) );
        // __asm__ __volatile__( " st %l1, [%l0] \n\t " );
        // __asm__ __volatile__( " add %l0, 0x4, %l0\n\t " );
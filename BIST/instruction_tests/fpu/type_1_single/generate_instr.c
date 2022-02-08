#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>

int generate_opcode_10(int rd,  int rs1,  int rs2,  int op_code, char i,  short imm);
int generate_f_opcode_10(int rd,  int rs1,  int rs2,  int opf_code,  int FPop);
int generate_opcode_11(int rd,  int rs1,  int rs2,  int op_code, char i,  short imm);


int generate_instr(int *test_program_ptr, int results_section_ptr, int *register_coverage_ptr, int register_seed, int instr_opcode, int *save_register_ptr)
{   

    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);
    ee_printf(">>> Tests for Instruction with opcode 0x%x\n", instr_opcode);
    ee_printf(">>> Register seed is %d\n", register_seed);
    char inv_op_code;

    if(instr_opcode == 0x41) inv_op_code = 0x45; // fadds 
    else if(instr_opcode == 0x45) inv_op_code = 0x41; // fsubs 

    char mem_mnemonic[3][4] = {'ld', 'ldf', 'st', 'stf'};
    char mem_op_codes[4] =    {0x00, 0x20,  0x04, 0x24};

    char seed_5 = register_seed;
    int *store_instr_at = test_program_ptr;
    *store_instr_at = 0x9de3bfa0; store_instr_at++; // save %o6, -96, %o6

    if(seed_5==14 || seed_5==15 || seed_5==30 || seed_5==31 ) seed_5 = prbs_5(seed_5, 0);
    store_instr_at = save_registers_14_15_30_31(save_register_ptr, store_instr_at, seed_5, register_coverage_ptr); // save register 14 15 30 31

    // set result section address
    seed_5 = prbs_5(seed_5, 0);
    char result_sec_base_reg = seed_5;
    store_instr_at = load_result_section_base(results_section_ptr, 1, 32, store_instr_at, result_sec_base_reg, register_coverage_ptr);

    int i;
    char rd, rs1, rs2;

    for(i=0; i<N_INPUTS; i++)
    {
        // ee_printf("i = %d\n", i);
        seed_5 = prbs_5(seed_5, 100);   rs1 = seed_5;
        seed_5 = prbs_5(seed_5, 100);   rs2 = seed_5;
        seed_5 = prbs_5(seed_5, 100);   rd = seed_5;
        ee_printf("%d. op f%d f%d f%d\n",i+1, rs1, rs2, rd);

        // load inputs in rs1 and rs2
        *store_instr_at = generate_opcode_11(rs1, result_sec_base_reg, 0, mem_op_codes[1], 1, 0); store_instr_at++;
        *store_instr_at = generate_opcode_11(rs2, result_sec_base_reg, 0, mem_op_codes[1], 1, 4); store_instr_at++;
        
        *store_instr_at = generate_opcode_11(0b00000, result_sec_base_reg, 0, 0b100101, 1, 8); // store initial fsr
        *store_instr_at = generate_f_opcode_10(rd, rs1, rs2, instr_opcode, 0b110100); store_instr_at++; //  run main instruction operation
        *store_instr_at = generate_opcode_11(0b00000, result_sec_base_reg, 0, 0b100101, 1, 12); // store later fsr
        *store_instr_at = generate_opcode_11(rd, result_sec_base_reg, 0, mem_op_codes[3], 1, 16); store_instr_at++; // store result

        if(instr_opcode==0x45) {
            //  run inverse instruction operation without CCR code update
            *store_instr_at = generate_f_opcode_10(rs1, rs1, rd, instr_opcode, 0b110100); store_instr_at++;
            *store_instr_at = generate_f_opcode_10(rs2, rd, rs2, inv_op_code, 0b110100); store_instr_at++;
        }
        else {
            //  run inverse instruction operation without CCR code update
            *store_instr_at = generate_f_opcode_10(rs1, rd, rs1, inv_op_code, 0b110100); store_instr_at++;
            *store_instr_at = generate_f_opcode_10(rs2, rd, rs2, inv_op_code, 0b110100); store_instr_at++;
        }

        // store inputs in rs1 and rs2
        *store_instr_at = generate_opcode_11(rs1, result_sec_base_reg, 0, mem_op_codes[3], 1, 24); store_instr_at++;
        *store_instr_at = generate_opcode_11(rs2, result_sec_base_reg, 0, mem_op_codes[3], 1, 20); store_instr_at++;
        // increment result_sec_base_reg = result_sec_base_reg + 32
        *store_instr_at = generate_opcode_10(result_sec_base_reg, result_sec_base_reg, 0, 0b000000, 1, 32); store_instr_at++;
        // store register coverage
        *(register_coverage_ptr + (rs1 & 0x1f)*3 ) += 1;
        *(register_coverage_ptr + (rs2 & 0x1f)*3 + 1) += 1;
        *(register_coverage_ptr + (rd & 0x1f)*3 + 2) += 1;

    }

    // load registers back
    seed_5 = prbs_5(seed_5, 0);
    if(seed_5==14 || seed_5==15 || seed_5==30 || seed_5==31 ) seed_5 = prbs_5(seed_5, 0);
    store_instr_at = load_registers_14_15_30_31(save_register_ptr, store_instr_at, seed_5, register_coverage_ptr);


    // instruction restore; retl; nop
    *store_instr_at = 0x81e80000; store_instr_at++;
    *store_instr_at = 0x81c3e008; store_instr_at++;
    *store_instr_at = 0x01000000; store_instr_at++;


    ee_printf("last address written 0x%x\n", (store_instr_at-1));
    ee_printf("------------------- Instructions generation done -------------------\n");
    return seed_5;
}


// other functions
 int generate_f_opcode_10( int rd, int rs1, int rs2, int opf_code, int FPop)
{
     int test = 0x80000000;
    test |= rd << 25;
    test |= FPop << 19;
    test |= rs1 << 14;
    test |= opf_code << 5;
    test |= rs2;
    return test;
}

 int generate_opcode_10( int rd,  int rs1,  int rs2,  int op_code, char i,  short imm)
{
     int test = 0x80000000;
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

 int generate_opcode_11( int rd,  int rs1,  int rs2,  int op_code, char i,  short imm)
{
     int test = 0xc0000000;
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



        // __asm__ __volatile__( " set instr_section, %l0\n\t " );
        // __asm__ __volatile__( " mov %0, %%l1 \n\t " : : "r" (tests[i]) );
        // __asm__ __volatile__( " st %l1, [%l0] \n\t " );
        // __asm__ __volatile__( " add %l0, 0x4, %l0\n\t " );
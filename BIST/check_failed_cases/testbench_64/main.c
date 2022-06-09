/*#####################################################
Verification of Floating point unit (FPU) 
Author : Prajwal Kamble
instructions test - fadds, fsubs, fsqrts, fmuls, fdivs
#####################################################*/

#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdint.h>
#include <stdbool.h>

int main(int *test_program_ptr, int *results_section) {
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);
    ee_printf("started------\n");

    int register_seed = 20;

    char instr_opcodes[5] = {0x42,  0x46,  0x2a,    0x4a,  0x4e};
    // char instr_memn[5] = {faddd, fsubd, fsqrtd,  fmuld, fdivd};
    int opcode_ptr = 4;

    int register_coverage[4*32] = {0};
    int save_register[4] = {0};

    flush_mem(save_register, 4);

    ee_printf(">>> Tests for Instruction with opcode 0x%x\n", instr_opcodes[opcode_ptr]);
    ee_printf("Register seed is - %d\n", register_seed);


    int new_register_seed = generate_instr(test_program_ptr, results_section, register_coverage, register_seed, instr_opcodes[opcode_ptr], save_register, N_INPUTS);
    
    test_program();
    ee_printf("test program ran\n");

    checker(results_section);

    register_seed = new_register_seed;

    ee_printf("####################################################\n\n");

    __asm__ __volatile__ (" ta 0 \n\t");
    __asm__ __volatile__ (" nop \n\t");

    return 0;
}


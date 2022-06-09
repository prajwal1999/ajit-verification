/*#####################################################
Verification of Floating point unit (FPU) 
Author : Prajwal Kamble
instructions test - fadds, fsubs, fsqrts, fmuls, fdivs
#####################################################*/

#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdint.h>
#include <stdbool.h>

int main(int *test_program_ptr) {
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);
    ee_printf("started------\n");

    uint64_t input_pair_seed = 0x77BA4D5199953E82;
    int register_seed = 4;

    char instr_opcodes[5] = {0x42,  0x46,  0x2a,    0x4a,  0x4e};
    // char instr_memn[5] = {faddd, fsubd, fsqrtd,  fmuld, fdivd};
    int opcode_ptr = 4;

    int results_section[16*N_INPUTS] = {0};
    int register_coverage[4*32] = {0};
    int save_register[4] = {0};
    int data_coverage[64][64] = {0};
    int instr_count[5] = {0};

    int iteration = 0;
    while(1) {
        flush_mem(results_section, 16*N_INPUTS);
        flush_mem(save_register, 4);

        ee_printf(">>> Tests for Instruction with opcode 0x%x\n", instr_opcodes[opcode_ptr]);
        ee_printf(">>> Input seed is - 0x%x%x, ", input_pair_seed,input_pair_seed);
        ee_printf("Register seed is - %d\n", register_seed);

        uint64_t new_input_pair_seed = 0;
        int float_type_1 = iteration/2;
        int float_type_2 = iteration % 2;
        // int float_type_1 = 0; 
        // int float_type_2 = 2;
        ee_printf(">>> Float Types are ----- %d, %d\n", float_type_1, float_type_2);
        generate_input_output(results_section, input_pair_seed, &new_input_pair_seed, float_type_1, float_type_2);
        ee_printf("new_input_pair_seed is 0x%x %x\n", new_input_pair_seed, new_input_pair_seed);
        int new_register_seed = generate_instr(test_program_ptr, results_section, register_coverage, register_seed, instr_opcodes[opcode_ptr], save_register, N_INPUTS);
        
        test_program();
        ee_printf("test program ran\n");

        switch(instr_opcodes[opcode_ptr]) {
            case 0x42:
                checker_add_sub(results_section, data_coverage, 0x42, N_INPUTS);
                break;
            case 0x46:
                checker_add_sub(results_section, data_coverage, 0x46, N_INPUTS);
                break;
            case 0x2a:
                checker_sqrt(results_section, data_coverage, 0x2a, N_INPUTS);
                break;
            case 0x4a:
                checker_mul(results_section, data_coverage, 0x4a, N_INPUTS);
                break;
            case 0x4e:
                checker_div(results_section, data_coverage, 0x4e, N_INPUTS);
                break;
            default:
                ee_printf("Invalid OPcode\n");
                __asm__ __volatile__ (" ta 0 \n\t");
                __asm__ __volatile__ (" nop \n\t");
                break;
        }


        // bool change_op = print_coverage(register_coverage_ptr, data_coverage_ptr, input_pair_seed, register_seed);
        // if(change_op) {
        //     opcode_ptr = opcode_ptr + 1;
        //     opcode_ptr = opcode_ptr % 12;
        //     flush_mem(register_coverage_ptr, 32*3);
        //     flush_mem(data_coverage_ptr, 1<<(64-2*GRID_DIM));
        // flush_mem(instr_count, 4);
        // }

        input_pair_seed = new_input_pair_seed;
        register_seed = new_register_seed;

        ee_printf("%dth Iteration Ended ####################################################\n\n", iteration);

        iteration++;
        if(iteration >= 4) {
            __asm__ __volatile__ (" ta 0 \n\t");
            __asm__ __volatile__ (" nop \n\t");
        }
    }

    return 0;
}


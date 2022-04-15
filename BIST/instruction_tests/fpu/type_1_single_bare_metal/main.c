/*#####################################################
Verification of Floating point unit (FPU) 
Author : Prajwal Kamble
instructions test - fadds, fsubs, fsqrts, fmuls, fdivs
#####################################################*/

#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdbool.h>

int main(int *test_program_ptr) {
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    int input_pair_seed = 0x9b9d1366;
    int register_seed = 20;

    char instr_opcodes[8] = {0x41,  0x45,  0x29,    0x49,  0x4d,  0x1,   0x5,   0x9};
    // char instr_memn[8] = {fadds, fsubs, fsqrts,  fmuls, fdivs, fmovs, fnegs, fabss};
    int opcode_ptr = 0;

    int results_section[8*N_INPUTS] = {0};
    int register_coverage[4*32] = {0};
    int save_register[4] = {0};
    int data_coverage[64][64] = {0};
    int instr_count[8] = {0};

    while(1) {
        flush_mem(results_section, 8*N_INPUTS);
        flush_mem(save_register, 4);

        ee_printf(">>> Tests for Instruction with opcode 0x%x\n", instr_opcodes[opcode_ptr]);
        ee_printf(">>> Input seed is - 0x%x, Register seed is - %d\n", input_pair_seed, register_seed);

        int new_input_pair_seed = generate_input_output(results_section, input_pair_seed, N_INPUTS); // returned lfsr will be used for next input pair
        
        int new_register_seed = generate_instr(test_program_ptr, results_section, register_coverage, register_seed, instr_opcodes[opcode_ptr], save_register, N_INPUTS);
        
        test_program();
        ee_printf("test program ran\n");

        switch(instr_opcodes[opcode_ptr]) {
            case 0x41:
                checker_add_sub(results_section, data_coverage, instr_opcodes[opcode_ptr], N_INPUTS);
                break;
            case 0x45:
                checker_add_sub(results_section, data_coverage, instr_opcodes[opcode_ptr], N_INPUTS);
                break;
            case 0x49:
                checker_mul(results_section, data_coverage, instr_opcodes[opcode_ptr], N_INPUTS);
                break;
            case 0x4d:
                checker_div(results_section, data_coverage, instr_opcodes[opcode_ptr], N_INPUTS);
                break;
            case 0x29:
                checker_sqrt(results_section, data_coverage, instr_opcodes[opcode_ptr], N_INPUTS);
                break;
            case 0x1:
                checker_fmovs_fnegs_fabss(results_section, data_coverage, instr_opcodes[opcode_ptr], N_INPUTS);
                break;
            case 0x5:
                checker_fmovs_fnegs_fabss(results_section, data_coverage, instr_opcodes[opcode_ptr], N_INPUTS);
                break;
            case 0x9:
                checker_fmovs_fnegs_fabss(results_section, data_coverage, instr_opcodes[opcode_ptr], N_INPUTS);
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

        ee_printf("####################################################\n\n");

        __asm__ __volatile__ (" ta 0 \n\t");
        __asm__ __volatile__ (" nop \n\t");
    }

    return 0;
}


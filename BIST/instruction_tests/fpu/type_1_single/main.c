#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
unsigned int GRID_DIM = 26;
unsigned int N_INPUTS = 100;

int main() {

    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);
    int input_pair_seed = 0x4060601;
    int register_seed = 6;

    char instr_opcodes[4] = {0x41,  0x45,  0x29,    0x49};
    // char instr_memn[4] = {fadds, fsubs, fsqrts,  fmuls};
    int opcode_ptr = 3;

    int* results_section_ptr = (uint32_t*)cortos_bget(sizeof(uint32_t) * 8 * N_INPUTS);
    int* register_coverage_ptr = (uint32_t*)cortos_bget(sizeof(uint32_t) * 128);
    int* data_coverage_ptr = (uint32_t*)cortos_bget(sizeof(uint32_t) * (1<<(64-2*GRID_DIM) ));
    int* save_register_ptr = (uint32_t*)cortos_bget(sizeof(uint32_t) * 4);
    int* instr_count = (uint32_t*)cortos_bget(sizeof(uint32_t) * 4);

    void (*test_program_ptr)(void) = (uint32_t*)cortos_bget(sizeof(uint32_t) * (15 * N_INPUTS + 18) );

    while(1) {
        flush_mem(results_section_ptr, 8*N_INPUTS);
        flush_mem(register_coverage_ptr, 128);
        flush_mem(data_coverage_ptr, 1<<(64-2*GRID_DIM));
        flush_mem(save_register_ptr, 4);
        flush_mem(instr_count, 4);
        flush_mem(test_program_ptr, 15*N_INPUTS + 18);
        ee_printf("flushed result section\n");

        int new_input_pair_seed = generate_input_output(results_section_ptr, input_pair_seed, N_INPUTS);
        
        int new_register_seed = generate_instr(test_program_ptr, results_section_ptr, register_coverage_ptr, register_seed, instr_opcodes[opcode_ptr], save_register_ptr, N_INPUTS);
        
        test_program_ptr();

        if(instr_opcodes[opcode_ptr] == 0x41 || instr_opcodes[opcode_ptr] == 0x41 == 0x45) {
            checker_add_sub(results_section_ptr, data_coverage_ptr, input_pair_seed, register_seed, instr_opcodes[opcode_ptr], N_INPUTS, GRID_DIM);
        }
        else if(instr_opcodes[opcode_ptr] == 0x49) {
            checker_mul(results_section_ptr, data_coverage_ptr, input_pair_seed, register_seed, instr_opcodes[opcode_ptr], N_INPUTS, GRID_DIM);
        }
        
        // __asm__ __volatile__ (" ta 0 \n\t");
        // __asm__ __volatile__ (" nop \n\t");

        // bool change_op = print_coverage(register_coverage_ptr, data_coverage_ptr, input_pair_seed, register_seed);
        // if(change_op) {
        //     opcode_ptr = opcode_ptr + 1;
        //     opcode_ptr = opcode_ptr % 12;
        //     flush_mem(register_coverage_ptr, 32*3);
        //     flush_mem(data_coverage_ptr, 1<<(64-2*GRID_DIM));
        // }

        input_pair_seed = new_input_pair_seed;
        register_seed = new_register_seed;

        ee_printf("####################################################\n\n");

        // __asm__ __volatile__ (" ta 0 \n\t");
        // __asm__ __volatile__ (" nop \n\t");
    }

    return 0;
}


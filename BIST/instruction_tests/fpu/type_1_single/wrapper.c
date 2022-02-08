#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>


int wrapper(int *test_program_ptr, int *results_section_ptr, int *register_coverage_ptr, int *data_coverage_ptr, int *save_register_ptr) {

    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    int input_pair_seed = 0x4060601;
    int register_seed = 6;

    char instr_opcodes[4] = {0x41,  0x45,  0x29,    0x49};
    // char instr_memn[4] = {fadds, fsubs, fsqrts,  fmuls};
    int opcode_ptr = 0;


    flush_mem(register_coverage_ptr, 32*3);
    flush_mem(data_coverage_ptr, 1<<(64-2*GRID_DIM));

    while(1) {
        flush_mem(results_section_ptr, N_INPUTS*8);

        int new_input_pair_seed = generate_input_output(results_section_ptr, input_pair_seed);
        
        int new_register_seed = generate_instr(test_program_ptr, results_section_ptr, register_coverage_ptr, register_seed, instr_opcodes[opcode_ptr], save_register_ptr);
        
        test_program();

        checker(results_section_ptr, data_coverage_ptr, input_pair_seed, register_seed, instr_opcodes[opcode_ptr]);
        
        __asm__ __volatile__ (" ta 0 \n\t");
        __asm__ __volatile__ (" nop \n\t");

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

        __asm__ __volatile__ (" ta 0 \n\t");
        __asm__ __volatile__ (" nop \n\t");
    }

    return 0;
}


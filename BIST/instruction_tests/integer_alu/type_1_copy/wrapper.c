#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>


int wrapper(int *test_program_ptr, int *results_section_ptr, int *register_coverage_ptr, int *data_coverage_ptr, int *save_register_ptr) {

    int input_pair_seed = 1;
    int register_seed = 1;

    char instr_opcodes[12] = {0x00, 0x10, 0x04, 0x14, 0x03, 0x13, 0x07, 0x17, 0x0a, 0x1a, 0x0b, 0x1b};


    while(1) {

        int new_input_pair_seed = generate_input_output(results_section_ptr, input_pair_seed);
        
        int new_register_seed = main(test_program_ptr, results_section_ptr, register_coverage_ptr, register_seed, instr_opcodes[1], save_register_ptr);
        
        test_program();

        // __asm__ __volatile__ (" ta 0 \n\t");
        // __asm__ __volatile__ (" nop \n\t");


        checker(results_section_ptr, data_coverage_ptr, input_pair_seed, register_seed, instr_opcodes[1]);
        
        print_coverage(register_coverage_ptr, data_coverage_ptr, input_pair_seed, register_seed);

        input_pair_seed = new_input_pair_seed;
        register_seed = new_register_seed;
    }

    return 0;
}


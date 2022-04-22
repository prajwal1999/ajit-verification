#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdbool.h>
#include <stdint.h>

int main(int *test_program_ptr) {

    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);
    int64_t input_pair_seed = 0x7271856ECCAAEA3F;
    int register_seed = 7;

    char instr_opcodes[4] = {0xe, 0x1e,  0xf, 0x1f};
    //                       udiv udivcc sdiv sdivcc
    int opcode_ptr = 1;

    int results_section[8*N_INPUTS] = {0};
    int register_coverage[4*32] = {0};
    int save_register[4] = {0};
    int data_coverage[128][64] = {{0}};
    int instr_count[14] = {0};

    while(1) {
        flush_mem(results_section, 8*N_INPUTS);
        flush_mem(save_register, 4);

        ee_printf(">>> Tests for Instruction with opcode 0x%x\n", instr_opcodes[opcode_ptr]);
        ee_printf(">>> Input seed is - 0x%x%x, ", input_pair_seed,input_pair_seed);
        ee_printf("Register seed is - %d\n", register_seed);
        
        int64_t new_input_pair_seed = 0;
        generate_input_output(results_section, input_pair_seed, &new_input_pair_seed);

        // ee_printf("input output generated\n");

        int new_register_seed = generate_instr(test_program_ptr, results_section, register_coverage, register_seed, instr_opcodes[opcode_ptr], save_register);
        // ee_printf("instructions generated\n");
        test_program();
        // ee_printf("test program ran\n");
        checker(results_section, data_coverage, instr_opcodes[opcode_ptr]);
        
        instr_count[opcode_ptr] += N_INPUTS;

        bool change_op = print_coverage(register_coverage, data_coverage, instr_opcodes[opcode_ptr]);
        if(change_op) {
            opcode_ptr = opcode_ptr + 1;
            opcode_ptr = opcode_ptr % 4;
            int i;
            for(i=0; i<64; i++) {
                flush_mem(data_coverage, 64);
            }
        }

        input_pair_seed = new_input_pair_seed;
        // register_seed = new_register_seed;
        register_seed = (register_seed + 1) % 32;
        if(register_seed == 0) register_seed = 1;
        
        ee_printf("####################################################\n\n");

        // __asm__ __volatile__ (" ta 0 \n\t");
        // __asm__ __volatile__ (" nop \n\t");
    }

    return 0;
}


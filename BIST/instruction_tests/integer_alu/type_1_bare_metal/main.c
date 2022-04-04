#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdbool.h>


int main(int *test_program_ptr) {

    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);
    int input_pair_seed = 0x9dd13724;
    int register_seed = 15;

    char instr_opcodes[14] = {0x00, 0x10, 0x08, 0x04, 0x14, 0x0c, 0x03, 0x13, 0x07, 0x17,  0x0a, 0x1a,  0x0b, 0x1b};
    //                        add   addcc addx  sub   subcc subx  xor   xorcc xnor  xnorcc umul  umulcc smul  smulcc
    int opcode_ptr = 2;
    // 0x18, addxcc 
    int results_section[8*N_INPUTS] = {0};
    int register_coverage[4*32] = {0};
    int save_register[4] = {0};
    int data_coverage[64][64] = {0};
    int instr_count[14] = {0};

    while(1) {
        flush_mem(results_section, 8*N_INPUTS);
        flush_mem(save_register, 4);

        ee_printf(">>> Tests for Instruction with opcode 0x%x\n", instr_opcodes[opcode_ptr]);
        ee_printf(">>> Input seed is - 0x%x, Register seed is - %d\n", input_pair_seed, register_seed);
        
        int new_input_pair_seed = generate_input_output(results_section, input_pair_seed);

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
            opcode_ptr = opcode_ptr % 14;
            int i;
            for(i=0; i<64; i++) {
                flush_mem(data_coverage, 64);
            }
        }

        input_pair_seed = new_input_pair_seed;
        register_seed = new_register_seed;

        ee_printf("####################################################\n\n");

        // __asm__ __volatile__ (" ta 0 \n\t");
        // __asm__ __volatile__ (" nop \n\t");
    }

    return 0;
}


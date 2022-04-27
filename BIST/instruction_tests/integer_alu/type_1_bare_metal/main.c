#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdbool.h>


int main(int *test_program_ptr) {

    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);
    int input_pair_seed = 0x7267a12a;
    int register_seed = 11;

    char instr_opcodes[16] = {0x00, 0x10, 0x08, 0x18,  0x04, 0x14, 0x0c, 0x1c,  0x03, 0x13, 0x07, 0x17,  0x0a, 0x1a,  0x0b, 0x1b};
    //                        add   addcc addx  addxcc sub   subcc subx  subxcc xor   xorcc xnor  xnorcc umul  umulcc smul  smulcc
    int opcode_ptr = 2;

    int results_section[8*N_INPUTS] = {0};
    int register_coverage[4*32] = {0};
    int save_register[4] = {0};
    int data_coverage[64*64] = {0};
    int instr_metadata[14][3] = {{0}}; // input pairs count, imm inputs, carry set for addx, subx etc.

    flush_mem(data_coverage, 64*64);
    flush_mem(register_coverage, 4*32);
    flush_mem(data_coverage, 64*64);

    while(1) {
        flush_mem(results_section, 8*N_INPUTS);
        flush_mem(save_register, 4);

        ee_printf(">>> Tests for Instruction with opcode 0x%x\n", instr_opcodes[opcode_ptr]);
        ee_printf(">>> Input seed is - 0x%x, Register seed is - %d\n", input_pair_seed, register_seed);
        
        int new_input_pair_seed = generate_input_output(results_section, input_pair_seed, &instr_metadata[opcode_ptr][1]);

        // ee_printf("input output generated\n");

        int new_register_seed = generate_instr(test_program_ptr, results_section, register_coverage, register_seed, instr_opcodes[opcode_ptr], save_register);
        // ee_printf("instructions generated\n");
        test_program();
        // ee_printf("test program ran\n");


        checker(results_section, data_coverage, instr_opcodes[opcode_ptr], &instr_metadata[opcode_ptr][2]);
        
        instr_metadata[opcode_ptr][0] += N_INPUTS;

        ee_printf(">>> Total input pairs tested for opcode 0x%x are %u\n", instr_opcodes[opcode_ptr], (unsigned int)instr_metadata[opcode_ptr][0]);
        ee_printf(">>> Total imm addressed input pairs are %u\n", (unsigned int)instr_metadata[opcode_ptr][1]);
        ee_printf(">>> Carry was set before execution of main instr - %u\n", (unsigned int)instr_metadata[opcode_ptr][2]);

        bool change_op = print_coverage(register_coverage, data_coverage, instr_opcodes[opcode_ptr]);
        if(change_op) {
            opcode_ptr = opcode_ptr + 1;
            opcode_ptr = opcode_ptr % 16;
            flush_mem(data_coverage, 64*64);
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


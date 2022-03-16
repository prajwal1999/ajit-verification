#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"

#include "cortos.h"
unsigned int GRID_DIM = 26;
unsigned int N_INPUTS = 1;

// int *test_program_ptr, int *results_section_ptr, int *register_coverage_ptr, int *data_coverage_ptr, int *save_register_ptr, int *instr_count
int main() {

    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    // int input_pair_seed = 0x9dd13724;
    int input_pair_seed = 0xfa46740f;

    int register_seed = 15;

    char instr_opcodes[14] = {0x00, 0x10, 0x08, 0x04, 0x14, 0x0c, 0x03, 0x13, 0x07, 0x17,  0x0a, 0x1a,  0x0b, 0x1b};
    //                        add   addcc addx  sub   subcc subx  xor   xorcc xnor  xnorcc umul  umulcc smul  smulcc
    int opcode_ptr = 0;

    int* results_section_ptr = (uint32_t*)cortos_bget(sizeof(uint32_t) * 8 * N_INPUTS);
    int* register_coverage_ptr = (uint32_t*)cortos_bget(sizeof(uint32_t) * 128);
    int* data_coverage_ptr = (uint32_t*)cortos_bget(sizeof(uint32_t) * (1<<(64-2*GRID_DIM) ));
    int* save_register_ptr = (uint32_t*)cortos_bget(sizeof(uint32_t) * 4);
    int* instr_count = (uint32_t*)cortos_bget(sizeof(uint32_t) * 14);

    void (*test_program_ptr)(void) = (uint32_t*)cortos_bget(sizeof(uint32_t) * (15 * N_INPUTS + 18) );


    ee_printf("function stored at %x\n", (int *)test_program_ptr);

    int iterations = 1;
    int i=0;
    while(1) {
        flush_mem(results_section_ptr, 8*N_INPUTS);
        flush_mem(register_coverage_ptr, 128);
        flush_mem(save_register_ptr, 4);
        flush_mem(test_program_ptr, 15*N_INPUTS + 18);
        // flush_mem(data_coverage_ptr, 1<<(64-2*GRID_DIM));
        // flush_mem(instr_count, 14);
        // ee_printf("flushed result section\n");
        
        int new_input_pair_seed = generate_input_output(results_section_ptr, input_pair_seed, N_INPUTS);
        // ee_printf("input output generated\n");


        int new_register_seed = generate_instr(test_program_ptr, results_section_ptr, register_coverage_ptr, register_seed, instr_opcodes[opcode_ptr], save_register_ptr, N_INPUTS, iterations);
        // ee_printf("instructions generated\n");
        (*test_program_ptr)();

        for(i=0; i<15*N_INPUTS+18; i++) {
            ee_printf("opcode i. %d, %x\n", i+1, *((int *)test_program_ptr + i) );
        }

        //--------------------------------------------------------
            // __asm__ __volatile__ ("add %g0, 0x8e9, %g7 \n\t");
            // __asm__ __volatile__ ("add %g0, 0x5ef, %g7 \n\t");
        
        //--------------------------------------------------------

        
        for(i=0; i<N_INPUTS; i++) {
            ee_printf("i. %d, inp1 - 0x%x, inp2 - 0x%x, in_psr - 0x%x, result - 0x%x, fi_psr - 0x%x, out1 - 0x%x, out2 - 0x%x\n", i+1, *(results_section_ptr + 8*i),  *(results_section_ptr + 8*i + 1), *(results_section_ptr + 8*i + 2), *(results_section_ptr + 8*i + 4), *(results_section_ptr + 8*i + 5), *(results_section_ptr + 8*i + 6), *(results_section_ptr + 8*i + 7) );
        }
        ee_printf("test program ran\n");
        // checker(results_section_ptr, data_coverage_ptr, input_pair_seed, register_seed, instr_opcodes[opcode_ptr], N_INPUTS, GRID_DIM);
        
        *(instr_count + opcode_ptr) += N_INPUTS;
        // __asm__ __volatile__ (" ta 0 \n\t");
        // __asm__ __volatile__ (" nop \n\t");

        // bool change_op = print_coverage(register_coverage_ptr, data_coverage_ptr, input_pair_seed, register_seed, instr_opcodes[opcode_ptr]);
        // if(change_op) {
        //     opcode_ptr = opcode_ptr + 1;
        //     opcode_ptr = opcode_ptr % 14;
        //     flush_mem(register_coverage_ptr, 32*3);
        //     flush_mem(data_coverage_ptr, 1<<(64-2*GRID_DIM));
        // }

        input_pair_seed = new_input_pair_seed;
        register_seed = new_register_seed;

        ee_printf("####################################################\n\n");

        if(iterations > 2) {
            __asm__ __volatile__ (" ta 0 \n\t");
            __asm__ __volatile__ (" nop \n\t");
        }
        iterations++;
    }

    return 0;
}


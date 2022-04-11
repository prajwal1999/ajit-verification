/*#####################################################
Verification of Floating point unit (FPU) 
Author : Prajwal Kamble
instructions test - fadds, fsubs, fsqrts, fmuls, fdivs
#####################################################*/

#include "cortos.h"
unsigned int GRID_DIM = 26; // grid size of 2^26 for data coverage
unsigned int N_INPUTS = 100; // number of input pairs to be tested in single iteration 

int main() {

    int input_pair_seed = 0x4060601;
    int register_seed = 20;

    char instr_opcodes[8] = {0x41,  0x45,  0x29,    0x49,  0x4d,  0x1,   0x5,   0x9};
    // char instr_memn[7] = {fadds, fsubs, fsqrts,  fmuls, fdivs, fmovs, fnegs, fabss};
    int opcode_ptr = 0;

    int* results_section_ptr = (uint32_t*)cortos_bget(sizeof(uint32_t) * 8 * N_INPUTS);
    int* register_coverage_ptr = (uint32_t*)cortos_bget(sizeof(uint32_t) * 128);
    int* data_coverage_ptr = (uint32_t*)cortos_bget(sizeof(uint32_t) * (1<<(64-2*GRID_DIM) ));
    int* save_register_ptr = (uint32_t*)cortos_bget(sizeof(uint32_t) * 4);
    int* instr_count = (uint32_t*)cortos_bget(sizeof(uint32_t) * 4);

    void (*test_program_ptr)(void) = (uint32_t*)cortos_bget(sizeof(uint32_t) * (15 * N_INPUTS + 18) );

    while(1) {
        // ee_printf("results_section_ptr starts at 0x%x and ends at 0x%x\n", results_section_ptr, (results_section_ptr+8*N_INPUTS) );
        // ee_printf("register_coverage_ptr starts at 0x%x and ends at 0x%x\n", register_coverage_ptr, (register_coverage_ptr+128) );
        // ee_printf("data_coverage_ptr starts at 0x%x and ends at 0x%x\n", data_coverage_ptr, (data_coverage_ptr+(1<<(64-2*GRID_DIM) )) );
        // ee_printf("save_register_ptr starts at 0x%x and ends at 0x%x\n", save_register_ptr, (save_register_ptr+4) );
        // ee_printf("instr_count starts at 0x%x and ends at 0x%x\n", instr_count, (instr_count+4) );
        // ee_printf("test_program_ptr starts at 0x%x and ends at 0x%x\n", (int *)test_program_ptr, ((int *)test_program_ptr+(15 * N_INPUTS + 18)) );
    
        // flush_mem(results_section_ptr, 8*N_INPUTS);
        // flush_mem(save_register_ptr, 4);
        // flush_mem(test_program_ptr, 15*N_INPUTS + 18);
        // ee_printf("flushed result section\n");

        ee_printf(">>> Tests for Instruction with opcode 0x%x and Register seed is %d\n", instr_opcodes[opcode_ptr], register_seed);

        int new_input_pair_seed = generate_input_output(results_section_ptr, input_pair_seed, N_INPUTS); // returned lfsr will be used for next input pair
        
        int new_register_seed = generate_instr(test_program_ptr, results_section_ptr, register_coverage_ptr, register_seed, instr_opcodes[opcode_ptr], save_register_ptr, N_INPUTS);
        ee_printf("new register seed is - %d\n", new_register_seed);
        ee_printf("instructions generated\n");        
        test_program_ptr();
        ee_printf("test program ran\n");        

        switch(instr_opcodes[opcode_ptr]) {
            case 0x41:
                checker_add_sub(results_section_ptr, data_coverage_ptr, instr_opcodes[opcode_ptr], N_INPUTS, GRID_DIM);
                break;
            // case 0x45:
            //     checker_add_sub(results_section_ptr, data_coverage_ptr, instr_opcodes[opcode_ptr], N_INPUTS, GRID_DIM);
            //     break;
            // case 0x49:
            //     checker_mul(results_section_ptr, data_coverage_ptr, instr_opcodes[opcode_ptr], N_INPUTS, GRID_DIM);
            //     break;
            // case 0x4d:
            //     checker_div(results_section_ptr, data_coverage_ptr, instr_opcodes[opcode_ptr], N_INPUTS, GRID_DIM);
            //     break;
            // case 29:
            //     checker_sqrt(results_section_ptr, data_coverage_ptr, instr_opcodes[opcode_ptr], N_INPUTS, GRID_DIM);
            //     break;
            // case 0x1:
            //     checker_fmovs_fnegs_fabss(results_section_ptr, data_coverage_ptr, instr_opcodes[opcode_ptr], N_INPUTS, GRID_DIM);
            //     break;
            // case 0x5:
            //     checker_fmovs_fnegs_fabss(results_section_ptr, data_coverage_ptr, instr_opcodes[opcode_ptr], N_INPUTS, GRID_DIM);
            //     break;
            // case 0x9:
            //     checker_fmovs_fnegs_fabss(results_section_ptr, data_coverage_ptr, instr_opcodes[opcode_ptr], N_INPUTS, GRID_DIM);
            //     break;
            default:
                checker_add_sub(results_section_ptr, data_coverage_ptr, instr_opcodes[opcode_ptr], N_INPUTS, GRID_DIM);
                break;
        }

        // __asm__ __volatile__ (" ta 0 \n\t");
        // __asm__ __volatile__ (" nop \n\t");

        // bool change_op = print_coverage(register_coverage_ptr, data_coverage_ptr, input_pair_seed, register_seed);
        // if(change_op) {
        //     opcode_ptr = opcode_ptr + 1;
        //     opcode_ptr = opcode_ptr % 12;
        //     flush_mem(register_coverage_ptr, 32*3);
        //     flush_mem(data_coverage_ptr, 1<<(64-2*GRID_DIM));
        // flush_mem(instr_count, 4);
        // }

        input_pair_seed = new_input_pair_seed;
        // ee_printf("new register seed is - %x\n", new_register_seed);
        register_seed = new_register_seed;

        ee_printf("####################################################\n\n");

        // __asm__ __volatile__ (" ta 0 \n\t");
        // __asm__ __volatile__ (" nop \n\t");
    }

    return 0;
}


#include <stdbool.h>

int checker(int *results_section, int *data_coverage, int instr_opcode) {

    int n_correct_test = 0;

    int i;
    for(i=0; i<N_INPUTS; i++) {
        int input_1_msb = results_section[8*i + 0];
        int input_1 = results_section[8*i + 1];
        int input_2 = results_section[8*i + 2];
        int initial_psr = results_section[8*i + 3];
        int actual_result = results_section[8*i + 4];

        int output_1 = results_section[8*i + 6];
        int output_2 = results_section[8*i + 7];

        int final_psr = results_section[8*i + 5];
        int final_ccr = (final_psr & 0x00f00000) >> 20;

        int c_i = (initial_psr >> 20) & 1; // get initial carry
        int c_f = (final_psr >> 20) & 1; // get final carry

        bool test_passed = false;
        bool sub_test_1_correct = false, sub_test_2_correct = false, psr_correct = false;

        if(instr_opcode==0x0e || instr_opcode==0x1e || instr_opcode==0x0f || instr_opcode==0x1f) {
            if(input_1 == output_1 + output_2) sub_test_1_correct = true;
            else {
                ee_printf("output_1 - %x, output_2 - %x\n", output_1, output_2);
            }
            sub_test_2_correct = true;
        }
        else {
            if(input_1 == output_1) sub_test_1_correct = true;
            if(input_2 == output_2) sub_test_2_correct = true;
        }

  
        // verify ccr code
        int operand1_sign = (input_1 >> 31) & 1;
        int operand2_sign = (input_2 >> 31) & 1;
        int e_N = 0, e_Z = 0, e_V = 0, e_C = 0;
        int e_ccr = 0, e_psr = 0;

        if( (instr_opcode >> 4) == 0x1) {
            e_N = (actual_result >> 31) & 1;
            e_Z = (actual_result == 0) ? 1 : 0;
        } 
        else {
            e_N = 0;
            e_Z = 0;
        }

        if(instr_opcode == 0x1e) {
            if((final_ccr & 0b10) == 2) {
                ee_printf("psr is 2\n");
            }
            // ee_printf("final ccr is - %x\n", final_ccr);
            // ee_printf("result is - %x, remainder is - %x\n", actual_result, output_2);
            // if(actual_result == 0xffffffff)
            e_C = 0;
        } 
        else {
            e_V = 0;
            e_C = 0;
        }
        
        if(instr_opcode >> 4) {
            e_ccr =  e_N*8+e_Z*4+e_V*2+e_C;
            e_psr = (initial_psr & 0xff0fffff ) | (e_ccr << 20);
        } else {
            e_psr = initial_psr;
        }

        if(final_psr == e_psr) psr_correct = true;
        if(sub_test_1_correct && sub_test_2_correct && psr_correct) {
            n_correct_test++;
            test_passed = true;
        }

        // if(!test_passed) {
            ee_printf("Test failed - i - %d/%d\n", i+1, N_INPUTS);
            ee_printf("Inputs are 0x%x%x, 0x%x\n",input_1_msb, input_1, input_2);
            ee_printf("sub_test_1_correct - %d, sub_test_2_correct - %d\n", sub_test_1_correct, sub_test_2_correct);
            ee_printf("Initial psr - %x, ", initial_psr);
            if(instr_opcode >> 4) ee_printf("Expected psr - %x, ", e_psr);
            ee_printf("Final psr - %x\n", final_psr);
            ee_printf("Actual result 0x%x\n", actual_result);
            ee_printf("Actual Output 0x%x, 0x%x\n\n",output_1, output_2);
            ee_printf("####################################################\n\n");
            __asm__ __volatile__( " ta 0 \n\t " );
            __asm__ __volatile__ (" nop \n\t");
        // }


        // store data coverage
        int grid_dim = (int)pow(2, GRID_DIM);
        int grids_in_row = 1 << (32-GRID_DIM);
        int grid_row = ( input_1 >> GRID_DIM ) & 0x3f;
        int grid_col = ( input_2 >> GRID_DIM ) & 0x3f;
        *(data_coverage + grid_row*grids_in_row + grid_col) += 1;

        if( n_correct_test == N_INPUTS) {
            ee_printf("all tests passed\n");
        }
    
    }   

    return(0);
}

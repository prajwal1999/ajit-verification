#include "cortos.h"

int checker_sqrt(int *results_section_ptr, int *data_coverage_ptr, int instr_opcode, int number_of_inputs, int GRID_DIM) {

    int i;
    int n_correct_test = 0;

    for(i=0; i<number_of_inputs; i++) {
        ee_printf("Test number - %d\n", i+1);

        int input_2_1 = *(results_section_ptr + 8*i + 1);
        int initial_fsr = *(results_section_ptr + 8*i + 2);
        int final_fsr = *(results_section_ptr + 8*i + 3);
        int result_1 = *(results_section_ptr + 8*i + 4);
        int output_2_1 = *(results_section_ptr + 8*i + 6);

        int float_comb = *(results_section_ptr + 8*i + 7);
        int float_type_2 = float_comb % 5;

        char test_failed = 0;

        ////////////////
        int exp_2 = (input_2_1 & 0x7f800000) >> 23;
        int mantissa_2 = (input_2_1 & 0x007fffff);

        if(float_type_2 == 3 || float_type_2 == 4) { // infinity or NAN
            if(result_1 == input_2_1) n_correct_test++;
            else test_failed = 1;
        }

        else if(float_type_2 == 2) { // zero
            if(result_1 == (input_2_1 & 0x80000000)) n_correct_test++;
            else test_failed = 1;
        }
        // after this float type is either normal or subnormal
        else {
            ee_printf("exp_2 - %d\n", exp_2);
            ee_printf("mantissa_2 - 0x%x\n", mantissa_2);

            // if( (output_2_1 == real_val_2) || is_machine_eps_32(diff_2) ) sub_test_2 = 1;
            if( (output_2_1 == input_2_1) || is_machine_eps_32(abs(output_2_1 - input_2_1)) ) n_correct_test ++;
            else test_failed = 1;
        }

        ee_printf("float_type_2 - %d\n",float_type_2);
        ee_printf("Inputs are 0x%x\n", input_2_1);
        ee_printf("Actual result 0x%x\n", result_1);
        ee_printf("Actual Output 0x%x\n", output_2_1);
        if(test_failed) {
            ee_printf("Test failed\n");
        } else {
            ee_printf("Test passed\n");
        }
        ee_printf("####################################################\n\n");
        // store data coverage
        // int in1 = *(results_section_ptr + 8*i);
        // int in2 = *(results_section_ptr + 8*i + 1);
        // int grid_dim = (int)pow(2, GRID_DIM);
        // int grids_in_row = 1 << (32-GRID_DIM);
        // int grid_row = ( (unsigned int)(in1 + (int)pow(2, 31)) / grid_dim );
        // int grid_col = ( (unsigned int)(in2 + (int)pow(2, 31)) / grid_dim );
        // *(data_coverage_ptr + grid_row*grids_in_row + grid_col) += 1;

    }   

    if( n_correct_test == number_of_inputs) {
        ee_printf("all tests passed\n");    
    } else {
        ee_printf("%d out of %d tests passed\n", n_correct_test, number_of_inputs);    
        __asm__ __volatile__ (" ta 0 \n\t");
        __asm__ __volatile__ (" nop \n\t");
    }

    return(0);
}
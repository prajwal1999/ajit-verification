#include "cortos.h"

int checker_fmovs_fnegs_fabss(int *results_section_ptr, int *data_coverage_ptr, int instr_opcode, int number_of_inputs, int GRID_DIM) {

    int i;
    int n_correct_test = 0;

    for(i=0; i<number_of_inputs; i++) {
        ee_printf("Test number - %d\n", i+1);

        int input_2_1 = *(results_section_ptr + 8*i + 1);
        int initial_fsr = *(results_section_ptr + 8*i + 2);
        int final_fsr = *(results_section_ptr + 8*i + 3);
        int result_1 = *(results_section_ptr + 8*i + 4);

        int float_comb = *(results_section_ptr + 8*i + 7);
        int float_type_2 = float_comb % 5;

        char test_failed = 0;

        int real_val;
        switch(instr_opcode) {
            case 0x1: // fmovs
                real_val = input_2_1;
                break;
            case 0x5: // fnegs
                real_val = (input_2_1 ^ 0x80000000);
                break;
            case 0x9: // fabss
                real_val = (input_2_1 & 0x7fffffff);
                break;
        }


        if(result_1 == real_val) n_correct_test++;
        else test_failed = 1;

        ee_printf("float_type_2 - %d\n",float_type_2);
        ee_printf("Inputs are 0x%x\n", input_2_1);
        ee_printf("Actual result 0x%x\n", result_1);
        if(test_failed) {
            ee_printf("Test failed\n");
        } else {
            ee_printf("Test passed\n");
        }
        ee_printf("####################################################\n\n");

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
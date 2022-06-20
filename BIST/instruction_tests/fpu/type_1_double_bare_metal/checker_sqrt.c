#include <stdint.h>

int checker_sqrt(int *results_section, int *data_coverage, int instr_opcode, int number_of_inputs) {

    int i;
    int n_correct_tests = 0;

    for(i=0; i<number_of_inputs; i++) {
        int input_2_1 = results_section[16*i + 2];
        int input_2_2 = results_section[16*i + 3];
        uint64_t input_2 = (((uint64_t)input_2_1) << 32) + ((uint64_t)input_2_2 & 0xffffffff);

        // ee_printf("Inputs are 0x%x%x, ", input_2_1, input_2_2);
        // ee_printf("input_1 - 0x%x%x\n", input_2, input_2);

        int result_1 = results_section[16*i + 4];
        int result_2 = results_section[16*i + 5];
        uint64_t result = (((uint64_t)result_1) << 32) + ((uint64_t)result_2 & 0xffffffff);

        int output_2_1 = results_section[16*i + 8];
        int output_2_2 = results_section[16*i + 9];
        uint64_t output_2 = ((uint64_t)output_2_1 << 32) + ((uint64_t)output_2_2 & 0xffffffff);

        int float_comb = results_section[16*i + 10];
        int float_type_2 = float_comb % 5;

        char test_failed = 0;

        if( (input_2_1 == 0x80000000) && (input_2_2 == 0) ) {
            if( (result_1 == 0x80000000) && (result_2 == 0) ) n_correct_tests++; else test_failed = 1;
        }
        else if( (input_2_1 >> 31) & 1 == 1) { // number is negative
            if(is_NAN_64(result)) n_correct_tests++;
            else test_failed = 1;
        }
        else if(float_type_2 == 4) { // NAN
            if(is_NAN_64(result)) n_correct_tests++; else test_failed = 1; 
        }
        else if(float_type_2 == 3) { // infinity
            if((result_1 == input_2_1) && (result_2 == input_2_2)) n_correct_tests++;
            else test_failed = 1;
        }

        else if(float_type_2 == 2) { // zero
            if( (result_1 == (input_2_1 & 0x80000000)) && (result_2 == 0) ) n_correct_tests++;
            else test_failed = 1;
        }
        // after this float type is either normal or subnormal
        else {
            uint64_t diff = abs(output_2_1 - input_2_1);
            if( (output_2 == input_2) || is_machine_eps_64_or_zero(diff) ) n_correct_tests ++;
            else test_failed = 1;
        }

        if(test_failed) {
            ee_printf("Test Failed - %d/%d\n", i+1, number_of_inputs);
            ee_printf("float_type_2 - %d\n",float_type_2);
            ee_printf("@Inputs are %x %x,", 0, 0);
            ee_printf("%x %x\n", input_2_1, input_2_2);
            ee_printf("@Actual result %x %x\n", result_1, result_2);
            ee_printf("Actual Output %x %x, ", 0, 0);
            ee_printf("%x %x\n", output_2_1, output_2_2);
            ee_printf("####################################################\n\n");
        } else {
            // ee_printf("Test Passed - %d/%d\n", i+1, number_of_inputs);
            // ee_printf("float_type_2 - %d\n",float_type_2);
            // ee_printf("Inputs are 0x%x\n", input_2_1);
            // ee_printf("Actual result 0x%x\n", result_1);
            // ee_printf("Actual Output 0x%x\n", output_2_1);
            // ee_printf("####################################################\n\n");
        }
        // store data coverage
        // int in1 = *(results_section + 8*i);
        // int in2 = *(results_section + 8*i + 1);
        // int grid_dim = (int)pow(2, GRID_DIM);
        // int grids_in_row = 1 << (32-GRID_DIM);
        // int grid_row = ( (unsigned int)(in1 + (int)pow(2, 31)) / grid_dim );
        // int grid_col = ( (unsigned int)(in2 + (int)pow(2, 31)) / grid_dim );
        // *(data_coverage + grid_row*grids_in_row + grid_col) += 1;

    }   

    if( n_correct_tests == number_of_inputs) {
        ee_printf("all tests passed\n");    
    } else {
        ee_printf("%d out of %d tests passed\n", n_correct_tests, number_of_inputs);    
        // __asm__ __volatile__ (" ta 0 \n\t");
        // __asm__ __volatile__ (" nop \n\t");
    }

    return(0);
}
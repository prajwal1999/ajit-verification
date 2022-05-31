#include <stdint.h>
#include <stdbool.h>

int checker_mul(int *results_section, int *data_coverage, int instr_opcode, int number_of_inputs) {

    int i;
    int n_correct_tests = 0;

    for(i=0; i<number_of_inputs; i++) {

        int input_1_1 = results_section[16*i + 0];
        int input_1_2 = results_section[16*i + 1];
        uint64_t input_1 = (((uint64_t)input_1_1) << 32) | ((uint64_t)input_1_2 & 0xffffffff);

        int input_2_1 = results_section[16*i + 2];
        int input_2_2 = results_section[16*i + 3];
        uint64_t input_2 = (((uint64_t)input_2_1) << 32) + ((uint64_t)input_2_2 & 0xffffffff);

        int result_1 = results_section[16*i + 4];
        int result_2 = results_section[16*i + 5];
        uint64_t result = (((uint64_t)result_1) << 32) + ((uint64_t)result_2 & 0xffffffff);

        int output_1_1 = results_section[16*i + 6];
        int output_1_2 = results_section[16*i + 7];
        uint64_t output_1 = (((uint64_t)output_1_1) << 32) + ((uint64_t)output_1_2 & 0xffffffff);

        int output_2_1 = results_section[16*i + 8];
        int output_2_2 = results_section[16*i + 9];
        uint64_t output_2 = ((uint64_t)output_2_1 << 32) + ((uint64_t)output_2_2 & 0xffffffff);

        int float_comb = results_section[16*i + 10];
        int float_type_1 = float_comb/5;
        int float_type_2 = float_comb % 5;

        uint64_t real_val_1 = 0, real_val_2 = 0;
        bool sub_test_1_correct = false, sub_test_2_correct = false;
        char test_failed = 0;

        int g_exp_1 = (input_1_1 & 0x7ff00000) >> 20;
        int g_exp_2 = (input_2_1 & 0x7ff00000) >> 20;
        int g_exp_res = (result_1 & 0x7ff00000) >> 20;


        if( (float_type_1 == 4) || (float_type_2 == 4) ) { // NAN
            if(is_NAN_64(result)) n_correct_tests++;
            else { test_failed = 1; } 
        }
        else if( (float_type_1 == 3) || (float_type_2 == 3)) { // infinity
            int exp_result_1 = 0x7ff00000 | ((input_1_1^input_2_1) & 0x80000000);
            // ee_printf("i. %d, exp result_1 - %x\n", i+1, exp_result_1);
            if((result_1 == exp_result_1) && (result_2 == 0) ) n_correct_tests++;
            else test_failed = 1;
        }
        else if( (float_type_1 == 2) || (float_type_2 == 2) ) { // zero
            int exp_result_1 = 0x00000000 | ((input_1_1^input_2_1) & 0x80000000);
            if((result_1 == exp_result_1) && (result_2 == 0)) n_correct_tests++;
            else test_failed = 1;
        }
        // done till here
        // after this float type is either normal or subnormal
        else {
            int exp_1 = (input_1_1 & 0x7ff00000) >> 20;
            int exp_2 = (input_2_1 & 0x7ff00000) >> 20;
            int exp_res = (result_1 & 0x7ff00000) >> 20;

            uint64_t mantissa_1 = (((uint64_t)input_1_1 & 0x000fffff) << 32 ) | ((int64_t)input_1_2 & 0xffffffff);
            uint64_t mantissa_2 = ((uint64_t)(input_2_1 & 0x000fffff) << 32 ) | ((int64_t)input_2_2 & 0xffffffff);
            
            if(exp_1 + exp_2 - 1023 < -53) {
                // result is either zero or neg zero
                real_val_1 = (uint64_t)(input_1_1 >> 31) << 63; // retain the sign when making zero
                real_val_2 = (uint64_t)(input_2_1 >> 31) << 63; // retain the sign when making zero
            }
            else if(exp_1 + exp_2 - 1023 < 0) {
                int neg_overflow = abs(exp_1 + exp_2 - 1023);
                uint64_t mask = ((uint64_t)1 << neg_overflow) - (uint64_t)1;
                mask = ~ mask;
                // ee_printf("i. %d, this is the one, mask is - %x\n", i+1, mask);
                output_1 &= mask;
                output_2 &= mask;
                real_val_1 = input_1 & mask;
                real_val_2 = input_2 & mask;
            }
            else {
                if(exp_1 + exp_2 - 1023 >= 2047) {
                        // answer is +inf
                        // ee_printf("i. %d, answer is +-infinity\n", i+1);

                        real_val_1 = (uint64_t)((input_1_1 & 0x80000000) | 0x7ff00000) << 32;
                        real_val_2 = (uint64_t)((input_2_1 & 0x80000000) | 0x7ff00000) << 32;
                        // ee_printf("real 1 is 0x%x, real 2 is 0x%x\n", real_val_1, real_val_2);
                }
                else {
                    real_val_1 = input_1;
                    real_val_2 = input_2;
                }
            }

                int64_t diff_1 = abs(output_1 - real_val_1);
                int64_t diff_2 = abs(output_2 - real_val_2);
                if(is_machine_eps_64_or_zero(diff_1)) sub_test_1_correct = true;
                if(is_machine_eps_64_or_zero(diff_2)) sub_test_2_correct = true;
                if( sub_test_1_correct && sub_test_2_correct ) n_correct_tests++;
                else test_failed = 1; 

        }

        if(test_failed) {
            ee_printf("Test failed - %d/%d\n", i+1, number_of_inputs);
            ee_printf("float_type_1 - %d, float_type_2 - %d\n", float_type_1, float_type_2);
            ee_printf("Inputs are 0x%x %x, ", input_1_1, input_1_2);
            ee_printf("0x%x %x\n", input_2_1, input_2_2);

            ee_printf("exp_1 - %d, exp_2 - %d, exp_res - %d\n", g_exp_1, g_exp_2, g_exp_res);
            ee_printf("Actual result 0x%x %x\n", result);
            ee_printf("real 1 is 0x%x %x, \n", real_val_1, real_val_1);
            ee_printf("real 2 is 0x%x %x\n", real_val_2, real_val_2);
            ee_printf("Actual Output 0x%x %x, ", output_1_1, output_1_2);
            ee_printf("0x%x %x\n", output_2_1, output_2_2);
            ee_printf("####################################################\n\n");
        } else {
            // if(float_type_1 == 1 || float_type_2 == 1) {
            //     ee_printf("Test passed - %d/%d\n", i+1, number_of_inputs);
            //     ee_printf("float_type_1 - %d, float_type_2 - %d\n", float_type_1, float_type_2);
            //     ee_printf("Inputs are 0x%x, 0x%x\n", input_1_1, input_2_1);
            //     ee_printf("exp_1 - %d, exp_2 - %d, exp_res - %d\n", g_exp_1, g_exp_2, g_exp_res);
            //     ee_printf("Actual result 0x%x\n", result_1);
            //     ee_printf("real 1 is 0x%x, real 2 is 0x%x\n", real_val_1, real_val_2);
            //     ee_printf("Actual Output 0x%x, 0x%x\n", output_1_1, output_2_1);
            //     ee_printf("####################################################\n\n");
            // }
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
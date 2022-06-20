
int checker_mul(int *results_section, int *data_coverage, int instr_opcode, int number_of_inputs) {

    int i;
    int n_correct_tests = 0;

    for(i=0; i<number_of_inputs; i++) {

        int input_1_1 = results_section[8*i + 0];
        int input_2_1 = results_section[8*i + 1];
        int initial_fsr = results_section[8*i + 2];
        int final_fsr = results_section[8*i + 3];
        int result_1 = results_section[8*i + 4];
        int output_1_1 = results_section[8*i + 5];
        int output_2_1 = results_section[8*i + 6];

        int float_comb = results_section[8*i + 7];
        int float_type_1 = float_comb/5;
        int float_type_2 = float_comb % 5;

        int real_val_1 = 0, real_val_2 = 0;
        char test_failed = 0;

        ////////////////
        int g_exp_1 = (input_1_1 & 0x7f800000) >> 23;
        int g_exp_2 = (input_2_1 & 0x7f800000) >> 23;
        int g_exp_res = (result_1 & 0x7f800000) >> 23;

        if( (float_type_1 == 4) || (float_type_2 == 4) ) { // NAN
            if(is_NAN(result_1)) n_correct_tests++;
            else { test_failed = 1; } 
        }
        else if( ((float_type_1==3) && (float_type_2==2)) || ((float_type_1==2) && (float_type_2==3)) ) {
            if(is_NAN(result_1)) n_correct_tests++;
            else { test_failed = 1; } 
        }
        else if( (float_type_1 == 3) || (float_type_2 == 3) ) { // infinity
            int exp_result = 0x7f800000 | ((input_1_1^input_2_1) & 0x80000000);
            if(result_1 == exp_result) n_correct_tests++;
            else test_failed = 1;
        } 
        else if( (float_type_1 == 2) || (float_type_2 == 2) ) { // zero
            int exp_result = 0x00000000 | ((input_1_1^input_2_1) & 0x80000000);
            if(result_1 == exp_result) n_correct_tests++;
            else test_failed = 1;
        }
        // after this float type is either normal or subnormal
        else {
            int mantissa_1 = (input_1_1 & 0x007fffff);
            int mantissa_2 = (input_2_1 & 0x007fffff);
            int exp_1 = (input_1_1 & 0x7f800000) >> 23;
            int exp_2 = (input_2_1 & 0x7f800000) >> 23;
            int sub_test_1 = 0, sub_test_2 = 0;
            
            if(exp_1 + exp_2 - 127 < -24) {
                // result is either zero or neg zero
                real_val_1 = (input_1_1 & 0x80000000);
                real_val_2 = (input_2_1 & 0x80000000);
            }
            else if(exp_1 + exp_2 - 127 < 0) {
                int neg_overflow = abs(exp_1 + exp_2 - 127);
                int mask = (1 << neg_overflow) - 1;
                mask = ~ mask;
                // ee_printf("i. %d, this is the one, mask is - %x\n", i+1, mask);
                output_1_1 &= mask;
                output_2_1 &= mask;
                real_val_1 = input_1_1 & mask;
                real_val_2 = input_2_1 & mask;
            }
            else {
                unsigned long long int expec_mantissa = (mantissa_1 * mantissa_2);
                expec_mantissa = expec_mantissa / (1<<27);
                expec_mantissa = expec_mantissa / (1<<20);
                // ee_printf("i. %d, res_mantissa is %d\n",i+1, expec_mantissa);
                if(exp_1 + exp_2 - 127 >= 255) {
                        // answer is +inf
                        // ee_printf("i. %d, answer is +-infinity\n", i+1);
                        real_val_1 = (input_1_1 & 0x80000000) | 0x7f800000;
                        real_val_2 = (input_2_1 & 0x80000000) | 0x7f800000;
                        // ee_printf("real 1 is 0x%x, real 2 is 0x%x\n", real_val_1, real_val_2);
                }
                else {
                    real_val_1 = input_1_1;
                    real_val_2 = input_2_1;
                }
            }

                int diff_1 = abs(output_1_1 - real_val_1);
                int diff_2 = abs(output_2_1 - real_val_2);
                if( (output_1_1 == real_val_1) || is_machine_eps_32_or_zero(diff_1) ) sub_test_1 = 1;
                if( (output_2_1 == real_val_2) || is_machine_eps_32_or_zero(diff_2) ) sub_test_2 = 1;

            if(sub_test_1 == 1 && sub_test_2 == 1) n_correct_tests ++;
            else test_failed = 1;
        }

        if(test_failed) {
            ee_printf("Test failed - %d/%d\n", i+1, number_of_inputs);
            ee_printf("float_type_1 - %d, float_type_2 - %d\n", float_type_1, float_type_2);
            ee_printf("@Inputs are %x, %x\n", input_1_1, input_2_1);
            ee_printf("exp_1 - %d, exp_2 - %d, exp_res - %d\n", g_exp_1, g_exp_2, g_exp_res);
            ee_printf("@Actual result %x\n", result_1);
            ee_printf("real 1 is %x, real 2 is %x\n", real_val_1, real_val_2);
            ee_printf("Actual Output %x, %x\n", output_1_1, output_2_1);
            ee_printf("####################################################\n\n");
        } else {
            // ee_printf("Test passed - %d/%d\n", i+1, number_of_inputs);
            // ee_printf("float_type_1 - %d, float_type_2 - %d\n", float_type_1, float_type_2);
            // ee_printf("Inputs are 0x%x, 0x%x\n", input_1_1, input_2_1);
            // ee_printf("exp_1 - %d, exp_2 - %d, exp_res - %d\n", g_exp_1, g_exp_2, g_exp_res);
            // ee_printf("Actual result 0x%x\n", result_1);
            // ee_printf("real 1 is 0x%x, real 2 is 0x%x\n", real_val_1, real_val_2);
            // ee_printf("Actual Output 0x%x, 0x%x\n", output_1_1, output_2_1);
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

int checker_add_sub(int *results_section, int *data_coverage, int instr_opcode, int number_of_inputs) {

    int i;
    int n_correct_tests = 0;
    int n_failed_tests = 0;

    for(i=0; i<number_of_inputs; i++) {
        int input_1_1 = results_section[8*i];
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

        int g_exp_1 = (input_1_1 & 0x7f800000) >> 23;
        int g_exp_2 = (input_2_1 & 0x7f800000) >> 23;
        int g_exp_res = (result_1 & 0x7f800000) >> 23;


        if(float_type_2 == 4) { // NAN
            if(is_NAN(result_1, (input_2_1 >> 31) )) n_correct_tests++;
            else { test_failed = 1; n_failed_tests++; } 
        }
        else if(float_type_1 == 4) { // NAN
            if(is_NAN(result_1, (input_1_1 >> 31) )) n_correct_tests++;
            else { test_failed = 1; n_failed_tests++; } 
        }
        else if(float_type_1 == 3) { // infinity
            if(result_1 == input_1_1) n_correct_tests++;
            else { test_failed = 1; n_failed_tests++; } 
        } 
        else if(float_type_2 == 3) { // infinity
            if(result_1 == input_2_1) n_correct_tests++;
            else { test_failed = 1; n_failed_tests++; } 
        }
        else if(float_type_1 == 2) { // zero
            if(result_1 == input_2_1) n_correct_tests++;
            else { test_failed = 1; n_failed_tests++; } 
        }
        else if(float_type_2 == 2) { // zero
            if(result_1 == input_1_1) n_correct_tests++;
            else { test_failed = 1; n_failed_tests++; }
        }
        // after this float type is either normal or subnormal
        else {
            int exp_1 = (input_1_1 & 0x7f800000) >> 23;
            int exp_2 = (input_2_1 & 0x7f800000) >> 23;
            int exp_res = (result_1 & 0x7f800000) >> 23;

            if(exp_1 == 0) exp_1 = -126; else exp_1 -= 127;
            if(exp_2 == 0) exp_2 = -126; else exp_2 -= 127;
            if(exp_res == 0) exp_res = -126; else exp_res -= 127;

            int mantissa_1 = (input_1_1 & 0x007fffff);
            int mantissa_2 = (input_2_1 & 0x007fffff);
            int diff_exp_inp = abs(exp_1 - exp_2);
            int diff_exp1_res = exp_res - exp_1;
            int diff_exp2_res = exp_res - exp_2;

            if(exp_res > exp_1) {
                // change mantissa 1
                mantissa_1 |= (float_type_1 << 23);
                mantissa_1 = (mantissa_1 >> (diff_exp1_res-1));
                int rest_sign = mantissa_1 & 1;
                mantissa_1 >>= 1;
                mantissa_1 += rest_sign;
                if(mantissa_1 == (1<<(24-diff_exp1_res))) {
                    diff_exp1_res--;
                    exp_1++;
                }
                mantissa_1 <<= diff_exp1_res;
                real_val_1 = (input_1_1 & 0x80000000);
                if(exp_1 == -126) exp_1 = 0; else exp_1 += 127;
                real_val_1 |= (exp_1 << 23);
                real_val_1 |= (mantissa_1 & 0x7fffff);
                if(diff_exp1_res >= 24) real_val_1 = 0;
            } else real_val_1 = input_1_1;

            if(exp_res > exp_2) {
                // change mantissa 2
                mantissa_2 |= (float_type_2 << 23);
                mantissa_2 = (mantissa_2 >> (diff_exp2_res-1));
                int rest_sign = mantissa_2 & 1;
                mantissa_2 >>= 1;
                mantissa_2 += rest_sign;
                if(mantissa_2 == (1<<(24-diff_exp2_res))) {
                    diff_exp2_res--;
                    exp_2++;
                }
                mantissa_2 <<= diff_exp2_res;
                real_val_2 = (input_2_1 & 0x80000000);
                if(exp_2 == -126) exp_2 = 0; else exp_2 += 127;
                real_val_2 |= (exp_2 << 23);
                real_val_2 |= (mantissa_2 & 0x7fffff); 
                if(diff_exp2_res >= 24) real_val_2 = 0;
            } else real_val_2 = input_2_1;

            if( is_machine_eps_32_or_zero(abs(output_1_1 - real_val_1)) && is_machine_eps_32_or_zero(abs(output_2_1 - real_val_2)) ) {
                n_correct_tests++;
            }
            else { test_failed = 1; n_failed_tests++; } 
        }

        if(test_failed) {
            ee_printf("Test failed - %d/%d\n", i+1, number_of_inputs);
            ee_printf("float_type_1 - %d, float_type_2 - %d\n", float_type_1, float_type_2);
            ee_printf("Inputs are 0x%x, 0x%x\n", input_1_1, input_2_1);
            ee_printf("exp_1 - %d, exp_2 - %d, exp_res - %d\n", g_exp_1, g_exp_2, g_exp_res);
            // ee_printf("diff_exp_inp is %d\n",  abs(g_exp_1 - g_exp_2));
            ee_printf("Actual result 0x%x\n", result_1);
            ee_printf("real 1 is 0x%x, real 2 is 0x%x\n", real_val_1, real_val_2);
            ee_printf("Actual Output 0x%x, 0x%x\n", output_1_1, output_2_1);
            ee_printf("####################################################\n\n");
            // __asm__ __volatile__ (" ta 0 \n\t");
            // __asm__ __volatile__ (" nop \n\t");
        } else {
            // ee_printf("Test passed - %d/%d\n", i+1, number_of_inputs);
            // ee_printf("float_type_1 - %d, float_type_2 - %d\n", float_type_1, float_type_2);
            // ee_printf("Inputs are 0x%x, 0x%x\n", input_1_1, input_2_1);
            // ee_printf("exp_1 - %d, exp_2 - %d\n", g_exp_1, g_exp_2);
            // ee_printf("diff_exp_inp is %d\n",  abs(g_exp_1 - g_exp_2));
            // ee_printf("Actual result 0x%x\n", result_1);
            // ee_printf("real 1 is 0x%x, real 2 is 0x%x\n", real_val_1, real_val_2);
            // ee_printf("Actual Output 0x%x, 0x%x\n", output_1_1, output_2_1);
            // ee_printf("####################################################\n\n");
        }

        

        // ee_printf("####################################################\n\n");

        // store data coverage
        // int in1 = *(results_section + 8*i);
        // int in2 = *(results_section + 8*i + 1);
        // int grid_dim = (int)pow(2, GRID_DIM);
        // int grids_in_row = 1 << (32-GRID_DIM);
        // int grid_row = ( (unsigned int)(in1 + (int)pow(2, 31)) / grid_dim );
        // int grid_col = ( (unsigned int)(in2 + (int)pow(2, 31)) / grid_dim );
        // *(data_coverage + grid_row*grids_in_row + grid_col) += 1;

    }   

    // if( n_correct_test == number_of_inputs) {
    //     ee_printf("all tests passed\n");    
    // } else {
    //     ee_printf("%d out of %d tests passed\n", n_correct_test, number_of_inputs);    
    //     __asm__ __volatile__ (" ta 0 \n\t");
    //     __asm__ __volatile__ (" nop \n\t");
    // }

    ee_printf("%d out of %d tests passed\n", n_correct_tests, number_of_inputs);
    ee_printf("%d out of %d tests failed\n", n_failed_tests, number_of_inputs); 
    __asm__ __volatile__ (" ta 0 \n\t");
    __asm__ __volatile__ (" nop \n\t");

    return(0);
}
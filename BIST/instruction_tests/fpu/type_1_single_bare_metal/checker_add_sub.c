
int checker_add_sub(int *results_section, int *data_coverage, int instr_opcode, int number_of_inputs) {
    int i;
    int n_correct_tests = 0;

    for(i=0; i<number_of_inputs; i++) {
        // ee_printf("%dth itereation \n", i+1);
        // ee_printf("results_section addr - %x\n", &results_section[8*i]);
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


        if(instr_opcode == 0x41) {
            if( (input_1_1==0x7f800000) && (input_2_1==0xff800000) ) {
                if(is_NAN(result_1)) n_correct_tests++; else test_failed = 1; continue;
            }
            else if( (input_1_1==0xff800000) && (input_2_1==0x7f800000) ) {
                if(is_NAN(result_1)) n_correct_tests++; else test_failed = 1; continue;
            }

            if( (input_1_1==0x80000000) && (input_2_1==0x80000000) ) {
                if(result_1 == 0x80000000) n_correct_tests++; else test_failed = 1; continue;
            }
            else if( (float_type_1==2) && (float_type_2==2) ) {
                if(result_1 == 0x0) n_correct_tests++; else test_failed = 1; continue;
            }
        }
        else if(instr_opcode == 0x45) {
            if( (input_1_1==0x7f800000) && (input_2_1==0x7f800000) ) {
                if(is_NAN(result_1)) n_correct_tests++; else test_failed = 1; continue;
            }
            else if( (input_1_1==0xff800000) && (input_2_1==0xff800000) ) {
                if(is_NAN(result_1)) n_correct_tests++; else test_failed = 1; continue;
            }

            if( (input_1_1==0x80000000) && (input_2_1==0x0) ) {
                if(result_1 == 0x80000000) n_correct_tests++; else test_failed = 1; continue;
            }
            else if( (float_type_1==2) && (float_type_2==2) ) {
                if(result_1 == 0x0) n_correct_tests++; else test_failed = 1; continue;
            }
        }
        else {
            ee_printf(">>> Unknown Instruction\n");
            __asm__ __volatile__ (" ta 0 \n\t");
            __asm__ __volatile__ (" nop \n\t");
        }
        
        if( (float_type_2 == 4) || (float_type_1 == 4) ) { // NAN
            if(is_NAN(result_1)) n_correct_tests++; else test_failed = 1; 
        }
        else if(float_type_1 == 3) { // infinity
            if(result_1 == input_1_1) n_correct_tests++; else test_failed = 1; 
        } 
        else if(float_type_2 == 3) { // infinity
            if(instr_opcode == 0x45) {
                int t_input_2_1 = (input_2_1 & 0x7fffffff) | ((~(input_2_1 >> 31)) << 31); // change sign
                if(result_1 == t_input_2_1) n_correct_tests++; else test_failed = 1;
            } else {
                if(result_1 == input_2_1) n_correct_tests++; else test_failed = 1;
            }
        }
        else if(float_type_1 == 2) { // zero
            if(instr_opcode == 0x45) {
                int t_input_2_1 = (input_2_1 & 0x7fffffff) | ((~(input_2_1 >> 31)) << 31); // change sign
                if(result_1 == t_input_2_1) n_correct_tests++; else test_failed = 1;
            } else {
                if(result_1 == input_2_1) n_correct_tests++; else test_failed = 1;
            }
        }
        else if(float_type_2 == 2) { // zero
            if(result_1 == input_1_1) n_correct_tests++; else test_failed = 1;
        }
        // after this float type is either normal or subnormal
        else {
            int exp_1 = (input_1_1 & 0x7f800000) >> 23;
            int exp_2 = (input_2_1 & 0x7f800000) >> 23;
            int exp_res = (result_1 & 0x7f800000) >> 23;

            int mantissa_1 = (input_1_1 & 0x007fffff);
            int mantissa_2 = (input_2_1 & 0x007fffff);
            int diff_exp_inp = abs(exp_1 - exp_2);
            int diff_exp1_res = exp_res - exp_1;
            int diff_exp2_res = exp_res - exp_2;

            mantissa_1 |= (float_type_1 << 23);
            mantissa_2 |= (float_type_2 << 23);
            int rest_1 = mantissa_1 & ((1 << diff_exp1_res)-1);
            int rest_2 = mantissa_2 & ((1 << diff_exp2_res)-1);
            mantissa_1 = mantissa_1 >> diff_exp1_res;
            mantissa_2 = mantissa_2 >> diff_exp2_res;

            if(exp_res > exp_1) {
                // change mantissa 1
                int rest_sign = rest_1 >> (diff_exp1_res-1);
                if(rest_1 > (1<<(diff_exp1_res-1))) mantissa_1 += rest_sign;
                else if(rest_1 == (1<<(diff_exp1_res-1))) {
                    mantissa_1 += rest_sign * ((mantissa_1^mantissa_2) & 1);
                }

                if(mantissa_1 == (1<<(24-diff_exp1_res))) {
                    diff_exp1_res--;
                    exp_1++;
                }
                mantissa_1 <<= diff_exp1_res;
                real_val_1 = (input_1_1 & 0x80000000);
                real_val_1 |= (exp_1 << 23);
                real_val_1 |= (mantissa_1 & 0x7fffff);
                if(diff_exp1_res >= 24) real_val_1 = 0;
            } else real_val_1 = input_1_1;

            if(exp_res > exp_2) {
                // change mantissa 2
                int rest_sign = rest_2 >> (diff_exp2_res-1);
                if(rest_2 > (1<<(diff_exp2_res-1))) mantissa_2 += rest_sign;
                else if(rest_2 == (1<<(diff_exp2_res-1))) {
                    mantissa_2 += rest_sign * ((mantissa_1^mantissa_2) & 1);
                }
                if(mantissa_2 == (1<<(24-diff_exp2_res))) {
                    diff_exp2_res--;
                    exp_2++;
                }
                mantissa_2 <<= diff_exp2_res;
                real_val_2 = (input_2_1 & 0x80000000);
                real_val_2 |= (exp_2 << 23);
                real_val_2 |= (mantissa_2 & 0x7fffff); 
                if(diff_exp2_res >= 24) real_val_2 = 0;
            } else real_val_2 = input_2_1;

            int test_1_correct = is_machine_eps_32_or_zero(abs(output_1_1 - real_val_1));
            int test_2_correct = is_machine_eps_32_or_zero(abs(output_2_1 - real_val_2));
            if( test_1_correct && test_2_correct ) n_correct_tests++; else test_failed = 1;
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
            // __asm__ __volatile__ (" ta 0 \n\t");
            // __asm__ __volatile__ (" nop \n\t");
        } else {
            // ee_printf("Test passed - %d/%d\n", i+1, number_of_inputs);
            // ee_printf("float_type_1 - %d, float_type_2 - %d\n", float_type_1, float_type_2);
            // ee_printf("@Inputs are %x, %x\n", input_1_1, input_2_1);
            // ee_printf("exp_1 - %d, exp_2 - %d, exp_res - %d\n", g_exp_1, g_exp_2, g_exp_res);
            // ee_printf("@Actual result %x\n", result_1);
            // ee_printf("real 1 is %x, real 2 is %x\n", real_val_1, real_val_2);
            // ee_printf("Actual Output %x, %x\n", output_1_1, output_2_1);
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

    if( n_correct_tests == number_of_inputs) {
        ee_printf("all tests passed\n");    
    } else {
        ee_printf("%d out of %d tests passed\n", n_correct_tests, number_of_inputs);    
        // __asm__ __volatile__ (" ta 0 \n\t");
        // __asm__ __volatile__ (" nop \n\t");
    }

    // ee_printf("%d out of %d tests passed\n", n_correct_tests, number_of_inputs); 
    // __asm__ __volatile__ (" ta 0 \n\t");
    // __asm__ __volatile__ (" nop \n\t");

    return(0);
}
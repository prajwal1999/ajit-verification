#include <stdint.h>
#include <stdbool.h>


int checker_add_sub(int *results_section, int *data_coverage, int instr_opcode, int number_of_inputs) {

    int i;
    int n_correct_tests = 0;

    for(i=0; i<number_of_inputs; i++) {
        int input_1_1 = results_section[16*i + 0];
        int input_1_2 = results_section[16*i + 1];
        uint64_t input_1 = (((uint64_t)input_1_1) << 32) + ((uint64_t)input_1_2 & 0xffffffff);
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


        if(float_type_2 == 4) { // NAN
            if(is_NAN_64(result)) n_correct_tests++; else test_failed = 1; 
        }
        else if(float_type_1 == 4) { // NAN
            if(is_NAN_64(result)) n_correct_tests++; else test_failed = 1; 
        }
        else if(float_type_1 == 3) { // infinity
            if(result_1 == input_1_1 && result_2 == input_1_2) n_correct_tests++; else test_failed = 1; 
        } 
        else if(float_type_2 == 3) { // infinity
            if(instr_opcode == 0x46) {
                int t_input_2_1 = (input_2_1 & 0x7fffffff) | ((~(input_2_1 >> 31)) << 31); // change sign
                if((result_1 == t_input_2_1) && (result_2 == input_2_2)) n_correct_tests++; else test_failed = 1;
            } else {
                if(result_1 == input_2_1 && result_2 == input_2_2) n_correct_tests++; else test_failed = 1; 
            }
        }
        else if(float_type_1 == 2) { // zero
            if(instr_opcode == 0x46) {
                int t_input_2_1 = (input_2_1 & 0x7fffffff) | ((~(input_2_1 >> 31)) << 31); // change sign
                if( (result_1 == t_input_2_1) && (result_2 == input_2_2)) n_correct_tests++; else test_failed = 1;
            } else {
                if(result_1 == input_2_1 && result_2 == input_2_2) n_correct_tests++; else test_failed = 1; 
            }
        }
        else if(float_type_2 == 2) { // zero
            if(result_1 == input_1_1 && result_2 == input_1_2) n_correct_tests++; else test_failed = 1;
        }
        // after this float type is either normal or subnormal
        else {
            int exp_1 = (input_1_1 & 0x7ff00000) >> 20;
            int exp_2 = (input_2_1 & 0x7ff00000) >> 20;
            int exp_res = (result_1 & 0x7ff00000) >> 20;

            uint64_t mantissa_1 = (((uint64_t)input_1_1 & 0x000fffff) << 32 ) | ((int64_t)input_1_2 & 0xffffffff);
            uint64_t mantissa_2 = ((uint64_t)(input_2_1 & 0x000fffff) << 32 ) | ((int64_t)input_2_2 & 0xffffffff);
 
            // ee_printf("mantissa_1 is - 0x%x %x\n", mantissa_1, mantissa_1);
            // ee_printf("mantissa_2 is - 0x%x %x\n", mantissa_2, mantissa_2);
            // ee_printf("---------------\n");
            int diff_exp_inp = abs(exp_1 - exp_2);
            int diff_exp1_res = exp_res - exp_1;
            int diff_exp2_res = exp_res - exp_2;

            mantissa_1 |= ((uint64_t)float_type_1 << 52);
            mantissa_2 |= ((uint64_t)float_type_2 << 52);
            // ee_printf("mantissa_1 is - 0x%x %x\n", mantissa_1, mantissa_1);
            // ee_printf("mantissa_2 is - 0x%x %x\n", mantissa_2, mantissa_2);
            uint64_t rest_1 = mantissa_1 & (((uint64_t)1 << diff_exp1_res)-1);
            uint64_t rest_2 = mantissa_2 & (((uint64_t)1 << diff_exp2_res)-1);


            mantissa_1 = mantissa_1 >> diff_exp1_res;
            mantissa_2 = mantissa_2 >> diff_exp2_res;



            if(exp_res > exp_1) {
                // change mantissa 1
                int rest_sign = rest_1 >> (diff_exp1_res-1);
                if(rest_1 > ((uint64_t)1<<(diff_exp1_res-1))) mantissa_1 += rest_sign;
                else if(rest_1 == ((uint64_t)1<<(diff_exp1_res-1))) {
                    mantissa_1 += rest_sign * ((mantissa_1^mantissa_2) & 1);
                }
                if(mantissa_1 == ((uint64_t)1<<(53-diff_exp1_res))) {
                    diff_exp1_res--;
                    exp_1++;
                }
                mantissa_1 <<= diff_exp1_res;
                real_val_1 = ((uint64_t)(input_1_1 & 0x80000000)) << 32;
                real_val_1 |= ((uint64_t)exp_1 << 52);
                real_val_1 |= (mantissa_1 & 0xfffffffffffff);
                if(diff_exp1_res >= 53) real_val_1 = 0;
            } else real_val_1 = input_1;

            if(exp_res > exp_2) {
                // change mantissa 2
                int rest_sign = rest_2 >> (diff_exp2_res-1);
                if(rest_2 > ((uint64_t)1<<(diff_exp2_res-1))) mantissa_2 += rest_sign;
                else if(rest_2 == ((uint64_t)1<<(diff_exp2_res-1))) {
                    mantissa_2 += rest_sign * ((mantissa_1^mantissa_2) & 1);
                }
                if(mantissa_2 == ((uint64_t)1<<(53-diff_exp2_res))) {
                    diff_exp2_res--;
                    exp_2++;
                }
                mantissa_2 <<= diff_exp2_res;
                real_val_2 = ((uint64_t)(input_2_1 & 0x80000000)) << 32;
                real_val_2 |= ((uint64_t)exp_2 << 52);
                // ee_printf("i. %d, interm real_val_2 is %x %x\n",i+1, real_val_2, real_val_2);
                real_val_2 |= (mantissa_2 & 0xfffffffffffff);
                // ee_printf("mantissa_2 is %x %x\n", mantissa_2); 
                if(diff_exp2_res >= 53) real_val_2 = 0;
            } else real_val_2 = input_2;

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
            ee_printf("sub_test_1_correct - %d, sub_test_2_correct - %d\n", sub_test_1_correct, sub_test_2_correct);
            ee_printf("@Inputs are %x %x,", input_1_1, input_1_2);
            ee_printf("%x %x\n", input_2_1, input_2_2);

            ee_printf("exp_1 - %d, exp_2 - %d, exp_res - %d\n", g_exp_1, g_exp_2, g_exp_res);
            ee_printf("@Actual result %x %x\n", result_1, result_2);
            ee_printf("real 1 is %x %x, \n", real_val_1, real_val_1);
            ee_printf("real 2 is %x %x\n", real_val_2, real_val_2);
            ee_printf("Actual Output %x %x, ", output_1_1, output_1_2);
            ee_printf("%x %x\n", output_2_1, output_2_2);
            ee_printf("####################################################\n\n");
            // __asm__ __volatile__ (" ta 0 \n\t");
            // __asm__ __volatile__ (" nop \n\t");
        } else {
            // if(input_1_1 == result_1 || input_2_1 == result_1) continue;
            // else {
            // ee_printf("Test passed - %d/%d\n", i+1, number_of_inputs);
            // ee_printf("float_type_1 - %d, float_type_2 - %d\n", float_type_1, float_type_2);
            // ee_printf("Inputs are 0x%x %x, ", input_1_1, input_1_2);
            // ee_printf("0x%x %x\n", input_2_1, input_2_2);

            // ee_printf("exp_1 - %d, exp_2 - %d, exp_res - %d\n", g_exp_1, g_exp_2, g_exp_res);
            // ee_printf("Actual result 0x%x %x\n", result_1, result_2);
            // ee_printf("real 1 is 0x%x %x, \n", real_val_1, real_val_1);
            // ee_printf("real 2 is 0x%x %x\n", real_val_2, real_val_2);
            // ee_printf("Actual Output 0x%x %x, ", output_1_1, output_1_2);
            // ee_printf("0x%x %x\n", output_2_1, output_2_2);
            // ee_printf("####################################################\n\n");
            // }
        }

        

        // ee_printf("####################################################\n\n");

        // store data coverage
        // int in1 = *(results_section + 16*i);
        // int in2 = *(results_section + 16*i + 1);
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
    return(0);
}
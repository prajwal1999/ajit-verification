#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <math.h>

int checker(int *results_section_ptr, int *data_coverage_ptr, int input_seed, int register_seed, int instr_opcode, int number_of_inputs, int GRID_DIM) {

    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    int i;
    int n_correct_test = 0;

    for(i=0; i<number_of_inputs; i++) {

        int input_1_1 = *(results_section_ptr + 8*i);
        int input_2_1 = *(results_section_ptr + 8*i + 1);
        int initial_fsr = *(results_section_ptr + 8*i + 2);
        int final_fsr = *(results_section_ptr + 8*i + 3);
        int result_1 = *(results_section_ptr + 8*i + 4);
        int output_1_1 = *(results_section_ptr + 8*i + 5);
        int output_2_1 = *(results_section_ptr + 8*i + 6);

        int float_comb = *(results_section_ptr + 8*i + 7);
        int float_type_1 = float_comb/5;
        int float_type_2 = float_comb % 5;

        char test_failed = 0;
        int diff_1=0, diff_2=0;

        if(float_type_1 == 3 || float_type_1 == 4) { // infinity or NAN
            if(result_1 == input_1_1) n_correct_test++;
            else test_failed = 1;
        } 
        else if(float_type_2 == 3 || float_type_2 == 4) { // infinity or NAN
            if(result_1 == input_2_1) n_correct_test++;
            else test_failed = 1;
        }

        else if(float_type_1 == 1) { // zero
            if(result_1 == input_2_1) n_correct_test++;
            else test_failed = 1;
        }

        else if(float_type_2 == 1) { // zero
            if(result_1 == input_1_1) n_correct_test++;
            else test_failed = 1;
        }
        // after this float type is either normal or subnormal
        // check when both inputs are normal 
        else if(float_type_1 == 0 && float_type_2 == 0) {
            ee_printf("Test number - %d\n", i+1);
            ee_printf("both inputs are normal\n");
            // int sign_1 = (input_1_1 & 0x80000000) >> 31;
            // int sign_2 = (input_2_1 & 0x80000000) >> 31; 
            int exp_1 = (input_1_1 & 0x7f800000) >> 23;
            int exp_2 = (input_2_1 & 0x7f800000) >> 23;
            int mantissa_1 = (input_1_1 & 0x007fffff);
            int mantissa_2 = (input_2_1 & 0x007fffff);
            int diff_exp_inp = abs(exp_1 - exp_2);
            int real_val_1 = 0, real_val_2 = 0;

            ee_printf("exp_1 - %d, exp_2 - %d\n", exp_1, exp_2);
            ee_printf("mantissa_1 - 0x%x, mantissa_2 - 0x%x\n", mantissa_1, mantissa_2);
            ee_printf("diff_exp_inp is %d\n", diff_exp_inp);

            if(exp_1 > exp_2) {
                // change mantissa 2
                real_val_1 = input_1_1;
                mantissa_2 |= 0x800000;
                mantissa_2 = mantissa_2 / (int)pow(2, diff_exp_inp);
                mantissa_2 = mantissa_2 * (int)pow(2, diff_exp_inp);
                mantissa_2 &= 0x007fffff;
                if(mantissa_2 == 0) exp_2=0;
                real_val_2 = (input_2_1 & 0x80000000);
                real_val_2 |= (exp_2 << 23);
                real_val_2 |= mantissa_2;
            }
            else if(exp_1 < exp_2) {
                // change mantissa 1
                real_val_2 = input_2_1;
                mantissa_1 |= 0x800000;
                mantissa_1 = mantissa_1 / (int)pow(2, diff_exp_inp);
                mantissa_1 = mantissa_1 * (int)pow(2, diff_exp_inp);
                mantissa_1 &= 0x007fffff;
                if(mantissa_2 == 0) exp_2=0;
                real_val_1 = (input_1_1 & 0x80000000);
                real_val_1 |= (exp_1 << 23);
                real_val_1 |= mantissa_1;
            } else {
                real_val_1 = input_1_1;
                real_val_2 = input_2_1;
            }

            // if(test_failed == 1) ee_printf("Test failed - %d/%d\n", i+1, number_of_inputs);
            // else ee_printf("Test passed - %d/%d\n", i+1, number_of_inputs);
            ee_printf("float_type_1 - %d, float_type_2 - %d\n", float_type_1, float_type_2);
            ee_printf("Inputs are 0x%x, 0x%x\n", input_1_1, input_2_1);
            ee_printf("Actual result 0x%x\n", result_1);
            ee_printf("real 1 is 0x%x, real 2 is 0x%x\n", real_val_1, real_val_2);
            ee_printf("Actual Output 0x%x, 0x%x\n", output_1_1, output_2_1);
            // ee_printf("diff_1 - %x, diff_2 - %x\n", diff_1, diff_2);
            if(output_1_1 == real_val_1 && output_2_1 == real_val_2) {
                n_correct_test ++;
                ee_printf("Test passed\n");
            }
            ee_printf("####################################################\n\n");
            // if(diff_exp_inp >= 23) { // input_1 exp is greater
            //     if( (result_1 == input_1_1) && (result_1 == output_1_1) && (output_2_1 == 0) ) n_correct_test++;
            //     else test_failed = 1; 
            // }
            // else if(diff_exp_inp <= -23) { // input_2 exp is greater
            //     if( (result_1 == input_2_1) && (result_1 == output_2_1) && (output_1_1 == 0) ) n_correct_test++;
            //     else test_failed = 1; 
            // }
            // else {
            //     // check if both output has correct sign or not
            //     if( (input_1_1 & 0x80000000) != (output_1_1 & 0x80000000) ) test_failed = 1;
            //     else if( (input_2_1 & 0x80000000) != (output_2_1 & 0x80000000) ) test_failed = 1;
            //     // now check if exponent match
            //     else if( (input_1_1 & 0x7f800000) != (output_1_1 & 0x7f800000) ) test_failed = 1;
            //     else if( (input_2_1 & 0x7f800000) != (output_2_1 & 0x7f800000) ) test_failed = 1;
            //     else {
            //         // how check how much absolute difference is in the mantissa
            //         diff_1 = abs((input_1_1 & 0x007fffff) - (output_1_1 & 0x007fffff));
            //         diff_2 = abs((input_2_1 & 0x007fffff) - (output_2_1 & 0x007fffff));
            //         n_correct_test++;
            //     }
            // }
        }
        // check when both inputs are subnormal
        else if(float_type_1 == 2 && float_type_2 == 2) {
            // check if both output has correct sign or not
            if( (input_1_1 & 0x80000000) != (output_1_1 & 0x80000000) ) test_failed = 1;
            else if( (input_2_1 & 0x80000000) != (output_2_1 & 0x80000000) ) test_failed = 1;
            // now check if exponent match
            else if( (input_1_1 & 0x7f800000) != (output_1_1 & 0x7f800000) ) test_failed = 1;
            else if( (input_2_1 & 0x7f800000) != (output_2_1 & 0x7f800000) ) test_failed = 1;
            else {
                // how check how much absolute difference is in the mantissa
                diff_1 = abs((input_1_1 & 0x007fffff) - (output_1_1 & 0x007fffff));
                diff_2 = abs((input_2_1 & 0x007fffff) - (output_2_1 & 0x007fffff));
                n_correct_test++;
            }
        }
        // now one input is normal and other is subnormal
        else {
            ee_printf("one input is normal and other is subnormal\n");
            test_failed = 1;
        }

        // if(test_failed == 1) {
            // if(test_failed == 1) ee_printf("Test failed - %d/%d\n", i+1, number_of_inputs);
            // else ee_printf("Test passed - %d/%d\n", i+1, number_of_inputs);
            // ee_printf("float_type_1 - %d, float_type_2 - %d\n", float_type_1, float_type_2);
            // ee_printf("Inputs are 0x%x, 0x%x\n", input_1_1, input_2_1);
            // ee_printf("Actual result 0x%x\n", result_1);
            // ee_printf("Actual Output 0x%x, 0x%x\n", output_1_1, output_2_1);
            // ee_printf("diff_1 - %x, diff_2 - %x\n", diff_1, diff_2);
            // ee_printf("####################################################\n\n");
        // }


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
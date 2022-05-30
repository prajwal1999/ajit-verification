
int checker_sqrt(int *results_section, int *data_coverage, int instr_opcode, int number_of_inputs) {

    int i;
    int n_correct_tests = 0;

    for(i=0; i<number_of_inputs; i++) {
        int input_2_1 = results_section[8*i + 1];
        int initial_fsr = results_section[8*i + 2];
        int final_fsr = results_section[8*i + 3];
        int result_1 = results_section[8*i + 4];
        int output_2_1 = results_section[8*i + 6];

        int float_comb = results_section[8*i + 7];
        int float_type_2 = float_comb % 5;

        char test_failed = 0;

        int exp_2 = (input_2_1 & 0x7f800000) >> 23;
        int mantissa_2 = (input_2_1 & 0x007fffff);


        if( (input_2_1 >> 31) & 1 == 1) { // number is negative
            if(result_1 == 0x0) n_correct_tests++;
            else test_failed = 1;
        }

        else if(float_type_2 == 4) { // NAN
            // if(is_NAN(result_1)) n_correct_tests++;
            if(result_1 == 0x0) n_correct_tests++;
            else test_failed = 1;
        }

        else if(float_type_2 == 3) { // infinity
            if(result_1 == input_2_1) n_correct_tests++;
            else test_failed = 1;
        }

        else if(float_type_2 == 2) { // zero
            if(result_1 == (input_2_1 & 0x80000000)) n_correct_tests++;
            else test_failed = 1;
        }
        // after this float type is either normal or subnormal
        else {
            if( (output_2_1 == input_2_1) || is_machine_eps_32_or_zero(abs(output_2_1 - input_2_1)) ) n_correct_tests ++;
            else test_failed = 1;
        }

        if(test_failed) {
            ee_printf("Test Failed - %d/%d\n", i+1, number_of_inputs);
            ee_printf("float_type_2 - %d\n",float_type_2);
            ee_printf("Inputs are 0x%x\n", input_2_1);
            ee_printf("Actual result 0x%x\n", result_1);
            ee_printf("Actual Output 0x%x\n", output_2_1);
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
#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <math.h>

int checker(int *results_section_ptr, int *register_coverage, int *data_coverage) {
    int number_of_inputs = N_INPUTS;
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    ee_printf("------------------------Starting tests-------------------\n");

    int i;
    int instr;

    for(i=0; i<number_of_inputs; i++) {
        int expected_out_1 = *(results_section_ptr + 6*i + 1);
        int expected_out_2 = *(results_section_ptr + 6*i);

        int actual_out_1 = *(results_section_ptr + 6*i + 2);
        int actual_out_2 = *(results_section_ptr + 6*i + 3);

        char sub_test_1_correct = 0, sub_test_2_correct = 0;
        if(expected_out_1 == actual_out_1) {
            sub_test_1_correct = 1;
        } else {
            ee_printf("Test failed - %d/%d\n", i+1, number_of_inputs);
            ee_printf("Expected Output 0x%x, 0x%x\n",expected_out_1, expected_out_2);
            ee_printf("Actual Output 0x%x, 0x%x\n",actual_out_1, actual_out_2);
            ee_printf("----------------------------------------------------\n");
            __asm__ __volatile__( " ta 0 \n\t " );
        }

        if(expected_out_2 == actual_out_2) {
            sub_test_2_correct = 1;
        } else {
            ee_printf("Test failed - %d/%d\n", i+1, number_of_inputs);
            ee_printf("Expected Output 0x%x, 0x%x\n",expected_out_1, expected_out_2);
            ee_printf("Actual Output 0x%x, 0x%x\n",actual_out_1, actual_out_2);
            ee_printf("----------------------------------------------------\n");
            __asm__ __volatile__( " ta 0 \n\t " );
        }

        if(sub_test_1_correct && sub_test_2_correct) {
            // if((ceil(log2(i+1)) == floor(log2(i+1))))
                ee_printf("Test %d passed\n", i+1);
        }

        // store data coverage
        int in1 = *(results_section_ptr + 6*i);
        int in2 = *(results_section_ptr + 6*i + 1);
        unsigned int grid_dim = (int)pow(2, GRID_DIM);
        unsigned int grids_in_row = (unsigned int)(pow(2, 32) / grid_dim);
        int grid_row = (in1 / grid_dim) + grids_in_row/2 - 1;
        int grid_col = (in2 / grid_dim) + grids_in_row/2 - 1;

        ee_printf("%d, %d, %d\n", grid_row, grid_col, grids_in_row);
    }

    // print register coverage
    for(i=0; i<8; i++) {
        ee_printf("l%d --- rs1 - %d, rs2 - %d, rd - %d\n", i, *(register_coverage + i*3), *(register_coverage + i*3 + 1), *(register_coverage + i*3 + 2));
    }

    return(0);
}
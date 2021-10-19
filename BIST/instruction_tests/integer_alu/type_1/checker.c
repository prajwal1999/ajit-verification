#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <math.h>

int checker(int *results_section_ptr, int *data_coverage, int *ccr_coverage) {
    int number_of_inputs = N_INPUTS;
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    ee_printf("------------------------Starting tests-------------------\n");

    int i;
    int instr;
    ee_printf(">>> Tests for Instruction with opcode 0x%x\n", INSTR_OP);
    for(i=0; i<number_of_inputs; i++) {
        int expected_out_1 = *(results_section_ptr + 8*i + 1);
        int expected_out_2 = *(results_section_ptr + 8*i);

        // ee_printf(">>> expected_out_1 0x%x expected_out_2 0x%x\n", expected_out_1, expected_out_2);

        int actual_out_1 = *(results_section_ptr + 8*i + 5);
        int actual_out_2 = *(results_section_ptr + 8*i + 6);

        // ee_printf(">>> actual_out_1 0x%x actual_out_2 0x%x\n", actual_out_1, actual_out_2);

        int result_msb = *(results_section_ptr + 8*i + 2);
        int instr_result = *(results_section_ptr + 8*i + 3);

        // ee_printf(">>> result_msb 0x%x instr_result 0x%x\n", result_msb, instr_result);

        char sub_test_1_correct = 0, sub_test_2_correct = 0;

        // ee_printf("result section head %x\n", (results_section_ptr + 6*i));
        // ee_printf("result %x\n", *(results_section_ptr + 6*i + 2));

        if(expected_out_1 == actual_out_1) {
            sub_test_1_correct = 1;
        } else {
            ee_printf("Test failed - %d/%d\n", i+1, number_of_inputs);
            ee_printf("Expected Output 0x%x, 0x%x\n",expected_out_1, expected_out_2);
            ee_printf("result_msb 0x%x\n", result_msb);
            ee_printf("Actual result 0x%x\n", instr_result);
            ee_printf("Actual Output 0x%x, 0x%x\n",actual_out_1, actual_out_2);
            // ee_printf("----------------------------------------------------\n");
            __asm__ __volatile__( " ta 0 \n\t " );
        }

        if(expected_out_2 == actual_out_2) {
            sub_test_2_correct = 1;
        } else {
            ee_printf("Test failed - %d/%d\n", i+1, number_of_inputs);
            ee_printf("Expected Output 0x%x, 0x%x\n",expected_out_1, expected_out_2);
            ee_printf("result_msb 0x%x\n", result_msb);
            ee_printf("Actual result 0x%x\n", instr_result);
            ee_printf("Actual Output 0x%x, 0x%x\n",actual_out_1, actual_out_2);
            // ee_printf("----------------------------------------------------\n");
            __asm__ __volatile__( " ta 0 \n\t " );
        }

        if(sub_test_1_correct && sub_test_2_correct) {
            // if((ceil(log2(i+1)) == floor(log2(i+1))))
                ee_printf("Test %d passed\n", i+1);
        }

        // store data coverage
        // int in1 = *(results_section_ptr + 8*i);
        // int in2 = *(results_section_ptr + 8*i + 1);
        // int grid_dim = (int)pow(2, GRID_DIM);
        // int grids_in_row = 1 << (32-GRID_DIM);
        // int grid_row = ( (unsigned int)(in1 + (int)pow(2, 31)) / grid_dim );
        // int grid_col = ( (unsigned int)(in2 + (int)pow(2, 31)) / grid_dim );
        // *(data_coverage + grid_row*grids_in_row + grid_col) += 1;


        // store ccr codes
        // unsigned int psr = *(results_section_ptr + 8*i + 4);
        // unsigned int ccr = (psr & 0x00f00000) >> 20; 
        // *(ccr_coverage + grid_row*grids_in_row*4 + 4*grid_col) += ((ccr & 0b1000)>>3); // n
        // *(ccr_coverage + grid_row*grids_in_row*4 + 4*grid_col + 1) += ((ccr & 0b0100)>>2); // z
        // *(ccr_coverage + grid_row*grids_in_row*4 + 4*grid_col + 2) += ((ccr & 0b0010)>>1); // v
        // *(ccr_coverage + grid_row*grids_in_row*4 + 4*grid_col + 3) += ((ccr & 0b0001)>>0); // c
        
        // ee_printf("%x   %x\n", in1, in2);
        // ee_printf("%d, %d\n", grid_row, grid_col);
        // ee_printf("psr %x %x\n", psr, ccr);
        // ee_printf("----------------------------------------------------\n");

    
    }   

    

    return(0);
}
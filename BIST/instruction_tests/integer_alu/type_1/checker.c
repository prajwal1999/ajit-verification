#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <math.h>

int checker(int *results_section_ptr, int *data_coverage, int *ccr_coverage, int input_seed, int register_seed, int instr_opcode) {

    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    ee_printf("------------------------Starting tests-------------------\n");

    int i;
    int instr;
    ee_printf(">>> Tests for Instruction with opcode 0x%x\n", instr_opcode);
    ee_printf(">>> Input seed is 0x%x | Register seed is 0x%x\n", input_seed, register_seed);

    for(i=0; i<N_INPUTS; i++) {
        int expected_out_2 = *(results_section_ptr + 8*i);
        int expected_out_1 = *(results_section_ptr + 8*i + 1);

        int result_msb = *(results_section_ptr + 8*i + 2);
        int actual_result = *(results_section_ptr + 8*i + 3);


        int actual_out_1 = *(results_section_ptr + 8*i + 5);
        int actual_out_2 = *(results_section_ptr + 8*i + 6);


        int psr = *(results_section_ptr + 8*i + 4);
        int ccr = (psr & 0x00f00000) >> 20; 
        int N =  ((ccr & 0b1000)>>3);
        int Z = ((ccr & 0b0100)>>2);
        int V = ((ccr & 0b0010)>>1);
        int C = (ccr & 0b0001);


        char sub_test_1_correct = 0, sub_test_2_correct = 0;

        if(expected_out_1 == actual_out_1) sub_test_1_correct = 1;
        else {
            ee_printf("Test failed - i - %d/%d\n", i+1, N_INPUTS);
            ee_printf("Expected Output 0x%x, 0x%x\n",expected_out_1, expected_out_2);
            ee_printf("result_msb 0x%x,  Actual result 0x%x\n", result_msb, actual_result);
            ee_printf("Actual Output 0x%x, 0x%x\n\n",actual_out_1, actual_out_2);
            ee_printf("----------------------------------------------------\n");
            __asm__ __volatile__( " ta 0 \n\t " );
        }

        if(expected_out_2 == actual_out_2) sub_test_2_correct = 1;
        else {
            ee_printf("Test failed - ii - %d/%d\n", i+1, N_INPUTS);
            ee_printf("Expected Output 0x%x, 0x%x\n",expected_out_1, expected_out_2);
            ee_printf("result_msb 0x%x,  Actual result 0x%x\n", result_msb, actual_result);
            ee_printf("Actual Output 0x%x, 0x%x\n\n",actual_out_1, actual_out_2);
            ee_printf("----------------------------------------------------\n");
            __asm__ __volatile__( " ta 0 \n\t " );
        }

        if(sub_test_1_correct && sub_test_2_correct) {
            // if((ceil(log2(i+1)) == floor(log2(i+1))))
                ee_printf("Test %d passed\n", i+1);
        }

        // verify ccr code
        int e_N = (actual_result >> 31) & 1;
        int e_Z = (actual_result == 0) ? 1 : 0;
        int e_V;
        int e_C;
        if(instr_opcode == 0x13 || instr_opcode == 0x17 || instr_opcode == 0x1a || instr_opcode == 0x1b)
        {
            e_V = 0;
            e_C = 0;
        }
        else if(instr_opcode == 0x10 || instr_opcode == 0x14)
        {
            int operand1_sign = (expected_out_1 >> 31) & 1;
            int operand2_sign = (expected_out_2 >> 31) & 1;

            e_V = ((operand1_sign & operand2_sign & !e_N) | (!operand1_sign & !operand2_sign & e_N));
            e_C = (operand1_sign & operand2_sign) | ((!e_N) & (operand1_sign | operand2_sign));
        }

        if(N!=e_N || Z!=e_Z || V!=e_V || C!=e_C){
            ee_printf("CCR wrong in test %d/%d\n", i+1, N_INPUTS);
            ee_printf("Actual %x | Expected %x \n", ccr, N*8+Z*4+V*2+C);
            __asm__ __volatile__( " ta 0 \n\t " );
        } 

        // store data coverage
        int in1 = *(results_section_ptr + 8*i);
        int in2 = *(results_section_ptr + 8*i + 1);
        int grid_dim = (int)pow(2, GRID_DIM);
        int grids_in_row = 1 << (32-GRID_DIM);
        int grid_row = ( (unsigned int)(in1 + (int)pow(2, 31)) / grid_dim );
        int grid_col = ( (unsigned int)(in2 + (int)pow(2, 31)) / grid_dim );
        *(data_coverage + grid_row*grids_in_row + grid_col) += 1;


        // store ccr codes
       
        *(ccr_coverage + grid_row*grids_in_row*4 + 4*grid_col) += ((ccr & 0b1000)>>3); // n
        *(ccr_coverage + grid_row*grids_in_row*4 + 4*grid_col + 1) += ((ccr & 0b0100)>>2); // z
        *(ccr_coverage + grid_row*grids_in_row*4 + 4*grid_col + 2) += ((ccr & 0b0010)>>1); // v
        *(ccr_coverage + grid_row*grids_in_row*4 + 4*grid_col + 3) += ((ccr & 0b0001)>>0); // c
        
        // ee_printf("%x   %x\n", in1, in2);
        // ee_printf("%d, %d\n", grid_row, grid_col);
        // ee_printf("psr %x %x\n", psr, ccr);
        // ee_printf("----------------------------------------------------\n");

    
    }   

    

    return(0);
}
#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <math.h>

int checker(int *results_section_ptr, int *data_coverage_ptr, int input_seed, int register_seed, int instr_opcode) {

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
            ee_printf("Inputs are %x, %x\n",expected_out_2, expected_out_1);
            ee_printf("result_msb 0x%x,  Actual result 0x%x\n", result_msb, actual_result);
            ee_printf("Actual Output 0x%x, 0x%x\n\n",actual_out_1, actual_out_2);
            ee_printf("----------------------------------------------------\n");
            __asm__ __volatile__( " ta 0 \n\t " );
        }

        if(expected_out_2 == actual_out_2) sub_test_2_correct = 1;
        else {
            ee_printf("Test failed - ii - %d/%d\n", i+1, N_INPUTS);
            ee_printf("Inputs are %x, %x\n",expected_out_2, expected_out_1);
            ee_printf("result_msb 0x%x,  Actual result 0x%x\n", result_msb, actual_result);
            ee_printf("Actual Output 0x%x, 0x%x\n\n",actual_out_1, actual_out_2);
            ee_printf("----------------------------------------------------\n");
            __asm__ __volatile__( " ta 0 \n\t " );
        }

        if(sub_test_1_correct && sub_test_2_correct) {
            if((ceil(log2(i+1)) == floor(log2(i+1))))
                ee_printf("Test %d passed\n", i+1);
        }

        // verify ccr code
        int operand1_sign = (expected_out_1 >> 31) & 1;
        int operand2_sign = (expected_out_2 >> 31) & 1;
        int e_N;
        int e_Z;
        int e_V;
        int e_C;

        if( (instr_opcode >> 4) == 0x1)
        {
            e_N = (actual_result >> 31) & 1;
            e_Z = (actual_result == 0) ? 1 : 0;
        }
        else
        {
            e_N = 0;
            e_Z = 0;
        }

        if(instr_opcode == 0x10 )
        {
            e_V = ((operand1_sign & operand2_sign & !e_N) | (!operand1_sign & !operand2_sign & e_N));
            e_C = (operand1_sign & operand2_sign) | ((!e_N) & (operand1_sign | operand2_sign));
        }
        else if(instr_opcode == 0x14) {
            e_V = ((operand1_sign && (!operand2_sign) & (!e_N)) || ((!operand1_sign) && operand2_sign && e_N));
            e_C = ((!operand1_sign) && operand2_sign) || (e_N && ((!operand1_sign) || operand2_sign));
        } 
        else 
        {
            e_V = 0;
            e_C = 0;
        }

        if( (instr_opcode >> 4) == 0x1) {
            if(N!=e_N || Z!=e_Z || V!=e_V || C!=e_C){
                ee_printf("CCR wrong in test %d/%d\n", i+1, N_INPUTS);
                ee_printf("N = %x | e_N = %x \n", N, e_N);
                ee_printf("Z = %x | e_Z = %x \n", Z, e_Z);
                ee_printf("V = %x | e_V = %x \n", V, e_V);
                ee_printf("C = %x | e_C = %x \n", C, e_C);
                ee_printf("Actual %x | Expected %x \n", ccr, e_N*8+e_Z*4+e_V*2+e_C);
                ee_printf("Inputs are %x, %x\n",expected_out_2, expected_out_1);
                ee_printf("result_msb 0x%x,  Actual result 0x%x\n", result_msb, actual_result);
                ee_printf("Actual Output 0x%x, 0x%x\n\n",actual_out_1, actual_out_2);
                ee_printf("----------------------------------------------------\n");
                __asm__ __volatile__( " ta 0 \n\t " );
            } 
        }

        // store data coverage
        int in1 = *(results_section_ptr + 8*i);
        int in2 = *(results_section_ptr + 8*i + 1);
        int grid_dim = (int)pow(2, GRID_DIM);
        int grids_in_row = 1 << (32-GRID_DIM);
        int grid_row = ( (unsigned int)(in1 + (int)pow(2, 31)) / grid_dim );
        int grid_col = ( (unsigned int)(in2 + (int)pow(2, 31)) / grid_dim );
        *(data_coverage_ptr + grid_row*grids_in_row + grid_col) += 1;

        // ee_printf("----------------------------------------------------\n");

    
    }   

    

    return(0);
}
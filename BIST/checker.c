#include<stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <math.h>

int checker(int *results_section_ptr, int number_of_inputs) {
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    ee_printf("------------------------Starting tests-------------------\n");

    int i,j;
    int instr;

    for(i=0; i<number_of_inputs; i++) {
        int expected_out_1 = *(results_section_ptr + 2*i + 1);
        int expected_out_2 = *(results_section_ptr + 2*i);

        int actual_out_1 = *(results_section_ptr + 2*number_of_inputs + 2*i);
        int actual_out_2 = *(results_section_ptr + 2*number_of_inputs + 2*i + 1);

        char sub_test_1_correct = 0, sub_test_2_correct = 0;
        if(expected_out_1 == actual_out_1) {
            sub_test_1_correct = 1;
        } else {
            ee_printf("Test failed - %d/%d\n", i+1, number_of_inputs);
            ee_printf("Expected Output %d, %d\n",expected_out_1, expected_out_2);
            ee_printf("Actual Output %d, %d\n",actual_out_1, actual_out_2);
            ee_printf("----------------------------------------------------");
            __asm__ __volatile__( " ta 0 \n\t " );
        }

        if(expected_out_2 == actual_out_2) {
            sub_test_2_correct = 1;
        } else {
            ee_printf("Test failed - %d/%d\n", i+1, number_of_inputs);
            ee_printf("Expected Output %d, %d\n",expected_out_1, expected_out_2);
            ee_printf("Actual Output %d, %d\n",actual_out_1, actual_out_2);
            ee_printf("----------------------------------------------------");
            __asm__ __volatile__( " ta 0 \n\t " );
        }

        if(sub_test_1_correct && sub_test_2_correct) {
            if((ceil(log2(i+1)) == floor(log2(i+1))))
                ee_printf("Test %d passed\n", i+1);
        }
        // if(*(results_section_ptr + number_of_inputs+i) == *(results_section_ptr + 2*number_of_inputs+i)){
        //     ee_printf("Test ran successfuuly - %d/%d\n", i+1, number_of_inputs);
        // }
        // else {
        //     ee_printf("Test failed - %d/%d\n", i+1, number_of_inputs);
        //     __asm__ __volatile__( " ta 0 \n\t " );
        // }
    }

    return(0);
}
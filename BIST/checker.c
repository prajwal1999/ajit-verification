#include<stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"

int checker(int *results_section_ptr) {
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    int expected_out_1 = *(results_section_ptr + 2);
    int expected_out_2 = *(results_section_ptr + 3);

    int actual_out_1 = *(results_section_ptr + 4);
    int actual_out_2 = *(results_section_ptr + 5);

    if(expected_out_1 == actual_out_1) {
        ee_printf("Test ran successfuuly - 1/2\n");
    } else {
        ee_printf("Test failed - 1/2\n");
        __asm__ __volatile__( " ta 0 \n\t " );
    }

    if(expected_out_2 == actual_out_2) {
        ee_printf("Test ran successfuuly - 2/2\n");
    } else {
        ee_printf("Test failed - 1/2\n");
        __asm__ __volatile__( " ta 0 \n\t " );
    }

    return(0);
}
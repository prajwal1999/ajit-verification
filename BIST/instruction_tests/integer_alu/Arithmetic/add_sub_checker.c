#include<stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"

int checker(int *results_section_ptr, int number_of_inputs) {
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    ee_printf("------------------------Starting tests-------------------\n");

    int i;

    for(i=0; i<number_of_inputs; i++) {
        if(*(results_section_ptr + no_of_inputs+i) == *(results_section_ptr + 2*no_of_inputs+i)){
            ee_printf("Test ran successfuuly - %d/%d\n", i+1, no_of_inputs);
        }
        else {
            ee_printf("Test failed - %d/%d\n", i+1, no_of_inputs);
            __asm__ __volatile__( " ta 0 \n\t " );
        }
    }

    return(0);
}
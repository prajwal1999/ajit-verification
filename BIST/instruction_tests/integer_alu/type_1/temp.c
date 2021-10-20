#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>


int temp(int *results_section_ptr) 
{

    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);
    ee_printf("reached here\n");
    int i;
    for(i=0; i<N_INPUTS; i++) {
        ee_printf("%d 0x%x 0x%x 0x%x 0x%x\n", i+1, (results_section_ptr + 8*i), *(results_section_ptr + 8*i), (results_section_ptr + 8*i + 1), *(results_section_ptr + 8*i + 1));
    }

    return(1);
}
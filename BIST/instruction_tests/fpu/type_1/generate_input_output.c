#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>


uint32_t prbs_32(uint32_t x)
{
    x ^= x << 13;
	x ^= x >> 17;
	x ^= x << 5;
    return x;
}

int generate_input_output(int *results_section_ptr, int input_seed)
{
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    ee_printf("inputs generation started. input seed is 0x%x\n", input_seed);
	

    int number_of_inputs = N_INPUTS;
    int lfsr = input_seed;

    
    int i;
    for(i=0; i<N_INPUTS; i++) {
        lfsr = prbs_32(lfsr);
        *(results_section_ptr + 8*i) = lfsr;

        lfsr = prbs_32(lfsr);
        *(results_section_ptr + 8*i + 1) = lfsr;
    }
    

    ee_printf("--------------------Inputs Outputs Generated----------------------\n");

    return lfsr;

}


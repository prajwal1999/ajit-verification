#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>


int16_t prbs(int16_t lfsr)
{
    bool bit;                    
    bit  = ((lfsr >> 31) ^ (lfsr >> 28) ^ (lfsr >> 18) ^ (lfsr >> 5) ) & 1;
    lfsr =  (lfsr >> 1) | (bit << 12);
    return lfsr;
}

uint32_t prbs_32(uint32_t x)
{
    x ^= x << 13;
	x ^= x >> 17;
	x ^= x << 5;
    return x;
}


int generate_input_output(int *results_section_ptr, int inputs_seed)
{
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);


    int number_of_inputs = N_INPUTS;
    int lfsr = inputs_seed;

    ee_printf("inputs generation started\n");

    int i;
    for(i=0; i<N_INPUTS; i++) {
        // ee_printf("number of inputs are %d and it is stores at 0x%x\n", number_of_inputs, &number_of_inputs);

        lfsr = prbs_32(lfsr);
        *(results_section_ptr + 8*i) = lfsr;
        // ee_printf("%d 0x%x 0x%x 0x%x\n", i, lfsr, (results_section_ptr + 8*i), *(results_section_ptr + 8*i));

        lfsr = prbs_32(lfsr);
        *(results_section_ptr + 8*i + 1) = lfsr;
        // ee_printf("%d 0x%x 0x%x 0x%x\n", i, lfsr, (results_section_ptr + 8*i + 1), *(results_section_ptr + 8*i + 1));
    }
    

    ee_printf("--------------------Inputs Outputs Generated----------------------\n");
    return(1);
}



// __asm__ __volatile__( " set results_section, %l0\n\t " );

    // __asm__ __volatile__( " mov %0, %%l1 \n\t " : : "r" (inp_out[i]) );
    // __asm__ __volatile__( " st %l1, [%l0] \n\t " );
    // __asm__ __volatile__( " add %l0, 0x4, %l0\n\t " );

    // __asm__ __volatile__( " mov %0, %%l1 \n\t " : : "r" (inp_out[number_of_inputs + i]) );
    // __asm__ __volatile__( " st %l1, [%l0] \n\t " );
    // __asm__ __volatile__( " add %l0, 0x10, %l0\n\t " );
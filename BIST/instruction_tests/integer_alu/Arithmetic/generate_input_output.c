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

uint32_t prbs_32(uint32_t lfsr)
{
    bool bit;                    
	bit  = ((lfsr >> 31) ^ (lfsr >> 30) ^ (lfsr >> 25) ^ (lfsr >> 26) ) & 1;
    lfsr =  (lfsr >> 1) | (lfsr << 31);
    // ee_printf("%x\n", lfsr);
    return lfsr;
}


int generate_input_output(int *results_section_ptr)
{
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    int number_of_inputs = N_INPUTS;
    uint inp_out[number_of_inputs*2];
    int start_state = 0x96BD843D;  /* Any nonzero start state will work. */
    int lfsr = start_state;

    int i;
    for(i=0; i<number_of_inputs; i++) {
        lfsr = prbs_32(lfsr);
        inp_out[i] = lfsr;
        lfsr = prbs_32(lfsr);
        inp_out[number_of_inputs+i] = lfsr;
    }

    for(i=0; i<number_of_inputs; i++) {
        *(results_section_ptr + 6*i) = inp_out[i];
        *(results_section_ptr + 6*i + 1) = inp_out[number_of_inputs + i];

        // ee_printf("stored 0x%x and 0x%x in results section\n", inp_out[i], inp_out[number_of_inputs + i]);
        ee_printf("%d   %d\n", inp_out[i], inp_out[number_of_inputs + i]);
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
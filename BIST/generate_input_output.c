#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include<time.h>

int16_t prbs(int16_t lfsr)
{
    bool bit;                    
    /* Must be 16bit to allow bit<<15 later in the code */
    /* taps: 16 14 13 11; feedback polynomial: x^16 + x^14 + x^13 + x^11 + 1 */
    bit  = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5) ) & 1;
    
    //bit  = ((lfsr >> 0) ^ (lfsr >> 2) ) & 1;
    lfsr =  (lfsr >> 1) | (bit << 12);
    //lfsr =  (lfsr >> 1) | (bit << 15);
    return lfsr;
}


int generate_input_output() {
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    uint16_t start_state = 0x010;  /* Any nonzero start state will work. */
    uint16_t lfsr = start_state;
    int inp_out[4];
    int i;

    //Storing random values in input array

    for(i=0; i<2; i++) {
        lfsr = prbs(lfsr) ;
        inp_out[i] = lfsr;
        ee_printf("0x%02X\n", inp_out[i]);
    }


    __asm__ __volatile__( " set results_section, %l0\n\t " );
    for(i=0; i<4; i++) {
        __asm__ __volatile__( " mov %0, %%l1 \n\t " : : "r" (inp_out[i]) );
        __asm__ __volatile__( " st %l1, [%l0] \n\t " );
        __asm__ __volatile__( " add %l0, 0x4, %l0\n\t " );
    }

    ee_printf("inputs outputs generated\n");

    
    
    
    return(0);
}

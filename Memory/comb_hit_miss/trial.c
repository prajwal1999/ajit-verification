#include <stdint.h>
#include <stdlib.h>
#include "ajit_access_routines.h"
#include "core_portme.h"
#include "math.h" 
#include <stdbool.h>
#include <float.h>

int trial()
{
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    int i;
    __asm__ __volatile__("set 0x000000, %o0 \n\t");

    uint32_t t0 = ajit_barebones_clock();
    __asm__ __volatile__("ldub [%o0], %l1 \n\t");
    uint32_t t1 = ajit_barebones_clock();
	ee_printf("Time in ticks = %u\n",(t1 - t0));
    
    for(i = 0; i< 15; i++){
        __asm__ __volatile__("inc %o0 \n\t"); 

        t0 = ajit_barebones_clock();
        __asm__ __volatile__("ldub [%o0], %l1 \n\t");
        t1 = ajit_barebones_clock();
        ee_printf("Time in ticks = %u\n",(t1 - t0));

    }
    
    return(0);
}


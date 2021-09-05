#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>

int generate_input_output() {
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);
    int inp_out[4] = {0x100, 0x200, 0x200, 0x100};

    int i;
    __asm__ __volatile__( " set results_section, %l0\n\t " );
    for(i=0; i<4; i++) {
        __asm__ __volatile__( " mov %0, %%l1 \n\t " : : "r" (inp_out[i]) );
        __asm__ __volatile__( " st %l1, [%l0] \n\t " );
        __asm__ __volatile__( " add %l0, 0x4, %l0\n\t " );
    }

    ee_printf("inputs outputs generated\n");

    // srand(1);
    // ee_printf("%d\n", rand());
    
    return(0);
}

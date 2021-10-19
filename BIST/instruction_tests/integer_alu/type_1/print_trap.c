#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"


int print_trap(int trap_msg) 
{

    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);
    ee_printf("trap occured %x\n", trap_msg);
    return(1);
}
#include<stdio.h>
#include <stdint.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
// #include "../../ajit-toolchain/AjitPublicResources/tools/ajit_access_routines/include/ajit_access_routines.h"
#include <math.h>

float convertToSeconds(long ut) {
	float result = (256.0/CLK_FREQUENCY)*((float)ut);
	return result;
}

int serial() {
	// __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    // #ifndef CLK_FREQUENCY
    //     ee_printf("Error: virtual clock frequency not specified\n");		
    //     return(1);
    // #endif

    // ee_printf("End of State\n");

    return(1);
}
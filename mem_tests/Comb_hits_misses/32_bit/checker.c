#include<stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <math.h>

int checker(int *results_section) {
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

	ee_printf("---Start----");

	//int expected_out = (1024-*(number_misses))*962+*(number_misses)*1843;

	//int actual_out = *(access_time);
	
	//ee_printf("Expected = %d\n", expected_out);
	//ee_printf("Actual = %d\n", actual_out);

    return(0);
}
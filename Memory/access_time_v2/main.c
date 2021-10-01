#include <stdint.h>
#include <stdlib.h>
#include "ajit_access_routines.h"
#include "core_portme.h"
#include "math.h" 
#include <stdbool.h>
#include <float.h>

int run_test(uint32_t* array_1, int length);
uint32_t prbs(uint32_t lfsr);

int main()
{
	__ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

	//uint32_t lfsr = __ajit_get_clock_time();
	//lfsr = prbs(lfsr);
	int i;
	//unsigned int *array_1 = (unsigned int *) lfsr; 
	uint32_t* array_1 = 0x40044000; //index: 0x100 
	
	/* Cache size is 32 kB */
	init_src_array(array_1);
	run_test(array_1, 64*32);
	run_test(array_1, 64*64);
	run_test(array_1, 64*128);
	run_test(array_1, 64*256);
	run_test(array_1, 64*512);
	run_test(array_1, 64*1024);
	

	
	return(0);
}


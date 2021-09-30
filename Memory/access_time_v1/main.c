#include <stdint.h>
#include <stdlib.h>
#include "ajit_access_routines.h"
#include "core_portme.h"
#include "math.h" 
#include <stdbool.h>
#include <float.h>

int run_test(int length, int stride,uint32_t* array_1);
uint32_t prbs(uint32_t lfsr);

int main()
{
	__ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

	//uint32_t lfsr = __ajit_get_clock_time();
	//lfsr = prbs(lfsr);
	int i;
	//unsigned int *array_1 = (unsigned int *) lfsr; 
	uint32_t* array_1 = 0x40044000; //index: 0x100 
	
	init_src_array(array_1);
	run_test(64*64,1, array_1);
	run_test(64*128,1, array_1);
	run_test(64*256,1, array_1);
	run_test(64*512,1, array_1);
	run_test(64*1024,1, array_1);
	
	return(0);
}


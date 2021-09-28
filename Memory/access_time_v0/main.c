#include <stdint.h>
#include <stdlib.h>
#include "ajit_access_routines.h"
#include "core_portme.h"
#include "math.h" 
#include <stdbool.h>
#include <float.h>


int init_src_array(uint32_t* array_1, int length, int stride);
int run_test(int length, int stride,uint32_t* array_1);
uint32_t prbs(uint32_t lfsr);

int main()
{
	__ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

	//uint32_t lfsr = __ajit_get_clock_time();
	//lfsr = prbs(lfsr);
    double time1, time2, time3, time4, time5;
	int i;
	//unsigned int *array_1 = (unsigned int *) lfsr; 
	uint32_t* array_1 = 0x40044000; //index: 0x100 
	/*
	init_src_array(array_1, 4096, 8);  
	init_src_array(array_1, 64*128, 8);  
	init_src_array(array_1, 64*256, 8);
	init_src_array(array_1, 64*512, 8);
	init_src_array(array_1, 64*1024, 8);      
	init_src_array(array_1, 128*1024, 8);
	init_src_array(array_1, 256*1024, 8);
	init_src_array(array_1, 256*1024, 8);
	*/

	run_test(64*64,8, array_1);
	init_src_array(array_1, 64*64, 8); 
	run_test(64*128,8, array_1);
	run_test(64*256,8, array_1);
	run_test(64*512,8, array_1);
	run_test(64*1024,8, array_1);
	return(0);
}


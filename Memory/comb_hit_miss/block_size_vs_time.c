#include <stdint.h>
#include <stdlib.h>
#include "ajit_access_routines.h"
#include "core_portme.h"
#include "math.h" 
#include <stdbool.h>
#include <float.h>

uint32_t prbs(uint32_t lfsr)
{
    bool bit;                    
    
	bit  = ((lfsr >> 31) ^ (lfsr >> 30) ^ (lfsr >> 25) ^ (lfsr >> 26) ) & 1;
    lfsr =  (lfsr >> 1) | (lfsr << 31) ;
	lfsr = lfsr * 4;
	lfsr = 0x40040000 | lfsr;
	lfsr = 0x7FFFFFFF & lfsr;
    return lfsr;
}

int init_src_array(uint32_t* array_1, int LENGTH)
{	
	double time,start_time, end_time;
	start_time = __ajit_get_clock_time();
	int i;
	for(i = 0; i < LENGTH;  i += 1)
	{
		*(array_1 + i) = i;
	}
	end_time = __ajit_get_clock_time();
	time =(double) end_time - start_time ;
	return(time);
}

int run_test(int length,uint32_t* array_1)
{
	double time,start_time, end_time;
	start_time  = __ajit_get_clock_time();					
	int i;
	int value1;
	for(i = 0; i < length; i++)
	{
		value1=array_1[i];
	}
	end_time  = __ajit_get_clock_time();					
	time = (double)(end_time- start_time);
	return(time);
}


int block_size_vs_time()
{
	__ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

	double time1, time2;
	int i;
	
	uint32_t lfsr = __ajit_get_clock_time();
	
	lfsr = prbs(lfsr);
	unsigned int *array_1 = (unsigned int *) lfsr;  
	for(i = 0; i< 256; i++){
		
		time1 = init_src_array(array_1, i) * 1e-08;
		time2 = run_test(i, array_1) * 1e-08;
		
		ee_printf("Time elapsed in stores = %f\n ", time1);
		ee_printf("Time elapsed in loads = %f\n ", time2);
	}
	
		
	return(0);
}



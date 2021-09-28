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

int init_src_array(uint32_t* array_1)
{
	int i;
	for(i = 0; i < 64*1024; i++)
	{
		*(array_1 + i) = i;
	}
}


float run_test(int length, int stride,uint32_t* array_1)
{	
	double time = 0, iters = 0, err= 0;
	int i,j;
	double miss_penalty, value;
	uint64_t start_time, end_time;

	/*Store the array */
	for(j = 0;  j< 5;  j += 1){
		start_time = __ajit_get_clock_time();
		
		for(i = 0; i < length;  i += stride)
		{
			*(array_1 + i) = i;
		}
		
		end_time = __ajit_get_clock_time();
		time =time+ (double)(end_time - start_time) ;
		
	}

	/*Load the array */
	for(j = 0; j < 5;  j += 1){
		start_time = __ajit_get_clock_time();
		
		for(i = 0; i < length;  i += stride)
		{
			value = array_1[i];
			if(value != i){
				err= err+1;
			}
		}
		end_time = __ajit_get_clock_time();
		time = time + (double)(end_time - start_time) ;

	}

	/*avg miss penalty = (total miss penalty across iters/iters) */

	miss_penalty = ((time)/10)*1e-8;
	ee_printf("Avg miss penalty = %f sec \n", miss_penalty);
	ee_printf("Loads- Stores completed with error =%f\n", err);
	
	
	return(err);
}




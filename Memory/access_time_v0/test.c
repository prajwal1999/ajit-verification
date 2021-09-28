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



float init_src_array(uint32_t* array_1, int length, int stride)
{	
	double sec = 0, iters = 0;
	int i;
	double time, miss_penalty;
	uint64_t start_time, end_time;

	do{
		start_time = __ajit_get_clock_time();
		
		for(i = 0; i < length;  i += stride)
		{
			*(array_1 + i) = i;
		}
		end_time = __ajit_get_clock_time();
		time = (double)(end_time - start_time) ;
		sec = sec+ time;
		iters = iters+1;

	}while(sec*1e-08 <0.1);

	/* Gives us array access time - cache access time = miss time*/
	
	int iters2 = 0, var = 0;
    do {
        start_time = __ajit_get_clock_time();
        
        for (i = 0; i < length; i += stride) 
            var = i;
        
        iters2 = iters2 + 1;
        end_time = __ajit_get_clock_time();
		time = (double)(end_time - start_time) ;
		sec = sec - (time);

    } while (iters2 < iters);
	
	/* avg miss penalty = (total miss penalty across iters/iters) */

	miss_penalty = (sec/iters)*1e-2;
	ee_printf("Avg miss penalty = %f usec \n", miss_penalty);
	return(sec);
}

int run_test(int length, int stride,uint32_t* array_1)
{
	double sec = 0, iters = 0;
	int i;
	double time, miss_penalty;
	uint64_t start_time, end_time;
	uint32_t value[length];

	do{
		start_time = __ajit_get_clock_time();
		
		for(i = 0; i < length;  i += stride)
		{
			value[i] = array_1[i];
		}
		end_time = __ajit_get_clock_time();
		time = (double)(end_time - start_time) ;
		sec = sec+ time;
		iters = iters+1;

	}while(sec*1e-08 <0.1);

	/* Gives us array access time - cache access time = miss time*/
	
	int iters2 = 0, var = 0;
    do {
        start_time = __ajit_get_clock_time();
        
        for (i = 0; i < length; i += stride) 
            var = i;
        
        iters2 = iters2 + 1;
        end_time = __ajit_get_clock_time();
		time = (double)(end_time - start_time) ;
		sec = sec - (time);

    } while (iters2 < iters);
	
	/* avg miss penalty = (total miss penalty across iters/iters) */

	miss_penalty = (sec/iters)*1e-2;
	ee_printf("Avg miss penalty = %f usec \n", miss_penalty);
	return(sec);
}




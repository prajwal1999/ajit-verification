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


float run_test(uint32_t* array_1, int length)
{	
	double time1 = 0, time2 = 0, iters = 0, err= 0;
	int i,j;
	double miss_penalty, value;
	uint64_t start_time, end_time;

	/*Store the array */
	
	do{
	start_time = __ajit_get_clock_time();
	
		for(i = 0; i < length;  i += 1)
		{
			
			if (i%2 == 0){
				*(array_1+i) = i;

			}
			else{
				*(array_1+i+32768) = i;
			}
			
		}
		
		end_time = __ajit_get_clock_time();
		time1 =time1+ (double)(end_time - start_time) ;
		iters = iters+1;
	//
	}while(time1*1e-08< 0.1);

	int iters2 = 0;
    do {
        start_time = __ajit_get_clock_time();
        
        for (i = 0; i < length; i += stride) 
            var = i;
        
        iters2 = iters2 + 1;
        end_time = __ajit_get_clock_time();
		time1 = time1 - (double)(end_time - start_time) ;

    } while (iters2 < iters);

	time1 = time1/iters;

	iters = 0;

	do{
	start_time = __ajit_get_clock_time();
	
		for(i = 0; i < length;  i += 1)
		{
			
			if (i%2 == 0){
				value = array_1[i];
				if (value != i){
					err = err+1;
				}

			}
			else{
				value = array_1[32768+i];
				if (value != i){
					err = err+1;
				}
			}
			
		}
		
		end_time = __ajit_get_clock_time();
		time2 =time2+ (double)(end_time - start_time) ;
		iters = iters+1;
	//
	}while(time2*1e-08< 0.1);
	
	time2 = time2/iters;
	/*avg miss penalty = (total miss penalty across iters/iters) */

	miss_penalty = (time1+time2)*1e-8;
	ee_printf("Avg miss penalty = %f sec \n", miss_penalty);
	ee_printf("Loads- Stores completed with error =%f\n", err);
	
	
	return(err);
}




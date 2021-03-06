
#include<stdio.h>
#include <stdint.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <math.h>
#include <stdbool.h>
#include <float.h>


#define TESTLENGTH 256
#define NSWEEPS    10

// mapped to VA_DATA_SECTION_START  + 0x10000 for low mem
// mapped to VA_DATA_SECTION_START at 0x40040000 and above for high mem

float convertToSeconds(long ut);
uint32_t *cacheable_mem    = VA_DATA_SECTION_START+0x4000; 
uint32_t *non_cacheable_mem    = VA_DATA_SECTION_START+0x40000+0x4000; 

uint16_t prbs(uint16_t lfsr)
{
    bool bit;                    
    
	bit  = ((lfsr >> 0) ^ (lfsr >> 3)) & 1;
    lfsr =  (lfsr >> 1) | (lfsr << 9) ;
    return lfsr;
}

int main()
{
	__ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

#ifndef VA_DATA_SECTION_START
	ee_printf("Error: virtual address of data section not specified\n");		
	return(1);
#endif

#ifndef CLK_FREQUENCY
	ee_printf("Error: virtual clock frequency not specified\n");		
	return(1);
#endif
	uint16_t seed, loc;
	int I,J, no_hits;
	double no_misses;
	uint32_t t0, t1;
	
	seed = 31040+__ajit_get_clock_time();
	no_misses =(double)(prbs(seed) & 0x3FF);
	no_hits = 1024 - no_misses;


	ee_printf("No. of misses = %f\n", (no_misses/1024));
	t0 = ajit_barebones_clock();
	for(I = 0; I< NSWEEPS; I++){
		for(J = 0; J<no_hits; J++){
			*(cacheable_mem+I) = I;
			}
	}
	for(I = 0; I< NSWEEPS; I++){
		for(J = 0; J<no_misses; J++){
			*(non_cacheable_mem+I) = I;
			}
	}
	t1 = ajit_barebones_clock();
	int access_time = (t1 -t0)/NSWEEPS;
	//ee_printf("Time in ticks = %u\n", access_time);

	int expected_out = (1024-no_misses)*0.093+no_misses*0.231;
	
	ee_printf("Expected = %d\n", expected_out);
	
	if((expected_out == access_time) || (expected_out == access_time+1) || (expected_out == access_time-1)){
		ee_printf("Test passed\n");
	}
	else{
		ee_printf("Test failed for no.of misses = %u\n", no_misses);
		__asm__ __volatile__( " ta 0 \n\t " );
	}

	//ee_printf("done\n");
}


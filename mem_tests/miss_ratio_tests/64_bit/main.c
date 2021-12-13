#include<stdio.h>
#include <stdint.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <math.h>

#define TESTLENGTH 256
#define NSWEEPS    16

// mapped to VA_DATA_SECTION_START  + 0x10000 for low mem
// mapped to VA_DATA_SECTION_START at 0x40040000 and above for high mem
float convertToSeconds(long ut);
int test_1 (uint64_t* a, int length);
int test_2 (uint64_t* a, int length);

uint64_t *cacheable_mem    = VA_DATA_SECTION_START+0x4000; 


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
	int I, err;
	uint32_t t0, t1 = ajit_barebones_clock();
	/*
	for(I = 0; I < NSWEEPS; I++)
	{
		err = test_1(cacheable_mem,TESTLENGTH*4);
		if(err)
		{
			ee_printf("Error cacheable\n");
		}
	}
	t1 = ajit_barebones_clock();
	ee_printf("All misses: Time in ticks = %u\n",(t1 - t0));
	*/
	t0 = ajit_barebones_clock();
	for(I = 0; I < NSWEEPS; I++)
	{
		err = test_2(cacheable_mem,TESTLENGTH*4);
		if(err)
		{
			ee_printf("Error cacheable\n");
		}
	}
	t1 = ajit_barebones_clock();
	ee_printf("Only one miss: Time in ticks = %u\n",(t1 - t0));
	
	ee_printf("done\n");
}


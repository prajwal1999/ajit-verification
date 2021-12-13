#include<stdio.h>
#include <stdint.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <math.h>

#define TESTLENGTH 256
#define NSWEEPS    16

int test_1 (uint32_t* a, int length);
int test_2 (uint32_t* a, int length);

// mapped to VA_DATA_SECTION_START  + 0x10000 for low mem
// mapped to VA_DATA_SECTION_START at 0x40040000 and above for high mem
float convertToSeconds(long ut);
uint32_t *cacheable_mem    = VA_DATA_SECTION_START+0x4000; 


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
	uint32_t t0, t1, t2, t3;

	t0 = ajit_barebones_clock();

	for(I = 0; I < NSWEEPS; I++)
	{
		test_1(cacheable_mem,TESTLENGTH*4);
	}
	t1 = ajit_barebones_clock();
	access_time_loop_instrs(TESTLENGTH*4);
	t2 = ajit_barebones_clock();
	t3 = t1 - t0- (NSWEEPS*(t2-t1));
	ee_printf("All misses: Time in ticks = %u\n",t3);
	
	t0 = ajit_barebones_clock();

	for(I = 0; I < NSWEEPS; I++)
	{
		test_2(cacheable_mem,TESTLENGTH*4);
	}
	t1 = ajit_barebones_clock();
	access_time_loop_instrs(TESTLENGTH*4);
	t2 = ajit_barebones_clock();
	t3 = t1 - t0- (NSWEEPS*(t2-t1));
	ee_printf("Only one miss: Time in ticks = %u\n",t3);
	
	ee_printf("done\n");
}


#include<stdio.h>
#include <stdint.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <math.h>

#define TESTLENGTH 256
#define NSWEEPS    16

// mapped to VA_DATA_SECTION_START  + 0x10000 for low mem
// mapped to VA_DATA_SECTION_START at 0x40040000 and above for high mem
uint64_t *cacheable_mem    = VA_DATA_SECTION_START+0x4000; 

float convertToSeconds(long ut)
{
	float result = (256.0/CLK_FREQUENCY)*((float)ut);
	return result;
}

int march_test (uint64_t* a, int length)
{
	int err = 0;
	uint64_t value;
	int i;
		for(i=0; i < length; i++)
		{
			*(a+i) = i;
			
		}
		for(i=0; i < length; i++)
		{
			value = a[i];
			if(value != i)
					err = 1;
		}
#ifdef EXPAND		
    for (i = 0; i < length; i++)
    {
		ee_printf("\t Value stored at location 0x%x is : %d\r\n",(a + i),i);
    }
#endif 
	return(err);
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
	int I, err;
	uint32_t t0 = ajit_barebones_clock();
	
	for(I = 0; I < NSWEEPS; I++)
	{
		err = march_test(cacheable_mem,TESTLENGTH*2);
		if(err)
		{
			ee_printf("Error cacheable\n");
		}
	}
	uint32_t t1 = ajit_barebones_clock();
	ee_printf("Cacheable: Time in ticks = %u\n",(t1 - t0));
	

	t0 = ajit_barebones_clock();
	for(I = 0; I < NSWEEPS; I++)
	{
		err = march_test(cacheable_mem,TESTLENGTH*4);
		if(err)
		{
			ee_printf("Error cacheable\n");
		}
	}
	t1 = ajit_barebones_clock();
	ee_printf("Cacheable: Time in ticks = %u\n",(t1 - t0));

	t0 = ajit_barebones_clock();
	for(I = 0; I < NSWEEPS; I++)
	{
		err = march_test(cacheable_mem,TESTLENGTH*8);
		if(err)
		{
			ee_printf("Error cacheable\n");
		}
	}
	t1 = ajit_barebones_clock();
	ee_printf("Cacheable: Time in ticks = %u\n",(t1 - t0));

	t0 = ajit_barebones_clock();
	for(I = 0; I < NSWEEPS; I++)
	{
		err = march_test(cacheable_mem,TESTLENGTH*16);
		if(err)
		{
			ee_printf("Error cacheable\n");
		}
	}
	t1 = ajit_barebones_clock();
	ee_printf("Cacheable: Time in ticks = %u\n",(t1 - t0));

	t0 = ajit_barebones_clock();
	for(I = 0; I < NSWEEPS; I++)
	{
		err = march_test(cacheable_mem,TESTLENGTH*24);
		if(err)
		{
			ee_printf("Error cacheable\n");
		}
	}
	t1 = ajit_barebones_clock();
	ee_printf("Cacheable: Time in ticks = %u\n",(t1 - t0));

	t0 = ajit_barebones_clock();
	for(I = 0; I < NSWEEPS; I++)
	{
		err = march_test(cacheable_mem,TESTLENGTH*32);
		if(err)
		{
			ee_printf("Error cacheable\n");
		}
	}
	t1 = ajit_barebones_clock();
	ee_printf("Cacheable: Time in ticks = %u\n",(t1 - t0));

	ee_printf("done\n");
}

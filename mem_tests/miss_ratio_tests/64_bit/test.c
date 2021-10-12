#include<stdio.h>
#include <stdint.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <math.h>


float convertToSeconds(long ut)
{
	float result = (256.0/CLK_FREQUENCY)*((float)ut);
	return result;
}

int test_1 (uint64_t* a, int length)
{
	int err = 0;
	uint32_t value;
	int i;
		for(i=0; i < length; i++)
		{
			*(a) = i;
			*(a+8192) = i;	
		}
#ifdef EXPAND		
    for (i = 0; i < length; i++)
    {
		ee_printf("\t Value stored at location 0x%x is : %d\r\n",(a + i),i);
    }
#endif 
	return(err);
}

int test_2 (uint64_t* a, int length)
{
	int err = 0;
	uint32_t value;
	int i;
		for(i=0; i < length; i++)
		{
			*(a) = i;
			*(a+1) = i;	
		}
#ifdef EXPAND		
    for (i = 0; i < length; i++)
    {
		ee_printf("\t Value stored at location 0x%x is : %d\r\n",(a + i),i);
    }
#endif 
	return(err);
}
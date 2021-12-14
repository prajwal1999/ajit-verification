#include<stdio.h>
#include <stdint.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <math.h>
#include <stdbool.h>

uint32_t prbs(uint32_t lfsr)
{
    bool bit;                    
    
	bit  = ((lfsr >> 31) ^ (lfsr >> 30) ^ (lfsr >> 25) ^ (lfsr >> 26) ) & 1;
    lfsr =  (lfsr >> 1) | (lfsr << 31) ;
	lfsr = lfsr * 4;
	lfsr = VA_DATA_SECTION_START | lfsr;
	lfsr = 0x7FFFFFFF & lfsr;
    return lfsr;
}

int access_time_loop_instrs(int length)
{
	int var,i;
	for(i=0; i < length; i++)
	{
        var = i;
    }
	return(1);
}

float convertToSeconds(long ut)
{
	float result = (256.0/CLK_FREQUENCY)*((float)ut);
	return result;
}

int test_1 (uint32_t* a, int length)
{
	int err = 0;
	uint32_t value;
	int i;
		for(i=0; i < length; i++)
		{
			if (i%2 == 0){
				*(a) = i;
			}
			else{
				*(a+8192) = i;
			}	
		}
}

int test_2 (uint32_t* a, int length)
{
	int err = 0;
	uint32_t value;
	int i;
		for(i=0; i < length; i++)
		{
			if (i%2 == 0){
				*(a) = i;
			}
			else{
				*(a+1) = i;
			}	
		}
}
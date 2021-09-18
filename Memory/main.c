#include <stdint.h>
#include <stdlib.h>
#include "ajit_access_routines.h"
#include "core_portme.h"
#include "math.h" 
#include <stdbool.h>
 
int run_test(int length, unsigned int* arr1, unsigned int* arr2, double* t);

int32_t prbs(int32_t lfsr)
{
    bool bit;    
	//bit  = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5) ) & 1;
    //lfsr =  (lfsr >> 1) | (bit << 12);
                
    
	bit  = ((lfsr >> 31) ^ (lfsr >> 30) ^ (lfsr >> 25) ^ (lfsr >> 26) ) & 1;
    lfsr =  (lfsr >> 1) | (lfsr << 31) ;
	//lfsr = 
    return lfsr;
}

//uint32_t* array_1 = 0x40044000; //index: 0x100
//uint32_t* array_2 = 0x40089000; //index: 0x040


int run_test(int length, unsigned int* arr1, unsigned int* arr2, double* t)
{
	int loads = 0;
	int status = 0;
	int i;int k=0;

	// initialize the memory arrays using some standard values
	// e.g. array_1[I] = 2*I
	//      array_2[I] = (2*I)+1 
	//
	for(i = 0; i < length; i++)
	{
		__ajit_store_word_mmu_bypass__((uint32_t) (2*i),(uint32_t) (arr1 + i));
		__ajit_store_word_mmu_bypass__((uint32_t) ((2*i)+1),(uint32_t) (arr2 + i));
	}

	uint64_t start_time  = __ajit_get_clock_time();					

	for(i = 0; i < length; i++)
	{
		uint32_t val1 = __ajit_load_word_mmu_bypass__((uint32_t) (arr1 + i));
		uint32_t val2 = __ajit_load_word_mmu_bypass__((uint32_t) (arr2 + i));

		// val1 must be even and val2 must be odd.
		status = !(((~val1) & 0x1) && (val2 & 0x1)) || status;
		if(!status)
		{
		}
	}
	uint64_t end_time  = __ajit_get_clock_time();					
	*t = ((double) (end_time - start_time)) * 1.0e-8;

	return(status);
}


int main()
{
	__ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    uint32_t start_state = 0x000A0001;  /* Any nonzero start state will work. */
    uint32_t lfsr = start_state;
	int i;
	lfsr = prbs(lfsr);
	unsigned int *array_1 = (unsigned int *) lfsr; //index: 0x000 
	//lfsr = prbs(lfsr);
	//unsigned int *array_2 = (unsigned int *) lfsr; //index: 0x040
	for(i=0; i<50; i++) {
        lfsr = prbs(lfsr);
        
		ee_printf("0x%X\n", lfsr);
    }

	
	//ee_printf("0x%X\n", array_2);
	/*
	ee_printf("Starting \n");
	int err = 0;
	int i;
	double t;

	// this should return a 0 on success.
	int status = run_test (256, array_1, array_2, &t);
	if(!status)
		ee_printf("Success! for 256 bypass loads, time elapsed is t=%f seconds\n", t);
	else
		ee_printf("Error: Failure! for 256 bypass loads, time elapsed is t=%f seconds\n", t);

	return(status);
	*/
	return(0);
}



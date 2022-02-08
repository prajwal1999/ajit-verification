#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>


int generate_input_output(int *results_section_ptr, int input_seed)
{
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    int lfsr_32 = input_seed;

    // ee_printf("inputs generation started. input seed is 0x%x\n", input_seed);
    char float_type_seed_1 = (lfsr_32 & 0x1f);
    char float_type_seed_2 = (lfsr_32 & 0xf8000000);
    int float_type_1 = 0, float_type_2 = 0;

    int i;
    for(i=0; i<N_INPUTS; i++) {
        float_type_seed_1 = prbs_5(float_type_seed_1);
        float_type_seed_2 = prbs_5(float_type_seed_2);
        lfsr_32 = prbs_32(lfsr_32);

        if(float_type_seed_1 < 23) float_type_1 = 0; // normal float value
        else if(float_type_seed_1 < 24) float_type_1 = 1; // zero float value
        else if(float_type_seed_1 < 28) float_type_1 = 2; // subnormal
        else if(float_type_seed_1 < 30) float_type_1 = 3; // infinity
        else float_type_1 = 4; // NAN

        if(float_type_seed_2 < 23) float_type_2 = 0; // normal float value
        else if(float_type_seed_2 < 24) float_type_2 = 1; // zero float value
        else if(float_type_seed_2 < 28) float_type_2 = 2; // subnormal
        else if(float_type_seed_2 < 30) float_type_2 = 3; // infinity
        else float_type_2 = 4; // NAN


        switch(float_type_1){
            case 0:
                while(1) {
                    int exp = (lfsr_32 & 0x7f800000) >> 23;
                    if(exp == 0 || exp == 255) lfsr_32 = prbs_32(lfsr_32);
                    else {
                        *(results_section_ptr + 8*i) = lfsr_32; // store 1st input
                        break;
                    }
                }
                break;
            case 1: *(results_section_ptr + 8*i) = (lfsr_32 & 0x80000000); break;
            case 2: *(results_section_ptr + 8*i) = (lfsr_32 & 0x807fffff); break;
            case 3: *(results_section_ptr + 8*i) = (lfsr_32 & 0x80000000) | 0x7f800000; break;
            case 4: *(results_section_ptr + 8*i) = (lfsr_32 | 0xffc00000); break;
        }

        lfsr_32 = prbs_32(lfsr_32);

        switch(float_type_2){
            case 0:
                while(1) {
                    int exp = (lfsr_32 & 0x7f800000) >> 23;
                    if(exp == 0 || exp == 255) lfsr_32 = prbs_32(lfsr_32);
                    else {
                        *(results_section_ptr + 8*i + 1) = lfsr_32; // store 1st input
                        break;
                    }
                }
                break;
            case 1: *(results_section_ptr + 8*i + 1) = (lfsr_32 & 0x80000000); break;
            case 2: *(results_section_ptr + 8*i + 1) = (lfsr_32 & 0x807fffff); break;
            case 3: *(results_section_ptr + 8*i + 1) = (lfsr_32 & 0x80000000) | 0x7f800000; break;
            case 4: *(results_section_ptr + 8*i + 1) = (lfsr_32 | 0xffc00000); break;
        }

        // ee_printf("i:%d - ft1 %d, ft2 %d\n", i+1, float_type_1, float_type_2);

        *(results_section_ptr + 8*i + 7) = 5*float_type_1 + float_type_2;
        lfsr_32 = prbs_32(lfsr_32);
    }

    ee_printf("--------------------Inputs Outputs Generated----------------------\n");

    return lfsr_32;

}



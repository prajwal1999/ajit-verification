/*#####################################################
Generate Input Pairs
Author : Prajwal Kamble
results_section_ptr - points to memory where inputs will be stored
input_seed - used to generate input pairs
number_of_inputs - number of pairs


results section structure
0           1           2           3           4           5           6           7           8           9           10
input_1_1   input_1_2   input_2_1   input_2_2   result_1    result_2    output_1_1  output_1_2  output_2_1  output_2_2  float_comb
#####################################################*/
#include <stdint.h>

uint64_t prbs_64(uint64_t x)
{
    x ^= x << 13;
	x ^= x >> 7;
	x ^= x << 17;
    return x;
}

void generate_input_output(int *results_section_ptr, uint64_t input_seed, uint64_t* new_input_pair_seed)
{

    uint64_t lfsr_64 = input_seed;

    // ee_printf("initial lfsr_64 - 0x%x %x\n", lfsr_64, lfsr_64);

/*
    Use last 5 bits to decide which type of float value to put in input 1
    Use last 5 bits to decide which type of float value to put in input 2
    #float_type     #float code     #probability of occurence
    normal          1               23/32
    zero            2               1/32
    subnormal       0               4/32
    infinity        3               2/32
    NAN             4               2/32
*/
    char float_type_seed_1 = (lfsr_64 & 0x1f);
    lfsr_64 = prbs_64(lfsr_64);
    char float_type_seed_2 = (lfsr_64 & 0x1f);

    int i;
    for(i=0; i<N_INPUTS; i++) {
        int float_type_1 = 0, float_type_2 = 0;
        float_type_seed_1 = prbs_5(float_type_seed_1);
        float_type_seed_2 = prbs_5(float_type_seed_2);
        lfsr_64 = prbs_64(lfsr_64);

        if(float_type_seed_1 < 23) float_type_1 = 1; // normal float value
        else if(float_type_seed_1 < 24) float_type_1 = 0; // subnormal
        else if(float_type_seed_1 < 28) float_type_1 = 2; // zero float value
        else if(float_type_seed_1 < 30) float_type_1 = 3; // infinity
        else float_type_1 = 4; // NAN

        if(float_type_seed_2 < 23) float_type_2 = 1; // normal float value
        else if(float_type_seed_2 < 24) float_type_2 = 0; // subnormal
        else if(float_type_seed_2 < 28) float_type_2 = 2; // zero float value
        else if(float_type_seed_2 < 30) float_type_2 = 3; // infinity
        else float_type_2 = 4; // NAN


        switch(float_type_1){
            int msb=0, lsb=0;
            case 1:
                while(1) {
                    int temp = (int)(lfsr_64 >> 32);
                    int exp = (temp & 0x7ff00000) >> 20;
                    if( (exp == 0) || (exp == 2047) ) lfsr_64 = prbs_64(lfsr_64);
                    else {
                        // store 1st input
                        results_section_ptr[16*i + 0] = ( (int)(lfsr_64 >> 32) & 0xffffffff);
                        results_section_ptr[16*i + 1] = (lfsr_64 & 0xffffffff); 
                        break;
                    }
                }
                break;
            case 0:
                msb = lfsr_64 >> 32;
                lsb = lfsr_64 & 0xffffffff;
                msb = msb & 0x800fffff; // make exp=0 
                results_section_ptr[16*i + 0] = msb;
                results_section_ptr[16*i + 1] = lsb;
                break;
            case 2: 
                msb = (lfsr_64 >> 32) & 0x80000000;
                results_section_ptr[16*i + 0] = msb;
                results_section_ptr[16*i + 1] = 0x0;
                break;
            case 3: 
                msb = (lfsr_64 >> 32) | 0x7ff00000;
                results_section_ptr[16*i + 0] = msb & 0xfff00000;
                results_section_ptr[16*i + 1] = 0x00000000; 
                break;
            case 4: 
                msb = (lfsr_64 >> 32) | 0x7ff00000;
                results_section_ptr[16*i + 0] = msb;
                results_section_ptr[16*i + 1] = (lfsr_64 & 0xffffffff);
                break;
        }

        // ee_printf("float type is - %d, ", float_type_1);
        // ee_printf("inputs is = 0x%x%x\n", results_section_ptr[16*i + 0], results_section_ptr[16*i + 1]);

        lfsr_64 = prbs_64(lfsr_64);

        switch(float_type_2){
            int msb=0, lsb=0;
            case 1:
                while(1) {
                    int temp = lfsr_64 >> 32;
                    uint64_t exp = (temp & 0x7ff00000) >> 20;
                    if( (exp == 0) || (exp == 2047) ) lfsr_64 = prbs_64(lfsr_64);
                    else {
                        // store 1st input
                        results_section_ptr[16*i + 2] = ( (lfsr_64 >> 32) & 0xffffffff);
                        results_section_ptr[16*i + 3] = (lfsr_64 & 0xffffffff); 
                        break;
                    }
                }
                break;
            case 0: 
                msb = lfsr_64 >> 32;
                lsb = lfsr_64 & 0xffffffff;
                msb = msb & 0x800fffff; // make exp=0 
                results_section_ptr[16*i + 2] = msb;
                results_section_ptr[16*i + 3] = lsb;
                break;
            case 2: 
                msb = (lfsr_64 >> 32) & 0x80000000;
                results_section_ptr[16*i + 2] = msb;
                results_section_ptr[16*i + 3] = 0x0;
                break;
            case 3: 
                msb = (lfsr_64 >> 32) | 0x7ff00000;
                results_section_ptr[16*i + 2] = msb & 0xfff00000;
                results_section_ptr[16*i + 3] = 0x00000000; 
                break;
            case 4: 
                msb = (lfsr_64 >> 32) | 0x7ff00000;
                results_section_ptr[16*i + 2] = msb;
                results_section_ptr[16*i + 3] = (lfsr_64 & 0xffffffff);
                break;
        }

        results_section_ptr[16*i + 10] = 5*float_type_1 + float_type_2; // store combination of both floating types 
        lfsr_64 = prbs_64(lfsr_64);

        // results_section_ptr[16*i + 0] = 0x967f1589;
        // results_section_ptr[16*i + 1] = 0xf81577ce;
        // results_section_ptr[16*i + 2] = 0x973badbc;
        // results_section_ptr[16*i + 3] = 0x7b168e52;
    }

    // return lfsr_64;
    *new_input_pair_seed = lfsr_64;

}



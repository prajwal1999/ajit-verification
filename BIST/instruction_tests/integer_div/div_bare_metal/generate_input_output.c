#include <stdint.h>
#include <stdbool.h>

uint64_t prbs_64(int64_t x)
{
    x ^= x << 13;
	x ^= x >> 7;
	x ^= x << 17;
    return x;
}


void generate_input_output(int *results_section, int64_t input_seed, int64_t* new_input_pair_seed)
{	    
    int i;
    for(i=0; i<N_INPUTS; i++) {
        input_seed = prbs_64(input_seed);
        results_section[8*i + 0] = ( (input_seed >> 32) & 0xffffffff);
        results_section[8*i + 1] = (input_seed & 0xffffffff);

        bool is_imm = ((input_seed & 0xf) == 1);
        input_seed = prbs_64(input_seed);
        int temp = input_seed & 0xffffffff;
        results_section[8*i + 3] = is_imm;
        if(is_imm) {
            temp = input_seed & 0x1fff;
            if(temp >> 12 == 1) temp |= 0xffffe000;
        }
        results_section[8*i + 2] = temp;
    }

    *new_input_pair_seed = input_seed;

    ee_printf("------------------------------------------------------\n");
}


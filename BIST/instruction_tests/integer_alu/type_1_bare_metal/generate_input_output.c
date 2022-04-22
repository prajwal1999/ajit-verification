#include <stdint.h>
#include <stdbool.h>


uint32_t prbs_32(uint32_t x)
{
    x ^= x << 13;
	x ^= x >> 17;
	x ^= x << 5;
    return x;
}

int generate_input_output(int *results_section, int input_seed, int* imm_count)
{	
    int lfsr = input_seed;
    
    int i;
    for(i=0; i<N_INPUTS; i++) {
        lfsr = prbs_32(lfsr);
        results_section[8*i + 0] = lfsr;

        bool is_imm = ((lfsr & 0xf) == 1);
        lfsr = prbs_32(lfsr);
        int temp = lfsr;
        if(is_imm) {
            (*imm_count)++;
            temp &= 0x1fff;
            if(temp >> 12 == 1) temp |= 0xffffe000;
        }

        results_section[8*i + 1] = temp;
        results_section[8*i + 2] = is_imm;
        lfsr = prbs_32(lfsr);
        results_section[8*i + 6] = lfsr; // for addx instruction to generate carry
        lfsr = prbs_32(lfsr);
        results_section[8*i + 7] = lfsr; // // for addx instruction to generate carry
    }
    
    // ee_printf("--------------------Inputs Outputs Generated----------------------\n");

    return lfsr;
}


/*#####################################################
Generate Input Pairs
Author : Prajwal Kamble
results_section_ptr - points to memory where inputs will be stored
input_seed - used to generate input pairs
number_of_inputs - number of pairs


results section structure
0           1           2               3           4           5           6           7
input_1     input_2     initial_fsr     later_fsr   result      output_1    output_2    float_comb
#####################################################*/

int generate_input_output(int *results_section_ptr, int input_seed, 
                            int float_type_1, int float_type_2)
{

    int lfsr_32 = input_seed;

/*
    Use last 5 bits to decide which type of float value to put in input 1
    Use first 5 bits to decide which type of float value to put in input 2
    #float_type     #float code     #probability of occurence
    normal          1               23/32
    zero            2               1/32
    subnormal       0               4/32
    infinity        3               2/32
    NAN             4               2/32
*/
    char float_type_seed_1 = (lfsr_32 & 0x1f);
    lfsr_32 = prbs_32(lfsr_32);
    char float_type_seed_2 = (lfsr_32 & 0x1f);

    int i;
    for(i=0; i<N_INPUTS; i++) {
        // int float_type_1 = 0, float_type_2 = 0;
        // float_type_seed_1 = prbs_5(float_type_seed_1);
        // float_type_seed_2 = prbs_5(float_type_seed_2);
        lfsr_32 = prbs_32(lfsr_32);

        // if(float_type_seed_1 < 23) float_type_1 = 1; // normal float value
        // else if(float_type_seed_1 < 24) float_type_1 = 2; // zero float value
        // else if(float_type_seed_1 < 28) float_type_1 = 0; // subnormal
        // else if(float_type_seed_1 < 30) float_type_1 = 3; // infinity
        // else float_type_1 = 4; // NAN

        // if(float_type_seed_2 < 23) float_type_2 = 1; // normal float value
        // else if(float_type_seed_2 < 24) float_type_2 = 2; // zero float value
        // else if(float_type_seed_2 < 28) float_type_2 = 0; // subnormal
        // else if(float_type_seed_2 < 30) float_type_2 = 3; // infinity
        // else float_type_2 = 4; // NAN


        switch(float_type_1){
            case 1:
                while(1) {
                    int exp = (lfsr_32 & 0x7f800000) >> 23;
                    if( (exp == 0) || (exp == 255) ) lfsr_32 = prbs_32(lfsr_32);
                    else {
                        results_section_ptr[8*i] = lfsr_32; // store 1st input
                        break;
                    }
                }
                break;
            case 0: results_section_ptr[8*i] = (lfsr_32 & 0x807fffff); break;
            case 2: results_section_ptr[8*i] = (lfsr_32 & 0x80000000); break;
            case 3: results_section_ptr[8*i] = (lfsr_32 & 0x80000000) | 0x7f800000; break;
            case 4: results_section_ptr[8*i] = (lfsr_32 | 0x7f800000); break;
        }

        lfsr_32 = prbs_32(lfsr_32);

        switch(float_type_2){
            case 1:
                while(1) {
                    int exp = (lfsr_32 & 0x7f800000) >> 23;
                    if(exp == 0 || exp == 255) lfsr_32 = prbs_32(lfsr_32);
                    else {
                        results_section_ptr[8*i + 1] = lfsr_32; // store 1st input
                        break;
                    }
                }
                break;
            case 0: results_section_ptr[8*i + 1] = (lfsr_32 & 0x807fffff); break;
            case 2: results_section_ptr[8*i + 1] = (lfsr_32 & 0x80000000); break;
            case 3: results_section_ptr[8*i + 1] = (lfsr_32 & 0x80000000) | 0x7f800000; break;
            case 4: results_section_ptr[8*i + 1] = (lfsr_32 | 0x7f800000); break;
        }

        results_section_ptr[8*i + 7] = 5*float_type_1 + float_type_2; // store combination of both floating types 
        lfsr_32 = prbs_32(lfsr_32);
    }

    return lfsr_32;

}



#include <stdint.h>
#include <stdbool.h>


int checker(int *results_section) {

    int i;
    int n_correct_tests = 0;

    for(i=0; i<N_INPUTS; i++) {
        int input_1_1 = results_section[8*i + 0];
        int input_1_2 = results_section[8*i + 1];
        uint64_t input_1 = (((uint64_t)input_1_1) << 32) + ((uint64_t)input_1_2 & 0xffffffff);
        int input_2_1 = results_section[8*i + 2];
        int input_2_2 = results_section[8*i + 3];
        uint64_t input_2 = (((uint64_t)input_2_1) << 32) + ((uint64_t)input_2_2 & 0xffffffff);

        int ajit_result_1 = results_section[8*i + 4];
        int ajit_result_2 = results_section[8*i + 5];
        uint64_t ajit_result = (((uint64_t)ajit_result_1) << 32) + ((uint64_t)ajit_result_2 & 0xffffffff);

        int Cmodel_result_1 = results_section[8*i + 6];
        int Cmodel_result_2 = results_section[8*i + 7];
        uint64_t Cmodel_result = (((uint64_t)Cmodel_result_1) << 32) + ((uint64_t)Cmodel_result_2 & 0xffffffff);

        char test_failed = 0;
         
        int64_t diff = abs(ajit_result - Cmodel_result);
        if(is_machine_eps_64_or_zero(diff)) n_correct_tests++;
        else test_failed = 1; 

        if(test_failed) {
            ee_printf("Test failed - %d/%d\n", i+1, N_INPUTS);
            ee_printf("Inputs are %x %x, ", input_1_1, input_1_2);
            ee_printf("%x %x\n", input_2_1, input_2_2);

            ee_printf("Ajit result %x %x\n", ajit_result_1, ajit_result_2);
            ee_printf("Cmodel result %x %x\n", Cmodel_result_1, Cmodel_result_2);
            ee_printf("####################################################\n\n");
            // __asm__ __volatile__ (" ta 0 \n\t");
            // __asm__ __volatile__ (" nop \n\t");
        } else {
            // ee_printf("Test passed - %d/%d\n", i+1, N_INPUTS);
            // ee_printf("Inputs are %x %x, ", input_1_1, input_1_2);
            // ee_printf("%x %x\n", input_2_1, input_2_2);

            // ee_printf("Ajit result %x %x\n", ajit_result_1, ajit_result_2);
            // ee_printf("Cmodel result %x %x\n", Cmodel_result_1, Cmodel_result_2);
            // ee_printf("####################################################\n\n");
        }

    }   

    if( n_correct_tests == N_INPUTS) {
        ee_printf("all tests passed\n");    
    } else {
        ee_printf("%d out of %d tests passed\n", n_correct_tests, N_INPUTS);    
        __asm__ __volatile__ (" ta 0 \n\t");
        __asm__ __volatile__ (" nop \n\t");
    }

    __asm__ __volatile__ (" ta 0 \n\t");
    __asm__ __volatile__ (" nop \n\t");

    return(0);
}
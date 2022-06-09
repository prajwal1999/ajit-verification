#include <stdint.h>
#include <stdbool.h>


int checker(int *results_section) {

    int i;
    int n_correct_tests = 0;

    for(i=0; i<N_INPUTS; i++) {
        int input_1 = results_section[4*i + 0];
        int input_2 = results_section[4*i + 1];

        int ajit_result = results_section[4*i + 2];

        int Cmodel_result = results_section[4*i + 3];

        char test_failed = 0;
         
        int diff = abs(ajit_result - Cmodel_result);
        if(is_machine_eps_32_or_zero(diff)) n_correct_tests++;
        else test_failed = 1; 

        if(test_failed) {
            ee_printf("Test failed - %d/%d\n", i+1, N_INPUTS);
            ee_printf("Inputs are %x, %x\n", input_1, input_2);

            ee_printf("Ajit result %x\n", ajit_result);
            ee_printf("Cmodel result %x\n", Cmodel_result);
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
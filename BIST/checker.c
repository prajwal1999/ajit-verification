#include<stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"

int checker(int *results_section_ptr, int no_of_inputs, int *instr_section, int no_of_instrs) {
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    ee_printf("------------------------Starting tests-------------------\n");

    int i,j;
    int instr;

    for (i=0; i<no_of_instrs; i++) {
        instr = *(instr_section + 3+7*i) ;
        instr = (instr >> 19) & 0x3F;
        
        if (instr == 0x00 || instr == 0x04 || instr == 0x0A || instr == 0x0E){
            for(j=0; j<2; j++) {
                if(*(results_section_ptr + 2*i+j) != *(results_section_ptr + no_of_inputs+2*i+j)){
                    ee_printf("Test failed - %d/%d\n", j+1, no_of_instrs);
                    __asm__ __volatile__( " ta 0 \n\t " );
                }
                else{
                    ee_printf("Test ran successfuuly - %d/%d\n", j+1, no_of_instrs);
                }
            }
        }

    }


    
    return(0);
}
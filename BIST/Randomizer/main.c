#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdbool.h>
#include <stdint.h>


int16_t prbs(int16_t lfsr)
{
    bool bit;
    bit  = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5) ) & 1;
    lfsr =  (lfsr >> 1) | (bit << 12);
    return lfsr;
}



struct Instruction {
    char mnemonic[10];
    unsigned char opcode;
    unsigned char reverse_opcode;
};

char instr_types[4][15] = {"branch", "logical", "arithmetic", "load_store"};


int main() {
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);
    int min_n_instrs = 10; 
    int16_t lfsr = 0xd136;

    int i=0;
    while(i < min_n_instrs) {
        lfsr = prbs(lfsr);
        int16_t instr_type_key = lfsr & 7;

        if(instr_type_key==0 || instr_type_key==4 || instr_type_key==5 || instr_type_key==0xb || instr_type_key==0xe || instr_type_key==0xf) 
        {
            ee_printf("logical\n");
        } 
        else if(instr_type_key==1 || instr_type_key==3 || instr_type_key==7 || instr_type_key==0xa || instr_type_key==0xc || instr_type_key==0xd)
        {
            ee_printf("arithmetic\n");
        }
        else if(instr_type_key==2 || instr_type_key==6 || instr_type_key==8) {
            ee_printf("load_store\n");
        } 
        else if(instr_type_key==9) {
            ee_printf("branch\n");
        }
        i++;
    }


    return(1);
}
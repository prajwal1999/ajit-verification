#include<stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include "instr_select.h"

char instr_sel(uint random_no)
{
    
    if (random_no == 0){
        return 0x00;
    }
    else if (random_no == 1) {
        return 0x04;
    }
    else if (random_no == 2){
        return 0x0A;
    }
    else if (random_no == 3){
        return 0x0E;
    }
}

char bring_complement_instr(char instr)
{
    if (instr == 0x00){
        return 0x04;
    }
    else if (instr == 0x04){
        return 0x00;
    }
    else if (instr == 0x0E){
        return 0x0A;
    }
    else if (instr == 0x0A){
        return 0x0E;
    }
}
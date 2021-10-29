#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>


int print_coverage(int *register_coverage_ptr, int *data_coverage_ptr, int inputs_seed, int register_seed )
{
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE );

    ee_printf("\n");
    ee_printf(">>> Coverage for Instruction with opcode 0x%x\n", INSTR_OP);
    ee_printf(">>> Inputs seed is %d\n", inputs_seed);
    ee_printf(">>> Register seed is %d\n", register_seed);
    // print register coverage
    int i;
    ee_printf(">>> Register Coverage\n");
    for(i=0; i<32; i++) {
        ee_printf(">>> r%d --- rs1 - %d, rs2 - %d, rd - %d\n", i, *(register_coverage_ptr + i*3), *(register_coverage_ptr + i*3 + 1), *(register_coverage_ptr + i*3 + 2));
    }

    ee_printf("\n");
    // print data grid
    int grids_in_row = 1 << (32-GRID_DIM);
    int j;
    ee_printf(">>> Data Grid\n");
    for(i=0; i<grids_in_row; i++) {
        ee_printf(">>> ");
        for(j=0; j<grids_in_row; j++) {
            ee_printf("%d   ", *(data_coverage_ptr + i*grids_in_row + j));
        }
        ee_printf("\n");
    }

    ee_printf("\n");

    return 0;
}
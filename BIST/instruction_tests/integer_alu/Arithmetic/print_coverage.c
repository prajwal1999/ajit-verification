#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>


int print_coverage(int *register_coverage, int *data_coverage, int *ccr_coverage)
{
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    ee_printf("\n");
    // print register coverage
    int i;
    ee_printf(">>> Register Coverage\n");
    for(i=0; i<8; i++) {
        ee_printf(">>> l%d --- rs1 - %d, rs2 - %d, rd - %d\n", i, *(register_coverage + i*3), *(register_coverage + i*3 + 1), *(register_coverage + i*3 + 2));
    }

    ee_printf("\n");
    // print data grid
    int grids_in_row = 1 << (32-GRID_DIM);
    int j;
    ee_printf(">>> Data Grid\n");
    for(i=0; i<grids_in_row; i++) {
        ee_printf(">>> ");
        for(j=0; j<grids_in_row; j++) {
            ee_printf("%d   ", *(data_coverage + i*grids_in_row + j));
        }
        ee_printf("\n");
    }

    ee_printf("\n");
    // print ccr codes
    // print n grid
    ee_printf(">>> n Grid\n");
    for(i=0; i<grids_in_row; i++) {
        ee_printf(">>> ");
        for(j=0; j<grids_in_row; j++) {
            ee_printf("%d   ", *(ccr_coverage + i*grids_in_row*4 + 4*j));
        }
        ee_printf("\n");
    }

    ee_printf("\n");
    // print z grid
    ee_printf(">>> z Grid\n");
    for(i=0; i<grids_in_row; i++) {
        ee_printf(">>> ");
        for(j=0; j<grids_in_row; j++) {
            ee_printf("%d   ", *(ccr_coverage + i*grids_in_row*4 + 4*j + 1));
        }
        ee_printf("\n");
    }

    ee_printf("\n");
    // print v grid
    ee_printf(">>> v Grid\n");
    for(i=0; i<grids_in_row; i++) {
        ee_printf(">>> ");
        for(j=0; j<grids_in_row; j++) {
            ee_printf("%d   ", *(ccr_coverage + i*grids_in_row*4 + 4*j + 2));
        }
        ee_printf("\n");
    }

    ee_printf("\n");
    // print c grid
    ee_printf(">>> c Grid\n");
    for(i=0; i<grids_in_row; i++) {
        ee_printf(">>> ");
        for(j=0; j<grids_in_row; j++) {
            ee_printf("%d   ", *(ccr_coverage + i*grids_in_row*4 + 4*j + + 3));
        }
        ee_printf("\n");
    }

    return(1);
}
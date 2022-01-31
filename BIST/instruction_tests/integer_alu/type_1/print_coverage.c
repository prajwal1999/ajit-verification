#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>


int print_coverage(int *register_coverage_ptr, int *data_coverage_ptr, int inputs_seed, int register_seed, int instr_opcode )
{
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE );

    // print register coverage
    int i;
    unsigned int lowest_reg_test_count_rs1 = 1 << 31;
    unsigned int lowest_reg_test_count_rs2 = 1 << 31;
    unsigned int lowest_reg_test_count_rd = 1 << 31;
    unsigned int lowest_reg_test_count_ldst = 1 << 31;
    // ee_printf(">>> Register Coverage\n");
    for(i=0; i<32; i++) {
        if(i==0) continue; // g0 register not used
        if(*(register_coverage_ptr + i*4) < lowest_reg_test_count_rs1) lowest_reg_test_count_rs1 = *(register_coverage_ptr + i*4);
        if(*(register_coverage_ptr + i*4 + 1) < lowest_reg_test_count_rs2) lowest_reg_test_count_rs2 = *(register_coverage_ptr + i*4 + 1);
        if(*(register_coverage_ptr + i*4 + 2) < lowest_reg_test_count_rd) lowest_reg_test_count_rd = *(register_coverage_ptr + i*4 + 2);
        if(*(register_coverage_ptr + i*4 + 3) < lowest_reg_test_count_ldst) lowest_reg_test_count_ldst = *(register_coverage_ptr + i*4 + 3);
        
        ee_printf(">>> r%d --- rs1 - %d, rs2 - %d, rd - %d, ld_st - %d\n", i, *(register_coverage_ptr + i*4), *(register_coverage_ptr + i*4 + 1), *(register_coverage_ptr + i*4 + 2), *(register_coverage_ptr + i*4 + 3));
    }

    // ee_printf("\n");
    // print data grid
    int grids_in_row = 1 << (32-GRID_DIM);
    int j;
    unsigned int lowest_count_in_grid = 1 << 31;
    // ee_printf(">>> Data Grid\n");
    for(i=0; i<grids_in_row; i++) {
        // ee_printf(">>> ");
        for(j=0; j<grids_in_row; j++) {
            if(*(data_coverage_ptr + i*grids_in_row + j) < lowest_count_in_grid) lowest_count_in_grid = *(data_coverage_ptr + i*grids_in_row + j);
            // ee_printf("%d   ", *(data_coverage_ptr + i*grids_in_row + j));
        }
        // ee_printf("\n");
    }

    int grid_count_threshold = 1000;
    if(
        lowest_count_in_grid >= grid_count_threshold
    ) {
        ee_printf("\n");
        ee_printf(">>> Coverage for Instruction with opcode 0x%x\n", instr_opcode);
        ee_printf(">>> all registers except g0, acted as rs1 atleast %d times \n", lowest_reg_test_count_rs1);
        ee_printf(">>> all registers except g0, acted as rs2 atleast %d times \n", lowest_reg_test_count_rs2);
        ee_printf(">>> all registers except g0, acted as rd atleast %d times \n", lowest_reg_test_count_rd);
        ee_printf(">>> all grids covered atleast %d times \n", grid_count_threshold);
        return true;
        // ee_printf(">>> Inputs seed is %d\n", inputs_seed);
        // ee_printf(">>> Register seed is %d\n", register_seed);
    }
    else {
        return false;
    }

}
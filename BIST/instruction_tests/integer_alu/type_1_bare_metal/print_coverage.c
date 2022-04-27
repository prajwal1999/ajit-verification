#include <math.h>
#include <stdbool.h>

bool print_coverage(int *register_coverage, int *data_coverage, int instr_opcode )
{

    // print register coverage
    int i;
    unsigned int lowest_reg_test_count_rs1 = 0x7fffffff;
    unsigned int lowest_reg_test_count_rs2 = 0x7fffffff;
    unsigned int lowest_reg_test_count_rd = 0x7fffffff;
    unsigned int lowest_reg_test_count_ldst = 0x7fffffff;

    for(i=0; i<32; i++) {
        if(i==0) continue; // g0 register not used
        lowest_reg_test_count_rs1 = min(lowest_reg_test_count_rs1, register_coverage[4*i + 0]);
        lowest_reg_test_count_rs2 = min(lowest_reg_test_count_rs2, register_coverage[4*i + 1]);
        lowest_reg_test_count_rd = min(lowest_reg_test_count_rd, register_coverage[4*i + 2]);
        lowest_reg_test_count_ldst = min(lowest_reg_test_count_ldst, register_coverage[4*i + 3]);
    }

    // print data grid
    // ee_printf("Grid Printing\n");
    int grids_in_row = 1 << (32-GRID_DIM);
    int j;
    unsigned int lowest_count_in_grid = 0x7fffffff;
    for(i=0; i<grids_in_row; i++) {
        for(j=0; j<grids_in_row; j++) {
            lowest_count_in_grid = min(lowest_count_in_grid, *(data_coverage + i*grids_in_row + j) );
        }
    }

    
    ee_printf(">>> Lowest count in grid is %u (just for debugging)\n", (unsigned int)lowest_count_in_grid);


    int grid_count_threshold = 1000;
    if(lowest_count_in_grid >= grid_count_threshold) {
        ee_printf("\n");
        ee_printf(">>> Coverage for Instruction with opcode 0x%x\n", instr_opcode);
        ee_printf(">>> all registers except g0, acted as rs1 atleast %d times \n", lowest_reg_test_count_rs1);
        ee_printf(">>> all registers except g0, acted as rs2 atleast %d times \n", lowest_reg_test_count_rs2);
        ee_printf(">>> all registers except g0, acted as rd atleast %d times \n", lowest_reg_test_count_rd);
        ee_printf(">>> all grids covered atleast %d times \n", grid_count_threshold);
        return true;
    }
    else {
        return false;
    }
}

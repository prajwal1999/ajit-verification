#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdbool.h>

// void print(int in1, int in2, int out) {
//     __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

//     ee_printf("Input 1 is - 0x%x, Input 1 is - 0x%x\n", in1, in2);
//     ee_printf("Output is - 0x%x", out);
// }

void print(int* test_program) {
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE);

    ee_printf("Input 1 is - 0x%x, Input 2 is - 0x%x\n", *test_program, *(test_program+1));
    ee_printf("Result is - 0x%x\n", *(test_program+2));
    ee_printf("Output 1 is - 0x%x, Output 2 is - 0x%x\n", *(test_program+3), *(test_program+4));
}


void print2() {
    ee_printf("Trapped didn't occur\n");
}
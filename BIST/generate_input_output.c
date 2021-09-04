#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"

int generate_input_output() {
    int inp_out[6] = {0x100, 0x200, 0, 1, 0x200, 0x100};
    // ee_printf("generate_inputs_outputs file\n");
    return(inp_out);
}

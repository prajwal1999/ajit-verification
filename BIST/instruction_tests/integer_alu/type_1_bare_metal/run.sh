#!/usr/bin/env bash
AAR=$AJIT_ACCESS_ROUTINES_MT
PT=$AJIT_MINIMAL_PRINTF_TIMER
TEXTBASE=0x40000000
DATABASE=0x40020000
# TEXTBASE=0x0
# DATABASE=0xf0000
CLKFREQ=80000000


n_inputs=1000
grid_dim=26

clear
sh clean.sh
makeLinkerScript.py -t $TEXTBASE -d $DATABASE -o customLinkerScript.lnk

compileToSparcUclibc.py -N main -V high_vmap.txt -W ./ \
                -D AJIT -D VA_DATA_SECTION_START=$DATABASE -D CLK_FREQUENCY=$CLKFREQ -D N_INPUTS=$n_inputs -D GRID_DIM=$grid_dim -U \
                -s init.s -s trap_handlers.s  \
                -c generate_instr.c -c main.c -c helper.c \
                -c generate_input_output.c -c checker.c -c print_coverage.c \
                -L customLinkerScript.lnk \
                -I $AJIT_UCLIBC_HEADERS_DIR -I $AAR/include -C $AAR/src -I $PT/include -C $PT/src -g 
                

ajit_C_system_model -m main.mmap -w main.reg -u 64 -d -r main.results -l main.log -w main.trace -q 22
# ajit_C_system_model -m main.mmap -g -p 8888



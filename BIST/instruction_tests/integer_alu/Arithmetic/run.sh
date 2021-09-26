#!/usr/bin/env bash
AAR=$AJIT_ACCESS_ROUTINES_MT
PT=$AJIT_MINIMAL_PRINTF_TIMER
# TEXTBASE=0x40000000
# DATABASE=0x40040000
TEXTBASE=0x0
DATABASE=0x40000000
CLKFREQ=80000000

clear
sh clean.sh
genVmapAsm low_vmap.txt setup_page_table.s
makeLinkerScript.py -t $TEXTBASE -d $DATABASE -o customLinkerScript.lnk

echo $grid_dim
compileToSparcUclibc.py -N main -W ./ -D AJIT -D VA_DATA_SECTION_START=$DATABASE -D CLK_FREQUENCY=$CLKFREQ -D N_INPUTS=10 -D Imm=0 -D GRID_DIM=29 -U \
                -s init.s -s trap_handlers.s -s setup_page_table.s \
                -c add/add.c \
                -c generate_input_output.c -c checker.c -c print_coverage.c \
                -L customLinkerScript.lnk \
                -I $AJIT_UCLIBC_HEADERS_DIR -I $AAR/include -C $AAR/src -I $PT/include -C $PT/src
                

ajit_C_system_model -m main.mmap -w -u 64 -d -r main.results -l main.log -w main.trace
# ajit_C_system_model -m main.mmap


# -c generate_input_output.c -c main.c -c checker.c

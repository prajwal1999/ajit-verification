#!/usr/bin/env bash
AAR=$AJIT_ACCESS_ROUTINES_MT
PT=$AJIT_MINIMAL_PRINTF_TIMER
TEXTBASE=0x40000000
DATABASE=0x4001e000
CLKFREQ=80000000


n_inputs=1000
grid_dim=26

clear
sh clean.sh
makeLinkerScript.py -t $TEXTBASE -d $DATABASE -o customLinkerScript.lnk

compileToSparcUclibc.py -N main -V high_vmap.txt -W ./ \
                -D AJIT -D VA_DATA_SECTION_START=$DATABASE -D CLK_FREQUENCY=$CLKFREQ  -D N_INPUTS=$n_inputs -D GRID_DIM=$grid_dim -U \
                -s init.s -s trap_handlers.s  \
                -c generate_instr.c -c main.c -c helper.c \
                -c generate_input_output.c -c flush_mem.c \
                -c checker_add_sub.c \
                -c checker_mul.c \
                -c checker_div.c \
                -c checker_sqrt.c\
                -L customLinkerScript.lnk \
                -I $AJIT_UCLIBC_HEADERS_DIR -I $AAR/include -C $AAR/src -I $PT/include -C $PT/src -g 
                
# -c checker_add_sub.c -c checker_div.c -c checker_fmovs_fnegs_fabss.c -c checker_mul.c -c checker_sqrt.c

ajit_C_system_model -m main.mmap -w main.reg -u 64 -d -r main.results -l main.log -w main.trace -q 22
# ajit_C_system_model -m main.mmap -g -p 8888


#!/usr/bin/env bash
AAR=$AJIT_ACCESS_ROUTINES_MT
PT=$AJIT_MINIMAL_PRINTF_TIMER
CLKFREQ=80000000

genVmapAsm vmap.txt setup_page_table.s
makeLinkerScript.py -t 0x0 -d 0x40000 -o customLinkerScript.lnk
compileToSparcUclibc.py -N main -W ./ -D AJIT -D CLK_FREQUENCY=$CLKFREQ -U \
                -s init.s -c generate_input_output.c -c main.c -c checker.c -c instr_sel.c -s trap_handlers.s -s setup_page_table.s \
                -L customLinkerScript.lnk \
                -I $AJIT_UCLIBC_HEADERS_DIR -I $AAR/include -C $AAR/src -I $PT/include -C $PT/src
ajit_C_system_model -m main.mmap -w -u 64 -d -r main.results -l main.log -w main.trace
# ajit_C_system_model -m main.mmap
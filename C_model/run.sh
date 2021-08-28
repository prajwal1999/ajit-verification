#!/usr/bin/env bash
AAR=$AJIT_ACCESS_ROUTINES_MT
PT=$AJIT_MINIMAL_PRINTF_TIMER
CLKFREQ=80000000

genVmapAsm vmap.txt setup_page_table.s
makeLinkerScript.py -t 0x3000 -d 0xf000 -o customLinkerScript.lnk
compileToSparcUclibc.py -N main -W ./ -D AJIT -D CLK_FREQUENCY=$CLKFREQ -U \
                -s init.s -s main.s -s data.s -s trap_handlers.s -s setup_page_table.s \
                -L customLinkerScript.lnk \
                -I $AJIT_UCLIBC_HEADERS_DIR -I $AAR/include -I $PT/include \
                -c serial.c
python3.6 generate_results_file.py
ajit_C_system_model -m main.mmap -w -u 64 -d -r main.results -l main.log -w main.trace



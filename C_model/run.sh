#!/usr/bin/env bash
AAR=$AJIT_ACCESS_ROUTINES_MT
PT=$AJIT_MINIMAL_PRINTF_TIMER
CLKFREQ=80000000

genVmapAsm vmap.txt setup_page_table.s
makeLinkerScript.py -t 0x0 -d 0x8000 -o customLinkerScript.lnk
compileToSparcUclibc.py -N main -W ./ -D AJIT -D CLK_FREQUENCY=$CLKFREQ -U \
                -s init.s -s main.s -s data.s -s trap_handlers.s -s setup_page_table.s \
                -L customLinkerScript.lnk \
                -I $AJIT_UCLIBC_HEADERS_DIR -I $AAR/include -I $PT/include \
                -c serial.c
python3.6 generate_results_file.py
ajit_C_system_model -m main.mmap -w -u 64 -d -r main.results -l main.log -w main.trace






# g0=0x0
# g1=0x0
# g2=0x0
# g3=0x0
# g4=0x0
# g5=0x0
# g6=0x0
# g7=0x0
# o0=0x0
# o1=0x0
# o2=0x0
# o3=0x0
# o4=0x0
# o5=0x0
# o6=0x0
# o7=0x0
# l0=0x0
# l1=0x0
# l2=0x0
# l3=0x0
# l4=0x0
# l5=0x0
# l6=0x0
# l7=0x0
# i0=0x0
# i1=0x0
# i2=0x0
# i3=0x0
# i4=0x0
# i5=0x0
# i6=0x0
# i7=0x0

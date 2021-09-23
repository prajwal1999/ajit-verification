#!/usr/bin/env bash

if [ $# -ne 3 ];
    then echo "specify memory locations of text, data sections and vmap file"
	echo "eg: ./run.sh 0x40000000 0x40040000 VMAPHIGH.txt"
	echo "or ./run.sh 0x0 0x40000000 VMAPLOW.txt"

    exit 1
fi 
AAR=$AJIT_ACCESS_ROUTINES_MT
PT=$AJIT_MINIMAL_PRINTF_TIMER
CLKFREQ=80000000
TEXTBASE=$1
DATABASE=$2
VMAP=$3
genVmapAsm vmap.txt setup_page_table.s
makeLinkerScript.py -t $TEXTBASE -d $DATABASE -o customLinkerScript.lnk
compileToSparcUclibc.py -N main  -W ./ -D AJIT -D CLK_FREQUENCY=$CLKFREQ -U \
                -s init.s -c main.c -s trap_handlers.s -s setup_page_table.s \
                -L customLinkerScript.lnk \
                -I $AJIT_UCLIBC_HEADERS_DIR -I $AAR/include -C $AAR/src -I $PT/include -C $PT/src 
ajit_C_system_model -m main.mmap -w -u 64 -d -r main.results -l main.log -w main.trace
# ajit_C_system_model -m main.mmap

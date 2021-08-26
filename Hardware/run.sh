#!/usr/bin/env bash

genVmapAsm vmap.txt setup_page_table.s
makeLinkerScript.py -t 0x0 -d 0x2000 customLinkerScript.lnk
compileToSparcUclibc.py -I $AJIT_UCLIBC_HEADERS_DIR -W ./ -L customLinkerScript.lnk -s init.s -s andd.s -s trap_handlers.s -s setup_page_table.s -N main  -D AJIT -U
ajit_C_system_model -m main.mmap -w -u 64 -d -r main.results -l main.log -w main.trace
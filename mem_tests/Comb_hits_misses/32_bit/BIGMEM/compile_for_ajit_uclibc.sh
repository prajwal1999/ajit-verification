AAR=$AJIT_ACCESS_ROUTINES_MT
PT=$AJIT_MINIMAL_PRINTF_TIMER
TEXTBASE=0x40000000
DATABASE=0x40040000
VMAP=VMAP.TXT
CLKFREQ=80000000
#1 generate linker script
makeLinkerScript.py -t $TEXTBASE -d $DATABASE -o customLinkerScript.lnk

cd ../
rm -r main.c
python3 main_generator.py
cd BIGMEM

#2 compile the application
compileToSparcUclibc.py -U -g -V $VMAP -N all_kinds_mem\
			-s ../init.s -s $AAR/asm/trap_handlers.s \
			-L customLinkerScript.lnk \
			-I $AAR/include -I $PT/include \
			-c ../main.c -C $AAR/src -C $PT/src -D VA_DATA_SECTION_START=$DATABASE -D CLK_FREQUENCY=$CLKFREQ
ajit_C_system_model -m all_kinds_mem.mmap -i 0x40000000 -w -u 64 -d -r main.results -l main.log -w main.trace
AAR=$AJIT_ACCESS_ROUTINES_MT
PT=$AJIT_MINIMAL_PRINTF_TIMER
#1 generate linker script
makeLinkerScript.py -t 0x0 -d 0x80000 -o customLinkerScript.lnk
#2 compile the application


	cd ../
	rm -r main.c
	python3 main_generator.py
	cd SMALLMEM
	compileToSparcUclibc.py -U -g -V VMAP.TXT -N all_kinds_mem\
			-s ../init.s -s $AAR/asm/trap_handlers.s \
			-L customLinkerScript.lnk \
			-I $AAR/include -I $PT/include \
			-c ../main.c -C $AAR/src -C $PT/src -D VA_DATA_SECTION_START=0x80000 -D CLK_FREQUENCY=80000000
	ajit_C_system_model -m all_kinds_mem.mmap 
	



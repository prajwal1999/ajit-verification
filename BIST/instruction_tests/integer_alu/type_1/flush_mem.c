// #include <stdint.h>



int flush_mem(int *start_addr, int n_words) {

    int i;
    for(i=0; i<n_words; i++) {
        *(start_addr + i) = 0;
    }

    return 0;
}
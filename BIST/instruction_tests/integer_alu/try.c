#include <stdio.h>



unsigned char prbs_5(unsigned char x)
{
    // printf("input to 3 bit prbs = %x\n", x);
    x ^= x << 2;
    x &= 0b11111;
    // printf("%x\n", x);
    x ^= x >> 1;
    // printf("%x\n", x);
    x &= 0b11111;
    // printf("output = %x \n", x);
    return x;
}


int main() {
    char seed_5 = 2;

    int i;
    for(i=0; i<50;i++) {
        seed_5 = prbs_5(seed_5);
        printf("%d\n", seed_5);
    }



    return(0);
}
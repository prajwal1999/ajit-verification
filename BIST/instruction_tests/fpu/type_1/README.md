### Verify using (Swap Inputs)

This section contains verification of fpu instruction by using inverse instructions

- fadds 001000001 
- faddd 001000010
- faddq 001000011
- fsubs 001000101
- fsubd 001000110
- fsubq 001000111

- fsqrts 000101001
- fsqrtd 000101010
- fsqrtq 000101011

- fmuls 001001001
- fmuld 001001010
- fmulq 001001011

- fsmuld 001101001
- fdmulq 001101110

<!-- - fdivs 001001101
- fdivd 001001110
- fdivq 001001111 -->


Each test consists 2-inputs for which 2-outputs are expected.
Result section - input_1 input_2 result_msb result_lsb psr output_1 output_2 _____ 
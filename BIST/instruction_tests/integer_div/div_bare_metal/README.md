### Verify using (Swap Inputs)

This section contains verification of integer alu instruction by using inverse instructions

- udiv (cc) 0x0e 0x1e
- sdiv (cc) 0x0f 0x1f



Each test consists 2-inputs for which 2-outputs are expected.
Result section - input_1 input_1 input_2 initial_psr result_lsb psr output_1 output_2 


--- stats store for register coverage
 - used as "rs1, rs2, rd" for alu instructions
 - used as rd for load/store instructions

--- instruction count - note how many times a opcode is checked 
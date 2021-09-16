#include<stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>

char instr_sel(uint random_no);

unsigned int bring_complement_instr_1(char instr, char rs1, char rs2, char rd);

unsigned int bring_complement_instr_2(char instr, char rs1, char rs2, char rd);

unsigned int generate_opcode_10(unsigned int rd, unsigned int rs1, unsigned int rs2, unsigned int op_code, char i, unsigned short imm);

unsigned int generate_opcode_11(unsigned int rd, unsigned int rs1, unsigned int rs2, unsigned int op_code, char i, unsigned short imm);


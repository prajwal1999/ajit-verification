#include<stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include "instr_select.h"

unsigned int generate_opcode_10(unsigned int rd, unsigned int rs1, unsigned int rs2, unsigned int op_code, char i, unsigned short imm)
{
    unsigned int test = 0x80000000;
    test |= rd << 25;
    test |= op_code << 19;
    test |= rs1 << 14;
    test |= rs2;
    // ee_printf("%i, %i, %i, %x\n", rd, rs1, rs2, test);
    return test;
}

unsigned int generate_opcode_11(unsigned int rd, unsigned int rs1, unsigned int rs2, unsigned int op_code, char i, unsigned short imm)
{
    unsigned int test = 0xc0000000;
    test |= rd << 25;
    test |= op_code << 19;
    test |= rs1 << 14;
    if(i==1) {
        test |= 1 << 13;
        test |= imm;
    } else {
        test |= rs2;
    }
    return test;
}

char instr_sel(uint random_no)
{
    
    if (random_no == 0){
        return 0x00;
    }
    else if (random_no == 1) {
        return 0x04;
    }
    else if (random_no == 2){
        return 0x0A;
    }
    else if (random_no == 3){
        return 0x0E;
    }
}

unsigned int bring_complement_instr_1(char instr, char rs1, char rs2, char rd)
{
    if (instr == 0x00){
        return generate_opcode_10(rs1, rd, rs2, 0x04, 0, 0);
    }
    else if (instr == 0x04){
        return generate_opcode_10(rs1, rd, rs2, 0x00, 0, 0);
    }
    else if (instr == 0x0E){
        return generate_opcode_10(rs1, rd, rs2, 0x0A, 0, 0);
    }
    else if (instr == 0x0A){
        return generate_opcode_10(rs1, rd, rs2, 0x0E, 0, 0);
    }
}

unsigned int bring_complement_instr_2(char instr, char rs1, char rs2, char rd)
{
    if (instr == 0x00){
        return generate_opcode_10(rs2, rd, rs1, 0x04, 0, 0);
    }
    else if (instr == 0x04){
        return generate_opcode_10(rs2, rs1, rd, 0x04, 0, 0);
    }
    else if (instr == 0x0E){
        return generate_opcode_10(rs2, rs1, rd, 0x0E, 0, 0);
    }
    else if (instr == 0x0A){
        return generate_opcode_10(rs2, rd, rs1, 0x0E, 0, 0);
    }
}
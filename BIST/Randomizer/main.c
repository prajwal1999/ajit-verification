#include <stdio.h>
#include "core_portme.h"
#include "ajit_access_routines.h"
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

int16_t prbs(int16_t lfsr)
{
    bool bit;
    bit  = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5) ) & 1;
    lfsr =  (lfsr >> 1) | (bit << 12);
    return lfsr;
}

unsigned char prbs_4(unsigned char lfsr_4)
{
    unsigned char bit_0 = lfsr_4 & 1;
    unsigned char bit_1 = ((lfsr_4 & 2)>>1); 
    lfsr_4 = (lfsr_4 >> 1) | ( (bit_0 ^ bit_1) << 3);
    return lfsr_4;
}



struct Test_Instruction
{
    char mnemonic[10];
    char opcode;
    // struct Test_Instruction* next_instr;
    // struct Test_Instruction* prev_instr;
    char rs1;
    char rs2;
    char rd;
    bool i;
};

// void Insert_Test_Instruction(struct Test_Instruction *head )
// {
//     struct Test_Instruction *test_instr = (struct Test_Instruction*)malloc(sizeof(struct Test_Instruction));
// }

char instr_types[4][15] = {"branch", "logical", "arithmetic", "load_store"};
char branch[10][5] = {"ba", "bn", "bne", "be"};
char logical[15][7] = {"and", "andcc", "andncc", "andn", "or", "orn", "orncc", "orcc", "xor", "xorcc", "xnorcc", "xnor", "sll", "srl", "sra"};
char arithmetic[][7] = {"add", "addcc", "subcc", "sub", "mulscc", "umulcc", "umul", "smul", "smulcc", "udiv", "udivcc", "sdivcc", "sdiv"};
char r_arithmetic[13][7] = {"sub", "subcc", "addcc", "add", "mulscc", "udivcc", "udiv", "sdiv", "sdivcc", "umul", "umulcc", "smulcc", "umul"};
char load_store[10][6] = {"ldsh", "lduh", "ld", "st", "std", "ldsb", "ldd", "sth", "stb", "ldub"};

char l_regs[9][3] = {"l0", "l1", "l2", "l3", "l4", "l5", "l6", "l7", ""};

int main() {
    __ajit_write_serial_control_register__ ( TX_ENABLE | RX_ENABLE );
    int min_n_instrs = 20; 
    int16_t lfsr = 0xd4536;
    // struct Test_Instruction* test_instrs_list = NULL;
    // struct Test_Instruction* reverse_test_instrs_list = NULL;
    struct Test_Instruction test_instrs_list[100];
    struct Test_Instruction reverse_test_instrs_list[100];
    int n_test_instrs = 0;
    int n_rev_test_instrs = 0;

    // Insert_Test_Instruction(test_instrs_list);
    // Insert_Test_Instruction(reverse_test_instrs_list);

    char reg_ctr = 5;

    int i=0;
    unsigned char lfsr_4 = 13;
    while(i < min_n_instrs) {
        lfsr = prbs(lfsr);
        int16_t instr_type_key = lfsr & 0xf;

        if(instr_type_key==0 || instr_type_key==4 || instr_type_key==5 || instr_type_key==0xb || instr_type_key==0xe || instr_type_key==0xf) 
        {
            lfsr_4 = prbs_4(lfsr_4);
            int16_t key = (lfsr_4 > 14) ? 0 : lfsr_4;
            // ee_printf("%s\n", logical[key]);
            // logical
        } 
        else if(instr_type_key==1 || instr_type_key==3 || instr_type_key==7 || instr_type_key==0xa || instr_type_key==0xc || instr_type_key==0xd)
        {
            lfsr_4 = prbs_4(lfsr_4);
            int16_t key = (lfsr_4 > 13) ? 0 : lfsr_4;
            reg_ctr = prbs_4(reg_ctr);
            char *rs1 = l_regs[reg_ctr % 8];
            reg_ctr = prbs_4(reg_ctr);
            char *rs2 = l_regs[reg_ctr % 8];

            ee_printf("%s %s, %s, %s    %s %s, %s, %s\n", arithmetic[key], rs1, rs2, rs1, r_arithmetic[key], rs1, rs2, rs1);
            // arithmetic
        }
        else if(instr_type_key==2 || instr_type_key==6 || instr_type_key==8) {
            lfsr_4 = prbs_4(lfsr_4);
            int16_t key = (lfsr_4 > 10) ? 0 : lfsr_4;
            // ee_printf("load_store %s\n", load_store[key]);
        } 
        else if(instr_type_key==9) {
            lfsr_4 = prbs_4(lfsr_4);
            int16_t key = (lfsr_4 > 10) ? 0 : lfsr_4;
            // ee_printf("branch %s\n", branch[key]);
        }
        i++;
    }


    return(1);
}
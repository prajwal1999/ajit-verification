#include <stdbool.h>

unsigned int generate_opcode_10(unsigned int rd, unsigned int rs1, unsigned int rs2, unsigned int op_code, char i, unsigned short imm);
unsigned int generate_opcode_11(unsigned int rd, unsigned int rs1, unsigned int rs2, unsigned int op_code, char i, unsigned short imm);
unsigned int generate_opcode_00(unsigned int rd, unsigned char op_code, unsigned int imm22);
unsigned char prbs_5(unsigned char x, unsigned char except);



int generate_instr(int *test_program_ptr, int *results_section, int *register_coverage, int register_seed, 
                    int instr_opcode, int save_register, int *current_instr_number)
{   

    unsigned char inv_op_code;
    unsigned char simple_op_code;

         if(instr_opcode == 0x20 || instr_opcode == 0x22) inv_op_code = 0x04; // taddcc, taddcctv

         if(instr_opcode == 0x20 || instr_opcode == 0x22) simple_op_code = 0x00; 
    // else if(instr_opcode == 0x04 || instr_opcode == 0x14) inv_op_code = 0x00; // sub, subcc

    unsigned char mem_mnemonic[2][3] = {'ld', 'st'};
    unsigned char mem_op_codes[2] = {0x00, 0x04};

    char seed_5 = register_seed; // 5-bit seed for register

    /*
        store_instr_at points to the section where current generated instruction will be stored. It is incremented after each storage.
        At start it points to test_program_ptr, where the test program execution begins 
    */
    int *store_instr_at = test_program_ptr;

    // first instr is save instruction which changes register window and decrement stack
    *store_instr_at = 0x9de3bfa0; store_instr_at++; // save %o6, -96, %o6

/*
    r14 - stack pointer
    r15 - address of call instruction
    r30 - frame pointer
    r31 - return address
    we first store these register values in some memory location and retreive them back at end of program
*/
    if(seed_5==14 || seed_5==15 || seed_5==30 || seed_5==31 ) seed_5 = prbs_5(seed_5, 0);
    store_instr_at = save_registers_14_15_30_31(save_register, store_instr_at, seed_5); // save register 14 15 30 31
    // update register coverage
    register_coverage[4*(seed_5 & 0x1f) + 0] += 1;
    register_coverage[4*(seed_5 & 0x1f) + 2] += 1;
    register_coverage[4*(seed_5 & 0x1f) + 3] += 4;


    // set result section address base
    seed_5 = prbs_5(seed_5, 0);
    char result_sec_base_reg = seed_5;
    /*
        result_sec_base_reg register contains the starting address of result section from where results are stored.
        This register is incremented by 32 after each test
    */
    store_instr_at = load_result_section_base((int)results_section, store_instr_at, result_sec_base_reg);
    // register coverage
    register_coverage[4*(seed_5 & 0x1f) + 0] += 1;
    register_coverage[4*(seed_5 & 0x1f) + 2] += 1;
    register_coverage[4*(seed_5 & 0x1f) + 3] += 4;


    int i;
    /*
    rd - destination register
    rs1 - input 1 register
    rs2 - input 2 register
    temp_r - temporary register to store middle values
    */
    char rd, rs1, rs2, temp_r, temp_r_2;
    int immediate; // immediate value
    bool is_imm;

    for(i=0; i<N_INPUTS; i++)
    {
        seed_5 = prbs_5(seed_5, result_sec_base_reg);   rs1 = seed_5;
        is_imm = results_section[8*i + 2];
        if(is_imm) immediate = results_section[8*i + 1];
        else immediate = 0;
        
        seed_5 = prbs_5(seed_5, result_sec_base_reg);   rs2 = seed_5;
        seed_5 = prbs_5(seed_5, result_sec_base_reg);   rd = seed_5;
        seed_5 = prbs_5(seed_5, result_sec_base_reg);   temp_r = seed_5;

        // load inputs in rs1 and rs2
        *store_instr_at = generate_opcode_11(rs1, result_sec_base_reg, 0, mem_op_codes[0], 1, 0); store_instr_at++;
        *store_instr_at = generate_opcode_11(rs2, result_sec_base_reg, 0, mem_op_codes[0], 1, 4); store_instr_at++;

        // run simple instruction and store result
        *store_instr_at = generate_opcode_10(rd, rs1, rs2, simple_op_code, is_imm, immediate); store_instr_at++;
        *store_instr_at = generate_opcode_11(rd, result_sec_base_reg, 0, mem_op_codes[1], 1, 12); store_instr_at++;
        // store psr 
        *store_instr_at = generate_opcode_10(temp_r, 0, 0, 0b101001, 0, 0); store_instr_at++;
        *store_instr_at = generate_opcode_11(temp_r, result_sec_base_reg, 0, mem_op_codes[1], 1, 8); store_instr_at++;
        
        // store the currnt executing instr number - indexed 0
        store_instr_at = load_result_section_base((int)current_instr_number, store_instr_at, temp_r);
        *store_instr_at = generate_opcode_10(rd, rd, 0, 0b000001, 1, 0); store_instr_at++; // rd = rd & 0
        *store_instr_at = generate_opcode_10(rd, rd, 0, 0b000001, 1, i); store_instr_at++; // rd = rd + 1

        // *(current_instr_number) = i;
        // run main instruction and store result
        *store_instr_at = generate_opcode_10(rd, rs1, rs2, instr_opcode, is_imm, immediate); store_instr_at++;
        *store_instr_at = generate_opcode_11(rd, result_sec_base_reg, 0, mem_op_codes[1], 1, 20); store_instr_at++;
        // store psr 
        *store_instr_at = generate_opcode_10(temp_r, 0, 0, 0b101001, 0, 0); store_instr_at++;
        *store_instr_at = generate_opcode_11(temp_r, result_sec_base_reg, 0, mem_op_codes[1], 1, 16); store_instr_at++;

        if(instr_opcode==0x21 || instr_opcode==0x23) {
            //  run inverse instruction operation without CCR code update
            *store_instr_at = generate_opcode_10(rs1, rs1, rd, instr_opcode, 0, 0); store_instr_at++;
            *store_instr_at = generate_opcode_10(rs2, rd, rs2, inv_op_code, is_imm, immediate); store_instr_at++;
        }
        else {
            //  run inverse instruction operation without CCR code update
            *store_instr_at = generate_opcode_10(rs1, rd, rs1, inv_op_code, 0, 0); store_instr_at++;
            *store_instr_at = generate_opcode_10(rs2, rd, rs2, inv_op_code, is_imm, immediate); store_instr_at++;
        }

        // store inputs in rs1 and rs2
        *store_instr_at = generate_opcode_11(rs1, result_sec_base_reg, 0, mem_op_codes[1], 1, 28); store_instr_at++;
        *store_instr_at = generate_opcode_11(rs2, result_sec_base_reg, 0, mem_op_codes[1], 1, 24); store_instr_at++;

        // increment result_sec_base_reg = result_sec_base_reg + 32
        *store_instr_at = generate_opcode_10(result_sec_base_reg, result_sec_base_reg, 0, 0b000000, 1, 32); store_instr_at++;


        // store register coverage
        register_coverage[4*(rs1 & 0x1f) + 0] += 1;
        register_coverage[4*(rs2 & 0x1f) + 1] += 1;
        register_coverage[4*(rd & 0x1f) + 2] += 1;
        register_coverage[4*(temp_r & 0x1f) + 3] += 3;
    }


    // load registers back
    seed_5 = prbs_5(seed_5, 0);
    if(seed_5==14 || seed_5==15 || seed_5==30 || seed_5==31 ) seed_5 = prbs_5(seed_5, 0);
    store_instr_at = load_registers_14_15_30_31(save_register, store_instr_at, seed_5);

    // instruction restore; retl; nop
    *store_instr_at = 0x81e80000; store_instr_at++;
    *store_instr_at = 0x81c3e008; store_instr_at++;
    *store_instr_at = 0x01000000; store_instr_at++;

    return seed_5;

}


// other functions
unsigned int generate_opcode_10(unsigned int rd, unsigned int rs1, unsigned int rs2, unsigned int op_code, char i, unsigned short imm)
{
    unsigned int test = 0x80000000;
    test |= rd << 25;
    test |= op_code << 19;
    test |= rs1 << 14;
    if(i==1) {
        test |= 1 << 13;
        test |= (imm & 0x1fff);
    } else {
        test |= rs2;
    }
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
        test |= (imm & 0x1fff);
    } else {
        test |= rs2;
    }
    return test;
}

unsigned int generate_opcode_00(unsigned int rd, unsigned char op_code, unsigned int imm22)
{
    unsigned int test = 0x00000000;
    test |= rd << 25;
    test |= op_code << 22;
    test |= (imm22 >> 10 );
    return test;
}

unsigned char prbs_5(unsigned char x, unsigned char except)
{
    // ee_printf("prbs - in - %d, ", x);
    x ^= (x << 2) & 0b11111;
    x ^= (x >> 3) & 0b11111;
    x ^= (x << 1) & 0b11111;
    if(x == except) x=prbs_5(x, except);
    if(x==0) x=prbs_5(1, 0);
    // ee_printf("prbs -> out - %d\n", x);
    return x;
}

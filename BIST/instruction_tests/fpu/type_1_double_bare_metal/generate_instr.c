int generate_opcode_10(int rd,  int rs1,  int rs2,  int op_code, char i,  short imm);
int generate_f_opcode_10(int rd,  int rs1,  int rs2,  int opf_code,  int FPop);
int generate_opcode_11(int rd,  int rs1,  int rs2,  int op_code, char i,  short imm);


int generate_instr(int *test_program, int results_section, int *register_coverage, int register_seed, int instr_opcode, int save_register, int number_of_inputs)
{   
    unsigned char inv_op_code;

    if(instr_opcode == 0x42) inv_op_code = 0x46; // faddd 
    else if(instr_opcode == 0x46) inv_op_code = 0x42; // fsubd 
    else if(instr_opcode == 0x2a) inv_op_code = 0x4a; // fsqrtd
    else if(instr_opcode == 0x4a) inv_op_code = 0x4e; // fmuld
    else if(instr_opcode == 0x4e) inv_op_code = 0x4a; // fdivd

    char mem_mnemonic[3][4] = {'ld', 'lddf', 'st', 'stdf'};
    char mem_op_codes[4] =    {0x00, 0x23,  0x04, 0x27};

    char seed_5 = register_seed; // 5-bit seed for register
    /*
        store_instr_at points to the section where current generated instruction will be stored. It is incremented after each storage.
        At start it points to test_program, where the test program execution begins 
    */
    int *store_instr_at = test_program;
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

    // set result section address base
    seed_5 = prbs_5(seed_5, 0);
    char result_sec_base_reg = seed_5;
    /*
        result_sec_base_reg register contains the starting address of result section from where results are stored.
        This register is incremented by 32 after each test
    */
    store_instr_at = load_result_section_base(results_section, 1, 32, store_instr_at, result_sec_base_reg);

    int i;
    /*
    rd - destination register
    rs1 - input 1 register
    rs2 - input 2 register
    temp_r - temporary register to store middle values
    */
    char rd, rs1, rs2;

    for(i=0; i<number_of_inputs; i++)
    {
        seed_5 = prbs_5(seed_5, 100);   rs1 = seed_5 & 0x1e;
        do{
            seed_5 = prbs_5(seed_5, rs1);
            rs2 = seed_5 & 0x1e;
        } while(rs2==rs1);
        do{
            seed_5 = prbs_5(seed_5, rs2);
            rd = seed_5 & 0x1e;
        } while(rd==rs1 || rd==rs2);
        // seed_5 = prbs_5(seed_5, 100);   rs2 = (seed_5 << 1) & 0x1f;
        // seed_5 = prbs_5(seed_5, 100);   rd = (seed_5 << 1) & 0x1f;

        if(instr_opcode == 0x2a){  // if instr is fsqrtd, rs1 is 0
            rs1 = 0;
        }

        // ee_printf("i, %d, opcode r%d, r%d, r%d\n", i+1, rs1, rs2, rd);

        // load inputs in rs1 and rs2
        *store_instr_at = generate_opcode_11(rs1, result_sec_base_reg, 0, mem_op_codes[1], 1, 0); store_instr_at++;
        *store_instr_at = generate_opcode_11(rs2, result_sec_base_reg, 0, mem_op_codes[1], 1, 8); store_instr_at++;
        
        //  run main instruction operation
        *store_instr_at = generate_f_opcode_10(rd, rs1, rs2, instr_opcode, 0b110100); store_instr_at++; 
        
        // store result
        *store_instr_at = generate_opcode_11(rd, result_sec_base_reg, 0, mem_op_codes[3], 1, 16); store_instr_at++; 

        if(instr_opcode==0x46 || instr_opcode == 0x4e) {
            //  run inverse instruction operation without CCR code update
            *store_instr_at = generate_f_opcode_10(rs1, rs1, rd, instr_opcode, 0b110100); store_instr_at++;
            *store_instr_at = generate_f_opcode_10(rs2, rd, rs2, inv_op_code, 0b110100); store_instr_at++;
        }
        else if(instr_opcode == 0x2a) {
            *store_instr_at = generate_f_opcode_10(rs1, rd, rd, inv_op_code, 0b110100); store_instr_at++;
            *store_instr_at = 0x01000000; store_instr_at++;
        }
        if(instr_opcode == 0x42 || instr_opcode == 0x4a) {
        //     //  run inverse instruction operation without CCR code update
            *store_instr_at = generate_f_opcode_10(rs1, rd, rs1, inv_op_code, 0b110100); store_instr_at++;
            *store_instr_at = generate_f_opcode_10(rs2, rd, rs2, inv_op_code, 0b110100); store_instr_at++;
        }

        // store inputs in rs1 and rs2
        *store_instr_at = generate_opcode_11(rs1, result_sec_base_reg, 0, mem_op_codes[3], 1, 32); store_instr_at++;
        *store_instr_at = generate_opcode_11(rs2, result_sec_base_reg, 0, mem_op_codes[3], 1, 24); store_instr_at++;
        // increment result_sec_base_reg = result_sec_base_reg + 32
        *store_instr_at = generate_opcode_10(result_sec_base_reg, result_sec_base_reg, 0, 0b000000, 1, 64); store_instr_at++;
    }

    // load registers back
    seed_5 = prbs_5(seed_5, 0);
    if(seed_5==14 || seed_5==15 || seed_5==30 || seed_5==31 ) seed_5 = prbs_5(seed_5, 0);
    store_instr_at = load_registers_14_15_30_31(save_register, store_instr_at, seed_5);

    // instruction restore; retl; nop
    *store_instr_at = 0x81e80000; store_instr_at++;
    *store_instr_at = 0x81c3e008; store_instr_at++;
    *store_instr_at = 0x01000000; store_instr_at++;

    ee_printf("------------------- Instructions generation done -------------------\n");
    return seed_5;
}


// other functions
 int generate_f_opcode_10( int rd, int rs1, int rs2, int opf_code, int FPop)
{
    int test = 0x80000000;
    test |= rd << 25;
    test |= FPop << 19;
    test |= rs1 << 14;
    test |= opf_code << 5;
    test |= rs2;
    return test;
}

 int generate_opcode_10( int rd,  int rs1,  int rs2,  int op_code, char i,  short imm)
{
     int test = 0x80000000;
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

 int generate_opcode_11( int rd,  int rs1,  int rs2,  int op_code, char i,  short imm)
{
     int test = 0xc0000000;
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

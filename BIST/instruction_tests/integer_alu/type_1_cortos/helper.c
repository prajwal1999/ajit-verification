int *save_registers_14_15_30_31(int *save_register_ptr, int * store_instr_at, char base_reg, int *register_coverage_ptr) {
    // save register 14 15 30 31
    unsigned int save_register_base = ((int)save_register_ptr >> 10) << 10;
    *store_instr_at = generate_opcode_00(base_reg, 0b100, save_register_base); store_instr_at++;

    save_register_base = ((int)save_register_ptr << 22) >> 22;
    save_register_base &= 0x000003ff; 
    *store_instr_at = generate_opcode_10(base_reg, base_reg, 0, 0x02, 1, save_register_base); store_instr_at++;
    
    *store_instr_at = generate_opcode_11(0b01110, base_reg, 0, 0x04, 1, 0); store_instr_at++;
    *store_instr_at = generate_opcode_11(0b01111, base_reg, 0, 0x04, 1, 4); store_instr_at++;
    *store_instr_at = generate_opcode_11(0b11110, base_reg, 0, 0x04, 1, 8); store_instr_at++;
    *store_instr_at = generate_opcode_11(0b11111, base_reg, 0, 0x04, 1, 12); store_instr_at++;

    // register coverage
    *(register_coverage_ptr + (base_reg & 0x1f)*4 + 0) += 1;
    *(register_coverage_ptr + (base_reg & 0x1f)*4 + 2) += 1;
    *(register_coverage_ptr + (base_reg & 0x1f)*4 + 3) += 4;
    return store_instr_at;
}

int *load_registers_14_15_30_31(int *save_register_ptr, int *store_instr_at, char base_reg, int *register_coverage_ptr) {
    // load register 14 15 30 31
    unsigned int save_register_base = ((int)save_register_ptr >> 10) << 10;
    *store_instr_at = generate_opcode_00(base_reg, 0b100, save_register_base); store_instr_at++;

    save_register_base = ((int)save_register_ptr << 22) >> 22;
    save_register_base &= 0x000003ff; 
    *store_instr_at = generate_opcode_10(base_reg, base_reg, 0, 0x02, 1, save_register_base); store_instr_at++;

    *store_instr_at = generate_opcode_11(0b01110, base_reg, 0, 0x00, 1, 0); store_instr_at++;
    *store_instr_at = generate_opcode_11(0b01111, base_reg, 0, 0x00, 1, 4); store_instr_at++;
    *store_instr_at = generate_opcode_11(0b11110, base_reg, 0, 0x00, 1, 8); store_instr_at++;
    *store_instr_at = generate_opcode_11(0b11111, base_reg, 0, 0x00, 1, 12); store_instr_at++;

    // register coverage
    *(register_coverage_ptr + (base_reg & 0x1f)*4 + 0) += 1;
    *(register_coverage_ptr + (base_reg & 0x1f)*4 + 2) += 1;
    *(register_coverage_ptr + (base_reg & 0x1f)*4 + 3) += 4;
    return store_instr_at;
}

int *load_result_section_base(int results_section_ptr, int base_test_n, int bytes_per_test, int *store_instr_at, char base_reg) {
    // set result section address
    results_section_ptr += (base_test_n-1)*bytes_per_test;
    unsigned int result_section_base = (int)results_section_ptr & 0xfffffc00;    
    *store_instr_at = generate_opcode_00(base_reg, 0b100, result_section_base); store_instr_at++; //sethi %hi(0x40000000), %result_sec_base_reg
    int low_bytes = (int)results_section_ptr & 0x000003ff;
    *store_instr_at = generate_opcode_10(base_reg, base_reg, 0, 0x02, 1, low_bytes); store_instr_at++; // or %result_sec_base_reg, 0x2a8, %result_sec_base_reg
    return store_instr_at;    
}


char prbs_5(char x, char except)
{
    x ^= x << 2;
    x &= 0b11111;
    x ^= x >> 1;
    x &= 0b11111;
    if(x == except) x=prbs_5(x, except);
    if(x==0) x=prbs_5(1, 0);
    return x;
}
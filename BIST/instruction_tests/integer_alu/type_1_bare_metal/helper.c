int *save_registers_14_15_30_31(int save_register, int *store_instr_at, char base_reg) {
    // save register 14 15 30 31
    unsigned int save_register_base = save_register & 0xfffffc00; // higher 22 bits
    *store_instr_at = generate_opcode_00(base_reg, 0b100, save_register_base); store_instr_at++;

    save_register_base = save_register & 0x3ff; // lower 10 bits
    *store_instr_at = generate_opcode_10(base_reg, base_reg, 0, 0x02, 1, save_register_base); store_instr_at++;
    
    *store_instr_at = generate_opcode_11(0b01110, base_reg, 0, 0x04, 1, 0); store_instr_at++;
    *store_instr_at = generate_opcode_11(0b01111, base_reg, 0, 0x04, 1, 4); store_instr_at++;
    *store_instr_at = generate_opcode_11(0b11110, base_reg, 0, 0x04, 1, 8); store_instr_at++;
    *store_instr_at = generate_opcode_11(0b11111, base_reg, 0, 0x04, 1, 12); store_instr_at++;
    return store_instr_at;
}

int *load_registers_14_15_30_31(int save_register, int *store_instr_at, char base_reg) {
    // load register 14 15 30 31
    unsigned int save_register_base = save_register & 0xfffffc00; // higher 22 bits
    *store_instr_at = generate_opcode_00(base_reg, 0b100, save_register_base); store_instr_at++;

    save_register_base = save_register & 0x3ff; // lower 10 bits
    *store_instr_at = generate_opcode_10(base_reg, base_reg, 0, 0x02, 1, save_register_base); store_instr_at++;

    *store_instr_at = generate_opcode_11(0b01110, base_reg, 0, 0x00, 1, 0); store_instr_at++;
    *store_instr_at = generate_opcode_11(0b01111, base_reg, 0, 0x00, 1, 4); store_instr_at++;
    *store_instr_at = generate_opcode_11(0b11110, base_reg, 0, 0x00, 1, 8); store_instr_at++;
    *store_instr_at = generate_opcode_11(0b11111, base_reg, 0, 0x00, 1, 12); store_instr_at++;
    return store_instr_at;
}

int *load_result_section_base(int results_section, int *store_instr_at, char base_reg) {
    // set result section address
    unsigned int result_section_base = results_section & 0xfffffc00; // higher 22 bits    
    *store_instr_at = generate_opcode_00(base_reg, 0b100, result_section_base); store_instr_at++; //sethi %hi(0x40000000), %result_sec_base_reg
    int low_bytes = results_section & 0x3ff; // lower 10 bits
    *store_instr_at = generate_opcode_10(base_reg, base_reg, 0, 0x02, 1, low_bytes); store_instr_at++; // or %result_sec_base_reg, 0x2a8, %result_sec_base_reg
    return store_instr_at;    
}

unsigned int min(unsigned int a, unsigned int b) {
    if(a < b) return a;
    else return b;
}

void flush_mem(int *start_addr, int n_words) {
    int i;
    for(i=0; i<n_words; i++) start_addr[i] = 0;
}


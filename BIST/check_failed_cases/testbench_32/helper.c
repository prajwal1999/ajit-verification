#include <stdint.h>

int generate_opcode_00(char rd, char op_code, unsigned int imm22)
{
    int test = 0x00000000;
    test |= rd << 25;
    test |= op_code << 22;
    test |= (imm22 >> 10 );
    return test;
}

int *save_registers_14_15_30_31(int *save_register_ptr, int * store_instr_at, char base_reg) {
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
    return store_instr_at;
}

int *load_registers_14_15_30_31(int *save_register_ptr, int *store_instr_at, char base_reg) {
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
    return (x & 0b11111);
}

int prbs_32(int x)
{
    x ^= x << 13;
	x ^= x >> 17;
	x ^= x << 5;
    return x;
}


int is_machine_eps_32_or_zero(int num) {
    if(num == 0x1 || num == 0x0) return 1;
    // if(num == 0x0) return 1;
    else return 0;
}

int is_NAN_64(int64_t num) {
    int e_NAN_1 = 0x7ff00000;
    int e_NAN_2 = 0x00000000;
    int num_1 = (num >> 32) & 0x7ff00000;
    int num_2 = (num & 0xffffffff) & 0x00000000;
    // ee_printf("-----------e_nan is 0x%x %x----------\n", e_NAN_1, e_NAN_2);
    // ee_printf("-----------num is 0x%x %x----------\n",num_1, num_2 );
    if(num_1 == e_NAN_1 && num_2 == e_NAN_2) return 1;
    else return 0;
}
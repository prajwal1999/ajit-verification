from input_for_instrs import Instruction_32_bit



global_reg = ['g0', 'g1', 'g2', 'g3', 'g4', 'g5', 'g6', 'g7']
out_reg = ['o0', 'o1', 'o2', 'o3', 'o4', 'o5', 'o6', 'o7']
local_reg = ['l0', 'l1', 'l2', 'l3', 'l4', 'l5', 'l6', 'l7']
in_reg = ['i0', 'i1', 'i2', 'i3', 'i4', 'i5', 'i6', 'i7']
window_regs = global_reg + out_reg + local_reg + in_reg # all registers in current window


if __name__ == "__main__":
    instr = Instruction_32_bit('and')
    instr.init_coverage()
    instr.generate_input_pairs(10000)
    instr.write_coverage()
    instr.write_inputs_in_data_section()

    
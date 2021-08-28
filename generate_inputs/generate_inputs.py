from genericpath import isfile
import json
import random
import sys
import getopt
import os
import input_for_instrs



global_reg = ['g0', 'g2', 'g4', 'g6']
out_reg = ['o0', 'o2', 'o4', 'o6']
local_reg = ['l0', 'l2', 'l4', 'l6']
in_reg = ['i0', 'i2', 'i4', 'i6']
window_regs = global_reg + out_reg + local_reg + in_reg # all registers in current window

grid_dim = 2**60
grids_in_row = int((2**64) / grid_dim)
grid_count = grids_in_row**2


def init_grid(grid_dim, file_path):
    ''' generates the grid file and initiates it with all zeros '''
    j=0
    grid = []
    
    while j*grid_dim < 2**64:
        i=0
        row = []
        while i*grid_dim < 2**64:
            row.append(0)
            i += 1
        grid.append(row)
        j += 1

    with open(file_path, 'w') as grid_file:
        for row in grid:
            s = ''
            for val in row: s += f'{val}    '
            grid_file.write(f'{s} \n')


def write_to_grid(grid, file_path):
    ''' writes back to the grid file '''
    with open(file_path, 'w') as grid_file:
        for row in grid:
            s = ''
            for val in row:
                s += f'{val}    '
            grid_file.write(f'{s} \n')

def init_coverage(instr_name):
    print('initiating coverage files ....................')
    ''' checks coverage files and directory and creates if not present '''
    coverage_path = f'./coverage/{instr_name}'
    grid_path = f'{coverage_path}/{instr_name}.grid'
    register_cov_path = f'{coverage_path}/{instr_name}_registers_cov.json'
    instrs_cov_path = f'{coverage_path}/instrs_cov.json'
    if not os.path.isdir(coverage_path):
        print(f'{coverage_path} folder not found. creating ..........')
        os.mkdir(coverage_path, mode=0o777)
    if not os.path.isfile(grid_path):
        print(f'{grid_path} grid file not found. creating ..........')
        init_grid(grid_dim, grid_path)

    if not os.path.isfile(register_cov_path):
        print(f'{register_cov_path} register coverage path not found. creating ..........')
        regs = {}
        for r in ['g', 'o', 'l', 'i']:
            for d in range(0, 8):
                regs[f'{r}{d}'] = {
                    'opr1': 0,
                    'opr2': 0,
                    'dest': 0
                }
        with open(register_cov_path, 'w') as reg_cov_file:
            json.dump(regs, reg_cov_file)
    
    if not os.path.isfile(instrs_cov_path):
        print(f'{instrs_cov_path} instructions coverage path not found. creating ..........')
        with open(instrs_cov_path, 'w') as instrs_cov_file:
            json.dump({}, instrs_cov_file)

    return grid_path, register_cov_path

def load_grid(file_path):
    ''' return the grid file for corresponding instruction '''
    print(f'loading grid file ...................')
    grid = []
    with open(file_path) as grid_file:
        lines = grid_file.readlines()
        for line in lines:
            grid.append(list(map(int, line.split())))
    return grid

def generate_inputs(instr_name, number_of_inputs):
    instr_name = instr_name.lower()
    coverage_path = f'./coverage/{instr_name}'
    grid_path, register_cov_path = init_coverage(instr_name)
    local_grid = load_grid(grid_path)
    try:
        method_to_call = getattr(input_for_instrs, instr_name)
    except:
        print("No Such Instruction Exists")
        return
    print('generating inputs ....................')
    input_pairs, local_grid = method_to_call(local_grid, number_of_inputs)
    write_to_grid(local_grid, grid_path)
    # print(input_pairs)
    return input_pairs

def write_inputs_in_data_section(input_pairs):
    print('writing data in data section ....................')
    temp = []
    temp.append('.global store_data;\n')
    temp.append('store_data:\n')
    temp.append('   .global number_of_inputs\n')
    temp.append(f"   number_of_inputs: .word {hex(len(input_pairs))}\n")
    temp.append('   .align 8\n')
    temp.append('   .global store_data_base\n')
    temp.append('   store_data_base:\n')
    for idx,inp in enumerate(input_pairs):
        temp.append(f"   data{idx*8}: .word {hex(inp['opr1']//(2**32))}\n")
        temp.append(f"   data{idx*8 + 1}: .word {hex(inp['opr1']%(2**32))}\n")
        temp.append(f"   data{idx*8 + 2}: .word {hex(inp['opr2']//(2**32))}\n")
        temp.append(f"   data{idx*8 + 3}: .word {hex(inp['opr2']%(2**32))}\n")
        temp.append(f"   data{idx*8 + 4}: .word 0x0\n") # output msb
        temp.append(f"   data{idx*8 + 5}: .word 0x0\n") # output lsb
        temp.append(f"   data{idx*8 + 6}: .word 0x0\n") # expected psr
        temp.append(f"   data{idx*8 + 7}: .word 0x0\n") # real psr

    data_file_path = '../C_model/data.s'
    with open(data_file_path, 'w') as data_file:
        for instr in temp:
            data_file.write(instr)

if __name__ == "__main__":
    # arg_list = sys.argv[1:]
    # opts, args = getopt.getopt(arg_list, 'i:j:')
    input_pairs =  generate_inputs('andd', 100000)
    write_inputs_in_data_section(input_pairs)
    # print(arg_list)
    # print(opts)
    # print(args)
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
    j=0;
    grid = []
    
    while j*grid_dim < 2**64:
        i=0;
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
    ''' checks coverage files and directory and creates if not present '''
    coverage_path = f'./coverage/{instr_name}'
    grid_path = f'{coverage_path}/{instr_name}.grid'
    register_cov_path = f'{coverage_path}/{instr_name}_registers_cov.json'
    instrs_cov_path = f'{coverage_path}/instrs_cov.json'
    if not os.path.isdir(coverage_path): os.mkdir(coverage_path, mode=0o777)
    if not os.path.isfile(grid_path): init_grid(grid_dim, grid_path)

    if not os.path.isfile(register_cov_path):
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
        with open(instrs_cov_path, 'w') as instrs_cov_file:
            json.dump({}, instrs_cov_file)

    return grid_path, register_cov_path

def load_grid(file_path):
    ''' return the grid file for corresponding instruction '''
    grid = []
    with open(file_path) as grid_file:
        lines = grid_file.readlines()
        for line in lines:
            grid.append(list(map(int, line.split())))
    return grid

def generate_inputs(instr_name):
    instr_name = instr_name.lower()
    coverage_path = f'./coverage/{instr_name}'
    grid_path, register_cov_path = init_coverage(instr_name)
    local_grid = load_grid(grid_path)
    try:
        method_to_call = getattr(input_for_instrs, instr_name)
    except:
        print("No Such Instruction Exists")
        return
    input_pairs, local_grid = method_to_call(local_grid, 100, grid_dim)
    write_to_grid(local_grid, grid_path)
    return input_pairs
    # print(input_pairs)

if __name__ == "__main__":
    arg_list = sys.argv[1:]
    opts, args = getopt.getopt(arg_list, 'i:j:')
    input_pairs =  generate_inputs('andd')
     
    # print(arg_list)
    # print(opts)
    # print(args)
import os, json, random
from genericpath import isfile

def get_n_lowest_grids(grid, grid_length):
    grid_length = len(grid)
    sorted_list = sorted(list(i for j in grid for i in j))
    nth_lowest = sorted_list[grid_length//10]
    lowest = []
    for i in range(grid_length):
        for j in range(grid_length):
            if(grid[i][j] <= nth_lowest): lowest.append((i, j))

    return lowest


def init_grid(grid_length, file_path, word_legth):
    ''' generates the grid file and initiates it with all zeros '''
    j=0
    grid = []
    
    while j*grid_length < 2**word_legth:
        i=0
        row = []
        while i*grid_length < 2**word_legth:
            row.append(0)
            i += 1
        grid.append(row)
        j += 1

    with open(file_path, 'w') as grid_file:
        for row in grid:
            s = ''
            for val in row: s += f'{val}    '
            grid_file.write(f'{s} \n')

def make_coverage_files(coverage_path, name, grid_length, word_legth):
    grid_path = f'{coverage_path}/{name}.grid'
    register_cov_path = f'{coverage_path}/{name}_registers_cov.json'
    instrs_cov_path = f'{coverage_path}/instrs_cov.json'

    if not os.path.isdir(coverage_path):
        print(f'folder not found. creating {coverage_path} ..........')
        os.mkdir(coverage_path, mode=0o777)
    if not os.path.isfile(grid_path):
        print(f'grid file not found. creating {grid_path} ..........')
        init_grid(grid_length, grid_path, word_legth)

    if not os.path.isfile(register_cov_path):
        print(f'register coverage path not found. creating {register_cov_path} ..........')
        regs = {}
        for r in ['g', 'o', 'l', 'i']:
            for d in range(0, 8):
                regs[f'{r}{d}'] = { 'opr1': 0, 'opr2': 0, 'dest': 0 }
        with open(register_cov_path, 'w') as reg_cov_file:
            json.dump(regs, reg_cov_file)
    
    if not os.path.isfile(instrs_cov_path):
        print(f'{instrs_cov_path} instructions coverage path not found. creating ..........')
        with open(instrs_cov_path, 'w') as instrs_cov_file:
            json.dump({}, instrs_cov_file)
    
    print(f'loading grid file ...................')
    grid = []
    with open(grid_path) as grid_file:
        lines = grid_file.readlines()
        for line in lines:
            grid.append(list(map(int, line.split())))
    return grid

def write_to_grid(grid, file_path):
    ''' writes back to the grid file '''
    with open(file_path, 'w') as grid_file:
        for row in grid:
            s = ''
            for val in row:
                s += f'{val}    '
            grid_file.write(f'{s} \n')

class Instruction:
    # name, coverage_path, grid, grid_length, word_legth, inputs
    coverage_init = False
    def init_coverage(self):
        ''' checks coverage files and directory and creates if not present '''
        print('initiating coverage files ....................')
        self.coverage_init = True
        self.grid = make_coverage_files(self.coverage_path, self.name, self.grid_length, self.word_legth)
        
    def __init__(self, name):
        self.name = name.lower()
        self.coverage_path = f'./coverage/{name}'
        self.grid_length = 2**28
        self.word_legth = 32

    def generate_input_pairs(self, number_of_inputs):
        print('generating inputs ....................')
        self.inputs = []
        if self.grid: priority_grids = get_n_lowest_grids(self.grid, self.grid_length)
        for _ in range(number_of_inputs):
            if not self.grid:
                idx_1 = random.choice(range(grid_length))
                idx_2 = random.choice(range(grid_length))
            else:
                grid_idx = random.choice(priority_grids)
                idx_1 = grid_idx[0]
                idx_2 = grid_idx[1]
                self.grid[idx_1][idx_2] += 1
            self.inputs.append({
                'opr1': random.choice(range(idx_1*self.grid_length, (idx_1+1)*self.grid_length)),
                'opr2': random.choice(range(idx_2*self.grid_length, (idx_2+1)*self.grid_length))
            })

    def write_coverage(self):
        grid_path = f'{self.coverage_path}/{self.name}.grid'
        with open(grid_path, 'w') as grid_file:
            for row in self.grid:
                s = ''
                for val in row:
                    s += f'{val}    '
                grid_file.write(f'{s} \n')
        

class Instruction_32_bit(Instruction):
    
    def __init__(self, name):
        self.name = name.lower()
        self.coverage_path = f'./coverage/{name}'
        self.grid_length = 2**28
        self.word_legth = 32
    
    def write_inputs_in_data_section(self):
        print('writing data in data section ....................')
        temp = []
        temp.append('.global store_data;\n')
        temp.append('store_data:\n')
        temp.append('   .global number_of_inputs\n')
        temp.append(f"   number_of_inputs: .word {hex(len(self.inputs))}\n")
        temp.append('   .align 4\n')
        temp.append('   .global store_data_base\n')
        temp.append('   store_data_base:\n')
        for idx,inp in enumerate(self.inputs):
            temp.append(f"   data{idx*4}: .word {hex(inp['opr1'])}\n")
            temp.append(f"   data{idx*4 + 1}: .word {hex(inp['opr2'])}\n")
            temp.append(f"   data{idx*4 + 2}: .word 0x0\n") # output
            temp.append(f"   data{idx*4 + 3}: .word 0x0\n") # psr
        data_file_path = '../C_model/data.s'
        with open(data_file_path, 'w') as data_file:
            for instr in temp: data_file.write(instr)




class Instruction_64_bit(Instruction):
    
    def __init__(self, name):
        self.name = name.lower()
        self.coverage_path = f'./coverage/{name}'
        self.grid_length = 2**60
        self.word_legth = 64

    def write_inputs_in_data_section(self):
        print('writing data in data section ....................')
        temp = []
        temp.append('.global store_data;\n')
        temp.append('store_data:\n')
        temp.append('   .global number_of_inputs\n')
        temp.append(f"   number_of_inputs: .word {hex(len(self.inputs))}\n")
        temp.append('   .align 8\n')
        temp.append('   .global store_data_base\n')
        temp.append('   store_data_base:\n')
        for idx,inp in enumerate(self.inputs):
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
            for instr in temp: data_file.write(instr)




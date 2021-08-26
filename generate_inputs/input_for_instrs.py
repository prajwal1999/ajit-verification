import random

def get_n_lowest_grids(grid):
    grid_dim = len(grid)
    sorted_list = sorted(list(i for j in grid for i in j))
    nth_lowest = sorted_list[grid_dim//10]
    lowest = []
    for i in range(grid_dim):
        for j in range(grid_dim):
            if(grid[i][j] < nth_lowest): lowest.append((i, j))

    return lowest

def generate_random_inputs_64_bits(number_of_inputs, priority_grids, grid):
    grid_dim = len(grid)
    inputs = []
    for _ in range(number_of_inputs):
        grid_idx = random.choice(priority_grids)
        idx_1 = grid_idx[0]
        idx_2 = grid_idx[1]
        grid[idx_1][idx_2] += 1
        inputs.append({
            'opr1': random.choice(range(idx_1*grid_dim, idx_1*grid_dim+grid_dim)),
            'opr2': random.choice(range(idx_2*grid_dim, idx_2*grid_dim+grid_dim))
        })
    return grid, inputs

def andd(grid, number_of_inputs):
    ''' generates input pairs for andd instructions '''
    grid_dim = len(grid)
    inputs = []
    priority_grids = get_n_lowest_grids(grid)
    grid, inputs = generate_random_inputs_64_bits(number_of_inputs, priority_grids, grid)
    return inputs, grid

def udivdcc(grid, number_of_inputs):
    ''' generates input pairs for udivdcc instructions '''
    grid_dim = len(grid)
    inputs = []
    priority_grids = get_n_lowest_grids(grid)
    grid, inputs = generate_random_inputs_64_bits(number_of_inputs, priority_grids, grid)
    return inputs, grid

def andcc(grid, number_of_inputs):
    inputs = []
    priority_grids = []
     # flatten_grid = [j for sub in grid for j in sub]
    # add grids numbers from which constraint line passes
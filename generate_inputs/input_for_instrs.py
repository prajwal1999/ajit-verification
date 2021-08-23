import random

def andd(grid, number_of_inputs, grid_dim):
    '''
        generates input pairs for andd instructions
    '''
    inputs = []
    for _ in range(number_of_inputs):
        idx_1 = random.choice(range(0, len(grid)))
        idx_2 = random.choice(range(0, len(grid[0])))
        grid[idx_1][idx_2] += 1
        inputs.append({
            'opr_1': random.choice(range(idx_1*grid_dim, idx_1*grid_dim+grid_dim)),
            'opr_2': random.choice(range(idx_2*grid_dim, idx_2*grid_dim+grid_dim))
        })
    return inputs, grid

def andcc(grid, number_of_inputs):
    inputs = []
    priority_grids = []
     # flatten_grid = [j for sub in grid for j in sub]
    # add grids numbers from which constraint line passes
import os

def generate_result_file_64(base_addr ,number_of_inputs):
    temp = []
    temp.append('g7=0x0\n')
    temp.append('g0=0x0\n')
    # temp.append('g3=0x0\n')
    temp.append('g4=0x0\n')
    
    for x in range(number_of_inputs):
        temp.append(f'm[{hex(base_addr + x*16 + 0)}]=0x1\n')
        temp.append('asi=0xa\n')
        temp.append(f'm[{hex(base_addr + x*16 + 4)}]=0x1\n')
        temp.append('asi=0xa\n')
        temp.append(f'm[{hex(base_addr + x*16 + 8)}]=0x1\n')
        temp.append('asi=0xa\n')
        temp.append(f'm[{hex(base_addr + x*16 + 12)}]=0x1\n')
        temp.append('asi=0xa\n')
    return temp

if __name__ == "__main__":
    objdump_file_path = 'main.objdump'
    if not os.path.isfile(objdump_file_path):
        print("object dump file not found")
    else:
        with open(objdump_file_path) as objdump_file:
            objdump_data = objdump_file.readlines()
            number_of_inputs = 5
            # for line in objdump_data:
                # if('<store_data_base>:' in line):
                    # base_addr = '0x' + line.split()[0]
            base_addr = '0x2c00c'
            base_addr = int(base_addr, base=16)
            temp = generate_result_file_64(base_addr, number_of_inputs)
            results_file_path = 'main.results'
            with open(results_file_path, 'w') as results_file:
                for t in temp: results_file.write(t)

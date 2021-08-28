from genericpath import isfile
import os




if __name__ == "__main__":
    objdump_file_path = 'main.objdump'
    if not os.path.isfile(objdump_file_path):
        print("object dump file not found")
    else:
        with open(objdump_file_path) as objdump_file:
            objdump_data = objdump_file.readlines()
            for line in objdump_data:
                if('<number_of_inputs>:' in line):
                    addr = line.split()[0]
                    print(addr, type(addr))
import sys
import getopt


if __name__=="__main__":
    argv = sys.argv[1:]
    opts = None
    args = None
    input_file_name = None
    output_file_name = None
    try:
        opts, args = getopt.getopt(argv, "i:o:x")
        if(len(opts) == 0):
            print("Enter File Name")
    except:
        pass

    if(opts):
        for opt, arg in opts:
            # print(opt)
            if opt in ['-i']: input_file_name = arg
            if opt in ['-o']: output_file_name = arg

    
    if not input_file_name: print("Input file not provided")
    if not output_file_name: print("Output file name not provided")

    failed_input_list = []
    curr_read_state = "in" # in or res
    curr_failed_input_object = {}

    if(input_file_name and output_file_name):
        with open(input_file_name) as input_file:
            input_file_content = input_file.readlines()
            for input_line in input_file_content:
                # print(input_line)
                if "@Inputs are " in input_line and curr_read_state == "in":
                    # print(input_line)
                    a = input_line.split("\n")[0].split("@Inputs are ")[1].split(",")
                    # print(a)
                    curr_failed_input_object['input1'] = a[0].split(" ")
                    curr_failed_input_object['input2'] = a[1].split(" ")
                    curr_read_state = "res"
                if("@Actual result ") in input_line and curr_read_state == "res":
                    a = input_line.split("\n")[0].split("@Actual result ")[1].split(" ")
                    curr_failed_input_object['ajit_result'] = a
                    failed_input_list.append(curr_failed_input_object)
                    # print(curr_failed_input_object)
                    curr_failed_input_object = {}
                    curr_read_state = "in"

        # file_write_list = []
        with open(output_file_name, "w") as output_file:
                for idx, failed_obj in enumerate(failed_input_list):
                    print(failed_obj)
                    output_file.write("test_" + str(idx+1) + "_inp_1_1: .word 0x" + failed_obj["input1"][0] + "\n")
                    output_file.write("test_" + str(idx+1) + "_inp_1_2: .word 0x" + failed_obj["input1"][1] + "\n")

                    output_file.write("test_" + str(idx+1) + "_inp_2_1: .word 0x" + failed_obj["input2"][0] + "\n")
                    output_file.write("test_" + str(idx+1) + "_inp_2_2: .word 0x" + failed_obj["input2"][1] + "\n")

                    output_file.write("test_" + str(idx+1) + "_ajit_res_1: .word 0x" + failed_obj["ajit_result"][0] + "\n")
                    output_file.write("test_" + str(idx+1) + "_ajit_res_2: .word 0x" + failed_obj["ajit_result"][1] + "\n")

                    output_file.write("test_" + str(idx+1) + "_Cmodel_res_1: .word 0x0\n")
                    output_file.write("test_" + str(idx+1) + "_Cmodel_res_2: .word 0x0\n\n")
                    # file_write_list.append()





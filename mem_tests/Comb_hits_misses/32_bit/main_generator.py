import random

# Read in the file
with open('main.txt', 'r') as file :
  filedata = file.read()

random_no = random.getrandbits(16)
# Replace the target string
filedata = filedata.replace('random_generated_seed', str(random_no))

# Write the file out again
with open('main.c', 'w') as file:
  file.write(filedata)
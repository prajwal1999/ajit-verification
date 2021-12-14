"""
Code for generation of asm instructions
"""

for no in range(1000):
    print("    __asm__ __volatile__(\"label"+str(no)+":"+" \\"+"n\\t \" );")
    print("    __asm__ __volatile__( \" add %l1, 1, %l1 "+" \\"+"n\\t \" );")
    print("    __asm__ __volatile__( \" cmp %l2, %l1 "+" \\"+"n\\t \" );")
    print("    __asm__ __volatile__( \" bg label"+str(no+1)+" \\"+"n\\t \" );")

print("    __asm__ __volatile__(\"label1000: nop "+":"+" \\"+"n\\t \" );")
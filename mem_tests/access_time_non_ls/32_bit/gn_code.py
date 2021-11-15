
for no in range(100):

    print("__asm__ __volatile__(\"label"+str(no)+":"+" \\"+"n\\t \" );")
    print("__asm__ __volatile__( \" clr %l1"+" \\"+"n\\t\" );")
    print("__asm__ __volatile__( \" add %l1, 1, %l1 "+" \\"+"n\\t \" );")
    print("__asm__ __volatile__( \" cmp %l2, %l1 "+" \\"+"n\\t \" );")
    print("__asm__ __volatile__( \" bg label"+str(no)+" \\"+"n\\t \" );")
    #
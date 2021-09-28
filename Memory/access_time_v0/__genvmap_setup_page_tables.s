.section .text.pagetablesetup
.global page_table_setup
page_table_setup:
   set PAGE_TABLE_BASE, %g1
   !PTD: context=0, index=0, level=0, child_p_addr=0x800, p_addr=0xc00
   ! *(PAGE_TABLE_BASE + 0xc00) = ptd(PAGE_TABLE_BASE + 0x800)
   ! make PTD from 0x800
   set 0x800, %g4
   add %g1, %g4, %g4
   srl %g4, 0x4, %g4
   or  %g4, 0x1, %g4
   ! g4 contains PTD 
   set 0xc00, %g5
   add %g5, %g1, %g3
   st %g4, [%g3]
   ! g4 stored into [g3] 
   !PTD: context=0, index=0, level=1, child_p_addr=0x0, p_addr=0x800
   ! *(PAGE_TABLE_BASE + 0x800) = ptd(PAGE_TABLE_BASE + 0x0)
   ! make PTD from 0x0
   set 0x0, %g4
   add %g1, %g4, %g4
   srl %g4, 0x4, %g4
   or  %g4, 0x1, %g4
   ! g4 contains PTD 
   set 0x800, %g5
   add %g5, %g1, %g3
   st %g4, [%g3]
   ! g4 stored into [g3] 
   !PTE: context=0, index=0, level=2,  ppnr=0x0, p_addr=0x0, cacheable=0x1, acc=0x3
   ! *(PAGE_TABLE_BASE + 0x0) = 0x8e (pte)
   set 0x8e, %g2
   set 0x0, %g5
   add %g5, %g1, %g3
   st %g2, [%g3]
   !PTD: context=0, index=64, level=1, child_p_addr=0x100, p_addr=0x900
   ! *(PAGE_TABLE_BASE + 0x900) = ptd(PAGE_TABLE_BASE + 0x100)
   ! make PTD from 0x100
   set 0x100, %g4
   add %g1, %g4, %g4
   srl %g4, 0x4, %g4
   or  %g4, 0x1, %g4
   ! g4 contains PTD 
   set 0x900, %g5
   add %g5, %g1, %g3
   st %g4, [%g3]
   ! g4 stored into [g3] 
   !PTE: context=0, index=0, level=2,  ppnr=0x40000000, p_addr=0x100, cacheable=0x1, acc=0x3
   ! *(PAGE_TABLE_BASE + 0x100) = 0x400008e (pte)
   set 0x400008e, %g2
   set 0x100, %g5
   add %g5, %g1, %g3
   st %g2, [%g3]
   !PTD: context=0, index=255, level=1, child_p_addr=0x4f0, p_addr=0xbfc
   ! *(PAGE_TABLE_BASE + 0xbfc) = ptd(PAGE_TABLE_BASE + 0x400)
   ! make PTD from 0x4f0
   set 0x400, %g4
   add %g1, %g4, %g4
   srl %g4, 0x4, %g4
   or  %g4, 0x1, %g4
   ! g4 contains PTD 
   set 0xbfc, %g5
   add %g5, %g1, %g3
   st %g4, [%g3]
   ! g4 stored into [g3] 
   !PTD: context=0, index=60, level=2, child_p_addr=0x200, p_addr=0x4f0
   ! *(PAGE_TABLE_BASE + 0x4f0) = ptd(PAGE_TABLE_BASE + 0x200)
   ! make PTD from 0x200
   set 0x200, %g4
   add %g1, %g4, %g4
   srl %g4, 0x4, %g4
   or  %g4, 0x1, %g4
   ! g4 contains PTD 
   set 0x4f0, %g5
   add %g5, %g1, %g3
   st %g4, [%g3]
   ! g4 stored into [g3] 
   !PTE: context=0, index=0, level=3,  ppnr=0xfff00000, p_addr=0x200, cacheable=0x1, acc=0x3
   ! *(PAGE_TABLE_BASE + 0x200) = 0xfff008e (pte)
   set 0xfff008e, %g2
   set 0x200, %g5
   add %g5, %g1, %g3
   st %g2, [%g3]
   !PTE: context=0, index=1, level=3,  ppnr=0xfff01000, p_addr=0x204, cacheable=0x1, acc=0x3
   ! *(PAGE_TABLE_BASE + 0x204) = 0xfff018e (pte)
   set 0xfff018e, %g2
   set 0x204, %g5
   add %g5, %g1, %g3
   st %g2, [%g3]
   !PTD: context=0, index=63, level=2, child_p_addr=0x3cc, p_addr=0x4fc
   ! *(PAGE_TABLE_BASE + 0x4fc) = ptd(PAGE_TABLE_BASE + 0x300)
   ! make PTD from 0x3cc
   set 0x300, %g4
   add %g1, %g4, %g4
   srl %g4, 0x4, %g4
   or  %g4, 0x1, %g4
   ! g4 contains PTD 
   set 0x4fc, %g5
   add %g5, %g1, %g3
   st %g4, [%g3]
   ! g4 stored into [g3] 
   !PTE: context=0, index=51, level=3,  ppnr=0xffff3000, p_addr=0x3cc, cacheable=0x0, acc=0x3
   ! *(PAGE_TABLE_BASE + 0x3cc) = 0xffff30e (pte)
   set 0xffff30e, %g2
   set 0x3cc, %g5
   add %g5, %g1, %g3
   st %g2, [%g3]
   !PTE: context=0, index=52, level=3,  ppnr=0xffff4000, p_addr=0x3d0, cacheable=0x0, acc=0x3
   ! *(PAGE_TABLE_BASE + 0x3d0) = 0xffff40e (pte)
   set 0xffff40e, %g2
   set 0x3d0, %g5
   add %g5, %g1, %g3
   st %g2, [%g3]
   retl;
   nop;
! done: page_table_setup
! start: set context-table-pointer = PAGE_TABLE_BASE + 0xc00
.global set_context_table_pointer
set_context_table_pointer:
   set PAGE_TABLE_BASE, %g1
   set 0xc00, %g5
   add %g5, %g1, %g2
   srl  %g2, 0x4, %g2
   or  %g2, 0x1, %g2
   set 0x100, %g3
   sta %g2, [%g3] 0x4
   retl;
   nop;
! done: set  context-table-pointer
.align 1024
PAGE_TABLE_BASE: .skip 4096

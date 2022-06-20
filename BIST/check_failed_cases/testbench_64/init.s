.global _start;
.section .text.ajitstart
_start:
	
	set 0xfff01ff8, %sp
  	set 0xfff01f00, %fp
	!clr %fp

	set 0x1, %l0		! window 0 is marked invalid...  we start at window 7
	wr %l0, 0x0, %wim	!

	! trap table.
	set	trap_table_base, %l0
	wr	%l0, 0x0, %tbr

	! set up virtual -> physical map.
	call page_table_setup 	
	nop


	! set context table pointer.
	call set_context_table_pointer
	nop

	! enable traps.
	set 0x10E0, %l0	
	wr %l0, %psr


  	! enable mmu.
	set 0x1, %o0
	sta %o0, [%g0] 0xa   


	set test_program, %o0
	set results_section, %o1
	call main
	nop


!------------------------------------------


!-------------------------------------------

	ta 0
	nop

	.align 4
	.global test_program
	test_program:
	.skip 64000


	.data
	.align 32
	.global results_section
	results_section:

test_1_inp_1_1: .word 0x6c671
test_1_inp_1_2: .word 0x8906b7a0
test_1_inp_2_1: .word 0xda7b5c25
test_1_inp_2_2: .word 0x58d352cf
test_1_ajit_res_1: .word 0x0
test_1_ajit_res_2: .word 0x0
test_1_Cmodel_res_1: .word 0x0
test_1_Cmodel_res_2: .word 0x0

test_2_inp_1_1: .word 0x80074481
test_2_inp_1_2: .word 0xfbb8af2f
test_2_inp_2_1: .word 0x42a59202
test_2_inp_2_2: .word 0xe8e3f5b1
test_2_ajit_res_1: .word 0x80000000
test_2_ajit_res_2: .word 0xac
test_2_Cmodel_res_1: .word 0x0
test_2_Cmodel_res_2: .word 0x0

test_3_inp_1_1: .word 0xa1054
test_3_inp_1_2: .word 0x8bb32266
test_3_inp_2_1: .word 0xcdeab460
test_3_inp_2_2: .word 0x91641da2
test_3_ajit_res_1: .word 0x0
test_3_ajit_res_2: .word 0x0
test_3_Cmodel_res_1: .word 0x0
test_3_Cmodel_res_2: .word 0x0

test_4_inp_1_1: .word 0x8002c3a6
test_4_inp_1_2: .word 0xdb0fda3a
test_4_inp_2_1: .word 0x5d3028e6
test_4_inp_2_2: .word 0xb8140b0e
test_4_ajit_res_1: .word 0x0
test_4_ajit_res_2: .word 0x0
test_4_Cmodel_res_1: .word 0x0
test_4_Cmodel_res_2: .word 0x0

test_5_inp_1_1: .word 0xd8ea8
test_5_inp_1_2: .word 0x5377bb7a
test_5_inp_2_1: .word 0xf226c76e
test_5_inp_2_2: .word 0xbc48ca8c
test_5_ajit_res_1: .word 0x0
test_5_ajit_res_2: .word 0x0
test_5_Cmodel_res_1: .word 0x0
test_5_Cmodel_res_2: .word 0x0

test_6_inp_1_1: .word 0x800dfa60
test_6_inp_1_2: .word 0x7730058f
test_6_inp_2_1: .word 0x6fbdc1b2
test_6_inp_2_2: .word 0xb7e6e644
test_6_ajit_res_1: .word 0x0
test_6_ajit_res_2: .word 0x0
test_6_Cmodel_res_1: .word 0x0
test_6_Cmodel_res_2: .word 0x0

test_7_inp_1_1: .word 0x80031cd1
test_7_inp_1_2: .word 0xfd82b0a9
test_7_inp_2_1: .word 0x6ffea0a6
test_7_inp_2_2: .word 0x17d0bf88
test_7_ajit_res_1: .word 0x0
test_7_ajit_res_2: .word 0x0
test_7_Cmodel_res_1: .word 0x0
test_7_Cmodel_res_2: .word 0x0

test_8_inp_1_1: .word 0x80065e36
test_8_inp_1_2: .word 0xfaf4dc47
test_8_inp_2_1: .word 0x73624317
test_8_inp_2_2: .word 0x39c0c43f
test_8_ajit_res_1: .word 0x0
test_8_ajit_res_2: .word 0x0
test_8_Cmodel_res_1: .word 0x0
test_8_Cmodel_res_2: .word 0x0

test_9_inp_1_1: .word 0x58e28
test_9_inp_1_2: .word 0x7afa8744
test_9_inp_2_1: .word 0xc57228f9
test_9_inp_2_2: .word 0x82d2234a
test_9_ajit_res_1: .word 0x0
test_9_ajit_res_2: .word 0x0
test_9_Cmodel_res_1: .word 0x0
test_9_Cmodel_res_2: .word 0x0

test_10_inp_1_1: .word 0x800532ce
test_10_inp_1_2: .word 0x1b188521
test_10_inp_2_1: .word 0x6d0b8b19
test_10_inp_2_2: .word 0xe97ddc6b
test_10_ajit_res_1: .word 0x0
test_10_ajit_res_2: .word 0x0
test_10_Cmodel_res_1: .word 0x0
test_10_Cmodel_res_2: .word 0x0

test_11_inp_1_1: .word 0x800ef5ff
test_11_inp_1_2: .word 0x20bb4d66
test_11_inp_2_1: .word 0x53ff20c0
test_11_inp_2_2: .word 0xdd7da27c
test_11_ajit_res_1: .word 0x0
test_11_ajit_res_2: .word 0x0
test_11_Cmodel_res_1: .word 0x0
test_11_Cmodel_res_2: .word 0x0

test_12_inp_1_1: .word 0x26757
test_12_inp_1_2: .word 0x3bfcc948
test_12_inp_2_1: .word 0xff139608
test_12_inp_2_2: .word 0x362462da
test_12_ajit_res_1: .word 0x0
test_12_ajit_res_2: .word 0x0
test_12_Cmodel_res_1: .word 0x0
test_12_Cmodel_res_2: .word 0x0

test_13_inp_1_1: .word 0x9a3c7
test_13_inp_1_2: .word 0xa7a28a35
test_13_inp_2_1: .word 0xf99e778e
test_13_inp_2_2: .word 0x55cbe261
test_13_ajit_res_1: .word 0x0
test_13_ajit_res_2: .word 0x0
test_13_Cmodel_res_1: .word 0x0
test_13_Cmodel_res_2: .word 0x0

test_14_inp_1_1: .word 0x80050523
test_14_inp_1_2: .word 0x8d262ffb
test_14_inp_2_1: .word 0x66b81aff
test_14_inp_2_2: .word 0xbc80fd64
test_14_ajit_res_1: .word 0x0
test_14_ajit_res_2: .word 0x0
test_14_Cmodel_res_1: .word 0x0
test_14_Cmodel_res_2: .word 0x0

test_15_inp_1_1: .word 0x800c8ffd
test_15_inp_1_2: .word 0x948b1698
test_15_inp_2_1: .word 0x76bf447f
test_15_inp_2_2: .word 0x62dea6b5
test_15_ajit_res_1: .word 0x0
test_15_ajit_res_2: .word 0x0
test_15_Cmodel_res_1: .word 0x0
test_15_Cmodel_res_2: .word 0x0

test_16_inp_1_1: .word 0x800fd76c
test_16_inp_1_2: .word 0x8fce3bfc
test_16_inp_2_1: .word 0x57a5e659
test_16_inp_2_2: .word 0xd336d88b
test_16_ajit_res_1: .word 0x0
test_16_ajit_res_2: .word 0x0
test_16_Cmodel_res_1: .word 0x0
test_16_Cmodel_res_2: .word 0x0

test_17_inp_1_1: .word 0x80050791
test_17_inp_1_2: .word 0x7efc13f3
test_17_inp_2_1: .word 0x5e1fe4e8
test_17_inp_2_2: .word 0x8f537714
test_17_ajit_res_1: .word 0x0
test_17_ajit_res_2: .word 0x0
test_17_Cmodel_res_1: .word 0x0
test_17_Cmodel_res_2: .word 0x0

test_18_inp_1_1: .word 0xb43d9
test_18_inp_1_2: .word 0x435ab0ce
test_18_inp_2_1: .word 0xec7f09b6
test_18_inp_2_2: .word 0x9d37f62f
test_18_ajit_res_1: .word 0x0
test_18_ajit_res_2: .word 0x0
test_18_Cmodel_res_1: .word 0x0
test_18_Cmodel_res_2: .word 0x0

test_19_inp_1_1: .word 0x2eadd
test_19_inp_1_2: .word 0x608f7527
test_19_inp_2_1: .word 0xedc0fa2e
test_19_inp_2_2: .word 0x932dc20d
test_19_ajit_res_1: .word 0x0
test_19_ajit_res_2: .word 0x0
test_19_Cmodel_res_1: .word 0x0
test_19_Cmodel_res_2: .word 0x0

test_20_inp_1_1: .word 0x800ae746
test_20_inp_1_2: .word 0xe2aa15de
test_20_inp_2_1: .word 0x6bc171c6
test_20_inp_2_2: .word 0x6bbbf675
test_20_ajit_res_1: .word 0x0
test_20_ajit_res_2: .word 0x0
test_20_Cmodel_res_1: .word 0x0
test_20_Cmodel_res_2: .word 0x0

test_21_inp_1_1: .word 0x5a445
test_21_inp_1_2: .word 0x87e522a2
test_21_inp_2_1: .word 0xd0b5ad7c
test_21_inp_2_2: .word 0x51380067
test_21_ajit_res_1: .word 0x0
test_21_ajit_res_2: .word 0x0
test_21_Cmodel_res_1: .word 0x0
test_21_Cmodel_res_2: .word 0x0

test_22_inp_1_1: .word 0x800bb384
test_22_inp_1_2: .word 0x5b70918a
test_22_inp_2_1: .word 0x45fef53d
test_22_inp_2_2: .word 0x39815229
test_22_ajit_res_1: .word 0x0
test_22_ajit_res_2: .word 0x0
test_22_Cmodel_res_1: .word 0x0
test_22_Cmodel_res_2: .word 0x0

test_23_inp_1_1: .word 0x8006fe92
test_23_inp_1_2: .word 0x1b197fe0
test_23_inp_2_1: .word 0x48929993
test_23_inp_2_2: .word 0xbcb2b51f
test_23_ajit_res_1: .word 0x0
test_23_ajit_res_2: .word 0x0
test_23_Cmodel_res_1: .word 0x0
test_23_Cmodel_res_2: .word 0x0

test_24_inp_1_1: .word 0xdfe6c
test_24_inp_1_2: .word 0x1996e60d
test_24_inp_2_1: .word 0xe01c4c1f
test_24_inp_2_2: .word 0xa9dfe881
test_24_ajit_res_1: .word 0x0
test_24_ajit_res_2: .word 0x0
test_24_Cmodel_res_1: .word 0x0
test_24_Cmodel_res_2: .word 0x0

test_25_inp_1_1: .word 0x37a9
test_25_inp_1_2: .word 0xe3291fbe
test_25_inp_2_1: .word 0xe947f365
test_25_inp_2_2: .word 0x9d5d6201
test_25_ajit_res_1: .word 0x0
test_25_ajit_res_2: .word 0x0
test_25_Cmodel_res_1: .word 0x0
test_25_Cmodel_res_2: .word 0x0

test_26_inp_1_1: .word 0x800a8d97
test_26_inp_1_2: .word 0x576b9079
test_26_inp_2_1: .word 0x49aed5e8
test_26_inp_2_2: .word 0x231c7919
test_26_ajit_res_1: .word 0x0
test_26_ajit_res_2: .word 0x0
test_26_Cmodel_res_1: .word 0x0
test_26_Cmodel_res_2: .word 0x0

test_27_inp_1_1: .word 0x80048bff
test_27_inp_1_2: .word 0xe077a9a7
test_27_inp_2_1: .word 0x71216fcd
test_27_inp_2_2: .word 0x6901cf34
test_27_ajit_res_1: .word 0x0
test_27_ajit_res_2: .word 0x0
test_27_Cmodel_res_1: .word 0x0
test_27_Cmodel_res_2: .word 0x0

test_28_inp_1_1: .word 0x4e241
test_28_inp_1_2: .word 0x4ac78e29
test_28_inp_2_1: .word 0xd1c8a266
test_28_inp_2_2: .word 0xde9eab75
test_28_ajit_res_1: .word 0x0
test_28_ajit_res_2: .word 0x0
test_28_Cmodel_res_1: .word 0x0
test_28_Cmodel_res_2: .word 0x0

test_29_inp_1_1: .word 0x983d7
test_29_inp_1_2: .word 0x71b31075
test_29_inp_2_1: .word 0xf4f3480f
test_29_inp_2_2: .word 0x47b0cb15
test_29_ajit_res_1: .word 0x0
test_29_ajit_res_2: .word 0x0
test_29_Cmodel_res_1: .word 0x0
test_29_Cmodel_res_2: .word 0x0

test_30_inp_1_1: .word 0x8004aee7
test_30_inp_1_2: .word 0x273d8c9c
test_30_inp_2_1: .word 0x51591592
test_30_inp_2_2: .word 0x36895085
test_30_ajit_res_1: .word 0x0
test_30_ajit_res_2: .word 0x0
test_30_Cmodel_res_1: .word 0x0
test_30_Cmodel_res_2: .word 0x0

test_31_inp_1_1: .word 0x8005c75c
test_31_inp_1_2: .word 0xb6b11f3d
test_31_inp_2_1: .word 0x4bce2dd1
test_31_inp_2_2: .word 0xa4fa1243
test_31_ajit_res_1: .word 0x0
test_31_ajit_res_2: .word 0x0
test_31_Cmodel_res_1: .word 0x0
test_31_Cmodel_res_2: .word 0x0

test_32_inp_1_1: .word 0x6f444
test_32_inp_1_2: .word 0x244e7ae4
test_32_inp_2_1: .word 0xc9d7cda5
test_32_inp_2_2: .word 0xcee6df11
test_32_ajit_res_1: .word 0x0
test_32_ajit_res_2: .word 0x0
test_32_Cmodel_res_1: .word 0x0
test_32_Cmodel_res_2: .word 0x0

test_33_inp_1_1: .word 0xeee63
test_33_inp_1_2: .word 0xa9814cc2
test_33_inp_2_1: .word 0xe6eef057
test_33_inp_2_2: .word 0x5aaf3edb
test_33_ajit_res_1: .word 0x0
test_33_ajit_res_2: .word 0x0
test_33_Cmodel_res_1: .word 0x0
test_33_Cmodel_res_2: .word 0x0

test_34_inp_1_1: .word 0x80007ffb
test_34_inp_1_2: .word 0x946cd806
test_34_inp_2_1: .word 0x41fb1589
test_34_inp_2_2: .word 0x631ec036
test_34_ajit_res_1: .word 0x80000000
test_34_ajit_res_2: .word 0x4b9b
test_34_Cmodel_res_1: .word 0x0
test_34_Cmodel_res_2: .word 0x0

test_35_inp_1_1: .word 0x49fc0
test_35_inp_1_2: .word 0x5e9d89ca
test_35_inp_2_1: .word 0xd7733dcc
test_35_inp_2_2: .word 0xc8c98059
test_35_ajit_res_1: .word 0x0
test_35_ajit_res_2: .word 0x0
test_35_Cmodel_res_1: .word 0x0
test_35_Cmodel_res_2: .word 0x0

test_36_inp_1_1: .word 0x3d520
test_36_inp_1_2: .word 0xe28809f8
test_36_inp_2_1: .word 0xf1a9e603
test_36_inp_2_2: .word 0xcfa667eb
test_36_ajit_res_1: .word 0x0
test_36_ajit_res_2: .word 0x0
test_36_Cmodel_res_1: .word 0x0
test_36_Cmodel_res_2: .word 0x0

test_37_inp_1_1: .word 0xe1a92
test_37_inp_1_2: .word 0xff12b97
test_37_inp_2_1: .word 0xed4fe677
test_37_inp_2_2: .word 0x6ad6cc00
test_37_ajit_res_1: .word 0x0
test_37_ajit_res_2: .word 0x0
test_37_Cmodel_res_1: .word 0x0
test_37_Cmodel_res_2: .word 0x0

test_38_inp_1_1: .word 0x52b8c
test_38_inp_1_2: .word 0x1bbedb0f
test_38_inp_2_1: .word 0xc2104f17
test_38_inp_2_2: .word 0x3dac8579
test_38_ajit_res_1: .word 0x80000000
test_38_ajit_res_2: .word 0x1449e
test_38_Cmodel_res_1: .word 0x0
test_38_Cmodel_res_2: .word 0x0

test_39_inp_1_1: .word 0x80098204
test_39_inp_1_2: .word 0xc01888f
test_39_inp_2_1: .word 0x5189bb57
test_39_inp_2_2: .word 0xa5d6485e
test_39_ajit_res_1: .word 0x0
test_39_ajit_res_2: .word 0x0
test_39_Cmodel_res_1: .word 0x0
test_39_Cmodel_res_2: .word 0x0

test_40_inp_1_1: .word 0x800d471e
test_40_inp_1_2: .word 0x1f7895d2
test_40_inp_2_1: .word 0x5bae464a
test_40_inp_2_2: .word 0x4f2b5079
test_40_ajit_res_1: .word 0x0
test_40_ajit_res_2: .word 0x0
test_40_Cmodel_res_1: .word 0x0
test_40_Cmodel_res_2: .word 0x0

test_41_inp_1_1: .word 0xafacc
test_41_inp_1_2: .word 0xd2f71763
test_41_inp_2_1: .word 0xc567eea5
test_41_inp_2_2: .word 0x9761418d
test_41_ajit_res_1: .word 0x0
test_41_ajit_res_2: .word 0x0
test_41_Cmodel_res_1: .word 0x0
test_41_Cmodel_res_2: .word 0x0

test_42_inp_1_1: .word 0xc1a70
test_42_inp_1_2: .word 0x7deef74e
test_42_inp_2_1: .word 0xd9294164
test_42_inp_2_2: .word 0x4a013920
test_42_ajit_res_1: .word 0x0
test_42_ajit_res_2: .word 0x0
test_42_Cmodel_res_1: .word 0x0
test_42_Cmodel_res_2: .word 0x0

test_43_inp_1_1: .word 0xf431c
test_43_inp_1_2: .word 0x53ba860b
test_43_inp_2_1: .word 0x42ab5a03
test_43_inp_2_2: .word 0xf6f311c7
test_43_ajit_res_1: .word 0x0
test_43_ajit_res_2: .word 0x11d
test_43_Cmodel_res_1: .word 0x0
test_43_Cmodel_res_2: .word 0x0

test_44_inp_1_1: .word 0xb77ed
test_44_inp_1_2: .word 0x109823bc
test_44_inp_2_1: .word 0xdbaba9d9
test_44_inp_2_2: .word 0x11307cfb
test_44_ajit_res_1: .word 0x0
test_44_ajit_res_2: .word 0x0
test_44_Cmodel_res_1: .word 0x0
test_44_Cmodel_res_2: .word 0x0

test_45_inp_1_1: .word 0xbcc89
test_45_inp_1_2: .word 0x4d9a9ec7
test_45_inp_2_1: .word 0xf614840d
test_45_inp_2_2: .word 0x9e0afa3a
test_45_ajit_res_1: .word 0x0
test_45_ajit_res_2: .word 0x0
test_45_Cmodel_res_1: .word 0x0
test_45_Cmodel_res_2: .word 0x0

test_46_inp_1_1: .word 0x2c57f
test_46_inp_1_2: .word 0x8af84e69
test_46_inp_2_1: .word 0xc9d66a2e
test_46_inp_2_2: .word 0xcb5904b5
test_46_ajit_res_1: .word 0x0
test_46_ajit_res_2: .word 0x0
test_46_Cmodel_res_1: .word 0x0
test_46_Cmodel_res_2: .word 0x0

test_47_inp_1_1: .word 0x80015a9a
test_47_inp_1_2: .word 0x34506884
test_47_inp_2_1: .word 0x5275ea4c
test_47_inp_2_2: .word 0xcb986955
test_47_ajit_res_1: .word 0x0
test_47_ajit_res_2: .word 0x0
test_47_Cmodel_res_1: .word 0x0
test_47_Cmodel_res_2: .word 0x0

test_48_inp_1_1: .word 0x800c3873
test_48_inp_1_2: .word 0x5690ce48
test_48_inp_2_1: .word 0x5ac60d8a
test_48_inp_2_2: .word 0xf66f7dd4
test_48_ajit_res_1: .word 0x0
test_48_ajit_res_2: .word 0x0
test_48_Cmodel_res_1: .word 0x0
test_48_Cmodel_res_2: .word 0x0

test_49_inp_1_1: .word 0x7e002
test_49_inp_1_2: .word 0xc046056b
test_49_inp_2_1: .word 0xc83c9eaf
test_49_inp_2_2: .word 0x73a8b3a1
test_49_ajit_res_1: .word 0x0
test_49_ajit_res_2: .word 0x0
test_49_Cmodel_res_1: .word 0x0
test_49_Cmodel_res_2: .word 0x0

test_50_inp_1_1: .word 0x9b4e9
test_50_inp_1_2: .word 0xb81ab890
test_50_inp_2_1: .word 0xdb739f40
test_50_inp_2_2: .word 0x6914a9e1
test_50_ajit_res_1: .word 0x0
test_50_ajit_res_2: .word 0x0
test_50_Cmodel_res_1: .word 0x0
test_50_Cmodel_res_2: .word 0x0

test_51_inp_1_1: .word 0xe8951
test_51_inp_1_2: .word 0xa3545207
test_51_inp_2_1: .word 0xd1378acc
test_51_inp_2_2: .word 0x69809b63
test_51_ajit_res_1: .word 0x0
test_51_ajit_res_2: .word 0x0
test_51_Cmodel_res_1: .word 0x0
test_51_Cmodel_res_2: .word 0x0

test_52_inp_1_1: .word 0x5bd5e
test_52_inp_1_2: .word 0xc10e690b
test_52_inp_2_1: .word 0xe9f2dddb
test_52_inp_2_2: .word 0x5c055719
test_52_ajit_res_1: .word 0x0
test_52_ajit_res_2: .word 0x0
test_52_Cmodel_res_1: .word 0x0
test_52_Cmodel_res_2: .word 0x0

test_53_inp_1_1: .word 0x800f4c51
test_53_inp_1_2: .word 0x5dd42a8e
test_53_inp_2_1: .word 0x7a6db34d
test_53_inp_2_2: .word 0xcd82e15b
test_53_ajit_res_1: .word 0x0
test_53_ajit_res_2: .word 0x0
test_53_Cmodel_res_1: .word 0x0
test_53_Cmodel_res_2: .word 0x0

test_54_inp_1_1: .word 0x36a8e
test_54_inp_1_2: .word 0xd208a5f3
test_54_inp_2_1: .word 0xf502c7d9
test_54_inp_2_2: .word 0x9cba878
test_54_ajit_res_1: .word 0x0
test_54_ajit_res_2: .word 0x0
test_54_Cmodel_res_1: .word 0x0
test_54_Cmodel_res_2: .word 0x0

test_55_inp_1_1: .word 0x945e9
test_55_inp_1_2: .word 0xb69a35bd
test_55_inp_2_1: .word 0xfbf4d047
test_55_inp_2_2: .word 0x18e1ce96
test_55_ajit_res_1: .word 0x0
test_55_ajit_res_2: .word 0x0
test_55_Cmodel_res_1: .word 0x0
test_55_Cmodel_res_2: .word 0x0

test_56_inp_1_1: .word 0x800beb48
test_56_inp_1_2: .word 0x4514e49a
test_56_inp_2_1: .word 0x7de85e44
test_56_inp_2_2: .word 0x5b92abd3
test_56_ajit_res_1: .word 0x0
test_56_ajit_res_2: .word 0x0
test_56_Cmodel_res_1: .word 0x0
test_56_Cmodel_res_2: .word 0x0

test_57_inp_1_1: .word 0x800f5fa7
test_57_inp_1_2: .word 0xdb93cebb
test_57_inp_2_1: .word 0x531b219c
test_57_inp_2_2: .word 0x46cc27e6
test_57_ajit_res_1: .word 0x0
test_57_ajit_res_2: .word 0x0
test_57_Cmodel_res_1: .word 0x0
test_57_Cmodel_res_2: .word 0x0

test_58_inp_1_1: .word 0x8005200a
test_58_inp_1_2: .word 0x59aa7e6
test_58_inp_2_1: .word 0x7d4feff1
test_58_inp_2_2: .word 0x7596ab29
test_58_ajit_res_1: .word 0x0
test_58_ajit_res_2: .word 0x0
test_58_Cmodel_res_1: .word 0x0
test_58_Cmodel_res_2: .word 0x0

test_59_inp_1_1: .word 0x737f6
test_59_inp_1_2: .word 0xfafdb8c
test_59_inp_2_1: .word 0xc833c380
test_59_inp_2_2: .word 0x3d41e73b
test_59_ajit_res_1: .word 0x0
test_59_ajit_res_2: .word 0x0
test_59_Cmodel_res_1: .word 0x0
test_59_Cmodel_res_2: .word 0x0

test_60_inp_1_1: .word 0xfadd9
test_60_inp_1_2: .word 0x42088c33
test_60_inp_2_1: .word 0xf6ef6ac0
test_60_inp_2_2: .word 0x80fff1eb
test_60_ajit_res_1: .word 0x0
test_60_ajit_res_2: .word 0x0
test_60_Cmodel_res_1: .word 0x0
test_60_Cmodel_res_2: .word 0x0

test_61_inp_1_1: .word 0x800a2533
test_61_inp_1_2: .word 0x38e278e1
test_61_inp_2_1: .word 0x5e1e2888
test_61_inp_2_2: .word 0x61b1a450
test_61_ajit_res_1: .word 0x0
test_61_ajit_res_2: .word 0x0
test_61_Cmodel_res_1: .word 0x0
test_61_Cmodel_res_2: .word 0x0

test_62_inp_1_1: .word 0x800a3079
test_62_inp_1_2: .word 0xbd30e050
test_62_inp_2_1: .word 0x7a95d121
test_62_inp_2_2: .word 0x35589590
test_62_ajit_res_1: .word 0x0
test_62_ajit_res_2: .word 0x0
test_62_Cmodel_res_1: .word 0x0
test_62_Cmodel_res_2: .word 0x0

test_63_inp_1_1: .word 0x800e599c
test_63_inp_1_2: .word 0x6085a8fa
test_63_inp_2_1: .word 0x57643644
test_63_inp_2_2: .word 0x7667dd2b
test_63_ajit_res_1: .word 0x0
test_63_ajit_res_2: .word 0x0
test_63_Cmodel_res_1: .word 0x0
test_63_Cmodel_res_2: .word 0x0

test_64_inp_1_1: .word 0xecff0
test_64_inp_1_2: .word 0xdd689fff
test_64_inp_2_1: .word 0xf3a8dfe1
test_64_inp_2_2: .word 0xd70a5100
test_64_ajit_res_1: .word 0x0
test_64_ajit_res_2: .word 0x0
test_64_Cmodel_res_1: .word 0x0
test_64_Cmodel_res_2: .word 0x0

test_65_inp_1_1: .word 0x8001e882
test_65_inp_1_2: .word 0xf1a1cd9
test_65_inp_2_1: .word 0x6da6d603
test_65_inp_2_2: .word 0xf3583ea0
test_65_ajit_res_1: .word 0x0
test_65_ajit_res_2: .word 0x0
test_65_Cmodel_res_1: .word 0x0
test_65_Cmodel_res_2: .word 0x0

test_66_inp_1_1: .word 0x800dd015
test_66_inp_1_2: .word 0x40bc8fd0
test_66_inp_2_1: .word 0x52f48f3a
test_66_inp_2_2: .word 0xd17a02cf
test_66_ajit_res_1: .word 0x0
test_66_ajit_res_2: .word 0x0
test_66_Cmodel_res_1: .word 0x0
test_66_Cmodel_res_2: .word 0x0

test_67_inp_1_1: .word 0x800d12f4
test_67_inp_1_2: .word 0x21bd8cc0
test_67_inp_2_1: .word 0x736e9fe5
test_67_inp_2_2: .word 0x98b7c7d9
test_67_ajit_res_1: .word 0x0
test_67_ajit_res_2: .word 0x0
test_67_Cmodel_res_1: .word 0x0
test_67_Cmodel_res_2: .word 0x0

test_68_inp_1_1: .word 0x75963
test_68_inp_1_2: .word 0x4f5c7b6a
test_68_inp_2_1: .word 0xc356a58b
test_68_inp_2_2: .word 0x6389591c
test_68_ajit_res_1: .word 0x0
test_68_ajit_res_2: .word 0x0
test_68_Cmodel_res_1: .word 0x0
test_68_Cmodel_res_2: .word 0x0

test_69_inp_1_1: .word 0xc656d
test_69_inp_1_2: .word 0x14af4ce2
test_69_inp_2_1: .word 0xd5a73de5
test_69_inp_2_2: .word 0xd93f6afb
test_69_ajit_res_1: .word 0x0
test_69_ajit_res_2: .word 0x0
test_69_Cmodel_res_1: .word 0x0
test_69_Cmodel_res_2: .word 0x0

test_70_inp_1_1: .word 0x800abe86
test_70_inp_1_2: .word 0x5ea2a882
test_70_inp_2_1: .word 0x5a0bbef3
test_70_inp_2_2: .word 0xb5038d53
test_70_ajit_res_1: .word 0x0
test_70_ajit_res_2: .word 0x0
test_70_Cmodel_res_1: .word 0x0
test_70_Cmodel_res_2: .word 0x0

test_71_inp_1_1: .word 0x2ba43
test_71_inp_1_2: .word 0x27186237
test_71_inp_2_1: .word 0xe5969d0d
test_71_inp_2_2: .word 0x156e3f33
test_71_ajit_res_1: .word 0x0
test_71_ajit_res_2: .word 0x0
test_71_Cmodel_res_1: .word 0x0
test_71_Cmodel_res_2: .word 0x0

test_72_inp_1_1: .word 0x800d3bb5
test_72_inp_1_2: .word 0x26a96252
test_72_inp_2_1: .word 0x53301db3
test_72_inp_2_2: .word 0x2dae416
test_72_ajit_res_1: .word 0x0
test_72_ajit_res_2: .word 0x0
test_72_Cmodel_res_1: .word 0x0
test_72_Cmodel_res_2: .word 0x0

test_73_inp_1_1: .word 0x800f540f
test_73_inp_1_2: .word 0x7e8ec956
test_73_inp_2_1: .word 0x59a4337f
test_73_inp_2_2: .word 0x98634144
test_73_ajit_res_1: .word 0x0
test_73_ajit_res_2: .word 0x0
test_73_Cmodel_res_1: .word 0x0
test_73_Cmodel_res_2: .word 0x0

test_74_inp_1_1: .word 0xd3650
test_74_inp_1_2: .word 0xe0e030d2
test_74_inp_2_1: .word 0xf250fa77
test_74_inp_2_2: .word 0x77518433
test_74_ajit_res_1: .word 0x0
test_74_ajit_res_2: .word 0x0
test_74_Cmodel_res_1: .word 0x0
test_74_Cmodel_res_2: .word 0x0

test_75_inp_1_1: .word 0xbecda
test_75_inp_1_2: .word 0xaec6286b
test_75_inp_2_1: .word 0xdc488649
test_75_inp_2_2: .word 0xd2eadefb
test_75_ajit_res_1: .word 0x0
test_75_ajit_res_2: .word 0x0
test_75_Cmodel_res_1: .word 0x0
test_75_Cmodel_res_2: .word 0x0

test_76_inp_1_1: .word 0x800f415f
test_76_inp_1_2: .word 0x294e807e
test_76_inp_2_1: .word 0x4557a459
test_76_inp_2_2: .word 0x914fc2fe
test_76_ajit_res_1: .word 0x0
test_76_ajit_res_2: .word 0x0
test_76_Cmodel_res_1: .word 0x0
test_76_Cmodel_res_2: .word 0x0

test_77_inp_1_1: .word 0x80085add
test_77_inp_1_2: .word 0xfa78c898
test_77_inp_2_1: .word 0x7cd34f03
test_77_inp_2_2: .word 0xf8bf1f09
test_77_ajit_res_1: .word 0x0
test_77_ajit_res_2: .word 0x0
test_77_Cmodel_res_1: .word 0x0
test_77_Cmodel_res_2: .word 0x0

test_78_inp_1_1: .word 0x800bf560
test_78_inp_1_2: .word 0x435a4b89
test_78_inp_2_1: .word 0x5cd54a8f
test_78_inp_2_2: .word 0x66833d5e
test_78_ajit_res_1: .word 0x0
test_78_ajit_res_2: .word 0x0
test_78_Cmodel_res_1: .word 0x0
test_78_Cmodel_res_2: .word 0x0

test_79_inp_1_1: .word 0xd5a1a
test_79_inp_1_2: .word 0xa8fd6cfa
test_79_inp_2_1: .word 0xe0778dca
test_79_inp_2_2: .word 0xde2ee8a3
test_79_ajit_res_1: .word 0x0
test_79_ajit_res_2: .word 0x0
test_79_Cmodel_res_1: .word 0x0
test_79_Cmodel_res_2: .word 0x0

test_80_inp_1_1: .word 0x800e2615
test_80_inp_1_2: .word 0x943229a2
test_80_inp_2_1: .word 0x5339c0f2
test_80_inp_2_2: .word 0x3c466571
test_80_ajit_res_1: .word 0x0
test_80_ajit_res_2: .word 0x0
test_80_Cmodel_res_1: .word 0x0
test_80_Cmodel_res_2: .word 0x0

test_81_inp_1_1: .word 0xc9b37
test_81_inp_1_2: .word 0x82b0edf0
test_81_inp_2_1: .word 0xd401a7d6
test_81_inp_2_2: .word 0xbc66f02b
test_81_ajit_res_1: .word 0x0
test_81_ajit_res_2: .word 0x0
test_81_Cmodel_res_1: .word 0x0
test_81_Cmodel_res_2: .word 0x0

test_82_inp_1_1: .word 0x7e02c
test_82_inp_1_2: .word 0xbac70e5a
test_82_inp_2_1: .word 0xd9a8d4ee
test_82_inp_2_2: .word 0x1e3656c6
test_82_ajit_res_1: .word 0x0
test_82_ajit_res_2: .word 0x0
test_82_Cmodel_res_1: .word 0x0
test_82_Cmodel_res_2: .word 0x0

test_83_inp_1_1: .word 0x800b6a6b
test_83_inp_1_2: .word 0x85841b6
test_83_inp_2_1: .word 0x78a4c7aa
test_83_inp_2_2: .word 0x79045cb5
test_83_ajit_res_1: .word 0x0
test_83_ajit_res_2: .word 0x0
test_83_Cmodel_res_1: .word 0x0
test_83_Cmodel_res_2: .word 0x0

test_84_inp_1_1: .word 0x800f678f
test_84_inp_1_2: .word 0x5fb49cea
test_84_inp_2_1: .word 0x74a16e02
test_84_inp_2_2: .word 0x21178f53
test_84_ajit_res_1: .word 0x0
test_84_ajit_res_2: .word 0x0
test_84_Cmodel_res_1: .word 0x0
test_84_Cmodel_res_2: .word 0x0

test_85_inp_1_1: .word 0x80062954
test_85_inp_1_2: .word 0x1448e633
test_85_inp_2_1: .word 0x4a0757b5
test_85_inp_2_2: .word 0x84e19b3f
test_85_ajit_res_1: .word 0x0
test_85_ajit_res_2: .word 0x0
test_85_Cmodel_res_1: .word 0x0
test_85_Cmodel_res_2: .word 0x0

test_86_inp_1_1: .word 0x800d3503
test_86_inp_1_2: .word 0x69484fa1
test_86_inp_2_1: .word 0x5d79ca60
test_86_inp_2_2: .word 0x1a81177e
test_86_ajit_res_1: .word 0x0
test_86_ajit_res_2: .word 0x0
test_86_Cmodel_res_1: .word 0x0
test_86_Cmodel_res_2: .word 0x0

test_87_inp_1_1: .word 0x2b164
test_87_inp_1_2: .word 0x5a77c2c5
test_87_inp_2_1: .word 0xc4d22888
test_87_inp_2_2: .word 0x8f6b3c00
test_87_ajit_res_1: .word 0x0
test_87_ajit_res_2: .word 0x0
test_87_Cmodel_res_1: .word 0x0
test_87_Cmodel_res_2: .word 0x0

test_88_inp_1_1: .word 0x800874de
test_88_inp_1_2: .word 0x37f647e6
test_88_inp_2_1: .word 0xc21948ad
test_88_inp_2_2: .word 0x9b2692e9
test_88_ajit_res_1: .word 0x0
test_88_ajit_res_2: .word 0x1567d
test_88_Cmodel_res_1: .word 0x0
test_88_Cmodel_res_2: .word 0x0

test_89_inp_1_1: .word 0x8001288c
test_89_inp_1_2: .word 0xbba71fea
test_89_inp_2_1: .word 0x6e5a0f52
test_89_inp_2_2: .word 0x7e40eb55
test_89_ajit_res_1: .word 0x0
test_89_ajit_res_2: .word 0x0
test_89_Cmodel_res_1: .word 0x0
test_89_Cmodel_res_2: .word 0x0

test_90_inp_1_1: .word 0xace81
test_90_inp_1_2: .word 0x1bd5b3c
test_90_inp_2_1: .word 0xf307d475
test_90_inp_2_2: .word 0x1a9b6e8a
test_90_ajit_res_1: .word 0x0
test_90_ajit_res_2: .word 0x0
test_90_Cmodel_res_1: .word 0x0
test_90_Cmodel_res_2: .word 0x0

test_91_inp_1_1: .word 0xcee0d
test_91_inp_1_2: .word 0x28b358bf
test_91_inp_2_1: .word 0xc7bd7bca
test_91_inp_2_2: .word 0x96bff1ce
test_91_ajit_res_1: .word 0x0
test_91_ajit_res_2: .word 0x0
test_91_Cmodel_res_1: .word 0x0
test_91_Cmodel_res_2: .word 0x0

test_92_inp_1_1: .word 0xd4e77
test_92_inp_1_2: .word 0xb37306e2
test_92_inp_2_1: .word 0xd6d3df79
test_92_inp_2_2: .word 0xd0d6186f
test_92_ajit_res_1: .word 0x0
test_92_ajit_res_2: .word 0x0
test_92_Cmodel_res_1: .word 0x0
test_92_Cmodel_res_2: .word 0x0

test_93_inp_1_1: .word 0x2825a
test_93_inp_1_2: .word 0x88b7ccc0
test_93_inp_2_1: .word 0xe20b3371
test_93_inp_2_2: .word 0xcf7f9359
test_93_ajit_res_1: .word 0x0
test_93_ajit_res_2: .word 0x0
test_93_Cmodel_res_1: .word 0x0
test_93_Cmodel_res_2: .word 0x0

test_94_inp_1_1: .word 0x800fccd3
test_94_inp_1_2: .word 0x24e03cd3
test_94_inp_2_1: .word 0x6f397966
test_94_inp_2_2: .word 0xede8a86a
test_94_ajit_res_1: .word 0x0
test_94_ajit_res_2: .word 0x0
test_94_Cmodel_res_1: .word 0x0
test_94_Cmodel_res_2: .word 0x0

test_95_inp_1_1: .word 0x1d7b3
test_95_inp_1_2: .word 0x89024e93
test_95_inp_2_1: .word 0xf742077d
test_95_inp_2_2: .word 0xfacd8ece
test_95_ajit_res_1: .word 0x0
test_95_ajit_res_2: .word 0x0
test_95_Cmodel_res_1: .word 0x0
test_95_Cmodel_res_2: .word 0x0

test_96_inp_1_1: .word 0x55574
test_96_inp_1_2: .word 0xe65e0639
test_96_inp_2_1: .word 0xc4518f84
test_96_inp_2_2: .word 0x703e1475
test_96_ajit_res_1: .word 0x0
test_96_ajit_res_2: .word 0x0
test_96_Cmodel_res_1: .word 0x0
test_96_Cmodel_res_2: .word 0x0

test_97_inp_1_1: .word 0x800417d9
test_97_inp_1_2: .word 0x120d3e5b
test_97_inp_2_1: .word 0x678822a8
test_97_inp_2_2: .word 0x2163d2e7
test_97_ajit_res_1: .word 0x0
test_97_ajit_res_2: .word 0x0
test_97_Cmodel_res_1: .word 0x0
test_97_Cmodel_res_2: .word 0x0

test_98_inp_1_1: .word 0x8008f063
test_98_inp_1_2: .word 0x417d2e91
test_98_inp_2_1: .word 0x71e80bb0
test_98_inp_2_2: .word 0xdc7e508c
test_98_ajit_res_1: .word 0x0
test_98_ajit_res_2: .word 0x0
test_98_Cmodel_res_1: .word 0x0
test_98_Cmodel_res_2: .word 0x0

test_99_inp_1_1: .word 0xc0468
test_99_inp_1_2: .word 0x7a3a7b3a
test_99_inp_2_1: .word 0xcc0c5f56
test_99_inp_2_2: .word 0x69af814c
test_99_ajit_res_1: .word 0x0
test_99_ajit_res_2: .word 0x0
test_99_Cmodel_res_1: .word 0x0
test_99_Cmodel_res_2: .word 0x0

test_100_inp_1_1: .word 0x56271
test_100_inp_1_2: .word 0x741def18
test_100_inp_2_1: .word 0xc242e2b1
test_100_inp_2_2: .word 0x9e112c6
test_100_ajit_res_1: .word 0x80000000
test_100_ajit_res_2: .word 0x247e
test_100_Cmodel_res_1: .word 0x0
test_100_Cmodel_res_2: .word 0x0

test_101_inp_1_1: .word 0x800a80d2
test_101_inp_1_2: .word 0xfcc90bdb
test_101_inp_2_1: .word 0x48926ae7
test_101_inp_2_2: .word 0x54110f0c
test_101_ajit_res_1: .word 0x0
test_101_ajit_res_2: .word 0x0
test_101_Cmodel_res_1: .word 0x0
test_101_Cmodel_res_2: .word 0x0

test_102_inp_1_1: .word 0x9c933
test_102_inp_1_2: .word 0xc992dad8
test_102_inp_2_1: .word 0xcd5aecb9
test_102_inp_2_2: .word 0x336496d
test_102_ajit_res_1: .word 0x0
test_102_ajit_res_2: .word 0x0
test_102_Cmodel_res_1: .word 0x0
test_102_Cmodel_res_2: .word 0x0

test_103_inp_1_1: .word 0x800212a8
test_103_inp_1_2: .word 0x6dd32270
test_103_inp_2_1: .word 0x67e62a30
test_103_inp_2_2: .word 0x1de61834
test_103_ajit_res_1: .word 0x0
test_103_ajit_res_2: .word 0x0
test_103_Cmodel_res_1: .word 0x0
test_103_Cmodel_res_2: .word 0x0

test_104_inp_1_1: .word 0xc5c73
test_104_inp_1_2: .word 0x26d0080c
test_104_inp_2_1: .word 0xf7fd77e4
test_104_inp_2_2: .word 0x23a62b1c
test_104_ajit_res_1: .word 0x0
test_104_ajit_res_2: .word 0x0
test_104_Cmodel_res_1: .word 0x0
test_104_Cmodel_res_2: .word 0x0

test_105_inp_1_1: .word 0xff8ad
test_105_inp_1_2: .word 0xbe864a8a
test_105_inp_2_1: .word 0xe010a192
test_105_inp_2_2: .word 0xc406a49f
test_105_ajit_res_1: .word 0x0
test_105_ajit_res_2: .word 0x0
test_105_Cmodel_res_1: .word 0x0
test_105_Cmodel_res_2: .word 0x0

test_106_inp_1_1: .word 0x80031a2a
test_106_inp_1_2: .word 0xe4041b4a
test_106_inp_2_1: .word 0x5f9cad60
test_106_inp_2_2: .word 0x305b81fc
test_106_ajit_res_1: .word 0x0
test_106_ajit_res_2: .word 0x0
test_106_Cmodel_res_1: .word 0x0
test_106_Cmodel_res_2: .word 0x0

test_107_inp_1_1: .word 0x8004512d
test_107_inp_1_2: .word 0x5440db94
test_107_inp_2_1: .word 0x4825130a
test_107_inp_2_2: .word 0x7bea3f23
test_107_ajit_res_1: .word 0x0
test_107_ajit_res_2: .word 0x0
test_107_Cmodel_res_1: .word 0x0
test_107_Cmodel_res_2: .word 0x0

test_108_inp_1_1: .word 0x800c9db4
test_108_inp_1_2: .word 0xf0319c5a
test_108_inp_2_1: .word 0x48be7bce
test_108_inp_2_2: .word 0xf5f9a9e2
test_108_ajit_res_1: .word 0x0
test_108_ajit_res_2: .word 0x0
test_108_Cmodel_res_1: .word 0x0
test_108_Cmodel_res_2: .word 0x0

test_109_inp_1_1: .word 0x80094a1a
test_109_inp_1_2: .word 0x805c82b5
test_109_inp_2_1: .word 0x6b9d0a71
test_109_inp_2_2: .word 0x5fca36f0
test_109_ajit_res_1: .word 0x0
test_109_ajit_res_2: .word 0x0
test_109_Cmodel_res_1: .word 0x0
test_109_Cmodel_res_2: .word 0x0

test_110_inp_1_1: .word 0x8003d574
test_110_inp_1_2: .word 0xdfb4bed0
test_110_inp_2_1: .word 0x764c4de3
test_110_inp_2_2: .word 0x8ba463ad
test_110_ajit_res_1: .word 0x0
test_110_ajit_res_2: .word 0x0
test_110_Cmodel_res_1: .word 0x0
test_110_Cmodel_res_2: .word 0x0

test_111_inp_1_1: .word 0x80087eed
test_111_inp_1_2: .word 0x71b69619
test_111_inp_2_1: .word 0x6790731c
test_111_inp_2_2: .word 0xaed95d75
test_111_ajit_res_1: .word 0x0
test_111_ajit_res_2: .word 0x0
test_111_Cmodel_res_1: .word 0x0
test_111_Cmodel_res_2: .word 0x0

test_112_inp_1_1: .word 0x8001ef6d
test_112_inp_1_2: .word 0x5b7c976a
test_112_inp_2_1: .word 0x6562448f
test_112_inp_2_2: .word 0x258af4c4
test_112_ajit_res_1: .word 0x0
test_112_ajit_res_2: .word 0x0
test_112_Cmodel_res_1: .word 0x0
test_112_Cmodel_res_2: .word 0x0

test_113_inp_1_1: .word 0x80086e29
test_113_inp_1_2: .word 0x119bc0ba
test_113_inp_2_1: .word 0x556bcc3d
test_113_inp_2_2: .word 0x6e2999bb
test_113_ajit_res_1: .word 0x0
test_113_ajit_res_2: .word 0x0
test_113_Cmodel_res_1: .word 0x0
test_113_Cmodel_res_2: .word 0x0

test_114_inp_1_1: .word 0xb9614
test_114_inp_1_2: .word 0x6b46bfc0
test_114_inp_2_1: .word 0xddf362c5
test_114_inp_2_2: .word 0xc0b9c2bf
test_114_ajit_res_1: .word 0x0
test_114_ajit_res_2: .word 0x0
test_114_Cmodel_res_1: .word 0x0
test_114_Cmodel_res_2: .word 0x0

test_115_inp_1_1: .word 0x525fa
test_115_inp_1_2: .word 0xc09e75f2
test_115_inp_2_1: .word 0xff57916a
test_115_inp_2_2: .word 0x370e7599
test_115_ajit_res_1: .word 0x0
test_115_ajit_res_2: .word 0x0
test_115_Cmodel_res_1: .word 0x0
test_115_Cmodel_res_2: .word 0x0

test_116_inp_1_1: .word 0x800eac68
test_116_inp_1_2: .word 0xd5a47892
test_116_inp_2_1: .word 0x47a975b7
test_116_inp_2_2: .word 0x4bc554e3
test_116_ajit_res_1: .word 0x0
test_116_ajit_res_2: .word 0x0
test_116_Cmodel_res_1: .word 0x0
test_116_Cmodel_res_2: .word 0x0

test_117_inp_1_1: .word 0x146e1
test_117_inp_1_2: .word 0x14567b07
test_117_inp_2_1: .word 0xd49867a2
test_117_inp_2_2: .word 0xe0e2f631
test_117_ajit_res_1: .word 0x0
test_117_ajit_res_2: .word 0x0
test_117_Cmodel_res_1: .word 0x0
test_117_Cmodel_res_2: .word 0x0

test_118_inp_1_1: .word 0x47d97
test_118_inp_1_2: .word 0xdbea075b
test_118_inp_2_1: .word 0xe0c8091d
test_118_inp_2_2: .word 0x49c09a1e
test_118_ajit_res_1: .word 0x0
test_118_ajit_res_2: .word 0x0
test_118_Cmodel_res_1: .word 0x0
test_118_Cmodel_res_2: .word 0x0

test_119_inp_1_1: .word 0x94e59
test_119_inp_1_2: .word 0xd89fe007
test_119_inp_2_1: .word 0xf3e2100c
test_119_inp_2_2: .word 0xccd83e07
test_119_ajit_res_1: .word 0x0
test_119_ajit_res_2: .word 0x0
test_119_Cmodel_res_1: .word 0x0
test_119_Cmodel_res_2: .word 0x0

test_120_inp_1_1: .word 0x333fd
test_120_inp_1_2: .word 0xf6f9aaab
test_120_inp_2_1: .word 0xd36a586f
test_120_inp_2_2: .word 0xa057933e
test_120_ajit_res_1: .word 0x0
test_120_ajit_res_2: .word 0x0
test_120_Cmodel_res_1: .word 0x0
test_120_Cmodel_res_2: .word 0x0

test_121_inp_1_1: .word 0x7f8ef
test_121_inp_1_2: .word 0xbd276686
test_121_inp_2_1: .word 0xd4e695fd
test_121_inp_2_2: .word 0x54c249cb
test_121_ajit_res_1: .word 0x0
test_121_ajit_res_2: .word 0x0
test_121_Cmodel_res_1: .word 0x0
test_121_Cmodel_res_2: .word 0x0

test_122_inp_1_1: .word 0x7fa90
test_122_inp_1_2: .word 0xcbabd827
test_122_inp_2_1: .word 0xec5bdfbe
test_122_inp_2_2: .word 0xb7606657
test_122_ajit_res_1: .word 0x0
test_122_ajit_res_2: .word 0x0
test_122_Cmodel_res_1: .word 0x0
test_122_Cmodel_res_2: .word 0x0

test_123_inp_1_1: .word 0xbaa79
test_123_inp_1_2: .word 0xcbf4bd3a
test_123_inp_2_1: .word 0xc6037ff7
test_123_inp_2_2: .word 0xe76b5ac0
test_123_ajit_res_1: .word 0x0
test_123_ajit_res_2: .word 0x0
test_123_Cmodel_res_1: .word 0x0
test_123_Cmodel_res_2: .word 0x0

test_124_inp_1_1: .word 0xf3282
test_124_inp_1_2: .word 0x5a8102f5
test_124_inp_2_1: .word 0xcd393b75
test_124_inp_2_2: .word 0xe54a1db0
test_124_ajit_res_1: .word 0x0
test_124_ajit_res_2: .word 0x0
test_124_Cmodel_res_1: .word 0x0
test_124_Cmodel_res_2: .word 0x0

test_125_inp_1_1: .word 0x800825b5
test_125_inp_1_2: .word 0x66920949
test_125_inp_2_1: .word 0x7c6f079d
test_125_inp_2_2: .word 0x57c25f1b
test_125_ajit_res_1: .word 0x0
test_125_ajit_res_2: .word 0x0
test_125_Cmodel_res_1: .word 0x0
test_125_Cmodel_res_2: .word 0x0

test_126_inp_1_1: .word 0xb4bc0
test_126_inp_1_2: .word 0x53d74d51
test_126_inp_2_1: .word 0xd35af92a
test_126_inp_2_2: .word 0xe01f978b
test_126_ajit_res_1: .word 0x0
test_126_ajit_res_2: .word 0x0
test_126_Cmodel_res_1: .word 0x0
test_126_Cmodel_res_2: .word 0x0

test_127_inp_1_1: .word 0x80014cee
test_127_inp_1_2: .word 0xd470b1d0
test_127_inp_2_1: .word 0x608b48d0
test_127_inp_2_2: .word 0x4aa824b3
test_127_ajit_res_1: .word 0x0
test_127_ajit_res_2: .word 0x0
test_127_Cmodel_res_1: .word 0x0
test_127_Cmodel_res_2: .word 0x0

test_128_inp_1_1: .word 0x800f8d11
test_128_inp_1_2: .word 0xbc2b0b71
test_128_inp_2_1: .word 0xc23ca81e
test_128_inp_2_2: .word 0xb6b1a127
test_128_ajit_res_1: .word 0x0
test_128_ajit_res_2: .word 0x8aec
test_128_Cmodel_res_1: .word 0x0
test_128_Cmodel_res_2: .word 0x0

test_129_inp_1_1: .word 0xc85ca
test_129_inp_1_2: .word 0xb8d99632
test_129_inp_2_1: .word 0xc9b8cb63
test_129_inp_2_2: .word 0xfa37e99e
test_129_ajit_res_1: .word 0x0
test_129_ajit_res_2: .word 0x0
test_129_Cmodel_res_1: .word 0x0
test_129_Cmodel_res_2: .word 0x0

test_130_inp_1_1: .word 0xe96bf
test_130_inp_1_2: .word 0xb920d2ce
test_130_inp_2_1: .word 0xf1f49b27
test_130_inp_2_2: .word 0x55e9e0eb
test_130_ajit_res_1: .word 0x0
test_130_ajit_res_2: .word 0x0
test_130_Cmodel_res_1: .word 0x0
test_130_Cmodel_res_2: .word 0x0

test_131_inp_1_1: .word 0x800c2c43
test_131_inp_1_2: .word 0xaedfd6d7
test_131_inp_2_1: .word 0x76dad871
test_131_inp_2_2: .word 0x1dd93cba
test_131_ajit_res_1: .word 0x0
test_131_ajit_res_2: .word 0x0
test_131_Cmodel_res_1: .word 0x0
test_131_Cmodel_res_2: .word 0x0

test_132_inp_1_1: .word 0xfad01
test_132_inp_1_2: .word 0x702eb058
test_132_inp_2_1: .word 0xc93a62d1
test_132_inp_2_2: .word 0x5919fb38
test_132_ajit_res_1: .word 0x0
test_132_ajit_res_2: .word 0x0
test_132_Cmodel_res_1: .word 0x0
test_132_Cmodel_res_2: .word 0x0

test_133_inp_1_1: .word 0x35f8f
test_133_inp_1_2: .word 0x3e65548a
test_133_inp_2_1: .word 0xf71e5a88
test_133_inp_2_2: .word 0xea9bfca3
test_133_ajit_res_1: .word 0x0
test_133_ajit_res_2: .word 0x0
test_133_Cmodel_res_1: .word 0x0
test_133_Cmodel_res_2: .word 0x0

test_134_inp_1_1: .word 0x8009527b
test_134_inp_1_2: .word 0x3c852534
test_134_inp_2_1: .word 0x54ebe7a7
test_134_inp_2_2: .word 0x8befe27e
test_134_ajit_res_1: .word 0x0
test_134_ajit_res_2: .word 0x0
test_134_Cmodel_res_1: .word 0x0
test_134_Cmodel_res_2: .word 0x0

test_135_inp_1_1: .word 0x8003bac6
test_135_inp_1_2: .word 0xc356da7e
test_135_inp_2_1: .word 0x5978743b
test_135_inp_2_2: .word 0x10bd284a
test_135_ajit_res_1: .word 0x0
test_135_ajit_res_2: .word 0x0
test_135_Cmodel_res_1: .word 0x0
test_135_Cmodel_res_2: .word 0x0

test_136_inp_1_1: .word 0xcdaf6
test_136_inp_1_2: .word 0x1a974976
test_136_inp_2_1: .word 0xf2ecc92a
test_136_inp_2_2: .word 0x4e96fa64
test_136_ajit_res_1: .word 0x0
test_136_ajit_res_2: .word 0x0
test_136_Cmodel_res_1: .word 0x0
test_136_Cmodel_res_2: .word 0x0

test_137_inp_1_1: .word 0xfe3ae
test_137_inp_1_2: .word 0x570c526c
test_137_inp_2_1: .word 0xfb2198eb
test_137_inp_2_2: .word 0xe16b51c8
test_137_ajit_res_1: .word 0x0
test_137_ajit_res_2: .word 0x0
test_137_Cmodel_res_1: .word 0x0
test_137_Cmodel_res_2: .word 0x0

test_138_inp_1_1: .word 0x80029f1f
test_138_inp_1_2: .word 0x45270d5d
test_138_inp_2_1: .word 0x585ef2df
test_138_inp_2_2: .word 0xbbcbb407
test_138_ajit_res_1: .word 0x0
test_138_ajit_res_2: .word 0x0
test_138_Cmodel_res_1: .word 0x0
test_138_Cmodel_res_2: .word 0x0

test_139_inp_1_1: .word 0xc3da1
test_139_inp_1_2: .word 0xd760e2d5
test_139_inp_2_1: .word 0xca55961b
test_139_inp_2_2: .word 0x3c0c3650
test_139_ajit_res_1: .word 0x0
test_139_ajit_res_2: .word 0x0
test_139_Cmodel_res_1: .word 0x0
test_139_Cmodel_res_2: .word 0x0

test_140_inp_1_1: .word 0x80087575
test_140_inp_1_2: .word 0x7052248
test_140_inp_2_1: .word 0x434f682b
test_140_inp_2_2: .word 0xfc12ba0c
test_140_ajit_res_1: .word 0x0
test_140_ajit_res_2: .word 0x0
test_140_Cmodel_res_1: .word 0x0
test_140_Cmodel_res_2: .word 0x0

test_141_inp_1_1: .word 0x800eb53c
test_141_inp_1_2: .word 0x871c6940
test_141_inp_2_1: .word 0x423adfd4
test_141_inp_2_2: .word 0xb7040192
test_141_ajit_res_1: .word 0x80000000
test_141_ajit_res_2: .word 0x8c1a
test_141_Cmodel_res_1: .word 0x0
test_141_Cmodel_res_2: .word 0x0

test_142_inp_1_1: .word 0x80017902
test_142_inp_1_2: .word 0xd04c50b6
test_142_inp_2_1: .word 0x5507d891
test_142_inp_2_2: .word 0x7c02597
test_142_ajit_res_1: .word 0x0
test_142_ajit_res_2: .word 0x0
test_142_Cmodel_res_1: .word 0x0
test_142_Cmodel_res_2: .word 0x0

test_143_inp_1_1: .word 0x8005a114
test_143_inp_1_2: .word 0xdbdd3f5c
test_143_inp_2_1: .word 0x4d3af186
test_143_inp_2_2: .word 0x68ad222
test_143_ajit_res_1: .word 0x0
test_143_ajit_res_2: .word 0x0
test_143_Cmodel_res_1: .word 0x0
test_143_Cmodel_res_2: .word 0x0

test_144_inp_1_1: .word 0x800ce269
test_144_inp_1_2: .word 0x5e1b7aa7
test_144_inp_2_1: .word 0x6b6cc063
test_144_inp_2_2: .word 0x6e090592
test_144_ajit_res_1: .word 0x0
test_144_ajit_res_2: .word 0x0
test_144_Cmodel_res_1: .word 0x0
test_144_Cmodel_res_2: .word 0x0

test_145_inp_1_1: .word 0x80043072
test_145_inp_1_2: .word 0x43f17a69
test_145_inp_2_1: .word 0x5e8d6436
test_145_inp_2_2: .word 0x31df22dd
test_145_ajit_res_1: .word 0x0
test_145_ajit_res_2: .word 0x0
test_145_Cmodel_res_1: .word 0x0
test_145_Cmodel_res_2: .word 0x0

test_146_inp_1_1: .word 0x80005d49
test_146_inp_1_2: .word 0xdcea84ee
test_146_inp_2_1: .word 0x55939ec6
test_146_inp_2_2: .word 0x71a1aa67
test_146_ajit_res_1: .word 0x0
test_146_ajit_res_2: .word 0x0
test_146_Cmodel_res_1: .word 0x0
test_146_Cmodel_res_2: .word 0x0

test_147_inp_1_1: .word 0x80012ab4
test_147_inp_1_2: .word 0xd12c9acd
test_147_inp_2_1: .word 0x709bbe13
test_147_inp_2_2: .word 0xc181d0b8
test_147_ajit_res_1: .word 0x0
test_147_ajit_res_2: .word 0x0
test_147_Cmodel_res_1: .word 0x0
test_147_Cmodel_res_2: .word 0x0

test_148_inp_1_1: .word 0x96c23
test_148_inp_1_2: .word 0x994c0efc
test_148_inp_2_1: .word 0xd77e5c71
test_148_inp_2_2: .word 0x5f60a9e1
test_148_ajit_res_1: .word 0x0
test_148_ajit_res_2: .word 0x0
test_148_Cmodel_res_1: .word 0x0
test_148_Cmodel_res_2: .word 0x0

test_149_inp_1_1: .word 0x4e696
test_149_inp_1_2: .word 0x303a1413
test_149_inp_2_1: .word 0xf4be0c6a
test_149_inp_2_2: .word 0x59ab04fb
test_149_ajit_res_1: .word 0x0
test_149_ajit_res_2: .word 0x0
test_149_Cmodel_res_1: .word 0x0
test_149_Cmodel_res_2: .word 0x0

test_150_inp_1_1: .word 0x6e5b2
test_150_inp_1_2: .word 0xa44d04aa
test_150_inp_2_1: .word 0xf153d5fa
test_150_inp_2_2: .word 0x9a97f423
test_150_ajit_res_1: .word 0x0
test_150_ajit_res_2: .word 0x0
test_150_Cmodel_res_1: .word 0x0
test_150_Cmodel_res_2: .word 0x0

test_151_inp_1_1: .word 0x65cc2
test_151_inp_1_2: .word 0x5e5bc75b
test_151_inp_2_1: .word 0xde92e2dc
test_151_inp_2_2: .word 0xb8d7c615
test_151_ajit_res_1: .word 0x0
test_151_ajit_res_2: .word 0x0
test_151_Cmodel_res_1: .word 0x0
test_151_Cmodel_res_2: .word 0x0

test_152_inp_1_1: .word 0xb8598
test_152_inp_1_2: .word 0x16b03fc1
test_152_inp_2_1: .word 0xe2646c95
test_152_inp_2_2: .word 0x92968ffe
test_152_ajit_res_1: .word 0x0
test_152_ajit_res_2: .word 0x0
test_152_Cmodel_res_1: .word 0x0
test_152_Cmodel_res_2: .word 0x0

test_153_inp_1_1: .word 0x80080e7d
test_153_inp_1_2: .word 0xb83ebe1b
test_153_inp_2_1: .word 0x7dd7404c
test_153_inp_2_2: .word 0xd06c25a7
test_153_ajit_res_1: .word 0x0
test_153_ajit_res_2: .word 0x0
test_153_Cmodel_res_1: .word 0x0
test_153_Cmodel_res_2: .word 0x0

test_154_inp_1_1: .word 0xfbd90
test_154_inp_1_2: .word 0xef05adc4
test_154_inp_2_1: .word 0xea076f20
test_154_inp_2_2: .word 0x1536579f
test_154_ajit_res_1: .word 0x0
test_154_ajit_res_2: .word 0x0
test_154_Cmodel_res_1: .word 0x0
test_154_Cmodel_res_2: .word 0x0

test_155_inp_1_1: .word 0x80079a5e
test_155_inp_1_2: .word 0xcd4f5afc
test_155_inp_2_1: .word 0x68e1abc9
test_155_inp_2_2: .word 0x3ecefb49
test_155_ajit_res_1: .word 0x0
test_155_ajit_res_2: .word 0x0
test_155_Cmodel_res_1: .word 0x0
test_155_Cmodel_res_2: .word 0x0

test_156_inp_1_1: .word 0xf1fa
test_156_inp_1_2: .word 0xfa2a5095
test_156_inp_2_1: .word 0xc7a26f53
test_156_inp_2_2: .word 0xcdb08174
test_156_ajit_res_1: .word 0x0
test_156_ajit_res_2: .word 0x0
test_156_Cmodel_res_1: .word 0x0
test_156_Cmodel_res_2: .word 0x0

test_157_inp_1_1: .word 0x21685
test_157_inp_1_2: .word 0x6f0e9a94
test_157_inp_2_1: .word 0xee62945b
test_157_inp_2_2: .word 0x3066a2a1
test_157_ajit_res_1: .word 0x0
test_157_ajit_res_2: .word 0x0
test_157_Cmodel_res_1: .word 0x0
test_157_Cmodel_res_2: .word 0x0

test_158_inp_1_1: .word 0x4e9f0
test_158_inp_1_2: .word 0xaf20eb6b
test_158_inp_2_1: .word 0xd3b11fbe
test_158_inp_2_2: .word 0xbbd3107d
test_158_ajit_res_1: .word 0x0
test_158_ajit_res_2: .word 0x0
test_158_Cmodel_res_1: .word 0x0
test_158_Cmodel_res_2: .word 0x0

test_159_inp_1_1: .word 0x637ba
test_159_inp_1_2: .word 0xe82e444f
test_159_inp_2_1: .word 0xdc7fb5a7
test_159_inp_2_2: .word 0x88e8eb07
test_159_ajit_res_1: .word 0x0
test_159_ajit_res_2: .word 0x0
test_159_Cmodel_res_1: .word 0x0
test_159_Cmodel_res_2: .word 0x0

test_160_inp_1_1: .word 0x9dfd5
test_160_inp_1_2: .word 0x5f8e9a8
test_160_inp_2_1: .word 0xd7a3606c
test_160_inp_2_2: .word 0x280a727b
test_160_ajit_res_1: .word 0x0
test_160_ajit_res_2: .word 0x0
test_160_Cmodel_res_1: .word 0x0
test_160_Cmodel_res_2: .word 0x0

test_161_inp_1_1: .word 0x393cc
test_161_inp_1_2: .word 0x6f602932
test_161_inp_2_1: .word 0xf9491f39
test_161_inp_2_2: .word 0xe152e5e0
test_161_ajit_res_1: .word 0x0
test_161_ajit_res_2: .word 0x0
test_161_Cmodel_res_1: .word 0x0
test_161_Cmodel_res_2: .word 0x0

test_162_inp_1_1: .word 0x80075f02
test_162_inp_1_2: .word 0xad5ac988
test_162_inp_2_1: .word 0x5691ebba
test_162_inp_2_2: .word 0x9bb51e1b
test_162_ajit_res_1: .word 0x0
test_162_ajit_res_2: .word 0x0
test_162_Cmodel_res_1: .word 0x0
test_162_Cmodel_res_2: .word 0x0

test_163_inp_1_1: .word 0x53244
test_163_inp_1_2: .word 0xc7276694
test_163_inp_2_1: .word 0xdb54e6b1
test_163_inp_2_2: .word 0x71100d59
test_163_ajit_res_1: .word 0x0
test_163_ajit_res_2: .word 0x0
test_163_Cmodel_res_1: .word 0x0
test_163_Cmodel_res_2: .word 0x0

test_164_inp_1_1: .word 0x1e112
test_164_inp_1_2: .word 0x97004375
test_164_inp_2_1: .word 0xe0cba035
test_164_inp_2_2: .word 0x7363eb3
test_164_ajit_res_1: .word 0x0
test_164_ajit_res_2: .word 0x0
test_164_Cmodel_res_1: .word 0x0
test_164_Cmodel_res_2: .word 0x0

test_165_inp_1_1: .word 0x9c4db
test_165_inp_1_2: .word 0xafd6e0e3
test_165_inp_2_1: .word 0xc6391619
test_165_inp_2_2: .word 0x1ae915e2
test_165_ajit_res_1: .word 0x0
test_165_ajit_res_2: .word 0x0
test_165_Cmodel_res_1: .word 0x0
test_165_Cmodel_res_2: .word 0x0

test_166_inp_1_1: .word 0x800b4e0c
test_166_inp_1_2: .word 0x11611015
test_166_inp_2_1: .word 0x59bd1fb2
test_166_inp_2_2: .word 0x9def7775
test_166_ajit_res_1: .word 0x0
test_166_ajit_res_2: .word 0x0
test_166_Cmodel_res_1: .word 0x0
test_166_Cmodel_res_2: .word 0x0

test_167_inp_1_1: .word 0x47c31
test_167_inp_1_2: .word 0x917fc819
test_167_inp_2_1: .word 0xe04fa3da
test_167_inp_2_2: .word 0x773e11c9
test_167_ajit_res_1: .word 0x0
test_167_ajit_res_2: .word 0x0
test_167_Cmodel_res_1: .word 0x0
test_167_Cmodel_res_2: .word 0x0

test_168_inp_1_1: .word 0x44085
test_168_inp_1_2: .word 0x6d4be755
test_168_inp_2_1: .word 0xf0a917f2
test_168_inp_2_2: .word 0x423405db
test_168_ajit_res_1: .word 0x0
test_168_ajit_res_2: .word 0x0
test_168_Cmodel_res_1: .word 0x0
test_168_Cmodel_res_2: .word 0x0

test_169_inp_1_1: .word 0x800c15a5
test_169_inp_1_2: .word 0xeebdd11
test_169_inp_2_1: .word 0x52480e56
test_169_inp_2_2: .word 0x58756eeb
test_169_ajit_res_1: .word 0x0
test_169_ajit_res_2: .word 0x0
test_169_Cmodel_res_1: .word 0x0
test_169_Cmodel_res_2: .word 0x0

test_170_inp_1_1: .word 0x40bb2
test_170_inp_1_2: .word 0xc647cd83
test_170_inp_2_1: .word 0xd7f9a0cc
test_170_inp_2_2: .word 0x4e3842d8
test_170_ajit_res_1: .word 0x0
test_170_ajit_res_2: .word 0x0
test_170_Cmodel_res_1: .word 0x0
test_170_Cmodel_res_2: .word 0x0

test_171_inp_1_1: .word 0xea4b2
test_171_inp_1_2: .word 0x799bd024
test_171_inp_2_1: .word 0xdc173966
test_171_inp_2_2: .word 0xdc906e84
test_171_ajit_res_1: .word 0x0
test_171_ajit_res_2: .word 0x0
test_171_Cmodel_res_1: .word 0x0
test_171_Cmodel_res_2: .word 0x0

test_172_inp_1_1: .word 0x800fe59a
test_172_inp_1_2: .word 0x50b43c83
test_172_inp_2_1: .word 0x7fcfabc7
test_172_inp_2_2: .word 0xe6fe143a
test_172_ajit_res_1: .word 0x0
test_172_ajit_res_2: .word 0x0
test_172_Cmodel_res_1: .word 0x0
test_172_Cmodel_res_2: .word 0x0

test_173_inp_1_1: .word 0x800cc073
test_173_inp_1_2: .word 0x87409455
test_173_inp_2_1: .word 0x72857039
test_173_inp_2_2: .word 0xe29ba03d
test_173_ajit_res_1: .word 0x0
test_173_ajit_res_2: .word 0x0
test_173_Cmodel_res_1: .word 0x0
test_173_Cmodel_res_2: .word 0x0

test_174_inp_1_1: .word 0x80029eb0
test_174_inp_1_2: .word 0x847f010d
test_174_inp_2_1: .word 0x4ca4720f
test_174_inp_2_2: .word 0x22081c4f
test_174_ajit_res_1: .word 0x0
test_174_ajit_res_2: .word 0x0
test_174_Cmodel_res_1: .word 0x0
test_174_Cmodel_res_2: .word 0x0

test_175_inp_1_1: .word 0x80050a56
test_175_inp_1_2: .word 0xbf285c1a
test_175_inp_2_1: .word 0x79c4258c
test_175_inp_2_2: .word 0x47864a22
test_175_ajit_res_1: .word 0x0
test_175_ajit_res_2: .word 0x0
test_175_Cmodel_res_1: .word 0x0
test_175_Cmodel_res_2: .word 0x0

test_176_inp_1_1: .word 0x8006ed65
test_176_inp_1_2: .word 0x8d15a4aa
test_176_inp_2_1: .word 0xc3400799
test_176_inp_2_2: .word 0x7d35e563
test_176_ajit_res_1: .word 0x0
test_176_ajit_res_2: .word 0x0
test_176_Cmodel_res_1: .word 0x0
test_176_Cmodel_res_2: .word 0x0

test_177_inp_1_1: .word 0x6afc8
test_177_inp_1_2: .word 0xf9079d45
test_177_inp_2_1: .word 0xe2e51afd
test_177_inp_2_2: .word 0x1cc4633f
test_177_ajit_res_1: .word 0x0
test_177_ajit_res_2: .word 0x0
test_177_Cmodel_res_1: .word 0x0
test_177_Cmodel_res_2: .word 0x0

test_178_inp_1_1: .word 0x84d99
test_178_inp_1_2: .word 0xf6a4344e
test_178_inp_2_1: .word 0x42fed030
test_178_inp_2_2: .word 0xb581afa6
test_178_ajit_res_1: .word 0x0
test_178_ajit_res_2: .word 0x4
test_178_Cmodel_res_1: .word 0x0
test_178_Cmodel_res_2: .word 0x0

test_179_inp_1_1: .word 0xc9c3e
test_179_inp_1_2: .word 0xf3621afd
test_179_inp_2_1: .word 0xd56c1e6d
test_179_inp_2_2: .word 0x964dc188
test_179_ajit_res_1: .word 0x0
test_179_ajit_res_2: .word 0x0
test_179_Cmodel_res_1: .word 0x0
test_179_Cmodel_res_2: .word 0x0

test_180_inp_1_1: .word 0x8009d706
test_180_inp_1_2: .word 0x70ec3118
test_180_inp_2_1: .word 0x7d6f496c
test_180_inp_2_2: .word 0x9fd6af7a
test_180_ajit_res_1: .word 0x0
test_180_ajit_res_2: .word 0x0
test_180_Cmodel_res_1: .word 0x0
test_180_Cmodel_res_2: .word 0x0

test_181_inp_1_1: .word 0xe95e4
test_181_inp_1_2: .word 0x1893fe9d
test_181_inp_2_1: .word 0xf3da85c6
test_181_inp_2_2: .word 0x37cede20
test_181_ajit_res_1: .word 0x0
test_181_ajit_res_2: .word 0x0
test_181_Cmodel_res_1: .word 0x0
test_181_Cmodel_res_2: .word 0x0

test_182_inp_1_1: .word 0x6dd64
test_182_inp_1_2: .word 0xe29f1da6
test_182_inp_2_1: .word 0xf9f7ebe6
test_182_inp_2_2: .word 0x7b138a1d
test_182_ajit_res_1: .word 0x0
test_182_ajit_res_2: .word 0x0
test_182_Cmodel_res_1: .word 0x0
test_182_Cmodel_res_2: .word 0x0

test_183_inp_1_1: .word 0x8002d504
test_183_inp_1_2: .word 0xebdeb626
test_183_inp_2_1: .word 0x5ec1ea2f
test_183_inp_2_2: .word 0x46f442ca
test_183_ajit_res_1: .word 0x0
test_183_ajit_res_2: .word 0x0
test_183_Cmodel_res_1: .word 0x0
test_183_Cmodel_res_2: .word 0x0

test_184_inp_1_1: .word 0x97475
test_184_inp_1_2: .word 0x5a6ac798
test_184_inp_2_1: .word 0xd56235bf
test_184_inp_2_2: .word 0x9ab2f417
test_184_ajit_res_1: .word 0x0
test_184_ajit_res_2: .word 0x0
test_184_Cmodel_res_1: .word 0x0
test_184_Cmodel_res_2: .word 0x0

test_185_inp_1_1: .word 0xd1c16
test_185_inp_1_2: .word 0xba8d6eb6
test_185_inp_2_1: .word 0xdd66a63b
test_185_inp_2_2: .word 0xaaa319eb
test_185_ajit_res_1: .word 0x0
test_185_ajit_res_2: .word 0x0
test_185_Cmodel_res_1: .word 0x0
test_185_Cmodel_res_2: .word 0x0

test_186_inp_1_1: .word 0x8007484c
test_186_inp_1_2: .word 0x8909c368
test_186_inp_2_1: .word 0x593050d3
test_186_inp_2_2: .word 0x7fda0aee
test_186_ajit_res_1: .word 0x0
test_186_ajit_res_2: .word 0x0
test_186_Cmodel_res_1: .word 0x0
test_186_Cmodel_res_2: .word 0x0

test_187_inp_1_1: .word 0x800f79b0
test_187_inp_1_2: .word 0xa18feae1
test_187_inp_2_1: .word 0x564c838e
test_187_inp_2_2: .word 0x84826d74
test_187_ajit_res_1: .word 0x0
test_187_ajit_res_2: .word 0x0
test_187_Cmodel_res_1: .word 0x0
test_187_Cmodel_res_2: .word 0x0

test_188_inp_1_1: .word 0x8003711b
test_188_inp_1_2: .word 0xdb0c3da6
test_188_inp_2_1: .word 0x767b9a6d
test_188_inp_2_2: .word 0xb0bb8c5d
test_188_ajit_res_1: .word 0x0
test_188_ajit_res_2: .word 0x0
test_188_Cmodel_res_1: .word 0x0
test_188_Cmodel_res_2: .word 0x0

test_189_inp_1_1: .word 0xe5fce
test_189_inp_1_2: .word 0x48b46dfb
test_189_inp_2_1: .word 0xc543f0f7
test_189_inp_2_2: .word 0x43411be0
test_189_ajit_res_1: .word 0x0
test_189_ajit_res_2: .word 0x0
test_189_Cmodel_res_1: .word 0x0
test_189_Cmodel_res_2: .word 0x0

test_190_inp_1_1: .word 0xaaef1
test_190_inp_1_2: .word 0xa92352d4
test_190_inp_2_1: .word 0xc33d231c
test_190_inp_2_2: .word 0x2a1d2171
test_190_ajit_res_1: .word 0x0
test_190_ajit_res_2: .word 0x0
test_190_Cmodel_res_1: .word 0x0
test_190_Cmodel_res_2: .word 0x0

test_191_inp_1_1: .word 0x18c3b
test_191_inp_1_2: .word 0x287b497d
test_191_inp_2_1: .word 0xd522174a
test_191_inp_2_2: .word 0xa88840af
test_191_ajit_res_1: .word 0x0
test_191_ajit_res_2: .word 0x0
test_191_Cmodel_res_1: .word 0x0
test_191_Cmodel_res_2: .word 0x0

test_192_inp_1_1: .word 0x80044790
test_192_inp_1_2: .word 0xa450be28
test_192_inp_2_1: .word 0x54489259
test_192_inp_2_2: .word 0xac5a9554
test_192_ajit_res_1: .word 0x0
test_192_ajit_res_2: .word 0x0
test_192_Cmodel_res_1: .word 0x0
test_192_Cmodel_res_2: .word 0x0

test_193_inp_1_1: .word 0x800cf7b8
test_193_inp_1_2: .word 0xec688914
test_193_inp_2_1: .word 0x57319080
test_193_inp_2_2: .word 0xacbc9d06
test_193_ajit_res_1: .word 0x0
test_193_ajit_res_2: .word 0x0
test_193_Cmodel_res_1: .word 0x0
test_193_Cmodel_res_2: .word 0x0

test_194_inp_1_1: .word 0x800a1032
test_194_inp_1_2: .word 0x8de2721a
test_194_inp_2_1: .word 0x6deb6541
test_194_inp_2_2: .word 0x3eda707e
test_194_ajit_res_1: .word 0x0
test_194_ajit_res_2: .word 0x0
test_194_Cmodel_res_1: .word 0x0
test_194_Cmodel_res_2: .word 0x0

test_195_inp_1_1: .word 0x8007daff
test_195_inp_1_2: .word 0x74feab2c
test_195_inp_2_1: .word 0x5028e5b8
test_195_inp_2_2: .word 0x5a2c1d7a
test_195_ajit_res_1: .word 0x0
test_195_ajit_res_2: .word 0x0
test_195_Cmodel_res_1: .word 0x0
test_195_Cmodel_res_2: .word 0x0

test_196_inp_1_1: .word 0x92e31
test_196_inp_1_2: .word 0x76166a25
test_196_inp_2_1: .word 0xf91246ba
test_196_inp_2_2: .word 0x83466fb1
test_196_ajit_res_1: .word 0x0
test_196_ajit_res_2: .word 0x0
test_196_Cmodel_res_1: .word 0x0
test_196_Cmodel_res_2: .word 0x0

test_197_inp_1_1: .word 0x800ab8dc
test_197_inp_1_2: .word 0x42520d89
test_197_inp_2_1: .word 0x4d1c2d3e
test_197_inp_2_2: .word 0xf840ebd2
test_197_ajit_res_1: .word 0x0
test_197_ajit_res_2: .word 0x0
test_197_Cmodel_res_1: .word 0x0
test_197_Cmodel_res_2: .word 0x0

test_198_inp_1_1: .word 0x800b0c85
test_198_inp_1_2: .word 0x22062a78
test_198_inp_2_1: .word 0x6d25269b
test_198_inp_2_2: .word 0x1cdfb82c
test_198_ajit_res_1: .word 0x0
test_198_ajit_res_2: .word 0x0
test_198_Cmodel_res_1: .word 0x0
test_198_Cmodel_res_2: .word 0x0

test_199_inp_1_1: .word 0x86cb2
test_199_inp_1_2: .word 0xb34c646c
test_199_inp_2_1: .word 0xed73f5d2
test_199_inp_2_2: .word 0x46f667a4
test_199_ajit_res_1: .word 0x0
test_199_ajit_res_2: .word 0x0
test_199_Cmodel_res_1: .word 0x0
test_199_Cmodel_res_2: .word 0x0

test_200_inp_1_1: .word 0x800cef30
test_200_inp_1_2: .word 0xb2d5cce8
test_200_inp_2_1: .word 0x75523224
test_200_inp_2_2: .word 0x65bc5d71
test_200_ajit_res_1: .word 0x0
test_200_ajit_res_2: .word 0x0
test_200_Cmodel_res_1: .word 0x0
test_200_Cmodel_res_2: .word 0x0

test_201_inp_1_1: .word 0x80044fa2
test_201_inp_1_2: .word 0xf4faebf8
test_201_inp_2_1: .word 0x4d3114b2
test_201_inp_2_2: .word 0x1288e02f
test_201_ajit_res_1: .word 0x0
test_201_ajit_res_2: .word 0x0
test_201_Cmodel_res_1: .word 0x0
test_201_Cmodel_res_2: .word 0x0

test_202_inp_1_1: .word 0x80011956
test_202_inp_1_2: .word 0xf987be07
test_202_inp_2_1: .word 0x5e66d55d
test_202_inp_2_2: .word 0x632dd0bb
test_202_ajit_res_1: .word 0x0
test_202_ajit_res_2: .word 0x0
test_202_Cmodel_res_1: .word 0x0
test_202_Cmodel_res_2: .word 0x0

test_203_inp_1_1: .word 0x40da6
test_203_inp_1_2: .word 0x52637ff1
test_203_inp_2_1: .word 0xe4b855a9
test_203_inp_2_2: .word 0x237a654e
test_203_ajit_res_1: .word 0x0
test_203_ajit_res_2: .word 0x0
test_203_Cmodel_res_1: .word 0x0
test_203_Cmodel_res_2: .word 0x0

test_204_inp_1_1: .word 0xe8424
test_204_inp_1_2: .word 0xc3fe15d2
test_204_inp_2_1: .word 0xc4f746ee
test_204_inp_2_2: .word 0xdb4dd79
test_204_ajit_res_1: .word 0x0
test_204_ajit_res_2: .word 0x0
test_204_Cmodel_res_1: .word 0x0
test_204_Cmodel_res_2: .word 0x0

test_205_inp_1_1: .word 0x9f1c5
test_205_inp_1_2: .word 0xa7db69d6
test_205_inp_2_1: .word 0xd847295c
test_205_inp_2_2: .word 0x627e6a85
test_205_ajit_res_1: .word 0x0
test_205_ajit_res_2: .word 0x0
test_205_Cmodel_res_1: .word 0x0
test_205_Cmodel_res_2: .word 0x0

test_206_inp_1_1: .word 0x8004c22c
test_206_inp_1_2: .word 0x33d943e8
test_206_inp_2_1: .word 0xc2310df9
test_206_inp_2_2: .word 0xa34d0b6f
test_206_ajit_res_1: .word 0x0
test_206_ajit_res_2: .word 0x476d
test_206_Cmodel_res_1: .word 0x0
test_206_Cmodel_res_2: .word 0x0

test_207_inp_1_1: .word 0xb9c9e
test_207_inp_1_2: .word 0xdab15b10
test_207_inp_2_1: .word 0xde261726
test_207_inp_2_2: .word 0x9b7cfda6
test_207_ajit_res_1: .word 0x0
test_207_ajit_res_2: .word 0x0
test_207_Cmodel_res_1: .word 0x0
test_207_Cmodel_res_2: .word 0x0

test_208_inp_1_1: .word 0x4a1f2
test_208_inp_1_2: .word 0x20df12b4
test_208_inp_2_1: .word 0xeee0b23b
test_208_inp_2_2: .word 0x122e8191
test_208_ajit_res_1: .word 0x0
test_208_ajit_res_2: .word 0x0
test_208_Cmodel_res_1: .word 0x0
test_208_Cmodel_res_2: .word 0x0

test_209_inp_1_1: .word 0x8001b598
test_209_inp_1_2: .word 0xb3fa08ea
test_209_inp_2_1: .word 0x46f79ca5
test_209_inp_2_2: .word 0x31f4867b
test_209_ajit_res_1: .word 0x0
test_209_ajit_res_2: .word 0x0
test_209_Cmodel_res_1: .word 0x0
test_209_Cmodel_res_2: .word 0x0

test_210_inp_1_1: .word 0x8007112d
test_210_inp_1_2: .word 0x94b60d46
test_210_inp_2_1: .word 0x61b3c195
test_210_inp_2_2: .word 0xc20cf0dc
test_210_ajit_res_1: .word 0x0
test_210_ajit_res_2: .word 0x0
test_210_Cmodel_res_1: .word 0x0
test_210_Cmodel_res_2: .word 0x0

test_211_inp_1_1: .word 0x800af1f6
test_211_inp_1_2: .word 0x82c59c67
test_211_inp_2_1: .word 0x65c113ba
test_211_inp_2_2: .word 0xb015ee9f
test_211_ajit_res_1: .word 0x0
test_211_ajit_res_2: .word 0x0
test_211_Cmodel_res_1: .word 0x0
test_211_Cmodel_res_2: .word 0x0

test_212_inp_1_1: .word 0x80013f81
test_212_inp_1_2: .word 0x7c940356
test_212_inp_2_1: .word 0x61dfc43d
test_212_inp_2_2: .word 0xa6a73ed0
test_212_ajit_res_1: .word 0x0
test_212_ajit_res_2: .word 0x0
test_212_Cmodel_res_1: .word 0x0
test_212_Cmodel_res_2: .word 0x0

test_213_inp_1_1: .word 0x8002b26e
test_213_inp_1_2: .word 0x37299291
test_213_inp_2_1: .word 0x4923ec80
test_213_inp_2_2: .word 0x989945f4
test_213_ajit_res_1: .word 0x0
test_213_ajit_res_2: .word 0x0
test_213_Cmodel_res_1: .word 0x0
test_213_Cmodel_res_2: .word 0x0

test_214_inp_1_1: .word 0x8005d83b
test_214_inp_1_2: .word 0xaeacbfce
test_214_inp_2_1: .word 0x7fe5c2fa
test_214_inp_2_2: .word 0x4f45d531
test_214_ajit_res_1: .word 0x0
test_214_ajit_res_2: .word 0x0
test_214_Cmodel_res_1: .word 0x0
test_214_Cmodel_res_2: .word 0x0

test_215_inp_1_1: .word 0x800c991f
test_215_inp_1_2: .word 0xc5a68682
test_215_inp_2_1: .word 0x7a76b9d0
test_215_inp_2_2: .word 0x15422b0f
test_215_ajit_res_1: .word 0x0
test_215_ajit_res_2: .word 0x0
test_215_Cmodel_res_1: .word 0x0
test_215_Cmodel_res_2: .word 0x0

test_216_inp_1_1: .word 0x80011104
test_216_inp_1_2: .word 0x1f116d41
test_216_inp_2_1: .word 0x7dc88c7b
test_216_inp_2_2: .word 0x816a3fdb
test_216_ajit_res_1: .word 0x0
test_216_ajit_res_2: .word 0x0
test_216_Cmodel_res_1: .word 0x0
test_216_Cmodel_res_2: .word 0x0

test_217_inp_1_1: .word 0x57fee
test_217_inp_1_2: .word 0xcc592fa4
test_217_inp_2_1: .word 0xf46cf3d4
test_217_inp_2_2: .word 0xcb88f4fb
test_217_ajit_res_1: .word 0x0
test_217_ajit_res_2: .word 0x0
test_217_Cmodel_res_1: .word 0x0
test_217_Cmodel_res_2: .word 0x0

test_218_inp_1_1: .word 0x80011798
test_218_inp_1_2: .word 0x3836c3e7
test_218_inp_2_1: .word 0x7c346faa
test_218_inp_2_2: .word 0xb2cab7a0
test_218_ajit_res_1: .word 0x0
test_218_ajit_res_2: .word 0x0
test_218_Cmodel_res_1: .word 0x0
test_218_Cmodel_res_2: .word 0x0

test_219_inp_1_1: .word 0x800d9ad1
test_219_inp_1_2: .word 0x8602e9fb
test_219_inp_2_1: .word 0x76647452
test_219_inp_2_2: .word 0x1d5bf2e8
test_219_ajit_res_1: .word 0x0
test_219_ajit_res_2: .word 0x0
test_219_Cmodel_res_1: .word 0x0
test_219_Cmodel_res_2: .word 0x0

test_220_inp_1_1: .word 0x80019511
test_220_inp_1_2: .word 0xbb3d29b3
test_220_inp_2_1: .word 0x45ca215c
test_220_inp_2_2: .word 0x4c775f20
test_220_ajit_res_1: .word 0x0
test_220_ajit_res_2: .word 0x0
test_220_Cmodel_res_1: .word 0x0
test_220_Cmodel_res_2: .word 0x0

test_221_inp_1_1: .word 0x800ab47b
test_221_inp_1_2: .word 0xccf41eed
test_221_inp_2_1: .word 0x6cea6d11
test_221_inp_2_2: .word 0x5e97ed90
test_221_ajit_res_1: .word 0x0
test_221_ajit_res_2: .word 0x0
test_221_Cmodel_res_1: .word 0x0
test_221_Cmodel_res_2: .word 0x0

test_222_inp_1_1: .word 0x4c798
test_222_inp_1_2: .word 0x4b3ec404
test_222_inp_2_1: .word 0xf4ddf850
test_222_inp_2_2: .word 0x1d81388c
test_222_ajit_res_1: .word 0x0
test_222_ajit_res_2: .word 0x0
test_222_Cmodel_res_1: .word 0x0
test_222_Cmodel_res_2: .word 0x0

test_223_inp_1_1: .word 0x71826
test_223_inp_1_2: .word 0x3748798e
test_223_inp_2_1: .word 0xe62c5560
test_223_inp_2_2: .word 0x33f34afd
test_223_ajit_res_1: .word 0x0
test_223_ajit_res_2: .word 0x0
test_223_Cmodel_res_1: .word 0x0
test_223_Cmodel_res_2: .word 0x0

test_224_inp_1_1: .word 0x8001a9fa
test_224_inp_1_2: .word 0xd9ad6703
test_224_inp_2_1: .word 0x6b221865
test_224_inp_2_2: .word 0xd1bd9d0d
test_224_ajit_res_1: .word 0x0
test_224_ajit_res_2: .word 0x0
test_224_Cmodel_res_1: .word 0x0
test_224_Cmodel_res_2: .word 0x0

test_225_inp_1_1: .word 0x800b3d75
test_225_inp_1_2: .word 0xe5fbd4bd
test_225_inp_2_1: .word 0x428bfe6c
test_225_inp_2_2: .word 0x52faac54
test_225_ajit_res_1: .word 0x80000000
test_225_ajit_res_2: .word 0x336
test_225_Cmodel_res_1: .word 0x0
test_225_Cmodel_res_2: .word 0x0

test_226_inp_1_1: .word 0x800a4bce
test_226_inp_1_2: .word 0xd78e3c3c
test_226_inp_2_1: .word 0x4e9f8a4e
test_226_inp_2_2: .word 0x30a1af44
test_226_ajit_res_1: .word 0x0
test_226_ajit_res_2: .word 0x0
test_226_Cmodel_res_1: .word 0x0
test_226_Cmodel_res_2: .word 0x0

test_227_inp_1_1: .word 0xabed3
test_227_inp_1_2: .word 0xf4cfb7b9
test_227_inp_2_1: .word 0xc991cdb3
test_227_inp_2_2: .word 0x5b10e696
test_227_ajit_res_1: .word 0x0
test_227_ajit_res_2: .word 0x0
test_227_Cmodel_res_1: .word 0x0
test_227_Cmodel_res_2: .word 0x0

test_228_inp_1_1: .word 0xbf029
test_228_inp_1_2: .word 0x31b021be
test_228_inp_2_1: .word 0xe3d17c6a
test_228_inp_2_2: .word 0xd716ee7d
test_228_ajit_res_1: .word 0x0
test_228_ajit_res_2: .word 0x0
test_228_Cmodel_res_1: .word 0x0
test_228_Cmodel_res_2: .word 0x0

test_229_inp_1_1: .word 0x8009f084
test_229_inp_1_2: .word 0xb45bf958
test_229_inp_2_1: .word 0x499d7d0f
test_229_inp_2_2: .word 0xe5b218aa
test_229_ajit_res_1: .word 0x0
test_229_ajit_res_2: .word 0x0
test_229_Cmodel_res_1: .word 0x0
test_229_Cmodel_res_2: .word 0x0

test_230_inp_1_1: .word 0x144b5
test_230_inp_1_2: .word 0x10e9ae9c
test_230_inp_2_1: .word 0xe0688385
test_230_inp_2_2: .word 0xc0f25ac1
test_230_ajit_res_1: .word 0x0
test_230_ajit_res_2: .word 0x0
test_230_Cmodel_res_1: .word 0x0
test_230_Cmodel_res_2: .word 0x0

test_231_inp_1_1: .word 0x660d4
test_231_inp_1_2: .word 0x4adac849
test_231_inp_2_1: .word 0xe5cd0bb4
test_231_inp_2_2: .word 0x92c64f99
test_231_ajit_res_1: .word 0x0
test_231_ajit_res_2: .word 0x0
test_231_Cmodel_res_1: .word 0x0
test_231_Cmodel_res_2: .word 0x0

test_232_inp_1_1: .word 0x800a0468
test_232_inp_1_2: .word 0xf4756c75
test_232_inp_2_1: .word 0x7e7dde43
test_232_inp_2_2: .word 0xe2923bed
test_232_ajit_res_1: .word 0x0
test_232_ajit_res_2: .word 0x0
test_232_Cmodel_res_1: .word 0x0
test_232_Cmodel_res_2: .word 0x0

test_233_inp_1_1: .word 0x3ba3c
test_233_inp_1_2: .word 0xdc2212d3
test_233_inp_2_1: .word 0xd9063772
test_233_inp_2_2: .word 0xeb288236
test_233_ajit_res_1: .word 0x0
test_233_ajit_res_2: .word 0x0
test_233_Cmodel_res_1: .word 0x0
test_233_Cmodel_res_2: .word 0x0

test_234_inp_1_1: .word 0xfd3ed
test_234_inp_1_2: .word 0xf6c08b0f
test_234_inp_2_1: .word 0xe4913133
test_234_inp_2_2: .word 0xdfdc29d9
test_234_ajit_res_1: .word 0x0
test_234_ajit_res_2: .word 0x0
test_234_Cmodel_res_1: .word 0x0
test_234_Cmodel_res_2: .word 0x0

test_235_inp_1_1: .word 0xbfd0593d
test_235_inp_1_2: .word 0x51633c5a
test_235_inp_2_1: .word 0x800035fc
test_235_inp_2_2: .word 0x4dc1aca2
test_235_ajit_res_1: .word 0x7ff00000
test_235_ajit_res_2: .word 0x0
test_235_Cmodel_res_1: .word 0x0
test_235_Cmodel_res_2: .word 0x0

test_236_inp_1_1: .word 0x67b7a8
test_236_inp_1_2: .word 0x36d139fd
test_236_inp_2_1: .word 0xdf5e7f8a
test_236_inp_2_2: .word 0x7c5144ce
test_236_ajit_res_1: .word 0x0
test_236_ajit_res_2: .word 0x0
test_236_Cmodel_res_1: .word 0x0
test_236_Cmodel_res_2: .word 0x0

test_237_inp_1_1: .word 0x2deddcfc
test_237_inp_1_2: .word 0x6033d077
test_237_inp_2_1: .word 0xffe96849
test_237_inp_2_2: .word 0x7a274a17
test_237_ajit_res_1: .word 0x0
test_237_ajit_res_2: .word 0x0
test_237_Cmodel_res_1: .word 0x0
test_237_Cmodel_res_2: .word 0x0

test_238_inp_1_1: .word 0x13435cdd
test_238_inp_1_2: .word 0x224f0a28
test_238_inp_2_1: .word 0xeae29c7d
test_238_inp_2_2: .word 0xd6f41e3c
test_238_ajit_res_1: .word 0x0
test_238_ajit_res_2: .word 0x0
test_238_Cmodel_res_1: .word 0x0
test_238_Cmodel_res_2: .word 0x0

test_239_inp_1_1: .word 0xcefd98
test_239_inp_1_2: .word 0x3e9badf7
test_239_inp_2_1: .word 0xddbcbad9
test_239_inp_2_2: .word 0xd36b076c
test_239_ajit_res_1: .word 0x0
test_239_ajit_res_2: .word 0x0
test_239_Cmodel_res_1: .word 0x0
test_239_Cmodel_res_2: .word 0x0

test_240_inp_1_1: .word 0x97ff539e
test_240_inp_1_2: .word 0x71071de
test_240_inp_2_1: .word 0x69c26829
test_240_inp_2_2: .word 0x3c43e6bd
test_240_ajit_res_1: .word 0x0
test_240_ajit_res_2: .word 0x0
test_240_Cmodel_res_1: .word 0x0
test_240_Cmodel_res_2: .word 0x0

test_241_inp_1_1: .word 0x811d8c04
test_241_inp_1_2: .word 0x473f4975
test_241_inp_2_1: .word 0x4d28ec71
test_241_inp_2_2: .word 0xfc03caa7
test_241_ajit_res_1: .word 0x0
test_241_ajit_res_2: .word 0x0
test_241_Cmodel_res_1: .word 0x0
test_241_Cmodel_res_2: .word 0x0

test_242_inp_1_1: .word 0xe81eb87
test_242_inp_1_2: .word 0x4d95d986
test_242_inp_2_1: .word 0xf3f5daa1
test_242_inp_2_2: .word 0x3a2253b5
test_242_ajit_res_1: .word 0x0
test_242_ajit_res_2: .word 0x0
test_242_Cmodel_res_1: .word 0x0
test_242_Cmodel_res_2: .word 0x0

test_243_inp_1_1: .word 0x10350a1
test_243_inp_1_2: .word 0x8118a4cd
test_243_inp_2_1: .word 0xf7466f17
test_243_inp_2_2: .word 0x9d2206c4
test_243_ajit_res_1: .word 0x0
test_243_ajit_res_2: .word 0x0
test_243_Cmodel_res_1: .word 0x0
test_243_Cmodel_res_2: .word 0x0

test_244_inp_1_1: .word 0x21370553
test_244_inp_1_2: .word 0x6d90fa1b
test_244_inp_2_1: .word 0x647f325c
test_244_inp_2_2: .word 0xca683d2f
test_244_ajit_res_1: .word 0x0
test_244_ajit_res_2: .word 0x0
test_244_Cmodel_res_1: .word 0x0
test_244_Cmodel_res_2: .word 0x0

test_245_inp_1_1: .word 0x91a46ed5
test_245_inp_1_2: .word 0x9fbff0cc
test_245_inp_2_1: .word 0x5d766a52
test_245_inp_2_2: .word 0x5d3f3c2d
test_245_ajit_res_1: .word 0x0
test_245_ajit_res_2: .word 0x0
test_245_Cmodel_res_1: .word 0x0
test_245_Cmodel_res_2: .word 0x0

test_246_inp_1_1: .word 0x1d95dc66
test_246_inp_1_2: .word 0x65fc9bf1
test_246_inp_2_1: .word 0xe2a5a827
test_246_inp_2_2: .word 0x3863be86
test_246_ajit_res_1: .word 0x0
test_246_ajit_res_2: .word 0x0
test_246_Cmodel_res_1: .word 0x0
test_246_Cmodel_res_2: .word 0x0

test_247_inp_1_1: .word 0xa8d7f8cf
test_247_inp_1_2: .word 0x880c3e8a
test_247_inp_2_1: .word 0x7cdab258
test_247_inp_2_2: .word 0x1b2cc477
test_247_ajit_res_1: .word 0x0
test_247_ajit_res_2: .word 0x0
test_247_Cmodel_res_1: .word 0x0
test_247_Cmodel_res_2: .word 0x0

test_248_inp_1_1: .word 0x19b6dd92
test_248_inp_1_2: .word 0x2e4e6106
test_248_inp_2_1: .word 0xe1563a3f
test_248_inp_2_2: .word 0xad227c44
test_248_ajit_res_1: .word 0x0
test_248_ajit_res_2: .word 0x0
test_248_Cmodel_res_1: .word 0x0
test_248_Cmodel_res_2: .word 0x0

test_249_inp_1_1: .word 0xb6627571
test_249_inp_1_2: .word 0x7c483f85
test_249_inp_2_1: .word 0x7da6d4d2
test_249_inp_2_2: .word 0x563beeba
test_249_ajit_res_1: .word 0x0
test_249_ajit_res_2: .word 0x0
test_249_Cmodel_res_1: .word 0x0
test_249_Cmodel_res_2: .word 0x0

test_250_inp_1_1: .word 0x9fd9b545
test_250_inp_1_2: .word 0xb54a407d
test_250_inp_2_1: .word 0x6bf5a895
test_250_inp_2_2: .word 0xf3c56bbd
test_250_ajit_res_1: .word 0x0
test_250_ajit_res_2: .word 0x0
test_250_Cmodel_res_1: .word 0x0
test_250_Cmodel_res_2: .word 0x0

test_251_inp_1_1: .word 0x1e4e66f0
test_251_inp_1_2: .word 0xf8ae2ed5
test_251_inp_2_1: .word 0x6118b70a
test_251_inp_2_2: .word 0x389e67c8
test_251_ajit_res_1: .word 0x0
test_251_ajit_res_2: .word 0x27
test_251_Cmodel_res_1: .word 0x0
test_251_Cmodel_res_2: .word 0x0

test_252_inp_1_1: .word 0x88c588b8
test_252_inp_1_2: .word 0x19ddfeba
test_252_inp_2_1: .word 0x64886c19
test_252_inp_2_2: .word 0xf6c8abc7
test_252_ajit_res_1: .word 0x0
test_252_ajit_res_2: .word 0x0
test_252_Cmodel_res_1: .word 0x0
test_252_Cmodel_res_2: .word 0x0

test_253_inp_1_1: .word 0x30952cc
test_253_inp_1_2: .word 0x7d88ad
test_253_inp_2_1: .word 0xcfce1f73
test_253_inp_2_2: .word 0xc7f2f8fc
test_253_ajit_res_1: .word 0x0
test_253_ajit_res_2: .word 0x0
test_253_Cmodel_res_1: .word 0x0
test_253_Cmodel_res_2: .word 0x0

test_254_inp_1_1: .word 0x9107fb19
test_254_inp_1_2: .word 0xdd9743d9
test_254_inp_2_1: .word 0x7cecce25
test_254_inp_2_2: .word 0x15bbbb1e
test_254_ajit_res_1: .word 0x0
test_254_ajit_res_2: .word 0x0
test_254_Cmodel_res_1: .word 0x0
test_254_Cmodel_res_2: .word 0x0

test_255_inp_1_1: .word 0x842311cb
test_255_inp_1_2: .word 0xc99fe6a2
test_255_inp_2_1: .word 0x5f85d66b
test_255_inp_2_2: .word 0xa6ff31ef
test_255_ajit_res_1: .word 0x0
test_255_ajit_res_2: .word 0x0
test_255_Cmodel_res_1: .word 0x0
test_255_Cmodel_res_2: .word 0x0

test_256_inp_1_1: .word 0xae591c9f
test_256_inp_1_2: .word 0xbf8906be
test_256_inp_2_1: .word 0x71a1fa78
test_256_inp_2_2: .word 0xb4067b33
test_256_ajit_res_1: .word 0x0
test_256_ajit_res_2: .word 0x0
test_256_Cmodel_res_1: .word 0x0
test_256_Cmodel_res_2: .word 0x0

test_257_inp_1_1: .word 0x6407d5a
test_257_inp_1_2: .word 0x8981ee4f
test_257_inp_2_1: .word 0xfd9c3873
test_257_inp_2_2: .word 0x5d869e53
test_257_ajit_res_1: .word 0x0
test_257_ajit_res_2: .word 0x0
test_257_Cmodel_res_1: .word 0x0
test_257_Cmodel_res_2: .word 0x0

test_258_inp_1_1: .word 0x8a5c7dc0
test_258_inp_1_2: .word 0x86200559
test_258_inp_2_1: .word 0x4e52bad2
test_258_inp_2_2: .word 0xe9a03313
test_258_ajit_res_1: .word 0x0
test_258_ajit_res_2: .word 0x0
test_258_Cmodel_res_1: .word 0x0
test_258_Cmodel_res_2: .word 0x0

test_259_inp_1_1: .word 0x872dbce7
test_259_inp_1_2: .word 0x4470f11c
test_259_inp_2_1: .word 0x5d53270e
test_259_inp_2_2: .word 0x271bd7fe
test_259_ajit_res_1: .word 0x0
test_259_ajit_res_2: .word 0x0
test_259_Cmodel_res_1: .word 0x0
test_259_Cmodel_res_2: .word 0x0

test_260_inp_1_1: .word 0x8e7b6f38
test_260_inp_1_2: .word 0x6783817d
test_260_inp_2_1: .word 0x54445409
test_260_inp_2_2: .word 0x75fd793f
test_260_ajit_res_1: .word 0x0
test_260_ajit_res_2: .word 0x0
test_260_Cmodel_res_1: .word 0x0
test_260_Cmodel_res_2: .word 0x0

test_261_inp_1_1: .word 0x9195be8c
test_261_inp_1_2: .word 0x88f65c7d
test_261_inp_2_1: .word 0x69926833
test_261_inp_2_2: .word 0x78f50f85
test_261_ajit_res_1: .word 0x0
test_261_ajit_res_2: .word 0x0
test_261_Cmodel_res_1: .word 0x0
test_261_Cmodel_res_2: .word 0x0

test_262_inp_1_1: .word 0x1739d985
test_262_inp_1_2: .word 0x4cc1d513
test_262_inp_2_1: .word 0xe9abfbe3
test_262_inp_2_2: .word 0xa87d7279
test_262_ajit_res_1: .word 0x0
test_262_ajit_res_2: .word 0x0
test_262_Cmodel_res_1: .word 0x0
test_262_Cmodel_res_2: .word 0x0

test_263_inp_1_1: .word 0x34b9aff
test_263_inp_1_2: .word 0x2e8e2665
test_263_inp_2_1: .word 0xdf5538fc
test_263_inp_2_2: .word 0xb1440369
test_263_ajit_res_1: .word 0x0
test_263_ajit_res_2: .word 0x0
test_263_Cmodel_res_1: .word 0x0
test_263_Cmodel_res_2: .word 0x0

test_264_inp_1_1: .word 0xa5b1f207
test_264_inp_1_2: .word 0x57a07d21
test_264_inp_2_1: .word 0x6f4387aa
test_264_inp_2_2: .word 0x1582559b
test_264_ajit_res_1: .word 0x0
test_264_ajit_res_2: .word 0x0
test_264_Cmodel_res_1: .word 0x0
test_264_Cmodel_res_2: .word 0x0

test_265_inp_1_1: .word 0xa44eb50b
test_265_inp_1_2: .word 0x7a5c3663
test_265_inp_2_1: .word 0x79e2ff26
test_265_inp_2_2: .word 0x90f776cf
test_265_ajit_res_1: .word 0x0
test_265_ajit_res_2: .word 0x0
test_265_Cmodel_res_1: .word 0x0
test_265_Cmodel_res_2: .word 0x0

test_266_inp_1_1: .word 0x86646146
test_266_inp_1_2: .word 0xac3bac25
test_266_inp_2_1: .word 0x510899b0
test_266_inp_2_2: .word 0xbe76723d
test_266_ajit_res_1: .word 0x0
test_266_ajit_res_2: .word 0x0
test_266_Cmodel_res_1: .word 0x0
test_266_Cmodel_res_2: .word 0x0

test_267_inp_1_1: .word 0x3b3738e7
test_267_inp_1_2: .word 0xfb418752
test_267_inp_2_1: .word 0xfd923879
test_267_inp_2_2: .word 0xf58490dc
test_267_ajit_res_1: .word 0x80000000
test_267_ajit_res_2: .word 0x1464
test_267_Cmodel_res_1: .word 0x0
test_267_Cmodel_res_2: .word 0x0

test_268_inp_1_1: .word 0x11360101
test_268_inp_1_2: .word 0xb8c0e3eb
test_268_inp_2_1: .word 0xe45f359c
test_268_inp_2_2: .word 0x662cf8ec
test_268_ajit_res_1: .word 0x0
test_268_ajit_res_2: .word 0x0
test_268_Cmodel_res_1: .word 0x0
test_268_Cmodel_res_2: .word 0x0

test_269_inp_1_1: .word 0x10808a59
test_269_inp_1_2: .word 0xa575692d
test_269_inp_2_1: .word 0x52dde50a
test_269_inp_2_2: .word 0x373e68bf
test_269_ajit_res_1: .word 0x0
test_269_ajit_res_2: .word 0x11b4
test_269_Cmodel_res_1: .word 0x0
test_269_Cmodel_res_2: .word 0x0

test_270_inp_1_1: .word 0xac58b58c
test_270_inp_1_2: .word 0x2fd1dcb8
test_270_inp_2_1: .word 0x7fb112ca
test_270_inp_2_2: .word 0x5a6c5101
test_270_ajit_res_1: .word 0x0
test_270_ajit_res_2: .word 0x0
test_270_Cmodel_res_1: .word 0x0
test_270_Cmodel_res_2: .word 0x0

test_271_inp_1_1: .word 0x25a8b5f7
test_271_inp_1_2: .word 0xc539d992
test_271_inp_2_1: .word 0xf0e4de25
test_271_inp_2_2: .word 0x42b58ea1
test_271_ajit_res_1: .word 0x0
test_271_ajit_res_2: .word 0x0
test_271_Cmodel_res_1: .word 0x0
test_271_Cmodel_res_2: .word 0x0

test_272_inp_1_1: .word 0x21215935
test_272_inp_1_2: .word 0x4f23f24d
test_272_inp_2_1: .word 0xf472d921
test_272_inp_2_2: .word 0x9eda86e9
test_272_ajit_res_1: .word 0x0
test_272_ajit_res_2: .word 0x0
test_272_Cmodel_res_1: .word 0x0
test_272_Cmodel_res_2: .word 0x0

test_273_inp_1_1: .word 0x1b12e72a
test_273_inp_1_2: .word 0x21f5f562
test_273_inp_2_1: .word 0xdfdd209c
test_273_inp_2_2: .word 0xba770608
test_273_ajit_res_1: .word 0x0
test_273_ajit_res_2: .word 0x0
test_273_Cmodel_res_1: .word 0x0
test_273_Cmodel_res_2: .word 0x0

test_274_inp_1_1: .word 0x804f0f16
test_274_inp_1_2: .word 0xe2c94e5
test_274_inp_2_1: .word 0x4bf2e25c
test_274_inp_2_2: .word 0x9291548c
test_274_ajit_res_1: .word 0x0
test_274_ajit_res_2: .word 0x0
test_274_Cmodel_res_1: .word 0x0
test_274_Cmodel_res_2: .word 0x0

test_275_inp_1_1: .word 0x972e5142
test_275_inp_1_2: .word 0xf14bba28
test_275_inp_2_1: .word 0x5b56a170
test_275_inp_2_2: .word 0x1fbaa75c
test_275_ajit_res_1: .word 0x0
test_275_ajit_res_2: .word 0x0
test_275_Cmodel_res_1: .word 0x0
test_275_Cmodel_res_2: .word 0x0

test_276_inp_1_1: .word 0x18f865f8
test_276_inp_1_2: .word 0xdd884bb8
test_276_inp_2_1: .word 0xf5057e18
test_276_inp_2_2: .word 0x2d08b52f
test_276_ajit_res_1: .word 0x0
test_276_ajit_res_2: .word 0x0
test_276_Cmodel_res_1: .word 0x0
test_276_Cmodel_res_2: .word 0x0

test_277_inp_1_1: .word 0x2c9615c6
test_277_inp_1_2: .word 0x4299b9bc
test_277_inp_2_1: .word 0xefae3ea4
test_277_inp_2_2: .word 0x94db65cf
test_277_ajit_res_1: .word 0x80000000
test_277_ajit_res_2: .word 0x1
test_277_Cmodel_res_1: .word 0x0
test_277_Cmodel_res_2: .word 0x0

test_278_inp_1_1: .word 0xf45c053
test_278_inp_1_2: .word 0xe4e93224
test_278_inp_2_1: .word 0xf14f9de6
test_278_inp_2_2: .word 0x8da8e940
test_278_ajit_res_1: .word 0x0
test_278_ajit_res_2: .word 0x0
test_278_Cmodel_res_1: .word 0x0
test_278_Cmodel_res_2: .word 0x0

test_279_inp_1_1: .word 0x8c64d869
test_279_inp_1_2: .word 0xa92d4809
test_279_inp_2_1: .word 0x6a6a0ece
test_279_inp_2_2: .word 0xf99e30d9
test_279_ajit_res_1: .word 0x0
test_279_ajit_res_2: .word 0x0
test_279_Cmodel_res_1: .word 0x0
test_279_Cmodel_res_2: .word 0x0

test_280_inp_1_1: .word 0x134f2245
test_280_inp_1_2: .word 0x6276def7
test_280_inp_2_1: .word 0xf4c6dca1
test_280_inp_2_2: .word 0x73cf6e8a
test_280_ajit_res_1: .word 0x0
test_280_ajit_res_2: .word 0x0
test_280_Cmodel_res_1: .word 0x0
test_280_Cmodel_res_2: .word 0x0

test_281_inp_1_1: .word 0xb3f5b1f4
test_281_inp_1_2: .word 0xc75096ea
test_281_inp_2_1: .word 0x7b596f01
test_281_inp_2_2: .word 0x72a8cd47
test_281_ajit_res_1: .word 0x0
test_281_ajit_res_2: .word 0x0
test_281_Cmodel_res_1: .word 0x0
test_281_Cmodel_res_2: .word 0x0

test_282_inp_1_1: .word 0xa2ac1443
test_282_inp_1_2: .word 0x92954350
test_282_inp_2_1: .word 0x7dde1fc8
test_282_inp_2_2: .word 0x6326bdd6
test_282_ajit_res_1: .word 0x0
test_282_ajit_res_2: .word 0x0
test_282_Cmodel_res_1: .word 0x0
test_282_Cmodel_res_2: .word 0x0

test_283_inp_1_1: .word 0x9a1412fd
test_283_inp_1_2: .word 0x832c0883
test_283_inp_2_1: .word 0x73c151ad
test_283_inp_2_2: .word 0x129c1052
test_283_ajit_res_1: .word 0x0
test_283_ajit_res_2: .word 0x0
test_283_Cmodel_res_1: .word 0x0
test_283_Cmodel_res_2: .word 0x0

test_284_inp_1_1: .word 0xae091971
test_284_inp_1_2: .word 0x696acc7d
test_284_inp_2_1: .word 0x78546b3d
test_284_inp_2_2: .word 0xc5cea6a5
test_284_ajit_res_1: .word 0x0
test_284_ajit_res_2: .word 0x0
test_284_Cmodel_res_1: .word 0x0
test_284_Cmodel_res_2: .word 0x0

test_285_inp_1_1: .word 0x902af68e
test_285_inp_1_2: .word 0xced2acca
test_285_inp_2_1: .word 0x7d72bdf0
test_285_inp_2_2: .word 0xc45b7b13
test_285_ajit_res_1: .word 0x0
test_285_ajit_res_2: .word 0x0
test_285_Cmodel_res_1: .word 0x0
test_285_Cmodel_res_2: .word 0x0

test_286_inp_1_1: .word 0x964c066d
test_286_inp_1_2: .word 0xad7d5c74
test_286_inp_2_1: .word 0x77e7b559
test_286_inp_2_2: .word 0xf5663bcc
test_286_ajit_res_1: .word 0x0
test_286_ajit_res_2: .word 0x0
test_286_Cmodel_res_1: .word 0x0
test_286_Cmodel_res_2: .word 0x0

test_287_inp_1_1: .word 0x2891d59
test_287_inp_1_2: .word 0x9c68ee0d
test_287_inp_2_1: .word 0xf4723bdd
test_287_inp_2_2: .word 0x11881c91
test_287_ajit_res_1: .word 0x0
test_287_ajit_res_2: .word 0x0
test_287_Cmodel_res_1: .word 0x0
test_287_Cmodel_res_2: .word 0x0

test_288_inp_1_1: .word 0x8f6d17d0
test_288_inp_1_2: .word 0x5b76f0f
test_288_inp_2_1: .word 0x5f5c7244
test_288_inp_2_2: .word 0x61a42211
test_288_ajit_res_1: .word 0x0
test_288_ajit_res_2: .word 0x0
test_288_Cmodel_res_1: .word 0x0
test_288_Cmodel_res_2: .word 0x0

test_289_inp_1_1: .word 0x2ef2735
test_289_inp_1_2: .word 0x4e24e805
test_289_inp_2_1: .word 0xdc1dfce8
test_289_inp_2_2: .word 0x31a80095
test_289_ajit_res_1: .word 0x0
test_289_ajit_res_2: .word 0x0
test_289_Cmodel_res_1: .word 0x0
test_289_Cmodel_res_2: .word 0x0

test_290_inp_1_1: .word 0x1115adfa
test_290_inp_1_2: .word 0xf2a05f60
test_290_inp_2_1: .word 0xe970ef34
test_290_inp_2_2: .word 0x2b02c7de
test_290_ajit_res_1: .word 0x0
test_290_ajit_res_2: .word 0x0
test_290_Cmodel_res_1: .word 0x0
test_290_Cmodel_res_2: .word 0x0

test_291_inp_1_1: .word 0xaac71cc5
test_291_inp_1_2: .word 0xde673dbc
test_291_inp_2_1: .word 0x79434f01
test_291_inp_2_2: .word 0x122d1cc7
test_291_ajit_res_1: .word 0x0
test_291_ajit_res_2: .word 0x0
test_291_Cmodel_res_1: .word 0x0
test_291_Cmodel_res_2: .word 0x0

test_292_inp_1_1: .word 0x9135adfc
test_292_inp_1_2: .word 0xf277509b
test_292_inp_2_1: .word 0x6b69df7c
test_292_inp_2_2: .word 0x8da0f8fa
test_292_ajit_res_1: .word 0x0
test_292_ajit_res_2: .word 0x0
test_292_Cmodel_res_1: .word 0x0
test_292_Cmodel_res_2: .word 0x0

test_293_inp_1_1: .word 0x82b21d1b
test_293_inp_1_2: .word 0x79b7294
test_293_inp_2_1: .word 0x7eb42d27
test_293_inp_2_2: .word 0x7bf86171
test_293_ajit_res_1: .word 0x0
test_293_ajit_res_2: .word 0x0
test_293_Cmodel_res_1: .word 0x0
test_293_Cmodel_res_2: .word 0x0

test_294_inp_1_1: .word 0xa6886c4c
test_294_inp_1_2: .word 0x2c89f2cb
test_294_inp_2_1: .word 0x7e4abbe4
test_294_inp_2_2: .word 0xcf2933ee
test_294_ajit_res_1: .word 0x0
test_294_ajit_res_2: .word 0x0
test_294_Cmodel_res_1: .word 0x0
test_294_Cmodel_res_2: .word 0x0

test_295_inp_1_1: .word 0x954d5ad2
test_295_inp_1_2: .word 0x9c96076d
test_295_inp_2_1: .word 0x70ce9ed4
test_295_inp_2_2: .word 0x7c855023
test_295_ajit_res_1: .word 0x0
test_295_ajit_res_2: .word 0x0
test_295_Cmodel_res_1: .word 0x0
test_295_Cmodel_res_2: .word 0x0

test_296_inp_1_1: .word 0x9cf81bcf
test_296_inp_1_2: .word 0x55f30c40
test_296_inp_2_1: .word 0x7b995eb4
test_296_inp_2_2: .word 0x22a3fa58
test_296_ajit_res_1: .word 0x0
test_296_ajit_res_2: .word 0x0
test_296_Cmodel_res_1: .word 0x0
test_296_Cmodel_res_2: .word 0x0

test_297_inp_1_1: .word 0x4092edf
test_297_inp_1_2: .word 0x2ce1b4ff
test_297_inp_2_1: .word 0xfc3a5640
test_297_inp_2_2: .word 0xcce6a856
test_297_ajit_res_1: .word 0x0
test_297_ajit_res_2: .word 0x0
test_297_Cmodel_res_1: .word 0x0
test_297_Cmodel_res_2: .word 0x0

test_298_inp_1_1: .word 0x1f1895a
test_298_inp_1_2: .word 0x9760f667
test_298_inp_2_1: .word 0xecb8a77f
test_298_inp_2_2: .word 0x78294e4b
test_298_ajit_res_1: .word 0x0
test_298_ajit_res_2: .word 0x0
test_298_Cmodel_res_1: .word 0x0
test_298_Cmodel_res_2: .word 0x0

test_299_inp_1_1: .word 0x2ffb94f8
test_299_inp_1_2: .word 0x7f9c51a1
test_299_inp_2_1: .word 0xf9a596bb
test_299_inp_2_2: .word 0xa0c72142
test_299_ajit_res_1: .word 0x0
test_299_ajit_res_2: .word 0x0
test_299_Cmodel_res_1: .word 0x0
test_299_Cmodel_res_2: .word 0x0

test_300_inp_1_1: .word 0x9df97c7b
test_300_inp_1_2: .word 0xc0ee1b67
test_300_inp_2_1: .word 0x63cf7765
test_300_inp_2_2: .word 0x32a7fe91
test_300_ajit_res_1: .word 0x0
test_300_ajit_res_2: .word 0x0
test_300_Cmodel_res_1: .word 0x0
test_300_Cmodel_res_2: .word 0x0

test_301_inp_1_1: .word 0x5e28850
test_301_inp_1_2: .word 0x366bc294
test_301_inp_2_1: .word 0xeb41b6ca
test_301_inp_2_2: .word 0x14873011
test_301_ajit_res_1: .word 0x0
test_301_ajit_res_2: .word 0x0
test_301_Cmodel_res_1: .word 0x0
test_301_Cmodel_res_2: .word 0x0

test_302_inp_1_1: .word 0x26c10ce
test_302_inp_1_2: .word 0xf473f347
test_302_inp_2_1: .word 0xcacd33c2
test_302_inp_2_2: .word 0x41cd2561
test_302_ajit_res_1: .word 0x0
test_302_ajit_res_2: .word 0x0
test_302_Cmodel_res_1: .word 0x0
test_302_Cmodel_res_2: .word 0x0

test_303_inp_1_1: .word 0xbbd9a0e8
test_303_inp_1_2: .word 0x80938625
test_303_inp_2_1: .word 0xfded32f4
test_303_inp_2_2: .word 0x15658869
test_303_ajit_res_1: .word 0x0
test_303_ajit_res_2: .word 0x1c164
test_303_Cmodel_res_1: .word 0x0
test_303_Cmodel_res_2: .word 0x0

test_304_inp_1_1: .word 0xa713c61f
test_304_inp_1_2: .word 0xe3af8072
test_304_inp_2_1: .word 0xea521513
test_304_inp_2_2: .word 0xc06283f2
test_304_ajit_res_1: .word 0x0
test_304_ajit_res_2: .word 0x0
test_304_Cmodel_res_1: .word 0x0
test_304_Cmodel_res_2: .word 0x0

test_305_inp_1_1: .word 0x9dc6216f
test_305_inp_1_2: .word 0x6c421bee
test_305_inp_2_1: .word 0x6fa5d9bd
test_305_inp_2_2: .word 0xa9d3a459
test_305_ajit_res_1: .word 0x0
test_305_ajit_res_2: .word 0x0
test_305_Cmodel_res_1: .word 0x0
test_305_Cmodel_res_2: .word 0x0

test_306_inp_1_1: .word 0x99b88f0a
test_306_inp_1_2: .word 0xce623f3
test_306_inp_2_1: .word 0x735eb719
test_306_inp_2_2: .word 0x3e17374
test_306_ajit_res_1: .word 0x0
test_306_ajit_res_2: .word 0x0
test_306_Cmodel_res_1: .word 0x0
test_306_Cmodel_res_2: .word 0x0

test_307_inp_1_1: .word 0x79cc6a3
test_307_inp_1_2: .word 0x805bccc1
test_307_inp_2_1: .word 0xd1fd77a5
test_307_inp_2_2: .word 0x7e006b18
test_307_ajit_res_1: .word 0x0
test_307_ajit_res_2: .word 0x0
test_307_Cmodel_res_1: .word 0x0
test_307_Cmodel_res_2: .word 0x0

test_308_inp_1_1: .word 0x2146a8cc
test_308_inp_1_2: .word 0xb61f19da
test_308_inp_2_1: .word 0xf551176f
test_308_inp_2_2: .word 0x695c1169
test_308_ajit_res_1: .word 0x0
test_308_ajit_res_2: .word 0x0
test_308_Cmodel_res_1: .word 0x0
test_308_Cmodel_res_2: .word 0x0


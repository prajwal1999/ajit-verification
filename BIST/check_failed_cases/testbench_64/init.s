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

test_1_inp_1_1: .word 0x8002b150
test_1_inp_1_2: .word 0xc8d8a5e7
test_1_inp_2_1: .word 0x800f2ea2
test_1_inp_2_2: .word 0x51048d6c
test_1_ajit_res_1: .word 0x3fc6b394
test_1_ajit_res_2: .word 0xfd060489
test_1_Cmodel_res_1: .word 0x0
test_1_Cmodel_res_2: .word 0x0

test_2_inp_1_1: .word 0x80039c58
test_2_inp_1_2: .word 0xa35aca48
test_2_inp_2_1: .word 0xc62ec
test_2_inp_2_2: .word 0x465feddc
test_2_ajit_res_1: .word 0xbfd2a80c
test_2_ajit_res_2: .word 0xfc1b3543
test_2_Cmodel_res_1: .word 0x0
test_2_Cmodel_res_2: .word 0x0

test_3_inp_1_1: .word 0xd450e
test_3_inp_1_2: .word 0xda3f0ca7
test_3_inp_2_1: .word 0x8009d4cc
test_3_inp_2_2: .word 0xdf20bb7e
test_3_ajit_res_1: .word 0xbff59896
test_3_ajit_res_2: .word 0x4e4b5a62
test_3_Cmodel_res_1: .word 0x0
test_3_Cmodel_res_2: .word 0x0

test_4_inp_1_1: .word 0x74e42
test_4_inp_1_2: .word 0xe1115f0
test_4_inp_2_1: .word 0x800d6873
test_4_inp_2_2: .word 0xbb404bdb
test_4_ajit_res_1: .word 0xbfe16f9e
test_4_ajit_res_2: .word 0x2003a391
test_4_Cmodel_res_1: .word 0x0
test_4_Cmodel_res_2: .word 0x0

test_5_inp_1_1: .word 0x80005ecd
test_5_inp_1_2: .word 0xa2840865
test_5_inp_2_1: .word 0x80028ad7
test_5_inp_2_2: .word 0x6ba5b935
test_5_ajit_res_1: .word 0x3fc2a512
test_5_ajit_res_2: .word 0x6ce3b50f
test_5_Cmodel_res_1: .word 0x0
test_5_Cmodel_res_2: .word 0x0

test_6_inp_1_1: .word 0x1bdd
test_6_inp_1_2: .word 0x173e2982
test_6_inp_2_1: .word 0xbe11c
test_6_inp_2_2: .word 0x4d087551
test_6_ajit_res_1: .word 0x3f82c3b2
test_6_ajit_res_2: .word 0x1f2cfbf0
test_6_Cmodel_res_1: .word 0x0
test_6_Cmodel_res_2: .word 0x0

test_7_inp_1_1: .word 0x4a76f
test_7_inp_1_2: .word 0xd003f884
test_7_inp_2_1: .word 0x800ecf4f
test_7_inp_2_2: .word 0xcca75e75
test_7_ajit_res_1: .word 0xbfd41cbe
test_7_ajit_res_2: .word 0xe807717c
test_7_Cmodel_res_1: .word 0x0
test_7_Cmodel_res_2: .word 0x0

test_8_inp_1_1: .word 0x800fbf08
test_8_inp_1_2: .word 0xea6d530c
test_8_inp_2_1: .word 0x80036a18
test_8_inp_2_2: .word 0x5fd8caaa
test_8_ajit_res_1: .word 0x40127258
test_8_ajit_res_2: .word 0x77e77025
test_8_Cmodel_res_1: .word 0x0
test_8_Cmodel_res_2: .word 0x0

test_9_inp_1_1: .word 0xd5ab4
test_9_inp_1_2: .word 0x25de995
test_9_inp_2_1: .word 0x16d69
test_9_inp_2_2: .word 0x6e1d9706
test_9_ajit_res_1: .word 0x4022b625
test_9_ajit_res_2: .word 0x5b2a9448
test_9_Cmodel_res_1: .word 0x0
test_9_Cmodel_res_2: .word 0x0

test_10_inp_1_1: .word 0x800ed55e
test_10_inp_1_2: .word 0xe08345bc
test_10_inp_2_1: .word 0xc0915
test_10_inp_2_2: .word 0x4d4aac37
test_10_ajit_res_1: .word 0xbff3b83b
test_10_ajit_res_2: .word 0xfcef780a
test_10_Cmodel_res_1: .word 0x0
test_10_Cmodel_res_2: .word 0x0

test_11_inp_1_1: .word 0xcb8b2
test_11_inp_1_2: .word 0x53fe8f4f
test_11_inp_2_1: .word 0xad50e
test_11_inp_2_2: .word 0x9a314191
test_11_ajit_res_1: .word 0x3ff2ca5e
test_11_ajit_res_2: .word 0x9d41132b
test_11_Cmodel_res_1: .word 0x0
test_11_Cmodel_res_2: .word 0x0

test_12_inp_1_1: .word 0x800edbb9
test_12_inp_1_2: .word 0x4525a01e
test_12_inp_2_1: .word 0x33573
test_12_inp_2_2: .word 0x93782cde
test_12_ajit_res_1: .word 0xc012859f
test_12_ajit_res_2: .word 0x7518c66a
test_12_Cmodel_res_1: .word 0x0
test_12_Cmodel_res_2: .word 0x0

test_13_inp_1_1: .word 0xfa9ff
test_13_inp_1_2: .word 0x847b8a91
test_13_inp_2_1: .word 0x800f9045
test_13_inp_2_2: .word 0xe74bf9c4
test_13_ajit_res_1: .word 0xbff01a72
test_13_ajit_res_2: .word 0x49a7fb6d
test_13_Cmodel_res_1: .word 0x0
test_13_Cmodel_res_2: .word 0x0

test_14_inp_1_1: .word 0x2b40d
test_14_inp_1_2: .word 0x37b4c505
test_14_inp_2_1: .word 0x7244a
test_14_inp_2_2: .word 0xc3d44dcf
test_14_ajit_res_1: .word 0x3fd839ba
test_14_ajit_res_2: .word 0xeaddf180
test_14_Cmodel_res_1: .word 0x0
test_14_Cmodel_res_2: .word 0x0

test_15_inp_1_1: .word 0xeca18
test_15_inp_1_2: .word 0x65bdc4d9
test_15_inp_2_1: .word 0x6f81b
test_15_inp_2_2: .word 0xd0bca910
test_15_ajit_res_1: .word 0x4000fa1a
test_15_ajit_res_2: .word 0xd40028d8
test_15_Cmodel_res_1: .word 0x0
test_15_Cmodel_res_2: .word 0x0

test_16_inp_1_1: .word 0x8007391a
test_16_inp_1_2: .word 0xf6c87464
test_16_inp_2_1: .word 0x800bb064
test_16_inp_2_2: .word 0x84ac7d8c
test_16_ajit_res_1: .word 0x3fe3c620
test_16_ajit_res_2: .word 0x720b8119
test_16_Cmodel_res_1: .word 0x0
test_16_Cmodel_res_2: .word 0x0

test_17_inp_1_1: .word 0x29f84
test_17_inp_1_2: .word 0x3656efa7
test_17_inp_2_1: .word 0xed196
test_17_inp_2_2: .word 0xe1054bb8
test_17_ajit_res_1: .word 0x3fc6a860
test_17_ajit_res_2: .word 0xb095cae3
test_17_Cmodel_res_1: .word 0x0
test_17_Cmodel_res_2: .word 0x0

test_18_inp_1_1: .word 0x800eb293
test_18_inp_1_2: .word 0x30f452d4
test_18_inp_2_1: .word 0x54e93
test_18_inp_2_2: .word 0xbf398f71
test_18_ajit_res_1: .word 0xc00627ed
test_18_ajit_res_2: .word 0xe99d2676
test_18_Cmodel_res_1: .word 0x0
test_18_Cmodel_res_2: .word 0x0

test_19_inp_1_1: .word 0x800298b8
test_19_inp_1_2: .word 0xbfe7cef9
test_19_inp_2_1: .word 0xf7933
test_19_inp_2_2: .word 0xf0fc9f24
test_19_ajit_res_1: .word 0xbfc57abb
test_19_ajit_res_2: .word 0xd55bd23f
test_19_Cmodel_res_1: .word 0x0
test_19_Cmodel_res_2: .word 0x0

test_20_inp_1_1: .word 0x8007f92d
test_20_inp_1_2: .word 0x9dc17dc4
test_20_inp_2_1: .word 0xc3c3a
test_20_inp_2_2: .word 0x85630e3f
test_20_ajit_res_1: .word 0xbfe4da7a
test_20_ajit_res_2: .word 0x39c80ca7
test_20_Cmodel_res_1: .word 0x0
test_20_Cmodel_res_2: .word 0x0

test_21_inp_1_1: .word 0x8000d352
test_21_inp_1_2: .word 0xeaea490b
test_21_inp_2_1: .word 0x8005e20a
test_21_inp_2_2: .word 0xc23ebf59
test_21_ajit_res_1: .word 0x3fc1f5eb
test_21_ajit_res_2: .word 0xa3ba100a
test_21_Cmodel_res_1: .word 0x0
test_21_Cmodel_res_2: .word 0x0

test_22_inp_1_1: .word 0xef501
test_22_inp_1_2: .word 0x3fce20d7
test_22_inp_2_1: .word 0x800ebb1b
test_22_inp_2_2: .word 0xd88f6956
test_22_ajit_res_1: .word 0xbff03ee2
test_22_ajit_res_2: .word 0x4eabaf4d
test_22_Cmodel_res_1: .word 0x0
test_22_Cmodel_res_2: .word 0x0

test_23_inp_1_1: .word 0xfe4cc
test_23_inp_1_2: .word 0x14d773d4
test_23_inp_2_1: .word 0x3e42b
test_23_inp_2_2: .word 0x73ea833
test_23_ajit_res_1: .word 0x40105679
test_23_ajit_res_2: .word 0xa9453c8d
test_23_Cmodel_res_1: .word 0x0
test_23_Cmodel_res_2: .word 0x0

test_24_inp_1_1: .word 0x35bab
test_24_inp_1_2: .word 0x2e9346d4
test_24_inp_2_1: .word 0xb5b8f
test_24_inp_2_2: .word 0x1e775559
test_24_ajit_res_1: .word 0x3fd2ec34
test_24_ajit_res_2: .word 0x6fee4b11
test_24_Cmodel_res_1: .word 0x0
test_24_Cmodel_res_2: .word 0x0

test_25_inp_1_1: .word 0x8005c1b1
test_25_inp_1_2: .word 0xf91e66e8
test_25_inp_2_1: .word 0xb1a3e
test_25_inp_2_2: .word 0xd1e2e025
test_25_ajit_res_1: .word 0xbfe09786
test_25_ajit_res_2: .word 0xa6b69c44
test_25_Cmodel_res_1: .word 0x0
test_25_Cmodel_res_2: .word 0x0

test_26_inp_1_1: .word 0xbfb54
test_26_inp_1_2: .word 0x1ea1895c
test_26_inp_2_1: .word 0x800f05db
test_26_inp_2_2: .word 0x15491d4e
test_26_ajit_res_1: .word 0xbfe985ab
test_26_ajit_res_2: .word 0xbbc1d7ae
test_26_Cmodel_res_1: .word 0x0
test_26_Cmodel_res_2: .word 0x0

test_27_inp_1_1: .word 0x6e14c
test_27_inp_1_2: .word 0xf8e2a708
test_27_inp_2_1: .word 0x80001a1b
test_27_inp_2_2: .word 0x4dd7a046
test_27_ajit_res_1: .word 0xc050ddcc
test_27_ajit_res_2: .word 0x7b79877
test_27_Cmodel_res_1: .word 0x0
test_27_Cmodel_res_2: .word 0x0

test_28_inp_1_1: .word 0x800f30df
test_28_inp_1_2: .word 0x86ecedf
test_28_inp_2_1: .word 0x800b305d
test_28_inp_2_2: .word 0xfd124482
test_28_ajit_res_1: .word 0x3ff5b906
test_28_ajit_res_2: .word 0x54ef8d70
test_28_Cmodel_res_1: .word 0x0
test_28_Cmodel_res_2: .word 0x0

test_29_inp_1_1: .word 0x18842
test_29_inp_1_2: .word 0xa5a6554f
test_29_inp_2_1: .word 0xa88ec
test_29_inp_2_2: .word 0xd79baa25
test_29_ajit_res_1: .word 0x3fc29e03
test_29_ajit_res_2: .word 0xf030cb90
test_29_Cmodel_res_1: .word 0x0
test_29_Cmodel_res_2: .word 0x0

test_30_inp_1_1: .word 0x2f49c
test_30_inp_1_2: .word 0xd54f9a97
test_30_inp_2_1: .word 0x8002544b
test_30_inp_2_2: .word 0xcc954062
test_30_ajit_res_1: .word 0xbff44d39
test_30_ajit_res_2: .word 0xc3ba1671
test_30_Cmodel_res_1: .word 0x0
test_30_Cmodel_res_2: .word 0x0

test_31_inp_1_1: .word 0x800fcc1f
test_31_inp_1_2: .word 0x45612e5a
test_31_inp_2_1: .word 0xa302c
test_31_inp_2_2: .word 0x73673a86
test_31_ajit_res_1: .word 0xbff8cf14
test_31_ajit_res_2: .word 0xf6859b58
test_31_Cmodel_res_1: .word 0x0
test_31_Cmodel_res_2: .word 0x0

test_32_inp_1_1: .word 0xf740c
test_32_inp_1_2: .word 0xda3940d2
test_32_inp_2_1: .word 0x7191b
test_32_inp_2_2: .word 0xe86146d3
test_32_ajit_res_1: .word 0x40016ab9
test_32_ajit_res_2: .word 0xcd1e1daa
test_32_Cmodel_res_1: .word 0x0
test_32_Cmodel_res_2: .word 0x0

test_33_inp_1_1: .word 0x80001e15
test_33_inp_1_2: .word 0xbb3167dd
test_33_inp_2_1: .word 0x62deb
test_33_inp_2_2: .word 0xd4415252
test_33_ajit_res_1: .word 0xbf937970
test_33_ajit_res_2: .word 0x8f6cba7d
test_33_Cmodel_res_1: .word 0x0
test_33_Cmodel_res_2: .word 0x0

test_34_inp_1_1: .word 0x800d23c5
test_34_inp_1_2: .word 0x8ecaeffe
test_34_inp_2_1: .word 0xf6c1e
test_34_inp_2_2: .word 0x61d145a1
test_34_ajit_res_1: .word 0xbfeb4388
test_34_ajit_res_2: .word 0x25ec6e6
test_34_Cmodel_res_1: .word 0x0
test_34_Cmodel_res_2: .word 0x0

test_35_inp_1_1: .word 0xa7be1
test_35_inp_1_2: .word 0x5a927639
test_35_inp_2_1: .word 0x800a38e9
test_35_inp_2_2: .word 0x8b57fc95
test_35_ajit_res_1: .word 0xbff068d1
test_35_ajit_res_2: .word 0x8c839ca1
test_35_Cmodel_res_1: .word 0x0
test_35_Cmodel_res_2: .word 0x0

test_36_inp_1_1: .word 0xf99a7
test_36_inp_1_2: .word 0x81202ad6
test_36_inp_2_1: .word 0x779b4
test_36_inp_2_2: .word 0xbd741f03
test_36_ajit_res_1: .word 0x4000b1e8
test_36_ajit_res_2: .word 0x86b4083d
test_36_Cmodel_res_1: .word 0x0
test_36_Cmodel_res_2: .word 0x0

test_37_inp_1_1: .word 0xb8ee4
test_37_inp_1_2: .word 0xde422d37
test_37_inp_2_1: .word 0x800a5ea0
test_37_inp_2_2: .word 0xcb8904ad
test_37_ajit_res_1: .word 0xbff1d578
test_37_ajit_res_2: .word 0xcb384795
test_37_Cmodel_res_1: .word 0x0
test_37_Cmodel_res_2: .word 0x0

test_38_inp_1_1: .word 0x46967
test_38_inp_1_2: .word 0xe89ccf47
test_38_inp_2_1: .word 0x800f9671
test_38_inp_2_2: .word 0x17a4c719
test_38_ajit_res_1: .word 0xbfd21d20
test_38_ajit_res_2: .word 0x91be5a1b
test_38_Cmodel_res_1: .word 0x0
test_38_Cmodel_res_2: .word 0x0

test_39_inp_1_1: .word 0x800dd1c7
test_39_inp_1_2: .word 0x6fdd0e2a
test_39_inp_2_1: .word 0x8002b94c
test_39_inp_2_2: .word 0x4ae87eb6
test_39_ajit_res_1: .word 0x40144b51
test_39_ajit_res_2: .word 0xb3f83d7b
test_39_Cmodel_res_1: .word 0x0
test_39_Cmodel_res_2: .word 0x0

test_40_inp_1_1: .word 0x800e5260
test_40_inp_1_2: .word 0xa833148c
test_40_inp_2_1: .word 0x70d87
test_40_inp_2_2: .word 0xa47dd1a5
test_40_ajit_res_1: .word 0xc0003ebf
test_40_ajit_res_2: .word 0x25635ae9
test_40_Cmodel_res_1: .word 0x0
test_40_Cmodel_res_2: .word 0x0

test_41_inp_1_1: .word 0xc94f
test_41_inp_1_2: .word 0x542afa06
test_41_inp_2_1: .word 0x800e6f74
test_41_inp_2_2: .word 0x4398ee72
test_41_ajit_res_1: .word 0xbfabe425
test_41_ajit_res_2: .word 0xccd4d46c
test_41_Cmodel_res_1: .word 0x0
test_41_Cmodel_res_2: .word 0x0

test_42_inp_1_1: .word 0x8007c02c
test_42_inp_1_2: .word 0x37fa6e03
test_42_inp_2_1: .word 0x800dfbc2
test_42_inp_2_2: .word 0x28f07a1f
test_42_ajit_res_1: .word 0x3fe1bca0
test_42_ajit_res_2: .word 0x2ae6f585
test_42_Cmodel_res_1: .word 0x0
test_42_Cmodel_res_2: .word 0x0

test_43_inp_1_1: .word 0x913f5
test_43_inp_1_2: .word 0xfb989376
test_43_inp_2_1: .word 0x8eb94
test_43_inp_2_2: .word 0x9b85bfd0
test_43_ajit_res_1: .word 0x3ff0486d
test_43_ajit_res_2: .word 0xe2ce4b84
test_43_Cmodel_res_1: .word 0x0
test_43_Cmodel_res_2: .word 0x0

test_44_inp_1_1: .word 0x800c15d7
test_44_inp_1_2: .word 0xb5dd31ad
test_44_inp_2_1: .word 0x8004f934
test_44_inp_2_2: .word 0x4ad3408e
test_44_ajit_res_1: .word 0x40037091
test_44_ajit_res_2: .word 0xd318b3d5
test_44_Cmodel_res_1: .word 0x0
test_44_Cmodel_res_2: .word 0x0

test_45_inp_1_1: .word 0x8006341a
test_45_inp_1_2: .word 0x28187217
test_45_inp_2_1: .word 0x8005d3d7
test_45_inp_2_2: .word 0x5a702733
test_45_ajit_res_1: .word 0x3ff1084b
test_45_ajit_res_2: .word 0x4b045d5e
test_45_Cmodel_res_1: .word 0x0
test_45_Cmodel_res_2: .word 0x0

test_46_inp_1_1: .word 0x2ff92
test_46_inp_1_2: .word 0x335e862a
test_46_inp_2_1: .word 0x5b833
test_46_inp_2_2: .word 0xf310f1a6
test_46_ajit_res_1: .word 0x3fe0c672
test_46_ajit_res_2: .word 0x874299d5
test_46_Cmodel_res_1: .word 0x0
test_46_Cmodel_res_2: .word 0x0

test_47_inp_1_1: .word 0x76ad0
test_47_inp_1_2: .word 0xb03ac0bd
test_47_inp_2_1: .word 0x669d4
test_47_inp_2_2: .word 0x33053a7c
test_47_ajit_res_1: .word 0x3ff2811f
test_47_ajit_res_2: .word 0xbaefcd52
test_47_Cmodel_res_1: .word 0x0
test_47_Cmodel_res_2: .word 0x0

test_48_inp_1_1: .word 0x74dca
test_48_inp_1_2: .word 0x43ced301
test_48_inp_2_1: .word 0x68483
test_48_inp_2_2: .word 0xa353aee7
test_48_ajit_res_1: .word 0x3ff1ee1b
test_48_ajit_res_2: .word 0x9e703427
test_48_Cmodel_res_1: .word 0x0
test_48_Cmodel_res_2: .word 0x0

test_49_inp_1_1: .word 0xf391c
test_49_inp_1_2: .word 0xd0dce680
test_49_inp_2_1: .word 0xe5f68
test_49_inp_2_2: .word 0xbc0eff4d
test_49_ajit_res_1: .word 0x3ff0f25a
test_49_ajit_res_2: .word 0x3100376c
test_49_Cmodel_res_1: .word 0x0
test_49_Cmodel_res_2: .word 0x0

test_50_inp_1_1: .word 0xad4fd
test_50_inp_1_2: .word 0xf33b7827
test_50_inp_2_1: .word 0x800ab240
test_50_inp_2_2: .word 0x6729e717
test_50_ajit_res_1: .word 0xbff033f7
test_50_ajit_res_2: .word 0x5e46ba84
test_50_Cmodel_res_1: .word 0x0
test_50_Cmodel_res_2: .word 0x0

test_51_inp_1_1: .word 0x6d2ba
test_51_inp_1_2: .word 0x4811f298
test_51_inp_2_1: .word 0x800ab5d3
test_51_inp_2_2: .word 0xe854777d
test_51_ajit_res_1: .word 0xbfe462da
test_51_ajit_res_2: .word 0x157f94c5
test_51_Cmodel_res_1: .word 0x0
test_51_Cmodel_res_2: .word 0x0

test_52_inp_1_1: .word 0x8006f7ec
test_52_inp_1_2: .word 0xf69c8246
test_52_inp_2_1: .word 0x50fde
test_52_inp_2_2: .word 0xcd9deac2
test_52_ajit_res_1: .word 0xbff606a6
test_52_ajit_res_2: .word 0x70c8fffb
test_52_Cmodel_res_1: .word 0x0
test_52_Cmodel_res_2: .word 0x0

test_53_inp_1_1: .word 0x8003d8a3
test_53_inp_1_2: .word 0xbcd9f55a
test_53_inp_2_1: .word 0x8006e68a
test_53_inp_2_2: .word 0x53165030
test_53_ajit_res_1: .word 0x3fe1d614
test_53_ajit_res_2: .word 0xef2f1b4a
test_53_Cmodel_res_1: .word 0x0
test_53_Cmodel_res_2: .word 0x0

test_54_inp_1_1: .word 0x800f9f33
test_54_inp_1_2: .word 0x4f4f7544
test_54_inp_2_1: .word 0x80006c7f
test_54_inp_2_2: .word 0x61f83aae
test_54_ajit_res_1: .word 0x40426e0e
test_54_ajit_res_2: .word 0x3b50c202
test_54_Cmodel_res_1: .word 0x0
test_54_Cmodel_res_2: .word 0x0

test_55_inp_1_1: .word 0xf5a68
test_55_inp_1_2: .word 0x768c04f0
test_55_inp_2_1: .word 0x80019bec
test_55_inp_2_2: .word 0xc40c20f9
test_55_ajit_res_1: .word 0xc0231548
test_55_ajit_res_2: .word 0xfdc5d6c
test_55_Cmodel_res_1: .word 0x0
test_55_Cmodel_res_2: .word 0x0

test_56_inp_1_1: .word 0x800405c0
test_56_inp_1_2: .word 0xb1e35b80
test_56_inp_2_1: .word 0x800bad97
test_56_inp_2_2: .word 0xd9487d37
test_56_ajit_res_1: .word 0x3fd60b66
test_56_ajit_res_2: .word 0x44246695
test_56_Cmodel_res_1: .word 0x0
test_56_Cmodel_res_2: .word 0x0

test_57_inp_1_1: .word 0x800279e9
test_57_inp_1_2: .word 0xe534ff4f
test_57_inp_2_1: .word 0xfb394
test_57_inp_2_2: .word 0xaecaa571
test_57_ajit_res_1: .word 0xbfc42fb9
test_57_ajit_res_2: .word 0x3f2fde90
test_57_Cmodel_res_1: .word 0x0
test_57_Cmodel_res_2: .word 0x0

test_58_inp_1_1: .word 0x8004153b
test_58_inp_1_2: .word 0xb3499cad
test_58_inp_2_1: .word 0xf4e2f
test_58_inp_2_2: .word 0x2c7584d4
test_58_ajit_res_1: .word 0xbfd112ac
test_58_ajit_res_2: .word 0x328e4d7e
test_58_Cmodel_res_1: .word 0x0
test_58_Cmodel_res_2: .word 0x0

test_59_inp_1_1: .word 0x773b0
test_59_inp_1_2: .word 0x2067c01f
test_59_inp_2_1: .word 0x800b76fa
test_59_inp_2_2: .word 0x716ae85f
test_59_ajit_res_1: .word 0xbfe4ccaa
test_59_ajit_res_2: .word 0x93938afa
test_59_Cmodel_res_1: .word 0x0
test_59_Cmodel_res_2: .word 0x0

test_60_inp_1_1: .word 0x7e938
test_60_inp_1_2: .word 0x51869bea
test_60_inp_2_1: .word 0xe532
test_60_inp_2_2: .word 0xcb442c5d
test_60_ajit_res_1: .word 0x4021ac15
test_60_ajit_res_2: .word 0x3c13fb23
test_60_Cmodel_res_1: .word 0x0
test_60_Cmodel_res_2: .word 0x0

test_61_inp_1_1: .word 0x800552b4
test_61_inp_1_2: .word 0x6af459ed
test_61_inp_2_1: .word 0x4d041
test_61_inp_2_2: .word 0xe0366a1e
test_61_ajit_res_1: .word 0xbff1b19a
test_61_ajit_res_2: .word 0xd313110b
test_61_Cmodel_res_1: .word 0x0
test_61_Cmodel_res_2: .word 0x0

test_62_inp_1_1: .word 0x800af7ac
test_62_inp_1_2: .word 0x531e1f2a
test_62_inp_2_1: .word 0x800e3c81
test_62_inp_2_2: .word 0x5cf2a994
test_62_ajit_res_1: .word 0x3fe8a6fe
test_62_ajit_res_2: .word 0xf76c2578
test_62_Cmodel_res_1: .word 0x0
test_62_Cmodel_res_2: .word 0x0

test_63_inp_1_1: .word 0x52d77
test_63_inp_1_2: .word 0xb6163f8f
test_63_inp_2_1: .word 0x80009a0a
test_63_inp_2_2: .word 0x3b641030
test_63_ajit_res_1: .word 0xc021359b
test_63_ajit_res_2: .word 0x27f2f318
test_63_Cmodel_res_1: .word 0x0
test_63_Cmodel_res_2: .word 0x0

test_64_inp_1_1: .word 0xc1ab
test_64_inp_1_2: .word 0xe3a3a42f
test_64_inp_2_1: .word 0x800606b4
test_64_inp_2_2: .word 0x394608a7
test_64_ajit_res_1: .word 0xbfc011b3
test_64_ajit_res_2: .word 0xed3c3cf2
test_64_Cmodel_res_1: .word 0x0
test_64_Cmodel_res_2: .word 0x0

test_65_inp_1_1: .word 0x8007e02c
test_65_inp_1_2: .word 0x6d015e16
test_65_inp_2_1: .word 0x800e75cb
test_65_inp_2_2: .word 0x6c1a192a
test_65_ajit_res_1: .word 0x3fe16dc0
test_65_ajit_res_2: .word 0xcb603c8f
test_65_Cmodel_res_1: .word 0x0
test_65_Cmodel_res_2: .word 0x0

test_66_inp_1_1: .word 0xf3a73
test_66_inp_1_2: .word 0x5dabcfa
test_66_inp_2_1: .word 0x2ddbf
test_66_inp_2_2: .word 0x2ce77703
test_66_ajit_res_1: .word 0x40154095
test_66_ajit_res_2: .word 0xe3ce14c5
test_66_Cmodel_res_1: .word 0x0
test_66_Cmodel_res_2: .word 0x0

test_67_inp_1_1: .word 0x800d759b
test_67_inp_1_2: .word 0x496b405f
test_67_inp_2_1: .word 0x800edacb
test_67_inp_2_2: .word 0x8f1c611f
test_67_ajit_res_1: .word 0x3fecfe8a
test_67_ajit_res_2: .word 0xea93f87c
test_67_Cmodel_res_1: .word 0x0
test_67_Cmodel_res_2: .word 0x0

test_68_inp_1_1: .word 0x8000cf9f
test_68_inp_1_2: .word 0xbdace1ba
test_68_inp_2_1: .word 0x615eb
test_68_inp_2_2: .word 0x582a96f9
test_68_ajit_res_1: .word 0xbfc10efe
test_68_ajit_res_2: .word 0x39652952
test_68_Cmodel_res_1: .word 0x0
test_68_Cmodel_res_2: .word 0x0

test_69_inp_1_1: .word 0xf6ffb
test_69_inp_1_2: .word 0x97c5eb9b
test_69_inp_2_1: .word 0xca4fe
test_69_inp_2_2: .word 0xe1fbe68c
test_69_ajit_res_1: .word 0x3ff388b9
test_69_ajit_res_2: .word 0x5270ebfc
test_69_Cmodel_res_1: .word 0x0
test_69_Cmodel_res_2: .word 0x0

test_70_inp_1_1: .word 0x80091681
test_70_inp_1_2: .word 0xde79c4e2
test_70_inp_2_1: .word 0x8007e944
test_70_inp_2_2: .word 0xe4fe4feb
test_70_ajit_res_1: .word 0x3ff2613d
test_70_ajit_res_2: .word 0x3bc14ea
test_70_Cmodel_res_1: .word 0x0
test_70_Cmodel_res_2: .word 0x0

test_71_inp_1_1: .word 0xe96b6
test_71_inp_1_2: .word 0xa913a6e7
test_71_inp_2_1: .word 0x800ddbfa
test_71_inp_2_2: .word 0x44a0d86a
test_71_ajit_res_1: .word 0xbff0d794
test_71_ajit_res_2: .word 0x485c0cfa
test_71_Cmodel_res_1: .word 0x0
test_71_Cmodel_res_2: .word 0x0

test_72_inp_1_1: .word 0x8007da79
test_72_inp_1_2: .word 0xbcec9a67
test_72_inp_2_1: .word 0x800e13c1
test_72_inp_2_2: .word 0x92d93a93
test_72_ajit_res_1: .word 0x3fe1da2e
test_72_ajit_res_2: .word 0x2cfd28d2
test_72_Cmodel_res_1: .word 0x0
test_72_Cmodel_res_2: .word 0x0

test_73_inp_1_1: .word 0xf9ba7
test_73_inp_1_2: .word 0xac4e48f
test_73_inp_2_1: .word 0x80065ef9
test_73_inp_2_2: .word 0x3475ae86
test_73_ajit_res_1: .word 0xc003994e
test_73_ajit_res_2: .word 0xdfb10514
test_73_Cmodel_res_1: .word 0x0
test_73_Cmodel_res_2: .word 0x0

test_74_inp_1_1: .word 0x5c09
test_74_inp_1_2: .word 0x8c380e9
test_74_inp_2_1: .word 0x800aebb5
test_74_inp_2_2: .word 0x617f1da8
test_74_ajit_res_1: .word 0xbfa0daea
test_74_ajit_res_2: .word 0xb062560a
test_74_Cmodel_res_1: .word 0x0
test_74_Cmodel_res_2: .word 0x0

test_75_inp_1_1: .word 0xee72b
test_75_inp_1_2: .word 0x935ef922
test_75_inp_2_1: .word 0x800ebbae
test_75_inp_2_2: .word 0x54424c50
test_75_ajit_res_1: .word 0xbff02f3a
test_75_ajit_res_2: .word 0x9241d892
test_75_Cmodel_res_1: .word 0x0
test_75_Cmodel_res_2: .word 0x0

test_76_inp_1_1: .word 0x800e3a90
test_76_inp_1_2: .word 0x6c257969
test_76_inp_2_1: .word 0x67a66
test_76_inp_2_2: .word 0x793849db
test_76_ajit_res_1: .word 0xc001924b
test_76_ajit_res_2: .word 0x28a42195
test_76_Cmodel_res_1: .word 0x0
test_76_Cmodel_res_2: .word 0x0

test_77_inp_1_1: .word 0x8007fe72
test_77_inp_1_2: .word 0x5a9d4453
test_77_inp_2_1: .word 0x800e85ad
test_77_inp_2_2: .word 0xa5c50a1b
test_77_ajit_res_1: .word 0x3fe19d65
test_77_ajit_res_2: .word 0xe6a3edfe
test_77_Cmodel_res_1: .word 0x0
test_77_Cmodel_res_2: .word 0x0

test_78_inp_1_1: .word 0x800e545f
test_78_inp_1_2: .word 0xdad1a20e
test_78_inp_2_1: .word 0xdeec1
test_78_inp_2_2: .word 0x60d942ca
test_78_ajit_res_1: .word 0xbff074b2
test_78_ajit_res_2: .word 0x92ca64d9
test_78_Cmodel_res_1: .word 0x0
test_78_Cmodel_res_2: .word 0x0

test_79_inp_1_1: .word 0x80069743
test_79_inp_1_2: .word 0x83f56d09
test_79_inp_2_1: .word 0x8002f2e2
test_79_inp_2_2: .word 0x9f2ee593
test_79_ajit_res_1: .word 0x4001e189
test_79_ajit_res_2: .word 0xcfab6e68
test_79_Cmodel_res_1: .word 0x0
test_79_Cmodel_res_2: .word 0x0

test_80_inp_1_1: .word 0x78e5b
test_80_inp_1_2: .word 0x67f8a00a
test_80_inp_2_1: .word 0xc0d5d
test_80_inp_2_2: .word 0x1c8a13ca
test_80_ajit_res_1: .word 0x3fe40ff1
test_80_ajit_res_2: .word 0x79b7a89f
test_80_Cmodel_res_1: .word 0x0
test_80_Cmodel_res_2: .word 0x0

test_81_inp_1_1: .word 0x800f87bb
test_81_inp_1_2: .word 0xddfd719e
test_81_inp_2_1: .word 0x55bae
test_81_inp_2_2: .word 0x22d32cfd
test_81_ajit_res_1: .word 0xc0073001
test_81_ajit_res_2: .word 0xb58b59ba
test_81_Cmodel_res_1: .word 0x0
test_81_Cmodel_res_2: .word 0x0

test_82_inp_1_1: .word 0x800e4efe
test_82_inp_1_2: .word 0xe99d0dea
test_82_inp_2_1: .word 0x8005d58a
test_82_inp_2_2: .word 0xc8520d71
test_82_ajit_res_1: .word 0x40039ed5
test_82_ajit_res_2: .word 0xb418c667
test_82_Cmodel_res_1: .word 0x0
test_82_Cmodel_res_2: .word 0x0

test_83_inp_1_1: .word 0x8007f528
test_83_inp_1_2: .word 0x22ae8c41
test_83_inp_2_1: .word 0x800be51e
test_83_inp_2_2: .word 0xcaf2e119
test_83_ajit_res_1: .word 0x3fe5685e
test_83_ajit_res_2: .word 0xedc23af4
test_83_Cmodel_res_1: .word 0x0
test_83_Cmodel_res_2: .word 0x0

test_84_inp_1_1: .word 0x800ecf68
test_84_inp_1_2: .word 0x45ff475d
test_84_inp_2_1: .word 0x704c5
test_84_inp_2_2: .word 0x9f68ce93
test_84_ajit_res_1: .word 0xc000e187
test_84_ajit_res_2: .word 0x6e0206d1
test_84_Cmodel_res_1: .word 0x0
test_84_Cmodel_res_2: .word 0x0

test_85_inp_1_1: .word 0xffb4
test_85_inp_1_2: .word 0x131ff68f
test_85_inp_2_1: .word 0xdb507
test_85_inp_2_2: .word 0x57518aa2
test_85_ajit_res_1: .word 0x3fb2a79e
test_85_ajit_res_2: .word 0x1b696a7d
test_85_Cmodel_res_1: .word 0x0
test_85_Cmodel_res_2: .word 0x0

test_86_inp_1_1: .word 0x6f47b
test_86_inp_1_2: .word 0xabe62375
test_86_inp_2_1: .word 0x800d70aa
test_86_inp_2_2: .word 0x45b19273
test_86_ajit_res_1: .word 0xbfe08f36
test_86_ajit_res_2: .word 0xe9648d03
test_86_Cmodel_res_1: .word 0x0
test_86_Cmodel_res_2: .word 0x0

test_87_inp_1_1: .word 0x8007e84e
test_87_inp_1_2: .word 0x630a4023
test_87_inp_2_1: .word 0x372d7
test_87_inp_2_2: .word 0xd9e3c63
test_87_ajit_res_1: .word 0xc00257f5
test_87_ajit_res_2: .word 0xaf293b3
test_87_Cmodel_res_1: .word 0x0
test_87_Cmodel_res_2: .word 0x0

test_88_inp_1_1: .word 0xf7b4a
test_88_inp_1_2: .word 0xb263088c
test_88_inp_2_1: .word 0x800d1cf4
test_88_inp_2_2: .word 0x5ee6d9d
test_88_ajit_res_1: .word 0xbff2e3d3
test_88_ajit_res_2: .word 0x92314a59
test_88_Cmodel_res_1: .word 0x0
test_88_Cmodel_res_2: .word 0x0

test_89_inp_1_1: .word 0x800f3eed
test_89_inp_1_2: .word 0x9c37aba2
test_89_inp_2_1: .word 0x15753
test_89_inp_2_2: .word 0x677b6c75
test_89_ajit_res_1: .word 0xc026bc6a
test_89_ajit_res_2: .word 0xaf73375d
test_89_Cmodel_res_1: .word 0x0
test_89_Cmodel_res_2: .word 0x0

test_90_inp_1_1: .word 0x8001fe83
test_90_inp_1_2: .word 0x3ed0770a
test_90_inp_2_1: .word 0x8003bec9
test_90_inp_2_2: .word 0x28995564
test_90_ajit_res_1: .word 0x3fe109e4
test_90_ajit_res_2: .word 0x4fa52a26
test_90_Cmodel_res_1: .word 0x0
test_90_Cmodel_res_2: .word 0x0

test_91_inp_1_1: .word 0xc627f
test_91_inp_1_2: .word 0xd5c991db
test_91_inp_2_1: .word 0x8001eb8d
test_91_inp_2_2: .word 0x424d1438
test_91_ajit_res_1: .word 0xc019ccc7
test_91_ajit_res_2: .word 0x9f5aef9d
test_91_Cmodel_res_1: .word 0x0
test_91_Cmodel_res_2: .word 0x0

test_92_inp_1_1: .word 0xd64d6
test_92_inp_1_2: .word 0x19a8704f
test_92_inp_2_1: .word 0xccbb1
test_92_inp_2_2: .word 0x7750d36f
test_92_ajit_res_1: .word 0x3ff0bf7e
test_92_ajit_res_2: .word 0x59b9eda3
test_92_Cmodel_res_1: .word 0x0
test_92_Cmodel_res_2: .word 0x0

test_93_inp_1_1: .word 0xb3c25
test_93_inp_1_2: .word 0xfd4d4166
test_93_inp_2_1: .word 0x8007671d
test_93_inp_2_2: .word 0xc9034264
test_93_ajit_res_1: .word 0xbff84859
test_93_ajit_res_2: .word 0x3cdf9343
test_93_Cmodel_res_1: .word 0x0
test_93_Cmodel_res_2: .word 0x0

test_94_inp_1_1: .word 0x8003a886
test_94_inp_1_2: .word 0x3f2f8e69
test_94_inp_2_1: .word 0x35b43
test_94_inp_2_2: .word 0xdf156b35
test_94_ajit_res_1: .word 0xbff17048
test_94_ajit_res_2: .word 0xd37d0c8b
test_94_Cmodel_res_1: .word 0x0
test_94_Cmodel_res_2: .word 0x0

test_95_inp_1_1: .word 0x800ee40b
test_95_inp_1_2: .word 0x27575df9
test_95_inp_2_1: .word 0x800d6103
test_95_inp_2_2: .word 0x5575ad02
test_95_ajit_res_1: .word 0x3ff1ceda
test_95_ajit_res_2: .word 0x55e24fbb
test_95_Cmodel_res_1: .word 0x0
test_95_Cmodel_res_2: .word 0x0

test_96_inp_1_1: .word 0xdfa83
test_96_inp_1_2: .word 0x43a9b855
test_96_inp_2_1: .word 0x800d1947
test_96_inp_2_2: .word 0x24805e65
test_96_ajit_res_1: .word 0xbff1131f
test_96_ajit_res_2: .word 0x573dec91
test_96_Cmodel_res_1: .word 0x0
test_96_Cmodel_res_2: .word 0x0

test_97_inp_1_1: .word 0x8001dcea
test_97_inp_1_2: .word 0x545381d0
test_97_inp_2_1: .word 0xca70e
test_97_inp_2_2: .word 0x418752d3
test_97_ajit_res_1: .word 0xbfc2d8ba
test_97_ajit_res_2: .word 0x53fb76ed
test_97_Cmodel_res_1: .word 0x0
test_97_Cmodel_res_2: .word 0x0

test_98_inp_1_1: .word 0x8001c220
test_98_inp_1_2: .word 0x26462603
test_98_inp_2_1: .word 0xabe3
test_98_inp_2_2: .word 0xa65d4a8f
test_98_ajit_res_1: .word 0xc004f316
test_98_ajit_res_2: .word 0x80b6b8d5
test_98_Cmodel_res_1: .word 0x0
test_98_Cmodel_res_2: .word 0x0

test_99_inp_1_1: .word 0x800e37a0
test_99_inp_1_2: .word 0xac029441
test_99_inp_2_1: .word 0xbc88b
test_99_inp_2_2: .word 0xfd25a129
test_99_ajit_res_1: .word 0xbff34e0b
test_99_ajit_res_2: .word 0xe84b89cf
test_99_Cmodel_res_1: .word 0x0
test_99_Cmodel_res_2: .word 0x0

test_100_inp_1_1: .word 0x80064863
test_100_inp_1_2: .word 0xe1fb067f
test_100_inp_2_1: .word 0x80019059
test_100_inp_2_2: .word 0x27508fb3
test_100_ajit_res_1: .word 0x401011e5
test_100_ajit_res_2: .word 0xa88281e2
test_100_Cmodel_res_1: .word 0x0
test_100_Cmodel_res_2: .word 0x0

test_101_inp_1_1: .word 0x800cc0c0
test_101_inp_1_2: .word 0x811431ff
test_101_inp_2_1: .word 0x63f08
test_101_inp_2_2: .word 0xcf9d865c
test_101_ajit_res_1: .word 0xc0005567
test_101_ajit_res_2: .word 0xec82fdf8
test_101_Cmodel_res_1: .word 0x0
test_101_Cmodel_res_2: .word 0x0

test_102_inp_1_1: .word 0xe9733
test_102_inp_1_2: .word 0x4ac979d1
test_102_inp_2_1: .word 0x5ade7
test_102_inp_2_2: .word 0xcffcbf62
test_102_ajit_res_1: .word 0x40048d7a
test_102_ajit_res_2: .word 0x1809d301
test_102_Cmodel_res_1: .word 0x0
test_102_Cmodel_res_2: .word 0x0

test_103_inp_1_1: .word 0x800fd33f
test_103_inp_1_2: .word 0x94e5ba7b
test_103_inp_2_1: .word 0xda3b
test_103_inp_2_2: .word 0x7a738fcf
test_103_ajit_res_1: .word 0xc032905d
test_103_ajit_res_2: .word 0x46b8034f
test_103_Cmodel_res_1: .word 0x0
test_103_Cmodel_res_2: .word 0x0

test_104_inp_1_1: .word 0x800d0eee
test_104_inp_1_2: .word 0x7b294c09
test_104_inp_2_1: .word 0x8005e812
test_104_inp_2_2: .word 0x3daf3cd1
test_104_ajit_res_1: .word 0x4001afc7
test_104_ajit_res_2: .word 0x51a816e0
test_104_Cmodel_res_1: .word 0x0
test_104_Cmodel_res_2: .word 0x0

test_105_inp_1_1: .word 0x3ba34
test_105_inp_1_2: .word 0xc890ffcd
test_105_inp_2_1: .word 0x6bcef
test_105_inp_2_2: .word 0x80238d72
test_105_ajit_res_1: .word 0x3fe1b3ae
test_105_ajit_res_2: .word 0x3fdf9c1a
test_105_Cmodel_res_1: .word 0x0
test_105_Cmodel_res_2: .word 0x0

test_106_inp_1_1: .word 0x486a2
test_106_inp_1_2: .word 0x471e9d2d
test_106_inp_2_1: .word 0x800320f9
test_106_inp_2_2: .word 0x813c4b57
test_106_ajit_res_1: .word 0xbff724fc
test_106_ajit_res_2: .word 0xbb337d97
test_106_Cmodel_res_1: .word 0x0
test_106_Cmodel_res_2: .word 0x0

test_107_inp_1_1: .word 0x8002d194
test_107_inp_1_2: .word 0x64bb9ce8
test_107_inp_2_1: .word 0x4dfa8
test_107_inp_2_2: .word 0xb2aad1d1
test_107_ajit_res_1: .word 0xbfe281d1
test_107_ajit_res_2: .word 0x4ad3c825
test_107_Cmodel_res_1: .word 0x0
test_107_Cmodel_res_2: .word 0x0

test_108_inp_1_1: .word 0x800f89bd
test_108_inp_1_2: .word 0x57ed7702
test_108_inp_2_1: .word 0x362f8
test_108_inp_2_2: .word 0x22272d6c
test_108_ajit_res_1: .word 0xc0125a36
test_108_ajit_res_2: .word 0x41243a10
test_108_Cmodel_res_1: .word 0x0
test_108_Cmodel_res_2: .word 0x0

test_109_inp_1_1: .word 0x800f305b
test_109_inp_1_2: .word 0xdeb4e7ae
test_109_inp_2_1: .word 0x800ed291
test_109_inp_2_2: .word 0x1307a5e1
test_109_ajit_res_1: .word 0x3ff0653e
test_109_ajit_res_2: .word 0x2b1f6111
test_109_Cmodel_res_1: .word 0x0
test_109_Cmodel_res_2: .word 0x0

test_110_inp_1_1: .word 0xb40c
test_110_inp_1_2: .word 0x65bca272
test_110_inp_2_1: .word 0x800776e8
test_110_inp_2_2: .word 0x897d07b6
test_110_ajit_res_1: .word 0xbfb81ee4
test_110_ajit_res_2: .word 0x7eb16550
test_110_Cmodel_res_1: .word 0x0
test_110_Cmodel_res_2: .word 0x0

test_111_inp_1_1: .word 0x80076823
test_111_inp_1_2: .word 0xf1badf75
test_111_inp_2_1: .word 0x80055639
test_111_inp_2_2: .word 0x2c16d78b
test_111_ajit_res_1: .word 0x3ff634b7
test_111_ajit_res_2: .word 0x33523d4d
test_111_Cmodel_res_1: .word 0x0
test_111_Cmodel_res_2: .word 0x0

test_112_inp_1_1: .word 0x4bc4c
test_112_inp_1_2: .word 0xb5e77086
test_112_inp_2_1: .word 0x7a625
test_112_inp_2_2: .word 0x48e5fe7
test_112_ajit_res_1: .word 0x3fe3cfb8
test_112_ajit_res_2: .word 0x1b583b9
test_112_Cmodel_res_1: .word 0x0
test_112_Cmodel_res_2: .word 0x0

test_113_inp_1_1: .word 0xf9df8
test_113_inp_1_2: .word 0x25e4442d
test_113_inp_2_1: .word 0x8001d000
test_113_inp_2_2: .word 0x6bf127e5
test_113_ajit_res_1: .word 0xc0213b89
test_113_ajit_res_2: .word 0x65552bae
test_113_Cmodel_res_1: .word 0x0
test_113_Cmodel_res_2: .word 0x0

test_114_inp_1_1: .word 0x3a89b
test_114_inp_1_2: .word 0x4b279592
test_114_inp_2_1: .word 0x800a4db1
test_114_inp_2_2: .word 0xba94fe39
test_114_ajit_res_1: .word 0xbfd6b9b7
test_114_ajit_res_2: .word 0xf2f29624
test_114_Cmodel_res_1: .word 0x0
test_114_Cmodel_res_2: .word 0x0

test_115_inp_1_1: .word 0x8006e6ae
test_115_inp_1_2: .word 0x9b12ddfb
test_115_inp_2_1: .word 0x8006c1fe
test_115_inp_2_2: .word 0x942ce680
test_115_ajit_res_1: .word 0x3ff056dc
test_115_ajit_res_2: .word 0xeaaa3997
test_115_Cmodel_res_1: .word 0x0
test_115_Cmodel_res_2: .word 0x0

test_116_inp_1_1: .word 0x1a68f
test_116_inp_1_2: .word 0x5c138748
test_116_inp_2_1: .word 0x2e0d1
test_116_inp_2_2: .word 0xd22f7246
test_116_ajit_res_1: .word 0x3fe25a0b
test_116_ajit_res_2: .word 0x741cde40
test_116_Cmodel_res_1: .word 0x0
test_116_Cmodel_res_2: .word 0x0

test_117_inp_1_1: .word 0x7dbd0
test_117_inp_1_2: .word 0xae4cc358
test_117_inp_2_1: .word 0x80073d12
test_117_inp_2_2: .word 0x1df78cde
test_117_ajit_res_1: .word 0xbff15ee2
test_117_ajit_res_2: .word 0xe020b162
test_117_Cmodel_res_1: .word 0x0
test_117_Cmodel_res_2: .word 0x0

test_118_inp_1_1: .word 0x7a31
test_118_inp_1_2: .word 0x181017ee
test_118_inp_2_1: .word 0x8006ac31
test_118_inp_2_2: .word 0x645a0c41
test_118_ajit_res_1: .word 0xbfb24ff8
test_118_ajit_res_2: .word 0xbe059b1b
test_118_Cmodel_res_1: .word 0x0
test_118_Cmodel_res_2: .word 0x0

test_119_inp_1_1: .word 0x78813
test_119_inp_1_2: .word 0xb97e167f
test_119_inp_2_1: .word 0x800c924f
test_119_inp_2_2: .word 0x28609593
test_119_ajit_res_1: .word 0xbfe32bcb
test_119_ajit_res_2: .word 0xf1d1d5de
test_119_Cmodel_res_1: .word 0x0
test_119_Cmodel_res_2: .word 0x0

test_120_inp_1_1: .word 0x800e5549
test_120_inp_1_2: .word 0x9b45d855
test_120_inp_2_1: .word 0x800bacf2
test_120_inp_2_2: .word 0xaf45e6a5
test_120_ajit_res_1: .word 0x3ff3a453
test_120_ajit_res_2: .word 0x2f35e4ca
test_120_Cmodel_res_1: .word 0x0
test_120_Cmodel_res_2: .word 0x0

test_121_inp_1_1: .word 0x82f2c
test_121_inp_1_2: .word 0x9aeaee2c
test_121_inp_2_1: .word 0xc6e4b
test_121_inp_2_2: .word 0x454130f0
test_121_ajit_res_1: .word 0x3fe5117d
test_121_ajit_res_2: .word 0x25b3b164
test_121_Cmodel_res_1: .word 0x0
test_121_Cmodel_res_2: .word 0x0

test_122_inp_1_1: .word 0x80007567
test_122_inp_1_2: .word 0x65a14579
test_122_inp_2_1: .word 0x17c8
test_122_inp_2_2: .word 0x18f279b3
test_122_ajit_res_1: .word 0xc013bf3a
test_122_ajit_res_2: .word 0x9ce80e51
test_122_Cmodel_res_1: .word 0x0
test_122_Cmodel_res_2: .word 0x0

test_123_inp_1_1: .word 0x73aa6
test_123_inp_1_2: .word 0x442e8680
test_123_inp_2_1: .word 0x800e1269
test_123_inp_2_2: .word 0x24cd7b8d
test_123_ajit_res_1: .word 0xbfe07070
test_123_ajit_res_2: .word 0x30bedba
test_123_Cmodel_res_1: .word 0x0
test_123_Cmodel_res_2: .word 0x0

test_124_inp_1_1: .word 0x8001964a
test_124_inp_1_2: .word 0x5ed1d3fe
test_124_inp_2_1: .word 0x800b04e5
test_124_inp_2_2: .word 0xdbd54fd9
test_124_ajit_res_1: .word 0x3fc26f89
test_124_ajit_res_2: .word 0xf7b2118
test_124_Cmodel_res_1: .word 0x0
test_124_Cmodel_res_2: .word 0x0

test_125_inp_1_1: .word 0x38963
test_125_inp_1_2: .word 0xff0e0253
test_125_inp_2_1: .word 0xcd6e9f1a
test_125_inp_2_2: .word 0xee14ea97
test_125_ajit_res_1: .word 0x80000000
test_125_ajit_res_2: .word 0x0
test_125_Cmodel_res_1: .word 0x0
test_125_Cmodel_res_2: .word 0x0

test_126_inp_1_1: .word 0x3610c
test_126_inp_1_2: .word 0x62d92f99
test_126_inp_2_1: .word 0x43cddbc5
test_126_inp_2_2: .word 0x5ea85b86
test_126_ajit_res_1: .word 0x0
test_126_ajit_res_2: .word 0x0
test_126_Cmodel_res_1: .word 0x0
test_126_Cmodel_res_2: .word 0x0

test_127_inp_1_1: .word 0x800b200b
test_127_inp_1_2: .word 0xacc8198a
test_127_inp_2_1: .word 0xa5559474
test_127_inp_2_2: .word 0xdcd4ab39
test_127_ajit_res_1: .word 0x1aa07f41
test_127_ajit_res_2: .word 0x548bc93f
test_127_Cmodel_res_1: .word 0x0
test_127_Cmodel_res_2: .word 0x0

test_128_inp_1_1: .word 0x6cc3e
test_128_inp_1_2: .word 0x8d3ed92f
test_128_inp_2_1: .word 0xdf5776cc
test_128_inp_2_2: .word 0x7a0d0f5d
test_128_ajit_res_1: .word 0x80000000
test_128_ajit_res_2: .word 0x0
test_128_Cmodel_res_1: .word 0x0
test_128_Cmodel_res_2: .word 0x0

test_129_inp_1_1: .word 0x80077d5d
test_129_inp_1_2: .word 0x904c7c4d
test_129_inp_2_1: .word 0xf1e0393e
test_129_inp_2_2: .word 0x181057f5
test_129_ajit_res_1: .word 0x0
test_129_ajit_res_2: .word 0x0
test_129_Cmodel_res_1: .word 0x0
test_129_Cmodel_res_2: .word 0x0

test_130_inp_1_1: .word 0x8006bd8f
test_130_inp_1_2: .word 0x95dd6455
test_130_inp_2_1: .word 0x819663e0
test_130_inp_2_2: .word 0x869f6bdd
test_130_ajit_res_1: .word 0x3e534458
test_130_ajit_res_2: .word 0x112d16bc
test_130_Cmodel_res_1: .word 0x0
test_130_Cmodel_res_2: .word 0x0

test_131_inp_1_1: .word 0x275f
test_131_inp_1_2: .word 0x87ab63b0
test_131_inp_2_1: .word 0x574f7c10
test_131_inp_2_2: .word 0xce4d977
test_131_ajit_res_1: .word 0x0
test_131_ajit_res_2: .word 0x0
test_131_Cmodel_res_1: .word 0x0
test_131_Cmodel_res_2: .word 0x0

test_132_inp_1_1: .word 0x8006aefa
test_132_inp_1_2: .word 0x4533931f
test_132_inp_2_1: .word 0xe730ebed
test_132_inp_2_2: .word 0x28ccd3f9
test_132_ajit_res_1: .word 0x0
test_132_ajit_res_2: .word 0x0
test_132_Cmodel_res_1: .word 0x0
test_132_Cmodel_res_2: .word 0x0

test_133_inp_1_1: .word 0xfe8c4
test_133_inp_1_2: .word 0x83da0c98
test_133_inp_2_1: .word 0x1be62dd5
test_133_inp_2_2: .word 0x80cf9e81
test_133_ajit_res_1: .word 0x2416f434
test_133_ajit_res_2: .word 0x4c41667e
test_133_Cmodel_res_1: .word 0x0
test_133_Cmodel_res_2: .word 0x0

test_134_inp_1_1: .word 0x67ce4
test_134_inp_1_2: .word 0x19dd562b
test_134_inp_2_1: .word 0xdfae12dc
test_134_inp_2_2: .word 0xf00647
test_134_ajit_res_1: .word 0x80000000
test_134_ajit_res_2: .word 0x0
test_134_Cmodel_res_1: .word 0x0
test_134_Cmodel_res_2: .word 0x0

test_135_inp_1_1: .word 0x631af
test_135_inp_1_2: .word 0x6a88b06f
test_135_inp_2_1: .word 0xd171bbbf
test_135_inp_2_2: .word 0x35e25acf
test_135_ajit_res_1: .word 0x80000000
test_135_ajit_res_2: .word 0x0
test_135_Cmodel_res_1: .word 0x0
test_135_Cmodel_res_2: .word 0x0

test_136_inp_1_1: .word 0x80037c06
test_136_inp_1_2: .word 0xcfc27606
test_136_inp_2_1: .word 0x22449ab4
test_136_inp_2_2: .word 0x1ad4b36a
test_136_ajit_res_1: .word 0x9d95a587
test_136_ajit_res_2: .word 0xae1d585f
test_136_Cmodel_res_1: .word 0x0
test_136_Cmodel_res_2: .word 0x0

test_137_inp_1_1: .word 0x46452
test_137_inp_1_2: .word 0x37a2059d
test_137_inp_2_1: .word 0xc2b4491c
test_137_inp_2_2: .word 0x365386d6
test_137_ajit_res_1: .word 0x80000000
test_137_ajit_res_2: .word 0x37
test_137_Cmodel_res_1: .word 0x0
test_137_Cmodel_res_2: .word 0x0

test_138_inp_1_1: .word 0x34453
test_138_inp_1_2: .word 0xb418eaad
test_138_inp_2_1: .word 0x4e2c908a
test_138_inp_2_2: .word 0xa86fd038
test_138_ajit_res_1: .word 0x0
test_138_ajit_res_2: .word 0x0
test_138_Cmodel_res_1: .word 0x0
test_138_Cmodel_res_2: .word 0x0

test_139_inp_1_1: .word 0xefffb
test_139_inp_1_2: .word 0x3d967477
test_139_inp_2_1: .word 0xb87d7a84
test_139_inp_2_2: .word 0x2a40a55f
test_139_ajit_res_1: .word 0x8780486e
test_139_ajit_res_2: .word 0x2d871a72
test_139_Cmodel_res_1: .word 0x0
test_139_Cmodel_res_2: .word 0x0

test_140_inp_1_1: .word 0x8005758a
test_140_inp_1_2: .word 0x1e04bfb2
test_140_inp_2_1: .word 0xffafc7e4
test_140_inp_2_2: .word 0x287b1a4d
test_140_ajit_res_1: .word 0x0
test_140_ajit_res_2: .word 0x0
test_140_Cmodel_res_1: .word 0x0
test_140_Cmodel_res_2: .word 0x0

test_141_inp_1_1: .word 0x7bbfd
test_141_inp_1_2: .word 0xe4f6f6ee
test_141_inp_2_1: .word 0xcfd26fd3
test_141_inp_2_2: .word 0x3d596083
test_141_ajit_res_1: .word 0x80000000
test_141_ajit_res_2: .word 0x0
test_141_Cmodel_res_1: .word 0x0
test_141_Cmodel_res_2: .word 0x0

test_142_inp_1_1: .word 0x80079251
test_142_inp_1_2: .word 0x81dad27
test_142_inp_2_1: .word 0x4e5999b0
test_142_inp_2_2: .word 0x67b83fbd
test_142_ajit_res_1: .word 0x80000000
test_142_ajit_res_2: .word 0x0
test_142_Cmodel_res_1: .word 0x0
test_142_Cmodel_res_2: .word 0x0

test_143_inp_1_1: .word 0x8007260e
test_143_inp_1_2: .word 0x176ef1c7
test_143_inp_2_1: .word 0x702794a3
test_143_inp_2_2: .word 0x750cbde4
test_143_ajit_res_1: .word 0x80000000
test_143_ajit_res_2: .word 0x0
test_143_Cmodel_res_1: .word 0x0
test_143_Cmodel_res_2: .word 0x0

test_144_inp_1_1: .word 0x8004920a
test_144_inp_1_2: .word 0x845f4ce4
test_144_inp_2_1: .word 0xc1ba3734
test_144_inp_2_2: .word 0xf9e24b7d
test_144_ajit_res_1: .word 0x0
test_144_ajit_res_2: .word 0x2ca1a2
test_144_Cmodel_res_1: .word 0x0
test_144_Cmodel_res_2: .word 0x0

test_145_inp_1_1: .word 0x13e33
test_145_inp_1_2: .word 0x528407eb
test_145_inp_2_1: .word 0xd89bd170
test_145_inp_2_2: .word 0x3f959524
test_145_ajit_res_1: .word 0x80000000
test_145_ajit_res_2: .word 0x0
test_145_Cmodel_res_1: .word 0x0
test_145_Cmodel_res_2: .word 0x0

test_146_inp_1_1: .word 0x16f32
test_146_inp_1_2: .word 0xc3071a60
test_146_inp_2_1: .word 0x72bfb12b
test_146_inp_2_2: .word 0x9ca38c54
test_146_ajit_res_1: .word 0x0
test_146_ajit_res_2: .word 0x0
test_146_Cmodel_res_1: .word 0x0
test_146_Cmodel_res_2: .word 0x0

test_147_inp_1_1: .word 0x8000e3ec
test_147_inp_1_2: .word 0x50c99bf0
test_147_inp_2_1: .word 0x507fc1c7
test_147_inp_2_2: .word 0x60fef4c7
test_147_ajit_res_1: .word 0x80000000
test_147_ajit_res_2: .word 0x0
test_147_Cmodel_res_1: .word 0x0
test_147_Cmodel_res_2: .word 0x0

test_148_inp_1_1: .word 0x64abc
test_148_inp_1_2: .word 0x64b64376
test_148_inp_2_1: .word 0x7f67b6a4
test_148_inp_2_2: .word 0x9d613270
test_148_ajit_res_1: .word 0x0
test_148_ajit_res_2: .word 0x0
test_148_Cmodel_res_1: .word 0x0
test_148_Cmodel_res_2: .word 0x0

test_149_inp_1_1: .word 0x80049e06
test_149_inp_1_2: .word 0xc2903b84
test_149_inp_2_1: .word 0xf6a3160e
test_149_inp_2_2: .word 0x998d7af3
test_149_ajit_res_1: .word 0x0
test_149_ajit_res_2: .word 0x0
test_149_Cmodel_res_1: .word 0x0
test_149_Cmodel_res_2: .word 0x0

test_150_inp_1_1: .word 0x7005a
test_150_inp_1_2: .word 0x76dae903
test_150_inp_2_1: .word 0xfb394546
test_150_inp_2_2: .word 0xd18f7c11
test_150_ajit_res_1: .word 0x80000000
test_150_ajit_res_2: .word 0x0
test_150_Cmodel_res_1: .word 0x0
test_150_Cmodel_res_2: .word 0x0

test_151_inp_1_1: .word 0x40da
test_151_inp_1_2: .word 0x3f558a64
test_151_inp_2_1: .word 0xccdb2f34
test_151_inp_2_2: .word 0x9fe53870
test_151_ajit_res_1: .word 0x80000000
test_151_ajit_res_2: .word 0x0
test_151_Cmodel_res_1: .word 0x0
test_151_Cmodel_res_2: .word 0x0

test_152_inp_1_1: .word 0x80060809
test_152_inp_1_2: .word 0x83ddb294
test_152_inp_2_1: .word 0x7a2e95ca
test_152_inp_2_2: .word 0x88062cf1
test_152_ajit_res_1: .word 0x80000000
test_152_ajit_res_2: .word 0x0
test_152_Cmodel_res_1: .word 0x0
test_152_Cmodel_res_2: .word 0x0

test_153_inp_1_1: .word 0x52522
test_153_inp_1_2: .word 0x23e851b5
test_153_inp_2_1: .word 0x73504c87
test_153_inp_2_2: .word 0xf214c56
test_153_ajit_res_1: .word 0x0
test_153_ajit_res_2: .word 0x0
test_153_Cmodel_res_1: .word 0x0
test_153_Cmodel_res_2: .word 0x0

test_154_inp_1_1: .word 0x80002890
test_154_inp_1_2: .word 0xc28758bd
test_154_inp_2_1: .word 0x7cd90726
test_154_inp_2_2: .word 0x1b5bd94c
test_154_ajit_res_1: .word 0x80000000
test_154_ajit_res_2: .word 0x0
test_154_Cmodel_res_1: .word 0x0
test_154_Cmodel_res_2: .word 0x0

test_155_inp_1_1: .word 0x66685
test_155_inp_1_2: .word 0x7a569f05
test_155_inp_2_1: .word 0xf268e996
test_155_inp_2_2: .word 0x9013537b
test_155_ajit_res_1: .word 0x80000000
test_155_ajit_res_2: .word 0x0
test_155_Cmodel_res_1: .word 0x0
test_155_Cmodel_res_2: .word 0x0

test_156_inp_1_1: .word 0x287cc
test_156_inp_1_2: .word 0x9cea71d6
test_156_inp_2_1: .word 0xdc292093
test_156_inp_2_2: .word 0x501f10b5
test_156_ajit_res_1: .word 0x80000000
test_156_ajit_res_2: .word 0x0
test_156_Cmodel_res_1: .word 0x0
test_156_Cmodel_res_2: .word 0x0

test_157_inp_1_1: .word 0x32f3a
test_157_inp_1_2: .word 0x57585d93
test_157_inp_2_1: .word 0x13d271bd
test_157_inp_2_2: .word 0x2d83e9e8
test_157_ajit_res_1: .word 0x2c061988
test_157_ajit_res_2: .word 0x19db356c
test_157_Cmodel_res_1: .word 0x0
test_157_Cmodel_res_2: .word 0x0

test_158_inp_1_1: .word 0x8007650c
test_158_inp_1_2: .word 0x4f27dc0d
test_158_inp_2_1: .word 0xd3570aaf
test_158_inp_2_2: .word 0x42530f5
test_158_ajit_res_1: .word 0x0
test_158_ajit_res_2: .word 0x0
test_158_Cmodel_res_1: .word 0x0
test_158_Cmodel_res_2: .word 0x0

test_159_inp_1_1: .word 0x63cf8
test_159_inp_1_2: .word 0x88bb6759
test_159_inp_2_1: .word 0x54558885
test_159_inp_2_2: .word 0xf436e7d7
test_159_ajit_res_1: .word 0x0
test_159_ajit_res_2: .word 0x0
test_159_Cmodel_res_1: .word 0x0
test_159_Cmodel_res_2: .word 0x0

test_160_inp_1_1: .word 0x80051691
test_160_inp_1_2: .word 0x245d32e7
test_160_inp_2_1: .word 0x502b5275
test_160_inp_2_2: .word 0x1581d142
test_160_ajit_res_1: .word 0x80000000
test_160_ajit_res_2: .word 0x0
test_160_Cmodel_res_1: .word 0x0
test_160_Cmodel_res_2: .word 0x0

test_161_inp_1_1: .word 0x80059b11
test_161_inp_1_2: .word 0x2f27c2fc
test_161_inp_2_1: .word 0x61c4825
test_161_inp_2_2: .word 0x5824b279
test_161_ajit_res_1: .word 0xb9c95eef
test_161_ajit_res_2: .word 0x74ca8bd8
test_161_Cmodel_res_1: .word 0x0
test_161_Cmodel_res_2: .word 0x0

test_162_inp_1_1: .word 0x8000577a
test_162_inp_1_2: .word 0x12504e76
test_162_inp_2_1: .word 0xcf4a7c49
test_162_inp_2_2: .word 0x1d7db36a
test_162_ajit_res_1: .word 0x0
test_162_ajit_res_2: .word 0x0
test_162_Cmodel_res_1: .word 0x0
test_162_Cmodel_res_2: .word 0x0

test_163_inp_1_1: .word 0x2c883
test_163_inp_1_2: .word 0xe889609
test_163_inp_2_1: .word 0xcf9dbce2
test_163_inp_2_2: .word 0xf2bb2565
test_163_ajit_res_1: .word 0x80000000
test_163_ajit_res_2: .word 0x0
test_163_Cmodel_res_1: .word 0x0
test_163_Cmodel_res_2: .word 0x0

test_164_inp_1_1: .word 0x8006bf30
test_164_inp_1_2: .word 0xfc29d77b
test_164_inp_2_1: .word 0xf27b1b62
test_164_inp_2_2: .word 0xd9613a15
test_164_ajit_res_1: .word 0x0
test_164_ajit_res_2: .word 0x0
test_164_Cmodel_res_1: .word 0x0
test_164_Cmodel_res_2: .word 0x0

test_165_inp_1_1: .word 0x80001a52
test_165_inp_1_2: .word 0xd58ed54c
test_165_inp_2_1: .word 0x6259c610
test_165_inp_2_2: .word 0xfef51be6
test_165_ajit_res_1: .word 0x80000000
test_165_ajit_res_2: .word 0x0
test_165_Cmodel_res_1: .word 0x0
test_165_Cmodel_res_2: .word 0x0

test_166_inp_1_1: .word 0x7db4e
test_166_inp_1_2: .word 0x53e42d15
test_166_inp_2_1: .word 0x7614aac4
test_166_inp_2_2: .word 0xb3f4000f
test_166_ajit_res_1: .word 0x0
test_166_ajit_res_2: .word 0x0
test_166_Cmodel_res_1: .word 0x0
test_166_Cmodel_res_2: .word 0x0

test_167_inp_1_1: .word 0x79c79
test_167_inp_1_2: .word 0x452210a5
test_167_inp_2_1: .word 0x553f1fc5
test_167_inp_2_2: .word 0x6b0ddc4
test_167_ajit_res_1: .word 0x0
test_167_ajit_res_2: .word 0x0
test_167_Cmodel_res_1: .word 0x0
test_167_Cmodel_res_2: .word 0x0

test_168_inp_1_1: .word 0x800680b2
test_168_inp_1_2: .word 0x9c796a25
test_168_inp_2_1: .word 0x4ad82624
test_168_inp_2_2: .word 0xa93db1b1
test_168_ajit_res_1: .word 0x80000000
test_168_ajit_res_2: .word 0x0
test_168_Cmodel_res_1: .word 0x0
test_168_Cmodel_res_2: .word 0x0

test_169_inp_1_1: .word 0x8003956d
test_169_inp_1_2: .word 0xbeb4411f
test_169_inp_2_1: .word 0xdbbcbf0b
test_169_inp_2_2: .word 0x5c408e5d
test_169_ajit_res_1: .word 0x0
test_169_ajit_res_2: .word 0x0
test_169_Cmodel_res_1: .word 0x0
test_169_Cmodel_res_2: .word 0x0

test_170_inp_1_1: .word 0x43495
test_170_inp_1_2: .word 0x9c5e74a5
test_170_inp_2_1: .word 0xf32bd6ce
test_170_inp_2_2: .word 0xec77410c
test_170_ajit_res_1: .word 0x80000000
test_170_ajit_res_2: .word 0x0
test_170_Cmodel_res_1: .word 0x0
test_170_Cmodel_res_2: .word 0x0

test_171_inp_1_1: .word 0x1d93c
test_171_inp_1_2: .word 0xc0979442
test_171_inp_2_1: .word 0x6543515b
test_171_inp_2_2: .word 0xb9afebea
test_171_ajit_res_1: .word 0x0
test_171_ajit_res_2: .word 0x0
test_171_Cmodel_res_1: .word 0x0
test_171_Cmodel_res_2: .word 0x0

test_172_inp_1_1: .word 0x8003f01f
test_172_inp_1_2: .word 0x557e76f1
test_172_inp_2_1: .word 0xf44a6fab
test_172_inp_2_2: .word 0xd62f165c
test_172_ajit_res_1: .word 0x0
test_172_ajit_res_2: .word 0x0
test_172_Cmodel_res_1: .word 0x0
test_172_Cmodel_res_2: .word 0x0

test_173_inp_1_1: .word 0x80072dff
test_173_inp_1_2: .word 0x2e5b660b
test_173_inp_2_1: .word 0x7af2cd9a
test_173_inp_2_2: .word 0x4e113207
test_173_ajit_res_1: .word 0x80000000
test_173_ajit_res_2: .word 0x0
test_173_Cmodel_res_1: .word 0x0
test_173_Cmodel_res_2: .word 0x0

test_174_inp_1_1: .word 0x76dd1
test_174_inp_1_2: .word 0xbd9998fd
test_174_inp_2_1: .word 0x765cf7e0
test_174_inp_2_2: .word 0x2283348c
test_174_ajit_res_1: .word 0x0
test_174_ajit_res_2: .word 0x0
test_174_Cmodel_res_1: .word 0x0
test_174_Cmodel_res_2: .word 0x0

test_175_inp_1_1: .word 0x246e7
test_175_inp_1_2: .word 0xebf63fa4
test_175_inp_2_1: .word 0x70691a5b
test_175_inp_2_2: .word 0x6becbadb
test_175_ajit_res_1: .word 0x0
test_175_ajit_res_2: .word 0x0
test_175_Cmodel_res_1: .word 0x0
test_175_Cmodel_res_2: .word 0x0

test_176_inp_1_1: .word 0x8005fb77
test_176_inp_1_2: .word 0xb1ddf160
test_176_inp_2_1: .word 0xe8bb748a
test_176_inp_2_2: .word 0xb2ea1282
test_176_ajit_res_1: .word 0x0
test_176_ajit_res_2: .word 0x0
test_176_Cmodel_res_1: .word 0x0
test_176_Cmodel_res_2: .word 0x0

test_177_inp_1_1: .word 0x5c71a
test_177_inp_1_2: .word 0x98232529
test_177_inp_2_1: .word 0xe5c71bc8
test_177_inp_2_2: .word 0xd3390923
test_177_ajit_res_1: .word 0x80000000
test_177_ajit_res_2: .word 0x0
test_177_Cmodel_res_1: .word 0x0
test_177_Cmodel_res_2: .word 0x0

test_178_inp_1_1: .word 0x80051198
test_178_inp_1_2: .word 0x2889b916
test_178_inp_2_1: .word 0x62218388
test_178_inp_2_2: .word 0x525c2fe4
test_178_ajit_res_1: .word 0x80000000
test_178_ajit_res_2: .word 0x0
test_178_Cmodel_res_1: .word 0x0
test_178_Cmodel_res_2: .word 0x0

test_179_inp_1_1: .word 0x738a3
test_179_inp_1_2: .word 0x56afdce4
test_179_inp_2_1: .word 0xfa239400
test_179_inp_2_2: .word 0x34d33a5d
test_179_ajit_res_1: .word 0x80000000
test_179_ajit_res_2: .word 0x0
test_179_Cmodel_res_1: .word 0x0
test_179_Cmodel_res_2: .word 0x0

test_180_inp_1_1: .word 0xce23
test_180_inp_1_2: .word 0x1bc2a912
test_180_inp_2_1: .word 0x5e6bd4fb
test_180_inp_2_2: .word 0xa9fd28c0
test_180_ajit_res_1: .word 0x0
test_180_ajit_res_2: .word 0x0
test_180_Cmodel_res_1: .word 0x0
test_180_Cmodel_res_2: .word 0x0

test_181_inp_1_1: .word 0x800e8c5d
test_181_inp_1_2: .word 0x7ff725d4
test_181_inp_2_1: .word 0xba2ff112
test_181_inp_2_2: .word 0xa1453e9f
test_181_ajit_res_1: .word 0x5cd2653
test_181_ajit_res_2: .word 0xfed6969c
test_181_Cmodel_res_1: .word 0x0
test_181_Cmodel_res_2: .word 0x0

test_182_inp_1_1: .word 0x80041652
test_182_inp_1_2: .word 0x5ae6c444
test_182_inp_2_1: .word 0x367c9f61
test_182_inp_2_2: .word 0xaef298cc
test_182_ajit_res_1: .word 0x89624724
test_182_ajit_res_2: .word 0xb8a59430
test_182_Cmodel_res_1: .word 0x0
test_182_Cmodel_res_2: .word 0x0

test_183_inp_1_1: .word 0x21e0c
test_183_inp_1_2: .word 0x8178e311
test_183_inp_2_1: .word 0x4019bd7e
test_183_inp_2_2: .word 0x370ef697
test_183_ajit_res_1: .word 0x543b
test_183_ajit_res_2: .word 0xda2b73c3
test_183_Cmodel_res_1: .word 0x0
test_183_Cmodel_res_2: .word 0x0

test_184_inp_1_1: .word 0x2182f
test_184_inp_1_2: .word 0xa19fb767
test_184_inp_2_1: .word 0x47effc7f
test_184_inp_2_2: .word 0xc4fb1c9
test_184_ajit_res_1: .word 0x0
test_184_ajit_res_2: .word 0x0
test_184_Cmodel_res_1: .word 0x0
test_184_Cmodel_res_2: .word 0x0

test_185_inp_1_1: .word 0x8000278c
test_185_inp_1_2: .word 0x72aeaa93
test_185_inp_2_1: .word 0x5da6c3ec
test_185_inp_2_2: .word 0x72bf3306
test_185_ajit_res_1: .word 0x80000000
test_185_ajit_res_2: .word 0x0
test_185_Cmodel_res_1: .word 0x0
test_185_Cmodel_res_2: .word 0x0

test_186_inp_1_1: .word 0x8007feeb
test_186_inp_1_2: .word 0x81d38ed5
test_186_inp_2_1: .word 0x65f7bc1e
test_186_inp_2_2: .word 0x2af93c88
test_186_ajit_res_1: .word 0x80000000
test_186_ajit_res_2: .word 0x0
test_186_Cmodel_res_1: .word 0x0
test_186_Cmodel_res_2: .word 0x0

test_187_inp_1_1: .word 0x8000783e
test_187_inp_1_2: .word 0xe148d168
test_187_inp_2_1: .word 0xe7988279
test_187_inp_2_2: .word 0xe1071aca
test_187_ajit_res_1: .word 0x0
test_187_ajit_res_2: .word 0x0
test_187_Cmodel_res_1: .word 0x0
test_187_Cmodel_res_2: .word 0x0

test_188_inp_1_1: .word 0x8006c60e
test_188_inp_1_2: .word 0xd663cc9e
test_188_inp_2_1: .word 0xc24ea7a4
test_188_inp_2_2: .word 0xf3a1ec87
test_188_ajit_res_1: .word 0x0
test_188_ajit_res_2: .word 0x1c48
test_188_Cmodel_res_1: .word 0x0
test_188_Cmodel_res_2: .word 0x0

test_189_inp_1_1: .word 0x8004291a
test_189_inp_1_2: .word 0x9ffa2bc3
test_189_inp_2_1: .word 0xe0a7767e
test_189_inp_2_2: .word 0x8f9f4f54
test_189_ajit_res_1: .word 0x0
test_189_ajit_res_2: .word 0x0
test_189_Cmodel_res_1: .word 0x0
test_189_Cmodel_res_2: .word 0x0

test_190_inp_1_1: .word 0x800331db
test_190_inp_1_2: .word 0xd03cb39b
test_190_inp_2_1: .word 0xffbfc6cd
test_190_inp_2_2: .word 0x66bb4c3c
test_190_ajit_res_1: .word 0x0
test_190_ajit_res_2: .word 0x0
test_190_Cmodel_res_1: .word 0x0
test_190_Cmodel_res_2: .word 0x0

test_191_inp_1_1: .word 0x180a7
test_191_inp_1_2: .word 0x5ae47a60
test_191_inp_2_1: .word 0x47f6652a
test_191_inp_2_2: .word 0x772b2a94
test_191_ajit_res_1: .word 0x0
test_191_ajit_res_2: .word 0x0
test_191_Cmodel_res_1: .word 0x0
test_191_Cmodel_res_2: .word 0x0

test_192_inp_1_1: .word 0x80017db0
test_192_inp_1_2: .word 0xb384d56a
test_192_inp_2_1: .word 0x603eb7e0
test_192_inp_2_2: .word 0x25fbc640
test_192_ajit_res_1: .word 0x80000000
test_192_ajit_res_2: .word 0x0
test_192_Cmodel_res_1: .word 0x0
test_192_Cmodel_res_2: .word 0x0

test_193_inp_1_1: .word 0x8007dc62
test_193_inp_1_2: .word 0x261e718f
test_193_inp_2_1: .word 0xcd3eb86f
test_193_inp_2_2: .word 0x36a7ceac
test_193_ajit_res_1: .word 0x0
test_193_ajit_res_2: .word 0x0
test_193_Cmodel_res_1: .word 0x0
test_193_Cmodel_res_2: .word 0x0

test_194_inp_1_1: .word 0x247ca
test_194_inp_1_2: .word 0xe8cca18b
test_194_inp_2_1: .word 0xcbd2d8ee
test_194_inp_2_2: .word 0xae143a08
test_194_ajit_res_1: .word 0x80000000
test_194_ajit_res_2: .word 0x0
test_194_Cmodel_res_1: .word 0x0
test_194_Cmodel_res_2: .word 0x0

test_195_inp_1_1: .word 0x80074cdf
test_195_inp_1_2: .word 0x4e0ff05c
test_195_inp_2_1: .word 0xca60e69c
test_195_inp_2_2: .word 0x7c1c78bc
test_195_ajit_res_1: .word 0x0
test_195_ajit_res_2: .word 0x0
test_195_Cmodel_res_1: .word 0x0
test_195_Cmodel_res_2: .word 0x0

test_196_inp_1_1: .word 0x48eca
test_196_inp_1_2: .word 0x63b0261c
test_196_inp_2_1: .word 0x526d4643
test_196_inp_2_2: .word 0x9d1d4150
test_196_ajit_res_1: .word 0x0
test_196_ajit_res_2: .word 0x0
test_196_Cmodel_res_1: .word 0x0
test_196_Cmodel_res_2: .word 0x0

test_197_inp_1_1: .word 0xc714
test_197_inp_1_2: .word 0x8007690d
test_197_inp_2_1: .word 0x4e95b843
test_197_inp_2_2: .word 0x4cc2849f
test_197_ajit_res_1: .word 0x0
test_197_ajit_res_2: .word 0x0
test_197_Cmodel_res_1: .word 0x0
test_197_Cmodel_res_2: .word 0x0

test_198_inp_1_1: .word 0x8005706a
test_198_inp_1_2: .word 0x42a766a
test_198_inp_2_1: .word 0xe6abe86b
test_198_inp_2_2: .word 0x647ef806
test_198_ajit_res_1: .word 0x0
test_198_ajit_res_2: .word 0x0
test_198_Cmodel_res_1: .word 0x0
test_198_Cmodel_res_2: .word 0x0

test_199_inp_1_1: .word 0x80071e98
test_199_inp_1_2: .word 0x8252d07e
test_199_inp_2_1: .word 0xf59a1d14
test_199_inp_2_2: .word 0x2951aa5e
test_199_ajit_res_1: .word 0x0
test_199_ajit_res_2: .word 0x0
test_199_Cmodel_res_1: .word 0x0
test_199_Cmodel_res_2: .word 0x0

test_200_inp_1_1: .word 0x22d9c
test_200_inp_1_2: .word 0x6fa4d0b7
test_200_inp_2_1: .word 0x3dbeb9a
test_200_inp_2_2: .word 0x8df554d6
test_200_ajit_res_1: .word 0x3bf3f8b4
test_200_ajit_res_2: .word 0xd986cf47
test_200_Cmodel_res_1: .word 0x0
test_200_Cmodel_res_2: .word 0x0

test_201_inp_1_1: .word 0x800c1e28
test_201_inp_1_2: .word 0xb945fb9b
test_201_inp_2_1: .word 0xa7eed767
test_201_inp_2_2: .word 0xeb62f6ac
test_201_ajit_res_1: .word 0x18092562
test_201_ajit_res_2: .word 0xc5fb3c08
test_201_Cmodel_res_1: .word 0x0
test_201_Cmodel_res_2: .word 0x0

test_202_inp_1_1: .word 0x8005f6e2
test_202_inp_1_2: .word 0xdbbe7508
test_202_inp_2_1: .word 0xa70180a4
test_202_inp_2_2: .word 0xa8f14be2
test_202_ajit_res_1: .word 0x18e5cf3d
test_202_ajit_res_2: .word 0x3e9e4ed9
test_202_Cmodel_res_1: .word 0x0
test_202_Cmodel_res_2: .word 0x0

test_203_inp_1_1: .word 0x377e5
test_203_inp_1_2: .word 0x6d38df76
test_203_inp_2_1: .word 0x6f4ae181
test_203_inp_2_2: .word 0x94abb348
test_203_ajit_res_1: .word 0x0
test_203_ajit_res_2: .word 0x0
test_203_Cmodel_res_1: .word 0x0
test_203_Cmodel_res_2: .word 0x0

test_204_inp_1_1: .word 0x80002424
test_204_inp_1_2: .word 0xf999cbc2
test_204_inp_2_1: .word 0xd9ffeca1
test_204_inp_2_2: .word 0x7eca48d5
test_204_ajit_res_1: .word 0x0
test_204_ajit_res_2: .word 0x0
test_204_Cmodel_res_1: .word 0x0
test_204_Cmodel_res_2: .word 0x0

test_205_inp_1_1: .word 0x800506ac
test_205_inp_1_2: .word 0x6cec44ae
test_205_inp_2_1: .word 0x70460545
test_205_inp_2_2: .word 0x68ff77a7
test_205_ajit_res_1: .word 0x80000000
test_205_ajit_res_2: .word 0x0
test_205_Cmodel_res_1: .word 0x0
test_205_Cmodel_res_2: .word 0x0

test_206_inp_1_1: .word 0x6a50c
test_206_inp_1_2: .word 0x8cef5e54
test_206_inp_2_1: .word 0xc95d112f
test_206_inp_2_2: .word 0x6e3b95e8
test_206_ajit_res_1: .word 0x80000000
test_206_ajit_res_2: .word 0x0
test_206_Cmodel_res_1: .word 0x0
test_206_Cmodel_res_2: .word 0x0

test_207_inp_1_1: .word 0x7305a
test_207_inp_1_2: .word 0x631982ef
test_207_inp_2_1: .word 0x5477a704
test_207_inp_2_2: .word 0xf5b6ea2a
test_207_ajit_res_1: .word 0x0
test_207_ajit_res_2: .word 0x0
test_207_Cmodel_res_1: .word 0x0
test_207_Cmodel_res_2: .word 0x0

test_208_inp_1_1: .word 0x63bba
test_208_inp_1_2: .word 0x5f066e64
test_208_inp_2_1: .word 0x44b43d64
test_208_inp_2_2: .word 0xd09f7bb8
test_208_ajit_res_1: .word 0x0
test_208_ajit_res_2: .word 0x0
test_208_Cmodel_res_1: .word 0x0
test_208_Cmodel_res_2: .word 0x0

test_209_inp_1_1: .word 0x58634
test_209_inp_1_2: .word 0x57fb9891
test_209_inp_2_1: .word 0xd4b64f92
test_209_inp_2_2: .word 0x65606be0
test_209_ajit_res_1: .word 0x80000000
test_209_ajit_res_2: .word 0x0
test_209_Cmodel_res_1: .word 0x0
test_209_Cmodel_res_2: .word 0x0

test_210_inp_1_1: .word 0x800e23f7
test_210_inp_1_2: .word 0x65973a51
test_210_inp_2_1: .word 0x4259d6a
test_210_inp_2_2: .word 0x4912a065
test_210_ajit_res_1: .word 0xbbd4ef37
test_210_ajit_res_2: .word 0x2eb2ee48
test_210_Cmodel_res_1: .word 0x0
test_210_Cmodel_res_2: .word 0x0

test_211_inp_1_1: .word 0x569b
test_211_inp_1_2: .word 0xaabc595d
test_211_inp_2_1: .word 0xebb59622
test_211_inp_2_2: .word 0x148ad6af
test_211_ajit_res_1: .word 0x80000000
test_211_ajit_res_2: .word 0x0
test_211_Cmodel_res_1: .word 0x0
test_211_Cmodel_res_2: .word 0x0

test_212_inp_1_1: .word 0x800fcfa8
test_212_inp_1_2: .word 0x4d697753
test_212_inp_2_1: .word 0x947e0101
test_212_inp_2_2: .word 0x4bbe117d
test_212_ajit_res_1: .word 0x2b80dcef
test_212_ajit_res_2: .word 0xb23e5220
test_212_Cmodel_res_1: .word 0x0
test_212_Cmodel_res_2: .word 0x0

test_213_inp_1_1: .word 0xf8b1
test_213_inp_1_2: .word 0xbdaa17f5
test_213_inp_2_1: .word 0xee24afce
test_213_inp_2_2: .word 0xcb9e1e9a
test_213_ajit_res_1: .word 0x80000000
test_213_ajit_res_2: .word 0x0
test_213_Cmodel_res_1: .word 0x0
test_213_Cmodel_res_2: .word 0x0

test_214_inp_1_1: .word 0x7da22
test_214_inp_1_2: .word 0xc54c0a6f
test_214_inp_2_1: .word 0xe4d2009d
test_214_inp_2_2: .word 0x81ffe9bb
test_214_ajit_res_1: .word 0x80000000
test_214_ajit_res_2: .word 0x0
test_214_Cmodel_res_1: .word 0x0
test_214_Cmodel_res_2: .word 0x0

test_215_inp_1_1: .word 0x80028665
test_215_inp_1_2: .word 0x30e913ee
test_215_inp_2_1: .word 0xf661f95b
test_215_inp_2_2: .word 0x1623fa49
test_215_ajit_res_1: .word 0x0
test_215_ajit_res_2: .word 0x0
test_215_Cmodel_res_1: .word 0x0
test_215_Cmodel_res_2: .word 0x0

test_216_inp_1_1: .word 0x5da74
test_216_inp_1_2: .word 0x1cb60407
test_216_inp_2_1: .word 0x469a7c4c
test_216_inp_2_2: .word 0xa1089cf
test_216_ajit_res_1: .word 0x0
test_216_ajit_res_2: .word 0x0
test_216_Cmodel_res_1: .word 0x0
test_216_Cmodel_res_2: .word 0x0

test_217_inp_1_1: .word 0x7ae5
test_217_inp_1_2: .word 0x631997d0
test_217_inp_2_1: .word 0x59e515ab
test_217_inp_2_2: .word 0xfcbe50ff
test_217_ajit_res_1: .word 0x0
test_217_ajit_res_2: .word 0x0
test_217_Cmodel_res_1: .word 0x0
test_217_Cmodel_res_2: .word 0x0

test_218_inp_1_1: .word 0x50353
test_218_inp_1_2: .word 0x431e35f9
test_218_inp_2_1: .word 0xcb21fcb2
test_218_inp_2_2: .word 0x4b0e57d2
test_218_ajit_res_1: .word 0x80000000
test_218_ajit_res_2: .word 0x0
test_218_Cmodel_res_1: .word 0x0
test_218_Cmodel_res_2: .word 0x0

test_219_inp_1_1: .word 0x8007bada
test_219_inp_1_2: .word 0xb70fa086
test_219_inp_2_1: .word 0x2bab5ed1
test_219_inp_2_2: .word 0x89175e47
test_219_ajit_res_1: .word 0x94421324
test_219_ajit_res_2: .word 0x8e8c901e
test_219_Cmodel_res_1: .word 0x0
test_219_Cmodel_res_2: .word 0x0

test_220_inp_1_1: .word 0x2da71
test_220_inp_1_2: .word 0x43b5f7f9
test_220_inp_2_1: .word 0x43c34e83
test_220_inp_2_2: .word 0x761c4256
test_220_ajit_res_1: .word 0x0
test_220_ajit_res_2: .word 0x0
test_220_Cmodel_res_1: .word 0x0
test_220_Cmodel_res_2: .word 0x0

test_221_inp_1_1: .word 0x800529df
test_221_inp_1_2: .word 0xd2abd390
test_221_inp_2_1: .word 0x4494553d
test_221_inp_2_2: .word 0x7de66037
test_221_ajit_res_1: .word 0x80000000
test_221_ajit_res_2: .word 0x0
test_221_Cmodel_res_1: .word 0x0
test_221_Cmodel_res_2: .word 0x0

test_222_inp_1_1: .word 0x800fb3f5
test_222_inp_1_2: .word 0x79255e9
test_222_inp_2_1: .word 0x56364b
test_222_inp_2_2: .word 0x15b12b02
test_222_ajit_res_1: .word 0xbfa69f61
test_222_ajit_res_2: .word 0x71d1826f
test_222_Cmodel_res_1: .word 0x0
test_222_Cmodel_res_2: .word 0x0

test_223_inp_1_1: .word 0x8002953c
test_223_inp_1_2: .word 0x59aa681c
test_223_inp_2_1: .word 0xa7339934
test_223_inp_2_2: .word 0x7118bbcc
test_223_ajit_res_1: .word 0x18a0de9d
test_223_ajit_res_2: .word 0x459e661e
test_223_Cmodel_res_1: .word 0x0
test_223_Cmodel_res_2: .word 0x0

test_224_inp_1_1: .word 0x3500d
test_224_inp_1_2: .word 0xd2ce461a
test_224_inp_2_1: .word 0xfd56abf2
test_224_inp_2_2: .word 0x8a151c16
test_224_ajit_res_1: .word 0x80000000
test_224_ajit_res_2: .word 0x0
test_224_Cmodel_res_1: .word 0x0
test_224_Cmodel_res_2: .word 0x0

test_225_inp_1_1: .word 0x80069dbe
test_225_inp_1_2: .word 0xb8523815
test_225_inp_2_1: .word 0xe8f2e57d
test_225_inp_2_2: .word 0xe4e43925
test_225_ajit_res_1: .word 0x0
test_225_ajit_res_2: .word 0x0
test_225_Cmodel_res_1: .word 0x0
test_225_Cmodel_res_2: .word 0x0

test_226_inp_1_1: .word 0x2da6d
test_226_inp_1_2: .word 0xb4b3e42a
test_226_inp_2_1: .word 0x78d24d6f
test_226_inp_2_2: .word 0xad62c962
test_226_ajit_res_1: .word 0x0
test_226_ajit_res_2: .word 0x0
test_226_Cmodel_res_1: .word 0x0
test_226_Cmodel_res_2: .word 0x0

test_227_inp_1_1: .word 0x8001ceb6
test_227_inp_1_2: .word 0xbc4b8458
test_227_inp_2_1: .word 0x53c431bf
test_227_inp_2_2: .word 0xb9f90550
test_227_ajit_res_1: .word 0x80000000
test_227_ajit_res_2: .word 0x0
test_227_Cmodel_res_1: .word 0x0
test_227_Cmodel_res_2: .word 0x0

test_228_inp_1_1: .word 0x8002bb57
test_228_inp_1_2: .word 0x7f539e9c
test_228_inp_2_1: .word 0x946b4926
test_228_inp_2_2: .word 0x4bdb1ea1
test_228_ajit_res_1: .word 0x2b69a15b
test_228_ajit_res_2: .word 0x81c569a4
test_228_Cmodel_res_1: .word 0x0
test_228_Cmodel_res_2: .word 0x0

test_229_inp_1_1: .word 0xb63a
test_229_inp_1_2: .word 0xbaa9599d
test_229_inp_2_1: .word 0x846e73de
test_229_inp_2_2: .word 0xd665cc6e
test_229_ajit_res_1: .word 0xbb47efa5
test_229_ajit_res_2: .word 0xc6ea1e40
test_229_Cmodel_res_1: .word 0x0
test_229_Cmodel_res_2: .word 0x0

test_230_inp_1_1: .word 0x1e10f
test_230_inp_1_2: .word 0x3b030cbd
test_230_inp_2_1: .word 0x56e32e20
test_230_inp_2_2: .word 0x8fe985e4
test_230_ajit_res_1: .word 0x0
test_230_ajit_res_2: .word 0x0
test_230_Cmodel_res_1: .word 0x0
test_230_Cmodel_res_2: .word 0x0

test_231_inp_1_1: .word 0x85686
test_231_inp_1_2: .word 0x47345f70
test_231_inp_2_1: .word 0x218e15db
test_231_inp_2_2: .word 0xdadfebce
test_231_ajit_res_1: .word 0x1e61bcba
test_231_ajit_res_2: .word 0x7f07b341
test_231_Cmodel_res_1: .word 0x0
test_231_Cmodel_res_2: .word 0x0

test_232_inp_1_1: .word 0x8006b67b
test_232_inp_1_2: .word 0x1150a2d0
test_232_inp_2_1: .word 0x42c1c9f8
test_232_inp_2_2: .word 0xc82ab795
test_232_ajit_res_1: .word 0x80000000
test_232_ajit_res_2: .word 0x30
test_232_Cmodel_res_1: .word 0x0
test_232_Cmodel_res_2: .word 0x0

test_233_inp_1_1: .word 0x80071c76
test_233_inp_1_2: .word 0x6af79593
test_233_inp_2_1: .word 0x6a239060
test_233_inp_2_2: .word 0x35857e78
test_233_ajit_res_1: .word 0x80000000
test_233_ajit_res_2: .word 0x0
test_233_Cmodel_res_1: .word 0x0
test_233_Cmodel_res_2: .word 0x0

test_234_inp_1_1: .word 0x800504fe
test_234_inp_1_2: .word 0x74a632e4
test_234_inp_2_1: .word 0xcc9110c0
test_234_inp_2_2: .word 0xe89d4781
test_234_ajit_res_1: .word 0x0
test_234_ajit_res_2: .word 0x0
test_234_Cmodel_res_1: .word 0x0
test_234_Cmodel_res_2: .word 0x0

test_235_inp_1_1: .word 0x56470
test_235_inp_1_2: .word 0xb5a930fc
test_235_inp_2_1: .word 0x77b65503
test_235_inp_2_2: .word 0xa3abdd9d
test_235_ajit_res_1: .word 0x0
test_235_ajit_res_2: .word 0x0
test_235_Cmodel_res_1: .word 0x0
test_235_Cmodel_res_2: .word 0x0

test_236_inp_1_1: .word 0x80030f65
test_236_inp_1_2: .word 0xe7d1c7c
test_236_inp_2_1: .word 0x6d5f00a5
test_236_inp_2_2: .word 0xa217944
test_236_ajit_res_1: .word 0x80000000
test_236_ajit_res_2: .word 0x0
test_236_Cmodel_res_1: .word 0x0
test_236_Cmodel_res_2: .word 0x0

test_237_inp_1_1: .word 0x80046313
test_237_inp_1_2: .word 0xbf21d8e3
test_237_inp_2_1: .word 0xfe94aeb5
test_237_inp_2_2: .word 0xec11c392
test_237_ajit_res_1: .word 0x0
test_237_ajit_res_2: .word 0x0
test_237_Cmodel_res_1: .word 0x0
test_237_Cmodel_res_2: .word 0x0

test_238_inp_1_1: .word 0x8007526d
test_238_inp_1_2: .word 0xcedfbcf5
test_238_inp_2_1: .word 0x6d0b9406
test_238_inp_2_2: .word 0x68ab9ecc
test_238_ajit_res_1: .word 0x80000000
test_238_ajit_res_2: .word 0x0
test_238_Cmodel_res_1: .word 0x0
test_238_Cmodel_res_2: .word 0x0

test_239_inp_1_1: .word 0x15b0e
test_239_inp_1_2: .word 0xa52d2f68
test_239_inp_2_1: .word 0xca676337
test_239_inp_2_2: .word 0x8adaf36
test_239_ajit_res_1: .word 0x80000000
test_239_ajit_res_2: .word 0x0
test_239_Cmodel_res_1: .word 0x0
test_239_Cmodel_res_2: .word 0x0

test_240_inp_1_1: .word 0xe0cf3
test_240_inp_1_2: .word 0xc683401b
test_240_inp_2_1: .word 0x40960771
test_240_inp_2_2: .word 0xa96b205b
test_240_ajit_res_1: .word 0x28d
test_240_ajit_res_2: .word 0x20c8672b
test_240_Cmodel_res_1: .word 0x0
test_240_Cmodel_res_2: .word 0x0

test_241_inp_1_1: .word 0x800d3f54
test_241_inp_1_2: .word 0xb2a94f1a
test_241_inp_2_1: .word 0x273616aa
test_241_inp_2_2: .word 0xae749b04
test_241_ajit_res_1: .word 0x98c33112
test_241_ajit_res_2: .word 0x52896842
test_241_Cmodel_res_1: .word 0x0
test_241_Cmodel_res_2: .word 0x0

test_242_inp_1_1: .word 0x80068443
test_242_inp_1_2: .word 0xc83aa625
test_242_inp_2_1: .word 0xe9b2eb31
test_242_inp_2_2: .word 0xe195fa29
test_242_ajit_res_1: .word 0x0
test_242_ajit_res_2: .word 0x0
test_242_Cmodel_res_1: .word 0x0
test_242_Cmodel_res_2: .word 0x0

test_243_inp_1_1: .word 0x5df64
test_243_inp_1_2: .word 0xfed91188
test_243_inp_2_1: .word 0x55c5b49d
test_243_inp_2_2: .word 0x2007c1ab
test_243_ajit_res_1: .word 0x0
test_243_ajit_res_2: .word 0x0
test_243_Cmodel_res_1: .word 0x0
test_243_Cmodel_res_2: .word 0x0

test_244_inp_1_1: .word 0x80049769
test_244_inp_1_2: .word 0x415c5bd
test_244_inp_2_1: .word 0x5b74d332
test_244_inp_2_2: .word 0x29372176
test_244_ajit_res_1: .word 0x80000000
test_244_ajit_res_2: .word 0x0
test_244_Cmodel_res_1: .word 0x0
test_244_Cmodel_res_2: .word 0x0

test_245_inp_1_1: .word 0x8003610d
test_245_inp_1_2: .word 0x99f167cf
test_245_inp_2_1: .word 0xffaf3352
test_245_inp_2_2: .word 0xffe296c0
test_245_ajit_res_1: .word 0x0
test_245_ajit_res_2: .word 0x0
test_245_Cmodel_res_1: .word 0x0
test_245_Cmodel_res_2: .word 0x0

test_246_inp_1_1: .word 0x78de0
test_246_inp_1_2: .word 0x73c4cd6a
test_246_inp_2_1: .word 0xd25003e5
test_246_inp_2_2: .word 0x675d5e70
test_246_ajit_res_1: .word 0x80000000
test_246_ajit_res_2: .word 0x0
test_246_Cmodel_res_1: .word 0x0
test_246_Cmodel_res_2: .word 0x0

test_247_inp_1_1: .word 0x6f8df
test_247_inp_1_2: .word 0xfcf2ac8d
test_247_inp_2_1: .word 0x5aa1a92c
test_247_inp_2_2: .word 0xbf19ca94
test_247_ajit_res_1: .word 0x0
test_247_ajit_res_2: .word 0x0
test_247_Cmodel_res_1: .word 0x0
test_247_Cmodel_res_2: .word 0x0

test_248_inp_1_1: .word 0x80079fb3
test_248_inp_1_2: .word 0x8c4345da
test_248_inp_2_1: .word 0x6a1cab84
test_248_inp_2_2: .word 0x7893f5d1
test_248_ajit_res_1: .word 0x80000000
test_248_ajit_res_2: .word 0x0
test_248_Cmodel_res_1: .word 0x0
test_248_Cmodel_res_2: .word 0x0

test_249_inp_1_1: .word 0x74473
test_249_inp_1_2: .word 0x7ddefbf6
test_249_inp_2_1: .word 0x69303e55
test_249_inp_2_2: .word 0xc4e77b81
test_249_ajit_res_1: .word 0x0
test_249_ajit_res_2: .word 0x0
test_249_Cmodel_res_1: .word 0x0
test_249_Cmodel_res_2: .word 0x0

test_250_inp_1_1: .word 0x800eba44
test_250_inp_1_2: .word 0xfe08a05c
test_250_inp_2_1: .word 0x838b8a60
test_250_inp_2_2: .word 0xadef261c
test_250_ajit_res_1: .word 0x3c711cc3
test_250_ajit_res_2: .word 0xd7e204c1
test_250_Cmodel_res_1: .word 0x0
test_250_Cmodel_res_2: .word 0x0

test_251_inp_1_1: .word 0x80001b52
test_251_inp_1_2: .word 0xcea25dcf
test_251_inp_2_1: .word 0x816e620
test_251_inp_2_2: .word 0x9d798ab4
test_251_ajit_res_1: .word 0xb773176d
test_251_ajit_res_2: .word 0xc4286cf2
test_251_Cmodel_res_1: .word 0x0
test_251_Cmodel_res_2: .word 0x0

test_252_inp_1_1: .word 0x8005b7c6
test_252_inp_1_2: .word 0x563bb27a
test_252_inp_2_1: .word 0x49566393
test_252_inp_2_2: .word 0x15081b9e
test_252_ajit_res_1: .word 0x80000000
test_252_ajit_res_2: .word 0x0
test_252_Cmodel_res_1: .word 0x0
test_252_Cmodel_res_2: .word 0x0

test_253_inp_1_1: .word 0x8004f731
test_253_inp_1_2: .word 0x2afd0c31
test_253_inp_2_1: .word 0xd7e77b11
test_253_inp_2_2: .word 0xe2bfda69
test_253_ajit_res_1: .word 0x0
test_253_ajit_res_2: .word 0x0
test_253_Cmodel_res_1: .word 0x0
test_253_Cmodel_res_2: .word 0x0

test_254_inp_1_1: .word 0x8004ae46
test_254_inp_1_2: .word 0xbf5eaee2
test_254_inp_2_1: .word 0xceb921f1
test_254_inp_2_2: .word 0xe629eb3f
test_254_ajit_res_1: .word 0x0
test_254_ajit_res_2: .word 0x0
test_254_Cmodel_res_1: .word 0x0
test_254_Cmodel_res_2: .word 0x0

test_255_inp_1_1: .word 0x793c6
test_255_inp_1_2: .word 0x4b5d2847
test_255_inp_2_1: .word 0x906cef0a
test_255_inp_2_2: .word 0x722763d7
test_255_ajit_res_1: .word 0xaf80c2ae
test_255_ajit_res_2: .word 0xf1b2997e
test_255_Cmodel_res_1: .word 0x0
test_255_Cmodel_res_2: .word 0x0

test_256_inp_1_1: .word 0xdae92
test_256_inp_1_2: .word 0x64328ea1
test_256_inp_2_1: .word 0x989b26ca
test_256_inp_2_2: .word 0xda7563fc
test_256_ajit_res_1: .word 0xa7602007
test_256_ajit_res_2: .word 0x4646ea5e
test_256_Cmodel_res_1: .word 0x0
test_256_Cmodel_res_2: .word 0x0

test_257_inp_1_1: .word 0x800378f8
test_257_inp_1_2: .word 0x915c7c0b
test_257_inp_2_1: .word 0x6e46a3c7
test_257_inp_2_2: .word 0xf486a633
test_257_ajit_res_1: .word 0x80000000
test_257_ajit_res_2: .word 0x0
test_257_Cmodel_res_1: .word 0x0
test_257_Cmodel_res_2: .word 0x0

test_258_inp_1_1: .word 0x5ccc
test_258_inp_1_2: .word 0x25fab4f0
test_258_inp_2_1: .word 0xbc700c7
test_258_inp_2_2: .word 0x6eb07d99
test_258_ajit_res_1: .word 0x33e022f5
test_258_ajit_res_2: .word 0x1ec9e4a2
test_258_Cmodel_res_1: .word 0x0
test_258_Cmodel_res_2: .word 0x0

test_259_inp_1_1: .word 0x80020d30
test_259_inp_1_2: .word 0x5e0bb31f
test_259_inp_2_1: .word 0xefda1a8d
test_259_inp_2_2: .word 0xcd4a83b9
test_259_ajit_res_1: .word 0x0
test_259_ajit_res_2: .word 0x0
test_259_Cmodel_res_1: .word 0x0
test_259_Cmodel_res_2: .word 0x0

test_260_inp_1_1: .word 0x80050062
test_260_inp_1_2: .word 0xf61ec958
test_260_inp_2_1: .word 0x6a74d6cb
test_260_inp_2_2: .word 0x28ffa2ca
test_260_ajit_res_1: .word 0x80000000
test_260_ajit_res_2: .word 0x0
test_260_Cmodel_res_1: .word 0x0
test_260_Cmodel_res_2: .word 0x0

test_261_inp_1_1: .word 0x5c74
test_261_inp_1_2: .word 0x80cfe46f
test_261_inp_2_1: .word 0x747afc80
test_261_inp_2_2: .word 0xa6748067
test_261_ajit_res_1: .word 0x0
test_261_ajit_res_2: .word 0x0
test_261_Cmodel_res_1: .word 0x0
test_261_Cmodel_res_2: .word 0x0

test_262_inp_1_1: .word 0x80073414
test_262_inp_1_2: .word 0xb870ec46
test_262_inp_2_1: .word 0x404c293b
test_262_inp_2_2: .word 0x288fdc1e
test_262_ajit_res_1: .word 0x800020bd
test_262_ajit_res_2: .word 0xdef2e595
test_262_Cmodel_res_1: .word 0x0
test_262_Cmodel_res_2: .word 0x0

test_263_inp_1_1: .word 0x8001ccdb
test_263_inp_1_2: .word 0xfee02d9c
test_263_inp_2_1: .word 0xc110cf2b
test_263_inp_2_2: .word 0xe12b0ac7
test_263_ajit_res_1: .word 0x0
test_263_ajit_res_2: .word 0x6daafeb5
test_263_Cmodel_res_1: .word 0x0
test_263_Cmodel_res_2: .word 0x0

test_264_inp_1_1: .word 0x80046330
test_264_inp_1_2: .word 0x6b5f92e2
test_264_inp_2_1: .word 0xe96516e4
test_264_inp_2_2: .word 0x84bfd547
test_264_ajit_res_1: .word 0x0
test_264_ajit_res_2: .word 0x0
test_264_Cmodel_res_1: .word 0x0
test_264_Cmodel_res_2: .word 0x0

test_265_inp_1_1: .word 0x80036ff3
test_265_inp_1_2: .word 0x2b70fbe6
test_265_inp_2_1: .word 0x45b7cc40
test_265_inp_2_2: .word 0x49462391
test_265_ajit_res_1: .word 0x80000000
test_265_ajit_res_2: .word 0x0
test_265_Cmodel_res_1: .word 0x0
test_265_Cmodel_res_2: .word 0x0

test_266_inp_1_1: .word 0x78d81
test_266_inp_1_2: .word 0xee7e4ac1
test_266_inp_2_1: .word 0xd3c349fe
test_266_inp_2_2: .word 0xf7402614
test_266_ajit_res_1: .word 0x80000000
test_266_ajit_res_2: .word 0x0
test_266_Cmodel_res_1: .word 0x0
test_266_Cmodel_res_2: .word 0x0

test_267_inp_1_1: .word 0x5d45c
test_267_inp_1_2: .word 0x69ad9a0b
test_267_inp_2_1: .word 0xf733b769
test_267_inp_2_2: .word 0x4ea723ff
test_267_ajit_res_1: .word 0x80000000
test_267_ajit_res_2: .word 0x0
test_267_Cmodel_res_1: .word 0x0
test_267_Cmodel_res_2: .word 0x0

test_268_inp_1_1: .word 0x80079c88
test_268_inp_1_2: .word 0xae635d20
test_268_inp_2_1: .word 0x3f14bccf
test_268_inp_2_2: .word 0xeb78d39a
test_268_ajit_res_1: .word 0x80d77d8b
test_268_ajit_res_2: .word 0x7406e7d5
test_268_Cmodel_res_1: .word 0x0
test_268_Cmodel_res_2: .word 0x0

test_269_inp_1_1: .word 0x285e5
test_269_inp_1_2: .word 0x4493acc2
test_269_inp_2_1: .word 0x46cd2ffe
test_269_inp_2_2: .word 0x295ffb1b
test_269_ajit_res_1: .word 0x0
test_269_ajit_res_2: .word 0x0
test_269_Cmodel_res_1: .word 0x0
test_269_Cmodel_res_2: .word 0x0

test_270_inp_1_1: .word 0x8002f1b8
test_270_inp_1_2: .word 0x865f13c1
test_270_inp_2_1: .word 0x425bcf6f
test_270_inp_2_2: .word 0x79a37da6
test_270_ajit_res_1: .word 0x80000000
test_270_ajit_res_2: .word 0x6c6
test_270_Cmodel_res_1: .word 0x0
test_270_Cmodel_res_2: .word 0x0

test_271_inp_1_1: .word 0x8005768e
test_271_inp_1_2: .word 0x3c586b8
test_271_inp_2_1: .word 0xe4a54372
test_271_inp_2_2: .word 0x191ea3b5
test_271_ajit_res_1: .word 0x0
test_271_ajit_res_2: .word 0x0
test_271_Cmodel_res_1: .word 0x0
test_271_Cmodel_res_2: .word 0x0

test_272_inp_1_1: .word 0x8004f68a
test_272_inp_1_2: .word 0xba8eefdc
test_272_inp_2_1: .word 0x478029ef
test_272_inp_2_2: .word 0xdbbd8503
test_272_ajit_res_1: .word 0x80000000
test_272_ajit_res_2: .word 0x0
test_272_Cmodel_res_1: .word 0x0
test_272_Cmodel_res_2: .word 0x0

test_273_inp_1_1: .word 0x8003b192
test_273_inp_1_2: .word 0x7b0a4504
test_273_inp_2_1: .word 0xd03bb695
test_273_inp_2_2: .word 0xf4d1908e
test_273_ajit_res_1: .word 0x0
test_273_ajit_res_2: .word 0x0
test_273_Cmodel_res_1: .word 0x0
test_273_Cmodel_res_2: .word 0x0

test_274_inp_1_1: .word 0x80013112
test_274_inp_1_2: .word 0xb218c723
test_274_inp_2_1: .word 0xcc41b2cd
test_274_inp_2_2: .word 0xb5735e6d
test_274_ajit_res_1: .word 0x0
test_274_ajit_res_2: .word 0x0
test_274_Cmodel_res_1: .word 0x0
test_274_Cmodel_res_2: .word 0x0

test_275_inp_1_1: .word 0x8005ecca
test_275_inp_1_2: .word 0x8b162b4e
test_275_inp_2_1: .word 0xe5135915
test_275_inp_2_2: .word 0x37d31498
test_275_ajit_res_1: .word 0x0
test_275_ajit_res_2: .word 0x0
test_275_Cmodel_res_1: .word 0x0
test_275_Cmodel_res_2: .word 0x0

test_276_inp_1_1: .word 0x8006ef7b
test_276_inp_1_2: .word 0x8875fb7f
test_276_inp_2_1: .word 0xdf70f7a1
test_276_inp_2_2: .word 0x83e62f49
test_276_ajit_res_1: .word 0x0
test_276_ajit_res_2: .word 0x0
test_276_Cmodel_res_1: .word 0x0
test_276_Cmodel_res_2: .word 0x0

test_277_inp_1_1: .word 0x80055e83
test_277_inp_1_2: .word 0xe3c4accb
test_277_inp_2_1: .word 0xc4b3e9dc
test_277_inp_2_2: .word 0x6e157752
test_277_ajit_res_1: .word 0x0
test_277_ajit_res_2: .word 0x0
test_277_Cmodel_res_1: .word 0x0
test_277_Cmodel_res_2: .word 0x0

test_278_inp_1_1: .word 0x8007fd2d
test_278_inp_1_2: .word 0x517aed07
test_278_inp_2_1: .word 0x6be2022b
test_278_inp_2_2: .word 0x7af9b91d
test_278_ajit_res_1: .word 0x80000000
test_278_ajit_res_2: .word 0x0
test_278_Cmodel_res_1: .word 0x0
test_278_Cmodel_res_2: .word 0x0

test_279_inp_1_1: .word 0xa36c
test_279_inp_1_2: .word 0x12464987
test_279_inp_2_1: .word 0xc9cffee6
test_279_inp_2_2: .word 0x1b6844d4
test_279_ajit_res_1: .word 0x80000000
test_279_ajit_res_2: .word 0x0
test_279_Cmodel_res_1: .word 0x0
test_279_Cmodel_res_2: .word 0x0

test_280_inp_1_1: .word 0xee802
test_280_inp_1_2: .word 0xdcbc085f
test_280_inp_2_1: .word 0xc304e0eb
test_280_inp_2_2: .word 0x7812878f
test_280_ajit_res_1: .word 0x80000000
test_280_ajit_res_2: .word 0x5
test_280_Cmodel_res_1: .word 0x0
test_280_Cmodel_res_2: .word 0x0

test_281_inp_1_1: .word 0x800f1dc3
test_281_inp_1_2: .word 0x2c300ff0
test_281_inp_2_1: .word 0x37f8799e
test_281_inp_2_2: .word 0x804b93ef
test_281_ajit_res_1: .word 0x8803c387
test_281_ajit_res_2: .word 0xe7812468
test_281_Cmodel_res_1: .word 0x0
test_281_Cmodel_res_2: .word 0x0

test_282_inp_1_1: .word 0x184ec
test_282_inp_1_2: .word 0x230f5936
test_282_inp_2_1: .word 0xb8b7dfff
test_282_inp_2_2: .word 0x47b1ca04
test_282_ajit_res_1: .word 0x87104a3a
test_282_ajit_res_2: .word 0x40bd88c8
test_282_Cmodel_res_1: .word 0x0
test_282_Cmodel_res_2: .word 0x0

test_283_inp_1_1: .word 0x800e5977
test_283_inp_1_2: .word 0xb4ecd5c1
test_283_inp_2_1: .word 0x1bf67aa5
test_283_inp_2_2: .word 0x425c5c2a
test_283_ajit_res_1: .word 0xa4046d59
test_283_ajit_res_2: .word 0x326ec345
test_283_Cmodel_res_1: .word 0x0
test_283_Cmodel_res_2: .word 0x0

test_284_inp_1_1: .word 0x80071b5d
test_284_inp_1_2: .word 0x2fee189
test_284_inp_2_1: .word 0x40ed1490
test_284_inp_2_2: .word 0x67665e0a
test_284_ajit_res_1: .word 0x80000007
test_284_ajit_res_2: .word 0xd2071f0f
test_284_Cmodel_res_1: .word 0x0
test_284_Cmodel_res_2: .word 0x0

test_285_inp_1_1: .word 0x45f3a
test_285_inp_1_2: .word 0x4fbedf9c
test_285_inp_2_1: .word 0x6b754e2b
test_285_inp_2_2: .word 0x8523c523
test_285_ajit_res_1: .word 0x0
test_285_ajit_res_2: .word 0x0
test_285_Cmodel_res_1: .word 0x0
test_285_Cmodel_res_2: .word 0x0

test_286_inp_1_1: .word 0x8005714f
test_286_inp_1_2: .word 0x45de4d7d
test_286_inp_2_1: .word 0xdc588a15
test_286_inp_2_2: .word 0x78270ea7
test_286_ajit_res_1: .word 0x0
test_286_ajit_res_2: .word 0x0
test_286_Cmodel_res_1: .word 0x0
test_286_Cmodel_res_2: .word 0x0

test_287_inp_1_1: .word 0xf5a88
test_287_inp_1_2: .word 0x8ebbd3da
test_287_inp_2_1: .word 0xc1e3819b
test_287_inp_2_2: .word 0x6ed312fd
test_287_ajit_res_1: .word 0x80000000
test_287_ajit_res_2: .word 0x193007
test_287_Cmodel_res_1: .word 0x0
test_287_Cmodel_res_2: .word 0x0

test_288_inp_1_1: .word 0x80075a96
test_288_inp_1_2: .word 0xf4e53e45
test_288_inp_2_1: .word 0xf2784015
test_288_inp_2_2: .word 0xcd79c579
test_288_ajit_res_1: .word 0x0
test_288_ajit_res_2: .word 0x0
test_288_Cmodel_res_1: .word 0x0
test_288_Cmodel_res_2: .word 0x0

test_289_inp_1_1: .word 0x8006c9bf
test_289_inp_1_2: .word 0x2d79b2e2
test_289_inp_2_1: .word 0xf664186f
test_289_inp_2_2: .word 0x491db907
test_289_ajit_res_1: .word 0x0
test_289_ajit_res_2: .word 0x0
test_289_Cmodel_res_1: .word 0x0
test_289_Cmodel_res_2: .word 0x0

test_290_inp_1_1: .word 0x8006f143
test_290_inp_1_2: .word 0x473038b2
test_290_inp_2_1: .word 0x6060b1da
test_290_inp_2_2: .word 0x62203443
test_290_ajit_res_1: .word 0x80000000
test_290_ajit_res_2: .word 0x0
test_290_Cmodel_res_1: .word 0x0
test_290_Cmodel_res_2: .word 0x0

test_291_inp_1_1: .word 0x8006ee9e
test_291_inp_1_2: .word 0xd13208f0
test_291_inp_2_1: .word 0x24d57cc9
test_291_inp_2_2: .word 0x40ce50e1
test_291_ajit_res_1: .word 0x9b14a5ad
test_291_ajit_res_2: .word 0x619ee0d5
test_291_Cmodel_res_1: .word 0x0
test_291_Cmodel_res_2: .word 0x0

test_292_inp_1_1: .word 0x80072c73
test_292_inp_1_2: .word 0xd2e55ba8
test_292_inp_2_1: .word 0x233bca45
test_292_inp_2_2: .word 0xd15d7b1f
test_292_ajit_res_1: .word 0x9cb0854e
test_292_ajit_res_2: .word 0x59b03c20
test_292_Cmodel_res_1: .word 0x0
test_292_Cmodel_res_2: .word 0x0

test_293_inp_1_1: .word 0x8006f2d6
test_293_inp_1_2: .word 0xfa5e56dc
test_293_inp_2_1: .word 0x6a93000f
test_293_inp_2_2: .word 0xb006dd71
test_293_ajit_res_1: .word 0x80000000
test_293_ajit_res_2: .word 0x0
test_293_Cmodel_res_1: .word 0x0
test_293_Cmodel_res_2: .word 0x0

test_294_inp_1_1: .word 0x38ac6
test_294_inp_1_2: .word 0x379c5a9b
test_294_inp_2_1: .word 0x7c63b5c0
test_294_inp_2_2: .word 0x9e6aa4ee
test_294_ajit_res_1: .word 0x0
test_294_ajit_res_2: .word 0x0
test_294_Cmodel_res_1: .word 0x0
test_294_Cmodel_res_2: .word 0x0

test_295_inp_1_1: .word 0x8005ff9a
test_295_inp_1_2: .word 0x5a670495
test_295_inp_2_1: .word 0x753416bf
test_295_inp_2_2: .word 0x88384fdc
test_295_ajit_res_1: .word 0x80000000
test_295_ajit_res_2: .word 0x0
test_295_Cmodel_res_1: .word 0x0
test_295_Cmodel_res_2: .word 0x0

test_296_inp_1_1: .word 0x800b78ae
test_296_inp_1_2: .word 0xfed82450
test_296_inp_2_1: .word 0x4032d976
test_296_inp_2_2: .word 0x11968018
test_296_ajit_res_1: .word 0x80009bcb
test_296_ajit_res_2: .word 0xf5653a25
test_296_Cmodel_res_1: .word 0x0
test_296_Cmodel_res_2: .word 0x0

test_297_inp_1_1: .word 0x8007e39c
test_297_inp_1_2: .word 0xbc4f204e
test_297_inp_2_1: .word 0x7bcbf911
test_297_inp_2_2: .word 0xa9ea6d8e
test_297_ajit_res_1: .word 0x80000000
test_297_ajit_res_2: .word 0x0
test_297_Cmodel_res_1: .word 0x0
test_297_Cmodel_res_2: .word 0x0

test_298_inp_1_1: .word 0x80066b67
test_298_inp_1_2: .word 0xcd9c09
test_298_inp_2_1: .word 0x540a023c
test_298_inp_2_2: .word 0x4c82571
test_298_ajit_res_1: .word 0x80000000
test_298_ajit_res_2: .word 0x0
test_298_Cmodel_res_1: .word 0x0
test_298_Cmodel_res_2: .word 0x0

test_299_inp_1_1: .word 0x6c00e
test_299_inp_1_2: .word 0xaa4ee65
test_299_inp_2_1: .word 0x54010bd5
test_299_inp_2_2: .word 0x1fb49ef9
test_299_ajit_res_1: .word 0x0
test_299_ajit_res_2: .word 0x0
test_299_Cmodel_res_1: .word 0x0
test_299_Cmodel_res_2: .word 0x0

test_300_inp_1_1: .word 0x22ca1
test_300_inp_1_2: .word 0x84f7f93
test_300_inp_2_1: .word 0x7f996d57
test_300_inp_2_2: .word 0x7d2a65ac
test_300_ajit_res_1: .word 0x0
test_300_ajit_res_2: .word 0x0
test_300_Cmodel_res_1: .word 0x0
test_300_Cmodel_res_2: .word 0x0

test_301_inp_1_1: .word 0x2539
test_301_inp_1_2: .word 0xe62cc613
test_301_inp_2_1: .word 0xd816dbe9
test_301_inp_2_2: .word 0x70ad7b5f
test_301_ajit_res_1: .word 0x80000000
test_301_ajit_res_2: .word 0x0
test_301_Cmodel_res_1: .word 0x0
test_301_Cmodel_res_2: .word 0x0

test_302_inp_1_1: .word 0x8004e142
test_302_inp_1_2: .word 0xfcbcfa05
test_302_inp_2_1: .word 0xd94055df
test_302_inp_2_2: .word 0x8c59a2b1
test_302_ajit_res_1: .word 0x0
test_302_ajit_res_2: .word 0x0
test_302_Cmodel_res_1: .word 0x0
test_302_Cmodel_res_2: .word 0x0

test_303_inp_1_1: .word 0x800621e8
test_303_inp_1_2: .word 0x689821a7
test_303_inp_2_1: .word 0x73c30e49
test_303_inp_2_2: .word 0xaa3d9824
test_303_ajit_res_1: .word 0x80000000
test_303_ajit_res_2: .word 0x0
test_303_Cmodel_res_1: .word 0x0
test_303_Cmodel_res_2: .word 0x0

test_304_inp_1_1: .word 0x79090
test_304_inp_1_2: .word 0xab09c7bb
test_304_inp_2_1: .word 0xf674cf48
test_304_inp_2_2: .word 0xc5315af4
test_304_ajit_res_1: .word 0x80000000
test_304_ajit_res_2: .word 0x0
test_304_Cmodel_res_1: .word 0x0
test_304_Cmodel_res_2: .word 0x0

test_305_inp_1_1: .word 0x53df2
test_305_inp_1_2: .word 0x53dd1955
test_305_inp_2_1: .word 0x7ab4a74a
test_305_inp_2_2: .word 0x4f585627
test_305_ajit_res_1: .word 0x0
test_305_ajit_res_2: .word 0x0
test_305_Cmodel_res_1: .word 0x0
test_305_Cmodel_res_2: .word 0x0

test_306_inp_1_1: .word 0x78037
test_306_inp_1_2: .word 0xb920e189
test_306_inp_2_1: .word 0xfb39b14a
test_306_inp_2_2: .word 0x464fe20a
test_306_ajit_res_1: .word 0x80000000
test_306_ajit_res_2: .word 0x0
test_306_Cmodel_res_1: .word 0x0
test_306_Cmodel_res_2: .word 0x0

test_307_inp_1_1: .word 0x8002a082
test_307_inp_1_2: .word 0x254761b0
test_307_inp_2_1: .word 0xc76c9825
test_307_inp_2_2: .word 0x9a058373
test_307_ajit_res_1: .word 0x0
test_307_ajit_res_2: .word 0x0
test_307_Cmodel_res_1: .word 0x0
test_307_Cmodel_res_2: .word 0x0

test_308_inp_1_1: .word 0x2d44b
test_308_inp_1_2: .word 0xc6a4139c
test_308_inp_2_1: .word 0xc6c50f7a
test_308_inp_2_2: .word 0x3283cbb
test_308_ajit_res_1: .word 0x80000000
test_308_ajit_res_2: .word 0x0
test_308_Cmodel_res_1: .word 0x0
test_308_Cmodel_res_2: .word 0x0

test_309_inp_1_1: .word 0x80032fb6
test_309_inp_1_2: .word 0x410b86c6
test_309_inp_2_1: .word 0x4d1cd339
test_309_inp_2_2: .word 0xdf26e04b
test_309_ajit_res_1: .word 0x80000000
test_309_ajit_res_2: .word 0x0
test_309_Cmodel_res_1: .word 0x0
test_309_Cmodel_res_2: .word 0x0

test_310_inp_1_1: .word 0x373ff
test_310_inp_1_2: .word 0xa52f7952
test_310_inp_2_1: .word 0xe4240376
test_310_inp_2_2: .word 0x98d13320
test_310_ajit_res_1: .word 0x80000000
test_310_ajit_res_2: .word 0x0
test_310_Cmodel_res_1: .word 0x0
test_310_Cmodel_res_2: .word 0x0

test_311_inp_1_1: .word 0x8006df75
test_311_inp_1_2: .word 0x36384074
test_311_inp_2_1: .word 0x53e81dd4
test_311_inp_2_2: .word 0x1a2adf4
test_311_ajit_res_1: .word 0x80000000
test_311_ajit_res_2: .word 0x0
test_311_Cmodel_res_1: .word 0x0
test_311_Cmodel_res_2: .word 0x0

test_312_inp_1_1: .word 0x4bbcb
test_312_inp_1_2: .word 0xbbdc664f
test_312_inp_2_1: .word 0x6a95f9de
test_312_inp_2_2: .word 0xdfdad43
test_312_ajit_res_1: .word 0x0
test_312_ajit_res_2: .word 0x0
test_312_Cmodel_res_1: .word 0x0
test_312_Cmodel_res_2: .word 0x0

test_313_inp_1_1: .word 0x800799c4
test_313_inp_1_2: .word 0x239db7f
test_313_inp_2_1: .word 0x4ffe59f9
test_313_inp_2_2: .word 0x11369709
test_313_ajit_res_1: .word 0x80000000
test_313_ajit_res_2: .word 0x0
test_313_Cmodel_res_1: .word 0x0
test_313_Cmodel_res_2: .word 0x0

test_314_inp_1_1: .word 0x80012b10
test_314_inp_1_2: .word 0x3a3dd97
test_314_inp_2_1: .word 0x7d9a2cf0
test_314_inp_2_2: .word 0x8f391fec
test_314_ajit_res_1: .word 0x80000000
test_314_ajit_res_2: .word 0x0
test_314_Cmodel_res_1: .word 0x0
test_314_Cmodel_res_2: .word 0x0

test_315_inp_1_1: .word 0x8003d6ee
test_315_inp_1_2: .word 0x8504b43e
test_315_inp_2_1: .word 0x6245c50a
test_315_inp_2_2: .word 0x6a0872d6
test_315_ajit_res_1: .word 0x80000000
test_315_ajit_res_2: .word 0x0
test_315_Cmodel_res_1: .word 0x0
test_315_Cmodel_res_2: .word 0x0

test_316_inp_1_1: .word 0x8003a2f1
test_316_inp_1_2: .word 0xef3ecd96
test_316_inp_2_1: .word 0xc78131ea
test_316_inp_2_2: .word 0x31fb158d
test_316_ajit_res_1: .word 0x0
test_316_ajit_res_2: .word 0x0
test_316_Cmodel_res_1: .word 0x0
test_316_Cmodel_res_2: .word 0x0

test_317_inp_1_1: .word 0x80076438
test_317_inp_1_2: .word 0x430a9927
test_317_inp_2_1: .word 0x58b1489d
test_317_inp_2_2: .word 0xe9a425d5
test_317_ajit_res_1: .word 0x80000000
test_317_ajit_res_2: .word 0x0
test_317_Cmodel_res_1: .word 0x0
test_317_Cmodel_res_2: .word 0x0

test_318_inp_1_1: .word 0x8003f12a
test_318_inp_1_2: .word 0x8500ceba
test_318_inp_2_1: .word 0xc3a3bf15
test_318_inp_2_2: .word 0xcaa021a7
test_318_ajit_res_1: .word 0x0
test_318_ajit_res_2: .word 0x0
test_318_Cmodel_res_1: .word 0x0
test_318_Cmodel_res_2: .word 0x0

test_319_inp_1_1: .word 0x80020cef
test_319_inp_1_2: .word 0xa1682b4b
test_319_inp_2_1: .word 0x551d25a1
test_319_inp_2_2: .word 0xb2f349dd
test_319_ajit_res_1: .word 0x80000000
test_319_ajit_res_2: .word 0x0
test_319_Cmodel_res_1: .word 0x0
test_319_Cmodel_res_2: .word 0x0

test_320_inp_1_1: .word 0x8000b225
test_320_inp_1_2: .word 0x14e87d7e
test_320_inp_2_1: .word 0x48270e7b
test_320_inp_2_2: .word 0xf793204
test_320_ajit_res_1: .word 0x80000000
test_320_ajit_res_2: .word 0x0
test_320_Cmodel_res_1: .word 0x0
test_320_Cmodel_res_2: .word 0x0

test_321_inp_1_1: .word 0x13aa6
test_321_inp_1_2: .word 0x3798d739
test_321_inp_2_1: .word 0x7f4f99e7
test_321_inp_2_2: .word 0x968b08d7
test_321_ajit_res_1: .word 0x0
test_321_ajit_res_2: .word 0x0
test_321_Cmodel_res_1: .word 0x0
test_321_Cmodel_res_2: .word 0x0

test_322_inp_1_1: .word 0x800eedd2
test_322_inp_1_2: .word 0x2d982f10
test_322_inp_2_1: .word 0x8a869564
test_322_inp_2_2: .word 0x5cb6db4e
test_322_ajit_res_1: .word 0x3575275d
test_322_ajit_res_2: .word 0xdd6b5dc6
test_322_Cmodel_res_1: .word 0x0
test_322_Cmodel_res_2: .word 0x0

test_323_inp_1_1: .word 0x8007c61f
test_323_inp_1_2: .word 0x2edc110f
test_323_inp_2_1: .word 0xfa340cb
test_323_inp_2_2: .word 0x307e0aed
test_323_ajit_res_1: .word 0xb049d771
test_323_ajit_res_2: .word 0x81659f5c
test_323_Cmodel_res_1: .word 0x0
test_323_Cmodel_res_2: .word 0x0

test_324_inp_1_1: .word 0x3927d
test_324_inp_1_2: .word 0x910de897
test_324_inp_2_1: .word 0xc3b2d092
test_324_inp_2_2: .word 0xf94b3686
test_324_ajit_res_1: .word 0x80000000
test_324_ajit_res_2: .word 0x0
test_324_Cmodel_res_1: .word 0x0
test_324_Cmodel_res_2: .word 0x0

test_325_inp_1_1: .word 0x800715b0
test_325_inp_1_2: .word 0x48691e29
test_325_inp_2_1: .word 0x22261c72
test_325_inp_2_2: .word 0xddd16655
test_325_ajit_res_1: .word 0x9dc481aa
test_325_ajit_res_2: .word 0xe78d330a
test_325_Cmodel_res_1: .word 0x0
test_325_Cmodel_res_2: .word 0x0

test_326_inp_1_1: .word 0x800e51f1
test_326_inp_1_2: .word 0x969fd949
test_326_inp_2_1: .word 0xb8a6113f
test_326_inp_2_2: .word 0x1b94bb
test_326_ajit_res_1: .word 0x754c400
test_326_ajit_res_2: .word 0xd799d336
test_326_Cmodel_res_1: .word 0x0
test_326_Cmodel_res_2: .word 0x0

test_327_inp_1_1: .word 0x7c5d6
test_327_inp_1_2: .word 0x81ad6208
test_327_inp_2_1: .word 0x79b318a7
test_327_inp_2_2: .word 0x9e2fbacc
test_327_ajit_res_1: .word 0x0
test_327_ajit_res_2: .word 0x0
test_327_Cmodel_res_1: .word 0x0
test_327_Cmodel_res_2: .word 0x0

test_328_inp_1_1: .word 0x426f4
test_328_inp_1_2: .word 0x293578b4
test_328_inp_2_1: .word 0x5470b0ca
test_328_inp_2_2: .word 0x5da5bf45
test_328_ajit_res_1: .word 0x0
test_328_ajit_res_2: .word 0x0
test_328_Cmodel_res_1: .word 0x0
test_328_Cmodel_res_2: .word 0x0

test_329_inp_1_1: .word 0x800490cc
test_329_inp_1_2: .word 0xcf90014b
test_329_inp_2_1: .word 0x6481d760
test_329_inp_2_2: .word 0x95341389
test_329_ajit_res_1: .word 0x80000000
test_329_ajit_res_2: .word 0x0
test_329_Cmodel_res_1: .word 0x0
test_329_Cmodel_res_2: .word 0x0

test_330_inp_1_1: .word 0x40ccf
test_330_inp_1_2: .word 0x17d6db9d
test_330_inp_2_1: .word 0xd39ddb91
test_330_inp_2_2: .word 0xc5e8316a
test_330_ajit_res_1: .word 0x80000000
test_330_ajit_res_2: .word 0x0
test_330_Cmodel_res_1: .word 0x0
test_330_Cmodel_res_2: .word 0x0

test_331_inp_1_1: .word 0x80062967
test_331_inp_1_2: .word 0xd3cc95e4
test_331_inp_2_1: .word 0xc67c1d5d
test_331_inp_2_2: .word 0x966cf5cf
test_331_ajit_res_1: .word 0x0
test_331_ajit_res_2: .word 0x0
test_331_Cmodel_res_1: .word 0x0
test_331_Cmodel_res_2: .word 0x0

test_332_inp_1_1: .word 0x80065073
test_332_inp_1_2: .word 0x3047df9b
test_332_inp_2_1: .word 0x5545fe50
test_332_inp_2_2: .word 0x91ebd6e4
test_332_ajit_res_1: .word 0x80000000
test_332_ajit_res_2: .word 0x0
test_332_Cmodel_res_1: .word 0x0
test_332_Cmodel_res_2: .word 0x0

test_333_inp_1_1: .word 0x4601c
test_333_inp_1_2: .word 0xf8ebf5c9
test_333_inp_2_1: .word 0x20b97a43
test_333_inp_2_2: .word 0x659a7062
test_333_ajit_res_1: .word 0x1f25fb79
test_333_ajit_res_2: .word 0x67108758
test_333_Cmodel_res_1: .word 0x0
test_333_Cmodel_res_2: .word 0x0

test_334_inp_1_1: .word 0x8004788e
test_334_inp_1_2: .word 0x5e03f34a
test_334_inp_2_1: .word 0x46b9c07c
test_334_inp_2_2: .word 0x7072662c
test_334_ajit_res_1: .word 0x80000000
test_334_ajit_res_2: .word 0x0
test_334_Cmodel_res_1: .word 0x0
test_334_Cmodel_res_2: .word 0x0

test_335_inp_1_1: .word 0x800767cb
test_335_inp_1_2: .word 0xe7e0ecf3
test_335_inp_2_1: .word 0x7d3b8c15
test_335_inp_2_2: .word 0x765e71ea
test_335_ajit_res_1: .word 0x80000000
test_335_ajit_res_2: .word 0x0
test_335_Cmodel_res_1: .word 0x0
test_335_Cmodel_res_2: .word 0x0

test_336_inp_1_1: .word 0x46b85
test_336_inp_1_2: .word 0x8d4b5a29
test_336_inp_2_1: .word 0x56952c1c
test_336_inp_2_2: .word 0x727866dd
test_336_ajit_res_1: .word 0x0
test_336_ajit_res_2: .word 0x0
test_336_Cmodel_res_1: .word 0x0
test_336_Cmodel_res_2: .word 0x0

test_337_inp_1_1: .word 0x5f1be
test_337_inp_1_2: .word 0xb0652852
test_337_inp_2_1: .word 0x53222176
test_337_inp_2_2: .word 0x1c41b682
test_337_ajit_res_1: .word 0x0
test_337_ajit_res_2: .word 0x0
test_337_Cmodel_res_1: .word 0x0
test_337_Cmodel_res_2: .word 0x0

test_338_inp_1_1: .word 0x296f7
test_338_inp_1_2: .word 0xf2f05b05
test_338_inp_2_1: .word 0xc772a4bf
test_338_inp_2_2: .word 0x1f85daf3
test_338_ajit_res_1: .word 0x80000000
test_338_ajit_res_2: .word 0x0
test_338_Cmodel_res_1: .word 0x0
test_338_Cmodel_res_2: .word 0x0

test_339_inp_1_1: .word 0x67f92
test_339_inp_1_2: .word 0x2cd6901d
test_339_inp_2_1: .word 0xb1854c2d
test_339_inp_2_2: .word 0xdbd29a7d
test_339_ajit_res_1: .word 0x8e638717
test_339_ajit_res_2: .word 0xa6af2357
test_339_Cmodel_res_1: .word 0x0
test_339_Cmodel_res_2: .word 0x0

test_340_inp_1_1: .word 0x2f4c8
test_340_inp_1_2: .word 0x7ec21e49
test_340_inp_2_1: .word 0x48d3604
test_340_inp_2_2: .word 0x4d1b2835
test_340_ajit_res_1: .word 0x3b49e84f
test_340_ajit_res_2: .word 0xf26ae86d
test_340_Cmodel_res_1: .word 0x0
test_340_Cmodel_res_2: .word 0x0

test_341_inp_1_1: .word 0x4162a
test_341_inp_1_2: .word 0x7e3afe40
test_341_inp_2_1: .word 0x6d988c3c
test_341_inp_2_2: .word 0xccc91bbc
test_341_ajit_res_1: .word 0x0
test_341_ajit_res_2: .word 0x0
test_341_Cmodel_res_1: .word 0x0
test_341_Cmodel_res_2: .word 0x0

test_342_inp_1_1: .word 0x35911
test_342_inp_1_2: .word 0x7305ed72
test_342_inp_2_1: .word 0x5e644ff2
test_342_inp_2_2: .word 0xd966fa28
test_342_ajit_res_1: .word 0x0
test_342_ajit_res_2: .word 0x0
test_342_Cmodel_res_1: .word 0x0
test_342_Cmodel_res_2: .word 0x0

test_343_inp_1_1: .word 0x3d683
test_343_inp_1_2: .word 0xc90e65a7
test_343_inp_2_1: .word 0xd3dd6b9e
test_343_inp_2_2: .word 0xa0e9f0ac
test_343_ajit_res_1: .word 0x80000000
test_343_ajit_res_2: .word 0x0
test_343_Cmodel_res_1: .word 0x0
test_343_Cmodel_res_2: .word 0x0

test_344_inp_1_1: .word 0x8007ef3e
test_344_inp_1_2: .word 0x64573fa3
test_344_inp_2_1: .word 0xda6d96bb
test_344_inp_2_2: .word 0xd89c191c
test_344_ajit_res_1: .word 0x0
test_344_ajit_res_2: .word 0x0
test_344_Cmodel_res_1: .word 0x0
test_344_Cmodel_res_2: .word 0x0

test_345_inp_1_1: .word 0x80026a92
test_345_inp_1_2: .word 0x4f1c3340
test_345_inp_2_1: .word 0xdedd76fa
test_345_inp_2_2: .word 0x9caadb26
test_345_ajit_res_1: .word 0x0
test_345_ajit_res_2: .word 0x0
test_345_Cmodel_res_1: .word 0x0
test_345_Cmodel_res_2: .word 0x0

test_346_inp_1_1: .word 0x4750c
test_346_inp_1_2: .word 0xb9b66ef7
test_346_inp_2_1: .word 0x83eb88fe
test_346_inp_2_2: .word 0xbf545fea
test_346_ajit_res_1: .word 0xbbf4b84a
test_346_ajit_res_2: .word 0x559de335
test_346_Cmodel_res_1: .word 0x0
test_346_Cmodel_res_2: .word 0x0

test_347_inp_1_1: .word 0x8005eec7
test_347_inp_1_2: .word 0x12d669cc
test_347_inp_2_1: .word 0xf25b1e24
test_347_inp_2_2: .word 0x886e361f
test_347_ajit_res_1: .word 0x0
test_347_ajit_res_2: .word 0x0
test_347_Cmodel_res_1: .word 0x0
test_347_Cmodel_res_2: .word 0x0

test_348_inp_1_1: .word 0x8004a63b
test_348_inp_1_2: .word 0x2800ff41
test_348_inp_2_1: .word 0x605ba7b3
test_348_inp_2_2: .word 0x5c790eff
test_348_ajit_res_1: .word 0x80000000
test_348_ajit_res_2: .word 0x0
test_348_Cmodel_res_1: .word 0x0
test_348_Cmodel_res_2: .word 0x0

test_349_inp_1_1: .word 0x8002b4b0
test_349_inp_1_2: .word 0xbe5b18e4
test_349_inp_2_1: .word 0xfdafffc7
test_349_inp_2_2: .word 0x55717d5
test_349_ajit_res_1: .word 0x0
test_349_ajit_res_2: .word 0x0
test_349_Cmodel_res_1: .word 0x0
test_349_Cmodel_res_2: .word 0x0

test_350_inp_1_1: .word 0x6d9bc
test_350_inp_1_2: .word 0x7a22d762
test_350_inp_2_1: .word 0xec81b54b
test_350_inp_2_2: .word 0xc4170a4c
test_350_ajit_res_1: .word 0x80000000
test_350_ajit_res_2: .word 0x0
test_350_Cmodel_res_1: .word 0x0
test_350_Cmodel_res_2: .word 0x0

test_351_inp_1_1: .word 0x5c3ff
test_351_inp_1_2: .word 0x919da936
test_351_inp_2_1: .word 0xa60c5c4b
test_351_inp_2_2: .word 0x833a1fe4
test_351_ajit_res_1: .word 0x99da05a5
test_351_ajit_res_2: .word 0x4ce4518b
test_351_Cmodel_res_1: .word 0x0
test_351_Cmodel_res_2: .word 0x0

test_352_inp_1_1: .word 0x800031dc
test_352_inp_1_2: .word 0x28643f91
test_352_inp_2_1: .word 0xfe88be2b
test_352_inp_2_2: .word 0x699533ae
test_352_ajit_res_1: .word 0x0
test_352_ajit_res_2: .word 0x0
test_352_Cmodel_res_1: .word 0x0
test_352_Cmodel_res_2: .word 0x0

test_353_inp_1_1: .word 0x80025fe8
test_353_inp_1_2: .word 0x32035a6d
test_353_inp_2_1: .word 0xcf49b4e3
test_353_inp_2_2: .word 0xc6ce6799
test_353_ajit_res_1: .word 0x0
test_353_ajit_res_2: .word 0x0
test_353_Cmodel_res_1: .word 0x0
test_353_Cmodel_res_2: .word 0x0

test_354_inp_1_1: .word 0x82787
test_354_inp_1_2: .word 0x2738b2ec
test_354_inp_2_1: .word 0x12c70e9
test_354_inp_2_2: .word 0x15f889
test_354_ajit_res_1: .word 0x3ec2597f
test_354_ajit_res_2: .word 0x610b0cf1
test_354_Cmodel_res_1: .word 0x0
test_354_Cmodel_res_2: .word 0x0

test_355_inp_1_1: .word 0x319d2
test_355_inp_1_2: .word 0x78398a9a
test_355_inp_2_1: .word 0x7b7e4388
test_355_inp_2_2: .word 0xdde61f0f
test_355_ajit_res_1: .word 0x0
test_355_ajit_res_2: .word 0x0
test_355_Cmodel_res_1: .word 0x0
test_355_Cmodel_res_2: .word 0x0

test_356_inp_1_1: .word 0x5103a
test_356_inp_1_2: .word 0x14454ca4
test_356_inp_2_1: .word 0x5a026743
test_356_inp_2_2: .word 0x6d06f3d
test_356_ajit_res_1: .word 0x0
test_356_ajit_res_2: .word 0x0
test_356_Cmodel_res_1: .word 0x0
test_356_Cmodel_res_2: .word 0x0

test_357_inp_1_1: .word 0x3827f
test_357_inp_1_2: .word 0x7d1e7239
test_357_inp_2_1: .word 0xbcffc178
test_357_inp_2_2: .word 0xcb05e09d
test_357_ajit_res_1: .word 0x82dc4b45
test_357_ajit_res_2: .word 0x4b99db3b
test_357_Cmodel_res_1: .word 0x0
test_357_Cmodel_res_2: .word 0x0

test_358_inp_1_1: .word 0x6c6a5
test_358_inp_1_2: .word 0x4ef6bc4
test_358_inp_2_1: .word 0x141af27d
test_358_inp_2_2: .word 0x1062c413
test_358_ajit_res_1: .word 0x2bd017cd
test_358_ajit_res_2: .word 0xb2895529
test_358_Cmodel_res_1: .word 0x0
test_358_Cmodel_res_2: .word 0x0

test_359_inp_1_1: .word 0x800e3d46
test_359_inp_1_2: .word 0x61d6dd51
test_359_inp_2_1: .word 0xc2cd7a8e
test_359_inp_2_2: .word 0x4a5e04ab
test_359_ajit_res_1: .word 0x0
test_359_ajit_res_2: .word 0x3d
test_359_Cmodel_res_1: .word 0x0
test_359_Cmodel_res_2: .word 0x0

test_360_inp_1_1: .word 0xdb117
test_360_inp_1_2: .word 0xfc2c1f06
test_360_inp_2_1: .word 0xb40a8669
test_360_inp_2_2: .word 0xd64346b8
test_360_ajit_res_1: .word 0x8bf08491
test_360_ajit_res_2: .word 0x81923df4
test_360_Cmodel_res_1: .word 0x0
test_360_Cmodel_res_2: .word 0x0

test_361_inp_1_1: .word 0x8006baf5
test_361_inp_1_2: .word 0x412d84f3
test_361_inp_2_1: .word 0xec506254
test_361_inp_2_2: .word 0x5624833a
test_361_ajit_res_1: .word 0x0
test_361_ajit_res_2: .word 0x0
test_361_Cmodel_res_1: .word 0x0
test_361_Cmodel_res_2: .word 0x0

test_362_inp_1_1: .word 0x8003b533
test_362_inp_1_2: .word 0x52bf887
test_362_inp_2_1: .word 0xeab1b3a3
test_362_inp_2_2: .word 0x8ba36eb6
test_362_ajit_res_1: .word 0x0
test_362_ajit_res_2: .word 0x0
test_362_Cmodel_res_1: .word 0x0
test_362_Cmodel_res_2: .word 0x0

test_363_inp_1_1: .word 0x80061ae6
test_363_inp_1_2: .word 0xf3c781a0
test_363_inp_2_1: .word 0x255ceff
test_363_inp_2_2: .word 0xf2b266a3
test_363_ajit_res_1: .word 0xbd91ea87
test_363_ajit_res_2: .word 0x5a92119b
test_363_Cmodel_res_1: .word 0x0
test_363_Cmodel_res_2: .word 0x0

test_364_inp_1_1: .word 0x6a3f4
test_364_inp_1_2: .word 0x13272cbb
test_364_inp_2_1: .word 0x74b2ff69
test_364_inp_2_2: .word 0x8f192c22
test_364_ajit_res_1: .word 0x0
test_364_ajit_res_2: .word 0x0
test_364_Cmodel_res_1: .word 0x0
test_364_Cmodel_res_2: .word 0x0

test_365_inp_1_1: .word 0x532bc
test_365_inp_1_2: .word 0xb87cd0d7
test_365_inp_2_1: .word 0xec2b28bd
test_365_inp_2_2: .word 0xbd4efcb6
test_365_ajit_res_1: .word 0x80000000
test_365_ajit_res_2: .word 0x0
test_365_Cmodel_res_1: .word 0x0
test_365_Cmodel_res_2: .word 0x0

test_366_inp_1_1: .word 0x17ef9
test_366_inp_1_2: .word 0x83455353
test_366_inp_2_1: .word 0xdc27c4f6
test_366_inp_2_2: .word 0xd1176d35
test_366_ajit_res_1: .word 0x80000000
test_366_ajit_res_2: .word 0x0
test_366_Cmodel_res_1: .word 0x0
test_366_Cmodel_res_2: .word 0x0

test_367_inp_1_1: .word 0x201de
test_367_inp_1_2: .word 0xe452a9cd
test_367_inp_2_1: .word 0xc93d7efd
test_367_inp_2_2: .word 0xa7b5dfde
test_367_ajit_res_1: .word 0x80000000
test_367_ajit_res_2: .word 0x0
test_367_Cmodel_res_1: .word 0x0
test_367_Cmodel_res_2: .word 0x0

test_368_inp_1_1: .word 0x8007ff5b
test_368_inp_1_2: .word 0x19a950aa
test_368_inp_2_1: .word 0xb7fb1ae0
test_368_inp_2_2: .word 0x3ecd688b
test_368_ajit_res_1: .word 0x7f2e231
test_368_ajit_res_2: .word 0xe19f9d7c
test_368_Cmodel_res_1: .word 0x0
test_368_Cmodel_res_2: .word 0x0

test_369_inp_1_1: .word 0x58037
test_369_inp_1_2: .word 0x50692f2a
test_369_inp_2_1: .word 0xf3e9ae20
test_369_inp_2_2: .word 0xee8f77f4
test_369_ajit_res_1: .word 0x80000000
test_369_ajit_res_2: .word 0x0
test_369_Cmodel_res_1: .word 0x0
test_369_Cmodel_res_2: .word 0x0

test_370_inp_1_1: .word 0x9a55
test_370_inp_1_2: .word 0xd63ad48b
test_370_inp_2_1: .word 0xf32907b6
test_370_inp_2_2: .word 0x6e76e3e2
test_370_ajit_res_1: .word 0x80000000
test_370_ajit_res_2: .word 0x0
test_370_Cmodel_res_1: .word 0x0
test_370_Cmodel_res_2: .word 0x0

test_371_inp_1_1: .word 0x8005e23d
test_371_inp_1_2: .word 0x73466321
test_371_inp_2_1: .word 0xf607c075
test_371_inp_2_2: .word 0x1b1207a7
test_371_ajit_res_1: .word 0x0
test_371_ajit_res_2: .word 0x0
test_371_Cmodel_res_1: .word 0x0
test_371_Cmodel_res_2: .word 0x0

test_372_inp_1_1: .word 0x8003bd91
test_372_inp_1_2: .word 0x3b27d6b7
test_372_inp_2_1: .word 0x76e80d25
test_372_inp_2_2: .word 0x83c6d4da
test_372_ajit_res_1: .word 0x80000000
test_372_ajit_res_2: .word 0x0
test_372_Cmodel_res_1: .word 0x0
test_372_Cmodel_res_2: .word 0x0

test_373_inp_1_1: .word 0x8001c6bf
test_373_inp_1_2: .word 0x96d28e9f
test_373_inp_2_1: .word 0x6e924113
test_373_inp_2_2: .word 0xd40b6c42
test_373_ajit_res_1: .word 0x80000000
test_373_ajit_res_2: .word 0x0
test_373_Cmodel_res_1: .word 0x0
test_373_Cmodel_res_2: .word 0x0

test_374_inp_1_1: .word 0x80048ffb
test_374_inp_1_2: .word 0xcfbbee88
test_374_inp_2_1: .word 0xffa397fc
test_374_inp_2_2: .word 0xdda43b55
test_374_ajit_res_1: .word 0x0
test_374_ajit_res_2: .word 0x0
test_374_Cmodel_res_1: .word 0x0
test_374_Cmodel_res_2: .word 0x0

test_375_inp_1_1: .word 0x587b8
test_375_inp_1_2: .word 0xab82a8d7
test_375_inp_2_1: .word 0xc79a6927
test_375_inp_2_2: .word 0x9fe97846
test_375_ajit_res_1: .word 0x80000000
test_375_ajit_res_2: .word 0x0
test_375_Cmodel_res_1: .word 0x0
test_375_Cmodel_res_2: .word 0x0

test_376_inp_1_1: .word 0x57250
test_376_inp_1_2: .word 0x4f3ae40
test_376_inp_2_1: .word 0xcaced798
test_376_inp_2_2: .word 0x5fe1d91c
test_376_ajit_res_1: .word 0x80000000
test_376_ajit_res_2: .word 0x0
test_376_Cmodel_res_1: .word 0x0
test_376_Cmodel_res_2: .word 0x0

test_377_inp_1_1: .word 0x6b607
test_377_inp_1_2: .word 0x7dd997d7
test_377_inp_2_1: .word 0x4780ba75
test_377_inp_2_2: .word 0x55cd3138
test_377_ajit_res_1: .word 0x0
test_377_ajit_res_2: .word 0x0
test_377_Cmodel_res_1: .word 0x0
test_377_Cmodel_res_2: .word 0x0

test_378_inp_1_1: .word 0x26794
test_378_inp_1_2: .word 0xecee37d0
test_378_inp_2_1: .word 0xd76a2b7d
test_378_inp_2_2: .word 0x73e1fbf
test_378_ajit_res_1: .word 0x80000000
test_378_ajit_res_2: .word 0x0
test_378_Cmodel_res_1: .word 0x0
test_378_Cmodel_res_2: .word 0x0

test_379_inp_1_1: .word 0x8001acba
test_379_inp_1_2: .word 0xb730fc98
test_379_inp_2_1: .word 0xe560944d
test_379_inp_2_2: .word 0x6730bb61
test_379_ajit_res_1: .word 0x0
test_379_ajit_res_2: .word 0x0
test_379_Cmodel_res_1: .word 0x0
test_379_Cmodel_res_2: .word 0x0

test_380_inp_1_1: .word 0x8007aa1f
test_380_inp_1_2: .word 0x1b273d3
test_380_inp_2_1: .word 0xcb637812
test_380_inp_2_2: .word 0x1abf83f4
test_380_ajit_res_1: .word 0x0
test_380_ajit_res_2: .word 0x0
test_380_Cmodel_res_1: .word 0x0
test_380_Cmodel_res_2: .word 0x0

test_381_inp_1_1: .word 0x7db1c
test_381_inp_1_2: .word 0xd6af755f
test_381_inp_2_1: .word 0xff38fda3
test_381_inp_2_2: .word 0x929e9c75
test_381_ajit_res_1: .word 0x80000000
test_381_ajit_res_2: .word 0x0
test_381_Cmodel_res_1: .word 0x0
test_381_Cmodel_res_2: .word 0x0

test_382_inp_1_1: .word 0x8001a4cc
test_382_inp_1_2: .word 0xf3736193
test_382_inp_2_1: .word 0x482ffe28
test_382_inp_2_2: .word 0xdd5f8390
test_382_ajit_res_1: .word 0x80000000
test_382_ajit_res_2: .word 0x0
test_382_Cmodel_res_1: .word 0x0
test_382_Cmodel_res_2: .word 0x0

test_383_inp_1_1: .word 0x30548
test_383_inp_1_2: .word 0x33e62bdb
test_383_inp_2_1: .word 0x6822a9d2
test_383_inp_2_2: .word 0x7de8714c
test_383_ajit_res_1: .word 0x0
test_383_ajit_res_2: .word 0x0
test_383_Cmodel_res_1: .word 0x0
test_383_Cmodel_res_2: .word 0x0

test_384_inp_1_1: .word 0x3ea78
test_384_inp_1_2: .word 0x9478874a
test_384_inp_2_1: .word 0x5b825637
test_384_inp_2_2: .word 0xa210e4c4
test_384_ajit_res_1: .word 0x0
test_384_ajit_res_2: .word 0x0
test_384_Cmodel_res_1: .word 0x0
test_384_Cmodel_res_2: .word 0x0

test_385_inp_1_1: .word 0xf718
test_385_inp_1_2: .word 0x8c8209a5
test_385_inp_2_1: .word 0x9b7ad91e
test_385_inp_2_2: .word 0x55c1c4f6
test_385_ajit_res_1: .word 0xa442682d
test_385_ajit_res_2: .word 0x64178843
test_385_Cmodel_res_1: .word 0x0
test_385_Cmodel_res_2: .word 0x0

test_386_inp_1_1: .word 0x5a304
test_386_inp_1_2: .word 0x785e3fdd
test_386_inp_2_1: .word 0xf9c267e2
test_386_inp_2_2: .word 0x91ed4e2
test_386_ajit_res_1: .word 0x80000000
test_386_ajit_res_2: .word 0x0
test_386_Cmodel_res_1: .word 0x0
test_386_Cmodel_res_2: .word 0x0

test_387_inp_1_1: .word 0x8008fb8b
test_387_inp_1_2: .word 0xabd9e428
test_387_inp_2_1: .word 0x4341b109
test_387_inp_2_2: .word 0xcdb25de0
test_387_ajit_res_1: .word 0x80000000
test_387_ajit_res_2: .word 0x0
test_387_Cmodel_res_1: .word 0x0
test_387_Cmodel_res_2: .word 0x0

test_388_inp_1_1: .word 0x8000d2fd
test_388_inp_1_2: .word 0x9b5f9de3
test_388_inp_2_1: .word 0xefb49731
test_388_inp_2_2: .word 0x30023a18
test_388_ajit_res_1: .word 0x0
test_388_ajit_res_2: .word 0x0
test_388_Cmodel_res_1: .word 0x0
test_388_Cmodel_res_2: .word 0x0

test_389_inp_1_1: .word 0x1c278
test_389_inp_1_2: .word 0x4f66cc1c
test_389_inp_2_1: .word 0xdeeda992
test_389_inp_2_2: .word 0xb2c08684
test_389_ajit_res_1: .word 0x80000000
test_389_ajit_res_2: .word 0x0
test_389_Cmodel_res_1: .word 0x0
test_389_Cmodel_res_2: .word 0x0

test_390_inp_1_1: .word 0xc902
test_390_inp_1_2: .word 0x44e22884
test_390_inp_2_1: .word 0xf2bc3b7f
test_390_inp_2_2: .word 0xa65b4dd5
test_390_ajit_res_1: .word 0x80000000
test_390_ajit_res_2: .word 0x0
test_390_Cmodel_res_1: .word 0x0
test_390_Cmodel_res_2: .word 0x0

test_391_inp_1_1: .word 0x8001fb8e
test_391_inp_1_2: .word 0x203575a6
test_391_inp_2_1: .word 0x4276c0ce
test_391_inp_2_2: .word 0xf206b6cd
test_391_ajit_res_1: .word 0x80000000
test_391_ajit_res_2: .word 0x164
test_391_Cmodel_res_1: .word 0x0
test_391_Cmodel_res_2: .word 0x0

test_392_inp_1_1: .word 0x80044c20
test_392_inp_1_2: .word 0xad6f52a3
test_392_inp_2_1: .word 0x47e70254
test_392_inp_2_2: .word 0xd43944c6
test_392_ajit_res_1: .word 0x80000000
test_392_ajit_res_2: .word 0x0
test_392_Cmodel_res_1: .word 0x0
test_392_Cmodel_res_2: .word 0x0

test_393_inp_1_1: .word 0x8007feab
test_393_inp_1_2: .word 0x136780bc
test_393_inp_2_1: .word 0x40096093
test_393_inp_2_2: .word 0xadcce0bd
test_393_ajit_res_1: .word 0x80028532
test_393_ajit_res_2: .word 0x9dfee2e0
test_393_Cmodel_res_1: .word 0x0
test_393_Cmodel_res_2: .word 0x0

test_394_inp_1_1: .word 0x8000bbe8
test_394_inp_1_2: .word 0xa7bc5832
test_394_inp_2_1: .word 0x7c94f187
test_394_inp_2_2: .word 0xcae76c02
test_394_ajit_res_1: .word 0x80000000
test_394_ajit_res_2: .word 0x0
test_394_Cmodel_res_1: .word 0x0
test_394_Cmodel_res_2: .word 0x0

test_395_inp_1_1: .word 0x80067c20
test_395_inp_1_2: .word 0xe016c9f5
test_395_inp_2_1: .word 0x6f6b5e56
test_395_inp_2_2: .word 0xf163926
test_395_ajit_res_1: .word 0x80000000
test_395_ajit_res_2: .word 0x0
test_395_Cmodel_res_1: .word 0x0
test_395_Cmodel_res_2: .word 0x0

test_396_inp_1_1: .word 0x800535eb
test_396_inp_1_2: .word 0x1814836f
test_396_inp_2_1: .word 0xd0787097
test_396_inp_2_2: .word 0x783b91a9
test_396_ajit_res_1: .word 0x0
test_396_ajit_res_2: .word 0x0
test_396_Cmodel_res_1: .word 0x0
test_396_Cmodel_res_2: .word 0x0

test_397_inp_1_1: .word 0x80022db3
test_397_inp_1_2: .word 0x9f566a35
test_397_inp_2_1: .word 0xcab3f78c
test_397_inp_2_2: .word 0x37f6eba1
test_397_ajit_res_1: .word 0x0
test_397_ajit_res_2: .word 0x0
test_397_Cmodel_res_1: .word 0x0
test_397_Cmodel_res_2: .word 0x0

test_398_inp_1_1: .word 0x80057fa4
test_398_inp_1_2: .word 0xbab0f80
test_398_inp_2_1: .word 0x787c2c33
test_398_inp_2_2: .word 0xbbb1b99f
test_398_ajit_res_1: .word 0x80000000
test_398_ajit_res_2: .word 0x0
test_398_Cmodel_res_1: .word 0x0
test_398_Cmodel_res_2: .word 0x0

test_399_inp_1_1: .word 0x8006b2c7
test_399_inp_1_2: .word 0xce61096
test_399_inp_2_1: .word 0x4cf3fd2f
test_399_inp_2_2: .word 0xb073937
test_399_ajit_res_1: .word 0x80000000
test_399_ajit_res_2: .word 0x0
test_399_Cmodel_res_1: .word 0x0
test_399_Cmodel_res_2: .word 0x0

test_400_inp_1_1: .word 0x80058174
test_400_inp_1_2: .word 0x78287cf0
test_400_inp_2_1: .word 0xdd7bd2df
test_400_inp_2_2: .word 0xb54b1009
test_400_ajit_res_1: .word 0x0
test_400_ajit_res_2: .word 0x0
test_400_Cmodel_res_1: .word 0x0
test_400_Cmodel_res_2: .word 0x0

test_401_inp_1_1: .word 0x5ba1b
test_401_inp_1_2: .word 0x45cac595
test_401_inp_2_1: .word 0x41e54d82
test_401_inp_2_2: .word 0x73fe955e
test_401_ajit_res_1: .word 0x0
test_401_ajit_res_2: .word 0x89a50
test_401_Cmodel_res_1: .word 0x0
test_401_Cmodel_res_2: .word 0x0

test_402_inp_1_1: .word 0xfc5d3
test_402_inp_1_2: .word 0xb96079c3
test_402_inp_2_1: .word 0x95ff2bf3
test_402_inp_2_2: .word 0x1ad4a9f0
test_402_ajit_res_1: .word 0xaa00311f
test_402_ajit_res_2: .word 0xb1bb4daa
test_402_Cmodel_res_1: .word 0x0
test_402_Cmodel_res_2: .word 0x0

test_403_inp_1_1: .word 0x8007237a
test_403_inp_1_2: .word 0x2d9869a6
test_403_inp_2_1: .word 0x1e4453df
test_403_inp_2_2: .word 0x5307f0f5
test_403_ajit_res_1: .word 0xa1a679ac
test_403_ajit_res_2: .word 0xa8337cab
test_403_Cmodel_res_1: .word 0x0
test_403_Cmodel_res_2: .word 0x0

test_404_inp_1_1: .word 0x8002067f
test_404_inp_1_2: .word 0x1774a190
test_404_inp_2_1: .word 0x372cbfd8
test_404_inp_2_2: .word 0xf9e62cd3
test_404_ajit_res_1: .word 0x88a208f7
test_404_ajit_res_2: .word 0xe78724ef
test_404_Cmodel_res_1: .word 0x0
test_404_Cmodel_res_2: .word 0x0

test_405_inp_1_1: .word 0x1cacd
test_405_inp_1_2: .word 0x7849c7a2
test_405_inp_2_1: .word 0xd8224576
test_405_inp_2_2: .word 0x3166fcad
test_405_ajit_res_1: .word 0x80000000
test_405_ajit_res_2: .word 0x0
test_405_Cmodel_res_1: .word 0x0
test_405_Cmodel_res_2: .word 0x0

test_406_inp_1_1: .word 0x800442ae
test_406_inp_1_2: .word 0xa0f0545e
test_406_inp_2_1: .word 0x5712a3c3
test_406_inp_2_2: .word 0xdc36376
test_406_ajit_res_1: .word 0x80000000
test_406_ajit_res_2: .word 0x0
test_406_Cmodel_res_1: .word 0x0
test_406_Cmodel_res_2: .word 0x0

test_407_inp_1_1: .word 0x65d9
test_407_inp_1_2: .word 0xecf8e9c0
test_407_inp_2_1: .word 0xecc436b0
test_407_inp_2_2: .word 0xac056813
test_407_ajit_res_1: .word 0x80000000
test_407_ajit_res_2: .word 0x0
test_407_Cmodel_res_1: .word 0x0
test_407_Cmodel_res_2: .word 0x0

test_408_inp_1_1: .word 0x800729fc
test_408_inp_1_2: .word 0x7446e0cf
test_408_inp_2_1: .word 0x71969425
test_408_inp_2_2: .word 0x3c93bece
test_408_ajit_res_1: .word 0x80000000
test_408_ajit_res_2: .word 0x0
test_408_Cmodel_res_1: .word 0x0
test_408_Cmodel_res_2: .word 0x0

test_409_inp_1_1: .word 0x800105a2
test_409_inp_1_2: .word 0x824492bb
test_409_inp_2_1: .word 0xeb9eb726
test_409_inp_2_2: .word 0x6e8fd55e
test_409_ajit_res_1: .word 0x0
test_409_ajit_res_2: .word 0x0
test_409_Cmodel_res_1: .word 0x0
test_409_Cmodel_res_2: .word 0x0

test_410_inp_1_1: .word 0x800723da
test_410_inp_1_2: .word 0x974248ce
test_410_inp_2_1: .word 0x4462de1e
test_410_inp_2_2: .word 0xc4593fdf
test_410_ajit_res_1: .word 0x80000000
test_410_ajit_res_2: .word 0x0
test_410_Cmodel_res_1: .word 0x0
test_410_Cmodel_res_2: .word 0x0

test_411_inp_1_1: .word 0x800eb7f0
test_411_inp_1_2: .word 0x68ffb2e1
test_411_inp_2_1: .word 0x8f6578a7
test_411_inp_2_2: .word 0xea16d5c4
test_411_ajit_res_1: .word 0x3095ef96
test_411_ajit_res_2: .word 0xa0802499
test_411_Cmodel_res_1: .word 0x0
test_411_Cmodel_res_2: .word 0x0

test_412_inp_1_1: .word 0x66dd0
test_412_inp_1_2: .word 0x79de7042
test_412_inp_2_1: .word 0xfb3d5b5d
test_412_inp_2_2: .word 0x58fd9c22
test_412_ajit_res_1: .word 0x80000000
test_412_ajit_res_2: .word 0x0
test_412_Cmodel_res_1: .word 0x0
test_412_Cmodel_res_2: .word 0x0

test_413_inp_1_1: .word 0x5eaae
test_413_inp_1_2: .word 0x57a4eb78
test_413_inp_2_1: .word 0x50e63ea6
test_413_inp_2_2: .word 0x86027cae
test_413_ajit_res_1: .word 0x0
test_413_ajit_res_2: .word 0x0
test_413_Cmodel_res_1: .word 0x0
test_413_Cmodel_res_2: .word 0x0

test_414_inp_1_1: .word 0x6aefc
test_414_inp_1_2: .word 0x37a2eb6c
test_414_inp_2_1: .word 0xc141ee6d
test_414_inp_2_2: .word 0x916ef5ba
test_414_ajit_res_1: .word 0x80000000
test_414_ajit_res_2: .word 0x2fb594b6
test_414_Cmodel_res_1: .word 0x0
test_414_Cmodel_res_2: .word 0x0

test_415_inp_1_1: .word 0x85157
test_415_inp_1_2: .word 0x7ca85d8e
test_415_inp_2_1: .word 0xedefc50
test_415_inp_2_2: .word 0xae9daeb5
test_415_ajit_res_1: .word 0x31112e1a
test_415_ajit_res_2: .word 0x3d8397da
test_415_Cmodel_res_1: .word 0x0
test_415_Cmodel_res_2: .word 0x0

test_416_inp_1_1: .word 0x8002024a
test_416_inp_1_2: .word 0x972b7f45
test_416_inp_2_1: .word 0x586ca86a
test_416_inp_2_2: .word 0x16c458fb
test_416_ajit_res_1: .word 0x80000000
test_416_ajit_res_2: .word 0x0
test_416_Cmodel_res_1: .word 0x0
test_416_Cmodel_res_2: .word 0x0

test_417_inp_1_1: .word 0x80061d16
test_417_inp_1_2: .word 0xe23a8d62
test_417_inp_2_1: .word 0x4dfb2930
test_417_inp_2_2: .word 0xd101e0f8
test_417_ajit_res_1: .word 0x80000000
test_417_ajit_res_2: .word 0x0
test_417_Cmodel_res_1: .word 0x0
test_417_Cmodel_res_2: .word 0x0

test_418_inp_1_1: .word 0x5ff42
test_418_inp_1_2: .word 0x43cddec3
test_418_inp_2_1: .word 0xf9e6b39e
test_418_inp_2_2: .word 0xa49995be
test_418_ajit_res_1: .word 0x80000000
test_418_ajit_res_2: .word 0x0
test_418_Cmodel_res_1: .word 0x0
test_418_Cmodel_res_2: .word 0x0

test_419_inp_1_1: .word 0x76f4d
test_419_inp_1_2: .word 0x5c42ecef
test_419_inp_2_1: .word 0xfe2d8ef5
test_419_inp_2_2: .word 0xee30b2f6
test_419_ajit_res_1: .word 0x80000000
test_419_ajit_res_2: .word 0x0
test_419_Cmodel_res_1: .word 0x0
test_419_Cmodel_res_2: .word 0x0

test_420_inp_1_1: .word 0x8000ef84
test_420_inp_1_2: .word 0x4cd593de
test_420_inp_2_1: .word 0xe0dda074
test_420_inp_2_2: .word 0xdda10f79
test_420_ajit_res_1: .word 0x0
test_420_ajit_res_2: .word 0x0
test_420_Cmodel_res_1: .word 0x0
test_420_Cmodel_res_2: .word 0x0

test_421_inp_1_1: .word 0x800434e0
test_421_inp_1_2: .word 0x90856b81
test_421_inp_2_1: .word 0x7e150da0
test_421_inp_2_2: .word 0x9fa2a116
test_421_ajit_res_1: .word 0x80000000
test_421_ajit_res_2: .word 0x0
test_421_Cmodel_res_1: .word 0x0
test_421_Cmodel_res_2: .word 0x0

test_422_inp_1_1: .word 0x4b316
test_422_inp_1_2: .word 0xd7ebd821
test_422_inp_2_1: .word 0x4eecb254
test_422_inp_2_2: .word 0x341427d1
test_422_ajit_res_1: .word 0x0
test_422_ajit_res_2: .word 0x0
test_422_Cmodel_res_1: .word 0x0
test_422_Cmodel_res_2: .word 0x0

test_423_inp_1_1: .word 0x80066483
test_423_inp_1_2: .word 0xafcd9715
test_423_inp_2_1: .word 0x3ae66f72
test_423_inp_2_2: .word 0x3be3697b
test_423_ajit_res_1: .word 0x85023c64
test_423_ajit_res_2: .word 0x1058cfcc
test_423_Cmodel_res_1: .word 0x0
test_423_Cmodel_res_2: .word 0x0

test_424_inp_1_1: .word 0xfe54b
test_424_inp_1_2: .word 0xb3592e78
test_424_inp_2_1: .word 0x1daaf170
test_424_inp_2_2: .word 0xd3f30224
test_424_ajit_res_1: .word 0x2252e10c
test_424_ajit_res_2: .word 0x9856c7eb
test_424_Cmodel_res_1: .word 0x0
test_424_Cmodel_res_2: .word 0x0

test_425_inp_1_1: .word 0x80075384
test_425_inp_1_2: .word 0xac569911
test_425_inp_2_1: .word 0xf1878e96
test_425_inp_2_2: .word 0xc34c5063
test_425_ajit_res_1: .word 0x0
test_425_ajit_res_2: .word 0x0
test_425_Cmodel_res_1: .word 0x0
test_425_Cmodel_res_2: .word 0x0

test_426_inp_1_1: .word 0x5c371
test_426_inp_1_2: .word 0xa81179a3
test_426_inp_2_1: .word 0x7ac421c9
test_426_inp_2_2: .word 0xc70b5390
test_426_ajit_res_1: .word 0x0
test_426_ajit_res_2: .word 0x0
test_426_Cmodel_res_1: .word 0x0
test_426_Cmodel_res_2: .word 0x0

test_427_inp_1_1: .word 0x80005532
test_427_inp_1_2: .word 0xd1597b5
test_427_inp_2_1: .word 0xc2418580
test_427_inp_2_2: .word 0x7d28f1da
test_427_ajit_res_1: .word 0x0
test_427_ajit_res_2: .word 0x26e
test_427_Cmodel_res_1: .word 0x0
test_427_Cmodel_res_2: .word 0x0

test_428_inp_1_1: .word 0x54375
test_428_inp_1_2: .word 0xb1f11613
test_428_inp_2_1: .word 0xd3160a8b
test_428_inp_2_2: .word 0x25eb10ff
test_428_ajit_res_1: .word 0x80000000
test_428_ajit_res_2: .word 0x0
test_428_Cmodel_res_1: .word 0x0
test_428_Cmodel_res_2: .word 0x0

test_429_inp_1_1: .word 0x34a4d
test_429_inp_1_2: .word 0x3471e943
test_429_inp_2_1: .word 0x60fa278c
test_429_inp_2_2: .word 0xfbe93a51
test_429_ajit_res_1: .word 0x0
test_429_ajit_res_2: .word 0x0
test_429_Cmodel_res_1: .word 0x0
test_429_Cmodel_res_2: .word 0x0

test_430_inp_1_1: .word 0x800e6ef3
test_430_inp_1_2: .word 0x849f40ec
test_430_inp_2_1: .word 0x1dfb46eb
test_430_inp_2_2: .word 0x2681c56d
test_430_ajit_res_1: .word 0xa200eeb9
test_430_ajit_res_2: .word 0xed7dd7a3
test_430_Cmodel_res_1: .word 0x0
test_430_Cmodel_res_2: .word 0x0

test_431_inp_1_1: .word 0x521f0
test_431_inp_1_2: .word 0xeff095eb
test_431_inp_2_1: .word 0xe1ce6b18
test_431_inp_2_2: .word 0x3cb76e00
test_431_ajit_res_1: .word 0x80000000
test_431_ajit_res_2: .word 0x0
test_431_Cmodel_res_1: .word 0x0
test_431_Cmodel_res_2: .word 0x0

test_432_inp_1_1: .word 0x800cc01e
test_432_inp_1_2: .word 0x822b29fa
test_432_inp_2_1: .word 0x8ca84fcf
test_432_inp_2_2: .word 0xd2884129
test_432_ajit_res_1: .word 0x3350c859
test_432_ajit_res_2: .word 0x34b25ced
test_432_Cmodel_res_1: .word 0x0
test_432_Cmodel_res_2: .word 0x0

test_433_inp_1_1: .word 0x58067
test_433_inp_1_2: .word 0xf3b9322b
test_433_inp_2_1: .word 0x47ae0443
test_433_inp_2_2: .word 0xa149aa8f
test_433_ajit_res_1: .word 0x0
test_433_ajit_res_2: .word 0x0
test_433_Cmodel_res_1: .word 0x0
test_433_Cmodel_res_2: .word 0x0

test_434_inp_1_1: .word 0x577fd
test_434_inp_1_2: .word 0xc6efb46e
test_434_inp_2_1: .word 0xe5a5dabb
test_434_inp_2_2: .word 0x110eb086
test_434_ajit_res_1: .word 0x80000000
test_434_ajit_res_2: .word 0x0
test_434_Cmodel_res_1: .word 0x0
test_434_Cmodel_res_2: .word 0x0

test_435_inp_1_1: .word 0x8006a4ee
test_435_inp_1_2: .word 0x26b3192d
test_435_inp_2_1: .word 0xe2e51cc3
test_435_inp_2_2: .word 0x1da3945f
test_435_ajit_res_1: .word 0x0
test_435_ajit_res_2: .word 0x0
test_435_Cmodel_res_1: .word 0x0
test_435_Cmodel_res_2: .word 0x0

test_436_inp_1_1: .word 0x80064e02
test_436_inp_1_2: .word 0x8a3f5920
test_436_inp_2_1: .word 0xd9ff24c9
test_436_inp_2_2: .word 0x34fd6f92
test_436_ajit_res_1: .word 0x0
test_436_ajit_res_2: .word 0x0
test_436_Cmodel_res_1: .word 0x0
test_436_Cmodel_res_2: .word 0x0

test_437_inp_1_1: .word 0x79a48
test_437_inp_1_2: .word 0x439f24cb
test_437_inp_2_1: .word 0xc3892f8f
test_437_inp_2_2: .word 0x40cc4842
test_437_ajit_res_1: .word 0x80000000
test_437_ajit_res_2: .word 0x0
test_437_Cmodel_res_1: .word 0x0
test_437_Cmodel_res_2: .word 0x0

test_438_inp_1_1: .word 0x5db31
test_438_inp_1_2: .word 0x41866de
test_438_inp_2_1: .word 0xc580c5e1
test_438_inp_2_2: .word 0x2ff42193
test_438_ajit_res_1: .word 0x80000000
test_438_ajit_res_2: .word 0x0
test_438_Cmodel_res_1: .word 0x0
test_438_Cmodel_res_2: .word 0x0

test_439_inp_1_1: .word 0x4bbb3
test_439_inp_1_2: .word 0xb669ea8a
test_439_inp_2_1: .word 0xe5d0c4b9
test_439_inp_2_2: .word 0xc190dbdf
test_439_ajit_res_1: .word 0x80000000
test_439_ajit_res_2: .word 0x0
test_439_Cmodel_res_1: .word 0x0
test_439_Cmodel_res_2: .word 0x0

test_440_inp_1_1: .word 0x1fa1a
test_440_inp_1_2: .word 0x35449de3
test_440_inp_2_1: .word 0x58d21ea1
test_440_inp_2_2: .word 0xdb850c18
test_440_ajit_res_1: .word 0x0
test_440_ajit_res_2: .word 0x0
test_440_Cmodel_res_1: .word 0x0
test_440_Cmodel_res_2: .word 0x0

test_441_inp_1_1: .word 0x342e8
test_441_inp_1_2: .word 0x1c2ba9c9
test_441_inp_2_1: .word 0xeded1a6e
test_441_inp_2_2: .word 0xea74acda
test_441_ajit_res_1: .word 0x80000000
test_441_ajit_res_2: .word 0x0
test_441_Cmodel_res_1: .word 0x0
test_441_Cmodel_res_2: .word 0x0

test_442_inp_1_1: .word 0x8004f835
test_442_inp_1_2: .word 0xbfff1245
test_442_inp_2_1: .word 0xeb53d94c
test_442_inp_2_2: .word 0x734edd21
test_442_ajit_res_1: .word 0x0
test_442_ajit_res_2: .word 0x0
test_442_Cmodel_res_1: .word 0x0
test_442_Cmodel_res_2: .word 0x0

test_443_inp_1_1: .word 0x8005a969
test_443_inp_1_2: .word 0xa7ac644a
test_443_inp_2_1: .word 0xf834ca41
test_443_inp_2_2: .word 0xcf776e02
test_443_ajit_res_1: .word 0x0
test_443_ajit_res_2: .word 0x0
test_443_Cmodel_res_1: .word 0x0
test_443_Cmodel_res_2: .word 0x0

test_444_inp_1_1: .word 0x726a7
test_444_inp_1_2: .word 0x68910b5e
test_444_inp_2_1: .word 0xe291caf0
test_444_inp_2_2: .word 0x5ef93ec8
test_444_ajit_res_1: .word 0x80000000
test_444_ajit_res_2: .word 0x0
test_444_Cmodel_res_1: .word 0x0
test_444_Cmodel_res_2: .word 0x0

test_445_inp_1_1: .word 0x8005259a
test_445_inp_1_2: .word 0x4447cf58
test_445_inp_2_1: .word 0xe409f067
test_445_inp_2_2: .word 0xb55b96c6
test_445_ajit_res_1: .word 0x0
test_445_ajit_res_2: .word 0x0
test_445_Cmodel_res_1: .word 0x0
test_445_Cmodel_res_2: .word 0x0

test_446_inp_1_1: .word 0x119de
test_446_inp_1_2: .word 0x579398d3
test_446_inp_2_1: .word 0xe0149f0b
test_446_inp_2_2: .word 0xaa84eb22
test_446_ajit_res_1: .word 0x80000000
test_446_ajit_res_2: .word 0x0
test_446_Cmodel_res_1: .word 0x0
test_446_Cmodel_res_2: .word 0x0

test_447_inp_1_1: .word 0x8003ecb4
test_447_inp_1_2: .word 0x9086c714
test_447_inp_2_1: .word 0x4b7275b0
test_447_inp_2_2: .word 0x1fc08f9a
test_447_ajit_res_1: .word 0x80000000
test_447_ajit_res_2: .word 0x0
test_447_Cmodel_res_1: .word 0x0
test_447_Cmodel_res_2: .word 0x0

test_448_inp_1_1: .word 0x48f90de6
test_448_inp_1_2: .word 0x234a95d1
test_448_inp_2_1: .word 0x800f9c3a
test_448_inp_2_2: .word 0xc66754ba
test_448_ajit_res_1: .word 0xfff00000
test_448_ajit_res_2: .word 0x0
test_448_Cmodel_res_1: .word 0x0
test_448_Cmodel_res_2: .word 0x0

test_449_inp_1_1: .word 0x6ec805d4
test_449_inp_1_2: .word 0xfee1d456
test_449_inp_2_1: .word 0x8007d4fb
test_449_inp_2_2: .word 0x511fc27e
test_449_ajit_res_1: .word 0xfff00000
test_449_ajit_res_2: .word 0x0
test_449_Cmodel_res_1: .word 0x0
test_449_Cmodel_res_2: .word 0x0

test_450_inp_1_1: .word 0x57e3bb47
test_450_inp_1_2: .word 0xd6d491be
test_450_inp_2_1: .word 0x8006abcb
test_450_inp_2_2: .word 0x5050971d
test_450_ajit_res_1: .word 0xfff00000
test_450_ajit_res_2: .word 0x0
test_450_Cmodel_res_1: .word 0x0
test_450_Cmodel_res_2: .word 0x0

test_451_inp_1_1: .word 0x4d38e3b9
test_451_inp_1_2: .word 0x76d0f233
test_451_inp_2_1: .word 0x800e0e76
test_451_inp_2_2: .word 0xd069bf17
test_451_ajit_res_1: .word 0xfff00000
test_451_ajit_res_2: .word 0x0
test_451_Cmodel_res_1: .word 0x0
test_451_Cmodel_res_2: .word 0x0

test_452_inp_1_1: .word 0x444d0215
test_452_inp_1_2: .word 0xbfcb89bc
test_452_inp_2_1: .word 0x80098444
test_452_inp_2_2: .word 0xf43ff1af
test_452_ajit_res_1: .word 0xfff00000
test_452_ajit_res_2: .word 0x0
test_452_Cmodel_res_1: .word 0x0
test_452_Cmodel_res_2: .word 0x0

test_453_inp_1_1: .word 0x57e09dfb
test_453_inp_1_2: .word 0xc636ea87
test_453_inp_2_1: .word 0x80099856
test_453_inp_2_2: .word 0xec74c692
test_453_ajit_res_1: .word 0xfff00000
test_453_ajit_res_2: .word 0x0
test_453_Cmodel_res_1: .word 0x0
test_453_Cmodel_res_2: .word 0x0

test_454_inp_1_1: .word 0xc35c2958
test_454_inp_1_2: .word 0x9050edca
test_454_inp_2_1: .word 0x800384c0
test_454_inp_2_2: .word 0xd5d07e91
test_454_ajit_res_1: .word 0x7ff00000
test_454_ajit_res_2: .word 0x0
test_454_Cmodel_res_1: .word 0x0
test_454_Cmodel_res_2: .word 0x0

test_455_inp_1_1: .word 0x1d1b8cc8
test_455_inp_1_2: .word 0xe53a8d98
test_455_inp_2_1: .word 0x5428e
test_455_inp_2_2: .word 0x56e69e83
test_455_ajit_res_1: .word 0x5d14f359
test_455_ajit_res_2: .word 0xac6b6dd0
test_455_Cmodel_res_1: .word 0x0
test_455_Cmodel_res_2: .word 0x0

test_456_inp_1_1: .word 0x8835085c
test_456_inp_1_2: .word 0x92e84b4a
test_456_inp_2_1: .word 0x8007d659
test_456_inp_2_2: .word 0x8a0e095c
test_456_ajit_res_1: .word 0x48257822
test_456_ajit_res_2: .word 0xffa30000
test_456_Cmodel_res_1: .word 0x0
test_456_Cmodel_res_2: .word 0x0

test_457_inp_1_1: .word 0x4a3e33e9
test_457_inp_1_2: .word 0x33fcce4a
test_457_inp_2_1: .word 0x80009d7e
test_457_inp_2_2: .word 0x4dcde556
test_457_ajit_res_1: .word 0xfff00000
test_457_ajit_res_2: .word 0x0
test_457_Cmodel_res_1: .word 0x0
test_457_Cmodel_res_2: .word 0x0

test_458_inp_1_1: .word 0x593d657e
test_458_inp_1_2: .word 0x1eee195a
test_458_inp_2_1: .word 0x8004b713
test_458_inp_2_2: .word 0x3daed3e8
test_458_ajit_res_1: .word 0xfff00000
test_458_ajit_res_2: .word 0x0
test_458_Cmodel_res_1: .word 0x0
test_458_Cmodel_res_2: .word 0x0

test_459_inp_1_1: .word 0xcaa1b529
test_459_inp_1_2: .word 0x3d76f727
test_459_inp_2_1: .word 0x80094308
test_459_inp_2_2: .word 0x8a473309
test_459_ajit_res_1: .word 0x7ff00000
test_459_ajit_res_2: .word 0x0
test_459_Cmodel_res_1: .word 0x0
test_459_Cmodel_res_2: .word 0x0

test_460_inp_1_1: .word 0x7e552f4f
test_460_inp_1_2: .word 0xd7202b26
test_460_inp_2_1: .word 0x800aa7c0
test_460_inp_2_2: .word 0x400062f0
test_460_ajit_res_1: .word 0xfff00000
test_460_ajit_res_2: .word 0x0
test_460_Cmodel_res_1: .word 0x0
test_460_Cmodel_res_2: .word 0x0

test_461_inp_1_1: .word 0xc0a8380e
test_461_inp_1_2: .word 0xdb796560
test_461_inp_2_1: .word 0x8008d8d2
test_461_inp_2_2: .word 0xab6ecfaa
test_461_ajit_res_1: .word 0x7ff00000
test_461_ajit_res_2: .word 0x0
test_461_Cmodel_res_1: .word 0x0
test_461_Cmodel_res_2: .word 0x0

test_462_inp_1_1: .word 0xb885f6e8
test_462_inp_1_2: .word 0x24de1c84
test_462_inp_2_1: .word 0x800a4297
test_462_inp_2_2: .word 0x3fa01bd
test_462_ajit_res_1: .word 0x78712048
test_462_ajit_res_2: .word 0x6adb7a89
test_462_Cmodel_res_1: .word 0x0
test_462_Cmodel_res_2: .word 0x0

test_463_inp_1_1: .word 0xdd159b68
test_463_inp_1_2: .word 0xadbc290b
test_463_inp_2_1: .word 0x8001525a
test_463_inp_2_2: .word 0x71fe7399
test_463_ajit_res_1: .word 0x7ff00000
test_463_ajit_res_2: .word 0x0
test_463_Cmodel_res_1: .word 0x0
test_463_Cmodel_res_2: .word 0x0

test_464_inp_1_1: .word 0xcaa67c97
test_464_inp_1_2: .word 0xa4212dc9
test_464_inp_2_1: .word 0x8009ac35
test_464_inp_2_2: .word 0xdd3f3dd2
test_464_ajit_res_1: .word 0x7ff00000
test_464_ajit_res_2: .word 0x0
test_464_Cmodel_res_1: .word 0x0
test_464_Cmodel_res_2: .word 0x0

test_465_inp_1_1: .word 0x35571379
test_465_inp_1_2: .word 0xc7855432
test_465_inp_2_1: .word 0xaa46c
test_465_inp_2_2: .word 0x5bed121a
test_465_ajit_res_1: .word 0x754158c2
test_465_ajit_res_2: .word 0x97116acb
test_465_Cmodel_res_1: .word 0x0
test_465_Cmodel_res_2: .word 0x0

test_466_inp_1_1: .word 0xe3613dbd
test_466_inp_1_2: .word 0x837d2323
test_466_inp_2_1: .word 0x800c2667
test_466_inp_2_2: .word 0x601d71a5
test_466_ajit_res_1: .word 0x7ff00000
test_466_ajit_res_2: .word 0x0
test_466_Cmodel_res_1: .word 0x0
test_466_Cmodel_res_2: .word 0x0

test_467_inp_1_1: .word 0x9269498
test_467_inp_1_2: .word 0x8a9ab082
test_467_inp_2_1: .word 0x278a7
test_467_inp_2_2: .word 0x81f5e563
test_467_ajit_res_1: .word 0x4932462b
test_467_ajit_res_2: .word 0xc25443cf
test_467_Cmodel_res_1: .word 0x0
test_467_Cmodel_res_2: .word 0x0

test_468_inp_1_1: .word 0x60b9b3c2
test_468_inp_1_2: .word 0x5d93b709
test_468_inp_2_1: .word 0x800dedc8
test_468_inp_2_2: .word 0x2f6a7227
test_468_ajit_res_1: .word 0xfff00000
test_468_ajit_res_2: .word 0x0
test_468_Cmodel_res_1: .word 0x0
test_468_Cmodel_res_2: .word 0x0

test_469_inp_1_1: .word 0xd7cd982e
test_469_inp_1_2: .word 0xc02602d2
test_469_inp_2_1: .word 0x80057853
test_469_inp_2_2: .word 0x20d2ba57
test_469_ajit_res_1: .word 0x7ff00000
test_469_ajit_res_2: .word 0x0
test_469_Cmodel_res_1: .word 0x0
test_469_Cmodel_res_2: .word 0x0

test_470_inp_1_1: .word 0xd0156639
test_470_inp_1_2: .word 0xae3ad0f6
test_470_inp_2_1: .word 0x8009e4c1
test_470_inp_2_2: .word 0xb86258d7
test_470_ajit_res_1: .word 0x7ff00000
test_470_ajit_res_2: .word 0x0
test_470_Cmodel_res_1: .word 0x0
test_470_Cmodel_res_2: .word 0x0

test_471_inp_1_1: .word 0xfef2690e
test_471_inp_1_2: .word 0xebc6440e
test_471_inp_2_1: .word 0x80098d1c
test_471_inp_2_2: .word 0xd90d0b06
test_471_ajit_res_1: .word 0x7ff00000
test_471_ajit_res_2: .word 0x0
test_471_Cmodel_res_1: .word 0x0
test_471_Cmodel_res_2: .word 0x0

test_472_inp_1_1: .word 0xd1df7def
test_472_inp_1_2: .word 0x34575d3b
test_472_inp_2_1: .word 0x800876cc
test_472_inp_2_2: .word 0xaecddd41
test_472_ajit_res_1: .word 0x7ff00000
test_472_ajit_res_2: .word 0x0
test_472_Cmodel_res_1: .word 0x0
test_472_Cmodel_res_2: .word 0x0

test_473_inp_1_1: .word 0x949c19ed
test_473_inp_1_2: .word 0x742b8a16
test_473_inp_2_1: .word 0x80035ec1
test_473_inp_2_2: .word 0xe4679882
test_473_ajit_res_1: .word 0x54a0ad35
test_473_ajit_res_2: .word 0x4ae275e7
test_473_Cmodel_res_1: .word 0x0
test_473_Cmodel_res_2: .word 0x0

test_474_inp_1_1: .word 0xc2de9666
test_474_inp_1_2: .word 0xfa003a8a
test_474_inp_2_1: .word 0x800b0ce3
test_474_inp_2_2: .word 0x55d87f
test_474_ajit_res_1: .word 0x7ff00000
test_474_ajit_res_2: .word 0x0
test_474_Cmodel_res_1: .word 0x0
test_474_Cmodel_res_2: .word 0x0

test_475_inp_1_1: .word 0xed439db7
test_475_inp_1_2: .word 0xea5e0ad7
test_475_inp_2_1: .word 0x80032c98
test_475_inp_2_2: .word 0x1556e302
test_475_ajit_res_1: .word 0x7ff00000
test_475_ajit_res_2: .word 0x0
test_475_Cmodel_res_1: .word 0x0
test_475_Cmodel_res_2: .word 0x0

test_476_inp_1_1: .word 0x5cba89d2
test_476_inp_1_2: .word 0xb49213eb
test_476_inp_2_1: .word 0x800730fb
test_476_inp_2_2: .word 0x2d1aad0c
test_476_ajit_res_1: .word 0xfff00000
test_476_ajit_res_2: .word 0x0
test_476_Cmodel_res_1: .word 0x0
test_476_Cmodel_res_2: .word 0x0

test_477_inp_1_1: .word 0xe59663da
test_477_inp_1_2: .word 0x69566f7b
test_477_inp_2_1: .word 0x80047f4d
test_477_inp_2_2: .word 0xbf3a7d65
test_477_ajit_res_1: .word 0x7ff00000
test_477_ajit_res_2: .word 0x0
test_477_Cmodel_res_1: .word 0x0
test_477_Cmodel_res_2: .word 0x0

test_478_inp_1_1: .word 0xd7d6af4d
test_478_inp_1_2: .word 0x9eb65f03
test_478_inp_2_1: .word 0x800fa55b
test_478_inp_2_2: .word 0x4506937d
test_478_ajit_res_1: .word 0x7ff00000
test_478_ajit_res_2: .word 0x0
test_478_Cmodel_res_1: .word 0x0
test_478_Cmodel_res_2: .word 0x0

test_479_inp_1_1: .word 0xbcfa03fd
test_479_inp_1_2: .word 0x6349300e
test_479_inp_2_1: .word 0x800a7f4f
test_479_inp_2_2: .word 0xae1e61ee
test_479_ajit_res_1: .word 0x7ce3d394
test_479_ajit_res_2: .word 0x160c8b59
test_479_Cmodel_res_1: .word 0x0
test_479_Cmodel_res_2: .word 0x0

test_480_inp_1_1: .word 0x4e46419c
test_480_inp_1_2: .word 0x7959f9a3
test_480_inp_2_1: .word 0x800d74e8
test_480_inp_2_2: .word 0xadc14290
test_480_ajit_res_1: .word 0xfff00000
test_480_ajit_res_2: .word 0x0
test_480_Cmodel_res_1: .word 0x0
test_480_Cmodel_res_2: .word 0x0

test_481_inp_1_1: .word 0x566e430e
test_481_inp_1_2: .word 0xc8b127fe
test_481_inp_2_1: .word 0x800a3e00
test_481_inp_2_2: .word 0x29f47a31
test_481_ajit_res_1: .word 0xfff00000
test_481_ajit_res_2: .word 0x0
test_481_Cmodel_res_1: .word 0x0
test_481_Cmodel_res_2: .word 0x0

test_482_inp_1_1: .word 0xefc4be3f
test_482_inp_1_2: .word 0x7a57d5b8
test_482_inp_2_1: .word 0x800d8015
test_482_inp_2_2: .word 0x43c71413
test_482_ajit_res_1: .word 0x7ff00000
test_482_ajit_res_2: .word 0x0
test_482_Cmodel_res_1: .word 0x0
test_482_Cmodel_res_2: .word 0x0

test_483_inp_1_1: .word 0xefd05006
test_483_inp_1_2: .word 0x6fbfb90e
test_483_inp_2_1: .word 0x800fcb94
test_483_inp_2_2: .word 0xf05745fc
test_483_ajit_res_1: .word 0x7ff00000
test_483_ajit_res_2: .word 0x0
test_483_Cmodel_res_1: .word 0x0
test_483_Cmodel_res_2: .word 0x0

test_484_inp_1_1: .word 0xd15cc1c6
test_484_inp_1_2: .word 0xe25a879f
test_484_inp_2_1: .word 0x800b862e
test_484_inp_2_2: .word 0xc36c3550
test_484_ajit_res_1: .word 0x7ff00000
test_484_ajit_res_2: .word 0x0
test_484_Cmodel_res_1: .word 0x0
test_484_Cmodel_res_2: .word 0x0

test_485_inp_1_1: .word 0xf49eb00e
test_485_inp_1_2: .word 0x3f4f94a
test_485_inp_2_1: .word 0x800ab558
test_485_inp_2_2: .word 0x79940238
test_485_ajit_res_1: .word 0x7ff00000
test_485_ajit_res_2: .word 0x0
test_485_Cmodel_res_1: .word 0x0
test_485_Cmodel_res_2: .word 0x0

test_486_inp_1_1: .word 0x550376f1
test_486_inp_1_2: .word 0xd9631b2d
test_486_inp_2_1: .word 0x8006f5a3
test_486_inp_2_2: .word 0x6dc4b65b
test_486_ajit_res_1: .word 0xfff00000
test_486_ajit_res_2: .word 0x0
test_486_Cmodel_res_1: .word 0x0
test_486_Cmodel_res_2: .word 0x0

test_487_inp_1_1: .word 0x4fea1bae
test_487_inp_1_2: .word 0x242d7ba4
test_487_inp_2_1: .word 0x800d580b
test_487_inp_2_2: .word 0x4ce94853
test_487_ajit_res_1: .word 0xfff00000
test_487_ajit_res_2: .word 0x0
test_487_Cmodel_res_1: .word 0x0
test_487_Cmodel_res_2: .word 0x0

test_488_inp_1_1: .word 0xe4cc032d
test_488_inp_1_2: .word 0xec41531f
test_488_inp_2_1: .word 0x8001f685
test_488_inp_2_2: .word 0x615cf679
test_488_ajit_res_1: .word 0x7ff00000
test_488_ajit_res_2: .word 0x0
test_488_Cmodel_res_1: .word 0x0
test_488_Cmodel_res_2: .word 0x0

test_489_inp_1_1: .word 0xaa6dd9d4
test_489_inp_1_2: .word 0x382fa976
test_489_inp_2_1: .word 0x800d2d5a
test_489_inp_2_2: .word 0xb9d36ba4
test_489_ajit_res_1: .word 0x6a521f6f
test_489_ajit_res_2: .word 0xe9df7db2
test_489_Cmodel_res_1: .word 0x0
test_489_Cmodel_res_2: .word 0x0

test_490_inp_1_1: .word 0xc1471a32
test_490_inp_1_2: .word 0x320209fb
test_490_inp_2_1: .word 0x8000717c
test_490_inp_2_2: .word 0xb18b1328
test_490_ajit_res_1: .word 0x7ff00000
test_490_ajit_res_2: .word 0x0
test_490_Cmodel_res_1: .word 0x0
test_490_Cmodel_res_2: .word 0x0

test_491_inp_1_1: .word 0xb6c69529
test_491_inp_1_2: .word 0x154b6710
test_491_inp_2_1: .word 0x8005825b
test_491_inp_2_2: .word 0x12e635de
test_491_ajit_res_1: .word 0x76c06575
test_491_ajit_res_2: .word 0x1de5b336
test_491_Cmodel_res_1: .word 0x0
test_491_Cmodel_res_2: .word 0x0

test_492_inp_1_1: .word 0x14ff99d1
test_492_inp_1_2: .word 0xa8d75de9
test_492_inp_2_1: .word 0x800f8c4b
test_492_inp_2_2: .word 0x87c8a912
test_492_ajit_res_1: .word 0xd4e0427e
test_492_ajit_res_2: .word 0x254de165
test_492_Cmodel_res_1: .word 0x0
test_492_Cmodel_res_2: .word 0x0

test_493_inp_1_1: .word 0xd1b61a31
test_493_inp_1_2: .word 0x9fb54881
test_493_inp_2_1: .word 0x800cb804
test_493_inp_2_2: .word 0xfc682250
test_493_ajit_res_1: .word 0x7ff00000
test_493_ajit_res_2: .word 0x0
test_493_Cmodel_res_1: .word 0x0
test_493_Cmodel_res_2: .word 0x0

test_494_inp_1_1: .word 0xf0084fd9
test_494_inp_1_2: .word 0x7e5e97d8
test_494_inp_2_1: .word 0x8005952b
test_494_inp_2_2: .word 0x3012dcf7
test_494_ajit_res_1: .word 0x7ff00000
test_494_ajit_res_2: .word 0x0
test_494_Cmodel_res_1: .word 0x0
test_494_Cmodel_res_2: .word 0x0

test_495_inp_1_1: .word 0x58e1e9c9
test_495_inp_1_2: .word 0xacb57755
test_495_inp_2_1: .word 0x800c1551
test_495_inp_2_2: .word 0x6dad68fb
test_495_ajit_res_1: .word 0xfff00000
test_495_ajit_res_2: .word 0x0
test_495_Cmodel_res_1: .word 0x0
test_495_Cmodel_res_2: .word 0x0

test_496_inp_1_1: .word 0x66d2fae4
test_496_inp_1_2: .word 0x3bb787ea
test_496_inp_2_1: .word 0x800ebcd1
test_496_inp_2_2: .word 0x4a165265
test_496_ajit_res_1: .word 0xfff00000
test_496_ajit_res_2: .word 0x0
test_496_Cmodel_res_1: .word 0x0
test_496_Cmodel_res_2: .word 0x0

test_497_inp_1_1: .word 0xe7dc3960
test_497_inp_1_2: .word 0x93e93cf4
test_497_inp_2_1: .word 0x8006d575
test_497_inp_2_2: .word 0x2805538d
test_497_ajit_res_1: .word 0x7ff00000
test_497_ajit_res_2: .word 0x0
test_497_Cmodel_res_1: .word 0x0
test_497_Cmodel_res_2: .word 0x0

test_498_inp_1_1: .word 0x59a6cb5b
test_498_inp_1_2: .word 0x4ce888de
test_498_inp_2_1: .word 0x800b9b12
test_498_inp_2_2: .word 0x8dd6ae4f
test_498_ajit_res_1: .word 0xfff00000
test_498_ajit_res_2: .word 0x0
test_498_Cmodel_res_1: .word 0x0
test_498_Cmodel_res_2: .word 0x0

test_499_inp_1_1: .word 0x69139ebe
test_499_inp_1_2: .word 0xe874848f
test_499_inp_2_1: .word 0x800ffb1e
test_499_inp_2_2: .word 0x4498ae46
test_499_ajit_res_1: .word 0xfff00000
test_499_ajit_res_2: .word 0x0
test_499_Cmodel_res_1: .word 0x0
test_499_Cmodel_res_2: .word 0x0

test_500_inp_1_1: .word 0xbaae38cd
test_500_inp_1_2: .word 0x99dc03da
test_500_inp_2_1: .word 0x800f0fc9
test_500_inp_2_2: .word 0xef2e0d5d
test_500_ajit_res_1: .word 0x7a900d66
test_500_ajit_res_2: .word 0x5566cc9
test_500_Cmodel_res_1: .word 0x0
test_500_Cmodel_res_2: .word 0x0

test_501_inp_1_1: .word 0xd55834c8
test_501_inp_1_2: .word 0xcc486659
test_501_inp_2_1: .word 0x8000291f
test_501_inp_2_2: .word 0xc2a840d5
test_501_ajit_res_1: .word 0x7ff00000
test_501_ajit_res_2: .word 0x0
test_501_Cmodel_res_1: .word 0x0
test_501_Cmodel_res_2: .word 0x0

test_502_inp_1_1: .word 0x7ad7cafe
test_502_inp_1_2: .word 0x4794bb3f
test_502_inp_2_1: .word 0x800e80ad
test_502_inp_2_2: .word 0xb240bd89
test_502_ajit_res_1: .word 0xfff00000
test_502_ajit_res_2: .word 0x0
test_502_Cmodel_res_1: .word 0x0
test_502_Cmodel_res_2: .word 0x0

test_503_inp_1_1: .word 0xf7898421
test_503_inp_1_2: .word 0xd7d8a353
test_503_inp_2_1: .word 0x800d49cc
test_503_inp_2_2: .word 0x3b9fa6d5
test_503_ajit_res_1: .word 0x7ff00000
test_503_ajit_res_2: .word 0x0
test_503_Cmodel_res_1: .word 0x0
test_503_Cmodel_res_2: .word 0x0

test_504_inp_1_1: .word 0x75afae83
test_504_inp_1_2: .word 0xe2a93231
test_504_inp_2_1: .word 0x8009ffbe
test_504_inp_2_2: .word 0xf14ccc15
test_504_ajit_res_1: .word 0xfff00000
test_504_ajit_res_2: .word 0x0
test_504_Cmodel_res_1: .word 0x0
test_504_Cmodel_res_2: .word 0x0

test_505_inp_1_1: .word 0x60c984e6
test_505_inp_1_2: .word 0x8894623a
test_505_inp_2_1: .word 0x800a26ea
test_505_inp_2_2: .word 0xe426847e
test_505_ajit_res_1: .word 0xfff00000
test_505_ajit_res_2: .word 0x0
test_505_Cmodel_res_1: .word 0x0
test_505_Cmodel_res_2: .word 0x0

test_506_inp_1_1: .word 0x791e0516
test_506_inp_1_2: .word 0x196bb36d
test_506_inp_2_1: .word 0x80018c07
test_506_inp_2_2: .word 0x274e1f4b
test_506_ajit_res_1: .word 0xfff00000
test_506_ajit_res_2: .word 0x0
test_506_Cmodel_res_1: .word 0x0
test_506_Cmodel_res_2: .word 0x0

test_507_inp_1_1: .word 0x12b75ad1
test_507_inp_1_2: .word 0x72a6f496
test_507_inp_2_1: .word 0x8007e0b4
test_507_inp_2_2: .word 0x1e925cff
test_507_ajit_res_1: .word 0xd2a7b799
test_507_ajit_res_2: .word 0xdc706afb
test_507_Cmodel_res_1: .word 0x0
test_507_Cmodel_res_2: .word 0x0

test_508_inp_1_1: .word 0x4e35e15
test_508_inp_1_2: .word 0x758dd149
test_508_inp_2_1: .word 0x4bf32
test_508_inp_2_2: .word 0xf76db8ab
test_508_ajit_res_1: .word 0x44e051fa
test_508_ajit_res_2: .word 0xf4394282
test_508_Cmodel_res_1: .word 0x0
test_508_Cmodel_res_2: .word 0x0

test_509_inp_1_1: .word 0xa261a521
test_509_inp_1_2: .word 0x912f9acc
test_509_inp_2_1: .word 0x800cc94f
test_509_inp_2_2: .word 0x8740f6f9
test_509_ajit_res_1: .word 0x6246146e
test_509_ajit_res_2: .word 0xd6f7ab12
test_509_Cmodel_res_1: .word 0x0
test_509_Cmodel_res_2: .word 0x0

test_510_inp_1_1: .word 0x9424ee29
test_510_inp_1_2: .word 0x3189298d
test_510_inp_2_1: .word 0x242ab
test_510_inp_2_2: .word 0xd5adf89e
test_510_ajit_res_1: .word 0xd43284d2
test_510_ajit_res_2: .word 0xea562c42
test_510_Cmodel_res_1: .word 0x0
test_510_Cmodel_res_2: .word 0x0

test_511_inp_1_1: .word 0x5a1fdf68
test_511_inp_1_2: .word 0xdfe9dc61
test_511_inp_2_1: .word 0x8008be46
test_511_inp_2_2: .word 0xa09f3799
test_511_ajit_res_1: .word 0xfff00000
test_511_ajit_res_2: .word 0x0
test_511_Cmodel_res_1: .word 0x0
test_511_Cmodel_res_2: .word 0x0

test_512_inp_1_1: .word 0x7959ac16
test_512_inp_1_2: .word 0x7efcfba9
test_512_inp_2_1: .word 0x800e319b
test_512_inp_2_2: .word 0xe276c81e
test_512_ajit_res_1: .word 0xfff00000
test_512_ajit_res_2: .word 0x0
test_512_Cmodel_res_1: .word 0x0
test_512_Cmodel_res_2: .word 0x0

test_513_inp_1_1: .word 0x418354cc
test_513_inp_1_2: .word 0x40989e4a
test_513_inp_2_1: .word 0x80013288
test_513_inp_2_2: .word 0x161b7df6
test_513_ajit_res_1: .word 0xfff00000
test_513_ajit_res_2: .word 0x0
test_513_Cmodel_res_1: .word 0x0
test_513_Cmodel_res_2: .word 0x0

test_514_inp_1_1: .word 0x49a3589a
test_514_inp_1_2: .word 0xdbe46c20
test_514_inp_2_1: .word 0x80065678
test_514_inp_2_2: .word 0xc33cacf8
test_514_ajit_res_1: .word 0xfff00000
test_514_ajit_res_2: .word 0x0
test_514_Cmodel_res_1: .word 0x0
test_514_Cmodel_res_2: .word 0x0

test_515_inp_1_1: .word 0xe38644f8
test_515_inp_1_2: .word 0xb810ba36
test_515_inp_2_1: .word 0x8005d54c
test_515_inp_2_2: .word 0xf78cd6c2
test_515_ajit_res_1: .word 0x7ff00000
test_515_ajit_res_2: .word 0x0
test_515_Cmodel_res_1: .word 0x0
test_515_Cmodel_res_2: .word 0x0

test_516_inp_1_1: .word 0x429c11be
test_516_inp_1_2: .word 0x5ab3715c
test_516_inp_2_1: .word 0x800144be
test_516_inp_2_2: .word 0x658dc0be
test_516_ajit_res_1: .word 0xfff00000
test_516_ajit_res_2: .word 0x0
test_516_Cmodel_res_1: .word 0x0
test_516_Cmodel_res_2: .word 0x0

test_517_inp_1_1: .word 0x50b2e188
test_517_inp_1_2: .word 0x566501
test_517_inp_2_1: .word 0x8009749e
test_517_inp_2_2: .word 0x9a79a98b
test_517_ajit_res_1: .word 0xfff00000
test_517_ajit_res_2: .word 0x0
test_517_Cmodel_res_1: .word 0x0
test_517_Cmodel_res_2: .word 0x0

test_518_inp_1_1: .word 0xf35bb15a
test_518_inp_1_2: .word 0x3e9b12a8
test_518_inp_2_1: .word 0x80028b8b
test_518_inp_2_2: .word 0x536d8e8d
test_518_ajit_res_1: .word 0x7ff00000
test_518_ajit_res_2: .word 0x0
test_518_Cmodel_res_1: .word 0x0
test_518_Cmodel_res_2: .word 0x0

test_519_inp_1_1: .word 0x424473f5
test_519_inp_1_2: .word 0xac31d184
test_519_inp_2_1: .word 0x800c51a5
test_519_inp_2_2: .word 0xd7635327
test_519_ajit_res_1: .word 0xfff00000
test_519_ajit_res_2: .word 0x0
test_519_Cmodel_res_1: .word 0x0
test_519_Cmodel_res_2: .word 0x0

test_520_inp_1_1: .word 0xee8b78fb
test_520_inp_1_2: .word 0x3ad65599
test_520_inp_2_1: .word 0x800a5095
test_520_inp_2_2: .word 0xcd61bf72
test_520_ajit_res_1: .word 0x7ff00000
test_520_ajit_res_2: .word 0x0
test_520_Cmodel_res_1: .word 0x0
test_520_Cmodel_res_2: .word 0x0

test_521_inp_1_1: .word 0x44ae09f8
test_521_inp_1_2: .word 0xbf4aca09
test_521_inp_2_1: .word 0x8001b7a2
test_521_inp_2_2: .word 0x3e7dfddd
test_521_ajit_res_1: .word 0xfff00000
test_521_ajit_res_2: .word 0x0
test_521_Cmodel_res_1: .word 0x0
test_521_Cmodel_res_2: .word 0x0

test_522_inp_1_1: .word 0x4c01094d
test_522_inp_1_2: .word 0xfe51abd5
test_522_inp_2_1: .word 0x80076e90
test_522_inp_2_2: .word 0x7f395dc2
test_522_ajit_res_1: .word 0xfff00000
test_522_ajit_res_2: .word 0x0
test_522_Cmodel_res_1: .word 0x0
test_522_Cmodel_res_2: .word 0x0

test_523_inp_1_1: .word 0x5cf8033e
test_523_inp_1_2: .word 0xd38d2b55
test_523_inp_2_1: .word 0x800d36e9
test_523_inp_2_2: .word 0x608c4443
test_523_ajit_res_1: .word 0xfff00000
test_523_ajit_res_2: .word 0x0
test_523_Cmodel_res_1: .word 0x0
test_523_Cmodel_res_2: .word 0x0

test_524_inp_1_1: .word 0xe6684cc8
test_524_inp_1_2: .word 0x2b6dca93
test_524_inp_2_1: .word 0x80031901
test_524_inp_2_2: .word 0x7297d5c6
test_524_ajit_res_1: .word 0x7ff00000
test_524_ajit_res_2: .word 0x0
test_524_Cmodel_res_1: .word 0x0
test_524_Cmodel_res_2: .word 0x0

test_525_inp_1_1: .word 0xca815b85
test_525_inp_1_2: .word 0x2871dddf
test_525_inp_2_1: .word 0x800e16ad
test_525_inp_2_2: .word 0x56a5a9a4
test_525_ajit_res_1: .word 0x7ff00000
test_525_ajit_res_2: .word 0x0
test_525_Cmodel_res_1: .word 0x0
test_525_Cmodel_res_2: .word 0x0

test_526_inp_1_1: .word 0x19abd69a
test_526_inp_1_2: .word 0x7e8b6620
test_526_inp_2_1: .word 0x800d60ae
test_526_inp_2_2: .word 0x75b3f8ec
test_526_ajit_res_1: .word 0xd990a5cb
test_526_ajit_res_2: .word 0x9563375
test_526_Cmodel_res_1: .word 0x0
test_526_Cmodel_res_2: .word 0x0

test_527_inp_1_1: .word 0xb01b14a0
test_527_inp_1_2: .word 0x1b616c99
test_527_inp_2_1: .word 0x800d54dc
test_527_inp_2_2: .word 0xfe9fa800
test_527_ajit_res_1: .word 0x70004025
test_527_ajit_res_2: .word 0xeea4a07a
test_527_Cmodel_res_1: .word 0x0
test_527_Cmodel_res_2: .word 0x0

test_528_inp_1_1: .word 0xd1e6f086
test_528_inp_1_2: .word 0x2c3b8d83
test_528_inp_2_1: .word 0x800f670a
test_528_inp_2_2: .word 0xab80fa58
test_528_ajit_res_1: .word 0x7ff00000
test_528_ajit_res_2: .word 0x0
test_528_Cmodel_res_1: .word 0x0
test_528_Cmodel_res_2: .word 0x0

test_529_inp_1_1: .word 0x73f50cae
test_529_inp_1_2: .word 0xcc1253bf
test_529_inp_2_1: .word 0x8009aa54
test_529_inp_2_2: .word 0x2ed978d8
test_529_ajit_res_1: .word 0xfff00000
test_529_ajit_res_2: .word 0x0
test_529_Cmodel_res_1: .word 0x0
test_529_Cmodel_res_2: .word 0x0

test_530_inp_1_1: .word 0x6f51b57c
test_530_inp_1_2: .word 0x9c4430e5
test_530_inp_2_1: .word 0x800e3e61
test_530_inp_2_2: .word 0xb1e421c4
test_530_ajit_res_1: .word 0xfff00000
test_530_ajit_res_2: .word 0x0
test_530_Cmodel_res_1: .word 0x0
test_530_Cmodel_res_2: .word 0x0

test_531_inp_1_1: .word 0xd15c10ab
test_531_inp_1_2: .word 0xd63ed468
test_531_inp_2_1: .word 0x800e51ed
test_531_inp_2_2: .word 0xb32ab3c0
test_531_ajit_res_1: .word 0x7ff00000
test_531_ajit_res_2: .word 0x0
test_531_Cmodel_res_1: .word 0x0
test_531_Cmodel_res_2: .word 0x0

test_532_inp_1_1: .word 0x67823d1c
test_532_inp_1_2: .word 0xd89890e5
test_532_inp_2_1: .word 0x80064f61
test_532_inp_2_2: .word 0xa4193884
test_532_ajit_res_1: .word 0xfff00000
test_532_ajit_res_2: .word 0x0
test_532_Cmodel_res_1: .word 0x0
test_532_Cmodel_res_2: .word 0x0

test_533_inp_1_1: .word 0x7dac3dd0
test_533_inp_1_2: .word 0xb2163de2
test_533_inp_2_1: .word 0x8008a547
test_533_inp_2_2: .word 0x3732919
test_533_ajit_res_1: .word 0xfff00000
test_533_ajit_res_2: .word 0x0
test_533_Cmodel_res_1: .word 0x0
test_533_Cmodel_res_2: .word 0x0

test_534_inp_1_1: .word 0x66ca4c1d
test_534_inp_1_2: .word 0x78d53274
test_534_inp_2_1: .word 0x8004d28c
test_534_inp_2_2: .word 0xdb068510
test_534_ajit_res_1: .word 0xfff00000
test_534_ajit_res_2: .word 0x0
test_534_Cmodel_res_1: .word 0x0
test_534_Cmodel_res_2: .word 0x0

test_535_inp_1_1: .word 0x7b262fbc
test_535_inp_1_2: .word 0xff85c676
test_535_inp_2_1: .word 0x8005aca7
test_535_inp_2_2: .word 0xff31907a
test_535_ajit_res_1: .word 0xfff00000
test_535_ajit_res_2: .word 0x0
test_535_Cmodel_res_1: .word 0x0
test_535_Cmodel_res_2: .word 0x0

test_536_inp_1_1: .word 0xdc09de42
test_536_inp_1_2: .word 0x64c6afba
test_536_inp_2_1: .word 0x80001958
test_536_inp_2_2: .word 0x1c998c65
test_536_ajit_res_1: .word 0x7ff00000
test_536_ajit_res_2: .word 0x0
test_536_Cmodel_res_1: .word 0x0
test_536_Cmodel_res_2: .word 0x0

test_537_inp_1_1: .word 0xe21234a5
test_537_inp_1_2: .word 0x9d3f4371
test_537_inp_2_1: .word 0x8007697b
test_537_inp_2_2: .word 0xf2d5c1b7
test_537_ajit_res_1: .word 0x7ff00000
test_537_ajit_res_2: .word 0x0
test_537_Cmodel_res_1: .word 0x0
test_537_Cmodel_res_2: .word 0x0

test_538_inp_1_1: .word 0x5dce1e9c
test_538_inp_1_2: .word 0x405b7c46
test_538_inp_2_1: .word 0x8005aea2
test_538_inp_2_2: .word 0x37f01b3e
test_538_ajit_res_1: .word 0xfff00000
test_538_ajit_res_2: .word 0x0
test_538_Cmodel_res_1: .word 0x0
test_538_Cmodel_res_2: .word 0x0

test_539_inp_1_1: .word 0xf27f9879
test_539_inp_1_2: .word 0x3e8c233e
test_539_inp_2_1: .word 0x800d89eb
test_539_inp_2_2: .word 0x826e34f8
test_539_ajit_res_1: .word 0x7ff00000
test_539_ajit_res_2: .word 0x0
test_539_Cmodel_res_1: .word 0x0
test_539_Cmodel_res_2: .word 0x0

test_540_inp_1_1: .word 0x5a3c26f2
test_540_inp_1_2: .word 0xf5d51c19
test_540_inp_2_1: .word 0x800e314d
test_540_inp_2_2: .word 0xe6389061
test_540_ajit_res_1: .word 0xfff00000
test_540_ajit_res_2: .word 0x0
test_540_Cmodel_res_1: .word 0x0
test_540_Cmodel_res_2: .word 0x0

test_541_inp_1_1: .word 0x7f90961b
test_541_inp_1_2: .word 0x260904f3
test_541_inp_2_1: .word 0x8006300b
test_541_inp_2_2: .word 0x26ee4a3a
test_541_ajit_res_1: .word 0xfff00000
test_541_ajit_res_2: .word 0x0
test_541_Cmodel_res_1: .word 0x0
test_541_Cmodel_res_2: .word 0x0

test_542_inp_1_1: .word 0xf460f1f6
test_542_inp_1_2: .word 0x7cd5a601
test_542_inp_2_1: .word 0x800aa11b
test_542_inp_2_2: .word 0x4b9fad0d
test_542_ajit_res_1: .word 0x7ff00000
test_542_ajit_res_2: .word 0x0
test_542_Cmodel_res_1: .word 0x0
test_542_Cmodel_res_2: .word 0x0

test_543_inp_1_1: .word 0x63cb9568
test_543_inp_1_2: .word 0xb9220c35
test_543_inp_2_1: .word 0x80048de3
test_543_inp_2_2: .word 0xab8fe56d
test_543_ajit_res_1: .word 0xfff00000
test_543_ajit_res_2: .word 0x0
test_543_Cmodel_res_1: .word 0x0
test_543_Cmodel_res_2: .word 0x0

test_544_inp_1_1: .word 0x6013c7fa
test_544_inp_1_2: .word 0xc4ce073e
test_544_inp_2_1: .word 0x8006c21e
test_544_inp_2_2: .word 0xeb4194b0
test_544_ajit_res_1: .word 0xfff00000
test_544_ajit_res_2: .word 0x0
test_544_Cmodel_res_1: .word 0x0
test_544_Cmodel_res_2: .word 0x0

test_545_inp_1_1: .word 0x5e1caddb
test_545_inp_1_2: .word 0xf27151ae
test_545_inp_2_1: .word 0x80057bda
test_545_inp_2_2: .word 0xc2ee188d
test_545_ajit_res_1: .word 0xfff00000
test_545_ajit_res_2: .word 0x0
test_545_Cmodel_res_1: .word 0x0
test_545_Cmodel_res_2: .word 0x0

test_546_inp_1_1: .word 0x6390f522
test_546_inp_1_2: .word 0x7d312a5b
test_546_inp_2_1: .word 0x800c7264
test_546_inp_2_2: .word 0x2d54becf
test_546_ajit_res_1: .word 0xfff00000
test_546_ajit_res_2: .word 0x0
test_546_Cmodel_res_1: .word 0x0
test_546_Cmodel_res_2: .word 0x0

test_547_inp_1_1: .word 0x758b2b41
test_547_inp_1_2: .word 0x8612c00b
test_547_inp_2_1: .word 0x800b6eeb
test_547_inp_2_2: .word 0xd739874b
test_547_ajit_res_1: .word 0xfff00000
test_547_ajit_res_2: .word 0x0
test_547_Cmodel_res_1: .word 0x0
test_547_Cmodel_res_2: .word 0x0

test_548_inp_1_1: .word 0x68241c86
test_548_inp_1_2: .word 0x4dd4bc17
test_548_inp_2_1: .word 0x800efb53
test_548_inp_2_2: .word 0x42bcf0af
test_548_ajit_res_1: .word 0xfff00000
test_548_ajit_res_2: .word 0x0
test_548_Cmodel_res_1: .word 0x0
test_548_Cmodel_res_2: .word 0x0

test_549_inp_1_1: .word 0x47bb77ad
test_549_inp_1_2: .word 0xacfb398b
test_549_inp_2_1: .word 0x8001030d
test_549_inp_2_2: .word 0x342dcd38
test_549_ajit_res_1: .word 0xfff00000
test_549_ajit_res_2: .word 0x0
test_549_Cmodel_res_1: .word 0x0
test_549_Cmodel_res_2: .word 0x0

test_550_inp_1_1: .word 0xdad522c6
test_550_inp_1_2: .word 0xa739bdd4
test_550_inp_2_1: .word 0x800b4a89
test_550_inp_2_2: .word 0xa4fc3baf
test_550_ajit_res_1: .word 0x7ff00000
test_550_ajit_res_2: .word 0x0
test_550_Cmodel_res_1: .word 0x0
test_550_Cmodel_res_2: .word 0x0

test_551_inp_1_1: .word 0xd1197662
test_551_inp_1_2: .word 0x999266aa
test_551_inp_2_1: .word 0x800e66c1
test_551_inp_2_2: .word 0x2523a8e7
test_551_ajit_res_1: .word 0x7ff00000
test_551_ajit_res_2: .word 0x0
test_551_Cmodel_res_1: .word 0x0
test_551_Cmodel_res_2: .word 0x0

test_552_inp_1_1: .word 0x5c6d7209
test_552_inp_1_2: .word 0x7409e33
test_552_inp_2_1: .word 0x8001a71b
test_552_inp_2_2: .word 0x3131f3cf
test_552_ajit_res_1: .word 0xfff00000
test_552_ajit_res_2: .word 0x0
test_552_Cmodel_res_1: .word 0x0
test_552_Cmodel_res_2: .word 0x0

test_553_inp_1_1: .word 0xf645aaa2
test_553_inp_1_2: .word 0xea1f5ff
test_553_inp_2_1: .word 0x8006705c
test_553_inp_2_2: .word 0x8fd629d4
test_553_ajit_res_1: .word 0x7ff00000
test_553_ajit_res_2: .word 0x0
test_553_Cmodel_res_1: .word 0x0
test_553_Cmodel_res_2: .word 0x0

test_554_inp_1_1: .word 0x3e17a2e
test_554_inp_1_2: .word 0xf4b00908
test_554_inp_2_1: .word 0x800ee505
test_554_inp_2_2: .word 0xd24e2b1a
test_554_ajit_res_1: .word 0xc3c2c63a
test_554_ajit_res_2: .word 0x46bb7073
test_554_Cmodel_res_1: .word 0x0
test_554_Cmodel_res_2: .word 0x0

test_555_inp_1_1: .word 0xcabd6de9
test_555_inp_1_2: .word 0xf9d27056
test_555_inp_2_1: .word 0x80027318
test_555_inp_2_2: .word 0x12db0136
test_555_ajit_res_1: .word 0x7ff00000
test_555_ajit_res_2: .word 0x0
test_555_Cmodel_res_1: .word 0x0
test_555_Cmodel_res_2: .word 0x0

test_556_inp_1_1: .word 0x976b0dbd
test_556_inp_1_2: .word 0x16a8f7c1
test_556_inp_2_1: .word 0x800ca6b6
test_556_inp_2_2: .word 0x349c766e
test_556_ajit_res_1: .word 0x57511b7d
test_556_ajit_res_2: .word 0xfeddde4c
test_556_Cmodel_res_1: .word 0x0
test_556_Cmodel_res_2: .word 0x0

test_557_inp_1_1: .word 0xcf2ade15
test_557_inp_1_2: .word 0xc27b241a
test_557_inp_2_1: .word 0x800d91fd
test_557_inp_2_2: .word 0x3a1194d2
test_557_ajit_res_1: .word 0x7ff00000
test_557_ajit_res_2: .word 0x0
test_557_Cmodel_res_1: .word 0x0
test_557_Cmodel_res_2: .word 0x0

test_558_inp_1_1: .word 0x43a8845c
test_558_inp_1_2: .word 0xc2cbb2ef
test_558_inp_2_1: .word 0x800e25c3
test_558_inp_2_2: .word 0x436b7e4a
test_558_ajit_res_1: .word 0xfff00000
test_558_ajit_res_2: .word 0x0
test_558_Cmodel_res_1: .word 0x0
test_558_Cmodel_res_2: .word 0x0

test_559_inp_1_1: .word 0x8d5b26fd
test_559_inp_1_2: .word 0xfb821942
test_559_inp_2_1: .word 0x800ad708
test_559_inp_2_2: .word 0xb83b0df0
test_559_ajit_res_1: .word 0x4d4409e4
test_559_ajit_res_2: .word 0xfb67521d
test_559_Cmodel_res_1: .word 0x0
test_559_Cmodel_res_2: .word 0x0

test_560_inp_1_1: .word 0x7dab2025
test_560_inp_1_2: .word 0xdeb4bb5b
test_560_inp_2_1: .word 0x80059a5c
test_560_inp_2_2: .word 0x669664ed
test_560_ajit_res_1: .word 0xfff00000
test_560_ajit_res_2: .word 0x0
test_560_Cmodel_res_1: .word 0x0
test_560_Cmodel_res_2: .word 0x0

test_561_inp_1_1: .word 0x7db72b3c
test_561_inp_1_2: .word 0x10d6a10e
test_561_inp_2_1: .word 0x80081a89
test_561_inp_2_2: .word 0x96e68fcc
test_561_ajit_res_1: .word 0xfff00000
test_561_ajit_res_2: .word 0x0
test_561_Cmodel_res_1: .word 0x0
test_561_Cmodel_res_2: .word 0x0

test_562_inp_1_1: .word 0xe282191e
test_562_inp_1_2: .word 0xa56fb682
test_562_inp_2_1: .word 0x8002e419
test_562_inp_2_2: .word 0x27c6896f
test_562_ajit_res_1: .word 0x7ff00000
test_562_ajit_res_2: .word 0x0
test_562_Cmodel_res_1: .word 0x0
test_562_Cmodel_res_2: .word 0x0

test_563_inp_1_1: .word 0x78b32b87
test_563_inp_1_2: .word 0xe6ff1990
test_563_inp_2_1: .word 0x80053b7b
test_563_inp_2_2: .word 0xb28083a3
test_563_ajit_res_1: .word 0xfff00000
test_563_ajit_res_2: .word 0x0
test_563_Cmodel_res_1: .word 0x0
test_563_Cmodel_res_2: .word 0x0

test_564_inp_1_1: .word 0xd5222c33
test_564_inp_1_2: .word 0xf5cbe0b8
test_564_inp_2_1: .word 0x800a23b1
test_564_inp_2_2: .word 0x2e3d5979
test_564_ajit_res_1: .word 0x7ff00000
test_564_ajit_res_2: .word 0x0
test_564_Cmodel_res_1: .word 0x0
test_564_Cmodel_res_2: .word 0x0

test_565_inp_1_1: .word 0xea30e5be
test_565_inp_1_2: .word 0x9c773de7
test_565_inp_2_1: .word 0x80020e24
test_565_inp_2_2: .word 0x8f844a5c
test_565_ajit_res_1: .word 0x7ff00000
test_565_ajit_res_2: .word 0x0
test_565_Cmodel_res_1: .word 0x0
test_565_Cmodel_res_2: .word 0x0

test_566_inp_1_1: .word 0xece1fb2f
test_566_inp_1_2: .word 0xaec1c9f8
test_566_inp_2_1: .word 0x8007f748
test_566_inp_2_2: .word 0x1007346b
test_566_ajit_res_1: .word 0x7ff00000
test_566_ajit_res_2: .word 0x0
test_566_Cmodel_res_1: .word 0x0
test_566_Cmodel_res_2: .word 0x0

test_567_inp_1_1: .word 0xd2bf6f4c
test_567_inp_1_2: .word 0xa60d282
test_567_inp_2_1: .word 0x800063fd
test_567_inp_2_2: .word 0xf75ef3a7
test_567_ajit_res_1: .word 0x7ff00000
test_567_ajit_res_2: .word 0x0
test_567_Cmodel_res_1: .word 0x0
test_567_Cmodel_res_2: .word 0x0

test_568_inp_1_1: .word 0x734ae440
test_568_inp_1_2: .word 0xa8ae62ac
test_568_inp_2_1: .word 0x8002e8d3
test_568_inp_2_2: .word 0xe4e01569
test_568_ajit_res_1: .word 0xfff00000
test_568_ajit_res_2: .word 0x0
test_568_Cmodel_res_1: .word 0x0
test_568_Cmodel_res_2: .word 0x0

test_569_inp_1_1: .word 0x85976a04
test_569_inp_1_2: .word 0x69e3fd6f
test_569_inp_2_1: .word 0x800a8433
test_569_inp_2_2: .word 0x64c88155
test_569_ajit_res_1: .word 0x4581cfbe
test_569_ajit_res_2: .word 0x90a5c9be
test_569_Cmodel_res_1: .word 0x0
test_569_Cmodel_res_2: .word 0x0

test_570_inp_1_1: .word 0x8a8c2ba4
test_570_inp_1_2: .word 0x10100b1d
test_570_inp_2_1: .word 0x800de257
test_570_inp_2_2: .word 0xc5c74c4b
test_570_ajit_res_1: .word 0x4a703b52
test_570_ajit_res_2: .word 0x88a7dd82
test_570_Cmodel_res_1: .word 0x0
test_570_Cmodel_res_2: .word 0x0

test_571_inp_1_1: .word 0x434a9dc1
test_571_inp_1_2: .word 0x8c5cb5b3
test_571_inp_2_1: .word 0x800654ac
test_571_inp_2_2: .word 0x8eef0018
test_571_ajit_res_1: .word 0xfff00000
test_571_ajit_res_2: .word 0x0
test_571_Cmodel_res_1: .word 0x0
test_571_Cmodel_res_2: .word 0x0

test_572_inp_1_1: .word 0xa98fdd3b
test_572_inp_1_2: .word 0x8c5cdda8
test_572_inp_2_1: .word 0x800e1265
test_572_inp_2_2: .word 0x6be00e13
test_572_ajit_res_1: .word 0x69721d78
test_572_ajit_res_2: .word 0xe6d7bd8b
test_572_Cmodel_res_1: .word 0x0
test_572_Cmodel_res_2: .word 0x0

test_573_inp_1_1: .word 0x632b34f1
test_573_inp_1_2: .word 0x1695a95a
test_573_inp_2_1: .word 0x8001b5fc
test_573_inp_2_2: .word 0xcde99488
test_573_ajit_res_1: .word 0xfff00000
test_573_ajit_res_2: .word 0x0
test_573_Cmodel_res_1: .word 0x0
test_573_Cmodel_res_2: .word 0x0

test_574_inp_1_1: .word 0x9834bd9d
test_574_inp_1_2: .word 0x7f64ae73
test_574_inp_2_1: .word 0x20eaa
test_574_inp_2_2: .word 0x3ea19bef
test_574_ajit_res_1: .word 0xd84429c4
test_574_ajit_res_2: .word 0xc828ff2f
test_574_Cmodel_res_1: .word 0x0
test_574_Cmodel_res_2: .word 0x0

test_575_inp_1_1: .word 0x7c64dd9f
test_575_inp_1_2: .word 0x61b7ea9e
test_575_inp_2_1: .word 0x800d0071
test_575_inp_2_2: .word 0xa4be2cb
test_575_ajit_res_1: .word 0xfff00000
test_575_ajit_res_2: .word 0x0
test_575_Cmodel_res_1: .word 0x0
test_575_Cmodel_res_2: .word 0x0

test_576_inp_1_1: .word 0x67e9fd6c
test_576_inp_1_2: .word 0xe9a25101
test_576_inp_2_1: .word 0x8004cd12
test_576_inp_2_2: .word 0xf90375e3
test_576_ajit_res_1: .word 0xfff00000
test_576_ajit_res_2: .word 0x0
test_576_Cmodel_res_1: .word 0x0
test_576_Cmodel_res_2: .word 0x0

test_577_inp_1_1: .word 0x90492c38
test_577_inp_1_2: .word 0x3617991f
test_577_inp_2_1: .word 0x800bd7d3
test_577_inp_2_2: .word 0x136411ed
test_577_ajit_res_1: .word 0x50310113
test_577_ajit_res_2: .word 0x62917b99
test_577_Cmodel_res_1: .word 0x0
test_577_Cmodel_res_2: .word 0x0

test_578_inp_1_1: .word 0xc4ee4d61
test_578_inp_1_2: .word 0xc936af0b
test_578_inp_2_1: .word 0x8007d573
test_578_inp_2_2: .word 0x53c46095
test_578_ajit_res_1: .word 0x7ff00000
test_578_ajit_res_2: .word 0x0
test_578_Cmodel_res_1: .word 0x0
test_578_Cmodel_res_2: .word 0x0

test_579_inp_1_1: .word 0xf21daaea
test_579_inp_1_2: .word 0xb4002ace
test_579_inp_2_1: .word 0x800ab5e4
test_579_inp_2_2: .word 0xd60d591b
test_579_ajit_res_1: .word 0x7ff00000
test_579_ajit_res_2: .word 0x0
test_579_Cmodel_res_1: .word 0x0
test_579_Cmodel_res_2: .word 0x0

test_580_inp_1_1: .word 0xeca4e1c5
test_580_inp_1_2: .word 0xf00e13e3
test_580_inp_2_1: .word 0x800a1356
test_580_inp_2_2: .word 0x941e9704
test_580_ajit_res_1: .word 0x7ff00000
test_580_ajit_res_2: .word 0x0
test_580_Cmodel_res_1: .word 0x0
test_580_Cmodel_res_2: .word 0x0

test_581_inp_1_1: .word 0xc5e90e3
test_581_inp_1_2: .word 0xee72b1ba
test_581_inp_2_1: .word 0x1ae9d
test_581_inp_2_2: .word 0x17877a59
test_581_ajit_res_1: .word 0x4c722be6
test_581_ajit_res_2: .word 0x99e04f79
test_581_Cmodel_res_1: .word 0x0
test_581_Cmodel_res_2: .word 0x0

test_582_inp_1_1: .word 0xfb624829
test_582_inp_1_2: .word 0xf1f26299
test_582_inp_2_1: .word 0x80049d4f
test_582_inp_2_2: .word 0x92e2001c
test_582_ajit_res_1: .word 0x7ff00000
test_582_ajit_res_2: .word 0x0
test_582_Cmodel_res_1: .word 0x0
test_582_Cmodel_res_2: .word 0x0

test_583_inp_1_1: .word 0x6d66d5db
test_583_inp_1_2: .word 0x57ddfc9a
test_583_inp_2_1: .word 0x800f5762
test_583_inp_2_2: .word 0xea5821e3
test_583_ajit_res_1: .word 0xfff00000
test_583_ajit_res_2: .word 0x0
test_583_Cmodel_res_1: .word 0x0
test_583_Cmodel_res_2: .word 0x0

test_584_inp_1_1: .word 0xe2cd4393
test_584_inp_1_2: .word 0x52d88f5c
test_584_inp_2_1: .word 0x800df0f1
test_584_inp_2_2: .word 0x1316942
test_584_ajit_res_1: .word 0x7ff00000
test_584_ajit_res_2: .word 0x0
test_584_Cmodel_res_1: .word 0x0
test_584_Cmodel_res_2: .word 0x0

test_585_inp_1_1: .word 0xff28ad10
test_585_inp_1_2: .word 0x88593d9b
test_585_inp_2_1: .word 0x80089808
test_585_inp_2_2: .word 0x8af58920
test_585_ajit_res_1: .word 0x7ff00000
test_585_ajit_res_2: .word 0x0
test_585_Cmodel_res_1: .word 0x0
test_585_Cmodel_res_2: .word 0x0

test_586_inp_1_1: .word 0xe5eb8b78
test_586_inp_1_2: .word 0xa24562e6
test_586_inp_2_1: .word 0x80014a05
test_586_inp_2_2: .word 0x4d4391a3
test_586_ajit_res_1: .word 0x7ff00000
test_586_ajit_res_2: .word 0x0
test_586_Cmodel_res_1: .word 0x0
test_586_Cmodel_res_2: .word 0x0

test_587_inp_1_1: .word 0x2eee6c33
test_587_inp_1_2: .word 0x3bcfd2c5
test_587_inp_2_1: .word 0x67374
test_587_inp_2_2: .word 0xec545c20
test_587_ajit_res_1: .word 0x6ee2dd24
test_587_ajit_res_2: .word 0x5b68681
test_587_Cmodel_res_1: .word 0x0
test_587_Cmodel_res_2: .word 0x0

test_588_inp_1_1: .word 0xe907fffb
test_588_inp_1_2: .word 0x1af3cf3a
test_588_inp_2_1: .word 0x800d3e39
test_588_inp_2_2: .word 0x659aa624
test_588_ajit_res_1: .word 0x7ff00000
test_588_ajit_res_2: .word 0x0
test_588_Cmodel_res_1: .word 0x0
test_588_Cmodel_res_2: .word 0x0

test_589_inp_1_1: .word 0xc8e56160
test_589_inp_1_2: .word 0x9283bbfd
test_589_inp_2_1: .word 0x800de9b9
test_589_inp_2_2: .word 0x43a3e3ca
test_589_ajit_res_1: .word 0x7ff00000
test_589_ajit_res_2: .word 0x0
test_589_Cmodel_res_1: .word 0x0
test_589_Cmodel_res_2: .word 0x0

test_590_inp_1_1: .word 0xe12fe181
test_590_inp_1_2: .word 0xed09fbb5
test_590_inp_2_1: .word 0x8004c42f
test_590_inp_2_2: .word 0xd9dfa502
test_590_ajit_res_1: .word 0x7ff00000
test_590_ajit_res_2: .word 0x0
test_590_Cmodel_res_1: .word 0x0
test_590_Cmodel_res_2: .word 0x0

test_591_inp_1_1: .word 0xc8f9a483
test_591_inp_1_2: .word 0x7b31c2fd
test_591_inp_2_1: .word 0x80040ba3
test_591_inp_2_2: .word 0xf598be38
test_591_ajit_res_1: .word 0x7ff00000
test_591_ajit_res_2: .word 0x0
test_591_Cmodel_res_1: .word 0x0
test_591_Cmodel_res_2: .word 0x0

test_592_inp_1_1: .word 0xda29d275
test_592_inp_1_2: .word 0x89e3466a
test_592_inp_2_1: .word 0x80094857
test_592_inp_2_2: .word 0xc6205a66
test_592_ajit_res_1: .word 0x7ff00000
test_592_ajit_res_2: .word 0x0
test_592_Cmodel_res_1: .word 0x0
test_592_Cmodel_res_2: .word 0x0

test_593_inp_1_1: .word 0x71131c16
test_593_inp_1_2: .word 0xf081256a
test_593_inp_2_1: .word 0x8001528a
test_593_inp_2_2: .word 0xa2c43da0
test_593_ajit_res_1: .word 0xfff00000
test_593_ajit_res_2: .word 0x0
test_593_Cmodel_res_1: .word 0x0
test_593_Cmodel_res_2: .word 0x0

test_594_inp_1_1: .word 0x9e1b5417
test_594_inp_1_2: .word 0xf335d2a0
test_594_inp_2_1: .word 0x800bcec3
test_594_inp_2_2: .word 0x89f91105
test_594_ajit_res_1: .word 0x5e028408
test_594_ajit_res_2: .word 0x64033da6
test_594_Cmodel_res_1: .word 0x0
test_594_Cmodel_res_2: .word 0x0

test_595_inp_1_1: .word 0xd70ac082
test_595_inp_1_2: .word 0x8918fa37
test_595_inp_2_1: .word 0x80010e67
test_595_inp_2_2: .word 0x9974a603
test_595_ajit_res_1: .word 0x7ff00000
test_595_ajit_res_2: .word 0x0
test_595_Cmodel_res_1: .word 0x0
test_595_Cmodel_res_2: .word 0x0

test_596_inp_1_1: .word 0x85e170c6
test_596_inp_1_2: .word 0xfbc86446
test_596_inp_2_1: .word 0xf4dbc
test_596_inp_2_2: .word 0xc2b2250e
test_596_ajit_res_1: .word 0xc5c23bee
test_596_ajit_res_2: .word 0x5830cb05
test_596_Cmodel_res_1: .word 0x0
test_596_Cmodel_res_2: .word 0x0

test_597_inp_1_1: .word 0x475f8f5a
test_597_inp_1_2: .word 0x328d36e2
test_597_inp_2_1: .word 0x800aa66a
test_597_inp_2_2: .word 0x2b67d40f
test_597_ajit_res_1: .word 0xfff00000
test_597_ajit_res_2: .word 0x0
test_597_Cmodel_res_1: .word 0x0
test_597_Cmodel_res_2: .word 0x0

test_598_inp_1_1: .word 0xb6d28dbb
test_598_inp_1_2: .word 0xb3ff1b7b
test_598_inp_2_1: .word 0x800c8051
test_598_inp_2_2: .word 0x6f2b5b8d
test_598_ajit_res_1: .word 0x76b7bf0d
test_598_ajit_res_2: .word 0xe103e9e3
test_598_Cmodel_res_1: .word 0x0
test_598_Cmodel_res_2: .word 0x0

test_599_inp_1_1: .word 0xae1c4751
test_599_inp_1_2: .word 0x2e289859
test_599_inp_2_1: .word 0x9a4e2
test_599_inp_2_2: .word 0xeb0bff29
test_599_ajit_res_1: .word 0xee07752f
test_599_ajit_res_2: .word 0x8ddc0dc5
test_599_Cmodel_res_1: .word 0x0
test_599_Cmodel_res_2: .word 0x0

test_600_inp_1_1: .word 0x3689dcd0
test_600_inp_1_2: .word 0x490a4a29
test_600_inp_2_1: .word 0x800c36c5
test_600_inp_2_2: .word 0xbb5f4fd
test_600_ajit_res_1: .word 0xf670f08f
test_600_ajit_res_2: .word 0x827fa044
test_600_Cmodel_res_1: .word 0x0
test_600_Cmodel_res_2: .word 0x0

test_601_inp_1_1: .word 0xd71ba6ac
test_601_inp_1_2: .word 0x476a9f0c
test_601_inp_2_1: .word 0x80029f59
test_601_inp_2_2: .word 0x84c60932
test_601_ajit_res_1: .word 0x7ff00000
test_601_ajit_res_2: .word 0x0
test_601_Cmodel_res_1: .word 0x0
test_601_Cmodel_res_2: .word 0x0

test_602_inp_1_1: .word 0x85280ffb
test_602_inp_1_2: .word 0x45ff9cc9
test_602_inp_2_1: .word 0xab79e
test_602_inp_2_2: .word 0xdc6a71b0
test_602_ajit_res_1: .word 0xc511f62c
test_602_ajit_res_2: .word 0x4faaac7b
test_602_Cmodel_res_1: .word 0x0
test_602_Cmodel_res_2: .word 0x0

test_603_inp_1_1: .word 0xfa04e9e7
test_603_inp_1_2: .word 0x47b3b82c
test_603_inp_2_1: .word 0x800054bd
test_603_inp_2_2: .word 0xba6f545c
test_603_ajit_res_1: .word 0x7ff00000
test_603_ajit_res_2: .word 0x0
test_603_Cmodel_res_1: .word 0x0
test_603_Cmodel_res_2: .word 0x0

test_604_inp_1_1: .word 0x6be98e34
test_604_inp_1_2: .word 0xcdddbacf
test_604_inp_2_1: .word 0x800b8142
test_604_inp_2_2: .word 0xc085527a
test_604_ajit_res_1: .word 0xfff00000
test_604_ajit_res_2: .word 0x0
test_604_Cmodel_res_1: .word 0x0
test_604_Cmodel_res_2: .word 0x0

test_605_inp_1_1: .word 0x2c852427
test_605_inp_1_2: .word 0x88a896d2
test_605_inp_2_1: .word 0x2814
test_605_inp_2_2: .word 0x99b8337f
test_605_ajit_res_1: .word 0x6cd0e107
test_605_ajit_res_2: .word 0xd88885f5
test_605_Cmodel_res_1: .word 0x0
test_605_Cmodel_res_2: .word 0x0

test_606_inp_1_1: .word 0xf2635c9c
test_606_inp_1_2: .word 0x6b88d6f9
test_606_inp_2_1: .word 0x800e6724
test_606_inp_2_2: .word 0x199d5914
test_606_ajit_res_1: .word 0x7ff00000
test_606_ajit_res_2: .word 0x0
test_606_Cmodel_res_1: .word 0x0
test_606_Cmodel_res_2: .word 0x0

test_607_inp_1_1: .word 0xf90f36cf
test_607_inp_1_2: .word 0xb29233c0
test_607_inp_2_1: .word 0x8000f31b
test_607_inp_2_2: .word 0x4de7a7
test_607_ajit_res_1: .word 0x7ff00000
test_607_ajit_res_2: .word 0x0
test_607_Cmodel_res_1: .word 0x0
test_607_Cmodel_res_2: .word 0x0

test_608_inp_1_1: .word 0x75651ecf
test_608_inp_1_2: .word 0xce5b3f43
test_608_inp_2_1: .word 0x8004df0a
test_608_inp_2_2: .word 0xd31a39fd
test_608_ajit_res_1: .word 0xfff00000
test_608_ajit_res_2: .word 0x0
test_608_Cmodel_res_1: .word 0x0
test_608_Cmodel_res_2: .word 0x0

test_609_inp_1_1: .word 0xd8526616
test_609_inp_1_2: .word 0x53b71448
test_609_inp_2_1: .word 0x80096d80
test_609_inp_2_2: .word 0xa09c6860
test_609_ajit_res_1: .word 0x7ff00000
test_609_ajit_res_2: .word 0x0
test_609_Cmodel_res_1: .word 0x0
test_609_Cmodel_res_2: .word 0x0

test_610_inp_1_1: .word 0x524b9d80
test_610_inp_1_2: .word 0x258f7d17
test_610_inp_2_1: .word 0x800f3d70
test_610_inp_2_2: .word 0x25e3c62d
test_610_ajit_res_1: .word 0xfff00000
test_610_ajit_res_2: .word 0x0
test_610_Cmodel_res_1: .word 0x0
test_610_Cmodel_res_2: .word 0x0

test_611_inp_1_1: .word 0xd268b81a
test_611_inp_1_2: .word 0xfd827936
test_611_inp_2_1: .word 0x800affe6
test_611_inp_2_2: .word 0x749f044
test_611_ajit_res_1: .word 0x7ff00000
test_611_ajit_res_2: .word 0x0
test_611_Cmodel_res_1: .word 0x0
test_611_Cmodel_res_2: .word 0x0

test_612_inp_1_1: .word 0x4ce6827f
test_612_inp_1_2: .word 0x7425a01b
test_612_inp_2_1: .word 0x8004516f
test_612_inp_2_2: .word 0x2c908d9b
test_612_ajit_res_1: .word 0xfff00000
test_612_ajit_res_2: .word 0x0
test_612_Cmodel_res_1: .word 0x0
test_612_Cmodel_res_2: .word 0x0

test_613_inp_1_1: .word 0x4d644d8a
test_613_inp_1_2: .word 0x8560c30b
test_613_inp_2_1: .word 0x8005176b
test_613_inp_2_2: .word 0x90a1a04d
test_613_ajit_res_1: .word 0xfff00000
test_613_ajit_res_2: .word 0x0
test_613_Cmodel_res_1: .word 0x0
test_613_Cmodel_res_2: .word 0x0

test_614_inp_1_1: .word 0x5dcf03c2
test_614_inp_1_2: .word 0x8b0a15ad
test_614_inp_2_1: .word 0x8001205f
test_614_inp_2_2: .word 0x1ba0cac6
test_614_ajit_res_1: .word 0xfff00000
test_614_ajit_res_2: .word 0x0
test_614_Cmodel_res_1: .word 0x0
test_614_Cmodel_res_2: .word 0x0

test_615_inp_1_1: .word 0xc90a1650
test_615_inp_1_2: .word 0x167199e6
test_615_inp_2_1: .word 0x8009a6b8
test_615_inp_2_2: .word 0x9fadc355
test_615_ajit_res_1: .word 0x7ff00000
test_615_ajit_res_2: .word 0x0
test_615_Cmodel_res_1: .word 0x0
test_615_Cmodel_res_2: .word 0x0

test_616_inp_1_1: .word 0xbd99f489
test_616_inp_1_2: .word 0x157ab488
test_616_inp_2_1: .word 0xad952
test_616_inp_2_2: .word 0xc8ae63e1
test_616_ajit_res_1: .word 0xfd8323af
test_616_ajit_res_2: .word 0x4461a20b
test_616_Cmodel_res_1: .word 0x0
test_616_Cmodel_res_2: .word 0x0

test_617_inp_1_1: .word 0xe4b597c7
test_617_inp_1_2: .word 0xb661168f
test_617_inp_2_1: .word 0x8002fcfa
test_617_inp_2_2: .word 0xad5d9762
test_617_ajit_res_1: .word 0x7ff00000
test_617_ajit_res_2: .word 0x0
test_617_Cmodel_res_1: .word 0x0
test_617_Cmodel_res_2: .word 0x0

test_618_inp_1_1: .word 0xc220391c
test_618_inp_1_2: .word 0xa0441112
test_618_inp_2_1: .word 0x8005be0b
test_618_inp_2_2: .word 0x31429db0
test_618_ajit_res_1: .word 0x7ff00000
test_618_ajit_res_2: .word 0x0
test_618_Cmodel_res_1: .word 0x0
test_618_Cmodel_res_2: .word 0x0

test_619_inp_1_1: .word 0x7eae6ee1
test_619_inp_1_2: .word 0x4ba30bda
test_619_inp_2_1: .word 0x8000a201
test_619_inp_2_2: .word 0xf617fb4d
test_619_ajit_res_1: .word 0xfff00000
test_619_ajit_res_2: .word 0x0
test_619_Cmodel_res_1: .word 0x0
test_619_Cmodel_res_2: .word 0x0

test_620_inp_1_1: .word 0x4158b3dc
test_620_inp_1_2: .word 0xeda50c74
test_620_inp_2_1: .word 0x80045153
test_620_inp_2_2: .word 0x2a6bdb6c
test_620_ajit_res_1: .word 0xfff00000
test_620_ajit_res_2: .word 0x0
test_620_Cmodel_res_1: .word 0x0
test_620_Cmodel_res_2: .word 0x0

test_621_inp_1_1: .word 0x72526ec5
test_621_inp_1_2: .word 0x4e1b8258
test_621_inp_2_1: .word 0x8005b6d0
test_621_inp_2_2: .word 0x7494235c
test_621_ajit_res_1: .word 0xfff00000
test_621_ajit_res_2: .word 0x0
test_621_Cmodel_res_1: .word 0x0
test_621_Cmodel_res_2: .word 0x0

test_622_inp_1_1: .word 0x6ade018f
test_622_inp_1_2: .word 0x19629af4
test_622_inp_2_1: .word 0x80062436
test_622_inp_2_2: .word 0xc92a62c1
test_622_ajit_res_1: .word 0xfff00000
test_622_ajit_res_2: .word 0x0
test_622_Cmodel_res_1: .word 0x0
test_622_Cmodel_res_2: .word 0x0

test_623_inp_1_1: .word 0x7abc7303
test_623_inp_1_2: .word 0x9fdec70b
test_623_inp_2_1: .word 0x8006d79a
test_623_inp_2_2: .word 0x73bd845
test_623_ajit_res_1: .word 0xfff00000
test_623_ajit_res_2: .word 0x0
test_623_Cmodel_res_1: .word 0x0
test_623_Cmodel_res_2: .word 0x0

test_624_inp_1_1: .word 0xc2c0bc44
test_624_inp_1_2: .word 0xe56d96a3
test_624_inp_2_1: .word 0x8003ba85
test_624_inp_2_2: .word 0x8f8a854e
test_624_ajit_res_1: .word 0x7ff00000
test_624_ajit_res_2: .word 0x0
test_624_Cmodel_res_1: .word 0x0
test_624_Cmodel_res_2: .word 0x0

test_625_inp_1_1: .word 0xe7de3da8
test_625_inp_1_2: .word 0xd5c958c3
test_625_inp_2_1: .word 0x80044b06
test_625_inp_2_2: .word 0xe8489ab2
test_625_ajit_res_1: .word 0x7ff00000
test_625_ajit_res_2: .word 0x0
test_625_Cmodel_res_1: .word 0x0
test_625_Cmodel_res_2: .word 0x0

test_626_inp_1_1: .word 0x5e3b064d
test_626_inp_1_2: .word 0x61d9b433
test_626_inp_2_1: .word 0x800a38c0
test_626_inp_2_2: .word 0x6cc76b9b
test_626_ajit_res_1: .word 0xfff00000
test_626_ajit_res_2: .word 0x0
test_626_Cmodel_res_1: .word 0x0
test_626_Cmodel_res_2: .word 0x0

test_627_inp_1_1: .word 0xef6e19a6
test_627_inp_1_2: .word 0xf57f5e4b
test_627_inp_2_1: .word 0x800c6b91
test_627_inp_2_2: .word 0xa8e55237
test_627_ajit_res_1: .word 0x7ff00000
test_627_ajit_res_2: .word 0x0
test_627_Cmodel_res_1: .word 0x0
test_627_Cmodel_res_2: .word 0x0

test_628_inp_1_1: .word 0x4206b079
test_628_inp_1_2: .word 0x6be26043
test_628_inp_2_1: .word 0x800fd574
test_628_inp_2_2: .word 0x8523d443
test_628_ajit_res_1: .word 0xfff00000
test_628_ajit_res_2: .word 0x0
test_628_Cmodel_res_1: .word 0x0
test_628_Cmodel_res_2: .word 0x0

test_629_inp_1_1: .word 0xe0de85e4
test_629_inp_1_2: .word 0x70bb1d1e
test_629_inp_2_1: .word 0x800b2599
test_629_inp_2_2: .word 0x2c76eca4
test_629_ajit_res_1: .word 0x7ff00000
test_629_ajit_res_2: .word 0x0
test_629_Cmodel_res_1: .word 0x0
test_629_Cmodel_res_2: .word 0x0

test_630_inp_1_1: .word 0x61d7810a
test_630_inp_1_2: .word 0xd319f9b7
test_630_inp_2_1: .word 0x800b4931
test_630_inp_2_2: .word 0xb0ff4784
test_630_ajit_res_1: .word 0xfff00000
test_630_ajit_res_2: .word 0x0
test_630_Cmodel_res_1: .word 0x0
test_630_Cmodel_res_2: .word 0x0

test_631_inp_1_1: .word 0x693cdd16
test_631_inp_1_2: .word 0xce7b700e
test_631_inp_2_1: .word 0x800b1ea4
test_631_inp_2_2: .word 0x99e6456e
test_631_ajit_res_1: .word 0xfff00000
test_631_ajit_res_2: .word 0x0
test_631_Cmodel_res_1: .word 0x0
test_631_Cmodel_res_2: .word 0x0

test_632_inp_1_1: .word 0x3fb79924
test_632_inp_1_2: .word 0x7a6e2dfe
test_632_inp_2_1: .word 0x8000e919
test_632_inp_2_2: .word 0xf0e44e25
test_632_ajit_res_1: .word 0xffd9ea97
test_632_ajit_res_2: .word 0xd2784045
test_632_Cmodel_res_1: .word 0x0
test_632_Cmodel_res_2: .word 0x0

test_633_inp_1_1: .word 0xd15378af
test_633_inp_1_2: .word 0x7329af98
test_633_inp_2_1: .word 0x8005bf49
test_633_inp_2_2: .word 0xe7d91ac7
test_633_ajit_res_1: .word 0x7ff00000
test_633_ajit_res_2: .word 0x0
test_633_Cmodel_res_1: .word 0x0
test_633_Cmodel_res_2: .word 0x0

test_634_inp_1_1: .word 0xe5aff788
test_634_inp_1_2: .word 0x7522c40
test_634_inp_2_1: .word 0x80014633
test_634_inp_2_2: .word 0xb66f9818
test_634_ajit_res_1: .word 0x7ff00000
test_634_ajit_res_2: .word 0x0
test_634_Cmodel_res_1: .word 0x0
test_634_Cmodel_res_2: .word 0x0

test_635_inp_1_1: .word 0xc852386c
test_635_inp_1_2: .word 0x8446420
test_635_inp_2_1: .word 0x800d9d85
test_635_inp_2_2: .word 0x8419e4e8
test_635_ajit_res_1: .word 0x7ff00000
test_635_ajit_res_2: .word 0x0
test_635_Cmodel_res_1: .word 0x0
test_635_Cmodel_res_2: .word 0x0

test_636_inp_1_1: .word 0xcfdc9012
test_636_inp_1_2: .word 0xabaeb007
test_636_inp_2_1: .word 0x800e1e47
test_636_inp_2_2: .word 0xaa1b0ca7
test_636_ajit_res_1: .word 0x7ff00000
test_636_ajit_res_2: .word 0x0
test_636_Cmodel_res_1: .word 0x0
test_636_Cmodel_res_2: .word 0x0

test_637_inp_1_1: .word 0xd49d45a3
test_637_inp_1_2: .word 0xd9980357
test_637_inp_2_1: .word 0x800a9c6f
test_637_inp_2_2: .word 0xf5630691
test_637_ajit_res_1: .word 0x7ff00000
test_637_ajit_res_2: .word 0x0
test_637_Cmodel_res_1: .word 0x0
test_637_Cmodel_res_2: .word 0x0

test_638_inp_1_1: .word 0xd348665f
test_638_inp_1_2: .word 0x10b4b755
test_638_inp_2_1: .word 0x800ea9e4
test_638_inp_2_2: .word 0x43a4ab7b
test_638_ajit_res_1: .word 0x7ff00000
test_638_ajit_res_2: .word 0x0
test_638_Cmodel_res_1: .word 0x0
test_638_Cmodel_res_2: .word 0x0

test_639_inp_1_1: .word 0xe2352008
test_639_inp_1_2: .word 0x9330117c
test_639_inp_2_1: .word 0x800cc271
test_639_inp_2_2: .word 0x1081ae5e
test_639_ajit_res_1: .word 0x7ff00000
test_639_ajit_res_2: .word 0x0
test_639_Cmodel_res_1: .word 0x0
test_639_Cmodel_res_2: .word 0x0

test_640_inp_1_1: .word 0x6d1e70af
test_640_inp_1_2: .word 0x6ba013f7
test_640_inp_2_1: .word 0x800c34fa
test_640_inp_2_2: .word 0x432d4e10
test_640_ajit_res_1: .word 0xfff00000
test_640_ajit_res_2: .word 0x0
test_640_Cmodel_res_1: .word 0x0
test_640_Cmodel_res_2: .word 0x0

test_641_inp_1_1: .word 0xd6292110
test_641_inp_1_2: .word 0x57cb175a
test_641_inp_2_1: .word 0x8002f32a
test_641_inp_2_2: .word 0xc8a217f4
test_641_ajit_res_1: .word 0x7ff00000
test_641_ajit_res_2: .word 0x0
test_641_Cmodel_res_1: .word 0x0
test_641_Cmodel_res_2: .word 0x0

test_642_inp_1_1: .word 0x65bde777
test_642_inp_1_2: .word 0xcbeec389
test_642_inp_2_1: .word 0x800db747
test_642_inp_2_2: .word 0xbf24dc4e
test_642_ajit_res_1: .word 0xfff00000
test_642_ajit_res_2: .word 0x0
test_642_Cmodel_res_1: .word 0x0
test_642_Cmodel_res_2: .word 0x0

test_643_inp_1_1: .word 0x757658c
test_643_inp_1_2: .word 0xfc2e2bcf
test_643_inp_2_1: .word 0x800b61b7
test_643_inp_2_2: .word 0xe3956458
test_643_ajit_res_1: .word 0xc74071f2
test_643_ajit_res_2: .word 0x72fe30e8
test_643_Cmodel_res_1: .word 0x0
test_643_Cmodel_res_2: .word 0x0

test_644_inp_1_1: .word 0x4ba1b132
test_644_inp_1_2: .word 0xfc09658d
test_644_inp_2_1: .word 0x80018f5d
test_644_inp_2_2: .word 0xdf15b406
test_644_ajit_res_1: .word 0xfff00000
test_644_ajit_res_2: .word 0x0
test_644_Cmodel_res_1: .word 0x0
test_644_Cmodel_res_2: .word 0x0

test_645_inp_1_1: .word 0x73ee9042
test_645_inp_1_2: .word 0xc4e6c120
test_645_inp_2_1: .word 0x800a44b9
test_645_inp_2_2: .word 0x29bf44a2
test_645_ajit_res_1: .word 0xfff00000
test_645_ajit_res_2: .word 0x0
test_645_Cmodel_res_1: .word 0x0
test_645_Cmodel_res_2: .word 0x0

test_646_inp_1_1: .word 0xdf02a4cd
test_646_inp_1_2: .word 0x6e202bd4
test_646_inp_2_1: .word 0x800acc03
test_646_inp_2_2: .word 0x448a1e83
test_646_ajit_res_1: .word 0x7ff00000
test_646_ajit_res_2: .word 0x0
test_646_Cmodel_res_1: .word 0x0
test_646_Cmodel_res_2: .word 0x0

test_647_inp_1_1: .word 0x648b193c
test_647_inp_1_2: .word 0xdab5b7cf
test_647_inp_2_1: .word 0x800eaa47
test_647_inp_2_2: .word 0x2654cf60
test_647_ajit_res_1: .word 0xfff00000
test_647_ajit_res_2: .word 0x0
test_647_Cmodel_res_1: .word 0x0
test_647_Cmodel_res_2: .word 0x0

test_648_inp_1_1: .word 0x5f0476ea
test_648_inp_1_2: .word 0xb3bfb603
test_648_inp_2_1: .word 0x80026d36
test_648_inp_2_2: .word 0x2cab29af
test_648_ajit_res_1: .word 0xfff00000
test_648_ajit_res_2: .word 0x0
test_648_Cmodel_res_1: .word 0x0
test_648_Cmodel_res_2: .word 0x0

test_649_inp_1_1: .word 0xeff95609
test_649_inp_1_2: .word 0x4460729a
test_649_inp_2_1: .word 0x80028f36
test_649_inp_2_2: .word 0xe95954ff
test_649_ajit_res_1: .word 0x7ff00000
test_649_ajit_res_2: .word 0x0
test_649_Cmodel_res_1: .word 0x0
test_649_Cmodel_res_2: .word 0x0

test_650_inp_1_1: .word 0x6193798b
test_650_inp_1_2: .word 0x85fc9360
test_650_inp_2_1: .word 0x8003b259
test_650_inp_2_2: .word 0x1b33b246
test_650_ajit_res_1: .word 0xfff00000
test_650_ajit_res_2: .word 0x0
test_650_Cmodel_res_1: .word 0x0
test_650_Cmodel_res_2: .word 0x0

test_651_inp_1_1: .word 0x620e0240
test_651_inp_1_2: .word 0xe173272b
test_651_inp_2_1: .word 0x80062368
test_651_inp_2_2: .word 0x8fd76ba5
test_651_ajit_res_1: .word 0xfff00000
test_651_ajit_res_2: .word 0x0
test_651_Cmodel_res_1: .word 0x0
test_651_Cmodel_res_2: .word 0x0

test_652_inp_1_1: .word 0xe20089ee
test_652_inp_1_2: .word 0xdb080792
test_652_inp_2_1: .word 0x800ea0b1
test_652_inp_2_2: .word 0xa277b31d
test_652_ajit_res_1: .word 0x7ff00000
test_652_ajit_res_2: .word 0x0
test_652_Cmodel_res_1: .word 0x0
test_652_Cmodel_res_2: .word 0x0

test_653_inp_1_1: .word 0x41495855
test_653_inp_1_2: .word 0xf780018d
test_653_inp_2_1: .word 0x800619d5
test_653_inp_2_2: .word 0x39c2c2ce
test_653_ajit_res_1: .word 0xfff00000
test_653_ajit_res_2: .word 0x0
test_653_Cmodel_res_1: .word 0x0
test_653_Cmodel_res_2: .word 0x0

test_654_inp_1_1: .word 0x69f5b9d0
test_654_inp_1_2: .word 0x12bbfa62
test_654_inp_2_1: .word 0x8002e2a8
test_654_inp_2_2: .word 0xc9005516
test_654_ajit_res_1: .word 0xfff00000
test_654_ajit_res_2: .word 0x0
test_654_Cmodel_res_1: .word 0x0
test_654_Cmodel_res_2: .word 0x0

test_655_inp_1_1: .word 0xadcac8e5
test_655_inp_1_2: .word 0x47207901
test_655_inp_2_1: .word 0xd59e1
test_655_inp_2_2: .word 0xf9f659b3
test_655_ajit_res_1: .word 0xedb00ca9
test_655_ajit_res_2: .word 0x4662a159
test_655_Cmodel_res_1: .word 0x0
test_655_Cmodel_res_2: .word 0x0

test_656_inp_1_1: .word 0xe0452f79
test_656_inp_1_2: .word 0xa56de6e3
test_656_inp_2_1: .word 0x80062ce6
test_656_inp_2_2: .word 0x7a5ee5ee
test_656_ajit_res_1: .word 0x7ff00000
test_656_ajit_res_2: .word 0x0
test_656_Cmodel_res_1: .word 0x0
test_656_Cmodel_res_2: .word 0x0

test_657_inp_1_1: .word 0xc6d587c5
test_657_inp_1_2: .word 0xb7996322
test_657_inp_2_1: .word 0x800886c1
test_657_inp_2_2: .word 0x4402d964
test_657_ajit_res_1: .word 0x7ff00000
test_657_ajit_res_2: .word 0x0
test_657_Cmodel_res_1: .word 0x0
test_657_Cmodel_res_2: .word 0x0

test_658_inp_1_1: .word 0xcb645930
test_658_inp_1_2: .word 0x5290c85d
test_658_inp_2_1: .word 0x800bc9dc
test_658_inp_2_2: .word 0x32165e8d
test_658_ajit_res_1: .word 0x7ff00000
test_658_ajit_res_2: .word 0x0
test_658_Cmodel_res_1: .word 0x0
test_658_Cmodel_res_2: .word 0x0

test_659_inp_1_1: .word 0xe280f8e3
test_659_inp_1_2: .word 0xc48f8592
test_659_inp_2_1: .word 0x800219d9
test_659_inp_2_2: .word 0xac67be19
test_659_ajit_res_1: .word 0x7ff00000
test_659_ajit_res_2: .word 0x0
test_659_Cmodel_res_1: .word 0x0
test_659_Cmodel_res_2: .word 0x0

test_660_inp_1_1: .word 0xee2bdfc7
test_660_inp_1_2: .word 0xcc488ec4
test_660_inp_2_1: .word 0x800c0054
test_660_inp_2_2: .word 0x1d992ed9
test_660_ajit_res_1: .word 0x7ff00000
test_660_ajit_res_2: .word 0x0
test_660_Cmodel_res_1: .word 0x0
test_660_Cmodel_res_2: .word 0x0

test_661_inp_1_1: .word 0xecf3464d
test_661_inp_1_2: .word 0x1c779e21
test_661_inp_2_1: .word 0x800240d1
test_661_inp_2_2: .word 0xdad6d95d
test_661_ajit_res_1: .word 0x7ff00000
test_661_ajit_res_2: .word 0x0
test_661_Cmodel_res_1: .word 0x0
test_661_Cmodel_res_2: .word 0x0

test_662_inp_1_1: .word 0xeb35be8c
test_662_inp_1_2: .word 0xa407966f
test_662_inp_2_1: .word 0x800d7e97
test_662_inp_2_2: .word 0x8b61e283
test_662_ajit_res_1: .word 0x7ff00000
test_662_ajit_res_2: .word 0x0
test_662_Cmodel_res_1: .word 0x0
test_662_Cmodel_res_2: .word 0x0

test_663_inp_1_1: .word 0xa56002d4
test_663_inp_1_2: .word 0x4f2cfb7d
test_663_inp_2_1: .word 0xf99e0
test_663_inp_2_2: .word 0x875ddcb
test_663_ajit_res_1: .word 0xe5406ba3
test_663_ajit_res_2: .word 0x4edb8859
test_663_Cmodel_res_1: .word 0x0
test_663_Cmodel_res_2: .word 0x0

test_664_inp_1_1: .word 0xd938550b
test_664_inp_1_2: .word 0x9e299ef9
test_664_inp_2_1: .word 0x800875d9
test_664_inp_2_2: .word 0x97a55384
test_664_ajit_res_1: .word 0x7ff00000
test_664_ajit_res_2: .word 0x0
test_664_Cmodel_res_1: .word 0x0
test_664_Cmodel_res_2: .word 0x0

test_665_inp_1_1: .word 0x63be9bf1
test_665_inp_1_2: .word 0x7577b342
test_665_inp_2_1: .word 0x800b4c06
test_665_inp_2_2: .word 0xa551cca4
test_665_ajit_res_1: .word 0xfff00000
test_665_ajit_res_2: .word 0x0
test_665_Cmodel_res_1: .word 0x0
test_665_Cmodel_res_2: .word 0x0

test_666_inp_1_1: .word 0xd57d4589
test_666_inp_1_2: .word 0xf181e4f1
test_666_inp_2_1: .word 0x800a9e45
test_666_inp_2_2: .word 0x4875fb78
test_666_ajit_res_1: .word 0x7ff00000
test_666_ajit_res_2: .word 0x0
test_666_Cmodel_res_1: .word 0x0
test_666_Cmodel_res_2: .word 0x0

test_667_inp_1_1: .word 0xd5e4e1c9
test_667_inp_1_2: .word 0xfed77c93
test_667_inp_2_1: .word 0x80000b60
test_667_inp_2_2: .word 0x1a3396aa
test_667_ajit_res_1: .word 0x7ff00000
test_667_ajit_res_2: .word 0x0
test_667_Cmodel_res_1: .word 0x0
test_667_Cmodel_res_2: .word 0x0

test_668_inp_1_1: .word 0xce987fac
test_668_inp_1_2: .word 0xda78aa5e
test_668_inp_2_1: .word 0x800b2e70
test_668_inp_2_2: .word 0x11b90c8a
test_668_ajit_res_1: .word 0x7ff00000
test_668_ajit_res_2: .word 0x0
test_668_Cmodel_res_1: .word 0x0
test_668_Cmodel_res_2: .word 0x0

test_669_inp_1_1: .word 0xe1839219
test_669_inp_1_2: .word 0x88b1a4eb
test_669_inp_2_1: .word 0x800464e0
test_669_inp_2_2: .word 0x99909d62
test_669_ajit_res_1: .word 0x7ff00000
test_669_ajit_res_2: .word 0x0
test_669_Cmodel_res_1: .word 0x0
test_669_Cmodel_res_2: .word 0x0

test_670_inp_1_1: .word 0xe9cbb99f
test_670_inp_1_2: .word 0x21b43d1f
test_670_inp_2_1: .word 0x800047a5
test_670_inp_2_2: .word 0x1011f2a5
test_670_ajit_res_1: .word 0x7ff00000
test_670_ajit_res_2: .word 0x0
test_670_Cmodel_res_1: .word 0x0
test_670_Cmodel_res_2: .word 0x0

test_671_inp_1_1: .word 0xf96e82f
test_671_inp_1_2: .word 0x85afebb0
test_671_inp_2_1: .word 0x8000a6fb
test_671_inp_2_2: .word 0xfce65867
test_671_ajit_res_1: .word 0xcfc18f20
test_671_ajit_res_2: .word 0x8382193a
test_671_Cmodel_res_1: .word 0x0
test_671_Cmodel_res_2: .word 0x0

test_672_inp_1_1: .word 0x8368c25a
test_672_inp_1_2: .word 0x6866d570
test_672_inp_2_1: .word 0x5f712
test_672_inp_2_2: .word 0x961944da
test_672_ajit_res_1: .word 0xc3609a45
test_672_ajit_res_2: .word 0x95277d2e
test_672_Cmodel_res_1: .word 0x0
test_672_Cmodel_res_2: .word 0x0

test_673_inp_1_1: .word 0xf096393d
test_673_inp_1_2: .word 0x2e1fe612
test_673_inp_2_1: .word 0x8000a137
test_673_inp_2_2: .word 0x15c41d5e
test_673_ajit_res_1: .word 0x7ff00000
test_673_ajit_res_2: .word 0x0
test_673_Cmodel_res_1: .word 0x0
test_673_Cmodel_res_2: .word 0x0

test_674_inp_1_1: .word 0xd5737f4a
test_674_inp_1_2: .word 0x2e05bd54
test_674_inp_2_1: .word 0x800017c7
test_674_inp_2_2: .word 0x4ac0632e
test_674_ajit_res_1: .word 0x7ff00000
test_674_ajit_res_2: .word 0x0
test_674_Cmodel_res_1: .word 0x0
test_674_Cmodel_res_2: .word 0x0

test_675_inp_1_1: .word 0xe36d2c6d
test_675_inp_1_2: .word 0xe044dc5f
test_675_inp_2_1: .word 0x80063334
test_675_inp_2_2: .word 0xf576a227
test_675_ajit_res_1: .word 0x7ff00000
test_675_ajit_res_2: .word 0x0
test_675_Cmodel_res_1: .word 0x0
test_675_Cmodel_res_2: .word 0x0

test_676_inp_1_1: .word 0xde6f0dca
test_676_inp_1_2: .word 0xd787822e
test_676_inp_2_1: .word 0x80015c8f
test_676_inp_2_2: .word 0xded9c6aa
test_676_ajit_res_1: .word 0x7ff00000
test_676_ajit_res_2: .word 0x0
test_676_Cmodel_res_1: .word 0x0
test_676_Cmodel_res_2: .word 0x0

test_677_inp_1_1: .word 0x641b91c
test_677_inp_1_2: .word 0xa08c8b58
test_677_inp_2_1: .word 0x800ebe5f
test_677_inp_2_2: .word 0xa318444e
test_677_ajit_res_1: .word 0xc6233bbb
test_677_ajit_res_2: .word 0xcd5854d6
test_677_Cmodel_res_1: .word 0x0
test_677_Cmodel_res_2: .word 0x0

test_678_inp_1_1: .word 0x7f9845e7
test_678_inp_1_2: .word 0xd6232388
test_678_inp_2_1: .word 0x80011c30
test_678_inp_2_2: .word 0xfaa887cf
test_678_ajit_res_1: .word 0xfff00000
test_678_ajit_res_2: .word 0x0
test_678_Cmodel_res_1: .word 0x0
test_678_Cmodel_res_2: .word 0x0

test_679_inp_1_1: .word 0x4e8827f9
test_679_inp_1_2: .word 0xc1f444d4
test_679_inp_2_1: .word 0x80027e00
test_679_inp_2_2: .word 0xf546195d
test_679_ajit_res_1: .word 0xfff00000
test_679_ajit_res_2: .word 0x0
test_679_Cmodel_res_1: .word 0x0
test_679_Cmodel_res_2: .word 0x0

test_680_inp_1_1: .word 0x36ede1d5
test_680_inp_1_2: .word 0x60d0b72b
test_680_inp_2_1: .word 0xb32e7
test_680_inp_2_2: .word 0x91d3bc85
test_680_ajit_res_1: .word 0x76d558ba
test_680_ajit_res_2: .word 0xd89c02a5
test_680_Cmodel_res_1: .word 0x0
test_680_Cmodel_res_2: .word 0x0

test_681_inp_1_1: .word 0xe0e838bb
test_681_inp_1_2: .word 0x1dbc8c05
test_681_inp_2_1: .word 0x80058ff2
test_681_inp_2_2: .word 0x3d9e545d
test_681_ajit_res_1: .word 0x7ff00000
test_681_ajit_res_2: .word 0x0
test_681_Cmodel_res_1: .word 0x0
test_681_Cmodel_res_2: .word 0x0

test_682_inp_1_1: .word 0x48bec303
test_682_inp_1_2: .word 0xa68dde05
test_682_inp_2_1: .word 0x80047852
test_682_inp_2_2: .word 0x7085e4f9
test_682_ajit_res_1: .word 0xfff00000
test_682_ajit_res_2: .word 0x0
test_682_Cmodel_res_1: .word 0x0
test_682_Cmodel_res_2: .word 0x0

test_683_inp_1_1: .word 0x65209d13
test_683_inp_1_2: .word 0xb76d68dc
test_683_inp_2_1: .word 0x800c22ad
test_683_inp_2_2: .word 0xec58050d
test_683_ajit_res_1: .word 0xfff00000
test_683_ajit_res_2: .word 0x0
test_683_Cmodel_res_1: .word 0x0
test_683_Cmodel_res_2: .word 0x0

test_684_inp_1_1: .word 0x57ff078c
test_684_inp_1_2: .word 0x6ab9c580
test_684_inp_2_1: .word 0x800d5e95
test_684_inp_2_2: .word 0x48bbd60b
test_684_ajit_res_1: .word 0xfff00000
test_684_ajit_res_2: .word 0x0
test_684_Cmodel_res_1: .word 0x0
test_684_Cmodel_res_2: .word 0x0

test_685_inp_1_1: .word 0xb3e89127
test_685_inp_1_2: .word 0x9065a5df
test_685_inp_2_1: .word 0x51ec2
test_685_inp_2_2: .word 0x803ff954
test_685_ajit_res_1: .word 0xf3e33140
test_685_ajit_res_2: .word 0xbef1df48
test_685_Cmodel_res_1: .word 0x0
test_685_Cmodel_res_2: .word 0x0

test_686_inp_1_1: .word 0xcf091045
test_686_inp_1_2: .word 0x9ebad1af
test_686_inp_2_1: .word 0x800062d9
test_686_inp_2_2: .word 0xbe9e2fcc
test_686_ajit_res_1: .word 0x7ff00000
test_686_ajit_res_2: .word 0x0
test_686_Cmodel_res_1: .word 0x0
test_686_Cmodel_res_2: .word 0x0

test_687_inp_1_1: .word 0x46dba739
test_687_inp_1_2: .word 0xff8b5b0f
test_687_inp_2_1: .word 0x800aea7f
test_687_inp_2_2: .word 0xd9316e79
test_687_ajit_res_1: .word 0xfff00000
test_687_ajit_res_2: .word 0x0
test_687_Cmodel_res_1: .word 0x0
test_687_Cmodel_res_2: .word 0x0

test_688_inp_1_1: .word 0x701807fd
test_688_inp_1_2: .word 0xaa2810c0
test_688_inp_2_1: .word 0x800dcf1d
test_688_inp_2_2: .word 0x38a270e1
test_688_ajit_res_1: .word 0xfff00000
test_688_ajit_res_2: .word 0x0
test_688_Cmodel_res_1: .word 0x0
test_688_Cmodel_res_2: .word 0x0

test_689_inp_1_1: .word 0x6b6f0c8b
test_689_inp_1_2: .word 0x51253d74
test_689_inp_2_1: .word 0x800ec8af
test_689_inp_2_2: .word 0xfd7aaa0e
test_689_ajit_res_1: .word 0xfff00000
test_689_ajit_res_2: .word 0x0
test_689_Cmodel_res_1: .word 0x0
test_689_Cmodel_res_2: .word 0x0

test_690_inp_1_1: .word 0xcb17083a
test_690_inp_1_2: .word 0xded22db5
test_690_inp_2_1: .word 0x800ac7e3
test_690_inp_2_2: .word 0xd30e44ae
test_690_ajit_res_1: .word 0x7ff00000
test_690_ajit_res_2: .word 0x0
test_690_Cmodel_res_1: .word 0x0
test_690_Cmodel_res_2: .word 0x0

test_691_inp_1_1: .word 0xc7a43523
test_691_inp_1_2: .word 0x8f26ea98
test_691_inp_2_1: .word 0x800ffdec
test_691_inp_2_2: .word 0xde4b014d
test_691_ajit_res_1: .word 0x7ff00000
test_691_ajit_res_2: .word 0x0
test_691_Cmodel_res_1: .word 0x0
test_691_Cmodel_res_2: .word 0x0

test_692_inp_1_1: .word 0xd17e28f8
test_692_inp_1_2: .word 0xe57efe6d
test_692_inp_2_1: .word 0x8006dfb3
test_692_inp_2_2: .word 0xe56438d1
test_692_ajit_res_1: .word 0x7ff00000
test_692_ajit_res_2: .word 0x0
test_692_Cmodel_res_1: .word 0x0
test_692_Cmodel_res_2: .word 0x0

test_693_inp_1_1: .word 0x86d9357a
test_693_inp_1_2: .word 0x9c272929
test_693_inp_2_1: .word 0x800181d3
test_693_inp_2_2: .word 0x9f860d3b
test_693_ajit_res_1: .word 0x46f0b9f3
test_693_ajit_res_2: .word 0x50b1c213
test_693_Cmodel_res_1: .word 0x0
test_693_Cmodel_res_2: .word 0x0

test_694_inp_1_1: .word 0x397a314a
test_694_inp_1_2: .word 0x9a89e0cc
test_694_inp_2_1: .word 0x8002e765
test_694_inp_2_2: .word 0x11c7400d
test_694_ajit_res_1: .word 0xf9820a26
test_694_ajit_res_2: .word 0x927bb151
test_694_Cmodel_res_1: .word 0x0
test_694_Cmodel_res_2: .word 0x0

test_695_inp_1_1: .word 0xc087edab
test_695_inp_1_2: .word 0xcd6d09c7
test_695_inp_2_1: .word 0x80043034
test_695_inp_2_2: .word 0xe4a54214
test_695_ajit_res_1: .word 0x7ff00000
test_695_ajit_res_2: .word 0x0
test_695_Cmodel_res_1: .word 0x0
test_695_Cmodel_res_2: .word 0x0

test_696_inp_1_1: .word 0x737f764d
test_696_inp_1_2: .word 0x9e2f8a9d
test_696_inp_2_1: .word 0x800b5746
test_696_inp_2_2: .word 0xda32d2c8
test_696_ajit_res_1: .word 0xfff00000
test_696_ajit_res_2: .word 0x0
test_696_Cmodel_res_1: .word 0x0
test_696_Cmodel_res_2: .word 0x0

test_697_inp_1_1: .word 0x56c4631c
test_697_inp_1_2: .word 0xe2049c27
test_697_inp_2_1: .word 0x80072264
test_697_inp_2_2: .word 0x30dd7cdf
test_697_ajit_res_1: .word 0xfff00000
test_697_ajit_res_2: .word 0x0
test_697_Cmodel_res_1: .word 0x0
test_697_Cmodel_res_2: .word 0x0

test_698_inp_1_1: .word 0xe3999cd1
test_698_inp_1_2: .word 0x2281c045
test_698_inp_2_1: .word 0x80038e88
test_698_inp_2_2: .word 0xfdb67285
test_698_ajit_res_1: .word 0x7ff00000
test_698_ajit_res_2: .word 0x0
test_698_Cmodel_res_1: .word 0x0
test_698_Cmodel_res_2: .word 0x0

test_699_inp_1_1: .word 0xc90d484
test_699_inp_1_2: .word 0xa5228404
test_699_inp_2_1: .word 0x800d2832
test_699_inp_2_2: .word 0x3451400c
test_699_ajit_res_1: .word 0xcc747782
test_699_ajit_res_2: .word 0x96c9f54
test_699_Cmodel_res_1: .word 0x0
test_699_Cmodel_res_2: .word 0x0

test_700_inp_1_1: .word 0xdd7005d9
test_700_inp_1_2: .word 0xbeacb5cb
test_700_inp_2_1: .word 0x8000c4e3
test_700_inp_2_2: .word 0xcc85fe60
test_700_ajit_res_1: .word 0x7ff00000
test_700_ajit_res_2: .word 0x0
test_700_Cmodel_res_1: .word 0x0
test_700_Cmodel_res_2: .word 0x0

test_701_inp_1_1: .word 0xc148a7db
test_701_inp_1_2: .word 0x79332bd3
test_701_inp_2_1: .word 0x8001638f
test_701_inp_2_2: .word 0x54f9d944
test_701_ajit_res_1: .word 0x7ff00000
test_701_ajit_res_2: .word 0x0
test_701_Cmodel_res_1: .word 0x0
test_701_Cmodel_res_2: .word 0x0

test_702_inp_1_1: .word 0x49dead7b
test_702_inp_1_2: .word 0xa33178e8
test_702_inp_2_1: .word 0x800654c7
test_702_inp_2_2: .word 0xf7062019
test_702_ajit_res_1: .word 0xfff00000
test_702_ajit_res_2: .word 0x0
test_702_Cmodel_res_1: .word 0x0
test_702_Cmodel_res_2: .word 0x0

test_703_inp_1_1: .word 0x4aec3a5a
test_703_inp_1_2: .word 0x6a180e4d
test_703_inp_2_1: .word 0x80028bfb
test_703_inp_2_2: .word 0x43240d11
test_703_ajit_res_1: .word 0xfff00000
test_703_ajit_res_2: .word 0x0
test_703_Cmodel_res_1: .word 0x0
test_703_Cmodel_res_2: .word 0x0

test_704_inp_1_1: .word 0xfb3098da
test_704_inp_1_2: .word 0xdf19d409
test_704_inp_2_1: .word 0x8004b818
test_704_inp_2_2: .word 0x1d91c5e1
test_704_ajit_res_1: .word 0x7ff00000
test_704_ajit_res_2: .word 0x0
test_704_Cmodel_res_1: .word 0x0
test_704_Cmodel_res_2: .word 0x0

test_705_inp_1_1: .word 0x44cd0014
test_705_inp_1_2: .word 0xa395c5dc
test_705_inp_2_1: .word 0x800ba57e
test_705_inp_2_2: .word 0xe5b61957
test_705_ajit_res_1: .word 0xfff00000
test_705_ajit_res_2: .word 0x0
test_705_Cmodel_res_1: .word 0x0
test_705_Cmodel_res_2: .word 0x0

test_706_inp_1_1: .word 0x7753ab8d
test_706_inp_1_2: .word 0x665eba57
test_706_inp_2_1: .word 0x80063ba4
test_706_inp_2_2: .word 0xd9b072e3
test_706_ajit_res_1: .word 0xfff00000
test_706_ajit_res_2: .word 0x0
test_706_Cmodel_res_1: .word 0x0
test_706_Cmodel_res_2: .word 0x0

test_707_inp_1_1: .word 0x56154108
test_707_inp_1_2: .word 0x3b3e8e3a
test_707_inp_2_1: .word 0x800e44bb
test_707_inp_2_2: .word 0x4e603da6
test_707_ajit_res_1: .word 0xfff00000
test_707_ajit_res_2: .word 0x0
test_707_Cmodel_res_1: .word 0x0
test_707_Cmodel_res_2: .word 0x0

test_708_inp_1_1: .word 0x53274e44
test_708_inp_1_2: .word 0x2f5619b5
test_708_inp_2_1: .word 0x80097749
test_708_inp_2_2: .word 0x403478c6
test_708_ajit_res_1: .word 0xfff00000
test_708_ajit_res_2: .word 0x0
test_708_Cmodel_res_1: .word 0x0
test_708_Cmodel_res_2: .word 0x0

test_709_inp_1_1: .word 0x54a466fc
test_709_inp_1_2: .word 0xeb16faf3
test_709_inp_2_1: .word 0x80091c29
test_709_inp_2_2: .word 0x1fac0bc6
test_709_ajit_res_1: .word 0xfff00000
test_709_ajit_res_2: .word 0x0
test_709_Cmodel_res_1: .word 0x0
test_709_Cmodel_res_2: .word 0x0

test_710_inp_1_1: .word 0x60ff129a
test_710_inp_1_2: .word 0x7790fc0e
test_710_inp_2_1: .word 0x80087552
test_710_inp_2_2: .word 0x842d1e76
test_710_ajit_res_1: .word 0xfff00000
test_710_ajit_res_2: .word 0x0
test_710_Cmodel_res_1: .word 0x0
test_710_Cmodel_res_2: .word 0x0

test_711_inp_1_1: .word 0x6192d596
test_711_inp_1_2: .word 0x500b411
test_711_inp_2_1: .word 0x800eaa57
test_711_inp_2_2: .word 0x5dd79139
test_711_ajit_res_1: .word 0xfff00000
test_711_ajit_res_2: .word 0x0
test_711_Cmodel_res_1: .word 0x0
test_711_Cmodel_res_2: .word 0x0

test_712_inp_1_1: .word 0x646f249a
test_712_inp_1_2: .word 0xb198143b
test_712_inp_2_1: .word 0x80044abe
test_712_inp_2_2: .word 0x75df4ad3
test_712_ajit_res_1: .word 0xfff00000
test_712_ajit_res_2: .word 0x0
test_712_Cmodel_res_1: .word 0x0
test_712_Cmodel_res_2: .word 0x0

test_713_inp_1_1: .word 0x450b4a15
test_713_inp_1_2: .word 0x3a357b1f
test_713_inp_2_1: .word 0x80031a71
test_713_inp_2_2: .word 0x5e2e3629
test_713_ajit_res_1: .word 0xfff00000
test_713_ajit_res_2: .word 0x0
test_713_Cmodel_res_1: .word 0x0
test_713_Cmodel_res_2: .word 0x0

test_714_inp_1_1: .word 0x41e56c65
test_714_inp_1_2: .word 0x510cd010
test_714_inp_2_1: .word 0x800190f9
test_714_inp_2_2: .word 0xd9f8cdb0
test_714_ajit_res_1: .word 0xfff00000
test_714_ajit_res_2: .word 0x0
test_714_Cmodel_res_1: .word 0x0
test_714_Cmodel_res_2: .word 0x0

test_715_inp_1_1: .word 0x66486ffb
test_715_inp_1_2: .word 0x8ec40a4b
test_715_inp_2_1: .word 0x800ee33b
test_715_inp_2_2: .word 0xa8ac709f
test_715_ajit_res_1: .word 0xfff00000
test_715_ajit_res_2: .word 0x0
test_715_Cmodel_res_1: .word 0x0
test_715_Cmodel_res_2: .word 0x0

test_716_inp_1_1: .word 0x61ec0e3a
test_716_inp_1_2: .word 0xcc574f61
test_716_inp_2_1: .word 0x80058aff
test_716_inp_2_2: .word 0x768e19bf
test_716_ajit_res_1: .word 0xfff00000
test_716_ajit_res_2: .word 0x0
test_716_Cmodel_res_1: .word 0x0
test_716_Cmodel_res_2: .word 0x0

test_717_inp_1_1: .word 0xab339941
test_717_inp_1_2: .word 0xbafc69c7
test_717_inp_2_1: .word 0x800f8e14
test_717_inp_2_2: .word 0xa0300d4
test_717_ajit_res_1: .word 0x6b1428cb
test_717_ajit_res_2: .word 0x22b89a03
test_717_Cmodel_res_1: .word 0x0
test_717_Cmodel_res_2: .word 0x0

test_718_inp_1_1: .word 0x550cdeff
test_718_inp_1_2: .word 0x65629f66
test_718_inp_2_1: .word 0x8001b5f1
test_718_inp_2_2: .word 0x175343d8
test_718_ajit_res_1: .word 0xfff00000
test_718_ajit_res_2: .word 0x0
test_718_Cmodel_res_1: .word 0x0
test_718_Cmodel_res_2: .word 0x0

test_719_inp_1_1: .word 0xd2aad7b6
test_719_inp_1_2: .word 0x631181b8
test_719_inp_2_1: .word 0x800b54e2
test_719_inp_2_2: .word 0x62f6ccbb
test_719_ajit_res_1: .word 0x7ff00000
test_719_ajit_res_2: .word 0x0
test_719_Cmodel_res_1: .word 0x0
test_719_Cmodel_res_2: .word 0x0

test_720_inp_1_1: .word 0x7a0ccdd1
test_720_inp_1_2: .word 0x5caa8e15
test_720_inp_2_1: .word 0x8000816d
test_720_inp_2_2: .word 0x79e0fe49
test_720_ajit_res_1: .word 0xfff00000
test_720_ajit_res_2: .word 0x0
test_720_Cmodel_res_1: .word 0x0
test_720_Cmodel_res_2: .word 0x0

test_721_inp_1_1: .word 0xcb965b12
test_721_inp_1_2: .word 0xa86f0333
test_721_inp_2_1: .word 0x80030b31
test_721_inp_2_2: .word 0x957371f5
test_721_ajit_res_1: .word 0x7ff00000
test_721_ajit_res_2: .word 0x0
test_721_Cmodel_res_1: .word 0x0
test_721_Cmodel_res_2: .word 0x0

test_722_inp_1_1: .word 0xcac74967
test_722_inp_1_2: .word 0xeaab3142
test_722_inp_2_1: .word 0x8009b06e
test_722_inp_2_2: .word 0x6da77a0
test_722_ajit_res_1: .word 0x7ff00000
test_722_ajit_res_2: .word 0x0
test_722_Cmodel_res_1: .word 0x0
test_722_Cmodel_res_2: .word 0x0

test_723_inp_1_1: .word 0xd21d3abe
test_723_inp_1_2: .word 0xd5b6a317
test_723_inp_2_1: .word 0x80005667
test_723_inp_2_2: .word 0xc6f5eb91
test_723_ajit_res_1: .word 0x7ff00000
test_723_ajit_res_2: .word 0x0
test_723_Cmodel_res_1: .word 0x0
test_723_Cmodel_res_2: .word 0x0

test_724_inp_1_1: .word 0x574bc67d
test_724_inp_1_2: .word 0xdf463780
test_724_inp_2_1: .word 0x80071264
test_724_inp_2_2: .word 0x845b5bef
test_724_ajit_res_1: .word 0xfff00000
test_724_ajit_res_2: .word 0x0
test_724_Cmodel_res_1: .word 0x0
test_724_Cmodel_res_2: .word 0x0

test_725_inp_1_1: .word 0x756da686
test_725_inp_1_2: .word 0x477c175
test_725_inp_2_1: .word 0x8007c787
test_725_inp_2_2: .word 0x4acfd3b7
test_725_ajit_res_1: .word 0xfff00000
test_725_ajit_res_2: .word 0x0
test_725_Cmodel_res_1: .word 0x0
test_725_Cmodel_res_2: .word 0x0

test_726_inp_1_1: .word 0x5311c5a3
test_726_inp_1_2: .word 0xafb9c0ce
test_726_inp_2_1: .word 0x800a862a
test_726_inp_2_2: .word 0xbf1140cf
test_726_ajit_res_1: .word 0xfff00000
test_726_ajit_res_2: .word 0x0
test_726_Cmodel_res_1: .word 0x0
test_726_Cmodel_res_2: .word 0x0

test_727_inp_1_1: .word 0xd21e1d01
test_727_inp_1_2: .word 0x2c9abeea
test_727_inp_2_1: .word 0x800bfb81
test_727_inp_2_2: .word 0xbd9f7117
test_727_ajit_res_1: .word 0x7ff00000
test_727_ajit_res_2: .word 0x0
test_727_Cmodel_res_1: .word 0x0
test_727_Cmodel_res_2: .word 0x0

test_728_inp_1_1: .word 0x40074522
test_728_inp_1_2: .word 0x65b3b572
test_728_inp_2_1: .word 0xc39f0
test_728_inp_2_2: .word 0xa60bce98
test_728_ajit_res_1: .word 0x7fee73cf
test_728_ajit_res_2: .word 0xbb461389
test_728_Cmodel_res_1: .word 0x0
test_728_Cmodel_res_2: .word 0x0

test_729_inp_1_1: .word 0xbf698db5
test_729_inp_1_2: .word 0xebc63ab5
test_729_inp_2_1: .word 0x800be33f
test_729_inp_2_2: .word 0xc1c9bb80
test_729_ajit_res_1: .word 0x7f513257
test_729_ajit_res_2: .word 0x92d06e56
test_729_Cmodel_res_1: .word 0x0
test_729_Cmodel_res_2: .word 0x0

test_730_inp_1_1: .word 0xd9b78db
test_730_inp_1_2: .word 0xa1ade
test_730_inp_2_1: .word 0x2f745
test_730_inp_2_2: .word 0x501796b
test_730_ajit_res_1: .word 0x4da2867b
test_730_ajit_res_2: .word 0x3dc43f5c
test_730_Cmodel_res_1: .word 0x0
test_730_Cmodel_res_2: .word 0x0

test_731_inp_1_1: .word 0x6980ae93
test_731_inp_1_2: .word 0x59ae70d1
test_731_inp_2_1: .word 0x8001d51b
test_731_inp_2_2: .word 0xaa7b3870
test_731_ajit_res_1: .word 0xfff00000
test_731_ajit_res_2: .word 0x0
test_731_Cmodel_res_1: .word 0x0
test_731_Cmodel_res_2: .word 0x0

test_732_inp_1_1: .word 0x796c0ec6
test_732_inp_1_2: .word 0xc456f5e1
test_732_inp_2_1: .word 0x8004ba5e
test_732_inp_2_2: .word 0x824b004a
test_732_ajit_res_1: .word 0xfff00000
test_732_ajit_res_2: .word 0x0
test_732_Cmodel_res_1: .word 0x0
test_732_Cmodel_res_2: .word 0x0

test_733_inp_1_1: .word 0x90bc8b67
test_733_inp_1_2: .word 0xa33493c3
test_733_inp_2_1: .word 0x800db9a3
test_733_inp_2_2: .word 0xe7666a24
test_733_ajit_res_1: .word 0x50a0a346
test_733_ajit_res_2: .word 0xc42480d1
test_733_Cmodel_res_1: .word 0x0
test_733_Cmodel_res_2: .word 0x0

test_734_inp_1_1: .word 0xe6121c74
test_734_inp_1_2: .word 0x774a7eaf
test_734_inp_2_1: .word 0x8007ae65
test_734_inp_2_2: .word 0x41caa192
test_734_ajit_res_1: .word 0x7ff00000
test_734_ajit_res_2: .word 0x0
test_734_Cmodel_res_1: .word 0x0
test_734_Cmodel_res_2: .word 0x0

test_735_inp_1_1: .word 0x228f16a7
test_735_inp_1_2: .word 0x9247c631
test_735_inp_2_1: .word 0x63b8f
test_735_inp_2_2: .word 0x7faee5fd
test_735_ajit_res_1: .word 0x6283f3b6
test_735_ajit_res_2: .word 0xa6aa300
test_735_Cmodel_res_1: .word 0x0
test_735_Cmodel_res_2: .word 0x0

test_736_inp_1_1: .word 0xe32107f5
test_736_inp_1_2: .word 0xd342373a
test_736_inp_2_1: .word 0x80055ffa
test_736_inp_2_2: .word 0xd5263dd4
test_736_ajit_res_1: .word 0x7ff00000
test_736_ajit_res_2: .word 0x0
test_736_Cmodel_res_1: .word 0x0
test_736_Cmodel_res_2: .word 0x0

test_737_inp_1_1: .word 0xd73ecaca
test_737_inp_1_2: .word 0x406935fc
test_737_inp_2_1: .word 0x800e9df4
test_737_inp_2_2: .word 0xd9351897
test_737_ajit_res_1: .word 0x7ff00000
test_737_ajit_res_2: .word 0x0
test_737_Cmodel_res_1: .word 0x0
test_737_Cmodel_res_2: .word 0x0

test_738_inp_1_1: .word 0xfefd5d98
test_738_inp_1_2: .word 0xb770b652
test_738_inp_2_1: .word 0x80044e13
test_738_inp_2_2: .word 0x4b8583be
test_738_ajit_res_1: .word 0x7ff00000
test_738_ajit_res_2: .word 0x0
test_738_Cmodel_res_1: .word 0x0
test_738_Cmodel_res_2: .word 0x0

test_739_inp_1_1: .word 0xc2907ab6
test_739_inp_1_2: .word 0x2e59871a
test_739_inp_2_1: .word 0x800afb0c
test_739_inp_2_2: .word 0x81afb294
test_739_ajit_res_1: .word 0x7ff00000
test_739_ajit_res_2: .word 0x0
test_739_Cmodel_res_1: .word 0x0
test_739_Cmodel_res_2: .word 0x0

test_740_inp_1_1: .word 0xc7fdedf0
test_740_inp_1_2: .word 0x8ac38bb
test_740_inp_2_1: .word 0x800fe274
test_740_inp_2_2: .word 0x18b02e0a
test_740_ajit_res_1: .word 0x7ff00000
test_740_ajit_res_2: .word 0x0
test_740_Cmodel_res_1: .word 0x0
test_740_Cmodel_res_2: .word 0x0

test_741_inp_1_1: .word 0xca6234c3
test_741_inp_1_2: .word 0xee5ae11c
test_741_inp_2_1: .word 0x8006fba1
test_741_inp_2_2: .word 0x84a193de
test_741_ajit_res_1: .word 0x7ff00000
test_741_ajit_res_2: .word 0x0
test_741_Cmodel_res_1: .word 0x0
test_741_Cmodel_res_2: .word 0x0

test_742_inp_1_1: .word 0xeb7f572c
test_742_inp_1_2: .word 0xa76d8076
test_742_inp_2_1: .word 0x8004dcdd
test_742_inp_2_2: .word 0x98a186f6
test_742_ajit_res_1: .word 0x7ff00000
test_742_ajit_res_2: .word 0x0
test_742_Cmodel_res_1: .word 0x0
test_742_Cmodel_res_2: .word 0x0

test_743_inp_1_1: .word 0xd75686d2
test_743_inp_1_2: .word 0x3b9fe6ae
test_743_inp_2_1: .word 0x8006d1ab
test_743_inp_2_2: .word 0xe102b2e3
test_743_ajit_res_1: .word 0x7ff00000
test_743_ajit_res_2: .word 0x0
test_743_Cmodel_res_1: .word 0x0
test_743_Cmodel_res_2: .word 0x0

test_744_inp_1_1: .word 0x504bff9b
test_744_inp_1_2: .word 0x108055b6
test_744_inp_2_1: .word 0x8007f4b5
test_744_inp_2_2: .word 0xfd38f89d
test_744_ajit_res_1: .word 0xfff00000
test_744_ajit_res_2: .word 0x0
test_744_Cmodel_res_1: .word 0x0
test_744_Cmodel_res_2: .word 0x0

test_745_inp_1_1: .word 0xab70df6f
test_745_inp_1_2: .word 0x8854f768
test_745_inp_2_1: .word 0x800fad10
test_745_inp_2_2: .word 0xd5988486
test_745_ajit_res_1: .word 0x6b5138b3
test_745_ajit_res_2: .word 0x8d26a31b
test_745_Cmodel_res_1: .word 0x0
test_745_Cmodel_res_2: .word 0x0

test_746_inp_1_1: .word 0x7d985e25
test_746_inp_1_2: .word 0x7861e322
test_746_inp_2_1: .word 0x800665d0
test_746_inp_2_2: .word 0x4645a864
test_746_ajit_res_1: .word 0xfff00000
test_746_ajit_res_2: .word 0x0
test_746_Cmodel_res_1: .word 0x0
test_746_Cmodel_res_2: .word 0x0

test_747_inp_1_1: .word 0xe3fa4a8d
test_747_inp_1_2: .word 0xbb823840
test_747_inp_2_1: .word 0x8002a4e0
test_747_inp_2_2: .word 0x5f132c30
test_747_ajit_res_1: .word 0x7ff00000
test_747_ajit_res_2: .word 0x0
test_747_Cmodel_res_1: .word 0x0
test_747_Cmodel_res_2: .word 0x0

test_748_inp_1_1: .word 0x6db9b97a
test_748_inp_1_2: .word 0xd1b4f450
test_748_inp_2_1: .word 0x800661cb
test_748_inp_2_2: .word 0xc4d089b8
test_748_ajit_res_1: .word 0xfff00000
test_748_ajit_res_2: .word 0x0
test_748_Cmodel_res_1: .word 0x0
test_748_Cmodel_res_2: .word 0x0

test_749_inp_1_1: .word 0xcfbc4f0d
test_749_inp_1_2: .word 0x652d137a
test_749_inp_2_1: .word 0x800e75f6
test_749_inp_2_2: .word 0x3974d7dc
test_749_ajit_res_1: .word 0x7ff00000
test_749_ajit_res_2: .word 0x0
test_749_Cmodel_res_1: .word 0x0
test_749_Cmodel_res_2: .word 0x0

test_750_inp_1_1: .word 0x24e12309
test_750_inp_1_2: .word 0xf3d1afb4
test_750_inp_2_1: .word 0x35e1f
test_750_inp_2_2: .word 0xe27d61eb
test_750_ajit_res_1: .word 0x64e45ac3
test_750_ajit_res_2: .word 0xa7f0ba72
test_750_Cmodel_res_1: .word 0x0
test_750_Cmodel_res_2: .word 0x0

test_751_inp_1_1: .word 0xf702b65d
test_751_inp_1_2: .word 0xa01de2eb
test_751_inp_2_1: .word 0x800fd0aa
test_751_inp_2_2: .word 0xa7a403ee
test_751_ajit_res_1: .word 0x7ff00000
test_751_ajit_res_2: .word 0x0
test_751_Cmodel_res_1: .word 0x0
test_751_Cmodel_res_2: .word 0x0

test_752_inp_1_1: .word 0x655ba314
test_752_inp_1_2: .word 0x2fa328ca
test_752_inp_2_1: .word 0x800040f3
test_752_inp_2_2: .word 0xb2191c1b
test_752_ajit_res_1: .word 0xfff00000
test_752_ajit_res_2: .word 0x0
test_752_Cmodel_res_1: .word 0x0
test_752_Cmodel_res_2: .word 0x0

test_753_inp_1_1: .word 0xf3cf56dd
test_753_inp_1_2: .word 0x5906b9f3
test_753_inp_2_1: .word 0x800a3e4f
test_753_inp_2_2: .word 0x25a4a840
test_753_ajit_res_1: .word 0x7ff00000
test_753_ajit_res_2: .word 0x0
test_753_Cmodel_res_1: .word 0x0
test_753_Cmodel_res_2: .word 0x0

test_754_inp_1_1: .word 0xdf791578
test_754_inp_1_2: .word 0x39ea3fd6
test_754_inp_2_1: .word 0x800e57b8
test_754_inp_2_2: .word 0x48bede29
test_754_ajit_res_1: .word 0x7ff00000
test_754_ajit_res_2: .word 0x0
test_754_Cmodel_res_1: .word 0x0
test_754_Cmodel_res_2: .word 0x0

test_755_inp_1_1: .word 0xa434b1e8
test_755_inp_1_2: .word 0xf7bc3286
test_755_inp_2_1: .word 0xf225f
test_755_inp_2_2: .word 0x19c92b63
test_755_ajit_res_1: .word 0xe415e0f8
test_755_ajit_res_2: .word 0x63159837
test_755_Cmodel_res_1: .word 0x0
test_755_Cmodel_res_2: .word 0x0

test_756_inp_1_1: .word 0x4dc2d933
test_756_inp_1_2: .word 0xd574435c
test_756_inp_2_1: .word 0x800da591
test_756_inp_2_2: .word 0x9e11fcda
test_756_ajit_res_1: .word 0xfff00000
test_756_ajit_res_2: .word 0x0
test_756_Cmodel_res_1: .word 0x0
test_756_Cmodel_res_2: .word 0x0

test_757_inp_1_1: .word 0xf5e53d66
test_757_inp_1_2: .word 0xc8c14d79
test_757_inp_2_1: .word 0x80014eef
test_757_inp_2_2: .word 0x7feab1a3
test_757_ajit_res_1: .word 0x7ff00000
test_757_ajit_res_2: .word 0x0
test_757_Cmodel_res_1: .word 0x0
test_757_Cmodel_res_2: .word 0x0

test_758_inp_1_1: .word 0x63673eb2
test_758_inp_1_2: .word 0x634d76d8
test_758_inp_2_1: .word 0x8004e424
test_758_inp_2_2: .word 0xce675a35
test_758_ajit_res_1: .word 0xfff00000
test_758_ajit_res_2: .word 0x0
test_758_Cmodel_res_1: .word 0x0
test_758_Cmodel_res_2: .word 0x0

test_759_inp_1_1: .word 0x65a4ae2b
test_759_inp_1_2: .word 0x19c59728
test_759_inp_2_1: .word 0x80021664
test_759_inp_2_2: .word 0x207ad606
test_759_ajit_res_1: .word 0xfff00000
test_759_ajit_res_2: .word 0x0
test_759_Cmodel_res_1: .word 0x0
test_759_Cmodel_res_2: .word 0x0

test_760_inp_1_1: .word 0x7716d4ca
test_760_inp_1_2: .word 0x9c8a9e6e
test_760_inp_2_1: .word 0x800e69e6
test_760_inp_2_2: .word 0xd97dd0d2
test_760_ajit_res_1: .word 0xfff00000
test_760_ajit_res_2: .word 0x0
test_760_Cmodel_res_1: .word 0x0
test_760_Cmodel_res_2: .word 0x0

test_761_inp_1_1: .word 0x4e550776
test_761_inp_1_2: .word 0xda7f34ba
test_761_inp_2_1: .word 0x800436a2
test_761_inp_2_2: .word 0x637a453
test_761_ajit_res_1: .word 0xfff00000
test_761_ajit_res_2: .word 0x0
test_761_Cmodel_res_1: .word 0x0
test_761_Cmodel_res_2: .word 0x0

test_762_inp_1_1: .word 0x46ce4852
test_762_inp_1_2: .word 0x32fbf464
test_762_inp_2_1: .word 0x80092bce
test_762_inp_2_2: .word 0x63f79a8c
test_762_ajit_res_1: .word 0xfff00000
test_762_ajit_res_2: .word 0x0
test_762_Cmodel_res_1: .word 0x0
test_762_Cmodel_res_2: .word 0x0

test_763_inp_1_1: .word 0x4f2f412e
test_763_inp_1_2: .word 0x4d663254
test_763_inp_2_1: .word 0x800381e6
test_763_inp_2_2: .word 0x585aeb30
test_763_ajit_res_1: .word 0xfff00000
test_763_ajit_res_2: .word 0x0
test_763_Cmodel_res_1: .word 0x0
test_763_Cmodel_res_2: .word 0x0

test_764_inp_1_1: .word 0xbd6ce34e
test_764_inp_1_2: .word 0x1711e43
test_764_inp_2_1: .word 0xaecde
test_764_inp_2_2: .word 0xfb820cbf
test_764_ajit_res_1: .word 0xfd552730
test_764_ajit_res_2: .word 0x47011b3a
test_764_Cmodel_res_1: .word 0x0
test_764_Cmodel_res_2: .word 0x0

test_765_inp_1_1: .word 0x74fee045
test_765_inp_1_2: .word 0x5b918f1d
test_765_inp_2_1: .word 0x8005aeec
test_765_inp_2_2: .word 0x9220cb43
test_765_ajit_res_1: .word 0xfff00000
test_765_ajit_res_2: .word 0x0
test_765_Cmodel_res_1: .word 0x0
test_765_Cmodel_res_2: .word 0x0

test_766_inp_1_1: .word 0x22e8d3dc
test_766_inp_1_2: .word 0xd0bce36d
test_766_inp_2_1: .word 0x8003dbc9
test_766_inp_2_2: .word 0x199ee1eb
test_766_ajit_res_1: .word 0xe2e9bce2
test_766_ajit_res_2: .word 0x321e891
test_766_Cmodel_res_1: .word 0x0
test_766_Cmodel_res_2: .word 0x0

test_767_inp_1_1: .word 0x450b7a4d
test_767_inp_1_2: .word 0x6ee4f714
test_767_inp_2_1: .word 0x800bf5f2
test_767_inp_2_2: .word 0x24127bfa
test_767_ajit_res_1: .word 0xfff00000
test_767_ajit_res_2: .word 0x0
test_767_Cmodel_res_1: .word 0x0
test_767_Cmodel_res_2: .word 0x0

test_768_inp_1_1: .word 0x3b9cc83c
test_768_inp_1_2: .word 0xe1bfb3a6
test_768_inp_2_1: .word 0x6698616a
test_768_inp_2_2: .word 0xcb66e541
test_768_ajit_res_1: .word 0x14f2e37d
test_768_ajit_res_2: .word 0x1ab62434
test_768_Cmodel_res_1: .word 0x0
test_768_Cmodel_res_2: .word 0x0

test_769_inp_1_1: .word 0xeb7b1c5f
test_769_inp_1_2: .word 0x969cb20e
test_769_inp_2_1: .word 0x97433ee8
test_769_inp_2_2: .word 0x8908c8ea
test_769_ajit_res_1: .word 0x7ff00000
test_769_ajit_res_2: .word 0x0
test_769_Cmodel_res_1: .word 0x0
test_769_Cmodel_res_2: .word 0x0

test_770_inp_1_1: .word 0xa0b2ec36
test_770_inp_1_2: .word 0x55e70d04
test_770_inp_2_1: .word 0x61410c99
test_770_inp_2_2: .word 0xa513021e
test_770_ajit_res_1: .word 0x80000238
test_770_ajit_res_2: .word 0x431621d0
test_770_Cmodel_res_1: .word 0x0
test_770_Cmodel_res_2: .word 0x0

test_771_inp_1_1: .word 0x9fbf8220
test_771_inp_1_2: .word 0xacd22601
test_771_inp_2_1: .word 0xae0f5b11
test_771_inp_2_2: .word 0xd9d8220d
test_771_ajit_res_1: .word 0x31a013ee
test_771_ajit_res_2: .word 0x223f694a
test_771_Cmodel_res_1: .word 0x0
test_771_Cmodel_res_2: .word 0x0

test_772_inp_1_1: .word 0x5cce2a51
test_772_inp_1_2: .word 0x191b0a34
test_772_inp_2_1: .word 0x9a76383a
test_772_inp_2_2: .word 0xfeed3120
test_772_ajit_res_1: .word 0xfff00000
test_772_ajit_res_2: .word 0x0
test_772_Cmodel_res_1: .word 0x0
test_772_Cmodel_res_2: .word 0x0

test_773_inp_1_1: .word 0x9f9f816e
test_773_inp_1_2: .word 0xc479c6e6
test_773_inp_2_1: .word 0x15c943ea
test_773_inp_2_2: .word 0xa68a4ceb
test_773_ajit_res_1: .word 0xc9c3f3ac
test_773_ajit_res_2: .word 0xa7b9737c
test_773_Cmodel_res_1: .word 0x0
test_773_Cmodel_res_2: .word 0x0

test_774_inp_1_1: .word 0x63e5104f
test_774_inp_1_2: .word 0x3f4c0c1b
test_774_inp_2_1: .word 0x9cfcc92c
test_774_inp_2_2: .word 0x1634f2c3
test_774_ajit_res_1: .word 0xfff00000
test_774_ajit_res_2: .word 0x0
test_774_Cmodel_res_1: .word 0x0
test_774_Cmodel_res_2: .word 0x0

test_775_inp_1_1: .word 0x68ea83b0
test_775_inp_1_2: .word 0x41a912f1
test_775_inp_2_1: .word 0x5dc960f3
test_775_inp_2_2: .word 0xd018dc94
test_775_ajit_res_1: .word 0x4b10b74b
test_775_ajit_res_2: .word 0x5ee03579
test_775_Cmodel_res_1: .word 0x0
test_775_Cmodel_res_2: .word 0x0

test_776_inp_1_1: .word 0x4fcb0168
test_776_inp_1_2: .word 0xc5b15b3f
test_776_inp_2_1: .word 0x846373fb
test_776_inp_2_2: .word 0x7f991649
test_776_ajit_res_1: .word 0xfff00000
test_776_ajit_res_2: .word 0x0
test_776_Cmodel_res_1: .word 0x0
test_776_Cmodel_res_2: .word 0x0

test_777_inp_1_1: .word 0x38a0397a
test_777_inp_1_2: .word 0xff09e205
test_777_inp_2_1: .word 0xcf5d91c9
test_777_inp_2_2: .word 0x55cdd081
test_777_ajit_res_1: .word 0xa9318ee2
test_777_ajit_res_2: .word 0x4c3387c1
test_777_Cmodel_res_1: .word 0x0
test_777_Cmodel_res_2: .word 0x0

test_778_inp_1_1: .word 0x9023cd0a
test_778_inp_1_2: .word 0xa982a78f
test_778_inp_2_1: .word 0xd2448c19
test_778_inp_2_2: .word 0xca89a100
test_778_ajit_res_1: .word 0x0
test_778_ajit_res_2: .word 0xf6b3
test_778_Cmodel_res_1: .word 0x0
test_778_Cmodel_res_2: .word 0x0

test_779_inp_1_1: .word 0x9235ce8e
test_779_inp_1_2: .word 0x4ff35b08
test_779_inp_2_1: .word 0xb54e46c8
test_779_inp_2_2: .word 0x3ba77fbe
test_779_ajit_res_1: .word 0x1cd70c58
test_779_ajit_res_2: .word 0x9ff35cf4
test_779_Cmodel_res_1: .word 0x0
test_779_Cmodel_res_2: .word 0x0

test_780_inp_1_1: .word 0x7e291ce4
test_780_inp_1_2: .word 0x43356b8f
test_780_inp_2_1: .word 0xa259289b
test_780_inp_2_2: .word 0xeea80298
test_780_ajit_res_1: .word 0xfff00000
test_780_ajit_res_2: .word 0x0
test_780_Cmodel_res_1: .word 0x0
test_780_Cmodel_res_2: .word 0x0

test_781_inp_1_1: .word 0x4dfc47cf
test_781_inp_1_2: .word 0x44ee4a34
test_781_inp_2_1: .word 0x8c97f56b
test_781_inp_2_2: .word 0x1ff39ba0
test_781_ajit_res_1: .word 0xfff00000
test_781_ajit_res_2: .word 0x0
test_781_Cmodel_res_1: .word 0x0
test_781_Cmodel_res_2: .word 0x0

test_782_inp_1_1: .word 0xdf844dea
test_782_inp_1_2: .word 0xf37a8509
test_782_inp_2_1: .word 0x95d0309a
test_782_inp_2_2: .word 0x8c1a1243
test_782_ajit_res_1: .word 0x7ff00000
test_782_ajit_res_2: .word 0x0
test_782_Cmodel_res_1: .word 0x0
test_782_Cmodel_res_2: .word 0x0

test_783_inp_1_1: .word 0xc09b8a88
test_783_inp_1_2: .word 0x3c5b5432
test_783_inp_2_1: .word 0x809bb8f8
test_783_inp_2_2: .word 0xc44ae1a
test_783_ajit_res_1: .word 0x7fefca65
test_783_ajit_res_2: .word 0xf3656567
test_783_Cmodel_res_1: .word 0x0
test_783_Cmodel_res_2: .word 0x0

test_784_inp_1_1: .word 0xcc3e5efe
test_784_inp_1_2: .word 0x2921d3c7
test_784_inp_2_1: .word 0xb6351612
test_784_inp_2_2: .word 0xa43f81a0
test_784_ajit_res_1: .word 0x55f70b94
test_784_ajit_res_2: .word 0xdd97fc70
test_784_Cmodel_res_1: .word 0x0
test_784_Cmodel_res_2: .word 0x0

test_785_inp_1_1: .word 0x3deafbf8
test_785_inp_1_2: .word 0x41b2332f
test_785_inp_2_1: .word 0xd203ef99
test_785_inp_2_2: .word 0x62ca7c89
test_785_ajit_res_1: .word 0xabd5a822
test_785_ajit_res_2: .word 0xa0c7ff12
test_785_Cmodel_res_1: .word 0x0
test_785_Cmodel_res_2: .word 0x0

test_786_inp_1_1: .word 0xa9ef8fd9
test_786_inp_1_2: .word 0xdf67a5e4
test_786_inp_2_1: .word 0x621e1e44
test_786_inp_2_2: .word 0x66d293af
test_786_ajit_res_1: .word 0x87c0c456
test_786_ajit_res_2: .word 0x6e7c2d3a
test_786_Cmodel_res_1: .word 0x0
test_786_Cmodel_res_2: .word 0x0

test_787_inp_1_1: .word 0xa48b56d5
test_787_inp_1_2: .word 0xcaf8d332
test_787_inp_2_1: .word 0x5766c62a
test_787_inp_2_2: .word 0x9917ae14
test_787_ajit_res_1: .word 0x8d13350d
test_787_ajit_res_2: .word 0x31ec1f15
test_787_Cmodel_res_1: .word 0x0
test_787_Cmodel_res_2: .word 0x0

test_788_inp_1_1: .word 0xb8bb8eca
test_788_inp_1_2: .word 0x9fa95002
test_788_inp_2_1: .word 0xf9fb8d01
test_788_inp_2_2: .word 0x4e864222
test_788_ajit_res_1: .word 0x0
test_788_ajit_res_2: .word 0x40042656
test_788_Cmodel_res_1: .word 0x0
test_788_Cmodel_res_2: .word 0x0

test_789_inp_1_1: .word 0x8bed8f6f
test_789_inp_1_2: .word 0xbacf798e
test_789_inp_2_1: .word 0xcbf80a6c
test_789_inp_2_2: .word 0xb0af44fd
test_789_ajit_res_1: .word 0x2758d
test_789_ajit_res_2: .word 0x31a68eff
test_789_Cmodel_res_1: .word 0x0
test_789_Cmodel_res_2: .word 0x0

test_790_inp_1_1: .word 0xc8affc6b
test_790_inp_1_2: .word 0xa716346
test_790_inp_2_1: .word 0x877200b4
test_790_inp_2_2: .word 0x4c559000
test_790_ajit_res_1: .word 0x7ff00000
test_790_ajit_res_2: .word 0x0
test_790_Cmodel_res_1: .word 0x0
test_790_Cmodel_res_2: .word 0x0

test_791_inp_1_1: .word 0x326d3567
test_791_inp_1_2: .word 0x45779803
test_791_inp_2_1: .word 0x290c1444
test_791_inp_2_2: .word 0xafd17f3
test_791_ajit_res_1: .word 0x4950a4c1
test_791_ajit_res_2: .word 0x74931c60
test_791_Cmodel_res_1: .word 0x0
test_791_Cmodel_res_2: .word 0x0

test_792_inp_1_1: .word 0xcdd51dec
test_792_inp_1_2: .word 0xa805ba61
test_792_inp_2_1: .word 0xdd4fd713
test_792_inp_2_2: .word 0xd5dd0955
test_792_ajit_res_1: .word 0x30753910
test_792_ajit_res_2: .word 0x9d9757d4
test_792_Cmodel_res_1: .word 0x0
test_792_Cmodel_res_2: .word 0x0

test_793_inp_1_1: .word 0x60f92c1a
test_793_inp_1_2: .word 0x8adc9c59
test_793_inp_2_1: .word 0x5687bf71
test_793_inp_2_2: .word 0xbd271321
test_793_ajit_res_1: .word 0x4a60f5b0
test_793_ajit_res_2: .word 0xef43ab9
test_793_Cmodel_res_1: .word 0x0
test_793_Cmodel_res_2: .word 0x0

test_794_inp_1_1: .word 0x538a9d47
test_794_inp_1_2: .word 0x8dd2e3ed
test_794_inp_2_1: .word 0x506a7c3c
test_794_inp_2_2: .word 0x10d81d6a
test_794_ajit_res_1: .word 0x431013f6
test_794_ajit_res_2: .word 0x73b6a31d
test_794_Cmodel_res_1: .word 0x0
test_794_Cmodel_res_2: .word 0x0

test_795_inp_1_1: .word 0xd7f099b5
test_795_inp_1_2: .word 0xeab6593f
test_795_inp_2_1: .word 0x941a670f
test_795_inp_2_2: .word 0xd3489a4d
test_795_ajit_res_1: .word 0x7ff00000
test_795_ajit_res_2: .word 0x0
test_795_Cmodel_res_1: .word 0x0
test_795_Cmodel_res_2: .word 0x0

test_796_inp_1_1: .word 0x5865b81e
test_796_inp_1_2: .word 0x3ad3f009
test_796_inp_2_1: .word 0x89cd2b0c
test_796_inp_2_2: .word 0x270975a9
test_796_ajit_res_1: .word 0xfff00000
test_796_ajit_res_2: .word 0x0
test_796_Cmodel_res_1: .word 0x0
test_796_Cmodel_res_2: .word 0x0

test_797_inp_1_1: .word 0x6610a36
test_797_inp_1_2: .word 0x30a88646
test_797_inp_2_1: .word 0x201f4ffa
test_797_inp_2_2: .word 0x6bb486ca
test_797_ajit_res_1: .word 0x26316a00
test_797_ajit_res_2: .word 0x3b3172f7
test_797_Cmodel_res_1: .word 0x0
test_797_Cmodel_res_2: .word 0x0

test_798_inp_1_1: .word 0xe753bf7e
test_798_inp_1_2: .word 0xf3d40dfa
test_798_inp_2_1: .word 0xa211ecd9
test_798_inp_2_2: .word 0x4c4d9b61
test_798_ajit_res_1: .word 0x7ff00000
test_798_ajit_res_2: .word 0x0
test_798_Cmodel_res_1: .word 0x0
test_798_Cmodel_res_2: .word 0x0

test_799_inp_1_1: .word 0xef4d36d3
test_799_inp_1_2: .word 0xca7bfb92
test_799_inp_2_1: .word 0x8b0379c4
test_799_inp_2_2: .word 0xdda9a8e5
test_799_ajit_res_1: .word 0x7ff00000
test_799_ajit_res_2: .word 0x0
test_799_Cmodel_res_1: .word 0x0
test_799_Cmodel_res_2: .word 0x0

test_800_inp_1_1: .word 0x40ec135
test_800_inp_1_2: .word 0x8dbb4bed
test_800_inp_2_1: .word 0x9d57e27d
test_800_inp_2_2: .word 0x2d7b663a
test_800_ajit_res_1: .word 0xa6a49a23
test_800_ajit_res_2: .word 0x9674a45b
test_800_Cmodel_res_1: .word 0x0
test_800_Cmodel_res_2: .word 0x0

test_801_inp_1_1: .word 0xe86534d1
test_801_inp_1_2: .word 0x53e2017
test_801_inp_2_1: .word 0x9adeb323
test_801_inp_2_2: .word 0x5f90b997
test_801_ajit_res_1: .word 0x7ff00000
test_801_ajit_res_2: .word 0x0
test_801_Cmodel_res_1: .word 0x0
test_801_Cmodel_res_2: .word 0x0

test_802_inp_1_1: .word 0xe7feb5eb
test_802_inp_1_2: .word 0x3cd9577d
test_802_inp_2_1: .word 0x9a88b9e1
test_802_inp_2_2: .word 0xc33c9a93
test_802_ajit_res_1: .word 0x7ff00000
test_802_ajit_res_2: .word 0x0
test_802_Cmodel_res_1: .word 0x0
test_802_Cmodel_res_2: .word 0x0

test_803_inp_1_1: .word 0x916b739
test_803_inp_1_2: .word 0x91133aa8
test_803_inp_2_1: .word 0x126de544
test_803_inp_2_2: .word 0xac10b6dd
test_803_ajit_res_1: .word 0x36985092
test_803_ajit_res_2: .word 0x87335dbc
test_803_Cmodel_res_1: .word 0x0
test_803_Cmodel_res_2: .word 0x0

test_804_inp_1_1: .word 0x786f3566
test_804_inp_1_2: .word 0x8d6a557b
test_804_inp_2_1: .word 0x59fac397
test_804_inp_2_2: .word 0x2e68bf11
test_804_ajit_res_1: .word 0x5e62a833
test_804_ajit_res_2: .word 0xdfcc0386
test_804_Cmodel_res_1: .word 0x0
test_804_Cmodel_res_2: .word 0x0

test_805_inp_1_1: .word 0xfe933f8b
test_805_inp_1_2: .word 0x97c5aefb
test_805_inp_2_1: .word 0x8b830154
test_805_inp_2_2: .word 0x3292fb66
test_805_ajit_res_1: .word 0x7ff00000
test_805_ajit_res_2: .word 0x0
test_805_Cmodel_res_1: .word 0x0
test_805_Cmodel_res_2: .word 0x0

test_806_inp_1_1: .word 0xcf4f05e4
test_806_inp_1_2: .word 0x74089e
test_806_inp_2_1: .word 0xea6eca2b
test_806_inp_2_2: .word 0x5a7b070f
test_806_ajit_res_1: .word 0x24d01f08
test_806_ajit_res_2: .word 0xce3eed28
test_806_Cmodel_res_1: .word 0x0
test_806_Cmodel_res_2: .word 0x0

test_807_inp_1_1: .word 0x56495615
test_807_inp_1_2: .word 0xff0bce05
test_807_inp_2_1: .word 0x803c21aa
test_807_inp_2_2: .word 0x9e74f8d9
test_807_ajit_res_1: .word 0xfff00000
test_807_ajit_res_2: .word 0x0
test_807_Cmodel_res_1: .word 0x0
test_807_Cmodel_res_2: .word 0x0

test_808_inp_1_1: .word 0x4909ec78
test_808_inp_1_2: .word 0xd70a1e32
test_808_inp_2_1: .word 0x8286b4bf
test_808_inp_2_2: .word 0x2af9c68e
test_808_ajit_res_1: .word 0xfff00000
test_808_ajit_res_2: .word 0x0
test_808_Cmodel_res_1: .word 0x0
test_808_Cmodel_res_2: .word 0x0

test_809_inp_1_1: .word 0x172c516b
test_809_inp_1_2: .word 0xd074cae9
test_809_inp_2_1: .word 0xce5c2e44
test_809_inp_2_2: .word 0xf1c3b93c
test_809_ajit_res_1: .word 0x88c013f5
test_809_ajit_res_2: .word 0x3b3ad879
test_809_Cmodel_res_1: .word 0x0
test_809_Cmodel_res_2: .word 0x0

test_810_inp_1_1: .word 0xf1cb8e3d
test_810_inp_1_2: .word 0xae3918ad
test_810_inp_2_1: .word 0xc616d3e0
test_810_inp_2_2: .word 0xbb8ee1dc
test_810_ajit_res_1: .word 0x6ba35059
test_810_ajit_res_2: .word 0x4f631d8c
test_810_Cmodel_res_1: .word 0x0
test_810_Cmodel_res_2: .word 0x0

test_811_inp_1_1: .word 0xbf95b0de
test_811_inp_1_2: .word 0xc011854
test_811_inp_2_1: .word 0xd2e44b17
test_811_inp_2_2: .word 0x8d9d8f64
test_811_ajit_res_1: .word 0x2ca11a15
test_811_ajit_res_2: .word 0x4917af8e
test_811_Cmodel_res_1: .word 0x0
test_811_Cmodel_res_2: .word 0x0

test_812_inp_1_1: .word 0xe7c78ee1
test_812_inp_1_2: .word 0x39340820
test_812_inp_2_1: .word 0x2b1ff014
test_812_inp_2_2: .word 0xe7206830
test_812_ajit_res_1: .word 0xfc979a9f
test_812_ajit_res_2: .word 0x1da3532d
test_812_Cmodel_res_1: .word 0x0
test_812_Cmodel_res_2: .word 0x0

test_813_inp_1_1: .word 0x25fd6d48
test_813_inp_1_2: .word 0x57de833f
test_813_inp_2_1: .word 0x17bd0e10
test_813_inp_2_2: .word 0xc34411f9
test_813_ajit_res_1: .word 0x4e30346f
test_813_ajit_res_2: .word 0x2a26e2df
test_813_Cmodel_res_1: .word 0x0
test_813_Cmodel_res_2: .word 0x0

test_814_inp_1_1: .word 0x4abe6b22
test_814_inp_1_2: .word 0xfd8a3188
test_814_inp_2_1: .word 0x8720b962
test_814_inp_2_2: .word 0x131a47eb
test_814_ajit_res_1: .word 0xfff00000
test_814_ajit_res_2: .word 0x0
test_814_Cmodel_res_1: .word 0x0
test_814_Cmodel_res_2: .word 0x0

test_815_inp_1_1: .word 0xf544a389
test_815_inp_1_2: .word 0x5821b33c
test_815_inp_2_1: .word 0xa6cf0aa9
test_815_inp_2_2: .word 0xa2ebf5a
test_815_ajit_res_1: .word 0x7ff00000
test_815_ajit_res_2: .word 0x0
test_815_Cmodel_res_1: .word 0x0
test_815_Cmodel_res_2: .word 0x0

test_816_inp_1_1: .word 0xe3fbf44c
test_816_inp_1_2: .word 0xc165bf12
test_816_inp_2_1: .word 0x8d39e46d
test_816_inp_2_2: .word 0x57b2f0ec
test_816_ajit_res_1: .word 0x7ff00000
test_816_ajit_res_2: .word 0x0
test_816_Cmodel_res_1: .word 0x0
test_816_Cmodel_res_2: .word 0x0

test_817_inp_1_1: .word 0x298bfa86
test_817_inp_1_2: .word 0x956f9215
test_817_inp_2_1: .word 0x6a80fdbd
test_817_inp_2_2: .word 0xe1016871
test_817_ajit_res_1: .word 0x6
test_817_ajit_res_2: .word 0x962cd5d4
test_817_Cmodel_res_1: .word 0x0
test_817_Cmodel_res_2: .word 0x0

test_818_inp_1_1: .word 0x38669f8f
test_818_inp_1_2: .word 0xc9d21917
test_818_inp_2_1: .word 0x7ab18bb2
test_818_inp_2_2: .word 0xd02f18e5
test_818_ajit_res_1: .word 0x0
test_818_ajit_res_2: .word 0x2942
test_818_Cmodel_res_1: .word 0x0
test_818_Cmodel_res_2: .word 0x0

test_819_inp_1_1: .word 0x67bbb4b9
test_819_inp_1_2: .word 0x3b6a412b
test_819_inp_2_1: .word 0x84e97da0
test_819_inp_2_2: .word 0xa57bbf69
test_819_ajit_res_1: .word 0xfff00000
test_819_ajit_res_2: .word 0x0
test_819_Cmodel_res_1: .word 0x0
test_819_Cmodel_res_2: .word 0x0

test_820_inp_1_1: .word 0x3b260306
test_820_inp_1_2: .word 0x9b8d8a21
test_820_inp_2_1: .word 0x411fd4ef
test_820_inp_2_2: .word 0xb6763975
test_820_ajit_res_1: .word 0x39f620cd
test_820_ajit_res_2: .word 0xf38de626
test_820_Cmodel_res_1: .word 0x0
test_820_Cmodel_res_2: .word 0x0

test_821_inp_1_1: .word 0xb17b444c
test_821_inp_1_2: .word 0x6a5eb1d7
test_821_inp_2_1: .word 0x816a4aac
test_821_inp_2_2: .word 0x81f49974
test_821_ajit_res_1: .word 0x700097e9
test_821_ajit_res_2: .word 0x2ed1d648
test_821_Cmodel_res_1: .word 0x0
test_821_Cmodel_res_2: .word 0x0

test_822_inp_1_1: .word 0x94d6ca4a
test_822_inp_1_2: .word 0x3a880966
test_822_inp_2_1: .word 0x2906a9a6
test_822_inp_2_2: .word 0xc3b80f4
test_822_ajit_res_1: .word 0xabc0170b
test_822_ajit_res_2: .word 0x8400d70e
test_822_Cmodel_res_1: .word 0x0
test_822_Cmodel_res_2: .word 0x0

test_823_inp_1_1: .word 0xe67efcef
test_823_inp_1_2: .word 0xb11d0eff
test_823_inp_2_1: .word 0xa023dd1f
test_823_inp_2_2: .word 0x5ea76b22
test_823_ajit_res_1: .word 0x7ff00000
test_823_ajit_res_2: .word 0x0
test_823_Cmodel_res_1: .word 0x0
test_823_Cmodel_res_2: .word 0x0

test_824_inp_1_1: .word 0xfefd9858
test_824_inp_1_2: .word 0x3e4a3efa
test_824_inp_2_1: .word 0xa831c462
test_824_inp_2_2: .word 0xf3685407
test_824_ajit_res_1: .word 0x7ff00000
test_824_ajit_res_2: .word 0x0
test_824_Cmodel_res_1: .word 0x0
test_824_Cmodel_res_2: .word 0x0

test_825_inp_1_1: .word 0x34d32288
test_825_inp_1_2: .word 0xfc63a064
test_825_inp_2_1: .word 0x22de3b81
test_825_inp_2_2: .word 0x7d37fe24
test_825_ajit_res_1: .word 0x51e440ee
test_825_ajit_res_2: .word 0x336a24cd
test_825_Cmodel_res_1: .word 0x0
test_825_Cmodel_res_2: .word 0x0

test_826_inp_1_1: .word 0xde7b3b63
test_826_inp_1_2: .word 0x57360f6f
test_826_inp_2_1: .word 0x462844ca
test_826_inp_2_2: .word 0x2c9458b1
test_826_ajit_res_1: .word 0xd841f421
test_826_ajit_res_2: .word 0xf1d54338
test_826_Cmodel_res_1: .word 0x0
test_826_Cmodel_res_2: .word 0x0

test_827_inp_1_1: .word 0x271c7522
test_827_inp_1_2: .word 0xbe36f6b8
test_827_inp_2_1: .word 0xda802e1
test_827_inp_2_2: .word 0xc28a3555
test_827_ajit_res_1: .word 0x5962f67a
test_827_ajit_res_2: .word 0xe970a452
test_827_Cmodel_res_1: .word 0x0
test_827_Cmodel_res_2: .word 0x0

test_828_inp_1_1: .word 0x78ab90dd
test_828_inp_1_2: .word 0xdee3a4d8
test_828_inp_2_1: .word 0x9c0a190f
test_828_inp_2_2: .word 0x20e5591
test_828_ajit_res_1: .word 0xfff00000
test_828_ajit_res_2: .word 0x0
test_828_Cmodel_res_1: .word 0x0
test_828_Cmodel_res_2: .word 0x0

test_829_inp_1_1: .word 0x4f8e8715
test_829_inp_1_2: .word 0xfc094e2a
test_829_inp_2_1: .word 0x5f99182a
test_829_inp_2_2: .word 0xd00b9636
test_829_ajit_res_1: .word 0x2fe376d6
test_829_ajit_res_2: .word 0xcfdb495b
test_829_Cmodel_res_1: .word 0x0
test_829_Cmodel_res_2: .word 0x0

test_830_inp_1_1: .word 0xbf8fb6a9
test_830_inp_1_2: .word 0xdf46e39
test_830_inp_2_1: .word 0xdbb7c5f
test_830_inp_2_2: .word 0xfe7928a5
test_830_ajit_res_1: .word 0xf1c27604
test_830_ajit_res_2: .word 0x89be04e8
test_830_Cmodel_res_1: .word 0x0
test_830_Cmodel_res_2: .word 0x0

test_831_inp_1_1: .word 0xb219ee65
test_831_inp_1_2: .word 0x1851842
test_831_inp_2_1: .word 0x4758f759
test_831_inp_2_2: .word 0x8c2c42f2
test_831_ajit_res_1: .word 0xaab09e52
test_831_ajit_res_2: .word 0x9823ce66
test_831_Cmodel_res_1: .word 0x0
test_831_Cmodel_res_2: .word 0x0

test_832_inp_1_1: .word 0x7a9abf85
test_832_inp_1_2: .word 0xce350382
test_832_inp_2_1: .word 0x89af037c
test_832_inp_2_2: .word 0x7a93c905
test_832_ajit_res_1: .word 0xfff00000
test_832_ajit_res_2: .word 0x0
test_832_Cmodel_res_1: .word 0x0
test_832_Cmodel_res_2: .word 0x0

test_833_inp_1_1: .word 0xe1e9ed2c
test_833_inp_1_2: .word 0x2faabfae
test_833_inp_2_1: .word 0x3de56557
test_833_inp_2_2: .word 0x480dc151
test_833_ajit_res_1: .word 0xe3f36354
test_833_ajit_res_2: .word 0xdeda8bc8
test_833_Cmodel_res_1: .word 0x0
test_833_Cmodel_res_2: .word 0x0

test_834_inp_1_1: .word 0x56d71f93
test_834_inp_1_2: .word 0xd22f7e09
test_834_inp_2_1: .word 0xea740c36
test_834_inp_2_2: .word 0x94ff82b5
test_834_ajit_res_1: .word 0xac527464
test_834_ajit_res_2: .word 0x74edee5e
test_834_Cmodel_res_1: .word 0x0
test_834_Cmodel_res_2: .word 0x0

test_835_inp_1_1: .word 0xf3e502e4
test_835_inp_1_2: .word 0x80f4c11
test_835_inp_2_1: .word 0xb2daa47e
test_835_inp_2_2: .word 0xc7dc76c9
test_835_ajit_res_1: .word 0x7ff00000
test_835_ajit_res_2: .word 0x0
test_835_Cmodel_res_1: .word 0x0
test_835_Cmodel_res_2: .word 0x0

test_836_inp_1_1: .word 0x20224cc1
test_836_inp_1_2: .word 0xe9c2e350
test_836_inp_2_1: .word 0x635d889d
test_836_inp_2_2: .word 0x23efb296
test_836_ajit_res_1: .word 0x0
test_836_ajit_res_2: .word 0x0
test_836_Cmodel_res_1: .word 0x0
test_836_Cmodel_res_2: .word 0x0

test_837_inp_1_1: .word 0x8aa15c36
test_837_inp_1_2: .word 0x75a937a
test_837_inp_2_1: .word 0x7ac0cdb
test_837_inp_2_2: .word 0x9e27b8dc
test_837_ajit_res_1: .word 0xc2e3ce00
test_837_ajit_res_2: .word 0xfa970f7b
test_837_Cmodel_res_1: .word 0x0
test_837_Cmodel_res_2: .word 0x0

test_838_inp_1_1: .word 0x66c3363f
test_838_inp_1_2: .word 0xca897feb
test_838_inp_2_1: .word 0x8de4b78d
test_838_inp_2_2: .word 0xd716f7d4
test_838_ajit_res_1: .word 0xfff00000
test_838_ajit_res_2: .word 0x0
test_838_Cmodel_res_1: .word 0x0
test_838_Cmodel_res_2: .word 0x0

test_839_inp_1_1: .word 0xbf3d180f
test_839_inp_1_2: .word 0x1ab03009
test_839_inp_2_1: .word 0x195bdfbf
test_839_inp_2_2: .word 0x4ada7229
test_839_ajit_res_1: .word 0xe5d0b345
test_839_ajit_res_2: .word 0x3f9fc932
test_839_Cmodel_res_1: .word 0x0
test_839_Cmodel_res_2: .word 0x0

test_840_inp_1_1: .word 0x73302be5
test_840_inp_1_2: .word 0x5f05f714
test_840_inp_2_1: .word 0x44abcd4c
test_840_inp_2_2: .word 0x99d0b9fa
test_840_ajit_res_1: .word 0x6e729d03
test_840_ajit_res_2: .word 0x7df4e575
test_840_Cmodel_res_1: .word 0x0
test_840_Cmodel_res_2: .word 0x0

test_841_inp_1_1: .word 0xda0ed28d
test_841_inp_1_2: .word 0x7d8f59c7
test_841_inp_2_1: .word 0x87d21cf3
test_841_inp_2_2: .word 0x42f2d6b4
test_841_ajit_res_1: .word 0x7ff00000
test_841_ajit_res_2: .word 0x0
test_841_Cmodel_res_1: .word 0x0
test_841_Cmodel_res_2: .word 0x0

test_842_inp_1_1: .word 0x59940152
test_842_inp_1_2: .word 0xc63b8f10
test_842_inp_2_1: .word 0x92401c4a
test_842_inp_2_2: .word 0xe4aa3c0e
test_842_ajit_res_1: .word 0xfff00000
test_842_ajit_res_2: .word 0x0
test_842_Cmodel_res_1: .word 0x0
test_842_Cmodel_res_2: .word 0x0

test_843_inp_1_1: .word 0xf6d876c
test_843_inp_1_2: .word 0x7792ceaa
test_843_inp_2_1: .word 0xade52dbb
test_843_inp_2_2: .word 0x117501b7
test_843_ajit_res_1: .word 0xa1764efb
test_843_ajit_res_2: .word 0xdc22e82
test_843_Cmodel_res_1: .word 0x0
test_843_Cmodel_res_2: .word 0x0

test_844_inp_1_1: .word 0x715e51fa
test_844_inp_1_2: .word 0xb9f8d265
test_844_inp_2_1: .word 0x3387952e
test_844_inp_2_2: .word 0x1df11a81
test_844_ajit_res_1: .word 0x7dc49236
test_844_ajit_res_2: .word 0x2628e517
test_844_Cmodel_res_1: .word 0x0
test_844_Cmodel_res_2: .word 0x0

test_845_inp_1_1: .word 0x4bbedd61
test_845_inp_1_2: .word 0xcce47a77
test_845_inp_2_1: .word 0x135bb36f
test_845_inp_2_2: .word 0x27abcf43
test_845_ajit_res_1: .word 0x7851d3d3
test_845_ajit_res_2: .word 0xf5cd0bd
test_845_Cmodel_res_1: .word 0x0
test_845_Cmodel_res_2: .word 0x0

test_846_inp_1_1: .word 0x51dfbab4
test_846_inp_1_2: .word 0x7882b35d
test_846_inp_2_1: .word 0xe85aeaa6
test_846_inp_2_2: .word 0xe442c17b
test_846_ajit_res_1: .word 0xa972dc5e
test_846_ajit_res_2: .word 0x120e96cf
test_846_Cmodel_res_1: .word 0x0
test_846_Cmodel_res_2: .word 0x0

test_847_inp_1_1: .word 0xba75d4b9
test_847_inp_1_2: .word 0x46ce1a8d
test_847_inp_2_1: .word 0x73d3b0b1
test_847_inp_2_2: .word 0x4f6485f8
test_847_ajit_res_1: .word 0x8691bd52
test_847_ajit_res_2: .word 0xa47cdc49
test_847_Cmodel_res_1: .word 0x0
test_847_Cmodel_res_2: .word 0x0

test_848_inp_1_1: .word 0x5ff46045
test_848_inp_1_2: .word 0xbdffea56
test_848_inp_2_1: .word 0x8ef0463d
test_848_inp_2_2: .word 0x34304002
test_848_ajit_res_1: .word 0xfff00000
test_848_ajit_res_2: .word 0x0
test_848_Cmodel_res_1: .word 0x0
test_848_Cmodel_res_2: .word 0x0

test_849_inp_1_1: .word 0xe9a8efa4
test_849_inp_1_2: .word 0x723a80a7
test_849_inp_2_1: .word 0x47f511f4
test_849_inp_2_2: .word 0x9ca63c66
test_849_ajit_res_1: .word 0xe1a2ef89
test_849_ajit_res_2: .word 0x7b4b3050
test_849_Cmodel_res_1: .word 0x0
test_849_Cmodel_res_2: .word 0x0

test_850_inp_1_1: .word 0xffcaae11
test_850_inp_1_2: .word 0x26aa8967
test_850_inp_2_1: .word 0x9cff6503
test_850_inp_2_2: .word 0x340365b5
test_850_ajit_res_1: .word 0x7ff00000
test_850_ajit_res_2: .word 0x0
test_850_Cmodel_res_1: .word 0x0
test_850_Cmodel_res_2: .word 0x0

test_851_inp_1_1: .word 0xfdc590b6
test_851_inp_1_2: .word 0x55aa7cc8
test_851_inp_2_1: .word 0xb622c4b9
test_851_inp_2_2: .word 0x28651a31
test_851_ajit_res_1: .word 0x7ff00000
test_851_ajit_res_2: .word 0x0
test_851_Cmodel_res_1: .word 0x0
test_851_Cmodel_res_2: .word 0x0

test_852_inp_1_1: .word 0x8c8d9465
test_852_inp_1_2: .word 0x696953e5
test_852_inp_2_1: .word 0x48089c1d
test_852_inp_2_2: .word 0x6397d802
test_852_ajit_res_1: .word 0x84733b2b
test_852_ajit_res_2: .word 0x7483f235
test_852_Cmodel_res_1: .word 0x0
test_852_Cmodel_res_2: .word 0x0

test_853_inp_1_1: .word 0xf8f1922e
test_853_inp_1_2: .word 0x9d6c9741
test_853_inp_2_1: .word 0x99213a37
test_853_inp_2_2: .word 0x75c5be2f
test_853_ajit_res_1: .word 0x7ff00000
test_853_ajit_res_2: .word 0x0
test_853_Cmodel_res_1: .word 0x0
test_853_Cmodel_res_2: .word 0x0

test_854_inp_1_1: .word 0xc82d74af
test_854_inp_1_2: .word 0xe2fadeee
test_854_inp_2_1: .word 0x95b7494b
test_854_inp_2_2: .word 0xf9f350d3
test_854_ajit_res_1: .word 0x72643d32
test_854_ajit_res_2: .word 0x7b8f880c
test_854_Cmodel_res_1: .word 0x0
test_854_Cmodel_res_2: .word 0x0

test_855_inp_1_1: .word 0x802d1310
test_855_inp_1_2: .word 0x172fcb51
test_855_inp_2_1: .word 0x3da784e4
test_855_inp_2_2: .word 0xc4976087
test_855_ajit_res_1: .word 0x8273c77f
test_855_ajit_res_2: .word 0x9977edc4
test_855_Cmodel_res_1: .word 0x0
test_855_Cmodel_res_2: .word 0x0

test_856_inp_1_1: .word 0xb8bf4619
test_856_inp_1_2: .word 0xac3c17ad
test_856_inp_2_1: .word 0x462eae51
test_856_inp_2_2: .word 0x5b1024c2
test_856_ajit_res_1: .word 0xb2804f27
test_856_ajit_res_2: .word 0x6fe6dc9a
test_856_Cmodel_res_1: .word 0x0
test_856_Cmodel_res_2: .word 0x0

test_857_inp_1_1: .word 0x6bcce705
test_857_inp_1_2: .word 0x51013323
test_857_inp_2_1: .word 0xddbc6ea8
test_857_inp_2_2: .word 0xe819985
test_857_ajit_res_1: .word 0xce0043bb
test_857_ajit_res_2: .word 0xe42bcd80
test_857_Cmodel_res_1: .word 0x0
test_857_Cmodel_res_2: .word 0x0

test_858_inp_1_1: .word 0xfa6a2f35
test_858_inp_1_2: .word 0x2508c6b9
test_858_inp_2_1: .word 0x9bf5b9cb
test_858_inp_2_2: .word 0xa74c5974
test_858_ajit_res_1: .word 0x7ff00000
test_858_ajit_res_2: .word 0x0
test_858_Cmodel_res_1: .word 0x0
test_858_Cmodel_res_2: .word 0x0

test_859_inp_1_1: .word 0xfcd385cb
test_859_inp_1_2: .word 0x94ce76b6
test_859_inp_2_1: .word 0xc80bdfe5
test_859_inp_2_2: .word 0xf11a87db
test_859_ajit_res_1: .word 0x74b66976
test_859_ajit_res_2: .word 0xc8b2c16
test_859_Cmodel_res_1: .word 0x0
test_859_Cmodel_res_2: .word 0x0

test_860_inp_1_1: .word 0xb535a99b
test_860_inp_1_2: .word 0xd8594034
test_860_inp_2_1: .word 0xbe6d7c4b
test_860_inp_2_2: .word 0x2ed77fb4
test_860_ajit_res_1: .word 0x36b78287
test_860_ajit_res_2: .word 0x8331fd20
test_860_Cmodel_res_1: .word 0x0
test_860_Cmodel_res_2: .word 0x0

test_861_inp_1_1: .word 0xd3b6c058
test_861_inp_1_2: .word 0x173f81b7
test_861_inp_2_1: .word 0x79df88b4
test_861_inp_2_2: .word 0x7e2f7374
test_861_ajit_res_1: .word 0x99c71669
test_861_ajit_res_2: .word 0xeb53b298
test_861_Cmodel_res_1: .word 0x0
test_861_Cmodel_res_2: .word 0x0

test_862_inp_1_1: .word 0x7f9a2026
test_862_inp_1_2: .word 0x214cec66
test_862_inp_2_1: .word 0x88669eb4
test_862_inp_2_2: .word 0xfbc5ac3e
test_862_ajit_res_1: .word 0xfff00000
test_862_ajit_res_2: .word 0x0
test_862_Cmodel_res_1: .word 0x0
test_862_Cmodel_res_2: .word 0x0

test_863_inp_1_1: .word 0xbad21e85
test_863_inp_1_2: .word 0xf9f353c5
test_863_inp_2_1: .word 0xb1016da1
test_863_inp_2_2: .word 0x2ce8e422
test_863_ajit_res_1: .word 0x49c0a265
test_863_ajit_res_2: .word 0xb89f575d
test_863_Cmodel_res_1: .word 0x0
test_863_Cmodel_res_2: .word 0x0

test_864_inp_1_1: .word 0xfcc84c77
test_864_inp_1_2: .word 0xf40c6050
test_864_inp_2_1: .word 0x8b8b167f
test_864_inp_2_2: .word 0x4dd66c90
test_864_ajit_res_1: .word 0x7ff00000
test_864_ajit_res_2: .word 0x0
test_864_Cmodel_res_1: .word 0x0
test_864_Cmodel_res_2: .word 0x0

test_865_inp_1_1: .word 0x8d4f769f
test_865_inp_1_2: .word 0xb0fa908d
test_865_inp_2_1: .word 0x10587fdc
test_865_inp_2_2: .word 0x2ef6e6ec
test_865_ajit_res_1: .word 0xbce48c47
test_865_ajit_res_2: .word 0xa226c2aa
test_865_Cmodel_res_1: .word 0x0
test_865_Cmodel_res_2: .word 0x0

test_866_inp_1_1: .word 0x508e02c3
test_866_inp_1_2: .word 0xa25f7238
test_866_inp_2_1: .word 0x253d6365
test_866_inp_2_2: .word 0xd93842dc
test_866_ajit_res_1: .word 0x6b4056c3
test_866_ajit_res_2: .word 0xbc8a849b
test_866_Cmodel_res_1: .word 0x0
test_866_Cmodel_res_2: .word 0x0

test_867_inp_1_1: .word 0xf5cae915
test_867_inp_1_2: .word 0x7cdea51b
test_867_inp_2_1: .word 0x85befc59
test_867_inp_2_2: .word 0xc80f3e91
test_867_ajit_res_1: .word 0x7ff00000
test_867_ajit_res_2: .word 0x0
test_867_Cmodel_res_1: .word 0x0
test_867_Cmodel_res_2: .word 0x0

test_868_inp_1_1: .word 0x140d988f
test_868_inp_1_2: .word 0x3b6f4255
test_868_inp_2_1: .word 0x28686a1a
test_868_inp_2_2: .word 0x45a1a991
test_868_ajit_res_1: .word 0x2b93654a
test_868_ajit_res_2: .word 0xe18ef897
test_868_Cmodel_res_1: .word 0x0
test_868_Cmodel_res_2: .word 0x0

test_869_inp_1_1: .word 0x6e9e0123
test_869_inp_1_2: .word 0x71ea276d
test_869_inp_2_1: .word 0x9867091b
test_869_inp_2_2: .word 0x19ab8863
test_869_ajit_res_1: .word 0xfff00000
test_869_ajit_res_2: .word 0x0
test_869_Cmodel_res_1: .word 0x0
test_869_Cmodel_res_2: .word 0x0

test_870_inp_1_1: .word 0x62bea773
test_870_inp_1_2: .word 0x58713f10
test_870_inp_2_1: .word 0x6cf7673d
test_870_inp_2_2: .word 0xb7b0196e
test_870_ajit_res_1: .word 0x35b4f506
test_870_ajit_res_2: .word 0x5f13529b
test_870_Cmodel_res_1: .word 0x0
test_870_Cmodel_res_2: .word 0x0

test_871_inp_1_1: .word 0xa3633f98
test_871_inp_1_2: .word 0x72d14c19
test_871_inp_2_1: .word 0xe65aae68
test_871_inp_2_2: .word 0x4e66c8c1
test_871_ajit_res_1: .word 0x0
test_871_ajit_res_2: .word 0x5
test_871_Cmodel_res_1: .word 0x0
test_871_Cmodel_res_2: .word 0x0

test_872_inp_1_1: .word 0xd40ccb7d
test_872_inp_1_2: .word 0xfff3711d
test_872_inp_2_1: .word 0x292c9f8c
test_872_inp_2_2: .word 0x778d70bf
test_872_ajit_res_1: .word 0xead01890
test_872_ajit_res_2: .word 0x55f315b8
test_872_Cmodel_res_1: .word 0x0
test_872_Cmodel_res_2: .word 0x0

test_873_inp_1_1: .word 0x418e9751
test_873_inp_1_2: .word 0xfe2afd8a
test_873_inp_2_1: .word 0x51c97074
test_873_inp_2_2: .word 0x9d3a8af1
test_873_ajit_res_1: .word 0x2fb33d7f
test_873_ajit_res_2: .word 0x8944e079
test_873_Cmodel_res_1: .word 0x0
test_873_Cmodel_res_2: .word 0x0

test_874_inp_1_1: .word 0xab8adb59
test_874_inp_1_2: .word 0x6837d94d
test_874_inp_2_1: .word 0x9a666dc3
test_874_inp_2_2: .word 0xa74645bf
test_874_ajit_res_1: .word 0x511328aa
test_874_ajit_res_2: .word 0x4058b331
test_874_Cmodel_res_1: .word 0x0
test_874_Cmodel_res_2: .word 0x0

test_875_inp_1_1: .word 0xa1efbf68
test_875_inp_1_2: .word 0xc33bb080
test_875_inp_2_1: .word 0x122df6c2
test_875_inp_2_2: .word 0x6583e7e1
test_875_ajit_res_1: .word 0xcfb0f3d7
test_875_ajit_res_2: .word 0x9570bcb
test_875_Cmodel_res_1: .word 0x0
test_875_Cmodel_res_2: .word 0x0

test_876_inp_1_1: .word 0xdd977691
test_876_inp_1_2: .word 0x35b960c4
test_876_inp_2_1: .word 0x862f71a3
test_876_inp_2_2: .word 0x1398a305
test_876_ajit_res_1: .word 0x7ff00000
test_876_ajit_res_2: .word 0x0
test_876_Cmodel_res_1: .word 0x0
test_876_Cmodel_res_2: .word 0x0

test_877_inp_1_1: .word 0xf6ffca3f
test_877_inp_1_2: .word 0x5324b025
test_877_inp_2_1: .word 0xaf91b54f
test_877_inp_2_2: .word 0xd2a05005
test_877_ajit_res_1: .word 0x7ff00000
test_877_ajit_res_2: .word 0x0
test_877_Cmodel_res_1: .word 0x0
test_877_Cmodel_res_2: .word 0x0

test_878_inp_1_1: .word 0xf8a20d64
test_878_inp_1_2: .word 0x15b042b3
test_878_inp_2_1: .word 0x9de7e176
test_878_inp_2_2: .word 0x6431eef6
test_878_ajit_res_1: .word 0x7ff00000
test_878_ajit_res_2: .word 0x0
test_878_Cmodel_res_1: .word 0x0
test_878_Cmodel_res_2: .word 0x0

test_879_inp_1_1: .word 0xa03f5440
test_879_inp_1_2: .word 0xfc69e679
test_879_inp_2_1: .word 0x969315
test_879_inp_2_2: .word 0x4ccd8bf5
test_879_ajit_res_1: .word 0xdf963475
test_879_ajit_res_2: .word 0x6d2d4ad9
test_879_Cmodel_res_1: .word 0x0
test_879_Cmodel_res_2: .word 0x0

test_880_inp_1_1: .word 0xf3921b3b
test_880_inp_1_2: .word 0x7c641882
test_880_inp_2_1: .word 0x8d29bf4b
test_880_inp_2_2: .word 0xf0ecb033
test_880_ajit_res_1: .word 0x7ff00000
test_880_ajit_res_2: .word 0x0
test_880_Cmodel_res_1: .word 0x0
test_880_Cmodel_res_2: .word 0x0

test_881_inp_1_1: .word 0xf3b03695
test_881_inp_1_2: .word 0xf4324e38
test_881_inp_2_1: .word 0x6e8f781e
test_881_inp_2_2: .word 0xd3c6a4a4
test_881_ajit_res_1: .word 0xc5107c97
test_881_ajit_res_2: .word 0x96881429
test_881_Cmodel_res_1: .word 0x0
test_881_Cmodel_res_2: .word 0x0

test_882_inp_1_1: .word 0xfedabf3e
test_882_inp_1_2: .word 0xa1f616ac
test_882_inp_2_1: .word 0x8bc3d61d
test_882_inp_2_2: .word 0xc0e7d181
test_882_ajit_res_1: .word 0x7ff00000
test_882_ajit_res_2: .word 0x0
test_882_Cmodel_res_1: .word 0x0
test_882_Cmodel_res_2: .word 0x0

test_883_inp_1_1: .word 0x5e37a374
test_883_inp_1_2: .word 0xc4a17273
test_883_inp_2_1: .word 0xb823dfe2
test_883_inp_2_2: .word 0xb394cc57
test_883_ajit_res_1: .word 0xe60307b8
test_883_ajit_res_2: .word 0xd8f87ca2
test_883_Cmodel_res_1: .word 0x0
test_883_Cmodel_res_2: .word 0x0

test_884_inp_1_1: .word 0xda2f808d
test_884_inp_1_2: .word 0x1a2e931b
test_884_inp_2_1: .word 0x9574ec35
test_884_inp_2_2: .word 0x882768fd
test_884_ajit_res_1: .word 0x7ff00000
test_884_ajit_res_2: .word 0x0
test_884_Cmodel_res_1: .word 0x0
test_884_Cmodel_res_2: .word 0x0

test_885_inp_1_1: .word 0x20400558
test_885_inp_1_2: .word 0x8cd67adf
test_885_inp_2_1: .word 0xa57d4cfe
test_885_inp_2_2: .word 0xc4de81ea
test_885_ajit_res_1: .word 0xbab17f2b
test_885_ajit_res_2: .word 0x47b968ab
test_885_Cmodel_res_1: .word 0x0
test_885_Cmodel_res_2: .word 0x0

test_886_inp_1_1: .word 0x7f331088
test_886_inp_1_2: .word 0x1609b6f6
test_886_inp_2_1: .word 0xb1c33340
test_886_inp_2_2: .word 0x2a0d81b
test_886_ajit_res_1: .word 0xfff00000
test_886_ajit_res_2: .word 0x0
test_886_Cmodel_res_1: .word 0x0
test_886_Cmodel_res_2: .word 0x0

test_887_inp_1_1: .word 0x66616c5a
test_887_inp_1_2: .word 0xd015caaf
test_887_inp_2_1: .word 0x8f145111
test_887_inp_2_2: .word 0x8c66aafa
test_887_ajit_res_1: .word 0xfff00000
test_887_ajit_res_2: .word 0x0
test_887_Cmodel_res_1: .word 0x0
test_887_Cmodel_res_2: .word 0x0

test_888_inp_1_1: .word 0xbdb5113d
test_888_inp_1_2: .word 0x8b122d57
test_888_inp_2_1: .word 0x15936754
test_888_inp_2_2: .word 0x8bfbccd
test_888_ajit_res_1: .word 0xe8115f33
test_888_ajit_res_2: .word 0xbd367e2e
test_888_Cmodel_res_1: .word 0x0
test_888_Cmodel_res_2: .word 0x0

test_889_inp_1_1: .word 0xa36aee0f
test_889_inp_1_2: .word 0xae6ad263
test_889_inp_2_1: .word 0x64bcae68
test_889_inp_2_2: .word 0x8fc0ff07
test_889_ajit_res_1: .word 0x80000000
test_889_ajit_res_2: .word 0x1e0bc643
test_889_Cmodel_res_1: .word 0x0
test_889_Cmodel_res_2: .word 0x0

test_890_inp_1_1: .word 0xf00b51ed
test_890_inp_1_2: .word 0xb86222bf
test_890_inp_2_1: .word 0x8d5af4b7
test_890_inp_2_2: .word 0x6db9a93a
test_890_ajit_res_1: .word 0x7ff00000
test_890_ajit_res_2: .word 0x0
test_890_Cmodel_res_1: .word 0x0
test_890_Cmodel_res_2: .word 0x0

test_891_inp_1_1: .word 0x1c28af8f
test_891_inp_1_2: .word 0xb3afb126
test_891_inp_2_1: .word 0xdf598949
test_891_inp_2_2: .word 0x7e8867c4
test_891_ajit_res_1: .word 0x80000000
test_891_ajit_res_2: .word 0x0
test_891_Cmodel_res_1: .word 0x0
test_891_Cmodel_res_2: .word 0x0

test_892_inp_1_1: .word 0xab5c96a4
test_892_inp_1_2: .word 0x37e76ad6
test_892_inp_2_1: .word 0x390bd669
test_892_inp_2_2: .word 0xc80ed183
test_892_ajit_res_1: .word 0xb2406e7c
test_892_ajit_res_2: .word 0x59074fc5
test_892_Cmodel_res_1: .word 0x0
test_892_Cmodel_res_2: .word 0x0

test_893_inp_1_1: .word 0x467cd00c
test_893_inp_1_2: .word 0x47483019
test_893_inp_2_1: .word 0x996cb5c7
test_893_inp_2_2: .word 0x87bb8639
test_893_ajit_res_1: .word 0xed000ea3
test_893_ajit_res_2: .word 0xac401e9f
test_893_Cmodel_res_1: .word 0x0
test_893_Cmodel_res_2: .word 0x0

test_894_inp_1_1: .word 0xb3805c39
test_894_inp_1_2: .word 0xa4c7d28b
test_894_inp_2_1: .word 0x75975e27
test_894_inp_2_2: .word 0x23f79fee
test_894_ajit_res_1: .word 0x80000000
test_894_ajit_res_2: .word 0x16676
test_894_Cmodel_res_1: .word 0x0
test_894_Cmodel_res_2: .word 0x0

test_895_inp_1_1: .word 0xeb851184
test_895_inp_1_2: .word 0xf5b0da73
test_895_inp_2_1: .word 0x817ff26a
test_895_inp_2_2: .word 0x52d4707
test_895_ajit_res_1: .word 0x7ff00000
test_895_ajit_res_2: .word 0x0
test_895_Cmodel_res_1: .word 0x0
test_895_Cmodel_res_2: .word 0x0

test_896_inp_1_1: .word 0x37bef210
test_896_inp_1_2: .word 0x5c45261e
test_896_inp_2_1: .word 0xe8f89284
test_896_inp_2_2: .word 0x1ed3ebd2
test_896_ajit_res_1: .word 0x8eb4265d
test_896_ajit_res_2: .word 0x43ee0550
test_896_Cmodel_res_1: .word 0x0
test_896_Cmodel_res_2: .word 0x0

test_897_inp_1_1: .word 0xceeec450
test_897_inp_1_2: .word 0x75aacedd
test_897_inp_2_1: .word 0x10a9cf23
test_897_inp_2_2: .word 0xfe298c00
test_897_ajit_res_1: .word 0xfe3312ce
test_897_ajit_res_2: .word 0x3e41610d
test_897_Cmodel_res_1: .word 0x0
test_897_Cmodel_res_2: .word 0x0

test_898_inp_1_1: .word 0xadae329c
test_898_inp_1_2: .word 0xf62020b7
test_898_inp_2_1: .word 0xc52ad0a5
test_898_inp_2_2: .word 0x19bead36
test_898_ajit_res_1: .word 0x287204b4
test_898_ajit_res_2: .word 0xd4cb9e97
test_898_Cmodel_res_1: .word 0x0
test_898_Cmodel_res_2: .word 0x0

test_899_inp_1_1: .word 0xd8c86de1
test_899_inp_1_2: .word 0x34067a53
test_899_inp_2_1: .word 0x9330d282
test_899_inp_2_2: .word 0x3c748267
test_899_ajit_res_1: .word 0x7ff00000
test_899_ajit_res_2: .word 0x0
test_899_Cmodel_res_1: .word 0x0
test_899_Cmodel_res_2: .word 0x0

test_900_inp_1_1: .word 0xd8b10940
test_900_inp_1_2: .word 0x1f71573d
test_900_inp_2_1: .word 0x891ceb40
test_900_inp_2_2: .word 0xdc5bdad3
test_900_ajit_res_1: .word 0x7ff00000
test_900_ajit_res_2: .word 0x0
test_900_Cmodel_res_1: .word 0x0
test_900_Cmodel_res_2: .word 0x0

test_901_inp_1_1: .word 0x394ca42b
test_901_inp_1_2: .word 0xf51230d9
test_901_inp_2_1: .word 0x3eeb09e2
test_901_inp_2_2: .word 0xa59f02f8
test_901_ajit_res_1: .word 0x3a50f2c9
test_901_ajit_res_2: .word 0x127af4e6
test_901_Cmodel_res_1: .word 0x0
test_901_Cmodel_res_2: .word 0x0

test_902_inp_1_1: .word 0x5f7f8eff
test_902_inp_1_2: .word 0x7a3bfeb8
test_902_inp_2_1: .word 0xed0bcab5
test_902_inp_2_2: .word 0x3b6d2745
test_902_ajit_res_1: .word 0xb2622b26
test_902_ajit_res_2: .word 0x771b4d2f
test_902_Cmodel_res_1: .word 0x0
test_902_Cmodel_res_2: .word 0x0

test_903_inp_1_1: .word 0x51651165
test_903_inp_1_2: .word 0xd662f046
test_903_inp_2_1: .word 0x83528e0b
test_903_inp_2_2: .word 0x1336e426
test_903_ajit_res_1: .word 0xfff00000
test_903_ajit_res_2: .word 0x0
test_903_Cmodel_res_1: .word 0x0
test_903_Cmodel_res_2: .word 0x0

test_904_inp_1_1: .word 0x646977b5
test_904_inp_1_2: .word 0x68ce7a33
test_904_inp_2_1: .word 0x80391897
test_904_inp_2_2: .word 0xeac90a07
test_904_ajit_res_1: .word 0xfff00000
test_904_ajit_res_2: .word 0x0
test_904_Cmodel_res_1: .word 0x0
test_904_Cmodel_res_2: .word 0x0

test_905_inp_1_1: .word 0x1d6ca499
test_905_inp_1_2: .word 0x86ba134d
test_905_inp_2_1: .word 0x5e20d9d2
test_905_inp_2_2: .word 0x710c142b
test_905_ajit_res_1: .word 0x6c
test_905_ajit_res_2: .word 0xc963ebd9
test_905_Cmodel_res_1: .word 0x0
test_905_Cmodel_res_2: .word 0x0

test_906_inp_1_1: .word 0x4f4612a6
test_906_inp_1_2: .word 0x454bc95d
test_906_inp_2_1: .word 0x737ebb8a
test_906_inp_2_2: .word 0x7106a98f
test_906_ajit_res_1: .word 0x1bb6fbaf
test_906_ajit_res_2: .word 0x145ce4
test_906_Cmodel_res_1: .word 0x0
test_906_Cmodel_res_2: .word 0x0

test_907_inp_1_1: .word 0x690293c9
test_907_inp_1_2: .word 0xfc3bc858
test_907_inp_2_1: .word 0x8d216b63
test_907_inp_2_2: .word 0x4baaa9c8
test_907_ajit_res_1: .word 0xfff00000
test_907_ajit_res_2: .word 0x0
test_907_Cmodel_res_1: .word 0x0
test_907_Cmodel_res_2: .word 0x0

test_908_inp_1_1: .word 0xeb1a9ed8
test_908_inp_1_2: .word 0x5c47dba5
test_908_inp_2_1: .word 0x95441a80
test_908_inp_2_2: .word 0x3cd91d52
test_908_ajit_res_1: .word 0x7ff00000
test_908_ajit_res_2: .word 0x0
test_908_Cmodel_res_1: .word 0x0
test_908_Cmodel_res_2: .word 0x0

test_909_inp_1_1: .word 0x8cf53471
test_909_inp_1_2: .word 0x8f4f3b1c
test_909_inp_2_1: .word 0xcd09426a
test_909_inp_2_2: .word 0x9c28e26a
test_909_ajit_res_1: .word 0x1add0
test_909_ajit_res_2: .word 0xa73ca1b5
test_909_Cmodel_res_1: .word 0x0
test_909_Cmodel_res_2: .word 0x0

test_910_inp_1_1: .word 0xdd634d0a
test_910_inp_1_2: .word 0x96bfafb3
test_910_inp_2_1: .word 0x826e28fc
test_910_inp_2_2: .word 0x61d75c2c
test_910_ajit_res_1: .word 0x7ff00000
test_910_ajit_res_2: .word 0x0
test_910_Cmodel_res_1: .word 0x0
test_910_Cmodel_res_2: .word 0x0

test_911_inp_1_1: .word 0x7f1df5c0
test_911_inp_1_2: .word 0xaeb8ffd
test_911_inp_2_1: .word 0xbece3cb0
test_911_inp_2_2: .word 0x4ea607a2
test_911_ajit_res_1: .word 0xfff00000
test_911_ajit_res_2: .word 0x0
test_911_Cmodel_res_1: .word 0x0
test_911_Cmodel_res_2: .word 0x0

test_912_inp_1_1: .word 0xfb0c1355
test_912_inp_1_2: .word 0x92447502
test_912_inp_2_1: .word 0xa12a21e4
test_912_inp_2_2: .word 0xdc0dfd68
test_912_ajit_res_1: .word 0x7ff00000
test_912_ajit_res_2: .word 0x0
test_912_Cmodel_res_1: .word 0x0
test_912_Cmodel_res_2: .word 0x0

test_913_inp_1_1: .word 0x7b08a47e
test_913_inp_1_2: .word 0xf78c3545
test_913_inp_2_1: .word 0x87acabf7
test_913_inp_2_2: .word 0xd718dc6f
test_913_ajit_res_1: .word 0xfff00000
test_913_ajit_res_2: .word 0x0
test_913_Cmodel_res_1: .word 0x0
test_913_Cmodel_res_2: .word 0x0

test_914_inp_1_1: .word 0x769f0c28
test_914_inp_1_2: .word 0x4e34ea12
test_914_inp_2_1: .word 0xf5fe2c45
test_914_inp_2_2: .word 0x805c4746
test_914_ajit_res_1: .word 0xc09076b8
test_914_ajit_res_2: .word 0xb240cb86
test_914_Cmodel_res_1: .word 0x0
test_914_Cmodel_res_2: .word 0x0

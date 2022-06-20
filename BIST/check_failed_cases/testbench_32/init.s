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

test_1_inp_1: .word 0xb2173b40
test_1_inp_2: .word 0xfa9d2e1f
test_1_ajit_res: .word 0xf
test_1_Cmodel_res: .word 0x0

test_2_inp_1: .word 0x15ba846b
test_2_inp_2: .word 0xe3cf18f0
test_2_ajit_res: .word 0x0
test_2_Cmodel_res: .word 0x0

test_3_inp_1: .word 0x912f8497
test_3_inp_2: .word 0x5617dd69
test_3_ajit_res: .word 0x8000093e
test_3_Cmodel_res: .word 0x0

test_4_inp_1: .word 0xad3f455a
test_4_inp_2: .word 0xf710d590
test_4_ajit_res: .word 0x2
test_4_Cmodel_res: .word 0x0

test_5_inp_1: .word 0x113b2111
test_5_inp_2: .word 0xd63e483d
test_5_ajit_res: .word 0x800007de
test_5_Cmodel_res: .word 0x0

test_6_inp_1: .word 0xab2afbc5
test_6_inp_2: .word 0x7e199c6c
test_6_ajit_res: .word 0x0
test_6_Cmodel_res: .word 0x0

test_7_inp_1: .word 0x87cb575d
test_7_inp_2: .word 0x493f386d
test_7_ajit_res: .word 0x800440e8
test_7_Cmodel_res: .word 0x0

test_8_inp_1: .word 0x95bfa215
test_8_inp_2: .word 0x5e5b6f8b
test_8_ajit_res: .word 0x8000000d
test_8_Cmodel_res: .word 0x0

test_9_inp_1: .word 0x268027e1
test_9_inp_2: .word 0x6dfecd3f
test_9_ajit_res: .word 0x40
test_9_Cmodel_res: .word 0x0

test_10_inp_1: .word 0x871b1898
test_10_inp_2: .word 0x650ab91c
test_10_ajit_res: .word 0x0
test_10_Cmodel_res: .word 0x0

test_11_inp_1: .word 0x881be134
test_11_inp_2: .word 0x7391fe6a
test_11_ajit_res: .word 0x0
test_11_Cmodel_res: .word 0x0

test_12_inp_1: .word 0x961612c7
test_12_inp_2: .word 0xdd95c4e0
test_12_ajit_res: .word 0x40
test_12_Cmodel_res: .word 0x0

test_13_inp_1: .word 0xa65da86e
test_13_inp_2: .word 0x795c5906
test_13_ajit_res: .word 0x0
test_13_Cmodel_res: .word 0x0

test_14_inp_1: .word 0x8cd4f5b8
test_14_inp_2: .word 0x5e1c6da9
test_14_ajit_res: .word 0x0
test_14_Cmodel_res: .word 0x0

test_15_inp_1: .word 0x26231d81
test_15_inp_2: .word 0xf7f0f648
test_15_ajit_res: .word 0x0
test_15_Cmodel_res: .word 0x0

test_16_inp_1: .word 0x1307f444
test_16_inp_2: .word 0x5c60d2e3
test_16_ajit_res: .word 0x4
test_16_Cmodel_res: .word 0x0

test_17_inp_1: .word 0x991559ed
test_17_inp_2: .word 0x7734ffd9
test_17_ajit_res: .word 0x0
test_17_Cmodel_res: .word 0x0

test_18_inp_1: .word 0x8e1f5ac7
test_18_inp_2: .word 0xcdb684e4
test_18_ajit_res: .word 0x37e09d
test_18_Cmodel_res: .word 0x0

test_19_inp_1: .word 0x25c1f3b4
test_19_inp_2: .word 0x6d58b38f
test_19_ajit_res: .word 0x39
test_19_Cmodel_res: .word 0x0

test_20_inp_1: .word 0x14711891
test_20_inp_2: .word 0xdb074720
test_20_ajit_res: .word 0x800000e4
test_20_Cmodel_res: .word 0x0

test_21_inp_1: .word 0xade2e8f2
test_21_inp_2: .word 0xef69410c
test_21_ajit_res: .word 0x3e426
test_21_Cmodel_res: .word 0x0

test_22_inp_1: .word 0x8ac48e1d
test_22_inp_2: .word 0x7be3505e
test_22_ajit_res: .word 0x0
test_22_Cmodel_res: .word 0x0

test_23_inp_1: .word 0x293dd6e7
test_23_inp_2: .word 0xefc11df7
test_23_ajit_res: .word 0x800000fb
test_23_Cmodel_res: .word 0x0

test_24_inp_1: .word 0x9634aa2d
test_24_inp_2: .word 0x6d507935
test_24_ajit_res: .word 0x0
test_24_Cmodel_res: .word 0x0

test_25_inp_1: .word 0x94599e09
test_25_inp_2: .word 0x548ad565
test_25_ajit_res: .word 0x8019145a
test_25_Cmodel_res: .word 0x0

test_26_inp_1: .word 0x1faef6c2
test_26_inp_2: .word 0xefa39959
test_26_ajit_res: .word 0x0
test_26_Cmodel_res: .word 0x0

test_27_inp_1: .word 0xa3906cd2
test_27_inp_2: .word 0x6f4a8137
test_27_ajit_res: .word 0x0
test_27_Cmodel_res: .word 0x0

test_28_inp_1: .word 0x143b2aee
test_28_inp_2: .word 0x5dbc99fd
test_28_ajit_res: .word 0x3
test_28_Cmodel_res: .word 0x0

test_29_inp_1: .word 0x1587afae
test_29_inp_2: .word 0xee3e6d77
test_29_ajit_res: .word 0x0
test_29_Cmodel_res: .word 0x0

test_30_inp_1: .word 0x1d15f851
test_30_inp_2: .word 0xe1e1229e
test_30_ajit_res: .word 0x80000aa8
test_30_Cmodel_res: .word 0x0

test_31_inp_1: .word 0x26898d7c
test_31_inp_2: .word 0xf3e6db0f
test_31_ajit_res: .word 0x0
test_31_Cmodel_res: .word 0x0

test_32_inp_1: .word 0x2708c963
test_32_inp_2: .word 0xfab27851
test_32_ajit_res: .word 0x0
test_32_Cmodel_res: .word 0x0

test_33_inp_1: .word 0xe29c67c4
test_33_inp_2: .word 0xa2fece36
test_33_ajit_res: .word 0x7f1d2377
test_33_Cmodel_res: .word 0x0

test_34_inp_1: .word 0x48817ffb
test_34_inp_2: .word 0x88bba4c4
test_34_ajit_res: .word 0xff30acdc
test_34_Cmodel_res: .word 0x0

test_35_inp_1: .word 0x816a6e71
test_35_inp_2: .word 0x582eac43
test_35_ajit_res: .word 0x0
test_35_Cmodel_res: .word 0x0

test_36_inp_1: .word 0xa342fe57
test_36_inp_2: .word 0x6d8be273
test_36_ajit_res: .word 0x80000001
test_36_Cmodel_res: .word 0x0

test_37_inp_1: .word 0x957d7fb7
test_37_inp_2: .word 0x6bfbdcb2
test_37_ajit_res: .word 0x0
test_37_Cmodel_res: .word 0x0

test_38_inp_1: .word 0xc5cf9e7
test_38_inp_2: .word 0xff65dab7
test_38_ajit_res: .word 0x0
test_38_Cmodel_res: .word 0x0

test_39_inp_1: .word 0xfd00ad3
test_39_inp_2: .word 0xdfc7df56
test_39_ajit_res: .word 0x0
test_39_Cmodel_res: .word 0x0

test_40_inp_1: .word 0x91b34592
test_40_inp_2: .word 0xd921db52
test_40_ajit_res: .word 0x46
test_40_Cmodel_res: .word 0x0

test_41_inp_1: .word 0x20b7cd44
test_41_inp_2: .word 0xfaf498ab
test_41_ajit_res: .word 0x0
test_41_Cmodel_res: .word 0x0

test_42_inp_1: .word 0x93f4abec
test_42_inp_2: .word 0xd7ac3da8
test_42_ajit_res: .word 0x2d74
test_42_Cmodel_res: .word 0x0

test_43_inp_1: .word 0x9129bda0
test_43_inp_2: .word 0x752fb32e
test_43_ajit_res: .word 0x0
test_43_Cmodel_res: .word 0x0

test_44_inp_1: .word 0x1801f633
test_44_inp_2: .word 0xfe372f50
test_44_ajit_res: .word 0x0
test_44_Cmodel_res: .word 0x0

test_45_inp_1: .word 0x8208a15c
test_45_inp_2: .word 0x5241a3ed
test_45_ajit_res: .word 0x0
test_45_Cmodel_res: .word 0x0

test_46_inp_1: .word 0xacce01ce
test_46_inp_2: .word 0xf2090115
test_46_ajit_res: .word 0x603
test_46_Cmodel_res: .word 0x0

test_47_inp_1: .word 0x1e1c4d0d
test_47_inp_2: .word 0x6006fcb3
test_47_ajit_res: .word 0x250d7
test_47_Cmodel_res: .word 0x0

test_48_inp_1: .word 0xaf4fb2cc
test_48_inp_2: .word 0x7bd5d6a7
test_48_ajit_res: .word 0x0
test_48_Cmodel_res: .word 0x0

test_49_inp_1: .word 0x81ed1306
test_49_inp_2: .word 0x52359ac0
test_49_ajit_res: .word 0x0
test_49_Cmodel_res: .word 0x0

test_50_inp_1: .word 0x811b2753
test_50_inp_2: .word 0x5bd800cb
test_50_ajit_res: .word 0x0
test_50_Cmodel_res: .word 0x0

test_51_inp_1: .word 0xb5d3a0c1
test_51_inp_2: .word 0xf8b864a4
test_51_ajit_res: .word 0x92e7
test_51_Cmodel_res: .word 0x0

test_52_inp_1: .word 0x89d3e858
test_52_inp_2: .word 0x6fc554b4
test_52_ajit_res: .word 0x0
test_52_Cmodel_res: .word 0x0

test_53_inp_1: .word 0x5a03dee2
test_53_inp_2: .word 0x1a2e4fad
test_53_ajit_res: .word 0x7f41ab8f
test_53_Cmodel_res: .word 0x0

test_54_inp_1: .word 0x1cf60836
test_54_inp_2: .word 0x63ebff0e
test_54_ajit_res: .word 0x85
test_54_Cmodel_res: .word 0x0

test_55_inp_1: .word 0xa8297ffe
test_55_inp_2: .word 0x7d06feb5
test_55_ajit_res: .word 0x0
test_55_Cmodel_res: .word 0x0

test_56_inp_1: .word 0xae55ab66
test_56_inp_2: .word 0x7c15b9ba
test_56_ajit_res: .word 0x0
test_56_Cmodel_res: .word 0x0

test_57_inp_1: .word 0x533811a
test_57_inp_2: .word 0xd70f89d2
test_57_ajit_res: .word 0x0
test_57_Cmodel_res: .word 0x0

test_58_inp_1: .word 0xa2f54fc3
test_58_inp_2: .word 0x6aa862e5
test_58_ajit_res: .word 0x8000002e
test_58_Cmodel_res: .word 0x0

test_59_inp_1: .word 0xb6a464e9
test_59_inp_2: .word 0x7d126755
test_59_ajit_res: .word 0x8000011f
test_59_Cmodel_res: .word 0x0

test_60_inp_1: .word 0x2e8bbe0b
test_60_inp_2: .word 0x7014a76e
test_60_ajit_res: .word 0x3c29c
test_60_Cmodel_res: .word 0x0

test_61_inp_1: .word 0x97c505c0
test_61_inp_2: .word 0xd8ded1be
test_61_ajit_res: .word 0x712e4
test_61_Cmodel_res: .word 0x0

test_62_inp_1: .word 0x265b3817
test_62_inp_2: .word 0x6a66efdb
test_62_ajit_res: .word 0x1e60
test_62_Cmodel_res: .word 0x0

test_63_inp_1: .word 0xa1de8aac
test_63_inp_2: .word 0x61ed6fc9
test_63_ajit_res: .word 0x801dfe18
test_63_Cmodel_res: .word 0x0

test_64_inp_1: .word 0x35164866
test_64_inp_2: .word 0x7f4bbb0b
test_64_ajit_res: .word 0x1
test_64_Cmodel_res: .word 0x0

test_65_inp_1: .word 0xa7e524ee
test_65_inp_2: .word 0x6c644f12
test_65_ajit_res: .word 0x8000100e
test_65_Cmodel_res: .word 0x0

test_66_inp_1: .word 0x8f0b1fa0
test_66_inp_2: .word 0x731dd23f
test_66_ajit_res: .word 0x0
test_66_Cmodel_res: .word 0x0

test_67_inp_1: .word 0x293418df
test_67_inp_2: .word 0xefd594c8
test_67_ajit_res: .word 0x800000d7
test_67_Cmodel_res: .word 0x0

test_68_inp_1: .word 0x36386089
test_68_inp_2: .word 0x7f02ee3d
test_68_ajit_res: .word 0xb
test_68_Cmodel_res: .word 0x0

test_69_inp_1: .word 0x33d6daa3
test_69_inp_2: .word 0xf8d492a2
test_69_ajit_res: .word 0x80000815
test_69_Cmodel_res: .word 0x0

test_70_inp_1: .word 0x1092a01d
test_70_inp_2: .word 0xd6b568f5
test_70_ajit_res: .word 0x8000019d
test_70_Cmodel_res: .word 0x0

test_71_inp_1: .word 0x2423435
test_71_inp_2: .word 0xdc527cb7
test_71_ajit_res: .word 0x0
test_71_Cmodel_res: .word 0x0

test_72_inp_1: .word 0x9b08ee98
test_72_inp_2: .word 0x5da19355
test_72_ajit_res: .word 0x8000d8f4
test_72_Cmodel_res: .word 0x0

test_73_inp_1: .word 0x9116280c
test_73_inp_2: .word 0xd6e7c2e7
test_73_ajit_res: .word 0x297
test_73_Cmodel_res: .word 0x0

test_74_inp_1: .word 0x325042b1
test_74_inp_2: .word 0x7ac989f2
test_74_ajit_res: .word 0x10
test_74_Cmodel_res: .word 0x0

test_75_inp_1: .word 0xc17654e
test_75_inp_2: .word 0xf76bf731
test_75_ajit_res: .word 0x0
test_75_Cmodel_res: .word 0x0

test_76_inp_1: .word 0xe635ec2
test_76_inp_2: .word 0xd2deafff
test_76_ajit_res: .word 0x80001056
test_76_Cmodel_res: .word 0x0

test_77_inp_1: .word 0x1264cdf3
test_77_inp_2: .word 0xf0886bde
test_77_ajit_res: .word 0x0
test_77_Cmodel_res: .word 0x0

test_78_inp_1: .word 0x2d69343a
test_78_inp_2: .word 0x7620486d
test_78_ajit_res: .word 0xb
test_78_Cmodel_res: .word 0x0

test_79_inp_1: .word 0xf39cdb9
test_79_inp_2: .word 0xe750293e
test_79_ajit_res: .word 0x0
test_79_Cmodel_res: .word 0x0

test_80_inp_1: .word 0x2668a477
test_80_inp_2: .word 0x6e2dfd84
test_80_ajit_res: .word 0x2a
test_80_Cmodel_res: .word 0x0

test_81_inp_1: .word 0x80d2e991
test_81_inp_2: .word 0x61fbcb41
test_81_ajit_res: .word 0x0
test_81_Cmodel_res: .word 0x0

test_82_inp_1: .word 0x9a3bff88
test_82_inp_2: .word 0x5c94a0cd
test_82_ajit_res: .word 0x800143cf
test_82_Cmodel_res: .word 0x0

test_83_inp_1: .word 0x9e9394c9
test_83_inp_2: .word 0x6d5d1b4c
test_83_ajit_res: .word 0x0
test_83_Cmodel_res: .word 0x0

test_84_inp_1: .word 0x8fdbdfc6
test_84_inp_2: .word 0x70405f37
test_84_ajit_res: .word 0x0
test_84_Cmodel_res: .word 0x0

test_85_inp_1: .word 0x2c7a4430
test_85_inp_2: .word 0xfb72bf8e
test_85_ajit_res: .word 0x0
test_85_Cmodel_res: .word 0x0

test_86_inp_1: .word 0x82269272
test_86_inp_2: .word 0x5d77b286
test_86_ajit_res: .word 0x0
test_86_Cmodel_res: .word 0x0

test_87_inp_1: .word 0xa8220708
test_87_inp_2: .word 0xf0a29e49
test_87_ajit_res: .word 0xf
test_87_Cmodel_res: .word 0x0

test_88_inp_1: .word 0x154a015c
test_88_inp_2: .word 0xf954d66c
test_88_ajit_res: .word 0x0
test_88_Cmodel_res: .word 0x0

test_89_inp_1: .word 0x3de16ac
test_89_inp_2: .word 0xe07ab309
test_89_ajit_res: .word 0x0
test_89_Cmodel_res: .word 0x0

test_90_inp_1: .word 0x6d7fca3
test_90_inp_2: .word 0xd1306042
test_90_ajit_res: .word 0x80000001
test_90_Cmodel_res: .word 0x0

test_91_inp_1: .word 0x2a1dca6f
test_91_inp_2: .word 0xf9539b27
test_91_ajit_res: .word 0x0
test_91_Cmodel_res: .word 0x0

test_92_inp_1: .word 0x6a54db4
test_92_inp_2: .word 0x4d6f5d9d
test_92_ajit_res: .word 0xb0
test_92_Cmodel_res: .word 0x0

test_93_inp_1: .word 0xa7040a36
test_93_inp_2: .word 0xee19fbf7
test_93_ajit_res: .word 0x6d
test_93_Cmodel_res: .word 0x0

test_94_inp_1: .word 0x2040f75e
test_94_inp_2: .word 0xebce296b
test_94_ajit_res: .word 0x0
test_94_Cmodel_res: .word 0x0

test_95_inp_1: .word 0x9fa2f42a
test_95_inp_2: .word 0xe5d2c399
test_95_ajit_res: .word 0x18b
test_95_Cmodel_res: .word 0x0

test_96_inp_1: .word 0xb479824
test_96_inp_2: .word 0xf02064a5
test_96_ajit_res: .word 0x0
test_96_Cmodel_res: .word 0x0

test_97_inp_1: .word 0x377ebd58
test_97_inp_2: .word 0xfa63eb72
test_97_ajit_res: .word 0x80008f0f
test_97_Cmodel_res: .word 0x0

test_98_inp_1: .word 0xb02f09d6
test_98_inp_2: .word 0x73a9cadc
test_98_ajit_res: .word 0x800041fa
test_98_Cmodel_res: .word 0x0

test_99_inp_1: .word 0x1c39d5aa
test_99_inp_2: .word 0xf71c5b6c
test_99_ajit_res: .word 0x0
test_99_Cmodel_res: .word 0x0

test_100_inp_1: .word 0x2d4ba3ef
test_100_inp_2: .word 0xf765c4d6
test_100_ajit_res: .word 0x80000001
test_100_Cmodel_res: .word 0x0

test_101_inp_1: .word 0x9a67902f
test_101_inp_2: .word 0x642ac7de
test_101_ajit_res: .word 0x80000002
test_101_Cmodel_res: .word 0x0

test_102_inp_1: .word 0x189a2438
test_102_inp_2: .word 0xdfbc4cf6
test_102_ajit_res: .word 0x80000068
test_102_Cmodel_res: .word 0x0

test_103_inp_1: .word 0x150477fc
test_103_inp_2: .word 0xe4837a21
test_103_ajit_res: .word 0x0
test_103_Cmodel_res: .word 0x0

test_104_inp_1: .word 0x192c54c0
test_104_inp_2: .word 0xe5383e5a
test_104_ajit_res: .word 0x0
test_104_Cmodel_res: .word 0x0

test_105_inp_1: .word 0x99ee077b
test_105_inp_2: .word 0x7928349b
test_105_ajit_res: .word 0x0
test_105_Cmodel_res: .word 0x0

test_106_inp_1: .word 0xb2d880a3
test_106_inp_2: .word 0xfb550965
test_106_ajit_res: .word 0x10
test_106_Cmodel_res: .word 0x0

test_107_inp_1: .word 0xa060906a
test_107_inp_2: .word 0xea9a8c18
test_107_ajit_res: .word 0x1
test_107_Cmodel_res: .word 0x0

test_108_inp_1: .word 0x2432c190
test_108_inp_2: .word 0xfc1f0d90
test_108_ajit_res: .word 0x0
test_108_Cmodel_res: .word 0x0

test_109_inp_1: .word 0x91009c24
test_109_inp_2: .word 0xd20071a6
test_109_ajit_res: .word 0x802a5
test_109_Cmodel_res: .word 0x0

test_110_inp_1: .word 0x9f77fcbf
test_110_inp_2: .word 0x7ce5b52f
test_110_ajit_res: .word 0x0
test_110_Cmodel_res: .word 0x0

test_111_inp_1: .word 0x3afaf175
test_111_inp_2: .word 0xfe5800ff
test_111_ajit_res: .word 0x80004a5a
test_111_Cmodel_res: .word 0x0

test_112_inp_1: .word 0xb8217925
test_112_inp_2: .word 0x77b84647
test_112_ajit_res: .word 0x803814b7
test_112_Cmodel_res: .word 0x0

test_113_inp_1: .word 0xa261eb6f
test_113_inp_2: .word 0x7e8b59c9
test_113_ajit_res: .word 0x0
test_113_Cmodel_res: .word 0x0

test_114_inp_1: .word 0xb083ab55
test_114_inp_2: .word 0x78cbdd81
test_114_ajit_res: .word 0x80000014
test_114_Cmodel_res: .word 0x0

test_115_inp_1: .word 0x854a82cf
test_115_inp_2: .word 0x777d8086
test_115_ajit_res: .word 0x0
test_115_Cmodel_res: .word 0x0

test_116_inp_1: .word 0x2dc996fb
test_116_inp_2: .word 0xfdc9d770
test_116_ajit_res: .word 0x0
test_116_Cmodel_res: .word 0x0

test_117_inp_1: .word 0x969a9975
test_117_inp_2: .word 0x7330ae4f
test_117_ajit_res: .word 0x0
test_117_Cmodel_res: .word 0x0

test_118_inp_1: .word 0x2bf120ef
test_118_inp_2: .word 0xf2742439
test_118_ajit_res: .word 0x800000fc
test_118_Cmodel_res: .word 0x0

test_119_inp_1: .word 0x11ed1c06
test_119_inp_2: .word 0xdd25abaa
test_119_ajit_res: .word 0x0
test_119_Cmodel_res: .word 0x0

test_120_inp_1: .word 0x39e5744a
test_120_inp_2: .word 0x7aec007c
test_120_ajit_res: .word 0x7c72e
test_120_Cmodel_res: .word 0x0

test_121_inp_1: .word 0x8986c65c
test_121_inp_2: .word 0x78e0b1ba
test_121_ajit_res: .word 0x0
test_121_Cmodel_res: .word 0x0

test_122_inp_1: .word 0x208e44b8
test_122_inp_2: .word 0xeb30a634
test_122_ajit_res: .word 0x80000000
test_122_Cmodel_res: .word 0x0

test_123_inp_1: .word 0x89f872c6
test_123_inp_2: .word 0x73b153d6
test_123_ajit_res: .word 0x0
test_123_Cmodel_res: .word 0x0

test_124_inp_1: .word 0x89b22091
test_124_inp_2: .word 0x79a32e61
test_124_ajit_res: .word 0x0
test_124_Cmodel_res: .word 0x0

test_125_inp_1: .word 0xbb2cac54
test_125_inp_2: .word 0xfa615be7
test_125_ajit_res: .word 0x62134a
test_125_Cmodel_res: .word 0x0

test_126_inp_1: .word 0x231a3ec9
test_126_inp_2: .word 0xfca6b9a8
test_126_ajit_res: .word 0x0
test_126_Cmodel_res: .word 0x0

test_127_inp_1: .word 0x92fb9980
test_127_inp_2: .word 0xd8b945c5
test_127_ajit_res: .word 0x2b7
test_127_Cmodel_res: .word 0x0

test_128_inp_1: .word 0x2d1a8e3
test_128_inp_2: .word 0xce77b3a5
test_128_ajit_res: .word 0x0
test_128_Cmodel_res: .word 0x0

test_129_inp_1: .word 0x262e145a
test_129_inp_2: .word 0x700e6708
test_129_ajit_res: .word 0x2
test_129_Cmodel_res: .word 0x0

test_130_inp_1: .word 0x8bcc0a81
test_130_inp_2: .word 0x5919d62f
test_130_ajit_res: .word 0x0
test_130_Cmodel_res: .word 0x0

test_131_inp_1: .word 0x28f5181e
test_131_inp_2: .word 0xf52aa145
test_131_ajit_res: .word 0x0
test_131_Cmodel_res: .word 0x0

test_132_inp_1: .word 0x98cae821
test_132_inp_2: .word 0x7c147206
test_132_ajit_res: .word 0x0
test_132_Cmodel_res: .word 0x0

test_133_inp_1: .word 0x874dc46d
test_133_inp_2: .word 0xc7cf0a2d
test_133_ajit_res: .word 0xfe6d3
test_133_Cmodel_res: .word 0x0

test_134_inp_1: .word 0xa8e13e4b
test_134_inp_2: .word 0x6a24a23f
test_134_ajit_res: .word 0x800578fb
test_134_Cmodel_res: .word 0x0

test_135_inp_1: .word 0x8911f3ff
test_135_inp_2: .word 0x5aa8c148
test_135_ajit_res: .word 0x0
test_135_Cmodel_res: .word 0x0

test_136_inp_1: .word 0xcba3b3
test_136_inp_2: .word 0xe302c44d
test_136_ajit_res: .word 0x0
test_136_Cmodel_res: .word 0x0

test_137_inp_1: .word 0x933c0095
test_137_inp_2: .word 0x76fb8942
test_137_ajit_res: .word 0x0
test_137_Cmodel_res: .word 0x0

test_138_inp_1: .word 0x2d8f23eb
test_138_inp_2: .word 0xf7b94552
test_138_ajit_res: .word 0x80000001
test_138_Cmodel_res: .word 0x0

test_139_inp_1: .word 0x8ea42856
test_139_inp_2: .word 0x7e735da1
test_139_ajit_res: .word 0x0
test_139_Cmodel_res: .word 0x0

test_140_inp_1: .word 0xc7f27cd
test_140_inp_2: .word 0xf857024e
test_140_ajit_res: .word 0x0
test_140_Cmodel_res: .word 0x0

test_141_inp_1: .word 0xa3fc0b3f
test_141_inp_2: .word 0x71e4b432
test_141_ajit_res: .word 0x0
test_141_Cmodel_res: .word 0x0

test_142_inp_1: .word 0xdf7ed63
test_142_inp_2: .word 0xfb2adc8e
test_142_ajit_res: .word 0x0
test_142_Cmodel_res: .word 0x0

test_143_inp_1: .word 0x102f853c
test_143_inp_2: .word 0xf1895a78
test_143_ajit_res: .word 0x0
test_143_Cmodel_res: .word 0x0

test_144_inp_1: .word 0x81541e7e
test_144_inp_2: .word 0x51e03953
test_144_ajit_res: .word 0x0
test_144_Cmodel_res: .word 0x0

test_145_inp_1: .word 0x2d80bccf
test_145_inp_2: .word 0x793179a3
test_145_ajit_res: .word 0x0
test_145_Cmodel_res: .word 0x0

test_146_inp_1: .word 0x91b4539c
test_146_inp_2: .word 0x633c119f
test_146_ajit_res: .word 0x0
test_146_Cmodel_res: .word 0x0

test_147_inp_1: .word 0x16a1864d
test_147_inp_2: .word 0xeb6e9a59
test_147_ajit_res: .word 0x0
test_147_Cmodel_res: .word 0x0

test_148_inp_1: .word 0xa632b1bb
test_148_inp_2: .word 0xf0bf1e99
test_148_ajit_res: .word 0x0
test_148_Cmodel_res: .word 0x0

test_149_inp_1: .word 0xb6046118
test_149_inp_2: .word 0x7ec8fd6b
test_149_ajit_res: .word 0x8000000a
test_149_Cmodel_res: .word 0x0

test_150_inp_1: .word 0xbce64540
test_150_inp_2: .word 0xfd819387
test_150_ajit_res: .word 0xe3782
test_150_Cmodel_res: .word 0x0

test_151_inp_1: .word 0x330edd75
test_151_inp_2: .word 0xfcaead85
test_151_ajit_res: .word 0x80000003
test_151_Cmodel_res: .word 0x0

test_152_inp_1: .word 0x175e7aa0
test_152_inp_2: .word 0xd9474205
test_152_ajit_res: .word 0x80023baa
test_152_Cmodel_res: .word 0x0

test_153_inp_1: .word 0x80ab649b
test_153_inp_2: .word 0x6b39a267
test_153_ajit_res: .word 0x0
test_153_Cmodel_res: .word 0x0

test_154_inp_1: .word 0x5428da5
test_154_inp_2: .word 0xca36fc1e
test_154_ajit_res: .word 0x80000881
test_154_Cmodel_res: .word 0x0

test_155_inp_1: .word 0x943d7aba
test_155_inp_2: .word 0x562ec6ef
test_155_ajit_res: .word 0x80022b11
test_155_Cmodel_res: .word 0x0

test_156_inp_1: .word 0x15bcf34b
test_156_inp_2: .word 0xf1608281
test_156_ajit_res: .word 0x0
test_156_Cmodel_res: .word 0x0

test_157_inp_1: .word 0xbba925fc
test_157_inp_2: .word 0x7dc42497
test_157_ajit_res: .word 0x8001b988
test_157_Cmodel_res: .word 0x0

test_158_inp_1: .word 0x9fe3bf7d
test_158_inp_2: .word 0xe98e841b
test_158_ajit_res: .word 0x3
test_158_Cmodel_res: .word 0x0

test_159_inp_1: .word 0xda7e712
test_159_inp_2: .word 0xd9f1a9b0
test_159_ajit_res: .word 0x0
test_159_Cmodel_res: .word 0x0

test_160_inp_1: .word 0x8886ca5a
test_160_inp_2: .word 0x6879f53c
test_160_ajit_res: .word 0x0
test_160_Cmodel_res: .word 0x0

test_161_inp_1: .word 0xb40bce77
test_161_inp_2: .word 0x7563da35
test_161_ajit_res: .word 0x8004e89e
test_161_Cmodel_res: .word 0x0

test_162_inp_1: .word 0xa7f3d2de
test_162_inp_2: .word 0x68a87d4a
test_162_ajit_res: .word 0x800b93b1
test_162_Cmodel_res: .word 0x0

test_163_inp_1: .word 0x2f808e80
test_163_inp_2: .word 0xf442a4a8
test_163_ajit_res: .word 0x80000a91
test_163_Cmodel_res: .word 0x0

test_164_inp_1: .word 0xadcd310e
test_164_inp_2: .word 0x76726bf8
test_164_ajit_res: .word 0x8000000d
test_164_Cmodel_res: .word 0x0

test_165_inp_1: .word 0x9a52b73b
test_165_inp_2: .word 0x5a0c1d41
test_165_ajit_res: .word 0x80301fd3
test_165_Cmodel_res: .word 0x0

test_166_inp_1: .word 0x17e4145
test_166_inp_2: .word 0xe389b82e
test_166_ajit_res: .word 0x0
test_166_Cmodel_res: .word 0x0

test_167_inp_1: .word 0x27ad22f9
test_167_inp_2: .word 0xfdb5a300
test_167_ajit_res: .word 0x0
test_167_Cmodel_res: .word 0x0

test_168_inp_1: .word 0x2a12d199
test_168_inp_2: .word 0x7418f8a9
test_168_ajit_res: .word 0x1
test_168_Cmodel_res: .word 0x0

test_169_inp_1: .word 0xad33a36b
test_169_inp_2: .word 0xf284d744
test_169_ajit_res: .word 0x568
test_169_Cmodel_res: .word 0x0

test_170_inp_1: .word 0x88b45b45
test_170_inp_2: .word 0x7843afcb
test_170_ajit_res: .word 0x0
test_170_Cmodel_res: .word 0x0

test_171_inp_1: .word 0x8a9bea3
test_171_inp_2: .word 0xd0c5e2bd
test_171_ajit_res: .word 0x8000001b
test_171_Cmodel_res: .word 0x0

test_172_inp_1: .word 0xa17eaf97
test_172_inp_2: .word 0xe502cff1
test_172_ajit_res: .word 0x3e4d
test_172_Cmodel_res: .word 0x0

test_173_inp_1: .word 0x91e26753
test_173_inp_2: .word 0x7c0ad337
test_173_ajit_res: .word 0x0
test_173_Cmodel_res: .word 0x0

test_174_inp_1: .word 0x8ec84fa6
test_174_inp_2: .word 0x60aacb38
test_174_ajit_res: .word 0x0
test_174_Cmodel_res: .word 0x0

test_175_inp_1: .word 0x57ee139
test_175_inp_2: .word 0xf2639f35
test_175_ajit_res: .word 0x0
test_175_Cmodel_res: .word 0x0

test_176_inp_1: .word 0x869c6ac8
test_176_inp_2: .word 0x73688a6a
test_176_ajit_res: .word 0x0
test_176_Cmodel_res: .word 0x0

test_177_inp_1: .word 0x31f64e10
test_177_inp_2: .word 0xfebdf34a
test_177_ajit_res: .word 0x0
test_177_Cmodel_res: .word 0x0

test_178_inp_1: .word 0x9e698f45
test_178_inp_2: .word 0x5fa1e825
test_178_ajit_res: .word 0x8005c52d
test_178_Cmodel_res: .word 0x0

test_179_inp_1: .word 0x8cedbe48
test_179_inp_2: .word 0x5fb0d89a
test_179_ajit_res: .word 0x0
test_179_Cmodel_res: .word 0x0

test_180_inp_1: .word 0x81132d49
test_180_inp_2: .word 0x73fa1d94
test_180_ajit_res: .word 0x0
test_180_Cmodel_res: .word 0x0

test_181_inp_1: .word 0x65a7151
test_181_inp_2: .word 0x467ed849
test_181_ajit_res: .word 0x1b6dd9
test_181_Cmodel_res: .word 0x0

test_182_inp_1: .word 0x9d16ad03
test_182_inp_2: .word 0x5e6bc258
test_182_ajit_res: .word 0x80051ce5
test_182_Cmodel_res: .word 0x0

test_183_inp_1: .word 0x2c3ae01d
test_183_inp_2: .word 0x77167821
test_183_ajit_res: .word 0x0
test_183_Cmodel_res: .word 0x0

test_184_inp_1: .word 0x15c0b8bc
test_184_inp_2: .word 0x58300337
test_184_ajit_res: .word 0x1184d
test_184_Cmodel_res: .word 0x0

test_185_inp_1: .word 0xfa63228
test_185_inp_2: .word 0xf5860df9
test_185_ajit_res: .word 0x0
test_185_Cmodel_res: .word 0x0

test_186_inp_1: .word 0x427612e
test_186_inp_2: .word 0xe857f0cf
test_186_ajit_res: .word 0x0
test_186_Cmodel_res: .word 0x0

test_187_inp_1: .word 0x88ed902e
test_187_inp_2: .word 0x67e1e61a
test_187_ajit_res: .word 0x0
test_187_Cmodel_res: .word 0x0

test_188_inp_1: .word 0x22fca15c
test_188_inp_2: .word 0x6c37bcd7
test_188_ajit_res: .word 0x5
test_188_Cmodel_res: .word 0x0

test_189_inp_1: .word 0x2b02cff
test_189_inp_2: .word 0xe2d62268
test_189_ajit_res: .word 0x0
test_189_Cmodel_res: .word 0x0

test_190_inp_1: .word 0x14e17670
test_190_inp_2: .word 0xd96dfbde
test_190_ajit_res: .word 0x80000f28
test_190_Cmodel_res: .word 0x0

test_191_inp_1: .word 0x1d601791
test_191_inp_2: .word 0xedd53358
test_191_ajit_res: .word 0x0
test_191_Cmodel_res: .word 0x0

test_192_inp_1: .word 0x99987706
test_192_inp_2: .word 0x7868ebfa
test_192_ajit_res: .word 0x0
test_192_Cmodel_res: .word 0x0

test_193_inp_1: .word 0x7d630ec
test_193_inp_2: .word 0xf8be5129
test_193_ajit_res: .word 0x0
test_193_Cmodel_res: .word 0x0

test_194_inp_1: .word 0x8ef88905
test_194_inp_2: .word 0x64db3bc9
test_194_ajit_res: .word 0x0
test_194_Cmodel_res: .word 0x0

test_195_inp_1: .word 0x8cfd734e
test_195_inp_2: .word 0x7000e284
test_195_ajit_res: .word 0x0
test_195_Cmodel_res: .word 0x0

test_196_inp_1: .word 0xfa9c915
test_196_inp_2: .word 0xe7e53850
test_196_ajit_res: .word 0x0
test_196_Cmodel_res: .word 0x0

test_197_inp_1: .word 0x8e456126
test_197_inp_2: .word 0x6e57b2d6
test_197_ajit_res: .word 0x0
test_197_Cmodel_res: .word 0x0

test_198_inp_1: .word 0x91e07057
test_198_inp_2: .word 0x62beabe2
test_198_ajit_res: .word 0x0
test_198_Cmodel_res: .word 0x0

test_199_inp_1: .word 0x8cbe2819
test_199_inp_2: .word 0x7e18b427
test_199_ajit_res: .word 0x0
test_199_Cmodel_res: .word 0x0

test_200_inp_1: .word 0x90760284
test_200_inp_2: .word 0x54f3f877
test_200_ajit_res: .word 0x80001022
test_200_Cmodel_res: .word 0x0

test_201_inp_1: .word 0x235754cd
test_201_inp_2: .word 0xf013156a
test_201_ajit_res: .word 0x0
test_201_Cmodel_res: .word 0x0

test_202_inp_1: .word 0x12d370a7
test_202_inp_2: .word 0xe4327644
test_202_ajit_res: .word 0x0
test_202_Cmodel_res: .word 0x0

test_203_inp_1: .word 0x245890d1
test_203_inp_2: .word 0xfe17d5f0
test_203_ajit_res: .word 0x0
test_203_Cmodel_res: .word 0x0

test_204_inp_1: .word 0x894d1485
test_204_inp_2: .word 0x50698c0b
test_204_ajit_res: .word 0x80000070
test_204_Cmodel_res: .word 0x0

test_205_inp_1: .word 0xb822a543
test_205_inp_2: .word 0x7dd353c6
test_205_ajit_res: .word 0x80000314
test_205_Cmodel_res: .word 0x0

test_206_inp_1: .word 0x8e610229
test_206_inp_2: .word 0x6aa5525b
test_206_ajit_res: .word 0x0
test_206_Cmodel_res: .word 0x0

test_207_inp_1: .word 0x12b2bd56
test_207_inp_2: .word 0xe613a49a
test_207_ajit_res: .word 0x0
test_207_Cmodel_res: .word 0x0

test_208_inp_1: .word 0x87d8c477
test_208_inp_2: .word 0x7594905c
test_208_ajit_res: .word 0x0
test_208_Cmodel_res: .word 0x0

test_209_inp_1: .word 0xfacecb7
test_209_inp_2: .word 0xd57d70ea
test_209_ajit_res: .word 0x800002ba
test_209_Cmodel_res: .word 0x0

test_210_inp_1: .word 0x68636f5
test_210_inp_2: .word 0xcb49adf9
test_210_ajit_res: .word 0x80000aa5
test_210_Cmodel_res: .word 0x0

test_211_inp_1: .word 0x825ab3fc
test_211_inp_2: .word 0x5081e42e
test_211_ajit_res: .word 0x0
test_211_Cmodel_res: .word 0x0

test_212_inp_1: .word 0x9f7b3d45
test_212_inp_2: .word 0xe2a044ac
test_212_ajit_res: .word 0x6453
test_212_Cmodel_res: .word 0x0

test_213_inp_1: .word 0x3a0c946
test_213_inp_2: .word 0x4b888442
test_213_ajit_res: .word 0x25
test_213_Cmodel_res: .word 0x0

test_214_inp_1: .word 0x9a59e1ea
test_214_inp_2: .word 0x6af529d8
test_214_ajit_res: .word 0x0
test_214_Cmodel_res: .word 0x0

test_215_inp_1: .word 0x33c25daf
test_215_inp_2: .word 0x7687b314
test_215_ajit_res: .word 0xb756
test_215_Cmodel_res: .word 0x0

test_216_inp_1: .word 0x211fe5d8
test_216_inp_2: .word 0x693a6a4a
test_216_ajit_res: .word 0x1b
test_216_Cmodel_res: .word 0x0

test_217_inp_1: .word 0xc7801a
test_217_inp_2: .word 0xe85c3778
test_217_ajit_res: .word 0x0
test_217_Cmodel_res: .word 0x0

test_218_inp_1: .word 0x9a6fd61b
test_218_inp_2: .word 0x753c4fed
test_218_ajit_res: .word 0x0
test_218_Cmodel_res: .word 0x0

test_219_inp_1: .word 0xa4430c5e
test_219_inp_2: .word 0x7cd2f9fa
test_219_ajit_res: .word 0x0
test_219_Cmodel_res: .word 0x0

test_220_inp_1: .word 0x16fc2fdd
test_220_inp_2: .word 0xf3f08d9e
test_220_ajit_res: .word 0x0
test_220_Cmodel_res: .word 0x0

test_221_inp_1: .word 0xa3f44969
test_221_inp_2: .word 0x71f6fca5
test_221_ajit_res: .word 0x0
test_221_Cmodel_res: .word 0x0

test_222_inp_1: .word 0x18d26f8a
test_222_inp_2: .word 0xf143a67b
test_222_ajit_res: .word 0x0
test_222_Cmodel_res: .word 0x0

test_223_inp_1: .word 0x4b4b200
test_223_inp_2: .word 0xcc64143a
test_223_ajit_res: .word 0x80000032
test_223_Cmodel_res: .word 0x0

test_224_inp_1: .word 0x98c13581
test_224_inp_2: .word 0x70579d99
test_224_ajit_res: .word 0x0
test_224_Cmodel_res: .word 0x0

test_225_inp_1: .word 0x809e02ba
test_225_inp_2: .word 0x59e5391e
test_225_ajit_res: .word 0x0
test_225_Cmodel_res: .word 0x0

test_226_inp_1: .word 0x97fd2936
test_226_inp_2: .word 0x69a5fb3b
test_226_ajit_res: .word 0x0
test_226_Cmodel_res: .word 0x0

test_227_inp_1: .word 0x2994fd23
test_227_inp_2: .word 0x7027815b
test_227_ajit_res: .word 0xe3
test_227_Cmodel_res: .word 0x0

test_228_inp_1: .word 0x241bc906
test_228_inp_2: .word 0xfa5fd4fb
test_228_ajit_res: .word 0x0
test_228_Cmodel_res: .word 0x0

test_229_inp_1: .word 0x99c1b948
test_229_inp_2: .word 0x73faa9bc
test_229_ajit_res: .word 0x0
test_229_Cmodel_res: .word 0x0

test_230_inp_1: .word 0x94630780
test_230_inp_2: .word 0x66f344e9
test_230_ajit_res: .word 0x0
test_230_Cmodel_res: .word 0x0

test_231_inp_1: .word 0xa9e1cd0
test_231_inp_2: .word 0xe984f212
test_231_ajit_res: .word 0x0
test_231_Cmodel_res: .word 0x0

test_232_inp_1: .word 0x24a85334
test_232_inp_2: .word 0xf7164e33
test_232_ajit_res: .word 0x0
test_232_Cmodel_res: .word 0x0

test_233_inp_1: .word 0xafb5408d
test_233_inp_2: .word 0xf33888bf
test_233_ajit_res: .word 0x3edc
test_233_Cmodel_res: .word 0x0

test_234_inp_1: .word 0x9881f5e3
test_234_inp_2: .word 0x618a995d
test_234_ajit_res: .word 0x80000007
test_234_Cmodel_res: .word 0x0

test_235_inp_1: .word 0x9a410b3f
test_235_inp_2: .word 0xdfffe32c
test_235_ajit_res: .word 0x304
test_235_Cmodel_res: .word 0x0

test_236_inp_1: .word 0x14199c68
test_236_inp_2: .word 0xd5057be2
test_236_ajit_res: .word 0x800934cd
test_236_Cmodel_res: .word 0x0

test_237_inp_1: .word 0x9af79a90
test_237_inp_2: .word 0x5d106602
test_237_ajit_res: .word 0x8001b6f8
test_237_Cmodel_res: .word 0x0

test_238_inp_1: .word 0x2f6a5f40
test_238_inp_2: .word 0xf4cfcd21
test_238_ajit_res: .word 0x80000482
test_238_Cmodel_res: .word 0x0

test_239_inp_1: .word 0x15b0314e
test_239_inp_2: .word 0x60a6e8c2
test_239_ajit_res: .word 0x0
test_239_Cmodel_res: .word 0x0

test_240_inp_1: .word 0x84815c6f
test_240_inp_2: .word 0x4e9e16c9
test_240_ajit_res: .word 0x80000001
test_240_Cmodel_res: .word 0x0

test_241_inp_1: .word 0x8849f7a9
test_241_inp_2: .word 0x61229217
test_241_ajit_res: .word 0x0
test_241_Cmodel_res: .word 0x0

test_242_inp_1: .word 0x80a646a8
test_242_inp_2: .word 0x461f30b1
test_242_ajit_res: .word 0x8000042d
test_242_Cmodel_res: .word 0x0

test_243_inp_1: .word 0x80c3ada3
test_243_inp_2: .word 0x5b8ed418
test_243_ajit_res: .word 0x0
test_243_Cmodel_res: .word 0x0

test_244_inp_1: .word 0x88f9bf85
test_244_inp_2: .word 0x5e2ec021
test_244_ajit_res: .word 0x0
test_244_Cmodel_res: .word 0x0

test_245_inp_1: .word 0x9354050e
test_245_inp_2: .word 0x6d4c5274
test_245_ajit_res: .word 0x0
test_245_Cmodel_res: .word 0x0

test_246_inp_1: .word 0xc77a06d
test_246_inp_2: .word 0xf73a7650
test_246_ajit_res: .word 0x0
test_246_Cmodel_res: .word 0x0

test_247_inp_1: .word 0x1cb2583
test_247_inp_2: .word 0xca1590fe
test_247_ajit_res: .word 0x80000015
test_247_Cmodel_res: .word 0x0

test_248_inp_1: .word 0xbe4c8610
test_248_inp_2: .word 0xff5cbbb7
test_248_ajit_res: .word 0x7699a
test_248_Cmodel_res: .word 0x0

test_249_inp_1: .word 0x9dbf2bb2
test_249_inp_2: .word 0x61e3ad16
test_249_ajit_res: .word 0x80001ade
test_249_Cmodel_res: .word 0x0

test_250_inp_1: .word 0x8fddc7ba
test_250_inp_2: .word 0xd27919cf
test_250_ajit_res: .word 0xe3ec
test_250_Cmodel_res: .word 0x0

test_251_inp_1: .word 0xff0877e
test_251_inp_2: .word 0xfcf656d1
test_251_ajit_res: .word 0x0
test_251_Cmodel_res: .word 0x0

test_252_inp_1: .word 0x83a6d594
test_252_inp_2: .word 0x7b9b5ade
test_252_ajit_res: .word 0x0
test_252_Cmodel_res: .word 0x0

test_253_inp_1: .word 0xb912fa1
test_253_inp_2: .word 0xe2c60af3
test_253_ajit_res: .word 0x0
test_253_Cmodel_res: .word 0x0

test_254_inp_1: .word 0x99622125
test_254_inp_2: .word 0x75949f46
test_254_ajit_res: .word 0x0
test_254_Cmodel_res: .word 0x0

test_255_inp_1: .word 0x161a5aad
test_255_inp_2: .word 0xf4b5554a
test_255_ajit_res: .word 0x0
test_255_Cmodel_res: .word 0x0

test_256_inp_1: .word 0x16e1c127
test_256_inp_2: .word 0xf663fee5
test_256_ajit_res: .word 0x0
test_256_Cmodel_res: .word 0x0

test_257_inp_1: .word 0x377cce0e
test_257_inp_2: .word 0x7919f350
test_257_ajit_res: .word 0x348c3
test_257_Cmodel_res: .word 0x0

test_258_inp_1: .word 0x8328280f
test_258_inp_2: .word 0x4317687b
test_258_ajit_res: .word 0x80238a2d
test_258_Cmodel_res: .word 0x0

test_259_inp_1: .word 0x8ef5a400
test_259_inp_2: .word 0x74c29e7a
test_259_ajit_res: .word 0x0
test_259_Cmodel_res: .word 0x0

test_260_inp_1: .word 0x92bccb68
test_260_inp_2: .word 0x71e81e80
test_260_ajit_res: .word 0x0
test_260_Cmodel_res: .word 0x0

test_261_inp_1: .word 0xa4b3abb6
test_261_inp_2: .word 0xe96ae9d4
test_261_ajit_res: .word 0xc3c
test_261_Cmodel_res: .word 0x0

test_262_inp_1: .word 0xd205e03
test_262_inp_2: .word 0xdae79313
test_262_ajit_res: .word 0x0
test_262_Cmodel_res: .word 0x0

test_263_inp_1: .word 0x17218b00
test_263_inp_2: .word 0xee729c20
test_263_ajit_res: .word 0x0
test_263_Cmodel_res: .word 0x0

test_264_inp_1: .word 0x2a1063a5
test_264_inp_2: .word 0xeafec277
test_264_ajit_res: .word 0x80091179
test_264_Cmodel_res: .word 0x0

test_265_inp_1: .word 0x1ffe3625
test_265_inp_2: .word 0xfe6a2db8
test_265_ajit_res: .word 0x0
test_265_Cmodel_res: .word 0x0

test_266_inp_1: .word 0x9f6615d8
test_266_inp_2: .word 0xe67a5df6
test_266_ajit_res: .word 0x75
test_266_Cmodel_res: .word 0x0

test_267_inp_1: .word 0x21e9d71
test_267_inp_2: .word 0xe7a5e089
test_267_ajit_res: .word 0x0
test_267_Cmodel_res: .word 0x0

test_268_inp_1: .word 0xa09a0502
test_268_inp_2: .word 0xe77316ff
test_268_ajit_res: .word 0xa2
test_268_Cmodel_res: .word 0x0

test_269_inp_1: .word 0x719e28c
test_269_inp_2: .word 0x52479a28
test_269_ajit_res: .word 0x0
test_269_Cmodel_res: .word 0x0

test_270_inp_1: .word 0x948680cb
test_270_inp_2: .word 0xd7679204
test_270_ajit_res: .word 0x94b1
test_270_Cmodel_res: .word 0x0

test_271_inp_1: .word 0x9dd20135
test_271_inp_2: .word 0x6362b62f
test_271_ajit_res: .word 0x800003b4
test_271_Cmodel_res: .word 0x0

test_272_inp_1: .word 0x2a10a2c3
test_272_inp_2: .word 0xf7536107
test_272_ajit_res: .word 0x0
test_272_Cmodel_res: .word 0x0

test_273_inp_1: .word 0xabc75005
test_273_inp_2: .word 0x793dcc26
test_273_ajit_res: .word 0x0
test_273_Cmodel_res: .word 0x0

test_274_inp_1: .word 0x9f21ce27
test_274_inp_2: .word 0x7a4557f5
test_274_ajit_res: .word 0x0
test_274_Cmodel_res: .word 0x0

test_275_inp_1: .word 0x844c3115
test_275_inp_2: .word 0x4fbc9462
test_275_ajit_res: .word 0x0
test_275_Cmodel_res: .word 0x0

test_276_inp_1: .word 0x19685939
test_276_inp_2: .word 0x5ba173de
test_276_ajit_res: .word 0x17069
test_276_Cmodel_res: .word 0x0

test_277_inp_1: .word 0xa5cbc73a
test_277_inp_2: .word 0x78be5c2c
test_277_ajit_res: .word 0x0
test_277_Cmodel_res: .word 0x0

test_278_inp_1: .word 0x9c9ba9cf
test_278_inp_2: .word 0xddea1ede
test_278_ajit_res: .word 0x551af
test_278_Cmodel_res: .word 0x0

test_279_inp_1: .word 0xc3ea3cf
test_279_inp_2: .word 0xd0ad526c
test_279_ajit_res: .word 0x80001199
test_279_Cmodel_res: .word 0x0

test_280_inp_1: .word 0xa50a4fc5
test_280_inp_2: .word 0x72ae2e3c
test_280_ajit_res: .word 0x0
test_280_Cmodel_res: .word 0x0

test_281_inp_1: .word 0x9e8d229a
test_281_inp_2: .word 0x61118155
test_281_ajit_res: .word 0x8000f84f
test_281_Cmodel_res: .word 0x0

test_282_inp_1: .word 0x14b0746a
test_282_inp_2: .word 0x5d9a17f4
test_282_ajit_res: .word 0x9
test_282_Cmodel_res: .word 0x0

test_283_inp_1: .word 0x1b4c00c6
test_283_inp_2: .word 0xf1caa0ec
test_283_ajit_res: .word 0x0
test_283_Cmodel_res: .word 0x0

test_284_inp_1: .word 0x8a1ab921
test_284_inp_2: .word 0x7aef807e
test_284_ajit_res: .word 0x0
test_284_Cmodel_res: .word 0x0

test_285_inp_1: .word 0x94cb870b
test_285_inp_2: .word 0x6177b6de
test_285_ajit_res: .word 0x0
test_285_Cmodel_res: .word 0x0

test_286_inp_1: .word 0x3f8692d
test_286_inp_2: .word 0xd5640623
test_286_ajit_res: .word 0x0
test_286_Cmodel_res: .word 0x0

test_287_inp_1: .word 0x81245c0b
test_287_inp_2: .word 0x5e021279
test_287_ajit_res: .word 0x0
test_287_Cmodel_res: .word 0x0

test_288_inp_1: .word 0xa8768100
test_288_inp_2: .word 0x7281184b
test_288_ajit_res: .word 0x80000001
test_288_Cmodel_res: .word 0x0

test_289_inp_1: .word 0x3d591238
test_289_inp_2: .word 0xfcddab57
test_289_ajit_res: .word 0x803eac24
test_289_Cmodel_res: .word 0x0

test_290_inp_1: .word 0xe7fb168
test_290_inp_2: .word 0xf204e561
test_290_ajit_res: .word 0x0
test_290_Cmodel_res: .word 0x0

test_291_inp_1: .word 0x1cf89b93
test_291_inp_2: .word 0xfed57696
test_291_ajit_res: .word 0x0
test_291_Cmodel_res: .word 0x0

test_292_inp_1: .word 0x14fcfdc9
test_292_inp_2: .word 0xe3f9150b
test_292_ajit_res: .word 0x0
test_292_Cmodel_res: .word 0x0

test_293_inp_1: .word 0xd6c3d86
test_293_inp_2: .word 0xd14425e8
test_293_ajit_res: .word 0x8000268a
test_293_Cmodel_res: .word 0x0

test_294_inp_1: .word 0x1a275201
test_294_inp_2: .word 0xfc89cc72
test_294_ajit_res: .word 0x0
test_294_Cmodel_res: .word 0x0

test_295_inp_1: .word 0xae1f5de6
test_295_inp_2: .word 0xf1d459d7
test_295_ajit_res: .word 0x3007
test_295_Cmodel_res: .word 0x0

test_296_inp_1: .word 0x1863a26f
test_296_inp_2: .word 0xe9e0fb78
test_296_ajit_res: .word 0x0
test_296_Cmodel_res: .word 0x0

test_297_inp_1: .word 0xa068d4db
test_297_inp_2: .word 0xe4815de2
test_297_ajit_res: .word 0x1ccb
test_297_Cmodel_res: .word 0x0

test_298_inp_1: .word 0x7fd6ce7
test_298_inp_2: .word 0xe6556337
test_298_ajit_res: .word 0x0
test_298_Cmodel_res: .word 0x0

test_299_inp_1: .word 0x1a5ff2a6
test_299_inp_2: .word 0x656cd4c3
test_299_ajit_res: .word 0x0
test_299_Cmodel_res: .word 0x0

test_300_inp_1: .word 0x54f2bab
test_300_inp_2: .word 0xe772cd76
test_300_ajit_res: .word 0x0
test_300_Cmodel_res: .word 0x0

test_301_inp_1: .word 0x1dccb0bf
test_301_inp_2: .word 0xf0b63f12
test_301_ajit_res: .word 0x0
test_301_Cmodel_res: .word 0x0

test_302_inp_1: .word 0x2d07e3fb
test_302_inp_2: .word 0xfe6a03a7
test_302_ajit_res: .word 0x0
test_302_Cmodel_res: .word 0x0

test_303_inp_1: .word 0x88aac0f
test_303_inp_2: .word 0xfc6733ca
test_303_ajit_res: .word 0x0
test_303_Cmodel_res: .word 0x0

test_304_inp_1: .word 0xce30655
test_304_inp_2: .word 0xe91b9861
test_304_ajit_res: .word 0x0
test_304_Cmodel_res: .word 0x0

test_305_inp_1: .word 0x1d9b9714
test_305_inp_2: .word 0xfbecfd5c
test_305_ajit_res: .word 0x0
test_305_Cmodel_res: .word 0x0

test_306_inp_1: .word 0x9d093f5a
test_306_inp_2: .word 0xe6a9e74b
test_306_ajit_res: .word 0x3
test_306_Cmodel_res: .word 0x0

test_307_inp_1: .word 0x9a6dc054
test_307_inp_2: .word 0x6e8d7d87
test_307_ajit_res: .word 0x0
test_307_Cmodel_res: .word 0x0

test_308_inp_1: .word 0x1247d4a6
test_308_inp_2: .word 0xf2b0f92f
test_308_ajit_res: .word 0x0
test_308_Cmodel_res: .word 0x0

test_309_inp_1: .word 0x8b2b31e0
test_309_inp_2: .word 0x4ff02a0b
test_309_ajit_res: .word 0x80000b67
test_309_Cmodel_res: .word 0x0

test_310_inp_1: .word 0xb6146ee
test_310_inp_2: .word 0x542e7130
test_310_ajit_res: .word 0xa
test_310_Cmodel_res: .word 0x0

test_311_inp_1: .word 0x960db94
test_311_inp_2: .word 0x5058013d
test_311_ajit_res: .word 0x85
test_311_Cmodel_res: .word 0x0

test_312_inp_1: .word 0xa774ce95
test_312_inp_2: .word 0xea684906
test_312_ajit_res: .word 0x86e6
test_312_Cmodel_res: .word 0x0

test_313_inp_1: .word 0x970ffbf3
test_313_inp_2: .word 0x664456ab
test_313_ajit_res: .word 0x0
test_313_Cmodel_res: .word 0x0

test_314_inp_1: .word 0x833e969c
test_314_inp_2: .word 0x6c4af32a
test_314_ajit_res: .word 0x0
test_314_Cmodel_res: .word 0x0

test_315_inp_1: .word 0x434bd69
test_315_inp_2: .word 0xe0acc005
test_315_ajit_res: .word 0x0
test_315_Cmodel_res: .word 0x0

test_316_inp_1: .word 0x16f8c879
test_316_inp_2: .word 0xf10a1fc2
test_316_ajit_res: .word 0x0
test_316_Cmodel_res: .word 0x0

test_317_inp_1: .word 0xac6db27
test_317_inp_2: .word 0xe5e7ad36
test_317_ajit_res: .word 0x0
test_317_Cmodel_res: .word 0x0

test_318_inp_1: .word 0x9c5387ae
test_318_inp_2: .word 0x786f8e5d
test_318_ajit_res: .word 0x0
test_318_Cmodel_res: .word 0x0

test_319_inp_1: .word 0x3023cf2e
test_319_inp_2: .word 0x7103526d
test_319_ajit_res: .word 0x9faa5
test_319_Cmodel_res: .word 0x0

test_320_inp_1: .word 0x1a2e35c
test_320_inp_2: .word 0xe4e0fab8
test_320_ajit_res: .word 0x0
test_320_Cmodel_res: .word 0x0

test_321_inp_1: .word 0x35899338
test_321_inp_2: .word 0xfa3c892f
test_321_ajit_res: .word 0x80000bac
test_321_Cmodel_res: .word 0x0

test_322_inp_1: .word 0x10bbe9aa
test_322_inp_2: .word 0xdc5d72cd
test_322_ajit_res: .word 0x0
test_322_Cmodel_res: .word 0x0

test_323_inp_1: .word 0x1b523a61
test_323_inp_2: .word 0xdfd8b9ae
test_323_ajit_res: .word 0x80000f85
test_323_Cmodel_res: .word 0x0

test_324_inp_1: .word 0x87d2940c
test_324_inp_2: .word 0x7f332a05
test_324_ajit_res: .word 0x0
test_324_Cmodel_res: .word 0x0

test_325_inp_1: .word 0x1ac3b7b7
test_325_inp_2: .word 0xea99540d
test_325_ajit_res: .word 0x0
test_325_Cmodel_res: .word 0x0

test_326_inp_1: .word 0x183cba35
test_326_inp_2: .word 0x603e6c88
test_326_ajit_res: .word 0x1f
test_326_Cmodel_res: .word 0x0

test_327_inp_1: .word 0x25dc3d53
test_327_inp_2: .word 0xecb80168
test_327_ajit_res: .word 0x80000099
test_327_Cmodel_res: .word 0x0

test_328_inp_1: .word 0x9581f0a2
test_328_inp_2: .word 0xd926c868
test_328_ajit_res: .word 0x31dc
test_328_Cmodel_res: .word 0x0

test_329_inp_1: .word 0x8e98c495
test_329_inp_2: .word 0x57405d90
test_329_ajit_res: .word 0x8000000c
test_329_Cmodel_res: .word 0x0

test_330_inp_1: .word 0x8b1dc204
test_330_inp_2: .word 0x58f62eea
test_330_ajit_res: .word 0x0
test_330_Cmodel_res: .word 0x0

test_331_inp_1: .word 0xb05e872a
test_331_inp_2: .word 0x77c51997
test_331_ajit_res: .word 0x80000048
test_331_Cmodel_res: .word 0x0

test_332_inp_1: .word 0x8f3b5b7d
test_332_inp_2: .word 0x6eca23b7
test_332_ajit_res: .word 0x0
test_332_Cmodel_res: .word 0x0

test_333_inp_1: .word 0x80bf0e1d
test_333_inp_2: .word 0x4eef4ac3
test_333_ajit_res: .word 0x0
test_333_Cmodel_res: .word 0x0

test_334_inp_1: .word 0xd83e3cf
test_334_inp_2: .word 0x4ebd5d72
test_334_ajit_res: .word 0x59266
test_334_Cmodel_res: .word 0x0

test_335_inp_1: .word 0x94fa4895
test_335_inp_2: .word 0x60f7ca41
test_335_ajit_res: .word 0x0
test_335_Cmodel_res: .word 0x0

test_336_inp_1: .word 0x2d0a8809
test_336_inp_2: .word 0xfd79578c
test_336_ajit_res: .word 0x0
test_336_Cmodel_res: .word 0x0

test_337_inp_1: .word 0xacf6c661
test_337_inp_2: .word 0xf36153fc
test_337_ajit_res: .word 0x118
test_337_Cmodel_res: .word 0x0

test_338_inp_1: .word 0xa5fb860d
test_338_inp_2: .word 0x727c5e90
test_338_ajit_res: .word 0x0
test_338_Cmodel_res: .word 0x0

test_339_inp_1: .word 0x969fdae
test_339_inp_2: .word 0xed58fec0
test_339_ajit_res: .word 0x0
test_339_Cmodel_res: .word 0x0

test_340_inp_1: .word 0xf9c992df
test_340_inp_2: .word 0xb9df75d6
test_340_ajit_res: .word 0x7f66ed25
test_340_Cmodel_res: .word 0x0

test_341_inp_1: .word 0xa8e03629
test_341_inp_2: .word 0x6a82e65b
test_341_ajit_res: .word 0x80036cfa
test_341_Cmodel_res: .word 0x0

test_342_inp_1: .word 0x963a849
test_342_inp_2: .word 0xf13c79fc
test_342_ajit_res: .word 0x0
test_342_Cmodel_res: .word 0x0

test_343_inp_1: .word 0x8b7656ef
test_343_inp_2: .word 0x74d9517a
test_343_ajit_res: .word 0x0
test_343_Cmodel_res: .word 0x0

test_344_inp_1: .word 0xa5f41fe2
test_344_inp_2: .word 0xe701d026
test_344_ajit_res: .word 0x785b8
test_344_Cmodel_res: .word 0x0

test_345_inp_1: .word 0x81893f02
test_345_inp_2: .word 0x6b432af6
test_345_ajit_res: .word 0x0
test_345_Cmodel_res: .word 0x0

test_346_inp_1: .word 0x811aa0f5
test_346_inp_2: .word 0x7586a497
test_346_ajit_res: .word 0x0
test_346_Cmodel_res: .word 0x0

test_347_inp_1: .word 0x2f56dae6
test_347_inp_2: .word 0x7549fc83
test_347_ajit_res: .word 0x220
test_347_Cmodel_res: .word 0x0

test_348_inp_1: .word 0x463f9d04
test_348_inp_2: .word 0x6783eab
test_348_ajit_res: .word 0x7f459970
test_348_Cmodel_res: .word 0x0

test_349_inp_1: .word 0x81be89a6
test_349_inp_2: .word 0x41c65d83
test_349_ajit_res: .word 0x801ebcbd
test_349_Cmodel_res: .word 0x0

test_350_inp_1: .word 0x14fb405c
test_350_inp_2: .word 0xe2ef3aa4
test_350_ajit_res: .word 0x0
test_350_Cmodel_res: .word 0x0

test_351_inp_1: .word 0xadec1989
test_351_inp_2: .word 0xf578f207
test_351_ajit_res: .word 0x3c
test_351_Cmodel_res: .word 0x0

test_352_inp_1: .word 0x5eee425
test_352_inp_2: .word 0xf420ba90
test_352_ajit_res: .word 0x0
test_352_Cmodel_res: .word 0x0

test_353_inp_1: .word 0x9a06f967
test_353_inp_2: .word 0xe06d45b2
test_353_ajit_res: .word 0x123
test_353_Cmodel_res: .word 0x0

test_354_inp_1: .word 0xa71b333b
test_354_inp_2: .word 0xeef5c325
test_354_ajit_res: .word 0x28
test_354_Cmodel_res: .word 0x0

test_355_inp_1: .word 0x9b339b91
test_355_inp_2: .word 0xe077b991
test_355_ajit_res: .word 0x5cc
test_355_Cmodel_res: .word 0x0

test_356_inp_1: .word 0x86b18611
test_356_inp_2: .word 0x7803d828
test_356_ajit_res: .word 0x0
test_356_Cmodel_res: .word 0x0

test_357_inp_1: .word 0xece300b
test_357_inp_2: .word 0xd12639ec
test_357_ajit_res: .word 0x80013d8b
test_357_Cmodel_res: .word 0x0

test_358_inp_1: .word 0xa44a04fa
test_358_inp_2: .word 0x7e7c6490
test_358_ajit_res: .word 0x0
test_358_Cmodel_res: .word 0x0

test_359_inp_1: .word 0x2f0f927b
test_359_inp_2: .word 0x755c87bb
test_359_ajit_res: .word 0x14d
test_359_Cmodel_res: .word 0x0

test_360_inp_1: .word 0x20d68310
test_360_inp_2: .word 0xe624120a
test_360_ajit_res: .word 0x8000053a
test_360_Cmodel_res: .word 0x0

test_361_inp_1: .word 0x77b946d
test_361_inp_2: .word 0xcb37dc56
test_361_ajit_res: .word 0x80002bc9
test_361_Cmodel_res: .word 0x0

test_362_inp_1: .word 0x2d315616
test_362_inp_2: .word 0xf981280f
test_362_ajit_res: .word 0x0
test_362_Cmodel_res: .word 0x0

test_363_inp_1: .word 0x98397527
test_363_inp_2: .word 0x652b8349
test_363_ajit_res: .word 0x0
test_363_Cmodel_res: .word 0x0

test_364_inp_1: .word 0x931bfe23
test_364_inp_2: .word 0x772d61cc
test_364_ajit_res: .word 0x0
test_364_Cmodel_res: .word 0x0

test_365_inp_1: .word 0x2e4d2f2f
test_365_inp_2: .word 0xfeb6559b
test_365_ajit_res: .word 0x0
test_365_Cmodel_res: .word 0x0

test_366_inp_1: .word 0x98d3a5bd
test_366_inp_2: .word 0x60e5826f
test_366_ajit_res: .word 0x8000001d
test_366_Cmodel_res: .word 0x0

test_367_inp_1: .word 0xa200c41f
test_367_inp_2: .word 0xeae3d29e
test_367_ajit_res: .word 0x9
test_367_Cmodel_res: .word 0x0

test_368_inp_1: .word 0xad89f6c5
test_368_inp_2: .word 0xf97d72cd
test_368_ajit_res: .word 0x0
test_368_Cmodel_res: .word 0x0

test_369_inp_1: .word 0x93cb3525
test_369_inp_2: .word 0x589d9dd2
test_369_ajit_res: .word 0x80000a50
test_369_Cmodel_res: .word 0x0

test_370_inp_1: .word 0x4b81fc5
test_370_inp_2: .word 0xef5730c5
test_370_ajit_res: .word 0x0
test_370_Cmodel_res: .word 0x0

test_371_inp_1: .word 0x91c898d2
test_371_inp_2: .word 0xd88e2edb
test_371_ajit_res: .word 0xb4
test_371_Cmodel_res: .word 0x0

test_372_inp_1: .word 0x998d3b5c
test_372_inp_2: .word 0xe23221cf
test_372_ajit_res: .word 0xc
test_372_Cmodel_res: .word 0x0

test_373_inp_1: .word 0xa665d90
test_373_inp_2: .word 0xfb5c123a
test_373_ajit_res: .word 0x0
test_373_Cmodel_res: .word 0x0

test_374_inp_1: .word 0x155e2303
test_374_inp_2: .word 0xf6f4d81c
test_374_ajit_res: .word 0x0
test_374_Cmodel_res: .word 0x0

test_375_inp_1: .word 0x8e68c53e
test_375_inp_2: .word 0x4f290579
test_375_ajit_res: .word 0x800b046f
test_375_Cmodel_res: .word 0x0

test_376_inp_1: .word 0xa3be5bf5
test_376_inp_2: .word 0x70d93d35
test_376_ajit_res: .word 0x0
test_376_Cmodel_res: .word 0x0

test_377_inp_1: .word 0x83c4eae7
test_377_inp_2: .word 0xcd98b0cb
test_377_ajit_res: .word 0x2
test_377_Cmodel_res: .word 0x0

test_378_inp_1: .word 0x98120eee
test_378_inp_2: .word 0xe0346329
test_378_ajit_res: .word 0x19
test_378_Cmodel_res: .word 0x0

test_379_inp_1: .word 0x585b21c
test_379_inp_2: .word 0xcb04941f
test_379_ajit_res: .word 0x80000408
test_379_Cmodel_res: .word 0x0

test_380_inp_1: .word 0x958a01eb
test_380_inp_2: .word 0x6359ed30
test_380_ajit_res: .word 0x0
test_380_Cmodel_res: .word 0x0

test_381_inp_1: .word 0xad564eba
test_381_inp_2: .word 0xf4a6a3ba
test_381_ajit_res: .word 0x52
test_381_Cmodel_res: .word 0x0

test_382_inp_1: .word 0x99950e0
test_382_inp_2: .word 0x532d6562
test_382_ajit_res: .word 0x3
test_382_Cmodel_res: .word 0x0

test_383_inp_1: .word 0x819ea872
test_383_inp_2: .word 0xc688857a
test_383_ajit_res: .word 0x94c
test_383_Cmodel_res: .word 0x0

test_384_inp_1: .word 0x996dd96f
test_384_inp_2: .word 0x6a4521af
test_384_ajit_res: .word 0x0
test_384_Cmodel_res: .word 0x0

test_385_inp_1: .word 0x882a8553
test_385_inp_2: .word 0xc89e2b73
test_385_ajit_res: .word 0x113fd8
test_385_Cmodel_res: .word 0x0

test_386_inp_1: .word 0x12261ef2
test_386_inp_2: .word 0xeef177ce
test_386_ajit_res: .word 0x0
test_386_Cmodel_res: .word 0x0

test_387_inp_1: .word 0xb4555ba9
test_387_inp_2: .word 0xfb2ef319
test_387_ajit_res: .word 0x9c
test_387_Cmodel_res: .word 0x0

test_388_inp_1: .word 0x4d6a550
test_388_inp_2: .word 0xdfeae0ae
test_388_ajit_res: .word 0x0
test_388_Cmodel_res: .word 0x0

test_389_inp_1: .word 0x96173771
test_389_inp_2: .word 0x6fdccead
test_389_ajit_res: .word 0x0
test_389_Cmodel_res: .word 0x0

test_390_inp_1: .word 0x8cbfe1b5
test_390_inp_2: .word 0x61a647d1
test_390_ajit_res: .word 0x0
test_390_Cmodel_res: .word 0x0

test_391_inp_1: .word 0x118227bc
test_391_inp_2: .word 0xfbc42dc6
test_391_ajit_res: .word 0x0
test_391_Cmodel_res: .word 0x0

test_392_inp_1: .word 0xaca99e8a
test_392_inp_2: .word 0x706537f6
test_392_ajit_res: .word 0x80002f5b
test_392_Cmodel_res: .word 0x0

test_393_inp_1: .word 0x96c46fa2
test_393_inp_2: .word 0x7d34657a
test_393_ajit_res: .word 0x0
test_393_Cmodel_res: .word 0x0

test_394_inp_1: .word 0x10d9f62e
test_394_inp_2: .word 0xed980520
test_394_ajit_res: .word 0x0
test_394_Cmodel_res: .word 0x0

test_395_inp_1: .word 0x7d905e6b
test_395_inp_2: .word 0xbdfdade5
test_395_ajit_res: .word 0xff11b086
test_395_Cmodel_res: .word 0x0

test_396_inp_1: .word 0x3df9a2d
test_396_inp_2: .word 0xe3dd8e60
test_396_ajit_res: .word 0x0
test_396_Cmodel_res: .word 0x0

test_397_inp_1: .word 0x2a22f748
test_397_inp_2: .word 0xedb2688d
test_397_ajit_res: .word 0x80003a75
test_397_Cmodel_res: .word 0x0

test_398_inp_1: .word 0x997682a8
test_398_inp_2: .word 0x6d576119
test_398_ajit_res: .word 0x0
test_398_Cmodel_res: .word 0x0

test_399_inp_1: .word 0x24d81607
test_399_inp_2: .word 0xe504446b
test_399_ajit_res: .word 0x801a23aa
test_399_Cmodel_res: .word 0x0

test_400_inp_1: .word 0x774a514
test_400_inp_2: .word 0xe914731f
test_400_ajit_res: .word 0x0
test_400_Cmodel_res: .word 0x0

test_401_inp_1: .word 0x22df5efb
test_401_inp_2: .word 0xe904951b
test_401_ajit_res: .word 0x800001af
test_401_Cmodel_res: .word 0x0

test_402_inp_1: .word 0x8f1566e8
test_402_inp_2: .word 0x5ac6968c
test_402_ajit_res: .word 0x0
test_402_Cmodel_res: .word 0x0

test_403_inp_1: .word 0xa8aa239d
test_403_inp_2: .word 0x77e8cbd1
test_403_ajit_res: .word 0x0
test_403_Cmodel_res: .word 0x0

test_404_inp_1: .word 0xa6cb7f8c
test_404_inp_2: .word 0xee667931
test_404_ajit_res: .word 0x38
test_404_Cmodel_res: .word 0x0

test_405_inp_1: .word 0x98cdbbe8
test_405_inp_2: .word 0xd9a52a30
test_405_ajit_res: .word 0x9f70c
test_405_Cmodel_res: .word 0x0

test_406_inp_1: .word 0x82e0e514
test_406_inp_2: .word 0x5608ec95
test_406_ajit_res: .word 0x0
test_406_Cmodel_res: .word 0x0

test_407_inp_1: .word 0x164eb43b
test_407_inp_2: .word 0xd9f0bfbf
test_407_ajit_res: .word 0x800036f3
test_407_Cmodel_res: .word 0x0

test_408_inp_1: .word 0x9a0d85b8
test_408_inp_2: .word 0x7de88c45
test_408_ajit_res: .word 0x0
test_408_Cmodel_res: .word 0x0

test_409_inp_1: .word 0x1fd670ec
test_409_inp_2: .word 0xe8b71929
test_409_ajit_res: .word 0x80000009
test_409_Cmodel_res: .word 0x0

test_410_inp_1: .word 0x8afa7f75
test_410_inp_2: .word 0x678c821f
test_410_ajit_res: .word 0x0
test_410_Cmodel_res: .word 0x0

test_411_inp_1: .word 0x98fe8ecc
test_411_inp_2: .word 0x6dc261bf
test_411_ajit_res: .word 0x0
test_411_Cmodel_res: .word 0x0

test_412_inp_1: .word 0x236abb73
test_412_inp_2: .word 0xf498cf51
test_412_ajit_res: .word 0x0
test_412_Cmodel_res: .word 0x0

test_413_inp_1: .word 0xe56bf5b
test_413_inp_2: .word 0xee044325
test_413_ajit_res: .word 0x0
test_413_Cmodel_res: .word 0x0

test_414_inp_1: .word 0xa985f256
test_414_inp_2: .word 0xee280f91
test_414_ajit_res: .word 0xcc0
test_414_Cmodel_res: .word 0x0

test_415_inp_1: .word 0x248a94c
test_415_inp_2: .word 0xfb457d7c
test_415_ajit_res: .word 0x0
test_415_Cmodel_res: .word 0x0

test_416_inp_1: .word 0x88f607a5
test_416_inp_2: .word 0x4852f724
test_416_ajit_res: .word 0x804aa32d
test_416_Cmodel_res: .word 0x0

test_417_inp_1: .word 0x39b7c20
test_417_inp_2: .word 0xeff60fcf
test_417_ajit_res: .word 0x0
test_417_Cmodel_res: .word 0x0

test_418_inp_1: .word 0x87ff3ffc
test_418_inp_2: .word 0x6011707c
test_418_ajit_res: .word 0x0
test_418_Cmodel_res: .word 0x0

test_419_inp_1: .word 0x138f598d
test_419_inp_2: .word 0xef61bf92
test_419_ajit_res: .word 0x0
test_419_Cmodel_res: .word 0x0

test_420_inp_1: .word 0x9dd8bbe5
test_420_inp_2: .word 0xde200857
test_420_ajit_res: .word 0x15ab42
test_420_Cmodel_res: .word 0x0

test_421_inp_1: .word 0x3535d540
test_421_inp_2: .word 0x7c20434e
test_421_ajit_res: .word 0x91
test_421_Cmodel_res: .word 0x0

test_422_inp_1: .word 0x89a228f8
test_422_inp_2: .word 0x5b1b1a66
test_422_ajit_res: .word 0x0
test_422_Cmodel_res: .word 0x0

test_423_inp_1: .word 0x9b0697f4
test_423_inp_2: .word 0x76fe5208
test_423_ajit_res: .word 0x0
test_423_Cmodel_res: .word 0x0

test_424_inp_1: .word 0xe912df9
test_424_inp_2: .word 0x4eed15ae
test_424_ajit_res: .word 0x139865
test_424_Cmodel_res: .word 0x0

test_425_inp_1: .word 0x2fcde167
test_425_inp_2: .word 0xefc7da77
test_425_ajit_res: .word 0x8020f70d
test_425_Cmodel_res: .word 0x0

test_426_inp_1: .word 0x2b09c12e
test_426_inp_2: .word 0x76ad1fb8
test_426_ajit_res: .word 0x0
test_426_Cmodel_res: .word 0x0

test_427_inp_1: .word 0xa0085f7
test_427_inp_2: .word 0x4d737da8
test_427_ajit_res: .word 0x4390
test_427_Cmodel_res: .word 0x0

test_428_inp_1: .word 0x936c6974
test_428_inp_2: .word 0xd61e2cf5
test_428_ajit_res: .word 0xbf4f
test_428_Cmodel_res: .word 0x0

test_429_inp_1: .word 0x1f904051
test_429_inp_2: .word 0xe4d7181c
test_429_ajit_res: .word 0x8000055d
test_429_Cmodel_res: .word 0x0

test_430_inp_1: .word 0x8b867977
test_430_inp_2: .word 0xd1bfdf43
test_430_ajit_res: .word 0x166
test_430_Cmodel_res: .word 0x0

test_431_inp_1: .word 0x8117c5db
test_431_inp_2: .word 0x4c3fb8ad
test_431_ajit_res: .word 0x0
test_431_Cmodel_res: .word 0x0

test_432_inp_1: .word 0x94feed81
test_432_inp_2: .word 0x6093cde6
test_432_ajit_res: .word 0x0
test_432_Cmodel_res: .word 0x0

test_433_inp_1: .word 0xb082685
test_433_inp_2: .word 0xf4c8ac49
test_433_ajit_res: .word 0x0
test_433_Cmodel_res: .word 0x0

test_434_inp_1: .word 0x2bbca89d
test_434_inp_2: .word 0x6b4a2e8a
test_434_ajit_res: .word 0x3bb823
test_434_Cmodel_res: .word 0x0

test_435_inp_1: .word 0x770cee9
test_435_inp_2: .word 0xcb11d65f
test_435_ajit_res: .word 0x800034d6
test_435_Cmodel_res: .word 0x0

test_436_inp_1: .word 0xfad2fd6
test_436_inp_2: .word 0xe0af655d
test_436_ajit_res: .word 0x0
test_436_Cmodel_res: .word 0x0

test_437_inp_1: .word 0x9887a874
test_437_inp_2: .word 0xdcaac8b0
test_437_ajit_res: .word 0x196b
test_437_Cmodel_res: .word 0x0

test_438_inp_1: .word 0x115dd47
test_438_inp_2: .word 0xed1ee339
test_438_ajit_res: .word 0x0
test_438_Cmodel_res: .word 0x0

test_439_inp_1: .word 0x83992d45
test_439_inp_2: .word 0x600595fd
test_439_ajit_res: .word 0x0
test_439_Cmodel_res: .word 0x0

test_440_inp_1: .word 0x2dd5b672
test_440_inp_2: .word 0xf863441f
test_440_ajit_res: .word 0x80000000
test_440_Cmodel_res: .word 0x0

test_441_inp_1: .word 0x101ba7cd
test_441_inp_2: .word 0xf8a4823c
test_441_ajit_res: .word 0x0
test_441_Cmodel_res: .word 0x0

test_442_inp_1: .word 0x367bfe9d
test_442_inp_2: .word 0x7ca73369
test_442_ajit_res: .word 0x181
test_442_Cmodel_res: .word 0x0

test_443_inp_1: .word 0xf8c69d3
test_443_inp_2: .word 0xd470d988
test_443_ajit_res: .word 0x80000953
test_443_Cmodel_res: .word 0x0

test_444_inp_1: .word 0x1b8213e6
test_444_inp_2: .word 0x66211c39
test_444_ajit_res: .word 0x0
test_444_Cmodel_res: .word 0x0

test_445_inp_1: .word 0x89a7421e
test_445_inp_2: .word 0x5d72ef6c
test_445_ajit_res: .word 0x0
test_445_Cmodel_res: .word 0x0

test_446_inp_1: .word 0x479d113
test_446_inp_2: .word 0xf52e69fe
test_446_ajit_res: .word 0x0
test_446_Cmodel_res: .word 0x0

test_447_inp_1: .word 0x9cf91342
test_447_inp_2: .word 0x6cbf0d4a
test_447_ajit_res: .word 0x0
test_447_Cmodel_res: .word 0x0

test_448_inp_1: .word 0x9cc85dd5
test_448_inp_2: .word 0x792bfbec
test_448_ajit_res: .word 0x0
test_448_Cmodel_res: .word 0x0

test_449_inp_1: .word 0x94a4921e
test_449_inp_2: .word 0xda0d7ccd
test_449_ajit_res: .word 0x4a7
test_449_Cmodel_res: .word 0x0

test_450_inp_1: .word 0x94c17ea8
test_450_inp_2: .word 0xd99fc762
test_450_ajit_res: .word 0x9b0
test_450_Cmodel_res: .word 0x0

test_451_inp_1: .word 0x14d5b729
test_451_inp_2: .word 0xe4278011
test_451_ajit_res: .word 0x0
test_451_Cmodel_res: .word 0x0

test_452_inp_1: .word 0x248fa9d4
test_452_inp_2: .word 0xe712e0ce
test_452_ajit_res: .word 0x8000fa65
test_452_Cmodel_res: .word 0x0

test_453_inp_1: .word 0x4528e30
test_453_inp_2: .word 0xe7003bba
test_453_ajit_res: .word 0x0
test_453_Cmodel_res: .word 0x0

test_454_inp_1: .word 0x2a46d138
test_454_inp_2: .word 0xfc5b0808
test_454_ajit_res: .word 0x0
test_454_Cmodel_res: .word 0x0

test_455_inp_1: .word 0x9570919e
test_455_inp_2: .word 0x6f2ed5df
test_455_ajit_res: .word 0x0
test_455_Cmodel_res: .word 0x0

test_456_inp_1: .word 0x8284659b
test_456_inp_2: .word 0xc8d75280
test_456_ajit_res: .word 0x13a
test_456_Cmodel_res: .word 0x0

test_457_inp_1: .word 0x3676b4ee
test_457_inp_2: .word 0xfd8417fb
test_457_ajit_res: .word 0x80000077
test_457_Cmodel_res: .word 0x0

test_458_inp_1: .word 0x8a4f3be0
test_458_inp_2: .word 0xcb52a259
test_458_ajit_res: .word 0x7def0
test_458_Cmodel_res: .word 0x0

test_459_inp_1: .word 0xbe4212df
test_459_inp_2: .word 0x7f2796b3
test_459_ajit_res: .word 0x800943a8
test_459_Cmodel_res: .word 0x0

test_460_inp_1: .word 0xd260ed9
test_460_inp_2: .word 0x535bdc47
test_460_ajit_res: .word 0x182
test_460_Cmodel_res: .word 0x0

test_461_inp_1: .word 0x11ed90ca
test_461_inp_2: .word 0xdd6b2730
test_461_ajit_res: .word 0x0
test_461_Cmodel_res: .word 0x0

test_462_inp_1: .word 0x1a902941
test_462_inp_2: .word 0xe8b8d53d
test_462_ajit_res: .word 0x0
test_462_Cmodel_res: .word 0x0

test_463_inp_1: .word 0x8750c78d
test_463_inp_2: .word 0x6b8ba3fd
test_463_ajit_res: .word 0x0
test_463_Cmodel_res: .word 0x0

test_464_inp_1: .word 0x31ec9920
test_464_inp_2: .word 0xfbde40c4
test_464_ajit_res: .word 0x80000002
test_464_Cmodel_res: .word 0x0

test_465_inp_1: .word 0x956b88f1
test_465_inp_2: .word 0x6ac103ab
test_465_ajit_res: .word 0x0
test_465_Cmodel_res: .word 0x0

test_466_inp_1: .word 0x17a0c5e3
test_466_inp_2: .word 0xec88efcd
test_466_ajit_res: .word 0x0
test_466_Cmodel_res: .word 0x0

test_467_inp_1: .word 0x2edb5bb6
test_467_inp_2: .word 0xf01a9560
test_467_ajit_res: .word 0x8005ad15
test_467_Cmodel_res: .word 0x0

test_468_inp_1: .word 0x1214619d
test_468_inp_2: .word 0x5ad9df4e
test_468_ajit_res: .word 0xa
test_468_Cmodel_res: .word 0x0

test_469_inp_1: .word 0xa1edd665
test_469_inp_2: .word 0x7f0e0555
test_469_ajit_res: .word 0x0
test_469_Cmodel_res: .word 0x0

test_470_inp_1: .word 0x1611476b
test_470_inp_2: .word 0xe17b3ab5
test_470_ajit_res: .word 0x0
test_470_Cmodel_res: .word 0x0

test_471_inp_1: .word 0x831d07d7
test_471_inp_2: .word 0x5f1932a4
test_471_ajit_res: .word 0x0
test_471_Cmodel_res: .word 0x0

test_472_inp_1: .word 0xa9e1f41
test_472_inp_2: .word 0xe7b2a4ba
test_472_ajit_res: .word 0x0
test_472_Cmodel_res: .word 0x0

test_473_inp_1: .word 0x15d8d3bb
test_473_inp_2: .word 0xfa5939ec
test_473_ajit_res: .word 0x0
test_473_Cmodel_res: .word 0x0

test_474_inp_1: .word 0x8a29aa4f
test_474_inp_2: .word 0x536d2a1f
test_474_ajit_res: .word 0x80000005
test_474_Cmodel_res: .word 0x0

test_475_inp_1: .word 0x2b906e16
test_475_inp_2: .word 0xec051adf
test_475_ajit_res: .word 0x80115c80
test_475_Cmodel_res: .word 0x0

test_476_inp_1: .word 0x8ecff29b
test_476_inp_2: .word 0x6309f075
test_476_ajit_res: .word 0x0
test_476_Cmodel_res: .word 0x0

test_477_inp_1: .word 0x10319d06
test_477_inp_2: .word 0x51b8d50e
test_477_ajit_res: .word 0x3d801
test_477_Cmodel_res: .word 0x0

test_478_inp_1: .word 0x2dd8bb91
test_478_inp_2: .word 0x6ffa5e44
test_478_ajit_res: .word 0x1bb37
test_478_Cmodel_res: .word 0x0

test_479_inp_1: .word 0xfcf0ed
test_479_inp_2: .word 0x42cd6c3d
test_479_ajit_res: .word 0x2766f
test_479_Cmodel_res: .word 0x0

test_480_inp_1: .word 0xada71c2
test_480_inp_2: .word 0xd8a065d3
test_480_ajit_res: .word 0x0
test_480_Cmodel_res: .word 0x0

test_481_inp_1: .word 0x855c7c86
test_481_inp_2: .word 0x535b85e0
test_481_ajit_res: .word 0x0
test_481_Cmodel_res: .word 0x0

test_482_inp_1: .word 0x86399ca7
test_482_inp_2: .word 0x6c867437
test_482_ajit_res: .word 0x0
test_482_Cmodel_res: .word 0x0

test_483_inp_1: .word 0x2123e790
test_483_inp_2: .word 0xe7e8e678
test_483_ajit_res: .word 0x800000b4
test_483_Cmodel_res: .word 0x0

test_484_inp_1: .word 0x1b696983
test_484_inp_2: .word 0xfd7b474f
test_484_ajit_res: .word 0x0
test_484_Cmodel_res: .word 0x0

test_485_inp_1: .word 0x826b9fad
test_485_inp_2: .word 0xc2592b22
test_485_ajit_res: .word 0x22b82a
test_485_Cmodel_res: .word 0x0

test_486_inp_1: .word 0x1fb4e767
test_486_inp_2: .word 0xe85f1fab
test_486_ajit_res: .word 0x8000000c
test_486_Cmodel_res: .word 0x0

test_487_inp_1: .word 0x25f1f2c0
test_487_inp_2: .word 0x6e961d94
test_487_ajit_res: .word 0xc
test_487_Cmodel_res: .word 0x0

test_488_inp_1: .word 0x2b806aae
test_488_inp_2: .word 0xfc628144
test_488_ajit_res: .word 0x0
test_488_Cmodel_res: .word 0x0

test_489_inp_1: .word 0x8e87b432
test_489_inp_2: .word 0x7838ce72
test_489_ajit_res: .word 0x0
test_489_Cmodel_res: .word 0x0

test_490_inp_1: .word 0xd615ea5
test_490_inp_2: .word 0xf008521f
test_490_ajit_res: .word 0x0
test_490_Cmodel_res: .word 0x0

test_491_inp_1: .word 0x893b2afe
test_491_inp_2: .word 0x60f8854c
test_491_ajit_res: .word 0x0
test_491_Cmodel_res: .word 0x0

test_492_inp_1: .word 0x20949489
test_492_inp_2: .word 0xf2b7dceb
test_492_ajit_res: .word 0x0
test_492_Cmodel_res: .word 0x0

test_493_inp_1: .word 0x22790879
test_493_inp_2: .word 0x6db31182
test_493_ajit_res: .word 0x0
test_493_Cmodel_res: .word 0x0

test_494_inp_1: .word 0xb9591381
test_494_inp_2: .word 0xfe093cb5
test_494_ajit_res: .word 0xca7
test_494_Cmodel_res: .word 0x0

test_495_inp_1: .word 0x94ac923e
test_495_inp_2: .word 0xdb81782b
test_495_ajit_res: .word 0xaa
test_495_Cmodel_res: .word 0x0

test_496_inp_1: .word 0xf8349511
test_496_inp_2: .word 0x38468b1a
test_496_ajit_res: .word 0xff68d756
test_496_Cmodel_res: .word 0x0

test_497_inp_1: .word 0xaaad8ce3
test_497_inp_2: .word 0x7d0dce1b
test_497_ajit_res: .word 0x0
test_497_Cmodel_res: .word 0x0

test_498_inp_1: .word 0x14c993bd
test_498_inp_2: .word 0xf17a3ca2
test_498_ajit_res: .word 0x0
test_498_Cmodel_res: .word 0x0

test_499_inp_1: .word 0x92790a6e
test_499_inp_2: .word 0xd5a96d74
test_499_ajit_res: .word 0x5e12
test_499_Cmodel_res: .word 0x0

test_500_inp_1: .word 0x9020b64b
test_500_inp_2: .word 0x5bd4b2df
test_500_ajit_res: .word 0x0
test_500_Cmodel_res: .word 0x0

test_501_inp_1: .word 0x915d5b2e
test_501_inp_2: .word 0x7d284072
test_501_ajit_res: .word 0x0
test_501_Cmodel_res: .word 0x0

test_502_inp_1: .word 0x16e6b2e2
test_502_inp_2: .word 0xd7e7455f
test_502_ajit_res: .word 0x8007faee
test_502_Cmodel_res: .word 0x0

test_503_inp_1: .word 0xf06fbde
test_503_inp_2: .word 0xdfd8afe0
test_503_ajit_res: .word 0x0
test_503_Cmodel_res: .word 0x0

test_504_inp_1: .word 0xdd81754
test_504_inp_2: .word 0xe960896d
test_504_ajit_res: .word 0x0
test_504_Cmodel_res: .word 0x0

test_505_inp_1: .word 0xa7037174
test_505_inp_2: .word 0xec90a9a2
test_505_ajit_res: .word 0x3a2
test_505_Cmodel_res: .word 0x0

test_506_inp_1: .word 0x11fcbbb9
test_506_inp_2: .word 0x57ff477c
test_506_ajit_res: .word 0x1fa
test_506_Cmodel_res: .word 0x0

test_507_inp_1: .word 0x7a8cd13
test_507_inp_2: .word 0xdf5ee0d6
test_507_ajit_res: .word 0x0
test_507_Cmodel_res: .word 0x0

test_508_inp_1: .word 0x8d543d37
test_508_inp_2: .word 0x54a9d18e
test_508_ajit_res: .word 0x8000004f
test_508_Cmodel_res: .word 0x0

test_509_inp_1: .word 0x134c0499
test_509_inp_2: .word 0xe83d43b6
test_509_ajit_res: .word 0x0
test_509_Cmodel_res: .word 0x0

test_510_inp_1: .word 0x1bddcb94
test_510_inp_2: .word 0xf743c2a3
test_510_ajit_res: .word 0x0
test_510_Cmodel_res: .word 0x0

test_511_inp_1: .word 0x98536715
test_511_inp_2: .word 0x628994ed
test_511_ajit_res: .word 0x80000001
test_511_Cmodel_res: .word 0x0

test_512_inp_1: .word 0xaf8d63b3
test_512_inp_2: .word 0x7c9b4b8e
test_512_ajit_res: .word 0x0
test_512_Cmodel_res: .word 0x0

test_513_inp_1: .word 0x9f914f29
test_513_inp_2: .word 0x78fd3673
test_513_ajit_res: .word 0x0
test_513_Cmodel_res: .word 0x0

test_514_inp_1: .word 0xd595997
test_514_inp_2: .word 0xeb1efee2
test_514_ajit_res: .word 0x0
test_514_Cmodel_res: .word 0x0

test_515_inp_1: .word 0x2b465d26
test_515_inp_2: .word 0xfcb0c7b7
test_515_ajit_res: .word 0x0
test_515_Cmodel_res: .word 0x0

test_516_inp_1: .word 0x907c7208
test_516_inp_2: .word 0xd992dfd6
test_516_ajit_res: .word 0x6
test_516_Cmodel_res: .word 0x0

test_517_inp_1: .word 0x36a72a3
test_517_inp_2: .word 0xeaf8b3bc
test_517_ajit_res: .word 0x0
test_517_Cmodel_res: .word 0x0

test_518_inp_1: .word 0x247c53c6
test_518_inp_2: .word 0x6e93dc44
test_518_ajit_res: .word 0x1
test_518_Cmodel_res: .word 0x0

test_519_inp_1: .word 0x67a8667
test_519_inp_2: .word 0xd822d128
test_519_ajit_res: .word 0x0
test_519_Cmodel_res: .word 0x0

test_520_inp_1: .word 0x382e84fc
test_520_inp_2: .word 0xfe90e424
test_520_ajit_res: .word 0x80000134
test_520_Cmodel_res: .word 0x0

test_521_inp_1: .word 0xc519420
test_521_inp_2: .word 0xe464e20a
test_521_ajit_res: .word 0x0
test_521_Cmodel_res: .word 0x0

test_522_inp_1: .word 0x7ba9629
test_522_inp_2: .word 0xfa8c0e56
test_522_ajit_res: .word 0x0
test_522_Cmodel_res: .word 0x0

test_523_inp_1: .word 0x8451d7f8
test_523_inp_2: .word 0x6b701d4f
test_523_ajit_res: .word 0x0
test_523_Cmodel_res: .word 0x0

test_524_inp_1: .word 0xa75ff687
test_524_inp_2: .word 0x68687240
test_524_ajit_res: .word 0x8007b541
test_524_Cmodel_res: .word 0x0

test_525_inp_1: .word 0xc9bc7e07
test_525_inp_2: .word 0x89eb1a19
test_525_ajit_res: .word 0x7f4d3f4c
test_525_Cmodel_res: .word 0x0

test_526_inp_1: .word 0x931e5049
test_526_inp_2: .word 0x7bfcc482
test_526_ajit_res: .word 0x0
test_526_Cmodel_res: .word 0x0

test_527_inp_1: .word 0x87f23c99
test_527_inp_2: .word 0xcc416989
test_527_ajit_res: .word 0x1409
test_527_Cmodel_res: .word 0x0

test_528_inp_1: .word 0x95c01c3b
test_528_inp_2: .word 0x5eae5418
test_528_ajit_res: .word 0x80000008
test_528_Cmodel_res: .word 0x0

test_529_inp_1: .word 0x8c8fa22
test_529_inp_2: .word 0xe61a8d64
test_529_ajit_res: .word 0x0
test_529_Cmodel_res: .word 0x0

test_530_inp_1: .word 0xa212b3a7
test_530_inp_2: .word 0x78ac9b14
test_530_ajit_res: .word 0x0
test_530_Cmodel_res: .word 0x0

test_531_inp_1: .word 0xa69255db
test_531_inp_2: .word 0x690eba2f
test_531_ajit_res: .word 0x80010678
test_531_Cmodel_res: .word 0x0

test_532_inp_1: .word 0x898704b
test_532_inp_2: .word 0xd4b37363
test_532_ajit_res: .word 0x0
test_532_Cmodel_res: .word 0x0

test_533_inp_1: .word 0x153e8f5d
test_533_inp_2: .word 0x5e736bd7
test_533_ajit_res: .word 0x6
test_533_Cmodel_res: .word 0x0

test_534_inp_1: .word 0x1f68374
test_534_inp_2: .word 0xe29a9cb8
test_534_ajit_res: .word 0x0
test_534_Cmodel_res: .word 0x0

test_535_inp_1: .word 0x16a2507
test_535_inp_2: .word 0xfc961ba2
test_535_ajit_res: .word 0x0
test_535_Cmodel_res: .word 0x0

test_536_inp_1: .word 0x9ff7ff40
test_536_inp_2: .word 0x63e626af
test_536_ajit_res: .word 0x8000227b
test_536_Cmodel_res: .word 0x0

test_537_inp_1: .word 0x8e09e885
test_537_inp_2: .word 0xd034b029
test_537_ajit_res: .word 0x186c7
test_537_Cmodel_res: .word 0x0

test_538_inp_1: .word 0x2e1cc023
test_538_inp_2: .word 0x75081ecf
test_538_ajit_res: .word 0x93
test_538_Cmodel_res: .word 0x0

test_539_inp_1: .word 0x183f43e6
test_539_inp_2: .word 0xf8330327
test_539_ajit_res: .word 0x0
test_539_Cmodel_res: .word 0x0

test_540_inp_1: .word 0x17c889ea
test_540_inp_2: .word 0xd84c9890
test_540_ajit_res: .word 0x800faec6
test_540_Cmodel_res: .word 0x0

test_541_inp_1: .word 0x8c8a43f7
test_541_inp_2: .word 0x5a63702d
test_541_ajit_res: .word 0x0
test_541_Cmodel_res: .word 0x0

test_542_inp_1: .word 0x24eae0a4
test_542_inp_2: .word 0x6735c7bb
test_542_ajit_res: .word 0x14ac6
test_542_Cmodel_res: .word 0x0

test_543_inp_1: .word 0x5014f700
test_543_inp_2: .word 0x10691f3a
test_543_ajit_res: .word 0x7f23957a
test_543_Cmodel_res: .word 0x0

test_544_inp_1: .word 0xf7e345f
test_544_inp_2: .word 0xf74c2405
test_544_ajit_res: .word 0x0
test_544_Cmodel_res: .word 0x0

test_545_inp_1: .word 0x2701c276
test_545_inp_2: .word 0xf6aeb7f1
test_545_ajit_res: .word 0x0
test_545_Cmodel_res: .word 0x0

test_546_inp_1: .word 0x92d92276
test_546_inp_2: .word 0x646f1e9d
test_546_ajit_res: .word 0x0
test_546_Cmodel_res: .word 0x0

test_547_inp_1: .word 0xb52609df
test_547_inp_2: .word 0xf7a7a9f1
test_547_ajit_res: .word 0xfd84
test_547_Cmodel_res: .word 0x0

test_548_inp_1: .word 0x83275c8c
test_548_inp_2: .word 0x7e6bf237
test_548_ajit_res: .word 0x0
test_548_Cmodel_res: .word 0x0

test_549_inp_1: .word 0xb23be86
test_549_inp_2: .word 0xe29b5f1f
test_549_ajit_res: .word 0x0
test_549_Cmodel_res: .word 0x0

test_550_inp_1: .word 0x99d3456b
test_550_inp_2: .word 0xdeba6754
test_550_ajit_res: .word 0x911
test_550_Cmodel_res: .word 0x0

test_551_inp_1: .word 0xadedb06
test_551_inp_2: .word 0xe67f88f9
test_551_ajit_res: .word 0x0
test_551_Cmodel_res: .word 0x0

test_552_inp_1: .word 0x978527f8
test_552_inp_2: .word 0x5c3df6e5
test_552_ajit_res: .word 0x80000b37
test_552_Cmodel_res: .word 0x0

test_553_inp_1: .word 0x82882934
test_553_inp_2: .word 0x727c3683
test_553_ajit_res: .word 0x0
test_553_Cmodel_res: .word 0x0

test_554_inp_1: .word 0x14972f2b
test_554_inp_2: .word 0xdf3b45d2
test_554_ajit_res: .word 0x80000000
test_554_Cmodel_res: .word 0x0

test_555_inp_1: .word 0x197a65dd
test_555_inp_2: .word 0xedfc089d
test_555_ajit_res: .word 0x0
test_555_Cmodel_res: .word 0x0

test_556_inp_1: .word 0x88fc18e0
test_556_inp_2: .word 0x77e3bf10
test_556_ajit_res: .word 0x0
test_556_Cmodel_res: .word 0x0

test_557_inp_1: .word 0x9f190e28
test_557_inp_2: .word 0x6559f986
test_557_ajit_res: .word 0x80000167
test_557_Cmodel_res: .word 0x0

test_558_inp_1: .word 0x271c2c8c
test_558_inp_2: .word 0xf33dc48a
test_558_ajit_res: .word 0x0
test_558_Cmodel_res: .word 0x0

test_559_inp_1: .word 0xd74b8e9
test_559_inp_2: .word 0xd75cee7d
test_559_ajit_res: .word 0x80000002
test_559_Cmodel_res: .word 0x0

test_560_inp_1: .word 0xdc4f0e0
test_560_inp_2: .word 0xe8c0188c
test_560_ajit_res: .word 0x0
test_560_Cmodel_res: .word 0x0

test_561_inp_1: .word 0xab937321
test_561_inp_2: .word 0x7b1e8a9a
test_561_ajit_res: .word 0x0
test_561_Cmodel_res: .word 0x0

test_562_inp_1: .word 0x8695e061
test_562_inp_2: .word 0x69a2788d
test_562_ajit_res: .word 0x0
test_562_Cmodel_res: .word 0x0

test_563_inp_1: .word 0x98d83f5f
test_563_inp_2: .word 0x794e0806
test_563_ajit_res: .word 0x0
test_563_Cmodel_res: .word 0x0

test_564_inp_1: .word 0x189f930
test_564_inp_2: .word 0xeb532a87
test_564_ajit_res: .word 0x0
test_564_Cmodel_res: .word 0x0

test_565_inp_1: .word 0x42ac475c
test_565_inp_2: .word 0x82bc6d9f
test_565_ajit_res: .word 0xff6a0f29
test_565_Cmodel_res: .word 0x0

test_566_inp_1: .word 0x180b6bee
test_566_inp_2: .word 0xdba4bbf5
test_566_ajit_res: .word 0x8000362a
test_566_Cmodel_res: .word 0x0

test_567_inp_1: .word 0x6c5a653
test_567_inp_2: .word 0xf3f3f5d4
test_567_ajit_res: .word 0x0
test_567_Cmodel_res: .word 0x0

test_568_inp_1: .word 0x86178ab
test_568_inp_2: .word 0xc9f56931
test_568_ajit_res: .word 0x8003accc
test_568_Cmodel_res: .word 0x0

test_569_inp_1: .word 0x859b0b73
test_569_inp_2: .word 0x7a59b829
test_569_ajit_res: .word 0x0
test_569_Cmodel_res: .word 0x0

test_570_inp_1: .word 0x7429b4e
test_570_inp_2: .word 0xd1455a3b
test_570_ajit_res: .word 0x80000001
test_570_Cmodel_res: .word 0x0

test_571_inp_1: .word 0xd33e613
test_571_inp_2: .word 0x4fc6638b
test_571_ajit_res: .word 0xe823
test_571_Cmodel_res: .word 0x0

test_572_inp_1: .word 0x230e4c9
test_572_inp_2: .word 0xcb90b83d
test_572_ajit_res: .word 0x80000004
test_572_Cmodel_res: .word 0x0

test_573_inp_1: .word 0xa578bcc6
test_573_inp_2: .word 0xeeeb1376
test_573_ajit_res: .word 0x4
test_573_Cmodel_res: .word 0x0

test_574_inp_1: .word 0x89559601
test_574_inp_2: .word 0x4920d2ab
test_574_ajit_res: .word 0x802a7fa4
test_574_Cmodel_res: .word 0x0

test_575_inp_1: .word 0x96b25c8c
test_575_inp_2: .word 0x795a71bd
test_575_ajit_res: .word 0x0
test_575_Cmodel_res: .word 0x0

test_576_inp_1: .word 0xa72986e7
test_576_inp_2: .word 0x695f0ebd
test_576_ajit_res: .word 0x80018520
test_576_Cmodel_res: .word 0x0

test_577_inp_1: .word 0xf3983ba
test_577_inp_2: .word 0xd6955fbd
test_577_ajit_res: .word 0x8000004f
test_577_Cmodel_res: .word 0x0

test_578_inp_1: .word 0xb63ca78f
test_578_inp_2: .word 0x7b678bc9
test_578_ajit_res: .word 0x80000684
test_578_Cmodel_res: .word 0x0

test_579_inp_1: .word 0xa6d37eb0
test_579_inp_2: .word 0xe9a9dc72
test_579_ajit_res: .word 0x9f5f
test_579_Cmodel_res: .word 0x0

test_580_inp_1: .word 0xf225287e
test_580_inp_2: .word 0xb272be8b
test_580_ajit_res: .word 0x7f2e2d54
test_580_Cmodel_res: .word 0x0

test_581_inp_1: .word 0xaff869ac
test_581_inp_2: .word 0xfb75218a
test_581_ajit_res: .word 0x0
test_581_Cmodel_res: .word 0x0

test_582_inp_1: .word 0x2840b0df
test_582_inp_2: .word 0xf532b1b2
test_582_ajit_res: .word 0x0
test_582_Cmodel_res: .word 0x0

test_583_inp_1: .word 0x14fbaae6
test_583_inp_2: .word 0x554c1c95
test_583_ajit_res: .word 0x13ba53
test_583_Cmodel_res: .word 0x0

test_584_inp_1: .word 0x97abff86
test_584_inp_2: .word 0xe33dbecb
test_584_ajit_res: .word 0x0
test_584_Cmodel_res: .word 0x0

test_585_inp_1: .word 0x8c24b40f
test_585_inp_2: .word 0x4e0e72fd
test_585_ajit_res: .word 0x80024ffc
test_585_Cmodel_res: .word 0x0

test_586_inp_1: .word 0x8a8d839d
test_586_inp_2: .word 0x6539e2a2
test_586_ajit_res: .word 0x0
test_586_Cmodel_res: .word 0x0

test_587_inp_1: .word 0x222372b
test_587_inp_2: .word 0xdc29dc48
test_587_ajit_res: .word 0x0
test_587_Cmodel_res: .word 0x0

test_588_inp_1: .word 0x8f9a5aa3
test_588_inp_2: .word 0x5d0ac044
test_588_ajit_res: .word 0x0
test_588_Cmodel_res: .word 0x0

test_589_inp_1: .word 0x26d065a6
test_589_inp_2: .word 0x66f2a214
test_589_ajit_res: .word 0x1b7c17
test_589_Cmodel_res: .word 0x0

test_590_inp_1: .word 0x8d0666fe
test_590_inp_2: .word 0x7ae94452
test_590_ajit_res: .word 0x0
test_590_Cmodel_res: .word 0x0

test_591_inp_1: .word 0xa50f64f0
test_591_inp_2: .word 0x7bb94738
test_591_ajit_res: .word 0x0
test_591_Cmodel_res: .word 0x0

test_592_inp_1: .word 0x8af0710
test_592_inp_2: .word 0xe1ec95f6
test_592_ajit_res: .word 0x0
test_592_Cmodel_res: .word 0x0

test_593_inp_1: .word 0x6cf7e9e
test_593_inp_2: .word 0xca8a0810
test_593_ajit_res: .word 0x8000301a
test_593_Cmodel_res: .word 0x0

test_594_inp_1: .word 0x8ea8e4f0
test_594_inp_2: .word 0xd4ec908b
test_594_ajit_res: .word 0x16d
test_594_Cmodel_res: .word 0x0

test_595_inp_1: .word 0x473caca
test_595_inp_2: .word 0xd87c3fbf
test_595_ajit_res: .word 0x0
test_595_Cmodel_res: .word 0x0

test_596_inp_1: .word 0xb7f1c28c
test_596_inp_2: .word 0x7baf2edc
test_596_ajit_res: .word 0x80002c29
test_596_Cmodel_res: .word 0x0

test_597_inp_1: .word 0xf2044cb
test_597_inp_2: .word 0xf09dc5f7
test_597_ajit_res: .word 0x0
test_597_Cmodel_res: .word 0x0

test_598_inp_1: .word 0x45f2147
test_598_inp_2: .word 0xee8e1efc
test_598_ajit_res: .word 0x0
test_598_Cmodel_res: .word 0x0

test_599_inp_1: .word 0x26d9cc97
test_599_inp_2: .word 0xf62f4572
test_599_ajit_res: .word 0x0
test_599_Cmodel_res: .word 0x0

test_600_inp_1: .word 0x1d0d3a48
test_600_inp_2: .word 0xf2c70a2a
test_600_ajit_res: .word 0x0
test_600_Cmodel_res: .word 0x0

test_601_inp_1: .word 0x2c53cc9e
test_601_inp_2: .word 0xedc4e9be
test_601_ajit_res: .word 0x80044d69
test_601_Cmodel_res: .word 0x0

test_602_inp_1: .word 0x2a05c86f
test_602_inp_2: .word 0xf20bdc8b
test_602_ajit_res: .word 0x8000001e
test_602_Cmodel_res: .word 0x0

test_603_inp_1: .word 0xab8ca86e
test_603_inp_2: .word 0xeeaf92ee
test_603_ajit_res: .word 0x668b
test_603_Cmodel_res: .word 0x0

test_604_inp_1: .word 0xc31ede08
test_604_inp_2: .word 0x3259e87
test_604_ajit_res: .word 0xff75903d
test_604_Cmodel_res: .word 0x0

test_605_inp_1: .word 0x9df7096c
test_605_inp_2: .word 0xe78c5721
test_605_ajit_res: .word 0x3
test_605_Cmodel_res: .word 0x0

test_606_inp_1: .word 0xedfb2f6
test_606_inp_2: .word 0xe8af5876
test_606_ajit_res: .word 0x0
test_606_Cmodel_res: .word 0x0

test_607_inp_1: .word 0x18ee6adb
test_607_inp_2: .word 0x6316e021
test_607_ajit_res: .word 0x1
test_607_Cmodel_res: .word 0x0

test_608_inp_1: .word 0x8faccde7
test_608_inp_2: .word 0xd414fb0f
test_608_ajit_res: .word 0x128e
test_608_Cmodel_res: .word 0x0

test_609_inp_1: .word 0x2eeaf72d
test_609_inp_2: .word 0x71e28a6a
test_609_ajit_res: .word 0x84c2
test_609_Cmodel_res: .word 0x0

test_610_inp_1: .word 0x12fb3f06
test_610_inp_2: .word 0xd66374eb
test_610_ajit_res: .word 0x800046b1
test_610_Cmodel_res: .word 0x0

test_611_inp_1: .word 0x9e77346a
test_611_inp_2: .word 0x67b34af7
test_611_ajit_res: .word 0x80000005
test_611_Cmodel_res: .word 0x0

test_612_inp_1: .word 0x47c77db
test_612_inp_2: .word 0xda628198
test_612_ajit_res: .word 0x0
test_612_Cmodel_res: .word 0x0

test_613_inp_1: .word 0x91189cf7
test_613_inp_2: .word 0xd24e0b34
test_613_ajit_res: .word 0x5eceb
test_613_Cmodel_res: .word 0x0

test_614_inp_1: .word 0x5ce2a9c
test_614_inp_2: .word 0xd32b1092
test_614_ajit_res: .word 0x0
test_614_Cmodel_res: .word 0x0

test_615_inp_1: .word 0x89de842f
test_615_inp_2: .word 0x723258c2
test_615_ajit_res: .word 0x0
test_615_Cmodel_res: .word 0x0

test_616_inp_1: .word 0x8993a676
test_616_inp_2: .word 0x56f183d8
test_616_ajit_res: .word 0x0
test_616_Cmodel_res: .word 0x0

test_617_inp_1: .word 0x8865550a
test_617_inp_2: .word 0x7a448968
test_617_ajit_res: .word 0x0
test_617_Cmodel_res: .word 0x0

test_618_inp_1: .word 0x1221cd93
test_618_inp_2: .word 0x59e4b31a
test_618_ajit_res: .word 0x2d
test_618_Cmodel_res: .word 0x0

test_619_inp_1: .word 0x89ffce53
test_619_inp_2: .word 0x76875f69
test_619_ajit_res: .word 0x0
test_619_Cmodel_res: .word 0x0

test_620_inp_1: .word 0x178e31dc
test_620_inp_2: .word 0xe70179c6
test_620_ajit_res: .word 0x0
test_620_Cmodel_res: .word 0x0

test_621_inp_1: .word 0x1fde74ae
test_621_inp_2: .word 0xf83fdd6b
test_621_ajit_res: .word 0x0
test_621_Cmodel_res: .word 0x0

test_622_inp_1: .word 0x9b5af1b3
test_622_inp_2: .word 0x68fd13a5
test_622_ajit_res: .word 0x0
test_622_Cmodel_res: .word 0x0

test_623_inp_1: .word 0x1eb31265
test_623_inp_2: .word 0xe30e0f5a
test_623_ajit_res: .word 0x8000142b
test_623_Cmodel_res: .word 0x0

test_624_inp_1: .word 0x824f594d
test_624_inp_2: .word 0x45bf723e
test_624_ajit_res: .word 0x80004550
test_624_Cmodel_res: .word 0x0

test_625_inp_1: .word 0xaef2310a
test_625_inp_2: .word 0xf2bc2903
test_625_ajit_res: .word 0x2930
test_625_Cmodel_res: .word 0x0

test_626_inp_1: .word 0x4d15676
test_626_inp_2: .word 0xedefae59
test_626_ajit_res: .word 0x0
test_626_Cmodel_res: .word 0x0

test_627_inp_1: .word 0x17f905e4
test_627_inp_2: .word 0xdff65686
test_627_ajit_res: .word 0x80000020
test_627_Cmodel_res: .word 0x0

test_628_inp_1: .word 0x28b51951
test_628_inp_2: .word 0xf87f6f5e
test_628_ajit_res: .word 0x0
test_628_Cmodel_res: .word 0x0

test_629_inp_1: .word 0x2febd6aa
test_629_inp_2: .word 0xf2e93a95
test_629_ajit_res: .word 0x8000816e
test_629_Cmodel_res: .word 0x0

test_630_inp_1: .word 0x9c95b41b
test_630_inp_2: .word 0x68cee310
test_630_ajit_res: .word 0x0
test_630_Cmodel_res: .word 0x0

test_631_inp_1: .word 0xd6dbcf6
test_631_inp_2: .word 0xe498906f
test_631_ajit_res: .word 0x0
test_631_Cmodel_res: .word 0x0

test_632_inp_1: .word 0x92ce5c66
test_632_inp_2: .word 0x7114a827
test_632_ajit_res: .word 0x0
test_632_Cmodel_res: .word 0x0

test_633_inp_1: .word 0x81f0771d
test_633_inp_2: .word 0x6d6e0214
test_633_ajit_res: .word 0x0
test_633_Cmodel_res: .word 0x0

test_634_inp_1: .word 0x85ab8817
test_634_inp_2: .word 0x6184da23
test_634_ajit_res: .word 0x0
test_634_Cmodel_res: .word 0x0

test_635_inp_1: .word 0x85e7a8cd
test_635_inp_2: .word 0x6f3826f2
test_635_ajit_res: .word 0x0
test_635_Cmodel_res: .word 0x0

test_636_inp_1: .word 0x9eb84939
test_636_inp_2: .word 0x6474fc36
test_636_ajit_res: .word 0x80000302
test_636_Cmodel_res: .word 0x0

test_637_inp_1: .word 0x8392ba5f
test_637_inp_2: .word 0x4ff0b653
test_637_ajit_res: .word 0x0
test_637_Cmodel_res: .word 0x0

test_638_inp_1: .word 0xc3493b0
test_638_inp_2: .word 0x5616ceb1
test_638_ajit_res: .word 0x2
test_638_Cmodel_res: .word 0x0

test_639_inp_1: .word 0x129505a2
test_639_inp_2: .word 0xf60d0af2
test_639_ajit_res: .word 0x0
test_639_Cmodel_res: .word 0x0

test_640_inp_1: .word 0x89905fb4
test_640_inp_2: .word 0xcebace67
test_640_ajit_res: .word 0x62e
test_640_Cmodel_res: .word 0x0

test_641_inp_1: .word 0x9c51d0c9
test_641_inp_2: .word 0x6f535e4d
test_641_ajit_res: .word 0x0
test_641_Cmodel_res: .word 0x0

test_642_inp_1: .word 0x8103ecc8
test_642_inp_2: .word 0x6fc74225
test_642_ajit_res: .word 0x0
test_642_Cmodel_res: .word 0x0

test_643_inp_1: .word 0x8750c7f7
test_643_inp_2: .word 0x6a6cec20
test_643_ajit_res: .word 0x0
test_643_Cmodel_res: .word 0x0

test_644_inp_1: .word 0x2a4b7d7f
test_644_inp_2: .word 0xf9734e2d
test_644_ajit_res: .word 0x0
test_644_Cmodel_res: .word 0x0

test_645_inp_1: .word 0x80b6c65b
test_645_inp_2: .word 0x57ccc6c5
test_645_ajit_res: .word 0x0
test_645_Cmodel_res: .word 0x0

test_646_inp_1: .word 0x80faa9c0
test_646_inp_2: .word 0x6d952701
test_646_ajit_res: .word 0x0
test_646_Cmodel_res: .word 0x0

test_647_inp_1: .word 0x2ecb1b26
test_647_inp_2: .word 0xf85043d1
test_647_ajit_res: .word 0x80000003
test_647_Cmodel_res: .word 0x0

test_648_inp_1: .word 0x8c7199bf
test_648_inp_2: .word 0x578d659c
test_648_ajit_res: .word 0x0
test_648_Cmodel_res: .word 0x0

test_649_inp_1: .word 0x2b71c60
test_649_inp_2: .word 0xc659735d
test_649_ajit_res: .word 0x800035e4
test_649_Cmodel_res: .word 0x0

test_650_inp_1: .word 0x8a879975
test_650_inp_2: .word 0x4c89b181
test_650_ajit_res: .word 0x8001f836
test_650_Cmodel_res: .word 0x0

test_651_inp_1: .word 0x32216b8a
test_651_inp_2: .word 0xf554a062
test_651_ajit_res: .word 0x8000612c
test_651_Cmodel_res: .word 0x0

test_652_inp_1: .word 0xd6576dc
test_652_inp_2: .word 0xd465c763
test_652_ajit_res: .word 0x8000007f
test_652_Cmodel_res: .word 0x0

test_653_inp_1: .word 0x7008ae7
test_653_inp_2: .word 0xddd058e9
test_653_ajit_res: .word 0x0
test_653_Cmodel_res: .word 0x0

test_654_inp_1: .word 0xbdc937e4
test_654_inp_2: .word 0xfd8535be
test_654_ajit_res: .word 0x30564e
test_654_Cmodel_res: .word 0x0

test_655_inp_1: .word 0xac395b45
test_655_inp_2: .word 0x6d69254d
test_655_ajit_res: .word 0x80065c35
test_655_Cmodel_res: .word 0x0

test_656_inp_1: .word 0x9170714e
test_656_inp_2: .word 0x7469a2a2
test_656_ajit_res: .word 0x0
test_656_Cmodel_res: .word 0x0

test_657_inp_1: .word 0x94b3a80f
test_657_inp_2: .word 0xd7faa216
test_657_ajit_res: .word 0x5bc0
test_657_Cmodel_res: .word 0x0

test_658_inp_1: .word 0x3b0394c8
test_658_inp_2: .word 0x7accb0a5
test_658_ajit_res: .word 0x292426
test_658_Cmodel_res: .word 0x0

test_659_inp_1: .word 0x9e4bd0e1
test_659_inp_2: .word 0x6ea85b8a
test_659_ajit_res: .word 0x0
test_659_Cmodel_res: .word 0x0

test_660_inp_1: .word 0x5f5962b
test_660_inp_2: .word 0x512a9bd3
test_660_ajit_res: .word 0x0
test_660_Cmodel_res: .word 0x0

test_661_inp_1: .word 0x98fb6369
test_661_inp_2: .word 0x665e9d62
test_661_ajit_res: .word 0x0
test_661_Cmodel_res: .word 0x0

test_662_inp_1: .word 0x13648222
test_662_inp_2: .word 0xe73f75f2
test_662_ajit_res: .word 0x0
test_662_Cmodel_res: .word 0x0

test_663_inp_1: .word 0x843413ec
test_663_inp_2: .word 0xcf7b89c8
test_663_ajit_res: .word 0x0
test_663_Cmodel_res: .word 0x0

test_664_inp_1: .word 0x8f0dec7e
test_664_inp_2: .word 0x62c492df
test_664_ajit_res: .word 0x0
test_664_Cmodel_res: .word 0x0

test_665_inp_1: .word 0x910d9de1
test_665_inp_2: .word 0x74843b99
test_665_ajit_res: .word 0x0
test_665_Cmodel_res: .word 0x0

test_666_inp_1: .word 0x8bb963cd
test_666_inp_2: .word 0x5fdd158d
test_666_ajit_res: .word 0x0
test_666_Cmodel_res: .word 0x0

test_667_inp_1: .word 0xedb1812
test_667_inp_2: .word 0xd6f4b13e
test_667_ajit_res: .word 0x8000001c
test_667_Cmodel_res: .word 0x0

test_668_inp_1: .word 0x120792f1
test_668_inp_2: .word 0xeb6e197d
test_668_ajit_res: .word 0x0
test_668_Cmodel_res: .word 0x0

test_669_inp_1: .word 0x8c6e8140
test_669_inp_2: .word 0xd4934303
test_669_ajit_res: .word 0x19
test_669_Cmodel_res: .word 0x0

test_670_inp_1: .word 0xa4f2c4e8
test_670_inp_2: .word 0x7197613f
test_670_ajit_res: .word 0x0
test_670_Cmodel_res: .word 0x0

test_671_inp_1: .word 0x65ad8e7
test_671_inp_2: .word 0xf584dec4
test_671_ajit_res: .word 0x0
test_671_Cmodel_res: .word 0x0

test_672_inp_1: .word 0xe5394c3
test_672_inp_2: .word 0xe5b29e66
test_672_ajit_res: .word 0x0
test_672_Cmodel_res: .word 0x0

test_673_inp_1: .word 0x1dbbcaea
test_673_inp_2: .word 0xf831abb9
test_673_ajit_res: .word 0x0
test_673_Cmodel_res: .word 0x0

test_674_inp_1: .word 0xce4fc3e
test_674_inp_2: .word 0xff02446f
test_674_ajit_res: .word 0x0
test_674_Cmodel_res: .word 0x0

test_675_inp_1: .word 0xb19ac57
test_675_inp_2: .word 0xecf930de
test_675_ajit_res: .word 0x0
test_675_Cmodel_res: .word 0x0

test_676_inp_1: .word 0x34785394
test_676_inp_2: .word 0xff535eb1
test_676_ajit_res: .word 0x80000000
test_676_Cmodel_res: .word 0x0

test_677_inp_1: .word 0x99ecd566
test_677_inp_2: .word 0x6b428c06
test_677_ajit_res: .word 0x0
test_677_Cmodel_res: .word 0x0

test_678_inp_1: .word 0xd34d9f4
test_678_inp_2: .word 0x5747ccd1
test_678_ajit_res: .word 0x1
test_678_Cmodel_res: .word 0x0

test_679_inp_1: .word 0xcccfc95
test_679_inp_2: .word 0xf893327a
test_679_ajit_res: .word 0x0
test_679_Cmodel_res: .word 0x0

test_680_inp_1: .word 0x9e74d1b
test_680_inp_2: .word 0xe8c07a19
test_680_ajit_res: .word 0x0
test_680_Cmodel_res: .word 0x0

test_681_inp_1: .word 0x12fd8bf4
test_681_inp_2: .word 0xd3e79c95
test_681_ajit_res: .word 0x8008c1f5
test_681_Cmodel_res: .word 0x0

test_682_inp_1: .word 0x21bf899
test_682_inp_2: .word 0xdc1425bd
test_682_ajit_res: .word 0x0
test_682_Cmodel_res: .word 0x0

test_683_inp_1: .word 0xcde2c42
test_683_inp_2: .word 0xe39895c9
test_683_ajit_res: .word 0x0
test_683_Cmodel_res: .word 0x0

test_684_inp_1: .word 0xb25bdd48
test_684_inp_2: .word 0xf7aa0f91
test_684_ajit_res: .word 0x52b
test_684_Cmodel_res: .word 0x0

test_685_inp_1: .word 0x8a8d044e
test_685_inp_2: .word 0x6a9ef8cc
test_685_ajit_res: .word 0x0
test_685_Cmodel_res: .word 0x0

test_686_inp_1: .word 0x1de6c969
test_686_inp_2: .word 0x5db56a8c
test_686_ajit_res: .word 0x28b55e
test_686_Cmodel_res: .word 0x0

test_687_inp_1: .word 0x111eefbf
test_687_inp_2: .word 0x51cbd0ab
test_687_ajit_res: .word 0xc7a17
test_687_Cmodel_res: .word 0x0

test_688_inp_1: .word 0x913b2d90
test_688_inp_2: .word 0x65ac2d54
test_688_ajit_res: .word 0x0
test_688_Cmodel_res: .word 0x0

test_689_inp_1: .word 0xce01334
test_689_inp_2: .word 0xde541a97
test_689_ajit_res: .word 0x0
test_689_Cmodel_res: .word 0x0

test_690_inp_1: .word 0xa7ac6a76
test_690_inp_2: .word 0x76b55fe7
test_690_ajit_res: .word 0x0
test_690_Cmodel_res: .word 0x0

test_691_inp_1: .word 0x8730c9f2
test_691_inp_2: .word 0x5fd99855
test_691_ajit_res: .word 0x0
test_691_Cmodel_res: .word 0x0

test_692_inp_1: .word 0x2e025670
test_692_inp_2: .word 0xfd40e6d6
test_692_ajit_res: .word 0x0
test_692_Cmodel_res: .word 0x0

test_693_inp_1: .word 0x836a72bd
test_693_inp_2: .word 0x6a84b043
test_693_ajit_res: .word 0x0
test_693_Cmodel_res: .word 0x0

test_694_inp_1: .word 0xa88f4e44
test_694_inp_2: .word 0x69ba3207
test_694_ajit_res: .word 0x8006283f
test_694_Cmodel_res: .word 0x0

test_695_inp_1: .word 0x9c2e2910
test_695_inp_2: .word 0x788cb756
test_695_ajit_res: .word 0x0
test_695_Cmodel_res: .word 0x0

test_696_inp_1: .word 0xb5ec98e3
test_696_inp_2: .word 0xf8ed98fb
test_696_ajit_res: .word 0x7f76
test_696_Cmodel_res: .word 0x0

test_697_inp_1: .word 0xe510a8a
test_697_inp_2: .word 0xcf0bfc4a
test_697_ajit_res: .word 0x800bf24a
test_697_Cmodel_res: .word 0x0

test_698_inp_1: .word 0xec948a2
test_698_inp_2: .word 0xdc7e72cc
test_698_ajit_res: .word 0x0
test_698_Cmodel_res: .word 0x0

test_699_inp_1: .word 0x9d372950
test_699_inp_2: .word 0x7bbfbe9e
test_699_ajit_res: .word 0x0
test_699_Cmodel_res: .word 0x0

test_700_inp_1: .word 0x1e629780
test_700_inp_2: .word 0xdec488e9
test_700_ajit_res: .word 0x8012726b
test_700_Cmodel_res: .word 0x0

test_701_inp_1: .word 0x920f9753
test_701_inp_2: .word 0x7c5d2301
test_701_ajit_res: .word 0x0
test_701_Cmodel_res: .word 0x0

test_702_inp_1: .word 0x2a30c6e1
test_702_inp_2: .word 0x6f730d77
test_702_ajit_res: .word 0x5d1
test_702_Cmodel_res: .word 0x0

test_703_inp_1: .word 0x1a25c2ee
test_703_inp_2: .word 0xed7da992
test_703_ajit_res: .word 0x0
test_703_Cmodel_res: .word 0x0

test_704_inp_1: .word 0xbf9ed4c
test_704_inp_2: .word 0xfc5ebae4
test_704_ajit_res: .word 0x0
test_704_Cmodel_res: .word 0x0

test_705_inp_1: .word 0x8d59179e
test_705_inp_2: .word 0x5af5092b
test_705_ajit_res: .word 0x0
test_705_Cmodel_res: .word 0x0

test_706_inp_1: .word 0x2966ec67
test_706_inp_2: .word 0x69ab3452
test_706_ajit_res: .word 0x1594c1
test_706_Cmodel_res: .word 0x0

test_707_inp_1: .word 0x1ec7b031
test_707_inp_2: .word 0xf0f2ee71
test_707_ajit_res: .word 0x0
test_707_Cmodel_res: .word 0x0

test_708_inp_1: .word 0xb333e64
test_708_inp_2: .word 0xf30e8b7b
test_708_ajit_res: .word 0x0
test_708_Cmodel_res: .word 0x0

test_709_inp_1: .word 0xab9312b0
test_709_inp_2: .word 0xf1643c12
test_709_ajit_res: .word 0x293
test_709_Cmodel_res: .word 0x0

test_710_inp_1: .word 0xb35a23d
test_710_inp_2: .word 0x51366d04
test_710_ajit_res: .word 0x1fd
test_710_Cmodel_res: .word 0x0

test_711_inp_1: .word 0x96b9c028
test_711_inp_2: .word 0x7921f9b6
test_711_ajit_res: .word 0x0
test_711_Cmodel_res: .word 0x0

test_712_inp_1: .word 0xa7aa9d76
test_712_inp_2: .word 0x748f49f4
test_712_ajit_res: .word 0x0
test_712_Cmodel_res: .word 0x0

test_713_inp_1: .word 0xab33ec30
test_713_inp_2: .word 0xf4bf152d
test_713_ajit_res: .word 0x3
test_713_Cmodel_res: .word 0x0

test_714_inp_1: .word 0xad67c5a4
test_714_inp_2: .word 0xefbe86ed
test_714_ajit_res: .word 0x1376b
test_714_Cmodel_res: .word 0x0

test_715_inp_1: .word 0xa57fc667
test_715_inp_2: .word 0xebd21f7e
test_715_ajit_res: .word 0x137
test_715_Cmodel_res: .word 0x0

test_716_inp_1: .word 0x910c1889
test_716_inp_2: .word 0x51bb0167
test_716_ajit_res: .word 0x800bfc88
test_716_Cmodel_res: .word 0x0

test_717_inp_1: .word 0x918d9df9
test_717_inp_2: .word 0x646730e0
test_717_ajit_res: .word 0x0
test_717_Cmodel_res: .word 0x0

test_718_inp_1: .word 0x9d0e8130
test_718_inp_2: .word 0xe83c5324
test_718_ajit_res: .word 0x0
test_718_Cmodel_res: .word 0x0

test_719_inp_1: .word 0x90f03725
test_719_inp_2: .word 0x5480d9cf
test_719_ajit_res: .word 0x80003ba8
test_719_Cmodel_res: .word 0x0

test_720_inp_1: .word 0x135dc9fb
test_720_inp_2: .word 0xe632e58a
test_720_ajit_res: .word 0x0
test_720_Cmodel_res: .word 0x0

test_721_inp_1: .word 0x168a1810
test_721_inp_2: .word 0xe48e6854
test_721_ajit_res: .word 0x0
test_721_Cmodel_res: .word 0x0

test_722_inp_1: .word 0x8cfc3ebd
test_722_inp_2: .word 0x6e58fe28
test_722_ajit_res: .word 0x0
test_722_Cmodel_res: .word 0x0

test_723_inp_1: .word 0x84ec1703
test_723_inp_2: .word 0xc782f4a5
test_723_ajit_res: .word 0xe6c2
test_723_Cmodel_res: .word 0x0

test_724_inp_1: .word 0xa5f4fb11
test_724_inp_2: .word 0x684e0d1a
test_724_ajit_res: .word 0x8001305d
test_724_Cmodel_res: .word 0x0

test_725_inp_1: .word 0x2de745bf
test_725_inp_2: .word 0x6f47a5f7
test_725_ajit_res: .word 0x4a233
test_725_Cmodel_res: .word 0x0

test_726_inp_1: .word 0x810455b7
test_726_inp_2: .word 0x7de4bdae
test_726_ajit_res: .word 0x0
test_726_Cmodel_res: .word 0x0

test_727_inp_1: .word 0xa634e055
test_727_inp_2: .word 0x7df5f40a
test_727_ajit_res: .word 0x0
test_727_Cmodel_res: .word 0x0

test_728_inp_1: .word 0xa36d441b
test_728_inp_2: .word 0x762a1c6c
test_728_ajit_res: .word 0x0
test_728_Cmodel_res: .word 0x0

test_729_inp_1: .word 0x83173256
test_729_inp_2: .word 0xcee5dff8
test_729_ajit_res: .word 0x0
test_729_Cmodel_res: .word 0x0

test_730_inp_1: .word 0x9784a67a
test_730_inp_2: .word 0x6a371c3f
test_730_ajit_res: .word 0x0
test_730_Cmodel_res: .word 0x0

test_731_inp_1: .word 0x13d71d3c
test_731_inp_2: .word 0xfe63c584
test_731_ajit_res: .word 0x0
test_731_Cmodel_res: .word 0x0

test_732_inp_1: .word 0x924f93a9
test_732_inp_2: .word 0x676af534
test_732_ajit_res: .word 0x0
test_732_Cmodel_res: .word 0x0

test_733_inp_1: .word 0x8910f5bf
test_733_inp_2: .word 0x634313ec
test_733_ajit_res: .word 0x0
test_733_Cmodel_res: .word 0x0

test_734_inp_1: .word 0x90997734
test_734_inp_2: .word 0x7185296b
test_734_ajit_res: .word 0x0
test_734_Cmodel_res: .word 0x0

test_735_inp_1: .word 0x1e3f3023
test_735_inp_2: .word 0xff512bfe
test_735_ajit_res: .word 0x0
test_735_Cmodel_res: .word 0x0

test_736_inp_1: .word 0x882aab3f
test_736_inp_2: .word 0x74e616b9
test_736_ajit_res: .word 0x0
test_736_Cmodel_res: .word 0x0

test_737_inp_1: .word 0xb0736856
test_737_inp_2: .word 0x724e9baa
test_737_ajit_res: .word 0x80025b31
test_737_Cmodel_res: .word 0x0

test_738_inp_1: .word 0x9fc5ad2
test_738_inp_2: .word 0xd662aba1
test_738_ajit_res: .word 0x0
test_738_Cmodel_res: .word 0x0

test_739_inp_1: .word 0x9782bb37
test_739_inp_2: .word 0xdc6cd3e5
test_739_ajit_res: .word 0x8d5
test_739_Cmodel_res: .word 0x0

test_740_inp_1: .word 0x396341da
test_740_inp_2: .word 0x7a5d07b6
test_740_ajit_res: .word 0x839b2
test_740_Cmodel_res: .word 0x0

test_741_inp_1: .word 0x81260663
test_741_inp_2: .word 0x7ca29456
test_741_ajit_res: .word 0x0
test_741_Cmodel_res: .word 0x0

test_742_inp_1: .word 0x32ce776e
test_742_inp_2: .word 0x7855669f
test_742_ajit_res: .word 0x3de
test_742_Cmodel_res: .word 0x0

test_743_inp_1: .word 0x14191490
test_743_inp_2: .word 0xe7eaf575
test_743_ajit_res: .word 0x0
test_743_Cmodel_res: .word 0x0

test_744_inp_1: .word 0xb771a4df
test_744_inp_2: .word 0xfea5206a
test_744_ajit_res: .word 0x5d
test_744_Cmodel_res: .word 0x0

test_745_inp_1: .word 0x994baa0b
test_745_inp_2: .word 0x6d52bdce
test_745_ajit_res: .word 0x0
test_745_Cmodel_res: .word 0x0

test_746_inp_1: .word 0x3e96601
test_746_inp_2: .word 0xca036335
test_746_ajit_res: .word 0x800001c6
test_746_Cmodel_res: .word 0x0

test_747_inp_1: .word 0x263c67ce
test_747_inp_2: .word 0xf274272c
test_747_ajit_res: .word 0x0
test_747_Cmodel_res: .word 0x0

test_748_inp_1: .word 0x1077405a
test_748_inp_2: .word 0xf7fc70e4
test_748_ajit_res: .word 0x0
test_748_Cmodel_res: .word 0x0

test_749_inp_1: .word 0xa1baed12
test_749_inp_2: .word 0x7f0d30de
test_749_ajit_res: .word 0x0
test_749_Cmodel_res: .word 0x0

test_750_inp_1: .word 0xb5c68aaf
test_750_inp_2: .word 0xf6f84426
test_750_ajit_res: .word 0x665cf
test_750_Cmodel_res: .word 0x0

test_751_inp_1: .word 0xbdbf0aa
test_751_inp_2: .word 0xcc1fc3ed
test_751_ajit_res: .word 0x801606bc
test_751_Cmodel_res: .word 0x0

test_752_inp_1: .word 0x1cbf878f
test_752_inp_2: .word 0x6583a4a8
test_752_ajit_res: .word 0xb
test_752_Cmodel_res: .word 0x0

test_753_inp_1: .word 0x2c42a19e
test_753_inp_2: .word 0x765ae966
test_753_ajit_res: .word 0x1
test_753_Cmodel_res: .word 0x0

test_754_inp_1: .word 0xa24ed0f4
test_754_inp_2: .word 0x725df75c
test_754_ajit_res: .word 0x0
test_754_Cmodel_res: .word 0x0

test_755_inp_1: .word 0x210e518
test_755_inp_2: .word 0xc8cea261
test_755_ajit_res: .word 0x800000b3
test_755_Cmodel_res: .word 0x0

test_756_inp_1: .word 0xa2d4c2cc
test_756_inp_2: .word 0x6b26aeca
test_756_ajit_res: .word 0x80000014
test_756_Cmodel_res: .word 0x0

test_757_inp_1: .word 0x8c28368a
test_757_inp_2: .word 0xd5d0cd36
test_757_ajit_res: .word 0x3
test_757_Cmodel_res: .word 0x0

test_758_inp_1: .word 0x118ddb28
test_758_inp_2: .word 0xf7f6c5dc
test_758_ajit_res: .word 0x0
test_758_Cmodel_res: .word 0x0

test_759_inp_1: .word 0x86e4efda
test_759_inp_2: .word 0x78ebe8f5
test_759_ajit_res: .word 0x0
test_759_Cmodel_res: .word 0x0

test_760_inp_1: .word 0x83769a16
test_760_inp_2: .word 0x56ba338c
test_760_ajit_res: .word 0x0
test_760_Cmodel_res: .word 0x0

test_761_inp_1: .word 0xbddfe11b
test_761_inp_2: .word 0x7e689d45
test_761_ajit_res: .word 0x800f6630
test_761_Cmodel_res: .word 0x0

test_762_inp_1: .word 0x19493b10
test_762_inp_2: .word 0xfb4fa4a5
test_762_ajit_res: .word 0x0
test_762_Cmodel_res: .word 0x0

test_763_inp_1: .word 0xb5b134de
test_763_inp_2: .word 0xf672942b
test_763_ajit_res: .word 0xbb02c
test_763_Cmodel_res: .word 0x0

test_764_inp_1: .word 0x9a2448ba
test_764_inp_2: .word 0x75532543
test_764_ajit_res: .word 0x0
test_764_Cmodel_res: .word 0x0

test_765_inp_1: .word 0xb028b5ff
test_765_inp_2: .word 0x74785034
test_765_ajit_res: .word 0x800015bd
test_765_Cmodel_res: .word 0x0

test_766_inp_1: .word 0x8501d839
test_766_inp_2: .word 0x7eddc07a
test_766_ajit_res: .word 0x0
test_766_Cmodel_res: .word 0x0

test_767_inp_1: .word 0x11a139cd
test_767_inp_2: .word 0xe588d2a1
test_767_ajit_res: .word 0x0
test_767_Cmodel_res: .word 0x0

test_768_inp_1: .word 0x8f2801a7
test_768_inp_2: .word 0x6c87e309
test_768_ajit_res: .word 0x0
test_768_Cmodel_res: .word 0x0

test_769_inp_1: .word 0x91813df5
test_769_inp_2: .word 0x71c89baa
test_769_ajit_res: .word 0x0
test_769_Cmodel_res: .word 0x0

test_770_inp_1: .word 0x9a869d19
test_770_inp_2: .word 0x6d96a8eb
test_770_ajit_res: .word 0x0
test_770_Cmodel_res: .word 0x0

test_771_inp_1: .word 0x2ff808bf
test_771_inp_2: .word 0xf31006c8
test_771_ajit_res: .word 0x80006e37
test_771_Cmodel_res: .word 0x0

test_772_inp_1: .word 0x256fc7aa
test_772_inp_2: .word 0x6ec84587
test_772_ajit_res: .word 0x4
test_772_Cmodel_res: .word 0x0

test_773_inp_1: .word 0x8baed14a
test_773_inp_2: .word 0x617088a9
test_773_ajit_res: .word 0x0
test_773_Cmodel_res: .word 0x0

test_774_inp_1: .word 0x887aaa60
test_774_inp_2: .word 0x7be1db9b
test_774_ajit_res: .word 0x0
test_774_Cmodel_res: .word 0x0

test_775_inp_1: .word 0x77904f1
test_775_inp_2: .word 0xdb01d742
test_775_ajit_res: .word 0x0
test_775_Cmodel_res: .word 0x0

test_776_inp_1: .word 0x189c5a23
test_776_inp_2: .word 0xe8d98a2f
test_776_ajit_res: .word 0x0
test_776_Cmodel_res: .word 0x0

test_777_inp_1: .word 0x2840f3fa
test_777_inp_2: .word 0xf1cab445
test_777_ajit_res: .word 0x80000003
test_777_Cmodel_res: .word 0x0

test_778_inp_1: .word 0x35bd3692
test_778_inp_2: .word 0xfe875b85
test_778_ajit_res: .word 0x8000000b
test_778_Cmodel_res: .word 0x0

test_779_inp_1: .word 0x1380e906
test_779_inp_2: .word 0xdaa5e496
test_779_ajit_res: .word 0x80000063
test_779_Cmodel_res: .word 0x0

test_780_inp_1: .word 0x855b0ebd
test_780_inp_2: .word 0x7518c39b
test_780_ajit_res: .word 0x0
test_780_Cmodel_res: .word 0x0

test_781_inp_1: .word 0x304b485e
test_781_inp_2: .word 0x71543b3e
test_781_ajit_res: .word 0x7a9a5
test_781_Cmodel_res: .word 0x0

test_782_inp_1: .word 0x8ee14208
test_782_inp_2: .word 0x72adba58
test_782_ajit_res: .word 0x0
test_782_Cmodel_res: .word 0x0

test_783_inp_1: .word 0x818aeac3
test_783_inp_2: .word 0x4681f1ea
test_783_ajit_res: .word 0x8000088d
test_783_Cmodel_res: .word 0x0

test_784_inp_1: .word 0x11151f91
test_784_inp_2: .word 0xee043aa2
test_784_ajit_res: .word 0x0
test_784_Cmodel_res: .word 0x0

test_785_inp_1: .word 0xb1903cd2
test_785_inp_2: .word 0x77415d37
test_785_ajit_res: .word 0x800002fb
test_785_Cmodel_res: .word 0x0

test_786_inp_1: .word 0x92c5ca32
test_786_inp_2: .word 0x5bf06193
test_786_ajit_res: .word 0x80000006
test_786_Cmodel_res: .word 0x0

test_787_inp_1: .word 0xc97eec4
test_787_inp_2: .word 0xd8a25a03
test_787_ajit_res: .word 0x0
test_787_Cmodel_res: .word 0x0

test_788_inp_1: .word 0x36d05c2
test_788_inp_2: .word 0xd9781128
test_788_ajit_res: .word 0x0
test_788_Cmodel_res: .word 0x0

test_789_inp_1: .word 0x183b2201
test_789_inp_2: .word 0xf31cbbbc
test_789_ajit_res: .word 0x0
test_789_Cmodel_res: .word 0x0

test_790_inp_1: .word 0x903c5a0a
test_790_inp_2: .word 0x74dfe134
test_790_ajit_res: .word 0x0
test_790_Cmodel_res: .word 0x0

test_791_inp_1: .word 0x8fa73a02
test_791_inp_2: .word 0x740e8051
test_791_ajit_res: .word 0x0
test_791_Cmodel_res: .word 0x0

test_792_inp_1: .word 0x284cf4ca
test_792_inp_2: .word 0x6c679ba0
test_792_ajit_res: .word 0x1c51
test_792_Cmodel_res: .word 0x0

test_793_inp_1: .word 0x8e4e78f8
test_793_inp_2: .word 0x6b7a5250
test_793_ajit_res: .word 0x0
test_793_Cmodel_res: .word 0x0

test_794_inp_1: .word 0x8c6224e8
test_794_inp_2: .word 0xd718d277
test_794_ajit_res: .word 0x0
test_794_Cmodel_res: .word 0x0

test_795_inp_1: .word 0x89ad5a14
test_795_inp_2: .word 0x7f16a703
test_795_ajit_res: .word 0x0
test_795_Cmodel_res: .word 0x0

test_796_inp_1: .word 0x961187af
test_796_inp_2: .word 0x7a6d2f7d
test_796_ajit_res: .word 0x0
test_796_Cmodel_res: .word 0x0

test_797_inp_1: .word 0x6fb9d1d
test_797_inp_2: .word 0xde58f191
test_797_ajit_res: .word 0x0
test_797_Cmodel_res: .word 0x0

test_798_inp_1: .word 0xf367e3a
test_798_inp_2: .word 0xded51602
test_798_ajit_res: .word 0x0
test_798_Cmodel_res: .word 0x0

test_799_inp_1: .word 0xad1df7b2
test_799_inp_2: .word 0x6e9c76a7
test_799_ajit_res: .word 0x800409d7
test_799_Cmodel_res: .word 0x0

test_800_inp_1: .word 0x80b2e8f4
test_800_inp_2: .word 0x68234262
test_800_ajit_res: .word 0x0
test_800_Cmodel_res: .word 0x0

test_801_inp_1: .word 0x2466212d
test_801_inp_2: .word 0xe832508c
test_801_ajit_res: .word 0x8000294c
test_801_Cmodel_res: .word 0x0

test_802_inp_1: .word 0x2323d6e6
test_802_inp_2: .word 0x66187939
test_802_ajit_res: .word 0x898a
test_802_Cmodel_res: .word 0x0

test_803_inp_1: .word 0x19fc96a7
test_803_inp_2: .word 0xee21d553
test_803_ajit_res: .word 0x0
test_803_Cmodel_res: .word 0x0

test_804_inp_1: .word 0x9221a76d
test_804_inp_2: .word 0x7f49556b
test_804_ajit_res: .word 0x0
test_804_Cmodel_res: .word 0x0

test_805_inp_1: .word 0x8d6eecc3
test_805_inp_2: .word 0x4e2233b8
test_805_ajit_res: .word 0x800bc8b8
test_805_Cmodel_res: .word 0x0

test_806_inp_1: .word 0x1d109032
test_806_inp_2: .word 0xedcc2099
test_806_ajit_res: .word 0x0
test_806_Cmodel_res: .word 0x0

test_807_inp_1: .word 0x288cd40d
test_807_inp_2: .word 0xf3a70c6b
test_807_ajit_res: .word 0x0
test_807_Cmodel_res: .word 0x0

test_808_inp_1: .word 0x21b87d5f
test_808_inp_2: .word 0xec62c096
test_808_ajit_res: .word 0x80000000
test_808_Cmodel_res: .word 0x0

test_809_inp_1: .word 0xde4752c
test_809_inp_2: .word 0xeb78a50c
test_809_ajit_res: .word 0x0
test_809_Cmodel_res: .word 0x0

test_810_inp_1: .word 0x438d7df
test_810_inp_2: .word 0xc6a42f7e
test_810_ajit_res: .word 0x80012035
test_810_Cmodel_res: .word 0x0

test_811_inp_1: .word 0x13dc03bc
test_811_inp_2: .word 0xe6dd0749
test_811_ajit_res: .word 0x0
test_811_Cmodel_res: .word 0x0

test_812_inp_1: .word 0x86ee3819
test_812_inp_2: .word 0x7c4a250f
test_812_ajit_res: .word 0x0
test_812_Cmodel_res: .word 0x0

test_813_inp_1: .word 0x9ffd6d23
test_813_inp_2: .word 0x797b95ef
test_813_ajit_res: .word 0x0
test_813_Cmodel_res: .word 0x0

test_814_inp_1: .word 0x1c715769
test_814_inp_2: .word 0xe511e8c7
test_814_ajit_res: .word 0x8000000d
test_814_Cmodel_res: .word 0x0

test_815_inp_1: .word 0x2686957c
test_815_inp_2: .word 0x710b0268
test_815_ajit_res: .word 0x0
test_815_Cmodel_res: .word 0x0

test_816_inp_1: .word 0xe2a99cc
test_816_inp_2: .word 0xff75dfe5
test_816_ajit_res: .word 0x0
test_816_Cmodel_res: .word 0x0

test_817_inp_1: .word 0xae9588df
test_817_inp_2: .word 0xee428418
test_817_ajit_res: .word 0x31333d
test_817_Cmodel_res: .word 0x0

test_818_inp_1: .word 0x825c4852
test_818_inp_2: .word 0x6197b2d9
test_818_ajit_res: .word 0x0
test_818_Cmodel_res: .word 0x0

test_819_inp_1: .word 0x44300ee
test_819_inp_2: .word 0xef80aae1
test_819_ajit_res: .word 0x0
test_819_Cmodel_res: .word 0x0

test_820_inp_1: .word 0x8d5fa888
test_820_inp_2: .word 0x719c014f
test_820_ajit_res: .word 0x0
test_820_Cmodel_res: .word 0x0

test_821_inp_1: .word 0x22633fd4
test_821_inp_2: .word 0xf6aa3e18
test_821_ajit_res: .word 0x0
test_821_Cmodel_res: .word 0x0

test_822_inp_1: .word 0x9fdb995b
test_822_inp_2: .word 0x72eeeb43
test_822_ajit_res: .word 0x0
test_822_Cmodel_res: .word 0x0

test_823_inp_1: .word 0x14da4fb4
test_823_inp_2: .word 0xf8b0c562
test_823_ajit_res: .word 0x0
test_823_Cmodel_res: .word 0x0

test_824_inp_1: .word 0xafed62c2
test_824_inp_2: .word 0x75114018
test_824_ajit_res: .word 0x80000689
test_824_Cmodel_res: .word 0x0

test_825_inp_1: .word 0x8ffabfa5
test_825_inp_2: .word 0xd9cf87e2
test_825_ajit_res: .word 0x2
test_825_Cmodel_res: .word 0x0

test_826_inp_1: .word 0xd0554fa
test_826_inp_2: .word 0x54dd21d7
test_826_ajit_res: .word 0x26
test_826_Cmodel_res: .word 0x0

test_827_inp_1: .word 0x81e20fb6
test_827_inp_2: .word 0xc28ed83c
test_827_ajit_res: .word 0xca919
test_827_Cmodel_res: .word 0x0

test_828_inp_1: .word 0xaf8e392f
test_828_inp_2: .word 0x7dd6423a
test_828_ajit_res: .word 0x0
test_828_Cmodel_res: .word 0x0

test_829_inp_1: .word 0x927edb2e
test_829_inp_2: .word 0x6a7ccbc3
test_829_ajit_res: .word 0x0
test_829_Cmodel_res: .word 0x0

test_830_inp_1: .word 0x84491065
test_830_inp_2: .word 0x6ef60ba7
test_830_ajit_res: .word 0x0
test_830_Cmodel_res: .word 0x0

test_831_inp_1: .word 0x21f36530
test_831_inp_2: .word 0xe7fd30da
test_831_ajit_res: .word 0x800001ec
test_831_Cmodel_res: .word 0x0

test_832_inp_1: .word 0x623572f
test_832_inp_2: .word 0xf416a8cc
test_832_ajit_res: .word 0x0
test_832_Cmodel_res: .word 0x0

test_833_inp_1: .word 0x91e55894
test_833_inp_2: .word 0x640f780f
test_833_ajit_res: .word 0x0
test_833_Cmodel_res: .word 0x0

test_834_inp_1: .word 0x8bc11456
test_834_inp_2: .word 0x7f299360
test_834_ajit_res: .word 0x0
test_834_Cmodel_res: .word 0x0

test_835_inp_1: .word 0x95bb4a5c
test_835_inp_2: .word 0x62e9b0a4
test_835_ajit_res: .word 0x0
test_835_Cmodel_res: .word 0x0

test_836_inp_1: .word 0x9887ee5
test_836_inp_2: .word 0xcccf642f
test_836_ajit_res: .word 0x8000543e
test_836_Cmodel_res: .word 0x0

test_837_inp_1: .word 0x9dca8243
test_837_inp_2: .word 0x7ddd94c2
test_837_ajit_res: .word 0x0
test_837_Cmodel_res: .word 0x0

test_838_inp_1: .word 0xa50c3c1b
test_838_inp_2: .word 0x7366e6dc
test_838_ajit_res: .word 0x0
test_838_Cmodel_res: .word 0x0

test_839_inp_1: .word 0x8da5bfdc
test_839_inp_2: .word 0x719a7c93
test_839_ajit_res: .word 0x0
test_839_Cmodel_res: .word 0x0

test_840_inp_1: .word 0x14fa07ea
test_840_inp_2: .word 0xd4ead0c9
test_840_ajit_res: .word 0x802212d1
test_840_Cmodel_res: .word 0x0

test_841_inp_1: .word 0xd585dcb
test_841_inp_2: .word 0xdac6e9db
test_841_ajit_res: .word 0x0
test_841_Cmodel_res: .word 0x0

test_842_inp_1: .word 0x3171bdb
test_842_inp_2: .word 0xede2f64d
test_842_ajit_res: .word 0x0
test_842_Cmodel_res: .word 0x0

test_843_inp_1: .word 0x957cee3
test_843_inp_2: .word 0xe1fe8266
test_843_ajit_res: .word 0x0
test_843_Cmodel_res: .word 0x0

test_844_inp_1: .word 0x903285c3
test_844_inp_2: .word 0xd1d5b546
test_844_ajit_res: .word 0x35767
test_844_Cmodel_res: .word 0x0

test_845_inp_1: .word 0x1983efeb
test_845_inp_2: .word 0xeba90754
test_845_ajit_res: .word 0x0
test_845_Cmodel_res: .word 0x0

test_846_inp_1: .word 0xb1249d36
test_846_inp_2: .word 0x72cbc297
test_846_ajit_res: .word 0x80033b45
test_846_Cmodel_res: .word 0x0

test_847_inp_1: .word 0x21aacb9c
test_847_inp_2: .word 0x63f789f0
test_847_ajit_res: .word 0x16144
test_847_Cmodel_res: .word 0x0

test_848_inp_1: .word 0x8d73e472
test_848_inp_2: .word 0xce49cd0c
test_848_ajit_res: .word 0x9ab2b
test_848_Cmodel_res: .word 0x0

test_849_inp_1: .word 0xb21b5b0a
test_849_inp_2: .word 0xf63b0157
test_849_ajit_res: .word 0x1a95
test_849_Cmodel_res: .word 0x0

test_850_inp_1: .word 0x19b97de4
test_850_inp_2: .word 0xf6b93a26
test_850_ajit_res: .word 0x0
test_850_Cmodel_res: .word 0x0

test_851_inp_1: .word 0x82ea3439
test_851_inp_2: .word 0x49cc37ef
test_851_ajit_res: .word 0x80000092
test_851_Cmodel_res: .word 0x0

test_852_inp_1: .word 0xa4b66669
test_852_inp_2: .word 0x671538d4
test_852_ajit_res: .word 0x800138eb
test_852_Cmodel_res: .word 0x0

test_853_inp_1: .word 0x9c0c3ac5
test_853_inp_2: .word 0x71c67a8f
test_853_ajit_res: .word 0x0
test_853_Cmodel_res: .word 0x0

test_854_inp_1: .word 0x9caacaa5
test_854_inp_2: .word 0x7a30831a
test_854_ajit_res: .word 0x0
test_854_Cmodel_res: .word 0x0

test_855_inp_1: .word 0x6a6d139
test_855_inp_2: .word 0x4cbdf059
test_855_ajit_res: .word 0x1c1
test_855_Cmodel_res: .word 0x0

test_856_inp_1: .word 0x8dcf27e0
test_856_inp_2: .word 0x4f517c59
test_856_ajit_res: .word 0x8003f49c
test_856_Cmodel_res: .word 0x0

test_857_inp_1: .word 0x82a2fe06
test_857_inp_2: .word 0x7127c657
test_857_ajit_res: .word 0x0
test_857_Cmodel_res: .word 0x0

test_858_inp_1: .word 0x2b244efb
test_858_inp_2: .word 0xfd9b0f46
test_858_ajit_res: .word 0x0
test_858_Cmodel_res: .word 0x0

test_859_inp_1: .word 0x8e9a70db
test_859_inp_2: .word 0xd0a0e3fb
test_859_ajit_res: .word 0x1eb79
test_859_Cmodel_res: .word 0x0

test_860_inp_1: .word 0x23da7e6d
test_860_inp_2: .word 0xeeeae4a6
test_860_ajit_res: .word 0x0
test_860_Cmodel_res: .word 0x0

test_861_inp_1: .word 0xb947e52d
test_861_inp_2: .word 0xf9ae9c5c
test_861_ajit_res: .word 0x12511e
test_861_Cmodel_res: .word 0x0

test_862_inp_1: .word 0xfec14c66
test_862_inp_2: .word 0x3efe9fc0
test_862_ajit_res: .word 0xff4257cf
test_862_Cmodel_res: .word 0x0

test_863_inp_1: .word 0x94791bec
test_863_inp_2: .word 0x57934dae
test_863_ajit_res: .word 0x80006c3b
test_863_Cmodel_res: .word 0x0

test_864_inp_1: .word 0x9aa08fd8
test_864_inp_2: .word 0xe02d04d5
test_864_ajit_res: .word 0x3b6
test_864_Cmodel_res: .word 0x0

test_865_inp_1: .word 0x1def4bc3
test_865_inp_2: .word 0x6672e088
test_865_ajit_res: .word 0xf
test_865_Cmodel_res: .word 0x0

test_866_inp_1: .word 0x15ec996d
test_866_inp_2: .word 0x5ee1bbad
test_866_ajit_res: .word 0x8
test_866_Cmodel_res: .word 0x0

test_867_inp_1: .word 0xf4354d7
test_867_inp_2: .word 0xdee9415b
test_867_ajit_res: .word 0x0
test_867_Cmodel_res: .word 0x0

test_868_inp_1: .word 0x13b12bd5
test_868_inp_2: .word 0xefb986b0
test_868_ajit_res: .word 0x0
test_868_Cmodel_res: .word 0x0

test_869_inp_1: .word 0xb05a8775
test_869_inp_2: .word 0xf63132cf
test_869_ajit_res: .word 0x277
test_869_Cmodel_res: .word 0x0

test_870_inp_1: .word 0xb96741be
test_870_inp_2: .word 0x7b458bd6
test_870_ajit_res: .word 0x8002575e
test_870_Cmodel_res: .word 0x0

test_871_inp_1: .word 0x62b14cc
test_871_inp_2: .word 0xf2e67435
test_871_ajit_res: .word 0x0
test_871_Cmodel_res: .word 0x0

test_872_inp_1: .word 0xa48fac53
test_872_inp_2: .word 0x71b97ef1
test_872_ajit_res: .word 0x0
test_872_Cmodel_res: .word 0x0

test_873_inp_1: .word 0x9b5a1b2c
test_873_inp_2: .word 0xdfce9153
test_873_ajit_res: .word 0x10e4
test_873_Cmodel_res: .word 0x0

test_874_inp_1: .word 0x810e05ba
test_874_inp_2: .word 0x7695c9a6
test_874_ajit_res: .word 0x0
test_874_Cmodel_res: .word 0x0

test_875_inp_1: .word 0xa2f71f10
test_875_inp_2: .word 0x63b2ccda
test_875_ajit_res: .word 0x800b0e8f
test_875_Cmodel_res: .word 0x0

test_876_inp_1: .word 0x9b01c81b
test_876_inp_2: .word 0xe2525a5a
test_876_ajit_res: .word 0x4e
test_876_Cmodel_res: .word 0x0

test_877_inp_1: .word 0x25f99627
test_877_inp_2: .word 0xf092ca99
test_877_ajit_res: .word 0x80000000
test_877_Cmodel_res: .word 0x0

test_878_inp_1: .word 0x10ff8747
test_878_inp_2: .word 0xe2fa7ecc
test_878_ajit_res: .word 0x0
test_878_Cmodel_res: .word 0x0

test_879_inp_1: .word 0x89f438ae
test_879_inp_2: .word 0xd2de041e
test_879_ajit_res: .word 0x8
test_879_Cmodel_res: .word 0x0

test_880_inp_1: .word 0x8e246e95
test_880_inp_2: .word 0x7d2f22ae
test_880_ajit_res: .word 0x0
test_880_Cmodel_res: .word 0x0

test_881_inp_1: .word 0x19728ee6
test_881_inp_2: .word 0x5d633c91
test_881_ajit_res: .word 0x2228
test_881_Cmodel_res: .word 0x0

test_882_inp_1: .word 0x43f2f4b
test_882_inp_2: .word 0xdb1e4ba0
test_882_ajit_res: .word 0x0
test_882_Cmodel_res: .word 0x0

test_883_inp_1: .word 0xc37a20a
test_883_inp_2: .word 0xf6aad811
test_883_ajit_res: .word 0x0
test_883_Cmodel_res: .word 0x0

test_884_inp_1: .word 0xaa08012f
test_884_inp_2: .word 0xef94b319
test_884_ajit_res: .word 0x3a8
test_884_Cmodel_res: .word 0x0

test_885_inp_1: .word 0x3691ebfd
test_885_inp_2: .word 0x76278f4a
test_885_ajit_res: .word 0x37bc3e
test_885_Cmodel_res: .word 0x0

test_886_inp_1: .word 0xb203bd0b
test_886_inp_2: .word 0x71fac49a
test_886_ajit_res: .word 0x80219f2b
test_886_Cmodel_res: .word 0x0

test_887_inp_1: .word 0xaa2bbd3d
test_887_inp_2: .word 0x6c0d8c9b
test_887_ajit_res: .word 0x80026d33
test_887_Cmodel_res: .word 0x0

test_888_inp_1: .word 0x8157c26b
test_888_inp_2: .word 0x5a494226
test_888_ajit_res: .word 0x0
test_888_Cmodel_res: .word 0x0

test_889_inp_1: .word 0x36d398cd
test_889_inp_2: .word 0xfc895f28
test_889_ajit_res: .word 0x80000314
test_889_Cmodel_res: .word 0x0

test_890_inp_1: .word 0x1635ecc7
test_890_inp_2: .word 0xde09fb31
test_890_ajit_res: .word 0x8000002a
test_890_Cmodel_res: .word 0x0

test_891_inp_1: .word 0x9848bfb8
test_891_inp_2: .word 0x784f7487
test_891_ajit_res: .word 0x0
test_891_Cmodel_res: .word 0x0

test_892_inp_1: .word 0x141263cc
test_892_inp_2: .word 0x551230d9
test_892_ajit_res: .word 0x802c9
test_892_Cmodel_res: .word 0x0

test_893_inp_1: .word 0x3a65a3d
test_893_inp_2: .word 0xd4ddd7ed
test_893_ajit_res: .word 0x0
test_893_Cmodel_res: .word 0x0

test_894_inp_1: .word 0x870188fb
test_894_inp_2: .word 0x75c74d74
test_894_ajit_res: .word 0x0
test_894_Cmodel_res: .word 0x0

test_895_inp_1: .word 0x57208d71
test_895_inp_2: .word 0x975f48f6
test_895_ajit_res: .word 0xff38137e
test_895_Cmodel_res: .word 0x0

test_896_inp_1: .word 0x851b02c0
test_896_inp_2: .word 0x4d22fc41
test_896_ajit_res: .word 0x8000001e
test_896_Cmodel_res: .word 0x0


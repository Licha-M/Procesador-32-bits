	.file	"llvm-link"
	.text
	.globl	bus_Enumeration                 ; -- Begin function bus_Enumeration
	.type	bus_Enumeration,@function
bus_Enumeration:                        ; @bus_Enumeration
; %bb.0:                                ; %entry
	ADI R14, 56
	INT STR R14, R8, 20
	INT STR R14, R9, 16
	INT STR R14, R10, 12
	INT STR R14, R11, 8
	INT STR R14, R12, 4
	INT STR R14, R13, 0
	INT STR R14, R4, 40
	LDI R4, 255
	INT STR R14, R1, 28
	SUB R4, R1, R0
	H LDI R15, %hi(.LBB0_33)
	SLT ADI R15, %lo(.LBB0_33)
	BRH C, R15
	H LDI R15, %hi(.LBB0_1)
	SLT ADI R15, %lo(.LBB0_1)
	JMP R15
.LBB0_33:                               ; %for.end183
	INT LOD R14, R13, 0
	INT LOD R14, R12, 4
	INT LOD R14, R11, 8
	INT LOD R14, R10, 12
	INT LOD R14, R9, 16
	INT LOD R14, R8, 20
	ADI R14, -56
	RET
.LBB0_1:                                ; %for.cond.preheader
	LDI R1, 20
	INT LOD R14, R4, 28
	LSH R4, R1, R1
	NOR R1, R1, R1
	LDI R6, 0
	H LDI R6, 57344
	SLT ADI R6, 0
	NOR R6, R6, R6
	NOR R1, R6, R1
	INT STR R14, R1, 52
	LDI R13, 0
	LDI R8, 65535
	LDI R11, 0
	H LDI R11, 49152
	SLT ADI R11, 0
	LDI R12, 8
	INT STR R14, R13, 32
	INT STR R14, R2, 36
	INT STR R14, R3, 44
	INT STR R14, R5, 48
.LBB0_2:                                ; %for.cond2.preheader
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_3 Depth 2
	INT LOD R14, R6, 52
	SLT ADD R13, R0, R9
.LBB0_3:                                ; %for.body5
                                        ;   Parent Loop BB0_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	INT LOD R6, R1, 0
	AND R1, R8, R1
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB0_28)
	SLT ADI R15, %lo(.LBB0_28)
	BRH EQ, R15
	H LDI R15, %hi(.LBB0_4)
	SLT ADI R15, %lo(.LBB0_4)
	JMP R15
.LBB0_4:                                ; %if.then11
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R3, R1, 0
	LDI R7, 63
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB0_33)
	SLT ADI R15, %lo(.LBB0_33)
	BRH N, R15
	H LDI R15, %hi(.LBB0_5)
	SLT ADI R15, %lo(.LBB0_5)
	JMP R15
.LBB0_5:                                ; %if.end15
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R7, 19
	MUL R1, R7, R1
	ADD R2, R1, R7
	INT LOD R5, R1, 0
	ADD R1, R11, R1
	LDI R13, 24
	RSH R1, R13, R10
	CHAR STR R7, R10, 3
	LDI R4, 16
	RSH R1, R4, R10
	CHAR STR R7, R10, 2
	CHAR STR R7, R1, 0
	RSH R1, R12, R1
	CHAR STR R7, R1, 1
	INT LOD R14, R11, 28
	CHAR STR R7, R11, 16
	INT LOD R14, R1, 32
	CHAR STR R7, R1, 17
	INT STR R14, R9, 24
	CHAR STR R7, R9, 18
	INT LOD R6, R1, 8
	RSH R1, R13, R10
	CHAR STR R7, R10, 15
	RSH R1, R4, R10
	CHAR STR R7, R10, 14
	CHAR STR R7, R1, 12
	RSH R1, R12, R1
	CHAR STR R7, R1, 13
	INT LOD R6, R1, 8
	RSH R1, R13, R1
	LDI R9, 127
	AND R1, R9, R1
	LDI R10, 1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB0_25)
	SLT ADI R15, %lo(.LBB0_25)
	BRH EQ, R15
	H LDI R15, %hi(.LBB0_6)
	SLT ADI R15, %lo(.LBB0_6)
	JMP R15
.LBB0_6:                                ; %if.end15
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R11, 0
	H LDI R11, 49152
	SLT ADI R11, 0
	LDI R13, 0
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB0_32)
	SLT ADI R15, %lo(.LBB0_32)
	BRH NE, R15
	H LDI R15, %hi(.LBB0_7)
	SLT ADI R15, %lo(.LBB0_7)
	JMP R15
.LBB0_7:                                ; %for.cond40.preheader
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -1
	INT STR R6, R2, 4096
	INT LOD R6, R1, 4096
	LDI R8, 24
	SLT ADD R8, R0, R9
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB0_11)
	SLT ADI R15, %lo(.LBB0_11)
	BRH EQ, R15
	H LDI R15, %hi(.LBB0_8)
	SLT ADI R15, %lo(.LBB0_8)
	JMP R15
.LBB0_8:                                ; %if.end58
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R10, 0
	ADD R10, R11, R10
	INT STR R6, R10, 4096
	LDI R8, 4096
	SLT ADD R8, R0, R10
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB0_9)
	SLT ADI R15, %lo(.LBB0_9)
	BRH C, R15
.LBB0_9:                                ; %if.end58
                                        ;   in Loop: Header=BB0_3 Depth=2
	ADI R1, 4095
	LDI R10, 0
	H LDI R10, 0
	SLT ADI R10, -4096
	AND R1, R10, R10
.LBB0_10:                               ; %if.end58
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R1, 0
	ADD R1, R10, R1
	INT STR R5, R1, 0
.LBB0_11:                               ; %for.inc
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT STR R6, R2, 4100
	INT LOD R6, R1, 4100
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB0_15)
	SLT ADI R15, %lo(.LBB0_15)
	BRH EQ, R15
	H LDI R15, %hi(.LBB0_12)
	SLT ADI R15, %lo(.LBB0_12)
	JMP R15
.LBB0_12:                               ; %if.end58.1
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R10, 0
	ADD R10, R11, R10
	INT STR R6, R10, 4100
	LDI R8, 4096
	SLT ADD R8, R0, R10
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB0_13)
	SLT ADI R15, %lo(.LBB0_13)
	BRH C, R15
.LBB0_13:                               ; %if.end58.1
                                        ;   in Loop: Header=BB0_3 Depth=2
	ADI R1, 4095
	LDI R10, 0
	H LDI R10, 0
	SLT ADI R10, -4096
	AND R1, R10, R10
.LBB0_14:                               ; %if.end58.1
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R1, 0
	ADD R1, R10, R1
	INT STR R5, R1, 0
.LBB0_15:                               ; %for.inc.1
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT STR R6, R2, 4104
	INT LOD R6, R1, 4104
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB0_19)
	SLT ADI R15, %lo(.LBB0_19)
	BRH EQ, R15
	H LDI R15, %hi(.LBB0_16)
	SLT ADI R15, %lo(.LBB0_16)
	JMP R15
.LBB0_16:                               ; %if.end58.2
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R10, 0
	ADD R10, R11, R10
	INT STR R6, R10, 4104
	LDI R8, 4096
	SLT ADD R8, R0, R10
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB0_17)
	SLT ADI R15, %lo(.LBB0_17)
	BRH C, R15
.LBB0_17:                               ; %if.end58.2
                                        ;   in Loop: Header=BB0_3 Depth=2
	ADI R1, 4095
	LDI R10, 0
	H LDI R10, 0
	SLT ADI R10, -4096
	AND R1, R10, R10
.LBB0_18:                               ; %if.end58.2
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R1, 0
	ADD R1, R10, R1
	INT STR R5, R1, 0
.LBB0_19:                               ; %for.inc.2
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT STR R6, R2, 4108
	INT LOD R6, R1, 4108
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB0_21)
	SLT ADI R15, %lo(.LBB0_21)
	BRH NE, R15
	H LDI R15, %hi(.LBB0_20)
	SLT ADI R15, %lo(.LBB0_20)
	JMP R15
.LBB0_21:                               ; %if.end58.3
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R10, 0
	ADD R10, R11, R10
	INT STR R6, R10, 4108
	LDI R2, 4097
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB0_23)
	SLT ADI R15, %lo(.LBB0_23)
	BRH C, R15
	H LDI R15, %hi(.LBB0_22)
	SLT ADI R15, %lo(.LBB0_22)
	JMP R15
.LBB0_23:                               ; %if.then63.3
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R1, 0
	ADI R1, 4096
	INT STR R5, R1, 0
.LBB0_24:                               ; %for.inc.3
                                        ;   in Loop: Header=BB0_3 Depth=2
	CHAR LOD R7, R10, 2
	LSH R10, R4, R10
	NOR R10, R10, R10
	CHAR LOD R7, R11, 3
	LSH R11, R9, R11
	NOR R11, R11, R11
	NOR R11, R10, R10
	CHAR LOD R7, R11, 1
	LSH R11, R12, R11
	NOR R11, R11, R11
	SLT ADD R9, R0, R12
	CHAR LOD R7, R8, 0
	NOR R8, R8, R8
	NOR R11, R8, R8
	NOR R10, R10, R10
	NOR R8, R8, R8
	NOR R10, R8, R8
	SUB R1, R8, R1
	LDI R11, 0
	H LDI R11, 49152
	SLT ADI R11, 0
	ADD R1, R11, R1
	RSH R1, R4, R8
	CHAR STR R7, R8, 10
	RSH R1, R12, R8
	CHAR STR R7, R8, 11
	CHAR STR R7, R1, 8
	LDI R2, 8
	RSH R1, R2, R1
	CHAR STR R7, R1, 9
	INT LOD R5, R1, 0
	ADD R1, R11, R1
	RSH R1, R12, R8
	LDI R12, 8
	CHAR STR R7, R8, 7
	RSH R1, R4, R8
	CHAR STR R7, R8, 6
	CHAR STR R7, R1, 4
	RSH R1, R12, R1
	CHAR STR R7, R1, 5
	INT LOD R3, R1, 0
	ADI R1, 1
	INT STR R3, R1, 0
	LDI R8, 65535
	INT LOD R14, R2, 36
	INT LOD R14, R9, 24
	H LDI R15, %hi(.LBB0_28)
	SLT ADI R15, %lo(.LBB0_28)
	JMP R15
.LBB0_25:                               ; %if.then95
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R3, R1, 0
	ADI R1, 1
	INT STR R3, R1, 0
	SLT ADD R12, R0, R9
	LDI R12, 16
	INT LOD R14, R4, 40
	INT LOD R4, R1, 0
	INT LOD R6, R8, 4096
	LDI R10, 0
	H LDI R10, 65280
	SLT ADI R10, 0
	AND R8, R10, R8
	NOR R8, R8, R8
	LSH R1, R12, R10
	LDI R13, 0
	H LDI R13, 255
	SLT ADI R13, 0
	AND R10, R13, R10
	NOR R10, R10, R10
	NOR R10, R8, R8
	NOR R11, R11, R10
	NOR R8, R8, R8
	NOR R8, R10, R8
	INT STR R6, R8, 4096
	LDI R8, 255
	AND R1, R8, R1
	INT LOD R4, R8, 0
	ADI R8, 1
	INT STR R4, R8, 0
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	INT LOD R6, R8, 4096
	LDI R2, 0
	H LDI R2, 65280
	SLT ADI R2, 255
	AND R8, R2, R8
	LSH R1, R9, R1
	NOR R1, R1, R1
	NOR R8, R8, R8
	NOR R8, R1, R1
	INT LOD R4, R8, 0
	SLT ADD R12, R0, R3
	LSH R8, R3, R8
	ADD R8, R13, R8
	AND R8, R13, R8
	NOR R1, R1, R1
	NOR R8, R8, R8
	NOR R8, R1, R1
	INT STR R6, R1, 4096
	INT LOD R5, R1, 0
	LDI R2, 0
	H LDI R2, 49152
	SLT ADI R2, 0
	ADD R1, R2, R10
	LDI R2, 24
	RSH R10, R2, R8
	CHAR STR R7, R8, 7
	RSH R10, R3, R8
	CHAR STR R7, R8, 6
	RSH R10, R9, R8
	CHAR STR R7, R8, 5
	CHAR STR R7, R10, 4
	CHAR LOD R7, R8, 2
	LSH R8, R3, R8
	NOR R8, R8, R8
	CHAR LOD R7, R11, 3
	LSH R11, R2, R11
	NOR R11, R11, R11
	NOR R11, R8, R8
	CHAR LOD R7, R11, 1
	LSH R11, R9, R11
	NOR R11, R11, R11
	CHAR LOD R7, R13, 0
	NOR R13, R13, R13
	NOR R11, R13, R11
	NOR R8, R8, R8
	NOR R11, R11, R11
	NOR R8, R11, R8
	SUB R10, R8, R8
	RSH R8, R2, R11
	CHAR STR R7, R11, 11
	RSH R8, R3, R11
	CHAR STR R7, R11, 10
	CHAR STR R7, R8, 8
	RSH R8, R9, R8
	CHAR STR R7, R8, 9
	CHAR LOD R7, R8, 1
	CHAR LOD R7, R8, 0
	CHAR LOD R7, R8, 2
	CHAR LOD R7, R11, 3
	CHAR LOD R7, R13, 2
	LSH R13, R3, R13
	NOR R13, R13, R13
	CHAR LOD R7, R12, 3
	LSH R12, R2, R12
	NOR R12, R12, R12
	NOR R12, R13, R12
	CHAR LOD R7, R13, 1
	LSH R13, R9, R13
	NOR R13, R13, R13
	CHAR LOD R7, R7, 0
	NOR R7, R7, R7
	NOR R13, R7, R7
	NOR R12, R12, R12
	NOR R7, R7, R7
	NOR R12, R7, R12
	LSH R11, R2, R7
	LSH R8, R3, R8
	NOR R8, R8, R8
	NOR R7, R7, R7
	NOR R7, R8, R7
	RSH R7, R3, R7
	SLT ADD R7, R0, R11
	SUB R12, R10, R0
	H LDI R15, %hi(.LBB0_26)
	SLT ADI R15, %lo(.LBB0_26)
	BRH C, R15
.LBB0_26:                               ; %if.then95
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R2, 0
	H LDI R2, 49152
	SLT ADI R2, -1
	ADD R1, R2, R1
	LDI R2, 16
	RSH R1, R2, R11
.LBB0_27:                               ; %if.then95
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R1, 16
	LSH R11, R1, R1
	NOR R1, R1, R1
	NOR R7, R7, R7
	NOR R1, R7, R1
	LDI R2, 0
	H LDI R2, 65521
	SLT ADI R2, -16
	AND R1, R2, R1
	INT STR R6, R1, 4104
	INT LOD R14, R1, 28
	LDI R13, 0
	LDI R8, 65535
	LDI R11, 0
	H LDI R11, 49152
	SLT ADI R11, 0
	INT LOD R14, R2, 36
	INT LOD R14, R3, 44
	LDI R12, 8
	INT LOD R14, R9, 24
	INT LOD R14, R5, 48
.LBB0_28:                               ; %if.end161
                                        ;   in Loop: Header=BB0_3 Depth=2
	SUB R9, R13, R0
	H LDI R15, %hi(.LBB0_30)
	SLT ADI R15, %lo(.LBB0_30)
	BRH NE, R15
	H LDI R15, %hi(.LBB0_29)
	SLT ADI R15, %lo(.LBB0_29)
	JMP R15
.LBB0_30:                               ; %for.inc174
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R1, 6
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB0_32)
	SLT ADI R15, %lo(.LBB0_32)
	BRH C, R15
	H LDI R15, %hi(.LBB0_31)
	SLT ADI R15, %lo(.LBB0_31)
	JMP R15
.LBB0_29:                               ; %land.lhs.true
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R6, R1, 8
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB0_31)
	SLT ADI R15, %lo(.LBB0_31)
	BRH N, R15
	H LDI R15, %hi(.LBB0_32)
	SLT ADI R15, %lo(.LBB0_32)
	JMP R15
.LBB0_31:                               ; %for.body5.backedge
                                        ;   in Loop: Header=BB0_3 Depth=2
	ADI R6, 4096
	ADI R9, 1
	H LDI R15, %hi(.LBB0_3)
	SLT ADI R15, %lo(.LBB0_3)
	JMP R15
.LBB0_20:                               ; %for.inc.2.for.inc.3_crit_edge
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R1, 0
	H LDI R15, %hi(.LBB0_24)
	SLT ADI R15, %lo(.LBB0_24)
	JMP R15
.LBB0_22:                               ; %if.else.3
                                        ;   in Loop: Header=BB0_3 Depth=2
	ADI R1, 4095
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -4096
	AND R1, R2, R1
	INT LOD R5, R10, 0
	ADD R10, R1, R1
	INT STR R5, R1, 0
	H LDI R15, %hi(.LBB0_24)
	SLT ADI R15, %lo(.LBB0_24)
	JMP R15
.LBB0_32:                               ; %for.inc179
                                        ;   in Loop: Header=BB0_2 Depth=1
	INT LOD R14, R1, 52
	LDI R6, 32768
	ADD R1, R6, R1
	INT STR R14, R1, 52
	INT LOD R14, R6, 32
	ADI R6, 1
	LDI R1, 32
	INT STR R14, R6, 32
	SUB R6, R1, R0
	H LDI R15, %hi(.LBB0_2)
	SLT ADI R15, %lo(.LBB0_2)
	BRH NE, R15
	H LDI R15, %hi(.LBB0_33)
	SLT ADI R15, %lo(.LBB0_33)
	JMP R15
.Lfunc_end0:
	.size	bus_Enumeration, .Lfunc_end0-bus_Enumeration
                                        ; -- End function
	.globl	PCIe_Bus_Enumeration            ; -- Begin function PCIe_Bus_Enumeration
	.type	PCIe_Bus_Enumeration,@function
PCIe_Bus_Enumeration:                   ; @PCIe_Bus_Enumeration
; %bb.0:                                ; %entry
	ADI R14, 12
	ADD R14, R0, R5
	SLT ADD R5, R0, R4
	SLT ADI R4, 0
	LDI R1, 1
	INT STR R4, R1, 0
	SLT ADD R5, R0, R3
	SLT ADI R3, 4
	LDI R1, 0
	INT STR R3, R1, 0
	SLT ADI R5, 8
	INT STR R5, R1, 0
	LDI R2, 0
	H LDI R2, 2048
	SLT ADI R2, 0
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	INT LOD R3, R1, 0
	ADI R14, -12
	RET
.Lfunc_end1:
	.size	PCIe_Bus_Enumeration, .Lfunc_end1-PCIe_Bus_Enumeration
                                        ; -- End function
	.globl	main                            ; -- Begin function main
	.type	main,@function
main:                                   ; @main
; %bb.0:                                ; %entry
	H LDI R15, %hi(PCIe_Bus_Enumeration)
	SLT ADI R15, %lo(PCIe_Bus_Enumeration)
	CAL R15
	LDI R1, 0
	RET
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        ; -- End function
	.ident	"clang version 24.0.0git (https://github.com/Licha-M/llvm-project-ISA32-LM.git 986ce5f670cb25883d5d8a383fe6fbac592ea065)"
	.section	".note.GNU-stack","",@progbits

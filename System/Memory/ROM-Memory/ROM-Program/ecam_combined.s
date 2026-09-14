	.file	"llvm-link"
	.text
	.globl	bus_Enumeration                 ; -- Begin function bus_Enumeration
	.type	bus_Enumeration,@function
bus_Enumeration:                        ; @bus_Enumeration
; %bb.0:                                ; %entry
	ADI R14, 68
	INT STR R14, R8, -44
	INT STR R14, R9, -48
	INT STR R14, R10, -52
	INT STR R14, R11, -56
	INT STR R14, R12, -60
	INT STR R14, R13, -64
	INT STR R14, R4, -40
	SLT ADD R3, R0, R7
	SLT ADD R1, R0, R4
	LDI R1, 255
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB0_37)
	SLT ADI R15, %lo(.LBB0_37)
	BRH C, R15
; %bb.1:                                ; %for.cond.preheader
	LDI R1, 20
	LSH R4, R1, R1
	INT STR R14, R1, -24
	LDI R8, 0
	LDI R12, 0
	H LDI R12, 1
	SLT ADI R12, -1
	LDI R11, 0
	H LDI R11, 49152
	SLT ADI R11, 0
	INT STR R14, R8, -20
	INT STR R14, R5, -16
	INT STR R14, R7, -12
	INT STR R14, R2, -8
	INT STR R14, R4, -4
.LBB0_2:                                ; %for.cond2.preheader
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_3 Depth 2
	SLT ADD R8, R0, R6
	SLT ADD R8, R0, R1
.LBB0_3:                                ; %for.body5
                                        ;   Parent Loop BB0_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	SLT ADD R1, R0, R9
	INT LOD R14, R1, -24
	ADD R1, R6, R10
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 0
	ADD R10, R1, R1
	INT LOD R1, R1, 0
	AND R1, R12, R1
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB0_36)
	SLT ADI R15, %lo(.LBB0_36)
	BRH EQ, R15
; %bb.4:                                ; %if.end12
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R7, R1, 0
	LDI R3, 63
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB0_37)
	SLT ADI R15, %lo(.LBB0_37)
	BRH N, R15
; %bb.5:                                ; %if.end15
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT STR R14, R6, -36
	INT LOD R5, R3, 0
	ADD R3, R11, R3
	LDI R6, 20
	MUL R1, R6, R1
	ADD R2, R1, R13
	INT STR R13, R3, 0
	CHAR STR R13, R4, 16
	INT LOD R14, R1, -20
	CHAR STR R13, R1, 17
	INT STR R14, R9, -32
	CHAR STR R13, R9, 18
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 8
	ADD R10, R1, R1
	INT LOD R1, R9, 0
	LDI R1, 24
	RSH R9, R1, R1
	LDI R3, 127
	AND R1, R3, R1
	INT STR R13, R9, 12
	LDI R3, 1
	SUB R1, R3, R0
	H LDI R15, %hi(.LBB0_6)
	SLT ADI R15, %lo(.LBB0_6)
	BRH NE, R15
; %bb.26:                               ; %if.then75
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R1, 0
	ADD R1, R12, R1
	LDI R3, 0
	H LDI R3, 65535
	SLT ADI R3, 0
	AND R1, R3, R1
	INT STR R5, R1, 0
	ADD R1, R11, R1
	INT STR R13, R1, 0
	INT LOD R7, R1, 0
	ADI R1, 1
	INT STR R7, R1, 0
	INT STR R14, R10, -28
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 16
	ADD R10, R1, R10
	SLT ADD R4, R0, R12
	INT LOD R14, R4, -40
	INT LOD R4, R1, 0
	INT LOD R10, R3, 0
	LDI R6, 0
	H LDI R6, 65280
	SLT ADI R6, 0
	AND R3, R6, R11
	SLT ADD R7, R0, R8
	SLT ADD R2, R0, R7
	LDI R2, 255
	AND R1, R2, R3
	LDI R2, 16
	LSH R3, R2, R6
	NOR R11, R6, R2
	NOR R2, R2, R2
	NOR R2, R12, R2
	LDI R12, 0
	H LDI R12, 1
	SLT ADI R12, -1
	LDI R6, 8
	LSH R3, R6, R11
	NOR R2, R2, R2
	NOR R2, R11, R2
	NOR R2, R2, R2
	INT STR R10, R2, 0
	INT LOD R4, R2, 0
	ADI R2, 1
	INT STR R4, R2, 0
	SLT ADD R7, R0, R2
	SLT ADD R8, R0, R3
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	INT LOD R14, R5, -16
	INT LOD R5, R1, 0
	INT LOD R13, R2, 0
	LDI R3, 0
	H LDI R3, 16384
	SLT ADI R3, 0
	ADD R2, R3, R2
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB0_28)
	SLT ADI R15, %lo(.LBB0_28)
	BRH NC, R15
; %bb.27:                               ; %if.then99
                                        ;   in Loop: Header=BB0_3 Depth=2
	ADD R1, R12, R1
	LDI R2, 0
	H LDI R2, 65535
	SLT ADI R2, 0
	AND R1, R2, R1
	INT STR R5, R1, 0
.LBB0_28:                               ; %if.end102
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R10, R1, 0
	LDI R2, 0
	H LDI R2, 65280
	SLT ADI R2, 255
	AND R1, R2, R1
	INT LOD R14, R2, -40
	INT LOD R2, R2, 0
	LDI R3, 16
	LSH R2, R3, R2
	LDI R3, 0
	H LDI R3, 255
	SLT ADI R3, 0
	ADD R2, R3, R2
	AND R2, R3, R2
	NOR R1, R2, R1
	NOR R1, R1, R1
	NOR R1, R11, R1
	NOR R1, R1, R1
	INT STR R10, R1, 0
	INT LOD R5, R1, 0
	LDI R11, 0
	H LDI R11, 49152
	SLT ADI R11, 0
	ADD R1, R11, R3
	INT STR R13, R3, 4
	INT LOD R13, R2, 0
	SUB R3, R2, R2
	INT STR R13, R2, 8
	INT LOD R13, R4, 0
	LDI R8, 0
	SLT ADD R8, R0, R2
	INT LOD R14, R6, -28
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB0_30)
	SLT ADI R15, %lo(.LBB0_30)
	BRH NC, R15
; %bb.29:                               ; %if.then126
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 4
	ADD R6, R2, R2
	INT LOD R13, R3, 0
	LDI R4, 1
	INT STR R2, R4, 0
	LDI R2, 0
	H LDI R2, 49152
	SLT ADI R2, -1
	ADD R1, R2, R1
	LDI R2, 0
	H LDI R2, 65535
	SLT ADI R2, 0
	AND R1, R2, R1
	LDI R2, 16
	RSH R3, R2, R2
	NOR R2, R1, R1
	NOR R1, R1, R2
.LBB0_30:                               ; %if.end135
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 24
	ADD R6, R1, R1
	INT STR R1, R2, 0
	SLT ADD R8, R0, R1
	INT LOD R14, R7, -12
	SUB R9, R8, R0
	H LDI R15, %hi(.LBB0_32)
	SLT ADI R15, %lo(.LBB0_32)
	BRH NN, R15
; %bb.31:                               ; %if.end135
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R1, 1
.LBB0_32:                               ; %if.end135
                                        ;   in Loop: Header=BB0_3 Depth=2
	SLT ADD R8, R0, R3
	INT LOD R14, R2, -8
	INT LOD R14, R4, -4
	INT LOD R14, R6, -36
	SUB R6, R8, R0
	H LDI R15, %hi(.LBB0_34)
	SLT ADI R15, %lo(.LBB0_34)
	BRH EQ, R15
; %bb.33:                               ; %if.end135
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R3, 1
.LBB0_34:                               ; %if.end135
                                        ;   in Loop: Header=BB0_3 Depth=2
	NOR R3, R1, R1
	NOR R1, R1, R1
	LDI R3, 1
	INT LOD R14, R9, -32
	SUB R1, R3, R0
	H LDI R15, %hi(.LBB0_36)
	SLT ADI R15, %lo(.LBB0_36)
	BRH NE, R15
; %bb.35:                               ; %if.end135
                                        ;   in Loop: Header=BB0_3 Depth=2
	ADI R6, 4096
	SLT ADD R9, R0, R1
	ADI R1, 1
	LDI R3, 7
	SUB R9, R3, R0
	H LDI R15, %hi(.LBB0_3)
	SLT ADI R15, %lo(.LBB0_3)
	BRH C, R15
	H LDI R15, %hi(.LBB0_36)
	SLT ADI R15, %lo(.LBB0_36)
	JMP R15
.LBB0_6:                                ; %if.end15
                                        ;   in Loop: Header=BB0_2 Depth=1
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB0_7)
	SLT ADI R15, %lo(.LBB0_7)
	BRH EQ, R15
.LBB0_36:                               ; %for.inc159
                                        ;   in Loop: Header=BB0_2 Depth=1
	INT LOD R14, R1, -24
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -32768
	ADD R1, R3, R1
	INT STR R14, R1, -24
	INT LOD R14, R3, -20
	ADI R3, 1
	LDI R1, 32
	INT STR R14, R3, -20
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB0_2)
	SLT ADI R15, %lo(.LBB0_2)
	BRH NE, R15
	H LDI R15, %hi(.LBB0_37)
	SLT ADI R15, %lo(.LBB0_37)
	JMP R15
.LBB0_7:                                ; %for.cond31.preheader
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 16
	ADD R10, R1, R4
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -1
	INT STR R4, R2, 0
	INT LOD R4, R3, 0
	LDI R1, 0
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB0_11)
	SLT ADI R15, %lo(.LBB0_11)
	BRH EQ, R15
; %bb.8:                                ; %if.end46
	SLT ADD R7, R0, R8
	LDI R9, 4096
	INT LOD R5, R6, 0
	LDI R7, 0
	H LDI R7, 49152
	SLT ADI R7, 0
	ADD R6, R7, R6
	INT STR R4, R6, 0
	SUB R9, R3, R0
	H LDI R15, %hi(.LBB0_10)
	SLT ADI R15, %lo(.LBB0_10)
	BRH NC, R15
; %bb.9:                                ; %if.end46
	ADI R3, 4095
	LDI R4, 0
	H LDI R4, 0
	SLT ADI R4, -4096
	AND R3, R4, R9
.LBB0_10:                               ; %if.end46
	INT LOD R14, R5, -16
	INT LOD R5, R3, 0
	ADD R3, R9, R3
	INT STR R5, R3, 0
	SLT ADD R8, R0, R7
.LBB0_11:                               ; %for.inc
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 20
	ADD R10, R3, R3
	INT STR R3, R2, 0
	INT LOD R3, R2, 0
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB0_15)
	SLT ADI R15, %lo(.LBB0_15)
	BRH EQ, R15
; %bb.12:                               ; %if.end46.1
	INT LOD R5, R4, 0
	LDI R6, 0
	H LDI R6, 49152
	SLT ADI R6, 0
	ADD R4, R6, R4
	INT STR R3, R4, 0
	LDI R3, 4096
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB0_14)
	SLT ADI R15, %lo(.LBB0_14)
	BRH NC, R15
; %bb.13:                               ; %if.end46.1
	ADI R2, 4095
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -4096
	AND R2, R3, R3
.LBB0_14:                               ; %if.end46.1
	INT LOD R5, R2, 0
	ADD R2, R3, R2
	INT STR R5, R2, 0
.LBB0_15:                               ; %for.inc.1
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 24
	ADD R10, R2, R4
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -1
	INT STR R4, R2, 0
	INT LOD R4, R3, 0
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB0_19)
	SLT ADI R15, %lo(.LBB0_19)
	BRH EQ, R15
; %bb.16:                               ; %if.end46.2
	INT LOD R5, R5, 0
	LDI R6, 0
	H LDI R6, 49152
	SLT ADI R6, 0
	ADD R5, R6, R5
	INT STR R4, R5, 0
	LDI R4, 4096
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB0_18)
	SLT ADI R15, %lo(.LBB0_18)
	BRH NC, R15
; %bb.17:                               ; %if.end46.2
	ADI R3, 4095
	LDI R4, 0
	H LDI R4, 0
	SLT ADI R4, -4096
	AND R3, R4, R4
.LBB0_18:                               ; %if.end46.2
	INT LOD R14, R5, -16
	INT LOD R5, R3, 0
	ADD R3, R4, R3
	INT STR R5, R3, 0
.LBB0_19:                               ; %for.inc.2
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 28
	ADD R10, R3, R3
	INT STR R3, R2, 0
	INT LOD R3, R2, 0
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB0_20)
	SLT ADI R15, %lo(.LBB0_20)
	BRH EQ, R15
; %bb.21:                               ; %if.end46.3
	INT LOD R5, R1, 0
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, 0
	ADD R1, R4, R1
	INT STR R3, R1, 0
	LDI R1, 4097
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB0_22)
	SLT ADI R15, %lo(.LBB0_22)
	BRH NC, R15
; %bb.23:                               ; %if.then50.3
	INT LOD R5, R1, 0
	ADI R1, 4096
	H LDI R15, %hi(.LBB0_24)
	SLT ADI R15, %lo(.LBB0_24)
	JMP R15
.LBB0_20:                               ; %for.inc.2.for.inc.3_crit_edge
	INT LOD R5, R1, 0
	H LDI R15, %hi(.LBB0_25)
	SLT ADI R15, %lo(.LBB0_25)
	JMP R15
.LBB0_22:                               ; %if.else.3
	ADI R2, 4095
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -4096
	AND R2, R1, R1
	INT LOD R5, R2, 0
	ADD R2, R1, R1
.LBB0_24:                               ; %for.inc.3
	INT STR R5, R1, 0
.LBB0_25:                               ; %for.inc.3
	INT LOD R13, R2, 0
	SUB R1, R2, R1
	LDI R2, 0
	H LDI R2, 49152
	SLT ADI R2, 0
	ADD R1, R2, R1
	INT STR R13, R1, 8
	INT LOD R5, R1, 0
	ADD R1, R2, R1
	INT STR R13, R1, 4
	INT LOD R7, R1, 0
	ADI R1, 1
	INT STR R7, R1, 0
.LBB0_37:                               ; %for.end163
	INT LOD R14, R13, -64
	INT LOD R14, R12, -60
	INT LOD R14, R11, -56
	INT LOD R14, R10, -52
	INT LOD R14, R9, -48
	INT LOD R14, R8, -44
	ADI R14, -68
	RET
.Lfunc_end0:
	.size	bus_Enumeration, .Lfunc_end0-bus_Enumeration
                                        ; -- End function
	.globl	PCIe_Bus_Enumeration            ; -- Begin function PCIe_Bus_Enumeration
	.type	PCIe_Bus_Enumeration,@function
PCIe_Bus_Enumeration:                   ; @PCIe_Bus_Enumeration
; %bb.0:                                ; %entry
	ADI R14, 20
	INT STR R14, R8, -16
	ADD R14, R0, R5
	SLT ADD R5, R0, R4
	SLT ADI R4, -12
	LDI R1, 1
	INT STR R4, R1, 0
	SLT ADD R5, R0, R8
	SLT ADI R8, -8
	LDI R1, 0
	INT STR R8, R1, 0
	SLT ADI R5, -4
	INT STR R5, R1, 0
	LDI R2, 0
	H LDI R2, 2048
	SLT ADI R2, 0
	SLT ADD R8, R0, R3
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	INT LOD R8, R1, 0
	INT LOD R14, R8, -16
	ADI R14, -20
	RET
.Lfunc_end1:
	.size	PCIe_Bus_Enumeration, .Lfunc_end1-PCIe_Bus_Enumeration
                                        ; -- End function
	.globl	main                            ; -- Begin function main
	.type	main,@function
main:                                   ; @main
; %bb.0:                                ; %entry
	ADI R14, 4
	H LDI R15, %hi(PCIe_Bus_Enumeration)
	SLT ADI R15, %lo(PCIe_Bus_Enumeration)
	CAL R15
	;APP
	HLT
	;NO_APP
	LDI R1, 0
	ADI R14, -4
	RET
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        ; -- End function
	.ident	"clang version 24.0.0git (https://github.com/Licha-M/llvm-project-ISA32-LM.git e101a52fdf3d077fd625896439b950022aa1450a)"
	.section	".note.GNU-stack","",@progbits

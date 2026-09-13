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
	INT STR R14, R4, -8
	INT STR R14, R2, -28
	LDI R2, 255
	INT STR R14, R1, -32
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB0_1)
	SLT ADI R15, %lo(.LBB0_1)
	BRH NC, R15
.LBB0_37:                               ; %for.end154
	INT LOD R14, R13, -64
	INT LOD R14, R12, -60
	INT LOD R14, R11, -56
	INT LOD R14, R10, -52
	INT LOD R14, R9, -48
	INT LOD R14, R8, -44
	ADI R14, -68
	RET
.LBB0_1:                                ; %for.cond.preheader
	LDI R6, 20
	INT LOD R14, R1, -32
	LSH R1, R6, R8
	LDI R12, 0
	LDI R13, 1
	INT STR R14, R12, -20
	INT STR R14, R3, -4
	H LDI R15, %hi(.LBB0_2)
	SLT ADI R15, %lo(.LBB0_2)
	JMP R15
.LBB0_36:                               ; %for.inc150
                                        ;   in Loop: Header=BB0_2 Depth=1
	LDI R1, 0
	H LDI R1, 1
	SLT ADI R1, -32768
	ADD R8, R1, R8
	INT LOD R14, R2, -20
	ADI R2, 1
	LDI R1, 32
	INT STR R14, R2, -20
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB0_37)
	SLT ADI R15, %lo(.LBB0_37)
	BRH EQ, R15
.LBB0_2:                                ; %for.cond2.preheader
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_3 Depth 2
	INT STR R14, R12, -40
	SLT ADD R12, R0, R1
	INT STR R14, R8, -12
.LBB0_3:                                ; %for.body5
                                        ;   Parent Loop BB0_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	INT STR R14, R1, -36
	INT LOD R14, R1, -40
	ADD R8, R1, R9
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 0
	ADD R9, R1, R1
	INT LOD R1, R1, 0
	LDI R2, 0
	H LDI R2, 1
	SLT ADI R2, -1
	AND R1, R2, R1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB0_36)
	SLT ADI R15, %lo(.LBB0_36)
	BRH EQ, R15
; %bb.4:                                ; %if.end12
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R3, R1, 0
	LDI R2, 63
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB0_37)
	SLT ADI R15, %lo(.LBB0_37)
	BRH N, R15
; %bb.5:                                ; %if.end15
                                        ;   in Loop: Header=BB0_3 Depth=2
	SLT ADD R8, R0, R4
	INT LOD R5, R2, 0
	LDI R7, 0
	H LDI R7, 49152
	SLT ADI R7, 0
	ADD R2, R7, R2
	SLT ADD R6, R0, R7
	MUL R1, R6, R1
	INT LOD R14, R8, -28
	ADD R8, R1, R10
	INT STR R10, R2, 0
	INT LOD R14, R11, -32
	CHAR STR R10, R11, 16
	INT LOD R14, R1, -20
	CHAR STR R10, R1, 17
	INT LOD R14, R1, -36
	CHAR STR R10, R1, 18
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 8
	ADD R9, R1, R1
	INT LOD R1, R6, 0
	LDI R1, 24
	RSH R6, R1, R1
	LDI R2, 127
	AND R1, R2, R1
	INT STR R14, R6, -24
	INT STR R10, R6, 12
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB0_26)
	SLT ADI R15, %lo(.LBB0_26)
	BRH EQ, R15
; %bb.6:                                ; %if.end15
                                        ;   in Loop: Header=BB0_3 Depth=2
	SLT ADD R7, R0, R6
	SLT ADD R4, R0, R8
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB0_36)
	SLT ADI R15, %lo(.LBB0_36)
	BRH NE, R15
; %bb.7:                                ; %for.cond31.preheader
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 16
	ADD R9, R1, R2
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	INT STR R2, R1, 0
	INT LOD R2, R1, 0
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, 0
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB0_11)
	SLT ADI R15, %lo(.LBB0_11)
	BRH EQ, R15
; %bb.8:                                ; %if.end46
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R13, 0
	H LDI R13, 49152
	SLT ADI R13, 0
	INT LOD R5, R4, 0
	ADD R4, R13, R4
	INT STR R2, R4, 0
	LDI R4, 4096
	SLT ADD R4, R0, R2
	SUB R4, R1, R0
	H LDI R15, %hi(.LBB0_10)
	SLT ADI R15, %lo(.LBB0_10)
	BRH NC, R15
; %bb.9:                                ; %if.end46
                                        ;   in Loop: Header=BB0_3 Depth=2
	ADI R1, 4095
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -4096
	AND R1, R2, R2
.LBB0_10:                               ; %if.end46
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R1, 0
	ADD R1, R2, R1
	INT STR R5, R1, 0
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, 0
	LDI R13, 1
.LBB0_11:                               ; %for.inc
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 20
	ADD R9, R1, R2
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	INT STR R2, R1, 0
	INT LOD R2, R1, 0
	INT LOD R14, R7, -28
	INT LOD R14, R11, -32
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB0_15)
	SLT ADI R15, %lo(.LBB0_15)
	BRH EQ, R15
; %bb.12:                               ; %if.end46.1
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R13, 0
	H LDI R13, 49152
	SLT ADI R13, 0
	INT LOD R5, R4, 0
	ADD R4, R13, R4
	INT STR R2, R4, 0
	LDI R4, 4096
	SLT ADD R4, R0, R2
	SUB R4, R1, R0
	H LDI R15, %hi(.LBB0_14)
	SLT ADI R15, %lo(.LBB0_14)
	BRH NC, R15
; %bb.13:                               ; %if.end46.1
                                        ;   in Loop: Header=BB0_3 Depth=2
	ADI R1, 4095
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -4096
	AND R1, R2, R2
.LBB0_14:                               ; %if.end46.1
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R1, 0
	ADD R1, R2, R1
	INT STR R5, R1, 0
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, 0
	LDI R13, 1
.LBB0_15:                               ; %for.inc.1
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 24
	ADD R9, R1, R2
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	INT STR R2, R1, 0
	INT LOD R2, R1, 0
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB0_19)
	SLT ADI R15, %lo(.LBB0_19)
	BRH EQ, R15
; %bb.16:                               ; %if.end46.2
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R13, 0
	H LDI R13, 49152
	SLT ADI R13, 0
	INT LOD R5, R4, 0
	ADD R4, R13, R4
	INT STR R2, R4, 0
	LDI R4, 4096
	SLT ADD R4, R0, R2
	SUB R4, R1, R0
	H LDI R15, %hi(.LBB0_18)
	SLT ADI R15, %lo(.LBB0_18)
	BRH NC, R15
; %bb.17:                               ; %if.end46.2
                                        ;   in Loop: Header=BB0_3 Depth=2
	ADI R1, 4095
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -4096
	AND R1, R2, R2
.LBB0_18:                               ; %if.end46.2
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R1, 0
	ADD R1, R2, R1
	INT STR R5, R1, 0
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, 0
	LDI R13, 1
.LBB0_19:                               ; %for.inc.2
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 28
	ADD R9, R1, R2
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	INT STR R2, R1, 0
	INT LOD R2, R1, 0
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB0_20)
	SLT ADI R15, %lo(.LBB0_20)
	BRH EQ, R15
; %bb.21:                               ; %if.end46.3
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R13, 0
	H LDI R13, 49152
	SLT ADI R13, 0
	INT LOD R5, R4, 0
	ADD R4, R13, R4
	INT STR R2, R4, 0
	LDI R2, 4097
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB0_22)
	SLT ADI R15, %lo(.LBB0_22)
	BRH NC, R15
; %bb.23:                               ; %if.then50.3
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R1, 0
	ADI R1, 4096
	H LDI R15, %hi(.LBB0_24)
	SLT ADI R15, %lo(.LBB0_24)
	JMP R15
.LBB0_26:                               ; %if.then76
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R3, R1, 0
	ADI R1, 1
	INT STR R3, R1, 0
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 16
	INT STR R14, R9, -16
	ADD R9, R1, R13
	INT LOD R14, R9, -8
	INT LOD R9, R1, 0
	INT LOD R13, R2, 0
	LDI R4, 0
	H LDI R4, 65280
	SLT ADI R4, 0
	AND R2, R4, R2
	LDI R4, 255
	AND R1, R4, R6
	LDI R4, 16
	LSH R6, R4, R4
	NOR R2, R4, R2
	NOR R2, R2, R2
	NOR R2, R11, R2
	LDI R4, 8
	LSH R6, R4, R11
	NOR R2, R2, R2
	NOR R2, R11, R2
	NOR R2, R2, R2
	INT STR R13, R2, 0
	INT LOD R9, R2, 0
	ADI R2, 1
	INT STR R9, R2, 0
	SLT ADD R8, R0, R2
	SLT ADD R9, R0, R4
	SLT ADD R5, R0, R12
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	LDI R7, 16
	SLT ADD R12, R0, R5
	INT LOD R13, R1, 0
	LDI R2, 0
	H LDI R2, 65280
	SLT ADI R2, 255
	AND R1, R2, R1
	INT LOD R9, R2, 0
	LSH R2, R7, R2
	LDI R3, 0
	H LDI R3, 255
	SLT ADI R3, 0
	ADD R2, R3, R2
	AND R2, R3, R2
	NOR R1, R2, R1
	NOR R1, R1, R1
	NOR R1, R11, R1
	NOR R1, R1, R1
	INT STR R13, R1, 0
	INT LOD R5, R2, 0
	LDI R1, 0
	H LDI R1, 49152
	SLT ADI R1, 0
	ADD R2, R1, R1
	INT STR R10, R1, 4
	INT LOD R10, R3, 0
	SUB R1, R3, R3
	INT STR R10, R3, 8
	INT LOD R10, R3, 0
	RSH R3, R7, R3
	LDI R4, 0
	H LDI R4, 1
	SLT ADI R4, -16
	AND R3, R4, R3
	INT LOD R10, R6, 0
	SLT ADD R3, R0, R4
	SUB R6, R1, R0
	H LDI R15, %hi(.LBB0_28)
	SLT ADI R15, %lo(.LBB0_28)
	BRH NC, R15
; %bb.27:                               ; %if.then76
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, -1
	ADD R2, R4, R2
	RSH R2, R7, R2
	LDI R4, 0
	H LDI R4, 1
	SLT ADI R4, -16
	AND R2, R4, R4
.LBB0_28:                               ; %if.then76
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 24
	INT LOD R14, R9, -16
	ADD R9, R2, R2
	LSH R4, R7, R4
	NOR R4, R3, R3
	NOR R3, R3, R3
	INT STR R2, R3, 0
	INT LOD R10, R2, 0
	INT LOD R14, R3, -4
	INT LOD R14, R7, -28
	INT LOD R14, R11, -32
	LDI R6, 20
	INT LOD R14, R8, -12
	LDI R12, 0
	LDI R13, 1
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB0_29)
	SLT ADI R15, %lo(.LBB0_29)
	BRH C, R15
	H LDI R15, %hi(.LBB0_30)
	SLT ADI R15, %lo(.LBB0_30)
	JMP R15
.LBB0_20:                               ; %for.inc.2.for.inc.3_crit_edge
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R1, 0
	H LDI R15, %hi(.LBB0_25)
	SLT ADI R15, %lo(.LBB0_25)
	JMP R15
.LBB0_22:                               ; %if.else.3
                                        ;   in Loop: Header=BB0_3 Depth=2
	ADI R1, 4095
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -4096
	AND R1, R2, R1
	INT LOD R5, R2, 0
	ADD R2, R1, R1
.LBB0_24:                               ; %for.inc.3
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT STR R5, R1, 0
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, 0
	LDI R13, 1
.LBB0_25:                               ; %for.inc.3
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R10, R2, 0
	SUB R1, R2, R1
	ADD R1, R4, R1
	INT STR R10, R1, 8
	INT LOD R5, R1, 0
	ADD R1, R4, R1
	INT STR R10, R1, 4
	INT LOD R3, R1, 0
	ADI R1, 1
	INT STR R3, R1, 0
.LBB0_29:                               ; %if.end134.sink.split
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 4
	ADD R9, R1, R1
	INT STR R1, R13, 0
.LBB0_30:                               ; %if.end134
                                        ;   in Loop: Header=BB0_3 Depth=2
	SLT ADD R12, R0, R1
	INT LOD R14, R2, -24
	SUB R2, R12, R0
	H LDI R15, %hi(.LBB0_32)
	SLT ADI R15, %lo(.LBB0_32)
	BRH NN, R15
; %bb.31:                               ; %if.end134
                                        ;   in Loop: Header=BB0_3 Depth=2
	SLT ADD R13, R0, R1
.LBB0_32:                               ; %if.end134
                                        ;   in Loop: Header=BB0_3 Depth=2
	SLT ADD R12, R0, R2
	INT LOD R14, R9, -40
	SUB R9, R12, R0
	H LDI R15, %hi(.LBB0_34)
	SLT ADI R15, %lo(.LBB0_34)
	BRH EQ, R15
; %bb.33:                               ; %if.end134
                                        ;   in Loop: Header=BB0_3 Depth=2
	SLT ADD R13, R0, R2
.LBB0_34:                               ; %if.end134
                                        ;   in Loop: Header=BB0_3 Depth=2
	NOR R2, R1, R1
	NOR R1, R1, R1
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB0_36)
	SLT ADI R15, %lo(.LBB0_36)
	BRH NE, R15
; %bb.35:                               ; %if.end134
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R14, R1, -40
	ADI R1, 4096
	INT STR R14, R1, -40
	INT LOD R14, R9, -36
	SLT ADD R9, R0, R1
	ADI R1, 1
	LDI R2, 7
	SUB R9, R2, R0
	H LDI R15, %hi(.LBB0_3)
	SLT ADI R15, %lo(.LBB0_3)
	BRH C, R15
	H LDI R15, %hi(.LBB0_36)
	SLT ADI R15, %lo(.LBB0_36)
	JMP R15
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

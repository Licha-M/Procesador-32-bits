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
	SLT ADD R3, R0, R9
	INT STR R14, R2, -24
	LDI R2, 255
	INT STR R14, R1, -28
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB0_36)
	SLT ADI R15, %lo(.LBB0_36)
	BRH C, R15
	H LDI R15, %hi(.LBB0_1)
	SLT ADI R15, %lo(.LBB0_1)
	JMP R15
.LBB0_36:                               ; %for.end154
	INT LOD R14, R13, -64
	INT LOD R14, R12, -60
	INT LOD R14, R11, -56
	INT LOD R14, R10, -52
	INT LOD R14, R9, -48
	INT LOD R14, R8, -44
	ADI R14, -68
	RET
.LBB0_1:                                ; %for.cond.preheader
	LDI R1, 20
	INT LOD R14, R2, -28
	LSH R2, R1, R1
	INT STR R14, R1, -32
	LDI R10, 0
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, 0
	LDI R11, 16
	LDI R3, 1
	INT STR R14, R10, -16
	INT STR R14, R9, -4
.LBB0_2:                                ; %for.cond2.preheader
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_3 Depth 2
	INT STR R14, R10, -40
	SLT ADD R10, R0, R1
.LBB0_3:                                ; %for.body5
                                        ;   Parent Loop BB0_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	INT STR R14, R1, -36
	INT LOD R14, R1, -40
	INT LOD R14, R2, -32
	ADD R2, R1, R12
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 0
	ADD R12, R1, R1
	INT LOD R1, R1, 0
	LDI R2, 0
	H LDI R2, 1
	SLT ADI R2, -1
	AND R1, R2, R1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB0_35)
	SLT ADI R15, %lo(.LBB0_35)
	BRH EQ, R15
	H LDI R15, %hi(.LBB0_4)
	SLT ADI R15, %lo(.LBB0_4)
	JMP R15
.LBB0_4:                                ; %if.end12
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R9, R1, 0
	LDI R2, 63
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB0_36)
	SLT ADI R15, %lo(.LBB0_36)
	BRH N, R15
	H LDI R15, %hi(.LBB0_5)
	SLT ADI R15, %lo(.LBB0_5)
	JMP R15
.LBB0_5:                                ; %if.end15
                                        ;   in Loop: Header=BB0_3 Depth=2
	SLT ADD R9, R0, R7
	LDI R2, 19
	MUL R1, R2, R1
	INT LOD R14, R9, -24
	ADD R9, R1, R13
	INT LOD R5, R1, 0
	ADD R1, R4, R1
	LDI R4, 24
	RSH R1, R4, R2
	CHAR STR R13, R2, 3
	RSH R1, R11, R2
	CHAR STR R13, R2, 2
	CHAR STR R13, R1, 0
	LDI R2, 8
	RSH R1, R2, R1
	CHAR STR R13, R1, 1
	INT LOD R14, R6, -28
	CHAR STR R13, R6, 16
	INT LOD R14, R1, -16
	CHAR STR R13, R1, 17
	INT LOD R14, R1, -36
	CHAR STR R13, R1, 18
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 8
	ADD R12, R1, R1
	INT LOD R1, R8, 0
	RSH R8, R11, R1
	CHAR STR R13, R1, 14
	RSH R8, R2, R1
	CHAR STR R13, R1, 13
	RSH R8, R4, R1
	CHAR STR R13, R1, 15
	LDI R2, 127
	AND R1, R2, R1
	INT STR R14, R8, -20
	CHAR STR R13, R8, 12
	SUB R1, R3, R0
	H LDI R15, %hi(.LBB0_25)
	SLT ADI R15, %lo(.LBB0_25)
	BRH EQ, R15
	H LDI R15, %hi(.LBB0_6)
	SLT ADI R15, %lo(.LBB0_6)
	JMP R15
.LBB0_6:                                ; %if.end15
                                        ;   in Loop: Header=BB0_3 Depth=2
	SLT ADD R7, R0, R9
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -1
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, 0
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB0_35)
	SLT ADI R15, %lo(.LBB0_35)
	BRH NE, R15
	H LDI R15, %hi(.LBB0_7)
	SLT ADI R15, %lo(.LBB0_7)
	JMP R15
.LBB0_7:                                ; %for.cond31.preheader
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 16
	ADD R12, R1, R2
	INT STR R2, R7, 0
	INT LOD R2, R1, 0
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB0_11)
	SLT ADI R15, %lo(.LBB0_11)
	BRH EQ, R15
	H LDI R15, %hi(.LBB0_8)
	SLT ADI R15, %lo(.LBB0_8)
	JMP R15
.LBB0_8:                                ; %if.end46
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R3, 0
	ADD R3, R4, R3
	INT STR R2, R3, 0
	LDI R3, 4096
	SLT ADD R3, R0, R2
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB0_9)
	SLT ADI R15, %lo(.LBB0_9)
	BRH C, R15
.LBB0_9:                                ; %if.end46
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
.LBB0_11:                               ; %for.inc
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 20
	ADD R12, R1, R2
	INT STR R2, R7, 0
	INT LOD R2, R1, 0
	INT LOD R14, R6, -28
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB0_15)
	SLT ADI R15, %lo(.LBB0_15)
	BRH EQ, R15
	H LDI R15, %hi(.LBB0_12)
	SLT ADI R15, %lo(.LBB0_12)
	JMP R15
.LBB0_12:                               ; %if.end46.1
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R3, 0
	ADD R3, R4, R3
	INT STR R2, R3, 0
	LDI R3, 4096
	SLT ADD R3, R0, R2
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB0_13)
	SLT ADI R15, %lo(.LBB0_13)
	BRH C, R15
.LBB0_13:                               ; %if.end46.1
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
.LBB0_15:                               ; %for.inc.1
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 24
	ADD R12, R1, R2
	INT STR R2, R7, 0
	INT LOD R2, R1, 0
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB0_19)
	SLT ADI R15, %lo(.LBB0_19)
	BRH EQ, R15
	H LDI R15, %hi(.LBB0_16)
	SLT ADI R15, %lo(.LBB0_16)
	JMP R15
.LBB0_16:                               ; %if.end46.2
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R3, 0
	ADD R3, R4, R3
	INT STR R2, R3, 0
	LDI R3, 4096
	SLT ADD R3, R0, R2
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB0_17)
	SLT ADI R15, %lo(.LBB0_17)
	BRH C, R15
.LBB0_17:                               ; %if.end46.2
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
.LBB0_19:                               ; %for.inc.2
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 28
	ADD R12, R1, R2
	INT STR R2, R7, 0
	INT LOD R2, R1, 0
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB0_21)
	SLT ADI R15, %lo(.LBB0_21)
	BRH NE, R15
	H LDI R15, %hi(.LBB0_20)
	SLT ADI R15, %lo(.LBB0_20)
	JMP R15
.LBB0_21:                               ; %if.end46.3
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R3, 0
	ADD R3, R4, R3
	INT STR R2, R3, 0
	LDI R2, 4097
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB0_23)
	SLT ADI R15, %lo(.LBB0_23)
	BRH C, R15
	H LDI R15, %hi(.LBB0_22)
	SLT ADI R15, %lo(.LBB0_22)
	JMP R15
.LBB0_23:                               ; %if.then50.3
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R5, R1, 0
	ADI R1, 4096
	INT STR R5, R1, 0
.LBB0_24:                               ; %for.inc.3
                                        ;   in Loop: Header=BB0_3 Depth=2
	CHAR LOD R13, R2, 2
	LSH R2, R11, R2
	CHAR LOD R13, R3, 3
	LDI R11, 24
	LSH R3, R11, R3
	NOR R3, R2, R2
	CHAR LOD R13, R3, 1
	LDI R7, 8
	LSH R3, R7, R3
	CHAR LOD R13, R4, 0
	NOR R3, R4, R3
	NOR R2, R2, R2
	NOR R3, R3, R3
	NOR R2, R3, R2
	NOR R2, R2, R2
	SUB R1, R2, R1
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, 0
	ADD R1, R4, R1
	LDI R2, 16
	RSH R1, R2, R2
	CHAR STR R13, R2, 10
	RSH R1, R11, R2
	CHAR STR R13, R2, 11
	CHAR STR R13, R1, 8
	RSH R1, R7, R1
	CHAR STR R13, R1, 9
	INT LOD R5, R1, 0
	ADD R1, R4, R1
	RSH R1, R11, R2
	LDI R11, 16
	CHAR STR R13, R2, 7
	RSH R1, R11, R2
	CHAR STR R13, R2, 6
	CHAR STR R13, R1, 4
	RSH R1, R7, R1
	CHAR STR R13, R1, 5
	INT LOD R9, R1, 0
	ADI R1, 1
	INT STR R9, R1, 0
	LDI R3, 1
	INT LOD R14, R8, -24
	H LDI R15, %hi(.LBB0_28)
	SLT ADI R15, %lo(.LBB0_28)
	JMP R15
.LBB0_25:                               ; %if.then76
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R14, R1, -32
	INT STR R14, R1, -32
	INT LOD R7, R1, 0
	ADI R1, 1
	INT STR R7, R1, 0
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 16
	INT STR R14, R12, -12
	ADD R12, R1, R8
	INT LOD R14, R11, -8
	INT LOD R11, R1, 0
	INT LOD R8, R2, 0
	LDI R3, 0
	H LDI R3, 65280
	SLT ADI R3, 0
	AND R2, R3, R2
	LDI R3, 255
	AND R1, R3, R3
	LDI R4, 16
	LSH R3, R4, R4
	NOR R2, R4, R2
	NOR R2, R2, R2
	NOR R2, R6, R2
	NOR R2, R2, R2
	LDI R4, 8
	LSH R3, R4, R12
	NOR R2, R12, R2
	NOR R2, R2, R2
	INT STR R8, R2, 0
	INT LOD R11, R2, 0
	ADI R2, 1
	INT STR R11, R2, 0
	SLT ADD R9, R0, R2
	SLT ADD R7, R0, R3
	SLT ADD R11, R0, R4
	SLT ADD R5, R0, R10
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	SLT ADD R10, R0, R5
	INT LOD R8, R1, 0
	LDI R2, 0
	H LDI R2, 65280
	SLT ADI R2, 255
	AND R1, R2, R1
	INT LOD R11, R2, 0
	LDI R11, 16
	LSH R2, R11, R2
	LDI R3, 0
	H LDI R3, 255
	SLT ADI R3, 0
	ADD R2, R3, R2
	AND R2, R3, R2
	NOR R1, R2, R1
	NOR R1, R1, R1
	NOR R1, R12, R1
	NOR R1, R1, R1
	INT STR R8, R1, 0
	INT LOD R5, R2, 0
	LDI R1, 0
	H LDI R1, 49152
	SLT ADI R1, 0
	ADD R2, R1, R1
	LDI R8, 24
	RSH R1, R8, R3
	CHAR STR R13, R3, 7
	RSH R1, R11, R3
	CHAR STR R13, R3, 6
	LDI R9, 8
	RSH R1, R9, R3
	CHAR STR R13, R3, 5
	CHAR STR R13, R1, 4
	CHAR LOD R13, R3, 2
	LSH R3, R11, R3
	CHAR LOD R13, R4, 3
	LSH R4, R8, R4
	NOR R4, R3, R3
	CHAR LOD R13, R4, 1
	LSH R4, R9, R4
	CHAR LOD R13, R6, 0
	NOR R4, R6, R4
	NOR R3, R3, R3
	NOR R4, R4, R4
	NOR R3, R4, R3
	NOR R3, R3, R3
	SUB R1, R3, R3
	RSH R3, R8, R4
	CHAR STR R13, R4, 11
	RSH R3, R11, R4
	CHAR STR R13, R4, 10
	CHAR STR R13, R3, 8
	RSH R3, R9, R3
	CHAR STR R13, R3, 9
	CHAR LOD R13, R3, 2
	LSH R3, R11, R3
	CHAR LOD R13, R4, 3
	LSH R4, R8, R4
	NOR R4, R3, R3
	NOR R3, R3, R3
	RSH R3, R11, R3
	LDI R4, 0
	H LDI R4, 1
	SLT ADI R4, -16
	AND R3, R4, R3
	CHAR LOD R13, R4, 1
	CHAR LOD R13, R4, 0
	CHAR LOD R13, R4, 2
	LSH R4, R11, R4
	CHAR LOD R13, R6, 3
	LSH R6, R8, R6
	NOR R6, R4, R4
	CHAR LOD R13, R6, 1
	LSH R6, R9, R7
	CHAR LOD R13, R6, 0
	NOR R7, R6, R6
	NOR R4, R4, R4
	NOR R6, R6, R6
	NOR R4, R6, R4
	NOR R4, R4, R6
	SLT ADD R3, R0, R4
	SLT ADD R8, R0, R7
	SLT ADD R9, R0, R8
	SUB R6, R1, R0
	H LDI R15, %hi(.LBB0_26)
	SLT ADI R15, %lo(.LBB0_26)
	BRH C, R15
.LBB0_26:                               ; %if.then76
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, -1
	ADD R2, R4, R2
	RSH R2, R11, R2
	LDI R4, 0
	H LDI R4, 1
	SLT ADI R4, -16
	AND R2, R4, R4
.LBB0_27:                               ; %if.then76
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 24
	INT LOD R14, R12, -12
	ADD R12, R2, R2
	LSH R4, R11, R4
	NOR R4, R3, R3
	NOR R3, R3, R3
	INT STR R2, R3, 0
	CHAR LOD R13, R2, 2
	LSH R2, R11, R2
	CHAR LOD R13, R3, 3
	LSH R3, R7, R3
	NOR R3, R2, R2
	CHAR LOD R13, R3, 1
	LSH R3, R8, R3
	CHAR LOD R13, R4, 0
	NOR R3, R4, R3
	NOR R2, R2, R2
	NOR R3, R3, R3
	NOR R2, R3, R2
	NOR R2, R2, R2
	INT LOD R14, R9, -4
	INT LOD R14, R8, -24
	INT LOD R14, R6, -28
	INT LOD R14, R3, -32
	LDI R10, 0
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, 0
	LDI R3, 1
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB0_29)
	SLT ADI R15, %lo(.LBB0_29)
	BRH NC, R15
	H LDI R15, %hi(.LBB0_28)
	SLT ADI R15, %lo(.LBB0_28)
	JMP R15
.LBB0_28:                               ; %if.end134.sink.split
                                        ;   in Loop: Header=BB0_3 Depth=2
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 4
	ADD R12, R1, R1
	INT STR R1, R3, 0
.LBB0_29:                               ; %if.end134
                                        ;   in Loop: Header=BB0_3 Depth=2
	SLT ADD R10, R0, R1
	INT LOD R14, R2, -20
	SUB R2, R10, R0
	H LDI R15, %hi(.LBB0_30)
	SLT ADI R15, %lo(.LBB0_30)
	BRH N, R15
.LBB0_30:                               ; %if.end134
                                        ;   in Loop: Header=BB0_3 Depth=2
	SLT ADD R3, R0, R1
.LBB0_31:                               ; %if.end134
                                        ;   in Loop: Header=BB0_3 Depth=2
	SLT ADD R10, R0, R2
	INT LOD R14, R12, -40
	SUB R12, R10, R0
	H LDI R15, %hi(.LBB0_32)
	SLT ADI R15, %lo(.LBB0_32)
	BRH NE, R15
.LBB0_32:                               ; %if.end134
                                        ;   in Loop: Header=BB0_3 Depth=2
	SLT ADD R3, R0, R2
.LBB0_33:                               ; %if.end134
                                        ;   in Loop: Header=BB0_3 Depth=2
	NOR R2, R1, R1
	NOR R1, R1, R1
	SUB R1, R3, R0
	H LDI R15, %hi(.LBB0_35)
	SLT ADI R15, %lo(.LBB0_35)
	BRH NE, R15
	H LDI R15, %hi(.LBB0_34)
	SLT ADI R15, %lo(.LBB0_34)
	JMP R15
.LBB0_34:                               ; %if.end134
                                        ;   in Loop: Header=BB0_3 Depth=2
	INT LOD R14, R1, -40
	ADI R1, 4096
	INT STR R14, R1, -40
	INT LOD R14, R12, -36
	SLT ADD R12, R0, R1
	ADI R1, 1
	LDI R2, 7
	SUB R12, R2, R0
	H LDI R15, %hi(.LBB0_3)
	SLT ADI R15, %lo(.LBB0_3)
	BRH C, R15
	H LDI R15, %hi(.LBB0_35)
	SLT ADI R15, %lo(.LBB0_35)
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
	INT LOD R5, R2, 0
	ADD R2, R1, R1
	INT STR R5, R1, 0
	H LDI R15, %hi(.LBB0_24)
	SLT ADI R15, %lo(.LBB0_24)
	JMP R15
.LBB0_35:                               ; %for.inc150
                                        ;   in Loop: Header=BB0_2 Depth=1
	LDI R1, 0
	H LDI R1, 1
	SLT ADI R1, -32768
	INT LOD R14, R2, -32
	ADD R2, R1, R2
	INT STR R14, R2, -32
	INT LOD R14, R2, -16
	ADI R2, 1
	LDI R1, 32
	INT STR R14, R2, -16
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB0_2)
	SLT ADI R15, %lo(.LBB0_2)
	BRH NE, R15
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
	.ident	"clang version 24.0.0git (https://github.com/Licha-M/llvm-project-ISA32-LM.git e3f583d506af1169c029f963d2b9aac5b2ff0cbb)"
	.section	".note.GNU-stack","",@progbits

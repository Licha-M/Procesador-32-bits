	.file	"llvm-link"
	.text
	.globl	bus_Enumeration                 ; -- Begin function bus_Enumeration
	.type	bus_Enumeration,@function
bus_Enumeration:                        ; @bus_Enumeration
; %bb.0:                                ; %entry
	ADI R14, 120
	INT STR R14, R8, -96
	INT STR R14, R9, -100
	INT STR R14, R10, -104
	INT STR R14, R11, -108
	INT STR R14, R12, -112
	INT STR R14, R13, -116
	ADD R14, R0, R6
	SLT ADD R6, R0, R7
	SLT ADI R7, -92
	INT STR R7, R1, 0
	SLT ADD R6, R0, R1
	SLT ADI R1, -88
	INT STR R1, R2, 0
	SLT ADD R6, R0, R1
	SLT ADI R1, -84
	INT STR R1, R3, 0
	SLT ADD R6, R0, R1
	SLT ADI R1, -80
	INT STR R1, R4, 0
	SLT ADI R6, -76
	INT STR R6, R5, 0
	INT LOD R7, R1, 0
	LDI R2, 256
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB0_2)
	SLT ADI R15, %lo(.LBB0_2)
	BRH C, R15
	H LDI R15, %hi(.LBB0_1)
	SLT ADI R15, %lo(.LBB0_1)
	JMP R15
.LBB0_1:                                ; %if.then
	H LDI R15, %hi(.LBB0_39)
	SLT ADI R15, %lo(.LBB0_39)
	JMP R15
.LBB0_2:                                ; %if.end
	ADD R14, R0, R1
	SLT ADI R1, -72
	LDI R2, 0
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB0_3)
	SLT ADI R15, %lo(.LBB0_3)
	JMP R15
.LBB0_3:                                ; %for.cond
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_5 Depth 2
                                        ;       Child Loop BB0_12 Depth 3
	ADD R14, R0, R1
	SLT ADI R1, -72
	INT LOD R1, R1, 0
	LDI R2, 31
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB0_38)
	SLT ADI R15, %lo(.LBB0_38)
	BRH C, R15
	H LDI R15, %hi(.LBB0_4)
	SLT ADI R15, %lo(.LBB0_4)
	JMP R15
.LBB0_4:                                ; %for.body
                                        ;   in Loop: Header=BB0_3 Depth=1
	ADD R14, R0, R1
	SLT ADI R1, -68
	LDI R2, 0
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB0_5)
	SLT ADI R15, %lo(.LBB0_5)
	JMP R15
.LBB0_5:                                ; %for.cond2
                                        ;   Parent Loop BB0_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_12 Depth 3
	ADD R14, R0, R1
	SLT ADI R1, -68
	INT LOD R1, R1, 0
	LDI R2, 7
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB0_35)
	SLT ADI R15, %lo(.LBB0_35)
	BRH C, R15
	H LDI R15, %hi(.LBB0_6)
	SLT ADI R15, %lo(.LBB0_6)
	JMP R15
.LBB0_6:                                ; %for.body4
                                        ;   in Loop: Header=BB0_5 Depth=2
	ADD R14, R0, R1
	SLT ADD R1, R0, R2
	SLT ADI R2, -92
	INT LOD R2, R2, 0
	LDI R3, 20
	LSH R2, R3, R2
	SLT ADD R1, R0, R3
	SLT ADI R3, -72
	INT LOD R3, R3, 0
	LDI R4, 15
	LSH R3, R4, R3
	NOR R2, R3, R2
	NOR R2, R2, R2
	SLT ADD R1, R0, R3
	SLT ADI R3, -68
	INT LOD R3, R3, 0
	LDI R4, 12
	LSH R3, R4, R3
	NOR R2, R3, R2
	NOR R2, R2, R2
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 0
	ADD R2, R3, R2
	SLT ADD R1, R0, R3
	SLT ADI R3, -64
	INT STR R3, R2, 0
	INT LOD R3, R2, 0
	INT LOD R2, R2, 0
	SLT ADI R1, -60
	INT STR R1, R2, 0
	SHORT LOD R1, R1, 0
	LDI R2, 0
	H LDI R2, 1
	SLT ADI R2, -1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB0_8)
	SLT ADI R15, %lo(.LBB0_8)
	BRH NE, R15
	H LDI R15, %hi(.LBB0_7)
	SLT ADI R15, %lo(.LBB0_7)
	JMP R15
.LBB0_7:                                ; %if.then10
                                        ;   in Loop: Header=BB0_3 Depth=1
	H LDI R15, %hi(.LBB0_36)
	SLT ADI R15, %lo(.LBB0_36)
	JMP R15
.LBB0_8:                                ; %if.end11
                                        ;   in Loop: Header=BB0_5 Depth=2
	ADD R14, R0, R1
	SLT ADI R1, -84
	INT LOD R1, R1, 0
	INT LOD R1, R1, 0
	LDI R2, 64
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB0_10)
	SLT ADI R15, %lo(.LBB0_10)
	BRH N, R15
	H LDI R15, %hi(.LBB0_9)
	SLT ADI R15, %lo(.LBB0_9)
	JMP R15
.LBB0_9:                                ; %if.then13
	H LDI R15, %hi(.LBB0_39)
	SLT ADI R15, %lo(.LBB0_39)
	JMP R15
.LBB0_10:                               ; %if.end14
                                        ;   in Loop: Header=BB0_5 Depth=2
	ADD R14, R0, R1
	SLT ADD R1, R0, R2
	SLT ADI R2, -84
	INT LOD R2, R2, 0
	INT LOD R2, R3, 0
	SLT ADD R1, R0, R2
	SLT ADI R2, -56
	INT STR R2, R3, 0
	SLT ADD R1, R0, R3
	SLT ADI R3, -76
	INT LOD R3, R3, 0
	INT LOD R3, R3, 0
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, 0
	ADD R3, R4, R8
	SLT ADD R1, R0, R3
	SLT ADI R3, -88
	INT LOD R3, R5, 0
	INT LOD R2, R6, 0
	LDI R4, 19
	MUL R6, R4, R6
	ADD R5, R6, R9
	LDI R5, 24
	RSH R8, R5, R6
	CHAR STR R9, R6, 3
	LDI R6, 16
	RSH R8, R6, R7
	CHAR STR R9, R7, 2
	CHAR STR R9, R8, 0
	LDI R7, 8
	RSH R8, R7, R8
	CHAR STR R9, R8, 1
	SLT ADD R1, R0, R8
	SLT ADI R8, -92
	INT LOD R8, R8, 0
	INT LOD R3, R9, 0
	INT LOD R2, R10, 0
	MUL R10, R4, R10
	ADD R9, R10, R9
	CHAR STR R9, R8, 16
	SLT ADD R1, R0, R8
	SLT ADI R8, -72
	INT LOD R8, R8, 0
	INT LOD R3, R9, 0
	INT LOD R2, R10, 0
	MUL R10, R4, R10
	ADD R9, R10, R9
	CHAR STR R9, R8, 17
	SLT ADD R1, R0, R8
	SLT ADI R8, -68
	INT LOD R8, R8, 0
	INT LOD R3, R9, 0
	INT LOD R2, R10, 0
	MUL R10, R4, R10
	ADD R9, R10, R9
	CHAR STR R9, R8, 18
	SLT ADD R1, R0, R8
	SLT ADI R8, -64
	INT LOD R8, R8, 0
	INT LOD R8, R8, 8
	SLT ADD R1, R0, R9
	SLT ADI R9, -52
	INT STR R9, R8, 0
	INT LOD R9, R8, 0
	INT LOD R3, R3, 0
	INT LOD R2, R2, 0
	MUL R2, R4, R2
	ADD R3, R2, R2
	RSH R8, R5, R3
	CHAR STR R2, R3, 15
	RSH R8, R6, R3
	CHAR STR R2, R3, 14
	RSH R8, R7, R3
	CHAR STR R2, R3, 13
	CHAR STR R2, R8, 12
	LDI R2, 3
	NOR R9, R2, R2
	NOR R2, R2, R2
	CHAR LOD R2, R2, 0
	LDI R3, 127
	AND R2, R3, R2
	SLT ADI R1, -48
	INT STR R1, R2, 0
	INT LOD R1, R1, 0
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB0_21)
	SLT ADI R15, %lo(.LBB0_21)
	BRH NE, R15
	H LDI R15, %hi(.LBB0_11)
	SLT ADI R15, %lo(.LBB0_11)
	JMP R15
.LBB0_11:                               ; %if.then29
                                        ;   in Loop: Header=BB0_5 Depth=2
	ADD R14, R0, R1
	SLT ADD R1, R0, R2
	SLT ADI R2, -44
	LDI R3, 0
	INT STR R2, R3, 12
	INT STR R2, R3, 8
	INT STR R2, R3, 4
	INT STR R2, R3, 0
	SLT ADI R1, -28
	INT STR R1, R3, 0
	H LDI R15, %hi(.LBB0_12)
	SLT ADI R15, %lo(.LBB0_12)
	JMP R15
.LBB0_12:                               ; %for.cond30
                                        ;   Parent Loop BB0_3 Depth=1
                                        ;     Parent Loop BB0_5 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ADD R14, R0, R1
	SLT ADI R1, -28
	INT LOD R1, R1, 0
	LDI R2, 3
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB0_20)
	SLT ADI R15, %lo(.LBB0_20)
	BRH N, R15
	H LDI R15, %hi(.LBB0_13)
	SLT ADI R15, %lo(.LBB0_13)
	JMP R15
.LBB0_13:                               ; %for.body33
                                        ;   in Loop: Header=BB0_12 Depth=3
	ADD R14, R0, R1
	SLT ADD R1, R0, R2
	SLT ADI R2, -64
	INT LOD R2, R3, 0
	SLT ADD R1, R0, R4
	SLT ADI R4, -28
	INT LOD R4, R5, 0
	LDI R6, 2
	LSH R5, R6, R5
	ADD R5, R3, R3
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -1
	INT STR R3, R5, 16
	INT LOD R2, R2, 0
	INT LOD R4, R3, 0
	LSH R3, R6, R3
	ADD R3, R2, R2
	INT LOD R2, R2, 16
	INT LOD R4, R3, 0
	LSH R3, R6, R3
	SLT ADI R1, -44
	ADD R1, R3, R3
	INT STR R3, R2, 0
	INT LOD R4, R2, 0
	LSH R2, R6, R2
	ADD R1, R2, R1
	INT LOD R1, R1, 0
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB0_15)
	SLT ADI R15, %lo(.LBB0_15)
	BRH NE, R15
	H LDI R15, %hi(.LBB0_14)
	SLT ADI R15, %lo(.LBB0_14)
	JMP R15
.LBB0_14:                               ; %if.then43
                                        ;   in Loop: Header=BB0_12 Depth=3
	H LDI R15, %hi(.LBB0_19)
	SLT ADI R15, %lo(.LBB0_19)
	JMP R15
.LBB0_15:                               ; %if.end44
                                        ;   in Loop: Header=BB0_12 Depth=3
	ADD R14, R0, R1
	SLT ADD R1, R0, R2
	SLT ADI R2, -28
	INT LOD R2, R2, 0
	LDI R3, 2
	LSH R2, R3, R2
	SLT ADI R1, -44
	ADD R1, R2, R1
	INT LOD R1, R1, 0
	LDI R2, 4096
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB0_17)
	SLT ADI R15, %lo(.LBB0_17)
	BRH C, R15
	H LDI R15, %hi(.LBB0_16)
	SLT ADI R15, %lo(.LBB0_16)
	JMP R15
.LBB0_16:                               ; %if.then48
                                        ;   in Loop: Header=BB0_12 Depth=3
	ADD R14, R0, R1
	SLT ADD R1, R0, R2
	SLT ADI R2, -76
	INT LOD R2, R3, 0
	INT LOD R3, R3, 0
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, 0
	ADD R3, R4, R3
	SLT ADD R1, R0, R4
	SLT ADI R4, -64
	INT LOD R4, R4, 0
	SLT ADI R1, -28
	INT LOD R1, R1, 0
	LDI R5, 2
	LSH R1, R5, R1
	ADD R1, R4, R1
	INT STR R1, R3, 16
	INT LOD R2, R1, 0
	INT LOD R1, R2, 0
	ADI R2, 4096
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB0_18)
	SLT ADI R15, %lo(.LBB0_18)
	JMP R15
.LBB0_17:                               ; %if.else
                                        ;   in Loop: Header=BB0_12 Depth=3
	ADD R14, R0, R1
	SLT ADD R1, R0, R2
	SLT ADI R2, -76
	INT LOD R2, R3, 0
	INT LOD R3, R3, 0
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, 0
	ADD R3, R4, R3
	SLT ADD R1, R0, R4
	SLT ADI R4, -64
	INT LOD R4, R4, 0
	SLT ADD R1, R0, R5
	SLT ADI R5, -28
	INT LOD R5, R6, 0
	LDI R7, 2
	LSH R6, R7, R6
	ADD R6, R4, R4
	INT STR R4, R3, 16
	INT LOD R5, R3, 0
	LSH R3, R7, R3
	SLT ADI R1, -44
	ADD R1, R3, R1
	INT LOD R1, R1, 0
	ADI R1, 4095
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -4096
	AND R1, R3, R1
	INT LOD R2, R2, 0
	INT LOD R2, R3, 0
	ADD R3, R1, R1
	INT STR R2, R1, 0
	H LDI R15, %hi(.LBB0_18)
	SLT ADI R15, %lo(.LBB0_18)
	JMP R15
.LBB0_18:                               ; %if.end62
                                        ;   in Loop: Header=BB0_12 Depth=3
	H LDI R15, %hi(.LBB0_19)
	SLT ADI R15, %lo(.LBB0_19)
	JMP R15
.LBB0_19:                               ; %for.inc
                                        ;   in Loop: Header=BB0_12 Depth=3
	ADD R14, R0, R1
	SLT ADI R1, -28
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB0_12)
	SLT ADI R15, %lo(.LBB0_12)
	JMP R15
.LBB0_20:                               ; %for.end
                                        ;   in Loop: Header=BB0_5 Depth=2
	ADD R14, R0, R1
	SLT ADD R1, R0, R2
	SLT ADI R2, -76
	INT LOD R2, R3, 0
	INT LOD R3, R9, 0
	SLT ADD R1, R0, R3
	SLT ADI R3, -88
	INT LOD R3, R4, 0
	SLT ADD R1, R0, R5
	SLT ADI R5, -56
	INT LOD R5, R7, 0
	LDI R6, 19
	MUL R7, R6, R7
	ADD R4, R7, R8
	CHAR LOD R8, R7, 1
	LDI R4, 8
	LSH R7, R4, R7
	CHAR LOD R8, R10, 0
	NOR R7, R10, R7
	NOR R7, R7, R10
	CHAR LOD R8, R11, 2
	LDI R7, 16
	LSH R11, R7, R11
	CHAR LOD R8, R12, 3
	LDI R8, 24
	LSH R12, R8, R12
	NOR R12, R11, R11
	NOR R11, R11, R11
	NOR R11, R10, R10
	NOR R10, R10, R10
	SUB R9, R10, R9
	LDI R10, 0
	H LDI R10, 49152
	SLT ADI R10, 0
	ADD R9, R10, R9
	INT LOD R3, R11, 0
	INT LOD R5, R12, 0
	MUL R12, R6, R12
	ADD R11, R12, R11
	RSH R9, R8, R12
	CHAR STR R11, R12, 11
	RSH R9, R7, R12
	CHAR STR R11, R12, 10
	CHAR STR R11, R9, 8
	RSH R9, R4, R9
	CHAR STR R11, R9, 9
	INT LOD R2, R2, 0
	INT LOD R2, R2, 0
	ADD R2, R10, R2
	INT LOD R3, R3, 0
	INT LOD R5, R5, 0
	MUL R5, R6, R5
	ADD R3, R5, R3
	RSH R2, R8, R5
	CHAR STR R3, R5, 7
	RSH R2, R7, R5
	CHAR STR R3, R5, 6
	CHAR STR R3, R2, 4
	RSH R2, R4, R2
	CHAR STR R3, R2, 5
	SLT ADD R1, R0, R2
	SLT ADI R2, -84
	INT LOD R2, R2, 0
	INT LOD R2, R3, 0
	ADI R3, 1
	INT STR R2, R3, 0
	SLT ADI R1, -64
	INT LOD R1, R1, 0
	LDI R2, 1
	INT STR R1, R2, 4
	H LDI R15, %hi(.LBB0_30)
	SLT ADI R15, %lo(.LBB0_30)
	JMP R15
.LBB0_21:                               ; %if.else71
                                        ;   in Loop: Header=BB0_5 Depth=2
	ADD R14, R0, R1
	SLT ADI R1, -48
	INT LOD R1, R1, 0
	LDI R2, 1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB0_28)
	SLT ADI R15, %lo(.LBB0_28)
	BRH NE, R15
	H LDI R15, %hi(.LBB0_22)
	SLT ADI R15, %lo(.LBB0_22)
	JMP R15
.LBB0_22:                               ; %if.then74
                                        ;   in Loop: Header=BB0_5 Depth=2
	ADD R14, R0, R11
	SLT ADD R11, R0, R3
	SLT ADI R3, -84
	INT LOD R3, R1, 0
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	SLT ADD R11, R0, R13
	SLT ADI R13, -80
	INT LOD R13, R1, 0
	INT LOD R1, R1, 0
	SLT ADD R11, R0, R9
	SLT ADI R9, -24
	INT STR R9, R1, 0
	SLT ADD R11, R0, R2
	SLT ADI R2, -64
	INT LOD R2, R1, 0
	SLT ADD R2, R0, R4
	INT STR R14, R4, -4
	INT LOD R1, R1, 16
	SLT ADD R11, R0, R8
	SLT ADI R8, -20
	INT STR R8, R1, 0
	LDI R1, 3
	NOR R8, R1, R1
	NOR R1, R1, R1
	CHAR LOD R1, R1, 0
	LDI R2, 24
	LSH R1, R2, R1
	INT STR R8, R1, 0
	SLT ADD R11, R0, R1
	SLT ADI R1, -92
	CHAR LOD R1, R1, 0
	INT LOD R8, R2, 0
	NOR R2, R1, R1
	NOR R1, R1, R1
	INT STR R8, R1, 0
	CHAR LOD R9, R1, 0
	LDI R2, 8
	LSH R1, R2, R1
	INT LOD R8, R2, 0
	NOR R2, R1, R1
	NOR R1, R1, R1
	INT STR R8, R1, 0
	CHAR LOD R9, R1, 0
	LDI R2, 16
	LSH R1, R2, R1
	INT LOD R8, R2, 0
	NOR R2, R1, R1
	NOR R1, R1, R1
	INT STR R8, R1, 0
	INT LOD R8, R1, 0
	INT LOD R4, R2, 0
	INT STR R2, R1, 16
	INT LOD R13, R1, 0
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	INT LOD R9, R1, 0
	SLT ADD R11, R0, R12
	SLT ADI R12, -88
	INT LOD R12, R2, 0
	INT LOD R3, R3, 0
	INT LOD R13, R4, 0
	SLT ADD R11, R0, R10
	SLT ADI R10, -76
	INT LOD R10, R5, 0
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	INT LOD R14, R3, -4
	INT LOD R3, R1, 0
	INT LOD R1, R1, 16
	INT STR R8, R1, 0
	INT LOD R8, R1, 0
	LDI R2, 0
	H LDI R2, 65280
	SLT ADI R2, 255
	AND R1, R2, R1
	INT STR R8, R1, 0
	CHAR LOD R9, R1, 0
	LDI R9, 8
	LSH R1, R9, R1
	INT LOD R8, R2, 0
	NOR R2, R1, R1
	NOR R1, R1, R1
	INT STR R8, R1, 0
	INT LOD R13, R1, 0
	INT LOD R1, R1, 0
	ADI R1, -1
	LDI R2, 255
	AND R1, R2, R1
	LDI R7, 16
	LSH R1, R7, R1
	INT LOD R8, R2, 0
	NOR R2, R1, R1
	NOR R1, R1, R1
	INT STR R8, R1, 0
	INT LOD R8, R1, 0
	INT LOD R3, R2, 0
	INT STR R2, R1, 16
	INT LOD R10, R1, 0
	INT LOD R1, R1, 0
	LDI R2, 0
	H LDI R2, 49152
	SLT ADI R2, 0
	ADD R1, R2, R2
	SLT ADD R11, R0, R1
	SLT ADI R1, -16
	INT STR R1, R2, 0
	INT LOD R1, R4, 0
	INT LOD R12, R5, 0
	SLT ADD R11, R0, R2
	SLT ADI R2, -56
	INT LOD R2, R6, 0
	LDI R3, 19
	MUL R6, R3, R6
	ADD R5, R6, R5
	LDI R8, 24
	RSH R4, R8, R6
	CHAR STR R5, R6, 7
	SLT ADD R7, R0, R10
	RSH R4, R10, R6
	CHAR STR R5, R6, 6
	RSH R4, R9, R6
	CHAR STR R5, R6, 5
	CHAR STR R5, R4, 4
	INT LOD R1, R4, 0
	INT LOD R12, R5, 0
	INT LOD R2, R6, 0
	MUL R6, R3, R6
	ADD R5, R6, R5
	CHAR LOD R5, R6, 1
	LSH R6, R9, R6
	CHAR LOD R5, R7, 0
	NOR R6, R7, R6
	NOR R6, R6, R6
	CHAR LOD R5, R7, 2
	LSH R7, R10, R7
	CHAR LOD R5, R5, 3
	LSH R5, R8, R5
	NOR R5, R7, R5
	NOR R5, R5, R5
	NOR R5, R6, R5
	NOR R5, R5, R5
	SUB R4, R5, R4
	INT LOD R12, R5, 0
	INT LOD R2, R6, 0
	MUL R6, R3, R6
	ADD R5, R6, R5
	RSH R4, R8, R6
	SLT ADD R8, R0, R7
	CHAR STR R5, R6, 11
	RSH R4, R10, R6
	CHAR STR R5, R6, 10
	CHAR STR R5, R4, 8
	RSH R4, R9, R4
	CHAR STR R5, R4, 9
	INT LOD R12, R4, 0
	INT LOD R2, R5, 0
	MUL R5, R3, R5
	ADD R4, R5, R4
	CHAR LOD R4, R5, 1
	CHAR LOD R4, R5, 0
	CHAR LOD R4, R5, 2
	SLT ADD R10, R0, R6
	LSH R5, R6, R5
	CHAR LOD R4, R4, 3
	LSH R4, R7, R4
	NOR R4, R5, R4
	NOR R4, R4, R4
	RSH R4, R6, R4
	LDI R5, 0
	H LDI R5, 1
	SLT ADI R5, -16
	AND R4, R5, R4
	SLT ADI R11, -12
	INT STR R11, R4, 0
	INT LOD R1, R1, 0
	INT LOD R12, R4, 0
	INT LOD R2, R2, 0
	MUL R2, R3, R2
	ADD R4, R2, R2
	CHAR LOD R2, R3, 1
	LSH R3, R9, R3
	CHAR LOD R2, R4, 0
	NOR R3, R4, R3
	NOR R3, R3, R3
	CHAR LOD R2, R4, 2
	LSH R4, R6, R4
	CHAR LOD R2, R2, 3
	LSH R2, R7, R2
	NOR R2, R4, R2
	NOR R2, R2, R2
	NOR R2, R3, R2
	NOR R2, R2, R2
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB0_24)
	SLT ADI R15, %lo(.LBB0_24)
	BRH NC, R15
	H LDI R15, %hi(.LBB0_23)
	SLT ADI R15, %lo(.LBB0_23)
	JMP R15
.LBB0_23:                               ; %cond.true
                                        ;   in Loop: Header=BB0_5 Depth=2
	ADD R14, R0, R1
	SLT ADI R1, -16
	INT LOD R1, R1, 0
	ADI R1, -1
	LDI R2, 16
	RSH R1, R2, R1
	LDI R2, 0
	H LDI R2, 1
	SLT ADI R2, -16
	AND R1, R2, R1
	H LDI R15, %hi(.LBB0_25)
	SLT ADI R15, %lo(.LBB0_25)
	JMP R15
.LBB0_24:                               ; %cond.false
                                        ;   in Loop: Header=BB0_5 Depth=2
	ADD R14, R0, R1
	SLT ADI R1, -12
	INT LOD R1, R1, 0
	H LDI R15, %hi(.LBB0_25)
	SLT ADI R15, %lo(.LBB0_25)
	JMP R15
.LBB0_25:                               ; %cond.end
                                        ;   in Loop: Header=BB0_5 Depth=2
	ADD R14, R0, R2
	SLT ADD R2, R0, R3
	SLT ADI R3, -8
	INT STR R3, R1, 0
	SLT ADD R2, R0, R1
	SLT ADI R1, -12
	SHORT LOD R1, R4, 0
	INT LOD R3, R3, 0
	LDI R1, 16
	LSH R3, R1, R3
	NOR R4, R3, R3
	NOR R3, R3, R3
	SLT ADD R2, R0, R4
	SLT ADI R4, -64
	INT LOD R4, R4, 0
	INT STR R4, R3, 24
	SLT ADD R2, R0, R3
	SLT ADI R3, -16
	INT LOD R3, R3, 0
	SLT ADD R2, R0, R4
	SLT ADI R4, -88
	INT LOD R4, R4, 0
	SLT ADI R2, -56
	INT LOD R2, R2, 0
	LDI R5, 19
	MUL R2, R5, R2
	ADD R4, R2, R2
	CHAR LOD R2, R4, 1
	LDI R5, 8
	LSH R4, R5, R4
	CHAR LOD R2, R5, 0
	NOR R4, R5, R4
	NOR R4, R4, R4
	CHAR LOD R2, R5, 2
	LSH R5, R1, R1
	CHAR LOD R2, R2, 3
	LDI R5, 24
	LSH R2, R5, R2
	NOR R2, R1, R1
	NOR R1, R1, R1
	NOR R1, R4, R1
	NOR R1, R1, R1
	SUB R1, R3, R0
	H LDI R15, %hi(.LBB0_27)
	SLT ADI R15, %lo(.LBB0_27)
	BRH NC, R15
	H LDI R15, %hi(.LBB0_26)
	SLT ADI R15, %lo(.LBB0_26)
	JMP R15
.LBB0_26:                               ; %if.then127
                                        ;   in Loop: Header=BB0_5 Depth=2
	ADD R14, R0, R1
	SLT ADI R1, -64
	INT LOD R1, R1, 0
	LDI R2, 1
	INT STR R1, R2, 4
	H LDI R15, %hi(.LBB0_27)
	SLT ADI R15, %lo(.LBB0_27)
	JMP R15
.LBB0_27:                               ; %if.end129
                                        ;   in Loop: Header=BB0_5 Depth=2
	H LDI R15, %hi(.LBB0_29)
	SLT ADI R15, %lo(.LBB0_29)
	JMP R15
.LBB0_28:                               ; %if.else130
                                        ;   in Loop: Header=BB0_3 Depth=1
	H LDI R15, %hi(.LBB0_36)
	SLT ADI R15, %lo(.LBB0_36)
	JMP R15
.LBB0_29:                               ; %if.end131
                                        ;   in Loop: Header=BB0_5 Depth=2
	H LDI R15, %hi(.LBB0_30)
	SLT ADI R15, %lo(.LBB0_30)
	JMP R15
.LBB0_30:                               ; %if.end132
                                        ;   in Loop: Header=BB0_5 Depth=2
	ADD R14, R0, R1
	SLT ADI R1, -68
	INT LOD R1, R1, 0
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB0_33)
	SLT ADI R15, %lo(.LBB0_33)
	BRH NE, R15
	H LDI R15, %hi(.LBB0_31)
	SLT ADI R15, %lo(.LBB0_31)
	JMP R15
.LBB0_31:                               ; %land.lhs.true
                                        ;   in Loop: Header=BB0_5 Depth=2
	ADD R14, R0, R1
	SLT ADI R1, -52
	LDI R2, 3
	NOR R1, R2, R1
	NOR R1, R1, R1
	CHAR LOD R1, R1, 0
	LDI R2, 128
	AND R1, R2, R1
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB0_33)
	SLT ADI R15, %lo(.LBB0_33)
	BRH NE, R15
	H LDI R15, %hi(.LBB0_32)
	SLT ADI R15, %lo(.LBB0_32)
	JMP R15
.LBB0_32:                               ; %if.then137
                                        ;   in Loop: Header=BB0_3 Depth=1
	H LDI R15, %hi(.LBB0_36)
	SLT ADI R15, %lo(.LBB0_36)
	JMP R15
.LBB0_33:                               ; %if.end138
                                        ;   in Loop: Header=BB0_5 Depth=2
	H LDI R15, %hi(.LBB0_34)
	SLT ADI R15, %lo(.LBB0_34)
	JMP R15
.LBB0_34:                               ; %for.inc139
                                        ;   in Loop: Header=BB0_5 Depth=2
	ADD R14, R0, R1
	SLT ADI R1, -68
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB0_5)
	SLT ADI R15, %lo(.LBB0_5)
	JMP R15
.LBB0_35:                               ; %for.end141.loopexit
                                        ;   in Loop: Header=BB0_3 Depth=1
	H LDI R15, %hi(.LBB0_36)
	SLT ADI R15, %lo(.LBB0_36)
	JMP R15
.LBB0_36:                               ; %for.end141
                                        ;   in Loop: Header=BB0_3 Depth=1
	H LDI R15, %hi(.LBB0_37)
	SLT ADI R15, %lo(.LBB0_37)
	JMP R15
.LBB0_37:                               ; %for.inc142
                                        ;   in Loop: Header=BB0_3 Depth=1
	ADD R14, R0, R1
	SLT ADI R1, -72
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB0_3)
	SLT ADI R15, %lo(.LBB0_3)
	JMP R15
.LBB0_38:                               ; %for.end144.loopexit
	H LDI R15, %hi(.LBB0_39)
	SLT ADI R15, %lo(.LBB0_39)
	JMP R15
.LBB0_39:                               ; %for.end144
	INT LOD R14, R13, -116
	INT LOD R14, R12, -112
	INT LOD R14, R11, -108
	INT LOD R14, R10, -104
	INT LOD R14, R9, -100
	INT LOD R14, R8, -96
	ADI R14, -120
	RET
.Lfunc_end0:
	.size	bus_Enumeration, .Lfunc_end0-bus_Enumeration
                                        ; -- End function
	.globl	PCIe_Bus_Enumeration            ; -- Begin function PCIe_Bus_Enumeration
	.type	PCIe_Bus_Enumeration,@function
PCIe_Bus_Enumeration:                   ; @PCIe_Bus_Enumeration
; %bb.0:                                ; %entry
	ADI R14, 28
	INT STR R14, R8, -24
	ADD R14, R0, R5
	SLT ADD R5, R0, R2
	SLT ADI R2, -20
	LDI R1, 0
	H LDI R1, 2048
	SLT ADI R1, 0
	INT STR R2, R1, 0
	SLT ADD R5, R0, R1
	SLT ADI R1, -16
	LDI R3, 0
	INT STR R1, R3, 0
	SLT ADD R5, R0, R4
	SLT ADI R4, -12
	LDI R6, 1
	INT STR R4, R6, 0
	SLT ADD R5, R0, R8
	SLT ADI R8, -8
	INT STR R8, R3, 0
	SLT ADI R5, -4
	INT STR R5, R3, 0
	INT LOD R1, R1, 0
	INT LOD R2, R2, 0
	SLT ADD R8, R0, R3
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	INT LOD R8, R1, 0
	INT LOD R14, R8, -24
	ADI R14, -28
	RET
.Lfunc_end1:
	.size	PCIe_Bus_Enumeration, .Lfunc_end1-PCIe_Bus_Enumeration
                                        ; -- End function
	.globl	main                            ; -- Begin function main
	.type	main,@function
main:                                   ; @main
; %bb.0:                                ; %entry
	ADI R14, 28
	INT STR R14, R8, -20
	INT STR R14, R9, -24
	ADD R14, R0, R8
	SLT ADD R8, R0, R1
	SLT ADI R1, -16
	LDI R9, 0
	INT STR R1, R9, 0
	H LDI R15, %hi(PCIe_Bus_Enumeration)
	SLT ADI R15, %lo(PCIe_Bus_Enumeration)
	CAL R15
	SLT ADD R8, R0, R2
	SLT ADI R2, -12
	INT STR R2, R1, 0
	;APP
	HLT
	;NO_APP
	SLT ADD R8, R0, R1
	SLT ADI R1, -8
	LDI R2, 0
	H LDI R2, 2048
	SLT ADI R2, 0
	INT STR R1, R2, 0
	SLT ADI R8, -4
	INT STR R8, R9, 0
	H LDI R15, %hi(.LBB2_1)
	SLT ADI R15, %lo(.LBB2_1)
	JMP R15
.LBB2_1:                                ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	ADD R14, R0, R1
	SLT ADD R1, R0, R2
	SLT ADI R2, -4
	INT LOD R2, R2, 0
	SLT ADI R1, -12
	INT LOD R1, R1, 0
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB2_4)
	SLT ADI R15, %lo(.LBB2_4)
	BRH NN, R15
	H LDI R15, %hi(.LBB2_2)
	SLT ADI R15, %lo(.LBB2_2)
	JMP R15
.LBB2_2:                                ; %for.body
                                        ;   in Loop: Header=BB2_1 Depth=1
	H LDI R15, %hi(.LBB2_3)
	SLT ADI R15, %lo(.LBB2_3)
	JMP R15
.LBB2_3:                                ; %for.inc
                                        ;   in Loop: Header=BB2_1 Depth=1
	ADD R14, R0, R1
	SLT ADI R1, -4
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB2_1)
	SLT ADI R15, %lo(.LBB2_1)
	JMP R15
.LBB2_4:                                ; %for.end
	ADD R14, R0, R1
	SLT ADI R1, -16
	INT LOD R1, R1, 0
	INT LOD R14, R9, -24
	INT LOD R14, R8, -20
	ADI R14, -28
	RET
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        ; -- End function
	.ident	"clang version 24.0.0git (https://github.com/Licha-M/llvm-project-ISA32-LM.git da82c3068c0650642f073b6f1f0b5ce643fe0e50)"
	.section	".note.GNU-stack","",@progbits

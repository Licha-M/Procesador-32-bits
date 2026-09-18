	.file	"llvm-link"
	.text
	.globl	initTty                         ; -- Begin function initTty
	.type	initTty,@function
initTty:                                ; @initTty
; %bb.0:                                ; %entry
	ADI R14, 4
	LDI R2, 3
	INT STR R1, R2, 4
	INT LOD R1, R1, 16
	LDI R2, 0
	H LDI R2, current_display+4
	SLT ADI R2, current_display+4
	INT STR R2, R1, 0
	ADI R14, -4
	RET
.Lfunc_end0:
	.size	initTty, .Lfunc_end0-initTty
                                        ; -- End function
	.globl	ttyWrite                        ; -- Begin function ttyWrite
	.type	ttyWrite,@function
ttyWrite:                               ; @ttyWrite
; %bb.0:                                ; %entry
	ADI R14, 4
	LDI R4, 0
	H LDI R4, current_display+4
	SLT ADI R4, current_display+4
	INT LOD R4, R4, 0
	LDI R5, 0
	H LDI R5, current_display+8
	SLT ADI R5, current_display+8
	INT LOD R5, R5, 0
	INT LOD R5, R5, 4
	LDI R6, 0
	H LDI R6, 1
	SLT ADI R6, -1
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB1_8)
	SLT ADI R15, %lo(.LBB1_8)
	BRH C, R15
; %bb.1:                                ; %if.then
	LDI R5, 0
	INT STR R4, R5, 12
	INT STR R4, R5, 8
	INT STR R4, R5, 4
	SLT ADD R2, R0, R5
	ADI R5, -1
	LDI R6, 3
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB1_6)
	SLT ADI R15, %lo(.LBB1_6)
	BRH C, R15
; %bb.2:                                ; %if.then
	LDI R6, 2
	LSH R5, R6, R5
	LDI R6, 0
	H LDI R6, .LJTI1_0
	SLT ADI R6, .LJTI1_0
	ADD R6, R5, R5
	INT LOD R5, R5, 0
	JMP R5
.LBB1_3:                                ; %sw.bb
	INT STR R4, R3, 12
	CHAR LOD R1, R1, 0
	INT STR R4, R1, 4
	LDI R2, 1
	H LDI R15, %hi(.LBB1_7)
	SLT ADI R15, %lo(.LBB1_7)
	JMP R15
.LBB1_4:                                ; %sw.bb4
	INT STR R4, R3, 12
	LDI R2, 2
	H LDI R15, %hi(.LBB1_7)
	SLT ADI R15, %lo(.LBB1_7)
	JMP R15
.LBB1_5:                                ; %sw.bb9
	INT STR R4, R3, 8
	INT STR R4, R1, 4
	LDI R2, 4
	H LDI R15, %hi(.LBB1_7)
	SLT ADI R15, %lo(.LBB1_7)
	JMP R15
.LBB1_6:                                ; %sw.default
	LDI R2, 0
.LBB1_7:                                ; %cleanup.sink.split
	INT STR R4, R2, 0
.LBB1_8:                                ; %cleanup
	ADI R14, -4
	RET
.Lfunc_end1:
	.size	ttyWrite, .Lfunc_end1-ttyWrite
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
	.type	.LJTI1_0,@object
.LJTI1_0:
	.long	.LBB1_3
	.long	.LBB1_4
	.long	.LBB1_7
	.long	.LBB1_5
	.size	.LJTI1_0, 16
                                        ; -- End function
	.text
	.globl	initGpu                         ; -- Begin function initGpu
	.type	initGpu,@function
initGpu:                                ; @initGpu
; %bb.0:                                ; %entry
	ADI R14, 4
	LDI R2, 0
	INT STR R1, R2, 4
	ADI R14, -4
	RET
.Lfunc_end2:
	.size	initGpu, .Lfunc_end2-initGpu
                                        ; -- End function
	.globl	gpuWrite                        ; -- Begin function gpuWrite
	.type	gpuWrite,@function
gpuWrite:                               ; @gpuWrite
; %bb.0:                                ; %entry
	ADI R14, 4
	ADI R14, -4
	RET
.Lfunc_end3:
	.size	gpuWrite, .Lfunc_end3-gpuWrite
                                        ; -- End function
	.globl	displaySearch                   ; -- Begin function displaySearch
	.type	displaySearch,@function
displaySearch:                          ; @displaySearch
; %bb.0:                                ; %entry
	ADI R14, 4
	LDI R1, 0
	H LDI R1, 7
	SLT ADI R1, 0
	H LDI R15, %hi(search)
	SLT ADI R15, %lo(search)
	CAL R15
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB4_2)
	SLT ADI R15, %lo(.LBB4_2)
	BRH N, R15
; %bb.1:                                ; %if.end
	LDI R2, 20
	MUL R1, R2, R1
	LDI R3, 0
	H LDI R3, 2048
	SLT ADI R3, 0
	ADD R1, R3, R1
	CHAR LOD R1, R3, 16
	LSH R3, R2, R2
	CHAR LOD R1, R3, 17
	LDI R4, 15
	LSH R3, R4, R3
	NOR R3, R2, R2
	CHAR LOD R1, R1, 18
	LDI R3, 12
	LSH R1, R3, R1
	NOR R2, R2, R2
	NOR R2, R1, R1
	NOR R1, R1, R1
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 4
	NOR R1, R2, R2
	NOR R2, R2, R2
	LDI R3, 3
	INT STR R2, R3, 0
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 0
	NOR R1, R2, R2
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 16
	NOR R1, R3, R1
	NOR R1, R1, R1
	INT LOD R1, R1, 0
	NOR R2, R2, R2
	LDI R3, 0
	H LDI R3, current_display+8
	SLT ADI R3, current_display+8
	INT STR R3, R2, 0
	LDI R2, 0
	H LDI R2, current_display+4
	SLT ADI R2, current_display+4
	INT STR R2, R1, 0
	LDI R1, 0
	H LDI R1, ttyWrite
	SLT ADI R1, ttyWrite
	LDI R2, 0
	H LDI R2, current_display
	SLT ADI R2, current_display
	INT STR R2, R1, 0
.LBB4_2:                                ; %cleanup
	ADI R14, -4
	RET
.Lfunc_end4:
	.size	displaySearch, .Lfunc_end4-displaySearch
                                        ; -- End function
	.globl	strlen                          ; -- Begin function strlen
	.type	strlen,@function
strlen:                                 ; @strlen
; %bb.0:                                ; %entry
	ADI R14, 4
	SLT ADD R1, R0, R2
	LDI R3, 0
	SLT ADD R3, R0, R1
.LBB5_1:                                ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	ADD R2, R1, R4
	ADI R1, 1
	CHAR LOD R4, R4, 0
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB5_1)
	SLT ADI R15, %lo(.LBB5_1)
	BRH NE, R15
; %bb.2:                                ; %while.end
	ADI R1, -1
	ADI R14, -4
	RET
.Lfunc_end5:
	.size	strlen, .Lfunc_end5-strlen
                                        ; -- End function
	.globl	biosWrite                       ; -- Begin function biosWrite
	.type	biosWrite,@function
biosWrite:                              ; @biosWrite
; %bb.0:                                ; %entry
	ADI R14, 8
	INT STR R14, R8, -4
	SLT ADD R2, R0, R3
	CHAR LOD R1, R4, 0
	LDI R6, 1
	LDI R5, 255
	LDI R2, 0
	SUB R3, R6, R0
	H LDI R15, %hi(.LBB6_4)
	SLT ADI R15, %lo(.LBB6_4)
	BRH N, R15
; %bb.1:                                ; %entry
	AND R4, R5, R6
	SUB R6, R2, R0
	H LDI R15, %hi(.LBB6_4)
	SLT ADI R15, %lo(.LBB6_4)
	BRH NE, R15
; %bb.2:                                ; %if.then
	LDI R1, 0
	H LDI R1, current_display
	SLT ADI R1, current_display
	INT LOD R1, R4, 0
	LDI R2, 2
	H LDI R15, %hi(.LBB6_3)
	SLT ADI R15, %lo(.LBB6_3)
	JMP R15
.LBB6_4:                                ; %if.else
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB6_7)
	SLT ADI R15, %lo(.LBB6_7)
	BRH NE, R15
; %bb.5:                                ; %if.else
	AND R4, R5, R4
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB6_7)
	SLT ADI R15, %lo(.LBB6_7)
	BRH NE, R15
; %bb.6:                                ; %if.then11
	LDI R1, 0
	H LDI R1, current_display
	SLT ADI R1, current_display
	INT LOD R1, R4, 0
	LDI R2, 3
	LDI R3, 0
.LBB6_3:                                ; %if.end20
	LDI R1, 0
	H LDI R1, .L.str
	SLT ADI R1, .L.str
.LBB6_10:                               ; %if.end20
	CAL R4
	INT LOD R14, R8, -4
	ADI R14, -8
	RET
.LBB6_7:                                ; %if.else12
	CHAR LOD R1, R4, 1
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB6_9)
	SLT ADI R15, %lo(.LBB6_9)
	BRH EQ, R15
; %bb.8:                                ; %while.cond.i.preheader
	SLT ADD R1, R0, R8
	H LDI R15, %hi(strlen)
	SLT ADI R15, %lo(strlen)
	CAL R15
	SLT ADD R1, R0, R3
	LDI R1, 0
	H LDI R1, current_display
	SLT ADI R1, current_display
	INT LOD R1, R4, 0
	LDI R2, 4
	SLT ADD R8, R0, R1
	H LDI R15, %hi(.LBB6_10)
	SLT ADI R15, %lo(.LBB6_10)
	JMP R15
.LBB6_9:                                ; %if.then17
	LDI R2, 0
	H LDI R2, current_display
	SLT ADI R2, current_display
	INT LOD R2, R4, 0
	LDI R2, 1
	H LDI R15, %hi(.LBB6_10)
	SLT ADI R15, %lo(.LBB6_10)
	JMP R15
.Lfunc_end6:
	.size	biosWrite, .Lfunc_end6-biosWrite
                                        ; -- End function
	.globl	bus_Enumeration                 ; -- Begin function bus_Enumeration
	.type	bus_Enumeration,@function
bus_Enumeration:                        ; @bus_Enumeration
; %bb.0:                                ; %entry
	ADI R14, 60
	INT STR R14, R8, -36
	INT STR R14, R9, -40
	INT STR R14, R10, -44
	INT STR R14, R11, -48
	INT STR R14, R12, -52
	INT STR R14, R13, -56
	SLT ADD R2, R0, R8
	SLT ADD R1, R0, R11
	LDI R1, 255
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB7_37)
	SLT ADI R15, %lo(.LBB7_37)
	BRH C, R15
; %bb.1:                                ; %for.cond.preheader
	LDI R1, 20
	LSH R11, R1, R1
	INT STR R14, R1, -20
	LDI R13, 0
	LDI R6, 0
	H LDI R6, map_size
	SLT ADI R6, map_size
	LDI R5, 0
	H LDI R5, 49152
	SLT ADI R5, 0
	INT STR R14, R13, -16
	INT STR R14, R4, -12
	INT STR R14, R8, -8
	INT STR R14, R11, -4
.LBB7_2:                                ; %for.cond2.preheader
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB7_3 Depth 2
	SLT ADD R13, R0, R7
	SLT ADD R13, R0, R1
.LBB7_3:                                ; %for.body5
                                        ;   Parent Loop BB7_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	SLT ADD R1, R0, R10
	INT LOD R14, R1, -20
	ADD R1, R7, R9
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
	H LDI R15, %hi(.LBB7_36)
	SLT ADI R15, %lo(.LBB7_36)
	BRH EQ, R15
; %bb.4:                                ; %if.end12
                                        ;   in Loop: Header=BB7_3 Depth=2
	INT LOD R6, R1, 0
	LDI R2, 63
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB7_37)
	SLT ADI R15, %lo(.LBB7_37)
	BRH N, R15
; %bb.5:                                ; %if.end15
                                        ;   in Loop: Header=BB7_3 Depth=2
	INT STR R14, R7, -32
	INT LOD R4, R2, 0
	ADD R2, R5, R2
	LDI R7, 0
	H LDI R7, 49152
	SLT ADI R7, 0
	LDI R5, 20
	MUL R1, R5, R1
	ADD R8, R1, R12
	INT STR R12, R2, 0
	CHAR STR R12, R11, 16
	INT LOD R14, R1, -16
	CHAR STR R12, R1, 17
	INT STR R14, R10, -28
	CHAR STR R12, R10, 18
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 8
	ADD R9, R1, R1
	INT LOD R1, R10, 0
	LDI R1, 24
	RSH R10, R1, R1
	LDI R2, 127
	AND R1, R2, R1
	INT STR R12, R10, 12
	LDI R2, 1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB7_6)
	SLT ADI R15, %lo(.LBB7_6)
	BRH NE, R15
; %bb.26:                               ; %if.then75
                                        ;   in Loop: Header=BB7_3 Depth=2
	INT LOD R4, R1, 0
	LDI R2, 0
	H LDI R2, 1
	SLT ADI R2, -1
	ADD R1, R2, R1
	LDI R2, 0
	H LDI R2, 65535
	SLT ADI R2, 0
	AND R1, R2, R1
	INT STR R4, R1, 0
	ADD R1, R7, R1
	INT STR R12, R1, 0
	INT LOD R6, R1, 0
	ADI R1, 1
	INT STR R6, R1, 0
	INT STR R14, R9, -24
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 16
	ADD R9, R1, R9
	INT LOD R3, R1, 0
	INT LOD R9, R2, 0
	LDI R5, 0
	H LDI R5, 65280
	SLT ADI R5, 0
	AND R2, R5, R2
	LDI R5, 255
	AND R1, R5, R6
	LDI R5, 16
	LSH R6, R5, R5
	NOR R2, R5, R2
	NOR R2, R2, R2
	NOR R2, R11, R2
	LDI R5, 8
	LSH R6, R5, R13
	NOR R2, R2, R2
	NOR R2, R13, R2
	NOR R2, R2, R2
	INT STR R9, R2, 0
	INT LOD R3, R2, 0
	ADI R2, 1
	INT STR R3, R2, 0
	SLT ADD R8, R0, R2
	SLT ADD R3, R0, R11
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	INT LOD R14, R5, -12
	INT LOD R5, R1, 0
	INT LOD R12, R2, 0
	LDI R3, 0
	H LDI R3, 16384
	SLT ADI R3, 0
	ADD R2, R3, R2
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB7_28)
	SLT ADI R15, %lo(.LBB7_28)
	BRH NC, R15
; %bb.27:                               ; %if.then99
                                        ;   in Loop: Header=BB7_3 Depth=2
	LDI R2, 0
	H LDI R2, 1
	SLT ADI R2, -1
	ADD R1, R2, R1
	LDI R2, 0
	H LDI R2, 65535
	SLT ADI R2, 0
	AND R1, R2, R1
	INT STR R5, R1, 0
.LBB7_28:                               ; %if.end102
                                        ;   in Loop: Header=BB7_3 Depth=2
	INT LOD R9, R1, 0
	LDI R2, 0
	H LDI R2, 65280
	SLT ADI R2, 255
	AND R1, R2, R1
	SLT ADD R11, R0, R3
	INT LOD R3, R2, 0
	LDI R4, 16
	LSH R2, R4, R2
	LDI R4, 0
	H LDI R4, 255
	SLT ADI R4, 0
	ADD R2, R4, R2
	AND R2, R4, R2
	NOR R1, R2, R1
	NOR R1, R1, R1
	NOR R1, R13, R1
	NOR R1, R1, R1
	INT STR R9, R1, 0
	SLT ADD R5, R0, R4
	INT LOD R5, R1, 0
	LDI R2, 0
	H LDI R2, 49152
	SLT ADI R2, 0
	ADD R1, R2, R7
	INT STR R12, R7, 4
	INT LOD R12, R2, 0
	SUB R7, R2, R2
	INT STR R12, R2, 8
	INT LOD R12, R5, 0
	LDI R13, 0
	SLT ADD R13, R0, R2
	INT LOD R14, R6, -24
	SUB R5, R7, R0
	H LDI R15, %hi(.LBB7_30)
	SLT ADI R15, %lo(.LBB7_30)
	BRH NC, R15
; %bb.29:                               ; %if.then126
                                        ;   in Loop: Header=BB7_3 Depth=2
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 4
	ADD R6, R2, R2
	INT LOD R12, R5, 0
	LDI R7, 3
	INT STR R2, R7, 0
	LDI R2, 0
	H LDI R2, 49152
	SLT ADI R2, -1
	ADD R1, R2, R1
	LDI R2, 0
	H LDI R2, 65535
	SLT ADI R2, 0
	AND R1, R2, R1
	LDI R2, 16
	RSH R5, R2, R2
	NOR R2, R1, R1
	NOR R1, R1, R2
.LBB7_30:                               ; %if.end135
                                        ;   in Loop: Header=BB7_3 Depth=2
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 24
	ADD R6, R1, R1
	INT STR R1, R2, 0
	SLT ADD R13, R0, R1
	INT LOD R14, R11, -4
	SUB R10, R13, R0
	H LDI R15, %hi(.LBB7_32)
	SLT ADI R15, %lo(.LBB7_32)
	BRH NN, R15
; %bb.31:                               ; %if.end135
                                        ;   in Loop: Header=BB7_3 Depth=2
	LDI R1, 1
.LBB7_32:                               ; %if.end135
                                        ;   in Loop: Header=BB7_3 Depth=2
	SLT ADD R13, R0, R2
	INT LOD R14, R8, -8
	LDI R6, 0
	H LDI R6, map_size
	SLT ADI R6, map_size
	LDI R5, 0
	H LDI R5, 49152
	SLT ADI R5, 0
	INT LOD R14, R7, -32
	SUB R7, R13, R0
	H LDI R15, %hi(.LBB7_34)
	SLT ADI R15, %lo(.LBB7_34)
	BRH EQ, R15
; %bb.33:                               ; %if.end135
                                        ;   in Loop: Header=BB7_3 Depth=2
	LDI R2, 1
.LBB7_34:                               ; %if.end135
                                        ;   in Loop: Header=BB7_3 Depth=2
	NOR R2, R1, R1
	NOR R1, R1, R1
	LDI R2, 1
	INT LOD R14, R9, -28
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB7_36)
	SLT ADI R15, %lo(.LBB7_36)
	BRH NE, R15
; %bb.35:                               ; %if.end135
                                        ;   in Loop: Header=BB7_3 Depth=2
	ADI R7, 4096
	SLT ADD R9, R0, R1
	ADI R1, 1
	LDI R2, 7
	SUB R9, R2, R0
	H LDI R15, %hi(.LBB7_3)
	SLT ADI R15, %lo(.LBB7_3)
	BRH C, R15
	H LDI R15, %hi(.LBB7_36)
	SLT ADI R15, %lo(.LBB7_36)
	JMP R15
.LBB7_6:                                ; %if.end15
                                        ;   in Loop: Header=BB7_2 Depth=1
	LDI R5, 0
	H LDI R5, 49152
	SLT ADI R5, 0
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB7_7)
	SLT ADI R15, %lo(.LBB7_7)
	BRH EQ, R15
.LBB7_36:                               ; %for.inc159
                                        ;   in Loop: Header=BB7_2 Depth=1
	INT LOD R14, R1, -20
	LDI R2, 0
	H LDI R2, 1
	SLT ADI R2, -32768
	ADD R1, R2, R1
	INT STR R14, R1, -20
	INT LOD R14, R2, -16
	ADI R2, 1
	LDI R1, 32
	INT STR R14, R2, -16
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB7_2)
	SLT ADI R15, %lo(.LBB7_2)
	BRH NE, R15
	H LDI R15, %hi(.LBB7_37)
	SLT ADI R15, %lo(.LBB7_37)
	JMP R15
.LBB7_7:                                ; %for.cond31.preheader
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 16
	ADD R9, R1, R8
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -1
	INT STR R8, R2, 0
	INT LOD R8, R3, 0
	LDI R1, 0
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB7_11)
	SLT ADI R15, %lo(.LBB7_11)
	BRH EQ, R15
; %bb.8:                                ; %if.end46
	LDI R5, 4096
	INT LOD R4, R6, 0
	ADD R6, R7, R6
	INT STR R8, R6, 0
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB7_10)
	SLT ADI R15, %lo(.LBB7_10)
	BRH NC, R15
; %bb.9:                                ; %if.end46
	ADI R3, 4095
	LDI R4, 0
	H LDI R4, 0
	SLT ADI R4, -4096
	AND R3, R4, R5
.LBB7_10:                               ; %if.end46
	INT LOD R14, R4, -12
	INT LOD R4, R3, 0
	ADD R3, R5, R3
	INT STR R4, R3, 0
.LBB7_11:                               ; %for.inc
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 20
	ADD R9, R3, R3
	INT STR R3, R2, 0
	INT LOD R3, R2, 0
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB7_15)
	SLT ADI R15, %lo(.LBB7_15)
	BRH EQ, R15
; %bb.12:                               ; %if.end46.1
	INT LOD R4, R6, 0
	LDI R5, 0
	H LDI R5, 49152
	SLT ADI R5, 0
	ADD R6, R5, R5
	INT STR R3, R5, 0
	LDI R3, 4096
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB7_14)
	SLT ADI R15, %lo(.LBB7_14)
	BRH NC, R15
; %bb.13:                               ; %if.end46.1
	ADI R2, 4095
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -4096
	AND R2, R3, R3
.LBB7_14:                               ; %if.end46.1
	INT LOD R4, R2, 0
	ADD R2, R3, R2
	INT STR R4, R2, 0
.LBB7_15:                               ; %for.inc.1
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 24
	ADD R9, R2, R7
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -1
	INT STR R7, R2, 0
	INT LOD R7, R3, 0
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB7_19)
	SLT ADI R15, %lo(.LBB7_19)
	BRH EQ, R15
; %bb.16:                               ; %if.end46.2
	INT LOD R4, R5, 0
	LDI R6, 0
	H LDI R6, 49152
	SLT ADI R6, 0
	ADD R5, R6, R5
	INT STR R7, R5, 0
	LDI R5, 4096
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB7_18)
	SLT ADI R15, %lo(.LBB7_18)
	BRH NC, R15
; %bb.17:                               ; %if.end46.2
	ADI R3, 4095
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -4096
	AND R3, R5, R5
.LBB7_18:                               ; %if.end46.2
	SLT ADD R4, R0, R6
	INT LOD R6, R3, 0
	ADD R3, R5, R3
	INT STR R6, R3, 0
.LBB7_19:                               ; %for.inc.2
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 28
	ADD R9, R3, R3
	INT STR R3, R2, 0
	INT LOD R3, R2, 0
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB7_20)
	SLT ADI R15, %lo(.LBB7_20)
	BRH EQ, R15
; %bb.21:                               ; %if.end46.3
	INT LOD R4, R1, 0
	LDI R5, 0
	H LDI R5, 49152
	SLT ADI R5, 0
	ADD R1, R5, R1
	INT STR R3, R1, 0
	LDI R1, 4097
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB7_22)
	SLT ADI R15, %lo(.LBB7_22)
	BRH NC, R15
; %bb.23:                               ; %if.then50.3
	INT LOD R4, R1, 0
	ADI R1, 4096
	H LDI R15, %hi(.LBB7_24)
	SLT ADI R15, %lo(.LBB7_24)
	JMP R15
.LBB7_20:                               ; %for.inc.2.for.inc.3_crit_edge
	INT LOD R4, R1, 0
	H LDI R15, %hi(.LBB7_25)
	SLT ADI R15, %lo(.LBB7_25)
	JMP R15
.LBB7_22:                               ; %if.else.3
	ADI R2, 4095
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -4096
	AND R2, R1, R1
	INT LOD R4, R2, 0
	ADD R2, R1, R1
.LBB7_24:                               ; %for.inc.3
	INT STR R4, R1, 0
.LBB7_25:                               ; %for.inc.3
	INT LOD R12, R2, 0
	SUB R1, R2, R1
	LDI R2, 0
	H LDI R2, 49152
	SLT ADI R2, 0
	ADD R1, R2, R1
	INT STR R12, R1, 8
	INT LOD R4, R1, 0
	ADD R1, R2, R1
	INT STR R12, R1, 4
	LDI R1, 0
	H LDI R1, map_size
	SLT ADI R1, map_size
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
.LBB7_37:                               ; %for.end163
	INT LOD R14, R13, -56
	INT LOD R14, R12, -52
	INT LOD R14, R11, -48
	INT LOD R14, R10, -44
	INT LOD R14, R9, -40
	INT LOD R14, R8, -36
	ADI R14, -60
	RET
.Lfunc_end7:
	.size	bus_Enumeration, .Lfunc_end7-bus_Enumeration
                                        ; -- End function
	.globl	PCIe_Bus_Enumeration            ; -- Begin function PCIe_Bus_Enumeration
	.type	PCIe_Bus_Enumeration,@function
PCIe_Bus_Enumeration:                   ; @PCIe_Bus_Enumeration
; %bb.0:                                ; %entry
	ADI R14, 12
	ADD R14, R0, R4
	SLT ADD R4, R0, R3
	SLT ADI R3, -8
	LDI R1, 1
	INT STR R3, R1, 0
	LDI R1, 0
	LDI R2, 0
	H LDI R2, map_size
	SLT ADI R2, map_size
	INT STR R2, R1, 0
	SLT ADI R4, -4
	INT STR R4, R1, 0
	LDI R2, 0
	H LDI R2, 2048
	SLT ADI R2, 0
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	ADI R14, -12
	RET
.Lfunc_end8:
	.size	PCIe_Bus_Enumeration, .Lfunc_end8-PCIe_Bus_Enumeration
                                        ; -- End function
	.globl	search                          ; -- Begin function search
	.type	search,@function
search:                                 ; @search
; %bb.0:                                ; %entry
	ADI R14, 4
	SLT ADD R1, R0, R2
	LDI R1, 0
	H LDI R1, map_size
	SLT ADI R1, map_size
	INT LOD R1, R3, 0
	LDI R1, 1
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB9_4)
	SLT ADI R15, %lo(.LBB9_4)
	BRH N, R15
; %bb.1:                                ; %for.body.preheader
	LDI R1, 0
	LDI R4, 0
	H LDI R4, 2048
	SLT ADI R4, 12
	LDI R5, 0
	H LDI R5, 256
	SLT ADI R5, -1
.LBB9_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	INT LOD R4, R6, 0
	AND R6, R5, R6
	SUB R6, R2, R0
	H LDI R15, %hi(.LBB9_5)
	SLT ADI R15, %lo(.LBB9_5)
	BRH EQ, R15
; %bb.3:                                ; %for.inc
                                        ;   in Loop: Header=BB9_2 Depth=1
	ADI R4, 20
	ADI R1, 1
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB9_2)
	SLT ADI R15, %lo(.LBB9_2)
	BRH NE, R15
.LBB9_4:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
.LBB9_5:                                ; %cleanup
	ADI R14, -4
	RET
.Lfunc_end9:
	.size	search, .Lfunc_end9-search
                                        ; -- End function
	.globl	main                            ; -- Begin function main
	.type	main,@function
main:                                   ; @main
; %bb.0:                                ; %entry
	ADI R14, 12
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	H LDI R15, %hi(PCIe_Bus_Enumeration)
	SLT ADI R15, %lo(PCIe_Bus_Enumeration)
	CAL R15
	H LDI R15, %hi(displaySearch)
	SLT ADI R15, %lo(displaySearch)
	CAL R15
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.3
	SLT ADI R1, .L.str.3
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1
	SLT ADI R1, .L.str.1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R9, 5
	LDI R1, 0
	H LDI R1, .L.str.2
	SLT ADI R1, .L.str.2
	SLT ADD R9, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.3.4
	SLT ADI R1, .L.str.3.4
	SLT ADD R9, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	;APP
	HLT
	;NO_APP
	SLT ADD R8, R0, R1
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	ADI R14, -12
	RET
.Lfunc_end10:
	.size	main, .Lfunc_end10-main
                                        ; -- End function
	.type	current_display,@object         ; @current_display
	.section	.bss,"aw",@nobits
	.globl	current_display
	.p2align	2, 0x0
current_display:
	.zero	12
	.size	current_display, 12

	.type	.L.str,@object                  ; @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.zero	1
	.size	.L.str, 1

	.type	map_size,@object                ; @map_size
	.section	.bss,"aw",@nobits
	.globl	map_size
	.p2align	2, 0x0
map_size:
	.long	0                               ; 0x0
	.size	map_size, 4

	.type	.L.str.3,@object                ; @.str.3
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.3:
	.asciz	"Hola "
	.size	.L.str.3, 6

	.type	.L.str.1,@object                ; @.str.1
.L.str.1:
	.asciz	"Mundo!!! \n\n"
	.size	.L.str.1, 12

	.type	.L.str.2,@object                ; @.str.2
.L.str.2:
	.asciz	"A"
	.size	.L.str.2, 2

	.type	.L.str.3.4,@object              ; @.str.3.4
.L.str.3.4:
	.zero	1
	.size	.L.str.3.4, 1

	.ident	"clang version 24.0.0git (https://github.com/Licha-M/llvm-project-ISA32-LM.git 123c4b4feffc5a7ed210b88c5c369ff30f37d4d4)"
	.section	".note.GNU-stack","",@progbits

; ════════════════════ .start auto-generado ════════════════════
; Inicio en palabra ROM 768 (byte 0x000C00)
; .start:
; ── Fase 1: Copiar 10 palabra(s) de .data  ROM → RAM ──────────────
;	H LDI R15, 0xFFF0		; Dir. ROM origen .data (palabra 758, byte 0x000BD8)
;	SLT ADI R15, 0x0BD8
;	H LDI R1, 0x0400		; Dir. RAM destino = 0x04000000
;	SLT ADI R1, 0x0000
;	INT LOD R15, R2, 0		; Leer palabra 0 de ROM (.data blob)
;	INT STR R1, R2, 0		; Escribir en RAM[0x04000000]
;	INT LOD R15, R2, 4		; Leer palabra 1 de ROM (.data blob)
;	INT STR R1, R2, 4		; Escribir en RAM[0x04000004]
;	INT LOD R15, R2, 8		; Leer palabra 2 de ROM (.data blob)
;	INT STR R1, R2, 8		; Escribir en RAM[0x04000008]
;	INT LOD R15, R2, 12		; Leer palabra 3 de ROM (.data blob)
;	INT STR R1, R2, 12		; Escribir en RAM[0x0400000C]
;	INT LOD R15, R2, 16		; Leer palabra 4 de ROM (.data blob)
;	INT STR R1, R2, 16		; Escribir en RAM[0x04000010]
;	INT LOD R15, R2, 20		; Leer palabra 5 de ROM (.data blob)
;	INT STR R1, R2, 20		; Escribir en RAM[0x04000014]
;	INT LOD R15, R2, 24		; Leer palabra 6 de ROM (.data blob)
;	INT STR R1, R2, 24		; Escribir en RAM[0x04000018]
;	INT LOD R15, R2, 28		; Leer palabra 7 de ROM (.data blob)
;	INT STR R1, R2, 28		; Escribir en RAM[0x0400001C]
;	INT LOD R15, R2, 32		; Leer palabra 8 de ROM (.data blob)
;	INT STR R1, R2, 32		; Escribir en RAM[0x04000020]
;	INT LOD R15, R2, 36		; Leer palabra 9 de ROM (.data blob)
;	INT STR R1, R2, 36		; Escribir en RAM[0x04000024]
; ── Fase 2: Zero-inicializar 4 palabra(s) de .bss en RAM ─────────────
;	H LDI R1, 0x0400		; Base .bss en RAM = 0x04000028
;	SLT ADI R1, 0x0028
;	INT STR R1, R0, 0		; RAM[0x04000028] = 0  (.bss[0])
;	INT STR R1, R0, 4		; RAM[0x0400002C] = 0  (.bss[1])
;	INT STR R1, R0, 8		; RAM[0x04000030] = 0  (.bss[2])
;	INT STR R1, R0, 12		; RAM[0x04000034] = 0  (.bss[3])
; ── Fase 3: Saltar a main ──────────────────────────────────────────────────
;	H LDI R15, %hi(main)		; Parte alta de la dirección de main
;	SLT ADI R15, %lo(main)	; Parte baja
;	JMP R15

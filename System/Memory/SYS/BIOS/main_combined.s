	.file	"llvm-link"
	.text
	.globl	final                           ; -- Begin function final
	.type	final,@function
final:                                  ; @final
; %bb.0:
	SLT ADI R14, 4
.LBB0_1:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB0_1)
	SLT ADI R15, %lo(.LBB0_1)
	JMP R15
.Lfunc_end0:
	.size	final, .Lfunc_end0-final
                                        ; -- End function
	.globl	initGlobalVars                  ; -- Begin function initGlobalVars
	.type	initGlobalVars,@function
initGlobalVars:                         ; @initGlobalVars
; %bb.0:
	SLT ADI R14, 28
	INT STR R14, R8, -12
	INT STR R14, R9, -16
	INT STR R14, R10, -20
	INT STR R14, R11, -24
	LDI R8, 0
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT STR R1, R8, 0
	ADD R14, R0, R10
	SLT ADD R10, R0, R9
	SLT ADI R9, -8
	INT STR R9, R8, 0
	SLT ADI R10, -4
	INT STR R10, R8, 0
	LDI R1, 4096
	LDI R3, 1
	SLT ADD R8, R0, R2
	SLT ADD R10, R0, R4
	H LDI R15, %hi(allocatePages)
	SLT ADI R15, %lo(allocatePages)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB1_2)
	SLT ADI R15, %lo(.LBB1_2)
	BRH EQ, R15
.LBB1_1:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB1_1)
	SLT ADI R15, %lo(.LBB1_1)
	JMP R15
.LBB1_2:
	LDI R3, 1
	SLT ADD R8, R0, R1
	SLT ADD R8, R0, R2
	SLT ADD R9, R0, R4
	H LDI R15, %hi(allocatePages)
	SLT ADI R15, %lo(allocatePages)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB1_4)
	SLT ADI R15, %lo(.LBB1_4)
	BRH EQ, R15
.LBB1_3:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB1_3)
	SLT ADI R15, %lo(.LBB1_3)
	JMP R15
.LBB1_4:
	LDI R2, 28
	LDI R11, 0
	H LDI R11, Globals
	SLT ADI R11, Globals
	SLT ADD R8, R0, R1
	LDI R3, 0
	H LDI R3, Globals
	SLT ADI R3, Globals
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB1_6)
	SLT ADI R15, %lo(.LBB1_6)
	BRH EQ, R15
.LBB1_5:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB1_5)
	SLT ADI R15, %lo(.LBB1_5)
	JMP R15
.LBB1_6:
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 4
	INT LOD R1, R1, 0
	INT LOD R11, R2, 0
	INT STR R2, R1, 16
	INT LOD R10, R1, 0
	INT LOD R11, R2, 0
	INT STR R2, R1, 20
	INT LOD R9, R1, 0
	INT LOD R11, R2, 0
	INT STR R2, R1, 24
	INT LOD R11, R1, 0
	INT STR R1, R8, 0
	INT LOD R11, R1, 0
	INT STR R1, R8, 8
	INT LOD R11, R1, 0
	INT STR R1, R8, 12
	INT LOD R11, R1, 0
	CHAR STR R1, R8, 4
	INT LOD R14, R11, -24
	INT LOD R14, R10, -20
	INT LOD R14, R9, -16
	INT LOD R14, R8, -12
	SLT ADI R14, -28
	RET
.Lfunc_end1:
	.size	initGlobalVars, .Lfunc_end1-initGlobalVars
                                        ; -- End function
	.globl	main                            ; -- Begin function main
	.type	main,@function
main:                                   ; @main
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 0
	INT LOD R1, R1, 0
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB2_1)
	SLT ADI R15, %lo(.LBB2_1)
	BRH EQ, R15
; %bb.2:
	H LDI R15, %hi(initGlobalVars)
	SLT ADI R15, %lo(initGlobalVars)
	CAL R15
	H LDI R15, %hi(initLAPIC)
	SLT ADI R15, %lo(initLAPIC)
	CAL R15
	H LDI R15, %hi(PCIe_Bus_Enumeration)
	SLT ADI R15, %lo(PCIe_Bus_Enumeration)
	CAL R15
	H LDI R15, %hi(displaySearch)
	SLT ADI R15, %lo(displaySearch)
	CAL R15
	LDI R8, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB2_3)
	SLT ADI R15, %lo(.LBB2_3)
	BRH EQ, R15
; %bb.4:
	H LDI R15, %hi(nvmSearch)
	SLT ADI R15, %lo(nvmSearch)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB2_5)
	SLT ADI R15, %lo(.LBB2_5)
	BRH EQ, R15
; %bb.7:
	H LDI R15, %hi(keyboardSearch)
	SLT ADI R15, %lo(keyboardSearch)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB2_8)
	SLT ADI R15, %lo(.LBB2_8)
	BRH EQ, R15
; %bb.9:
	H LDI R15, %hi(BiosShell)
	SLT ADI R15, %lo(BiosShell)
	CAL R15
	H LDI R15, %hi(.LBB2_10)
	SLT ADI R15, %lo(.LBB2_10)
	JMP R15
.LBB2_1:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB2_1)
	SLT ADI R15, %lo(.LBB2_1)
	JMP R15
.LBB2_3:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB2_3)
	SLT ADI R15, %lo(.LBB2_3)
	JMP R15
.LBB2_5:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str
	SLT ADI R1, .L.str
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB2_6:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB2_6)
	SLT ADI R15, %lo(.LBB2_6)
	JMP R15
.LBB2_8:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.1
	SLT ADI R1, .L.str.1
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB2_10:
	LDI R1, 0
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        ; -- End function
	.globl	keyboard_IRQHandler             ; -- Begin function keyboard_IRQHandler
	.type	keyboard_IRQHandler,@function
keyboard_IRQHandler:                    ; @keyboard_IRQHandler
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R2, R0, R1
	LDI R2, 0
	H LDI R2, kq
	SLT ADI R2, kq
	INT LOD R2, R2, 0
	LDI R3, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB3_3)
	SLT ADI R15, %lo(.LBB3_3)
	BRH EQ, R15
; %bb.1:
	LDI R3, 0
	H LDI R3, kb_registers
	SLT ADI R3, kb_registers
	INT LOD R3, R4, 0
	INT LOD R4, R3, 4
	LDI R5, 2
	INT STR R4, R5, 0
	SLT ADD R2, R0, R4
	ADI R4, 64
	CHAR LOD R4, R4, 0
	ADI R4, 1
	LDI R5, 63
	AND R4, R5, R4
	CHAR LOD R2, R5, 65
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB3_3)
	SLT ADI R15, %lo(.LBB3_3)
	BRH EQ, R15
; %bb.2:
	CHAR LOD R2, R5, 64
	ADD R2, R5, R2
	CHAR STR R2, R3, 0
	LDI R2, 0
	H LDI R2, kq
	SLT ADI R2, kq
	INT LOD R2, R2, 0
	CHAR STR R2, R4, 64
.LBB3_3:
	SLT ADI R14, -4
	RET
.Lfunc_end3:
	.size	keyboard_IRQHandler, .Lfunc_end3-keyboard_IRQHandler
                                        ; -- End function
	.globl	keyboardSearch                  ; -- Begin function keyboardSearch
	.type	keyboardSearch,@function
keyboardSearch:                         ; @keyboardSearch
; %bb.0:
	SLT ADI R14, 28
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	INT STR R14, R13, -24
	LDI R1, 0
	H LDI R1, 9
	SLT ADI R1, 0
	H LDI R15, %hi(searchFirst)
	SLT ADI R15, %lo(searchFirst)
	CAL R15
	LDI R8, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB4_5)
	SLT ADI R15, %lo(.LBB4_5)
	BRH N, R15
; %bb.1:
	LDI R9, 20
	MUL R1, R9, R1
	LDI R2, 0
	H LDI R2, mapa
	SLT ADI R2, mapa
	INT LOD R2, R2, 0
	ADD R2, R1, R1
	CHAR LOD R1, R12, 16
	CHAR LOD R1, R11, 17
	CHAR LOD R1, R10, 18
	LDI R1, 5
	LDI R2, 66
	LDI R13, 0
	H LDI R13, kq
	SLT ADI R13, kq
	LDI R3, 0
	H LDI R3, kq
	SLT ADI R3, kq
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB4_3)
	SLT ADI R15, %lo(.LBB4_3)
	BRH NE, R15
; %bb.2:
	INT LOD R13, R1, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB4_3)
	SLT ADI R15, %lo(.LBB4_3)
	BRH EQ, R15
; %bb.4:
	CHAR STR R1, R8, 64
	CHAR STR R1, R8, 65
	LSH R12, R9, R1
	LDI R2, 15
	LSH R11, R2, R2
	NOR R2, R1, R1
	LDI R2, 12
	LSH R10, R2, R2
	NOR R1, R1, R1
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 4
	NOR R1, R2, R2
	NOR R2, R2, R2
	LDI R8, 1
	INT STR R2, R8, 0
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 16
	NOR R1, R2, R2
	NOR R2, R2, R2
	INT LOD R2, R2, 0
	LDI R9, 0
	H LDI R9, kb_registers
	SLT ADI R9, kb_registers
	INT STR R9, R2, 0
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 0
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 126
	LDI R3, 0
	H LDI R3, keyboard_IRQHandler
	SLT ADI R3, keyboard_IRQHandler
	H LDI R15, %hi(initMSI)
	SLT ADI R15, %lo(initMSI)
	CAL R15
	INT LOD R9, R1, 0
	INT STR R1, R8, 0
	H LDI R15, %hi(.LBB4_5)
	SLT ADI R15, %lo(.LBB4_5)
	JMP R15
.LBB4_3:
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.3
	SLT ADI R1, .L.str.3
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB4_5:
	SLT ADD R8, R0, R1
	INT LOD R14, R13, -24
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -28
	RET
.Lfunc_end4:
	.size	keyboardSearch, .Lfunc_end4-keyboardSearch
                                        ; -- End function
	.globl	readInput                       ; -- Begin function readInput
	.type	readInput,@function
readInput:                              ; @readInput
; %bb.0:
	SLT ADI R14, 36
	INT STR R14, R8, -12
	INT STR R14, R9, -16
	INT STR R14, R10, -20
	INT STR R14, R11, -24
	INT STR R14, R12, -28
	INT STR R14, R13, -32
	LDI R10, 0
	H LDI R10, 0
	SLT ADI R10, -1
	LDI R6, 0
	INT STR R14, R1, -4
	SUB R1, R6, R0
	H LDI R15, %hi(.LBB5_24)
	SLT ADI R15, %lo(.LBB5_24)
	BRH EQ, R15
; %bb.1:
	LDI R9, 1
	SUB R2, R9, R0
	H LDI R15, %hi(.LBB5_24)
	SLT ADI R15, %lo(.LBB5_24)
	BRH N, R15
; %bb.2:
	LDI R1, 0
	H LDI R1, kq
	SLT ADI R1, kq
	INT LOD R1, R1, 0
	SUB R1, R6, R0
	H LDI R15, %hi(.LBB5_24)
	SLT ADI R15, %lo(.LBB5_24)
	BRH EQ, R15
; %bb.3:
	INT LOD R14, R1, -4
	CHAR STR R1, R6, 0
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R3, 4
	AND R1, R3, R1
	SUB R1, R6, R0
	H LDI R15, %hi(.LBB5_5)
	SLT ADI R15, %lo(.LBB5_5)
	BRH NE, R15
; %bb.4:
	LDI R1, 0
	H LDI R1, .L.str.4
	SLT ADI R1, .L.str.4
	H LDI R15, %hi(.LBB5_23)
	SLT ADI R15, %lo(.LBB5_23)
	JMP R15
.LBB5_5:
	ADI R2, -1
	INT STR R14, R2, -8
	LDI R13, 0
	H LDI R13, kq
	SLT ADI R13, kq
	LDI R7, 63
	LDI R5, 12
	LDI R8, 10
	SLT ADD R6, R0, R1
	SLT ADD R6, R0, R10
	H LDI R15, %hi(.LBB5_7)
	SLT ADI R15, %lo(.LBB5_7)
	JMP R15
.LBB5_6:                                ;   in Loop: Header=BB5_7 Depth=1
	;APP
	HLT
	;NO_APP
.LBB5_7:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB5_8 Depth 2
	INT LOD R13, R2, 0
	CHAR LOD R2, R3, 65
	CHAR LOD R2, R2, 64
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB5_6)
	SLT ADI R15, %lo(.LBB5_6)
	BRH EQ, R15
.LBB5_8:                                ;   Parent Loop BB5_7 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	INT LOD R13, R2, 0
	CHAR LOD R2, R3, 65
	CHAR LOD R2, R4, 64
	SLT ADD R9, R0, R12
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB5_10)
	SLT ADI R15, %lo(.LBB5_10)
	BRH NE, R15
; %bb.9:                                ;   in Loop: Header=BB5_8 Depth=2
	SLT ADD R6, R0, R12
.LBB5_10:                               ;   in Loop: Header=BB5_8 Depth=2
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB5_19)
	SLT ADI R15, %lo(.LBB5_19)
	BRH EQ, R15
; %bb.11:                               ;   in Loop: Header=BB5_8 Depth=2
	CHAR LOD R2, R3, 65
	ADD R2, R3, R3
	CHAR LOD R3, R11, 0
	SLT ADD R2, R0, R3
	ADI R3, 65
	CHAR LOD R3, R4, 0
	ADI R4, 1
	AND R4, R7, R4
	CHAR STR R2, R4, 65
	SUB R5, R11, R0
	H LDI R15, %hi(.LBB5_25)
	SLT ADI R15, %lo(.LBB5_25)
	BRH N, R15
; %bb.12:                               ;   in Loop: Header=BB5_8 Depth=2
	LDI R4, 8
	SUB R11, R4, R0
	H LDI R15, %hi(.LBB5_37)
	SLT ADI R15, %lo(.LBB5_37)
	BRH EQ, R15
; %bb.13:                               ;   in Loop: Header=BB5_8 Depth=2
	SUB R11, R8, R0
	H LDI R15, %hi(.LBB5_14)
	SLT ADI R15, %lo(.LBB5_14)
	BRH NE, R15
	H LDI R15, %hi(.LBB5_27)
	SLT ADI R15, %lo(.LBB5_27)
	JMP R15
.LBB5_25:                               ;   in Loop: Header=BB5_8 Depth=2
	LDI R4, 127
	SUB R11, R4, R0
	H LDI R15, %hi(.LBB5_26)
	SLT ADI R15, %lo(.LBB5_26)
	BRH NE, R15
.LBB5_37:                               ;   in Loop: Header=BB5_8 Depth=2
	SUB R10, R9, R0
	H LDI R15, %hi(.LBB5_17)
	SLT ADI R15, %lo(.LBB5_17)
	BRH N, R15
; %bb.38:                               ;   in Loop: Header=BB5_8 Depth=2
	SLT ADD R9, R0, R13
	SLT ADD R8, R0, R9
	SLT ADD R10, R0, R8
	ADI R8, -1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB5_41)
	SLT ADI R15, %lo(.LBB5_41)
	BRH NN, R15
; %bb.39:                               ;   in Loop: Header=BB5_8 Depth=2
	SLT ADD R8, R0, R10
	H LDI R15, %hi(.LBB5_40)
	SLT ADI R15, %lo(.LBB5_40)
	JMP R15
.LBB5_41:                               ;   in Loop: Header=BB5_8 Depth=2
	LDI R1, 0
	H LDI R1, .L.str.1.3
	SLT ADI R1, .L.str.1.3
	SLT ADD R13, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R5, 12
	LDI R7, 63
	LDI R6, 0
	SLT ADD R8, R0, R10
	SLT ADD R8, R0, R1
.LBB5_40:                               ;   in Loop: Header=BB5_8 Depth=2
	SLT ADD R9, R0, R8
	SLT ADD R13, R0, R9
	LDI R13, 0
	H LDI R13, kq
	SLT ADI R13, kq
	H LDI R15, %hi(.LBB5_17)
	SLT ADI R15, %lo(.LBB5_17)
	JMP R15
.LBB5_26:                               ;   in Loop: Header=BB5_8 Depth=2
	LDI R4, 13
	SUB R11, R4, R0
	H LDI R15, %hi(.LBB5_27)
	SLT ADI R15, %lo(.LBB5_27)
	BRH EQ, R15
.LBB5_14:                               ;   in Loop: Header=BB5_8 Depth=2
	SLT ADD R11, R0, R2
	ADI R2, -32
	LDI R3, 255
	AND R2, R3, R2
	LDI R3, 94
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB5_17)
	SLT ADI R15, %lo(.LBB5_17)
	BRH C, R15
; %bb.15:                               ;   in Loop: Header=BB5_8 Depth=2
	INT LOD R14, R2, -8
	SUB R10, R2, R0
	H LDI R15, %hi(.LBB5_17)
	SLT ADI R15, %lo(.LBB5_17)
	BRH NN, R15
; %bb.16:                               ;   in Loop: Header=BB5_8 Depth=2
	INT LOD R14, R2, -4
	ADD R2, R10, R2
	CHAR STR R2, R11, 0
	ADI R10, 1
.LBB5_17:                               ;   in Loop: Header=BB5_8 Depth=2
	LDI R2, 13
	SUB R11, R2, R0
	H LDI R15, %hi(.LBB5_19)
	SLT ADI R15, %lo(.LBB5_19)
	BRH EQ, R15
; %bb.18:                               ;   in Loop: Header=BB5_8 Depth=2
	SUB R11, R8, R0
	H LDI R15, %hi(.LBB5_8)
	SLT ADI R15, %lo(.LBB5_8)
	BRH NE, R15
	H LDI R15, %hi(.LBB5_19)
	SLT ADI R15, %lo(.LBB5_19)
	JMP R15
.LBB5_27:                               ;   in Loop: Header=BB5_7 Depth=1
	SLT ADD R9, R0, R4
	SUB R11, R8, R0
	H LDI R15, %hi(.LBB5_29)
	SLT ADI R15, %lo(.LBB5_29)
	BRH EQ, R15
; %bb.28:                               ;   in Loop: Header=BB5_7 Depth=1
	SLT ADD R6, R0, R4
.LBB5_29:                               ;   in Loop: Header=BB5_7 Depth=1
	SLT ADD R9, R0, R5
	LDI R12, 13
	SUB R11, R12, R0
	H LDI R15, %hi(.LBB5_31)
	SLT ADI R15, %lo(.LBB5_31)
	BRH EQ, R15
; %bb.30:                               ;   in Loop: Header=BB5_7 Depth=1
	SLT ADD R6, R0, R5
.LBB5_31:                               ;   in Loop: Header=BB5_7 Depth=1
	SUB R11, R12, R0
	H LDI R15, %hi(.LBB5_32)
	SLT ADI R15, %lo(.LBB5_32)
	BRH NE, R15
; %bb.33:                               ;   in Loop: Header=BB5_7 Depth=1
	CHAR LOD R2, R4, 65
	CHAR LOD R2, R5, 64
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB5_34)
	SLT ADI R15, %lo(.LBB5_34)
	BRH EQ, R15
; %bb.35:                               ;   in Loop: Header=BB5_7 Depth=1
	CHAR LOD R2, R4, 65
	ADD R2, R4, R4
	CHAR LOD R4, R4, 0
	SUB R4, R8, R0
	H LDI R15, %hi(.LBB5_34)
	SLT ADI R15, %lo(.LBB5_34)
	BRH NE, R15
; %bb.36:                               ;   in Loop: Header=BB5_7 Depth=1
	CHAR LOD R3, R3, 0
	ADI R3, 1
	AND R3, R7, R3
	CHAR STR R2, R3, 65
.LBB5_34:                               ;   in Loop: Header=BB5_7 Depth=1
	SLT ADD R9, R0, R12
	LDI R5, 12
.LBB5_19:                               ;   in Loop: Header=BB5_7 Depth=1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB5_21)
	SLT ADI R15, %lo(.LBB5_21)
	BRH NN, R15
.LBB5_20:                               ;   in Loop: Header=BB5_7 Depth=1
	INT LOD R14, R3, -4
	ADD R3, R10, R2
	CHAR STR R2, R6, 0
	ADD R3, R1, R1
	SLT ADD R6, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R5, 12
	LDI R7, 63
	LDI R6, 0
	SLT ADD R10, R0, R1
.LBB5_21:                               ;   in Loop: Header=BB5_7 Depth=1
	AND R12, R9, R2
	SUB R2, R6, R0
	H LDI R15, %hi(.LBB5_7)
	SLT ADI R15, %lo(.LBB5_7)
	BRH EQ, R15
	H LDI R15, %hi(.LBB5_22)
	SLT ADI R15, %lo(.LBB5_22)
	JMP R15
.LBB5_32:                               ;   in Loop: Header=BB5_7 Depth=1
	NOR R4, R5, R2
	NOR R2, R2, R12
	LDI R5, 12
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB5_20)
	SLT ADI R15, %lo(.LBB5_20)
	BRH N, R15
	H LDI R15, %hi(.LBB5_21)
	SLT ADI R15, %lo(.LBB5_21)
	JMP R15
.LBB5_22:
	INT LOD R14, R1, -4
	ADD R1, R10, R1
	LDI R2, 0
	CHAR STR R1, R2, 0
	LDI R1, 0
	H LDI R1, .L.str.2
	SLT ADI R1, .L.str.2
.LBB5_23:
	LDI R2, 0
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB5_24:
	SLT ADD R10, R0, R1
	INT LOD R14, R13, -32
	INT LOD R14, R12, -28
	INT LOD R14, R11, -24
	INT LOD R14, R10, -20
	INT LOD R14, R9, -16
	INT LOD R14, R8, -12
	SLT ADI R14, -36
	RET
.Lfunc_end5:
	.size	readInput, .Lfunc_end5-readInput
                                        ; -- End function
	.globl	nvmSearch                       ; -- Begin function nvmSearch
	.type	nvmSearch,@function
nvmSearch:                              ; @nvmSearch
; %bb.0:
	SLT ADI R14, 172
	INT STR R14, R8, -148
	INT STR R14, R9, -152
	INT STR R14, R10, -156
	INT STR R14, R11, -160
	INT STR R14, R12, -164
	INT STR R14, R13, -168
	ADD R14, R0, R9
	SLT ADD R9, R0, R11
	SLT ADI R11, -140
	LDI R1, 0
	H LDI R1, 1
	SLT ADI R1, 2050
	SLT ADD R11, R0, R2
	H LDI R15, %hi(search)
	SLT ADI R15, %lo(search)
	CAL R15
	LDI R4, 0
	H LDI R4, Globals
	SLT ADI R4, Globals
	INT LOD R4, R3, 0
	INT STR R3, R1, 12
	INT LOD R4, R1, 0
	INT LOD R1, R1, 12
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB6_13)
	SLT ADI R15, %lo(.LBB6_13)
	BRH EQ, R15
; %bb.1:
	INT LOD R4, R1, 0
	INT LOD R1, R1, 12
	LDI R2, 40
	MUL R1, R2, R2
	LDI R1, 4
	LDI R8, 0
	H LDI R8, nvmDevs
	SLT ADI R8, nvmDevs
	LDI R3, 0
	H LDI R3, nvmDevs
	SLT ADI R3, nvmDevs
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB6_12)
	SLT ADI R15, %lo(.LBB6_12)
	BRH NE, R15
; %bb.2:
	INT LOD R8, R1, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB6_12)
	SLT ADI R15, %lo(.LBB6_12)
	BRH EQ, R15
; %bb.3:
	LDI R3, 0
	H LDI R3, Globals
	SLT ADI R3, Globals
	INT LOD R3, R1, 0
	INT LOD R1, R1, 12
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB6_13)
	SLT ADI R15, %lo(.LBB6_13)
	BRH EQ, R15
; %bb.4:                                ; %.preheader
	LDI R12, 125
	SLT ADI R9, -144
	INT STR R14, R9, -4
	SLT ADD R2, R0, R9
	SLT ADD R2, R0, R8
	INT STR R14, R2, -8
	H LDI R15, %hi(.LBB6_5)
	SLT ADI R15, %lo(.LBB6_5)
	JMP R15
.LBB6_7:                                ;   in Loop: Header=BB6_5 Depth=1
	LDI R1, 0
	H LDI R1, .L.str.1.8
	SLT ADI R1, .L.str.1.8
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R2, 0
	CHAR STR R10, R2, 20
.LBB6_10:                               ;   in Loop: Header=BB6_5 Depth=1
	INT LOD R14, R11, -12
	ADI R11, 4
	ADI R9, 40
	ADI R12, -1
	ADI R8, 1
	LDI R3, 0
	H LDI R3, Globals
	SLT ADI R3, Globals
	INT LOD R3, R1, 0
	INT LOD R1, R1, 12
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB6_11)
	SLT ADI R15, %lo(.LBB6_11)
	BRH NC, R15
.LBB6_5:                                ; =>This Inner Loop Header: Depth=1
	INT LOD R3, R1, 0
	INT STR R1, R8, 8
	LDI R1, 0
	H LDI R1, nvmDevs
	SLT ADI R1, nvmDevs
	INT LOD R1, R1, 0
	ADD R1, R9, R10
	INT STR R14, R11, -12
	INT LOD R11, R13, 0
	INT STR R10, R8, 24
	CHAR STR R10, R2, 12
	INT STR R10, R2, 16
	INT LOD R14, R11, -4
	INT STR R11, R2, 0
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	LDI R2, 5
	LDI R3, 1
	SLT ADD R11, R0, R4
	H LDI R15, %hi(allocatePages)
	SLT ADI R15, %lo(allocatePages)
	CAL R15
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB6_7)
	SLT ADI R15, %lo(.LBB6_7)
	BRH NE, R15
; %bb.6:                                ;   in Loop: Header=BB6_5 Depth=1
	INT LOD R11, R1, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB6_7)
	SLT ADI R15, %lo(.LBB6_7)
	BRH EQ, R15
; %bb.8:                                ;   in Loop: Header=BB6_5 Depth=1
	SLT ADD R1, R0, R2
	ADI R2, 2048
	INT STR R10, R2, 8
	INT STR R10, R1, 4
	LDI R3, 3
	INT STR R13, R3, 4
	INT LOD R13, R3, 16
	INT STR R10, R3, 0
	INT STR R3, R1, 4
	INT STR R3, R2, 8
	SLT ADD R13, R0, R1
	SLT ADD R12, R0, R2
	LDI R3, 0
	H LDI R3, nvm_IRQHandler
	SLT ADI R3, nvm_IRQHandler
	H LDI R15, %hi(initMSI)
	SLT ADI R15, %lo(initMSI)
	CAL R15
	LDI R1, 255
	INT LOD R14, R2, -8
	AND R2, R1, R1
	INT LOD R10, R2, 0
	LDI R3, 1
	INT STR R2, R3, 0
	INT STR R14, R3, -8
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB6_10)
	SLT ADI R15, %lo(.LBB6_10)
	BRH NE, R15
; %bb.9:                                ;   in Loop: Header=BB6_5 Depth=1
	ADI R10, 20
	CHAR LOD R10, R1, 0
	INT STR R14, R1, -8
	H LDI R15, %hi(.LBB6_10)
	SLT ADI R15, %lo(.LBB6_10)
	JMP R15
.LBB6_12:
	LDI R1, 0
	H LDI R1, .L.str.7
	SLT ADI R1, .L.str.7
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R2, 0
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT STR R1, R2, 12
	H LDI R15, %hi(.LBB6_13)
	SLT ADI R15, %lo(.LBB6_13)
	JMP R15
.LBB6_11:
	INT LOD R14, R2, -8
.LBB6_13:
	LDI R1, 1
	AND R2, R1, R1
	INT LOD R14, R13, -168
	INT LOD R14, R12, -164
	INT LOD R14, R11, -160
	INT LOD R14, R10, -156
	INT LOD R14, R9, -152
	INT LOD R14, R8, -148
	SLT ADI R14, -172
	RET
.Lfunc_end6:
	.size	nvmSearch, .Lfunc_end6-nvmSearch
                                        ; -- End function
	.type	nvm_IRQHandler,@function        ; -- Begin function nvm_IRQHandler
nvm_IRQHandler:                         ; @nvm_IRQHandler
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R2, R0, R1
	LDI R2, 125
	SUB R2, R3, R2
	LDI R3, 0
	H LDI R3, Globals
	SLT ADI R3, Globals
	INT LOD R3, R3, 0
	INT LOD R3, R3, 8
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB7_4)
	SLT ADI R15, %lo(.LBB7_4)
	BRH NC, R15
; %bb.1:
	LDI R3, 0
	H LDI R3, nvmDevs
	SLT ADI R3, nvmDevs
	INT LOD R3, R3, 0
	LDI R4, 0
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB7_4)
	SLT ADI R15, %lo(.LBB7_4)
	BRH EQ, R15
; %bb.2:
	LDI R4, 40
	MUL R2, R4, R2
	ADD R3, R2, R2
	INT LOD R2, R3, 16
	LDI R4, 3
	LSH R3, R4, R4
	INT LOD R2, R5, 8
	ADD R5, R4, R4
	INT LOD R4, R4, 0
	LDI R5, 0
	H LDI R5, 256
	SLT ADI R5, -1
	AND R4, R5, R4
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB7_4)
	SLT ADI R15, %lo(.LBB7_4)
	BRH NE, R15
; %bb.3:
	LDI R3, 1
	CHAR STR R2, R3, 12
.LBB7_4:
	SLT ADI R14, -4
	RET
.Lfunc_end7:
	.size	nvm_IRQHandler, .Lfunc_end7-nvm_IRQHandler
                                        ; -- End function
	.globl	nvm_read_sectors                ; -- Begin function nvm_read_sectors
	.type	nvm_read_sectors,@function
nvm_read_sectors:                       ; @nvm_read_sectors
; %bb.0:
	SLT ADI R14, 20
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	LDI R5, 0
	H LDI R5, Globals
	SLT ADI R5, Globals
	INT LOD R5, R5, 0
	INT LOD R5, R5, 12
	SUB R5, R1, R0
	H LDI R15, %hi(.LBB8_2)
	SLT ADI R15, %lo(.LBB8_2)
	BRH C, R15
; %bb.1:
	LDI R5, 0
	H LDI R5, nvmDevs
	SLT ADI R5, nvmDevs
	INT LOD R5, R5, 0
	LDI R8, 0
	SUB R5, R8, R0
	H LDI R15, %hi(.LBB8_2)
	SLT ADI R15, %lo(.LBB8_2)
	BRH EQ, R15
; %bb.3:
	LDI R6, 40
	MUL R1, R6, R1
	ADD R5, R1, R1
	INT LOD R1, R6, 16
	;APP
	CYE SR8, R5
	;NO_APP
	;APP
	CYE SR8, R9
	;NO_APP
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -5
	AND R9, R7, R9
	;APP
	CYR R9, SR8
	;NO_APP
	LDI R9, 3
	LSH R6, R9, R9
	INT LOD R1, R10, 8
	ADD R10, R9, R9
	LDI R10, 0
	H LDI R10, 0
	SLT ADI R10, -1
	INT STR R9, R10, 0
	LDI R9, 4
	LSH R6, R9, R10
	INT LOD R1, R11, 4
	ADD R11, R10, R10
	CHAR STR R1, R8, 12
	INT STR R10, R4, 4
	INT STR R10, R2, 8
	INT STR R10, R3, 12
	INT STR R10, R6, 0
	LDI R2, 1
	INT LOD R1, R3, 0
	CHAR STR R3, R2, 12
	CHAR LOD R1, R3, 12
	SUB R3, R8, R0
	H LDI R15, %hi(.LBB8_5)
	SLT ADI R15, %lo(.LBB8_5)
	BRH NE, R15
.LBB8_4:                                ; =>This Inner Loop Header: Depth=1
	;APP
	CYE SR8, R3
	;NO_APP
	NOR R3, R9, R3
	NOR R3, R3, R3
	;APP
	CYR R3, SR8
	;NO_APP
	;APP
	HLT
	;NO_APP
	;APP
	CYE SR8, R3
	;NO_APP
	AND R3, R7, R3
	;APP
	CYR R3, SR8
	;NO_APP
	CHAR LOD R1, R3, 12
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB8_4)
	SLT ADI R15, %lo(.LBB8_4)
	BRH NE, R15
.LBB8_5:
	ADI R6, 1
	LDI R2, 127
	AND R6, R2, R2
	INT STR R1, R2, 16
	;APP
	CYR R5, SR8
	;NO_APP
	LDI R1, 0
	H LDI R15, %hi(.LBB8_6)
	SLT ADI R15, %lo(.LBB8_6)
	JMP R15
.LBB8_2:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.3.9
	SLT ADI R1, .L.str.3.9
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 2
.LBB8_6:
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -20
	RET
.Lfunc_end8:
	.size	nvm_read_sectors, .Lfunc_end8-nvm_read_sectors
                                        ; -- End function
	.globl	nvm_write_sectors               ; -- Begin function nvm_write_sectors
	.type	nvm_write_sectors,@function
nvm_write_sectors:                      ; @nvm_write_sectors
; %bb.0:
	SLT ADI R14, 20
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	LDI R5, 0
	H LDI R5, Globals
	SLT ADI R5, Globals
	INT LOD R5, R5, 0
	INT LOD R5, R5, 12
	SUB R5, R1, R0
	H LDI R15, %hi(.LBB9_2)
	SLT ADI R15, %lo(.LBB9_2)
	BRH C, R15
; %bb.1:
	LDI R5, 0
	H LDI R5, nvmDevs
	SLT ADI R5, nvmDevs
	INT LOD R5, R5, 0
	LDI R8, 0
	SUB R5, R8, R0
	H LDI R15, %hi(.LBB9_2)
	SLT ADI R15, %lo(.LBB9_2)
	BRH EQ, R15
; %bb.3:
	LDI R6, 40
	MUL R1, R6, R1
	ADD R5, R1, R1
	INT LOD R1, R6, 16
	;APP
	CYE SR8, R5
	;NO_APP
	;APP
	CYE SR8, R9
	;NO_APP
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -5
	AND R9, R7, R9
	;APP
	CYR R9, SR8
	;NO_APP
	LDI R9, 3
	LSH R6, R9, R9
	INT LOD R1, R10, 8
	ADD R10, R9, R9
	LDI R10, 0
	H LDI R10, 0
	SLT ADI R10, -1
	INT STR R9, R10, 0
	LDI R9, 4
	LSH R6, R9, R10
	INT LOD R1, R11, 4
	ADD R11, R10, R10
	CHAR STR R1, R8, 12
	INT STR R10, R4, 4
	INT STR R10, R2, 8
	INT STR R10, R3, 12
	LDI R2, 0
	H LDI R2, 256
	SLT ADI R2, 0
	NOR R6, R2, R2
	NOR R2, R2, R2
	INT STR R10, R2, 0
	LDI R2, 1
	INT LOD R1, R3, 0
	CHAR STR R3, R2, 12
	CHAR LOD R1, R3, 12
	SUB R3, R8, R0
	H LDI R15, %hi(.LBB9_5)
	SLT ADI R15, %lo(.LBB9_5)
	BRH NE, R15
.LBB9_4:                                ; =>This Inner Loop Header: Depth=1
	;APP
	CYE SR8, R3
	;NO_APP
	NOR R3, R9, R3
	NOR R3, R3, R3
	;APP
	CYR R3, SR8
	;NO_APP
	;APP
	HLT
	;NO_APP
	;APP
	CYE SR8, R3
	;NO_APP
	AND R3, R7, R3
	;APP
	CYR R3, SR8
	;NO_APP
	CHAR LOD R1, R3, 12
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB9_4)
	SLT ADI R15, %lo(.LBB9_4)
	BRH NE, R15
.LBB9_5:
	ADI R6, 1
	LDI R2, 127
	AND R6, R2, R2
	INT STR R1, R2, 16
	;APP
	CYR R5, SR8
	;NO_APP
	LDI R1, 0
	H LDI R15, %hi(.LBB9_6)
	SLT ADI R15, %lo(.LBB9_6)
	JMP R15
.LBB9_2:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.3.9
	SLT ADI R1, .L.str.3.9
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 2
.LBB9_6:
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -20
	RET
.Lfunc_end9:
	.size	nvm_write_sectors, .Lfunc_end9-nvm_write_sectors
                                        ; -- End function
	.globl	displaySearch                   ; -- Begin function displaySearch
	.type	displaySearch,@function
displaySearch:                          ; @displaySearch
; %bb.0:
	SLT ADI R14, 32
	INT STR R14, R8, -8
	INT STR R14, R9, -12
	INT STR R14, R10, -16
	INT STR R14, R11, -20
	INT STR R14, R12, -24
	INT STR R14, R13, -28
	LDI R1, 0
	H LDI R1, 7
	SLT ADI R1, 0
	H LDI R15, %hi(searchFirst)
	SLT ADI R15, %lo(searchFirst)
	CAL R15
	SLT ADD R1, R0, R8
	LDI R10, 0
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB10_4)
	SLT ADI R15, %lo(.LBB10_4)
	BRH N, R15
; %bb.1:
	LDI R1, 20
	MUL R8, R1, R1
	LDI R2, 0
	H LDI R2, mapa
	SLT ADI R2, mapa
	INT LOD R2, R2, 0
	ADD R2, R1, R1
	CHAR LOD R1, R11, 16
	CHAR LOD R1, R13, 17
	CHAR LOD R1, R12, 18
	LDI R1, 4
	LDI R2, 16
	LDI R3, 0
	H LDI R3, current_display
	SLT ADI R3, current_display
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB10_5)
	SLT ADI R15, %lo(.LBB10_5)
	BRH NE, R15
; %bb.2:
	ADD R14, R0, R9
	SLT ADI R9, -4
	LDI R1, 5
	LDI R2, 831
	SLT ADD R9, R0, R3
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB10_5)
	SLT ADI R15, %lo(.LBB10_5)
	BRH NE, R15
; %bb.3:
	INT LOD R9, R1, 0
	ADI R1, 63
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -64
	AND R1, R2, R1
	LDI R2, 0
	H LDI R2, display_queue
	SLT ADI R2, display_queue
	INT STR R2, R1, 0
	LDI R2, 20
	LSH R11, R2, R2
	LDI R3, 15
	LSH R13, R3, R3
	NOR R3, R2, R2
	LDI R3, 12
	LSH R12, R3, R3
	CHAR STR R1, R10, 64
	CHAR STR R1, R10, 65
	CHAR STR R1, R10, 66
	LDI R11, 0
	H LDI R11, current_display
	SLT ADI R11, current_display
	INT LOD R11, R1, 0
	CHAR STR R1, R10, 12
	NOR R2, R2, R2
	NOR R2, R3, R2
	NOR R2, R2, R2
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 4
	NOR R2, R3, R3
	NOR R3, R3, R3
	LDI R4, 3
	INT STR R3, R4, 0
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 16
	NOR R2, R3, R3
	NOR R3, R3, R3
	INT LOD R3, R3, 0
	INT STR R1, R3, 4
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 0
	NOR R2, R1, R1
	NOR R1, R1, R9
	LDI R2, 127
	SLT ADD R9, R0, R1
	LDI R3, 0
	H LDI R3, tty_IRQHandler
	SLT ADI R3, tty_IRQHandler
	H LDI R15, %hi(initMSI)
	SLT ADI R15, %lo(initMSI)
	CAL R15
	INT LOD R11, R1, 0
	LDI R2, 0
	H LDI R2, ttyWrite
	SLT ADI R2, ttyWrite
	INT STR R1, R2, 0
	INT STR R1, R9, 8
.LBB10_4:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	XOR R8, R1, R1
	LDI R2, 31
	RSH R1, R2, R1
	INT LOD R14, R13, -28
	INT LOD R14, R12, -24
	INT LOD R14, R11, -20
	INT LOD R14, R10, -16
	INT LOD R14, R9, -12
	INT LOD R14, R8, -8
	SLT ADI R14, -32
	RET
.LBB10_5:
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.Lfunc_end10:
	.size	displaySearch, .Lfunc_end10-displaySearch
                                        ; -- End function
	.type	tty_IRQHandler,@function        ; -- Begin function tty_IRQHandler
tty_IRQHandler:                         ; @tty_IRQHandler
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
	SLT ADD R2, R0, R1
	LDI R2, 0
	H LDI R2, display_queue
	SLT ADI R2, display_queue
	INT LOD R2, R2, 0
	SLT ADD R2, R0, R3
	ADI R3, 64
	CHAR LOD R3, R3, 0
	ADI R3, 1
	LDI R4, 3
	AND R3, R4, R3
	CHAR STR R2, R3, 64
	SLT ADD R2, R0, R3
	ADI R3, 66
	CHAR LOD R3, R3, 0
	ADI R3, -1
	CHAR STR R2, R3, 66
	CHAR LOD R2, R4, 66
	LDI R3, 0
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB11_1)
	SLT ADI R15, %lo(.LBB11_1)
	BRH NE, R15
; %bb.2:
	LDI R2, 0
	H LDI R2, current_display
	SLT ADI R2, current_display
	INT LOD R2, R2, 0
	CHAR STR R2, R3, 12
.LBB11_3:
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.LBB11_1:
	CHAR LOD R2, R3, 64
	LDI R4, 4
	LSH R3, R4, R3
	ADD R2, R3, R2
	SLT ADD R1, R0, R8
	SLT ADD R2, R0, R1
	H LDI R15, %hi(tty_execute_request)
	SLT ADI R15, %lo(tty_execute_request)
	CAL R15
	SLT ADD R8, R0, R1
	H LDI R15, %hi(.LBB11_3)
	SLT ADI R15, %lo(.LBB11_3)
	JMP R15
.Lfunc_end11:
	.size	tty_IRQHandler, .Lfunc_end11-tty_IRQHandler
                                        ; -- End function
	.type	ttyWrite,@function              ; -- Begin function ttyWrite
ttyWrite:                               ; @ttyWrite
; %bb.0:
	SLT ADI R14, 64
	INT STR R14, R8, -40
	INT STR R14, R9, -44
	INT STR R14, R10, -48
	INT STR R14, R11, -52
	INT STR R14, R12, -56
	INT STR R14, R13, -60
	SLT ADD R3, R0, R7
	SLT ADD R2, R0, R6
	SLT ADD R1, R0, R12
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	CHAR LOD R1, R1, 4
	LDI R2, 1
	INT STR R14, R6, -12
	INT STR R14, R7, -8
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB12_1)
	SLT ADI R15, %lo(.LBB12_1)
	BRH EQ, R15
; %bb.5:
	LDI R1, 0
	LDI R13, 3
	SLT ADD R2, R0, R3
	SUB R6, R13, R0
	H LDI R15, %hi(.LBB12_7)
	SLT ADI R15, %lo(.LBB12_7)
	BRH NE, R15
; %bb.6:
	SLT ADD R1, R0, R3
.LBB12_7:
	SUB R2, R7, R0
	H LDI R15, %hi(.LBB12_9)
	SLT ADI R15, %lo(.LBB12_9)
	BRH N, R15
; %bb.8:
	SLT ADD R1, R0, R2
.LBB12_9:
	AND R3, R2, R2
	LDI R3, 2
	RSH R6, R3, R3
	NOR R3, R2, R2
	NOR R2, R2, R2
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB12_10)
	SLT ADI R15, %lo(.LBB12_10)
	BRH EQ, R15
; %bb.20:
	ADD R14, R0, R1
	SLT ADI R1, -36
	INT STR R14, R1, -4
	INT STR R1, R12, 0
	LDI R4, 0
	LDI R1, 1
	LDI R5, 4
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB12_22)
	SLT ADI R15, %lo(.LBB12_22)
	BRH EQ, R15
; %bb.21:
	SLT ADD R4, R0, R1
.LBB12_22:
	LDI R3, 0
	H LDI R3, 65520
	SLT ADI R3, -1
	LDI R2, 1
	SUB R3, R12, R0
	H LDI R15, %hi(.LBB12_24)
	SLT ADI R15, %lo(.LBB12_24)
	BRH C, R15
; %bb.23:
	SLT ADD R4, R0, R2
.LBB12_24:
	AND R2, R1, R1
	LDI R8, 0
	H LDI R8, display_queue
	SLT ADI R8, display_queue
	LDI R2, 1
	AND R1, R2, R1
	INT STR R14, R1, -16
	SLT ADD R4, R0, R1
	H LDI R15, %hi(.LBB12_25)
	SLT ADI R15, %lo(.LBB12_25)
	JMP R15
.LBB12_33:                              ;   in Loop: Header=BB12_25 Depth=1
	INT LOD R4, R3, 12
	INT STR R2, R3, 8
	LDI R3, 2
.LBB12_36:                              ;   in Loop: Header=BB12_25 Depth=1
	INT STR R2, R3, 0
	LDI R4, 0
	LDI R5, 4
.LBB12_37:                              ;   in Loop: Header=BB12_25 Depth=1
	INT LOD R14, R2, -20
	;APP
	CYR R2, SR8
	;NO_APP
	LDI R3, 1
	AND R1, R3, R2
	SLT ADD R3, R0, R1
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB12_38)
	SLT ADI R15, %lo(.LBB12_38)
	BRH EQ, R15
.LBB12_25:                              ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB12_26 Depth 2
	INT LOD R8, R2, 0
	CHAR LOD R2, R2, 66
	SUB R2, R5, R0
	H LDI R15, %hi(.LBB12_27)
	SLT ADI R15, %lo(.LBB12_27)
	BRH C, R15
.LBB12_26:                              ;   Parent Loop BB12_25 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	;APP
	HLT
	;NO_APP
	INT LOD R8, R2, 0
	CHAR LOD R2, R2, 66
	SUB R13, R2, R0
	H LDI R15, %hi(.LBB12_26)
	SLT ADI R15, %lo(.LBB12_26)
	BRH C, R15
.LBB12_27:                              ;   in Loop: Header=BB12_25 Depth=1
	;APP
	CYE SR8, R2
	;NO_APP
	INT STR R14, R2, -20
	;APP
	CYE SR8, R2
	;NO_APP
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -5
	AND R2, R3, R2
	;APP
	CYR R2, SR8
	;NO_APP
	INT LOD R8, R11, 0
	CHAR LOD R11, R9, 65
	SLT ADD R12, R0, R10
	INT LOD R14, R2, -16
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB12_29)
	SLT ADI R15, %lo(.LBB12_29)
	BRH EQ, R15
; %bb.28:                               ;   in Loop: Header=BB12_25 Depth=1
	LDI R1, 7
	LSH R9, R1, R1
	ADD R11, R1, R12
	ADI R12, 128
	SLT ADD R12, R0, R1
	INT LOD R14, R2, -4
	H LDI R15, %hi(copy_to_bounce)
	SLT ADI R15, %lo(copy_to_bounce)
	CAL R15
	LDI R5, 4
	LDI R4, 0
	INT LOD R14, R7, -8
	INT LOD R14, R6, -12
	LDI R2, 1
	XOR R1, R2, R1
.LBB12_29:                              ;   in Loop: Header=BB12_25 Depth=1
	LSH R9, R5, R2
	ADD R11, R2, R2
	INT STR R2, R12, 0
	CHAR LOD R12, R3, 0
	INT STR R2, R7, 12
	INT STR R2, R6, 8
	CHAR STR R2, R3, 4
	ADI R9, 1
	AND R9, R13, R2
	CHAR STR R11, R2, 65
	SLT ADD R11, R0, R2
	ADI R2, 66
	CHAR LOD R2, R2, 0
	ADI R2, 1
	CHAR STR R11, R2, 66
	LDI R2, 0
	H LDI R2, current_display
	SLT ADI R2, current_display
	INT LOD R2, R2, 0
	CHAR LOD R2, R3, 12
	SLT ADD R10, R0, R12
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB12_37)
	SLT ADI R15, %lo(.LBB12_37)
	BRH NE, R15
; %bb.30:                               ;   in Loop: Header=BB12_25 Depth=1
	LDI R3, 1
	CHAR STR R2, R3, 12
	CHAR LOD R11, R3, 64
	LSH R3, R5, R3
	ADD R11, R3, R4
	INT LOD R2, R2, 4
	INT LOD R4, R3, 8
	SLT ADD R3, R0, R5
	ADI R5, -1
	SUB R13, R5, R0
	H LDI R15, %hi(.LBB12_35)
	SLT ADI R15, %lo(.LBB12_35)
	BRH C, R15
; %bb.31:                               ;   in Loop: Header=BB12_25 Depth=1
	LDI R9, 2
	LSH R5, R9, R5
	LDI R9, 0
	H LDI R9, .LJTI12_0
	SLT ADI R9, .LJTI12_0
	ADD R9, R5, R5
	INT LOD R5, R5, 0
	JMP R5
.LBB12_32:                              ;   in Loop: Header=BB12_25 Depth=1
	INT LOD R4, R3, 12
	INT STR R2, R3, 8
	CHAR LOD R4, R3, 4
	INT STR R2, R3, 4
	LDI R3, 1
	H LDI R15, %hi(.LBB12_36)
	SLT ADI R15, %lo(.LBB12_36)
	JMP R15
.LBB12_34:                              ;   in Loop: Header=BB12_25 Depth=1
	INT LOD R4, R3, 0
	INT STR R2, R3, 4
	LDI R3, 4
	H LDI R15, %hi(.LBB12_36)
	SLT ADI R15, %lo(.LBB12_36)
	JMP R15
.LBB12_35:                              ;   in Loop: Header=BB12_25 Depth=1
	LDI R3, 0
	H LDI R15, %hi(.LBB12_36)
	SLT ADI R15, %lo(.LBB12_36)
	JMP R15
.LBB12_10:
	LDI R2, 0
	H LDI R2, current_display
	SLT ADI R2, current_display
	INT LOD R2, R1, 0
	CHAR LOD R1, R1, 12
	LDI R3, 1
	SUB R1, R3, R0
	H LDI R15, %hi(.LBB12_13)
	SLT ADI R15, %lo(.LBB12_13)
	BRH NE, R15
; %bb.11:                               ; %.preheader
	LDI R1, 0
.LBB12_12:                              ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	INT LOD R2, R3, 0
	CHAR LOD R3, R3, 12
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB12_12)
	SLT ADI R15, %lo(.LBB12_12)
	BRH NE, R15
.LBB12_13:
	;APP
	CYE SR8, R1
	;NO_APP
	;APP
	CYE SR8, R3
	;NO_APP
	LDI R4, 0
	H LDI R4, 0
	SLT ADI R4, -5
	AND R3, R4, R3
	;APP
	CYR R3, SR8
	;NO_APP
	INT LOD R2, R2, 0
	INT LOD R2, R2, 4
	SLT ADD R6, R0, R3
	ADI R3, -1
	SUB R13, R3, R0
	H LDI R15, %hi(.LBB12_18)
	SLT ADI R15, %lo(.LBB12_18)
	BRH C, R15
; %bb.14:
	LDI R4, 2
	LSH R3, R4, R3
	LDI R4, 0
	H LDI R4, .LJTI12_1
	SLT ADI R4, .LJTI12_1
	ADD R4, R3, R3
	INT LOD R3, R3, 0
	JMP R3
.LBB12_15:
	CHAR LOD R12, R3, 0
	INT STR R2, R7, 8
	INT STR R2, R3, 4
	LDI R6, 1
	H LDI R15, %hi(.LBB12_19)
	SLT ADI R15, %lo(.LBB12_19)
	JMP R15
.LBB12_16:
	INT STR R2, R7, 8
	LDI R6, 2
	H LDI R15, %hi(.LBB12_19)
	SLT ADI R15, %lo(.LBB12_19)
	JMP R15
.LBB12_17:
	INT STR R2, R12, 4
	LDI R6, 4
	H LDI R15, %hi(.LBB12_19)
	SLT ADI R15, %lo(.LBB12_19)
	JMP R15
.LBB12_18:
	LDI R6, 0
.LBB12_19:
	INT STR R2, R6, 0
	;APP
	CYR R1, SR8
	;NO_APP
.LBB12_38:
	INT LOD R14, R13, -60
	INT LOD R14, R12, -56
	INT LOD R14, R11, -52
	INT LOD R14, R10, -48
	INT LOD R14, R9, -44
	INT LOD R14, R8, -40
	SLT ADI R14, -64
	RET
.LBB12_1:
	LDI R1, 0
	H LDI R1, 65520
	SLT ADI R1, 0
	SLT ADD R12, R0, R11
	SUB R12, R1, R0
	H LDI R15, %hi(.LBB12_4)
	SLT ADI R15, %lo(.LBB12_4)
	BRH C, R15
; %bb.2:
	LDI R1, 4
	SLT ADD R12, R0, R11
	SUB R6, R1, R0
	H LDI R15, %hi(.LBB12_4)
	SLT ADI R15, %lo(.LBB12_4)
	BRH NE, R15
; %bb.3:
	ADD R14, R0, R2
	SLT ADI R2, -36
	INT STR R2, R12, 0
	LDI R1, 0
	H LDI R1, display_queue
	SLT ADI R1, display_queue
	INT LOD R1, R11, 0
	ADI R11, 640
	SLT ADD R11, R0, R1
	H LDI R15, %hi(copy_to_bounce)
	SLT ADI R15, %lo(copy_to_bounce)
	CAL R15
	INT LOD R14, R7, -8
	INT LOD R14, R6, -12
.LBB12_4:
	ADD R14, R0, R1
	SLT ADI R1, -36
	INT STR R1, R11, 0
	CHAR LOD R12, R2, 0
	CHAR STR R1, R2, 4
	LDI R2, 0
	CHAR STR R1, R2, 5
	CHAR STR R1, R2, 6
	CHAR STR R1, R2, 7
	INT STR R1, R7, 12
	INT STR R1, R6, 8
	H LDI R15, %hi(tty_execute_request)
	SLT ADI R15, %lo(tty_execute_request)
	CAL R15
	H LDI R15, %hi(.LBB12_38)
	SLT ADI R15, %lo(.LBB12_38)
	JMP R15
.Lfunc_end12:
	.size	ttyWrite, .Lfunc_end12-ttyWrite
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
	.type	.LJTI12_0,@object
.LJTI12_0:
	.long	.LBB12_32
	.long	.LBB12_33
	.long	.LBB12_36
	.long	.LBB12_34
	.size	.LJTI12_0, 16
	.type	.LJTI12_1,@object
.LJTI12_1:
	.long	.LBB12_15
	.long	.LBB12_16
	.long	.LBB12_19
	.long	.LBB12_17
	.size	.LJTI12_1, 16
                                        ; -- End function
	.text
	.type	copy_to_bounce,@function        ; -- Begin function copy_to_bounce
copy_to_bounce:                         ; @copy_to_bounce
; %bb.0:
	SLT ADI R14, 4
	INT LOD R2, R3, 0
	INT LOD R3, R5, 0
	INT STR R1, R5, 0
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	BRH NE, R15
; %bb.1:
	INT LOD R3, R6, 4
	INT STR R1, R6, 4
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB13_2)
	SLT ADI R15, %lo(.LBB13_2)
	BRH NE, R15
; %bb.3:
	INT LOD R3, R5, 8
	INT STR R1, R5, 8
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB13_4)
	SLT ADI R15, %lo(.LBB13_4)
	BRH NE, R15
; %bb.5:
	INT LOD R3, R6, 12
	INT STR R1, R6, 12
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB13_6)
	SLT ADI R15, %lo(.LBB13_6)
	BRH NE, R15
; %bb.7:
	INT LOD R3, R5, 16
	INT STR R1, R5, 16
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB13_8)
	SLT ADI R15, %lo(.LBB13_8)
	BRH NE, R15
; %bb.9:
	INT LOD R3, R6, 20
	INT STR R1, R6, 20
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB13_10)
	SLT ADI R15, %lo(.LBB13_10)
	BRH NE, R15
; %bb.11:
	INT LOD R3, R5, 24
	INT STR R1, R5, 24
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB13_12)
	SLT ADI R15, %lo(.LBB13_12)
	BRH NE, R15
; %bb.13:
	INT LOD R3, R6, 28
	INT STR R1, R6, 28
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB13_14)
	SLT ADI R15, %lo(.LBB13_14)
	BRH NE, R15
; %bb.15:
	INT LOD R3, R5, 32
	INT STR R1, R5, 32
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB13_16)
	SLT ADI R15, %lo(.LBB13_16)
	BRH NE, R15
; %bb.17:
	INT LOD R3, R6, 36
	INT STR R1, R6, 36
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB13_18)
	SLT ADI R15, %lo(.LBB13_18)
	BRH NE, R15
; %bb.19:
	INT LOD R3, R5, 40
	INT STR R1, R5, 40
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB13_20)
	SLT ADI R15, %lo(.LBB13_20)
	BRH NE, R15
; %bb.21:
	INT LOD R3, R6, 44
	INT STR R1, R6, 44
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB13_22)
	SLT ADI R15, %lo(.LBB13_22)
	BRH NE, R15
; %bb.23:
	INT LOD R3, R5, 48
	INT STR R1, R5, 48
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB13_24)
	SLT ADI R15, %lo(.LBB13_24)
	BRH NE, R15
; %bb.25:
	INT LOD R3, R6, 52
	INT STR R1, R6, 52
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB13_26)
	SLT ADI R15, %lo(.LBB13_26)
	BRH NE, R15
; %bb.27:
	INT LOD R3, R5, 56
	INT STR R1, R5, 56
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB13_28)
	SLT ADI R15, %lo(.LBB13_28)
	BRH NE, R15
; %bb.29:
	INT LOD R3, R6, 60
	INT STR R1, R6, 60
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB13_30)
	SLT ADI R15, %lo(.LBB13_30)
	BRH NE, R15
; %bb.31:
	INT LOD R3, R5, 64
	INT STR R1, R5, 64
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB13_32)
	SLT ADI R15, %lo(.LBB13_32)
	BRH NE, R15
; %bb.33:
	INT LOD R3, R6, 68
	INT STR R1, R6, 68
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB13_34)
	SLT ADI R15, %lo(.LBB13_34)
	BRH NE, R15
; %bb.35:
	INT LOD R3, R5, 72
	INT STR R1, R5, 72
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB13_36)
	SLT ADI R15, %lo(.LBB13_36)
	BRH NE, R15
; %bb.37:
	INT LOD R3, R6, 76
	INT STR R1, R6, 76
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB13_38)
	SLT ADI R15, %lo(.LBB13_38)
	BRH NE, R15
; %bb.39:
	INT LOD R3, R5, 80
	INT STR R1, R5, 80
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB13_40)
	SLT ADI R15, %lo(.LBB13_40)
	BRH NE, R15
; %bb.41:
	INT LOD R3, R6, 84
	INT STR R1, R6, 84
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB13_42)
	SLT ADI R15, %lo(.LBB13_42)
	BRH NE, R15
; %bb.43:
	INT LOD R3, R5, 88
	INT STR R1, R5, 88
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB13_44)
	SLT ADI R15, %lo(.LBB13_44)
	BRH NE, R15
; %bb.45:
	INT LOD R3, R6, 92
	INT STR R1, R6, 92
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB13_46)
	SLT ADI R15, %lo(.LBB13_46)
	BRH NE, R15
; %bb.47:
	INT LOD R3, R5, 96
	INT STR R1, R5, 96
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB13_48)
	SLT ADI R15, %lo(.LBB13_48)
	BRH NE, R15
; %bb.49:
	INT LOD R3, R6, 100
	INT STR R1, R6, 100
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB13_50)
	SLT ADI R15, %lo(.LBB13_50)
	BRH NE, R15
; %bb.51:
	INT LOD R3, R5, 104
	INT STR R1, R5, 104
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB13_52)
	SLT ADI R15, %lo(.LBB13_52)
	BRH NE, R15
; %bb.53:
	INT LOD R3, R6, 108
	INT STR R1, R6, 108
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB13_54)
	SLT ADI R15, %lo(.LBB13_54)
	BRH NE, R15
; %bb.55:
	INT LOD R3, R5, 112
	INT STR R1, R5, 112
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	SUB R4, R5, R6
	NOR R6, R5, R5
	NOR R5, R5, R6
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB13_56)
	SLT ADI R15, %lo(.LBB13_56)
	BRH NE, R15
; %bb.57:
	INT LOD R3, R6, 116
	INT STR R1, R6, 116
	SUB R4, R6, R4
	NOR R4, R6, R4
	NOR R4, R4, R4
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB13_58)
	SLT ADI R15, %lo(.LBB13_58)
	BRH NE, R15
; %bb.59:
	INT LOD R3, R4, 120
	INT STR R1, R4, 120
	LDI R5, 0
	H LDI R5, 257
	SLT ADI R5, 256
	SUB R5, R4, R5
	NOR R5, R4, R4
	NOR R4, R4, R4
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
	AND R4, R5, R4
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB13_60)
	SLT ADI R15, %lo(.LBB13_60)
	BRH NE, R15
; %bb.63:
	LDI R4, 0
	INT STR R1, R4, 124
	SLT ADD R4, R0, R1
	ADI R3, 124
	INT STR R2, R3, 0
	H LDI R15, %hi(.LBB13_62)
	SLT ADI R15, %lo(.LBB13_62)
	JMP R15
.LBB13_2:
	ADI R1, 4
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_4:
	ADI R1, 8
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_6:
	ADI R1, 12
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_8:
	ADI R1, 16
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_10:
	ADI R1, 20
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_12:
	ADI R1, 24
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_14:
	ADI R1, 28
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_16:
	ADI R1, 32
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_18:
	ADI R1, 36
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_20:
	ADI R1, 40
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_22:
	ADI R1, 44
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_24:
	ADI R1, 48
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_26:
	ADI R1, 52
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_28:
	ADI R1, 56
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_30:
	ADI R1, 60
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_32:
	ADI R1, 64
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_34:
	ADI R1, 68
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_36:
	ADI R1, 72
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_38:
	ADI R1, 76
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_40:
	ADI R1, 80
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_42:
	ADI R1, 84
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_44:
	ADI R1, 88
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_46:
	ADI R1, 92
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_48:
	ADI R1, 96
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_50:
	ADI R1, 100
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_52:
	ADI R1, 104
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_54:
	ADI R1, 108
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_56:
	ADI R1, 112
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_58:
	ADI R1, 116
	H LDI R15, %hi(.LBB13_61)
	SLT ADI R15, %lo(.LBB13_61)
	JMP R15
.LBB13_60:
	ADI R1, 120
.LBB13_61:
	LDI R2, 0
	INT STR R1, R2, 4
	LDI R1, 1
.LBB13_62:
	SLT ADI R14, -4
	RET
.Lfunc_end13:
	.size	copy_to_bounce, .Lfunc_end13-copy_to_bounce
                                        ; -- End function
	.type	tty_execute_request,@function   ; -- Begin function tty_execute_request
tty_execute_request:                    ; @tty_execute_request
; %bb.0:
	SLT ADI R14, 4
	LDI R2, 0
	H LDI R2, current_display
	SLT ADI R2, current_display
	INT LOD R2, R2, 0
	INT LOD R2, R2, 4
	INT LOD R1, R3, 8
	SLT ADD R3, R0, R4
	ADI R4, -1
	LDI R5, 3
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB14_5)
	SLT ADI R15, %lo(.LBB14_5)
	BRH C, R15
; %bb.1:
	LDI R5, 2
	LSH R4, R5, R4
	LDI R5, 0
	H LDI R5, .LJTI14_0
	SLT ADI R5, .LJTI14_0
	ADD R5, R4, R4
	INT LOD R4, R4, 0
	JMP R4
.LBB14_2:
	INT LOD R1, R3, 12
	INT STR R2, R3, 8
	CHAR LOD R1, R1, 4
	INT STR R2, R1, 4
	LDI R3, 1
	H LDI R15, %hi(.LBB14_6)
	SLT ADI R15, %lo(.LBB14_6)
	JMP R15
.LBB14_3:
	INT LOD R1, R1, 12
	INT STR R2, R1, 8
	LDI R3, 2
	H LDI R15, %hi(.LBB14_6)
	SLT ADI R15, %lo(.LBB14_6)
	JMP R15
.LBB14_4:
	INT LOD R1, R1, 0
	INT STR R2, R1, 4
	LDI R3, 4
	H LDI R15, %hi(.LBB14_6)
	SLT ADI R15, %lo(.LBB14_6)
	JMP R15
.LBB14_5:
	LDI R3, 0
.LBB14_6:
	INT STR R2, R3, 0
	SLT ADI R14, -4
	RET
.Lfunc_end14:
	.size	tty_execute_request, .Lfunc_end14-tty_execute_request
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
	.type	.LJTI14_0,@object
.LJTI14_0:
	.long	.LBB14_2
	.long	.LBB14_3
	.long	.LBB14_6
	.long	.LBB14_4
	.size	.LJTI14_0, 16
                                        ; -- End function
	.text
	.globl	biosClear                       ; -- Begin function biosClear
	.type	biosClear,@function
biosClear:                              ; @biosClear
; %bb.0:
	SLT ADI R14, 4
	LDI R1, 0
	H LDI R1, current_display
	SLT ADI R1, current_display
	INT LOD R1, R1, 0
	INT LOD R1, R4, 0
	LDI R2, 3
	LDI R1, 0
	SLT ADD R1, R0, R3
	CAL R4
	SLT ADI R14, -4
	RET
.Lfunc_end15:
	.size	biosClear, .Lfunc_end15-biosClear
                                        ; -- End function
	.globl	biosWrite                       ; -- Begin function biosWrite
	.type	biosWrite,@function
biosWrite:                              ; @biosWrite
; %bb.0:
	SLT ADI R14, 4
	CHAR LOD R1, R4, 0
	LDI R3, 1
	LDI R5, 8
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB16_1)
	SLT ADI R15, %lo(.LBB16_1)
	BRH EQ, R15
; %bb.2:
	SLT ADD R3, R0, R4
	H LDI R15, %hi(.LBB16_3)
	SLT ADI R15, %lo(.LBB16_3)
	JMP R15
.LBB16_1:
	LDI R4, 2
.LBB16_3:
	CHAR LOD R1, R6, 1
	LDI R5, 0
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_5)
	SLT ADI R15, %lo(.LBB16_5)
	BRH EQ, R15
; %bb.4:
	LDI R4, 4
.LBB16_5:
	NOR R2, R6, R6
	NOR R6, R6, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_7)
	SLT ADI R15, %lo(.LBB16_7)
	BRH EQ, R15
; %bb.6:
	SLT ADD R5, R0, R3
.LBB16_7:
	ADD R2, R3, R3
	LDI R2, 0
	H LDI R2, current_display
	SLT ADI R2, current_display
	INT LOD R2, R2, 0
	INT LOD R2, R5, 0
	SLT ADD R4, R0, R2
	CAL R5
	SLT ADI R14, -4
	RET
.Lfunc_end16:
	.size	biosWrite, .Lfunc_end16-biosWrite
                                        ; -- End function
	.globl	bus_Enumeration                 ; -- Begin function bus_Enumeration
	.type	bus_Enumeration,@function
bus_Enumeration:                        ; @bus_Enumeration
; %bb.0:
	SLT ADI R14, 48
	INT STR R14, R8, -24
	INT STR R14, R9, -28
	INT STR R14, R10, -32
	INT STR R14, R11, -36
	INT STR R14, R12, -40
	INT STR R14, R13, -44
	INT STR R14, R3, -20
	SLT ADD R2, R0, R6
	SLT ADD R1, R0, R5
	LDI R9, 255
	SUB R9, R5, R0
	H LDI R15, %hi(.LBB17_1)
	SLT ADI R15, %lo(.LBB17_1)
	BRH NC, R15
.LBB17_57:
	INT LOD R14, R13, -44
	INT LOD R14, R12, -40
	INT LOD R14, R11, -36
	INT LOD R14, R10, -32
	INT LOD R14, R9, -28
	INT LOD R14, R8, -24
	SLT ADI R14, -48
	RET
.LBB17_1:
	LDI R12, 1
	LDI R4, 0
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB17_3)
	SLT ADI R15, %lo(.LBB17_3)
	BRH EQ, R15
; %bb.2:
	SLT ADD R4, R0, R12
.LBB17_3:
	LDI R1, 20
	LSH R5, R1, R2
	LDI R1, 15
	LSH R12, R1, R1
	INT STR R14, R2, -16
	NOR R2, R1, R1
	NOR R1, R1, R1
	LDI R2, 4096
	NOR R1, R2, R1
	NOR R1, R1, R11
	LDI R10, 0
	H LDI R10, 57344
	SLT ADI R10, 0
	INT LOD R14, R1, -20
	INT STR R14, R6, -8
	INT STR R14, R5, -4
	H LDI R15, %hi(.LBB17_4)
	SLT ADI R15, %lo(.LBB17_4)
	JMP R15
.LBB17_21:                              ;   in Loop: Header=BB17_4 Depth=1
	LDI R4, 0
.LBB17_22:                              ;   in Loop: Header=BB17_4 Depth=1
	LDI R10, 0
	H LDI R10, 57344
	SLT ADI R10, 0
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB17_23)
	SLT ADI R15, %lo(.LBB17_23)
	BRH EQ, R15
.LBB17_56:                              ;   in Loop: Header=BB17_4 Depth=1
	LDI R1, 0
	H LDI R1, 1
	SLT ADI R1, -32768
	ADD R11, R1, R11
	ADI R12, 1
	LDI R1, 32
	SUB R12, R1, R0
	H LDI R15, %hi(.LBB17_57)
	SLT ADI R15, %lo(.LBB17_57)
	BRH EQ, R15
.LBB17_4:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB17_17 Depth 2
	LDI R1, 15
	LSH R12, R1, R1
	INT LOD R14, R2, -16
	ADD R1, R2, R13
	NOR R13, R10, R1
	NOR R1, R1, R1
	INT LOD R1, R1, 0
	LDI R2, 0
	H LDI R2, 1
	SLT ADI R2, -1
	AND R1, R2, R1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB17_56)
	SLT ADI R15, %lo(.LBB17_56)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB17_4 Depth=1
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R1, 0
	LDI R2, 63
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB17_57)
	SLT ADI R15, %lo(.LBB17_57)
	BRH C, R15
; %bb.6:                                ;   in Loop: Header=BB17_4 Depth=1
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 8
	NOR R13, R1, R1
	NOR R1, R1, R1
	INT LOD R1, R8, 0
	LDI R1, 24
	RSH R8, R1, R1
	LDI R2, 127
	AND R1, R2, R2
	NOR R2, R5, R1
	NOR R1, R1, R1
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB17_56)
	SLT ADI R15, %lo(.LBB17_56)
	BRH EQ, R15
; %bb.7:                                ;   in Loop: Header=BB17_4 Depth=1
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R1, 0
	INT LOD R14, R3, -20
	INT LOD R3, R3, 0
	LDI R10, 0
	H LDI R10, 49152
	SLT ADI R10, 0
	ADD R3, R10, R3
	LDI R10, 20
	MUL R1, R10, R10
	LDI R1, 0
	H LDI R1, mapa
	SLT ADI R1, mapa
	INT LOD R1, R1, 0
	ADD R1, R10, R1
	INT STR R1, R3, 0
	CHAR STR R1, R5, 16
	CHAR STR R1, R12, 17
	CHAR STR R1, R4, 18
	INT STR R1, R8, 12
	LDI R3, 1
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB17_22)
	SLT ADI R15, %lo(.LBB17_22)
	BRH NE, R15
; %bb.8:                                ;   in Loop: Header=BB17_4 Depth=1
	INT LOD R14, R4, -20
	INT LOD R4, R2, 0
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -1
	ADD R2, R3, R2
	LDI R3, 0
	H LDI R3, 65535
	SLT ADI R3, 0
	AND R2, R3, R2
	INT STR R4, R2, 0
	LDI R3, 0
	H LDI R3, 16096
	SLT ADI R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB17_58)
	SLT ADI R15, %lo(.LBB17_58)
	BRH C, R15
; %bb.9:                                ;   in Loop: Header=BB17_4 Depth=1
	INT LOD R6, R3, 0
	SUB R9, R3, R0
	H LDI R15, %hi(.LBB17_58)
	SLT ADI R15, %lo(.LBB17_58)
	BRH C, R15
; %bb.10:                               ;   in Loop: Header=BB17_4 Depth=1
	LDI R3, 0
	H LDI R3, 49152
	SLT ADI R3, 0
	NOR R2, R3, R2
	NOR R2, R2, R2
	INT STR R1, R2, 0
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	INT STR R14, R13, -12
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 16
	NOR R13, R1, R1
	NOR R1, R1, R2
	INT LOD R6, R1, 0
	INT LOD R2, R3, 0
	LDI R4, 0
	H LDI R4, 65280
	SLT ADI R4, 0
	AND R3, R4, R3
	AND R1, R9, R4
	SLT ADD R5, R0, R9
	LDI R5, 16
	LSH R4, R5, R5
	NOR R3, R5, R3
	NOR R3, R3, R3
	NOR R3, R9, R3
	LDI R5, 8
	LSH R4, R5, R9
	NOR R3, R3, R3
	NOR R3, R9, R3
	NOR R3, R3, R3
	INT STR R2, R3, 0
	INT LOD R6, R2, 0
	ADI R2, 1
	INT STR R6, R2, 0
	SLT ADD R6, R0, R2
	INT LOD R14, R3, -20
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	INT LOD R14, R2, -20
	LDI R1, 0
	H LDI R1, mapa
	SLT ADI R1, mapa
	INT LOD R1, R1, 0
	ADD R1, R10, R1
	INT LOD R2, R2, 0
	INT LOD R1, R3, 0
	LDI R4, 0
	H LDI R4, 16384
	SLT ADI R4, 0
	ADD R3, R4, R3
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB17_12)
	SLT ADI R15, %lo(.LBB17_12)
	BRH NC, R15
; %bb.11:                               ;   in Loop: Header=BB17_4 Depth=1
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -1
	ADD R2, R3, R2
	LDI R3, 0
	H LDI R3, 65535
	SLT ADI R3, 0
	AND R2, R3, R2
	INT LOD R14, R3, -20
	INT STR R3, R2, 0
	LDI R3, 0
	H LDI R3, 16096
	SLT ADI R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB17_58)
	SLT ADI R15, %lo(.LBB17_58)
	BRH C, R15
.LBB17_12:                              ;   in Loop: Header=BB17_4 Depth=1
	INT LOD R14, R13, -12
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 16
	ADD R13, R2, R2
	INT LOD R2, R3, 0
	LDI R4, 0
	H LDI R4, 65280
	SLT ADI R4, 255
	AND R3, R4, R3
	INT LOD R14, R6, -8
	INT LOD R6, R4, 0
	LDI R7, 16
	LSH R4, R7, R4
	LDI R5, 0
	H LDI R5, 255
	SLT ADI R5, 0
	ADD R4, R5, R4
	AND R4, R5, R4
	NOR R3, R4, R3
	NOR R3, R3, R3
	NOR R3, R9, R3
	NOR R3, R3, R3
	INT STR R2, R3, 0
	INT LOD R14, R2, -20
	INT LOD R2, R3, 0
	LDI R2, 0
	H LDI R2, 49152
	SLT ADI R2, 0
	ADD R3, R2, R2
	INT STR R1, R2, 4
	INT LOD R1, R4, 0
	SUB R2, R4, R4
	INT STR R1, R4, 8
	INT LOD R1, R4, 0
	LDI R10, 0
	SLT ADD R10, R0, R9
	INT LOD R14, R5, -4
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB17_15)
	SLT ADI R15, %lo(.LBB17_15)
	BRH NC, R15
; %bb.13:                               ;   in Loop: Header=BB17_4 Depth=1
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, -1
	ADD R3, R4, R3
	RSH R3, R7, R10
	INT LOD R1, R3, 0
	RSH R3, R7, R9
	LDI R3, 0
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB17_15)
	SLT ADI R15, %lo(.LBB17_15)
	BRH NE, R15
; %bb.14:                               ;   in Loop: Header=BB17_4 Depth=1
	INT LOD R1, R1, 0
	H LDI R15, %hi(allocateIOMemory)
	SLT ADI R15, %lo(allocateIOMemory)
	CAL R15
	INT LOD R14, R5, -4
	INT LOD R14, R6, -8
	INT LOD R14, R2, -20
	LDI R7, 16
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB17_58)
	SLT ADI R15, %lo(.LBB17_58)
	BRH NE, R15
.LBB17_15:                              ;   in Loop: Header=BB17_4 Depth=1
	LSH R10, R7, R1
	NOR R1, R9, R1
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 24
	NOR R13, R2, R2
	NOR R2, R2, R2
	NOR R1, R1, R1
	INT STR R2, R1, 0
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 4
	NOR R13, R1, R1
	NOR R1, R1, R1
	LDI R2, 3
	INT STR R1, R2, 0
	LDI R9, 255
	LDI R4, 0
	LDI R10, 0
	H LDI R10, 57344
	SLT ADI R10, 0
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB17_56)
	SLT ADI R15, %lo(.LBB17_56)
	BRH N, R15
; %bb.16:                               ; %.preheader
                                        ;   in Loop: Header=BB17_4 Depth=1
	SLT ADD R11, R0, R13
	SLT ADD R4, R0, R8
	H LDI R15, %hi(.LBB17_17)
	SLT ADI R15, %lo(.LBB17_17)
	JMP R15
.LBB17_55:                              ;   in Loop: Header=BB17_17 Depth=2
	LSH R10, R7, R1
	NOR R1, R9, R1
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 24
	ADD R13, R2, R2
	NOR R1, R1, R1
	INT STR R2, R1, 0
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 4
	ADD R13, R1, R1
	LDI R2, 3
	INT STR R1, R2, 0
	ADI R13, 4096
	LDI R9, 255
	LDI R4, 0
	LDI R10, 0
	H LDI R10, 57344
	SLT ADI R10, 0
	LDI R1, 7
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB17_56)
	SLT ADI R15, %lo(.LBB17_56)
	BRH NC, R15
.LBB17_17:                              ;   Parent Loop BB17_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ADD R13, R10, R1
	INT LOD R1, R1, 0
	LDI R2, 0
	H LDI R2, 1
	SLT ADI R2, -1
	AND R1, R2, R1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB17_56)
	SLT ADI R15, %lo(.LBB17_56)
	BRH EQ, R15
; %bb.18:                               ;   in Loop: Header=BB17_17 Depth=2
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R1, 0
	LDI R2, 63
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB17_57)
	SLT ADI R15, %lo(.LBB17_57)
	BRH C, R15
; %bb.19:                               ;   in Loop: Header=BB17_17 Depth=2
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 8
	ADD R13, R1, R1
	INT LOD R1, R3, 0
	LDI R1, 24
	RSH R3, R1, R1
	LDI R2, 127
	AND R1, R2, R2
	NOR R2, R5, R1
	NOR R1, R1, R1
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB17_56)
	SLT ADI R15, %lo(.LBB17_56)
	BRH EQ, R15
; %bb.20:                               ;   in Loop: Header=BB17_17 Depth=2
	ADI R8, 1
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R1, 0
	INT LOD R14, R4, -20
	INT LOD R4, R4, 0
	LDI R10, 0
	H LDI R10, 49152
	SLT ADI R10, 0
	ADD R4, R10, R4
	LDI R10, 20
	MUL R1, R10, R10
	LDI R1, 0
	H LDI R1, mapa
	SLT ADI R1, mapa
	INT LOD R1, R1, 0
	ADD R1, R10, R1
	INT STR R1, R4, 0
	CHAR STR R1, R5, 16
	CHAR STR R1, R12, 17
	CHAR STR R1, R8, 18
	INT STR R1, R3, 12
	LDI R3, 1
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB17_21)
	SLT ADI R15, %lo(.LBB17_21)
	BRH NE, R15
; %bb.48:                               ;   in Loop: Header=BB17_17 Depth=2
	INT LOD R14, R4, -20
	INT LOD R4, R2, 0
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -1
	ADD R2, R3, R2
	LDI R3, 0
	H LDI R3, 65535
	SLT ADI R3, 0
	AND R2, R3, R2
	INT STR R4, R2, 0
	LDI R3, 0
	H LDI R3, 16096
	SLT ADI R3, 1
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB17_58)
	SLT ADI R15, %lo(.LBB17_58)
	BRH NC, R15
; %bb.49:                               ;   in Loop: Header=BB17_17 Depth=2
	INT LOD R6, R3, 0
	LDI R4, 256
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB17_58)
	SLT ADI R15, %lo(.LBB17_58)
	BRH NC, R15
; %bb.50:                               ;   in Loop: Header=BB17_17 Depth=2
	LDI R3, 0
	H LDI R3, 49152
	SLT ADI R3, 0
	NOR R2, R3, R2
	NOR R2, R2, R2
	INT STR R1, R2, 0
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	INT STR R14, R13, -12
	SLT ADD R9, R0, R3
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 16
	ADD R13, R1, R9
	INT LOD R6, R1, 0
	INT LOD R9, R2, 0
	LDI R4, 0
	H LDI R4, 65280
	SLT ADI R4, 0
	AND R2, R4, R2
	AND R1, R3, R3
	LDI R4, 16
	LSH R3, R4, R4
	NOR R2, R4, R2
	NOR R2, R2, R2
	NOR R2, R5, R2
	LDI R4, 8
	LSH R3, R4, R13
	NOR R2, R2, R2
	NOR R2, R13, R2
	NOR R2, R2, R2
	INT STR R9, R2, 0
	INT LOD R6, R2, 0
	ADI R2, 1
	INT STR R6, R2, 0
	SLT ADD R6, R0, R2
	INT LOD R14, R3, -20
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	INT LOD R14, R2, -20
	LDI R1, 0
	H LDI R1, mapa
	SLT ADI R1, mapa
	INT LOD R1, R1, 0
	ADD R1, R10, R1
	INT LOD R2, R2, 0
	INT LOD R1, R3, 0
	LDI R4, 0
	H LDI R4, 16384
	SLT ADI R4, 0
	ADD R3, R4, R3
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB17_52)
	SLT ADI R15, %lo(.LBB17_52)
	BRH NC, R15
; %bb.51:                               ;   in Loop: Header=BB17_17 Depth=2
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -1
	ADD R2, R3, R2
	LDI R3, 0
	H LDI R3, 65535
	SLT ADI R3, 0
	AND R2, R3, R2
	INT LOD R14, R3, -20
	INT STR R3, R2, 0
	LDI R3, 0
	H LDI R3, 16096
	SLT ADI R3, 1
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB17_58)
	SLT ADI R15, %lo(.LBB17_58)
	BRH NC, R15
.LBB17_52:                              ;   in Loop: Header=BB17_17 Depth=2
	INT LOD R9, R2, 0
	LDI R3, 0
	H LDI R3, 65280
	SLT ADI R3, 255
	AND R2, R3, R2
	INT LOD R14, R6, -8
	INT LOD R6, R3, 0
	LDI R7, 16
	LSH R3, R7, R3
	LDI R4, 0
	H LDI R4, 255
	SLT ADI R4, 0
	ADD R3, R4, R3
	AND R3, R4, R3
	NOR R2, R3, R2
	NOR R2, R2, R2
	NOR R2, R13, R2
	NOR R2, R2, R2
	INT STR R9, R2, 0
	INT LOD R14, R2, -20
	INT LOD R2, R3, 0
	LDI R2, 0
	H LDI R2, 49152
	SLT ADI R2, 0
	ADD R3, R2, R2
	INT STR R1, R2, 4
	INT LOD R1, R4, 0
	SUB R2, R4, R4
	INT STR R1, R4, 8
	INT LOD R1, R4, 0
	LDI R10, 0
	SLT ADD R10, R0, R9
	INT LOD R14, R13, -12
	INT LOD R14, R5, -4
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB17_55)
	SLT ADI R15, %lo(.LBB17_55)
	BRH NC, R15
; %bb.53:                               ;   in Loop: Header=BB17_17 Depth=2
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, -1
	ADD R3, R4, R3
	RSH R3, R7, R10
	INT LOD R1, R3, 0
	RSH R3, R7, R9
	LDI R3, 0
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB17_55)
	SLT ADI R15, %lo(.LBB17_55)
	BRH NE, R15
; %bb.54:                               ;   in Loop: Header=BB17_17 Depth=2
	INT LOD R1, R1, 0
	H LDI R15, %hi(allocateIOMemory)
	SLT ADI R15, %lo(allocateIOMemory)
	CAL R15
	INT LOD R14, R5, -4
	INT LOD R14, R6, -8
	INT LOD R14, R2, -20
	LDI R7, 16
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB17_55)
	SLT ADI R15, %lo(.LBB17_55)
	BRH EQ, R15
.LBB17_58:
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.LBB17_23:
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 16
	ADD R13, R2, R2
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -1
	INT STR R2, R3, 0
	INT LOD R2, R4, 0
	LDI R2, 0
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB17_29)
	SLT ADI R15, %lo(.LBB17_29)
	BRH EQ, R15
; %bb.24:
	LDI R5, 4096
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB17_26)
	SLT ADI R15, %lo(.LBB17_26)
	BRH C, R15
; %bb.25:
	SLT ADD R5, R0, R4
.LBB17_26:
	INT LOD R14, R5, -20
	INT LOD R5, R5, 0
	LDI R6, 0
	H LDI R6, 16096
	SLT ADI R6, 0
	SUB R6, R5, R6
	SUB R6, R4, R0
	H LDI R15, %hi(.LBB17_58)
	SLT ADI R15, %lo(.LBB17_58)
	BRH C, R15
; %bb.27:
	ADI R4, 4095
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -4096
	AND R4, R7, R4
	INT LOD R14, R7, -20
	SUB R6, R4, R0
	H LDI R15, %hi(.LBB17_58)
	SLT ADI R15, %lo(.LBB17_58)
	BRH C, R15
; %bb.28:
	LDI R6, 0
	H LDI R6, 49152
	SLT ADI R6, 0
	ADD R5, R6, R5
	LDI R6, 0
	H LDI R6, 57344
	SLT ADI R6, 16
	ADD R13, R6, R6
	INT STR R6, R5, 0
	INT LOD R14, R6, -20
	INT LOD R6, R5, 0
	ADD R5, R4, R4
	INT STR R6, R4, 0
.LBB17_29:
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 20
	ADD R13, R4, R4
	INT STR R4, R3, 0
	INT LOD R4, R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB17_35)
	SLT ADI R15, %lo(.LBB17_35)
	BRH EQ, R15
; %bb.30:
	LDI R4, 4096
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB17_32)
	SLT ADI R15, %lo(.LBB17_32)
	BRH C, R15
; %bb.31:
	SLT ADD R4, R0, R3
.LBB17_32:
	INT LOD R14, R4, -20
	INT LOD R4, R4, 0
	LDI R5, 0
	H LDI R5, 16096
	SLT ADI R5, 0
	SUB R5, R4, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB17_58)
	SLT ADI R15, %lo(.LBB17_58)
	BRH C, R15
; %bb.33:
	ADI R3, 4095
	LDI R6, 0
	H LDI R6, 0
	SLT ADI R6, -4096
	AND R3, R6, R3
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB17_58)
	SLT ADI R15, %lo(.LBB17_58)
	BRH C, R15
; %bb.34:
	LDI R5, 0
	H LDI R5, 49152
	SLT ADI R5, 0
	ADD R4, R5, R4
	LDI R5, 0
	H LDI R5, 57344
	SLT ADI R5, 20
	ADD R13, R5, R5
	INT STR R5, R4, 0
	INT LOD R14, R5, -20
	INT LOD R5, R4, 0
	ADD R4, R3, R3
	INT STR R5, R3, 0
.LBB17_35:
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 24
	ADD R13, R3, R4
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -1
	INT STR R4, R3, 0
	INT LOD R4, R4, 0
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB17_41)
	SLT ADI R15, %lo(.LBB17_41)
	BRH EQ, R15
; %bb.36:
	LDI R5, 4096
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB17_38)
	SLT ADI R15, %lo(.LBB17_38)
	BRH C, R15
; %bb.37:
	SLT ADD R5, R0, R4
.LBB17_38:
	INT LOD R14, R5, -20
	INT LOD R5, R5, 0
	LDI R6, 0
	H LDI R6, 16096
	SLT ADI R6, 0
	SUB R6, R5, R6
	SUB R6, R4, R0
	H LDI R15, %hi(.LBB17_58)
	SLT ADI R15, %lo(.LBB17_58)
	BRH C, R15
; %bb.39:
	ADI R4, 4095
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -4096
	AND R4, R7, R4
	INT LOD R14, R7, -20
	SUB R6, R4, R0
	H LDI R15, %hi(.LBB17_58)
	SLT ADI R15, %lo(.LBB17_58)
	BRH C, R15
; %bb.40:
	LDI R6, 0
	H LDI R6, 49152
	SLT ADI R6, 0
	ADD R5, R6, R5
	LDI R6, 0
	H LDI R6, 57344
	SLT ADI R6, 24
	ADD R13, R6, R6
	INT STR R6, R5, 0
	INT LOD R14, R6, -20
	INT LOD R6, R5, 0
	ADD R5, R4, R4
	INT STR R6, R4, 0
.LBB17_41:
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 28
	ADD R13, R4, R4
	INT STR R4, R3, 0
	INT LOD R4, R4, 0
	INT LOD R14, R3, -20
	INT LOD R3, R3, 0
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB17_47)
	SLT ADI R15, %lo(.LBB17_47)
	BRH EQ, R15
; %bb.42:
	LDI R2, 0
	H LDI R2, 16096
	SLT ADI R2, 0
	SUB R2, R3, R2
	LDI R5, 4096
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB17_44)
	SLT ADI R15, %lo(.LBB17_44)
	BRH C, R15
; %bb.43:
	SLT ADD R5, R0, R4
.LBB17_44:
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB17_58)
	SLT ADI R15, %lo(.LBB17_58)
	BRH C, R15
; %bb.45:
	ADI R4, 4095
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -4096
	AND R4, R5, R4
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB17_58)
	SLT ADI R15, %lo(.LBB17_58)
	BRH C, R15
; %bb.46:
	LDI R2, 0
	H LDI R2, 49152
	SLT ADI R2, 0
	ADD R3, R2, R2
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 28
	ADD R13, R3, R3
	INT STR R3, R2, 0
	INT LOD R14, R5, -20
	INT LOD R5, R2, 0
	ADD R2, R4, R3
	INT STR R5, R3, 0
.LBB17_47:
	INT LOD R1, R2, 0
	SUB R3, R2, R2
	LDI R3, 0
	H LDI R3, 49152
	SLT ADI R3, 0
	ADD R2, R3, R2
	INT STR R1, R2, 8
	INT LOD R14, R2, -20
	INT LOD R2, R2, 0
	ADD R2, R3, R2
	INT STR R1, R2, 4
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB17_57)
	SLT ADI R15, %lo(.LBB17_57)
	JMP R15
.Lfunc_end17:
	.size	bus_Enumeration, .Lfunc_end17-bus_Enumeration
                                        ; -- End function
	.globl	PCIe_Bus_Enumeration            ; -- Begin function PCIe_Bus_Enumeration
	.type	PCIe_Bus_Enumeration,@function
PCIe_Bus_Enumeration:                   ; @PCIe_Bus_Enumeration
; %bb.0:
	SLT ADI R14, 24
	INT STR R14, R8, -12
	INT STR R14, R9, -16
	INT STR R14, R10, -20
	ADD R14, R0, R8
	SLT ADD R8, R0, R9
	SLT ADI R9, -8
	LDI R3, 1
	INT STR R9, R3, 0
	SLT ADI R8, -4
	LDI R10, 0
	INT STR R8, R10, 0
	LDI R2, 3
	LDI R1, 0
	H LDI R1, 2048
	SLT ADI R1, 0
	LDI R4, 0
	H LDI R4, mapa
	SLT ADI R4, mapa
	H LDI R15, %hi(allocatePages)
	SLT ADI R15, %lo(allocatePages)
	CAL R15
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB18_2)
	SLT ADI R15, %lo(.LBB18_2)
	BRH NE, R15
; %bb.1:
	LDI R1, 0
	SLT ADD R9, R0, R2
	SLT ADD R8, R0, R3
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	INT LOD R14, R10, -20
	INT LOD R14, R9, -16
	INT LOD R14, R8, -12
	SLT ADI R14, -24
	RET
.LBB18_2:
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.Lfunc_end18:
	.size	PCIe_Bus_Enumeration, .Lfunc_end18-PCIe_Bus_Enumeration
                                        ; -- End function
	.globl	searchFirst                     ; -- Begin function searchFirst
	.type	searchFirst,@function
searchFirst:                            ; @searchFirst
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R1, R0, R2
	LDI R3, 0
	H LDI R3, Globals
	SLT ADI R3, Globals
	INT LOD R3, R1, 0
	INT LOD R1, R1, 0
	LDI R4, 0
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB19_4)
	SLT ADI R15, %lo(.LBB19_4)
	BRH EQ, R15
; %bb.1:
	LDI R1, 0
	LDI R4, 0
	H LDI R4, mapa
	SLT ADI R4, mapa
	INT LOD R4, R4, 0
	ADI R4, 12
	LDI R5, 0
	H LDI R5, 256
	SLT ADI R5, -1
.LBB19_2:                               ; =>This Inner Loop Header: Depth=1
	INT LOD R4, R6, 0
	AND R6, R5, R6
	SUB R6, R2, R0
	H LDI R15, %hi(.LBB19_5)
	SLT ADI R15, %lo(.LBB19_5)
	BRH EQ, R15
; %bb.3:                                ;   in Loop: Header=BB19_2 Depth=1
	ADI R4, 20
	ADI R1, 1
	INT LOD R3, R6, 0
	INT LOD R6, R6, 0
	SUB R1, R6, R0
	H LDI R15, %hi(.LBB19_2)
	SLT ADI R15, %lo(.LBB19_2)
	BRH C, R15
.LBB19_4:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
.LBB19_5:
	SLT ADI R14, -4
	RET
.Lfunc_end19:
	.size	searchFirst, .Lfunc_end19-searchFirst
                                        ; -- End function
	.globl	search                          ; -- Begin function search
	.type	search,@function
search:                                 ; @search
; %bb.0:
	SLT ADI R14, 28
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	INT STR R14, R13, -24
	LDI R4, 0
	H LDI R4, Globals
	SLT ADI R4, Globals
	INT LOD R4, R3, 0
	INT LOD R3, R5, 0
	LDI R3, 0
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB20_6)
	SLT ADI R15, %lo(.LBB20_6)
	BRH EQ, R15
; %bb.1:
	LDI R7, 0
	LDI R3, 0
	H LDI R3, mapa
	SLT ADI R3, mapa
	INT LOD R3, R5, 0
	ADI R5, 18
	LDI R6, 0
	H LDI R6, 256
	SLT ADI R6, -1
	LDI R10, 0
	H LDI R10, 57344
	SLT ADI R10, 0
	LDI R11, 2
	LDI R12, 30
	SLT ADD R7, R0, R13
	H LDI R15, %hi(.LBB20_2)
	SLT ADI R15, %lo(.LBB20_2)
	JMP R15
.LBB20_3:                               ;   in Loop: Header=BB20_2 Depth=1
	SLT ADD R7, R0, R3
.LBB20_5:                               ;   in Loop: Header=BB20_2 Depth=1
	ADI R5, 20
	ADI R13, 1
	INT LOD R4, R7, 0
	INT LOD R7, R8, 0
	SLT ADD R3, R0, R7
	SUB R13, R8, R0
	H LDI R15, %hi(.LBB20_6)
	SLT ADI R15, %lo(.LBB20_6)
	BRH NC, R15
.LBB20_2:                               ; =>This Inner Loop Header: Depth=1
	INT LOD R5, R3, -6
	AND R3, R6, R3
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB20_3)
	SLT ADI R15, %lo(.LBB20_3)
	BRH NE, R15
; %bb.4:                                ;   in Loop: Header=BB20_2 Depth=1
	CHAR LOD R5, R3, -2
	LDI R8, 20
	LSH R3, R8, R3
	CHAR LOD R5, R8, -1
	LDI R9, 15
	LSH R8, R9, R8
	NOR R3, R8, R3
	CHAR LOD R5, R8, 0
	LDI R9, 12
	LSH R8, R9, R8
	NOR R3, R3, R3
	NOR R3, R8, R3
	NOR R3, R3, R3
	NOR R3, R10, R3
	LSH R7, R11, R8
	ADD R2, R8, R8
	NOR R3, R3, R3
	INT STR R8, R3, 0
	SLT ADD R7, R0, R3
	ADI R3, 1
	SUB R12, R7, R0
	H LDI R15, %hi(.LBB20_5)
	SLT ADI R15, %lo(.LBB20_5)
	BRH NC, R15
.LBB20_6:
	SLT ADD R3, R0, R1
	INT LOD R14, R13, -24
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -28
	RET
.Lfunc_end20:
	.size	search, .Lfunc_end20-search
                                        ; -- End function
	.globl	mainHandler                     ; -- Begin function mainHandler
	.type	mainHandler,@function
mainHandler:                            ; @mainHandler
; %bb.0:
	SLT ADI R14, 24
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	;APP
	CYE SR1, R9
	;NO_APP
	;APP
	CYE SR8, R2
	;NO_APP
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -5
	AND R2, R3, R10
	LDI R3, 8
	AND R2, R3, R4
	;APP
	CYE SR9, R11
	;NO_APP
	;APP
	CYE SR10, R12
	;NO_APP
	;APP
	CYE SR7, R8
	;NO_APP
	LDI R3, 0
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB21_2)
	SLT ADI R15, %lo(.LBB21_2)
	BRH EQ, R15
; %bb.1:
	LDI R4, 4
	NOR R2, R4, R4
	NOR R4, R4, R4
	;APP
	CYR R4, SR8
	;NO_APP
.LBB21_2:
	SUB R8, R3, R0
	H LDI R15, %hi(.LBB21_7)
	SLT ADI R15, %lo(.LBB21_7)
	BRH EQ, R15
; %bb.3:
	LDI R1, 127
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB21_6)
	SLT ADI R15, %lo(.LBB21_6)
	BRH C, R15
; %bb.4:
	LDI R1, 2
	LSH R8, R1, R1
	LDI R4, 0
	H LDI R4, irq_table
	SLT ADI R4, irq_table
	INT LOD R4, R4, 0
	ADD R4, R1, R1
	INT LOD R1, R4, 0
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB21_6)
	SLT ADI R15, %lo(.LBB21_6)
	BRH EQ, R15
; %bb.5:
	SLT ADD R2, R0, R1
	SLT ADD R9, R0, R2
	SLT ADD R8, R0, R3
	CAL R4
	H LDI R15, %hi(.LBB21_8)
	SLT ADI R15, %lo(.LBB21_8)
	JMP R15
.LBB21_6:
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -5
	AND R1, R2, R1
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	LDI R2, 1
	CHAR STR R1, R2, 4
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.22
	SLT ADI R1, .L.str.22
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB21_9)
	SLT ADI R15, %lo(.LBB21_9)
	JMP R15
.LBB21_7:
	SLT ADD R9, R0, R3
	H LDI R15, %hi(syscallsHandler)
	SLT ADI R15, %lo(syscallsHandler)
	CAL R15
.LBB21_8:
	SLT ADD R1, R0, R9
.LBB21_9:
	;APP
	CYR R10, SR8
	;NO_APP
	;APP
	CYR R9, SR1
	;NO_APP
	;APP
	CYR R11, SR9
	;NO_APP
	;APP
	CYR R12, SR10
	;NO_APP
	LDI R1, 16
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB21_11)
	SLT ADI R15, %lo(.LBB21_11)
	BRH C, R15
; %bb.10:
	LDI R1, 0
	H LDI R1, Registros
	SLT ADI R1, Registros
	INT LOD R1, R1, 0
	LDI R2, 1
	INT STR R1, R2, 16
.LBB21_11:
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -24
	RET
.Lfunc_end21:
	.size	mainHandler, .Lfunc_end21-mainHandler
                                        ; -- End function
	.globl	entryHandler                    ; -- Begin function entryHandler
	.type	entryHandler,@function
entryHandler:                           ; @entryHandler
; %bb.0:
	;APP
	SLT ADI R14, 56 
INT STR R14, R1, -56 
INT STR R14, R2, -52 
INT STR R14, R3, -48 
INT STR R14, R4, -44 
INT STR R14, R5, -40 
INT STR R14, R6, -36 
INT STR R14, R7, -32 
INT STR R14, R8, -28 
INT STR R14, R9, -24 
INT STR R14, R10, -20 
INT STR R14, R11, -16 
INT STR R14, R12, -12 
INT STR R14, R13, -8 
INT STR R14, R15, -4 
SLT ADD R14, R0, R1 
SLT ADI R1, -56 
H LDI R15, %hi(mainHandler) 
SLT ADI R15, %lo(mainHandler) 
CAL R15 
INT LOD R14, R1, -56 
INT LOD R14, R2, -52 
INT LOD R14, R3, -48 
INT LOD R14, R4, -44 
INT LOD R14, R5, -40 
INT LOD R14, R6, -36 
INT LOD R14, R7, -32 
INT LOD R14, R8, -28 
INT LOD R14, R9, -24 
INT LOD R14, R10, -20 
INT LOD R14, R11, -16 
INT LOD R14, R12, -12 
INT LOD R14, R13, -8 
INT LOD R14, R15, -4 
SLT ADI R14, -56 
SRT 

	;NO_APP
.Lfunc_end22:
	.size	entryHandler, .Lfunc_end22-entryHandler
                                        ; -- End function
	.globl	initMSI                         ; -- Begin function initMSI
	.type	initMSI,@function
initMSI:                                ; @initMSI
; %bb.0:
	SLT ADI R14, 4
	INT LOD R1, R4, 36
	ADD R4, R1, R1
	INT LOD R1, R4, 0
	LDI R5, 255
	AND R4, R5, R4
	LDI R5, 5
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB23_5)
	SLT ADI R15, %lo(.LBB23_5)
	BRH NE, R15
; %bb.1:
	INT LOD R1, R4, 0
	LDI R5, 0
	H LDI R5, 65248
	SLT ADI R5, 44
	INT STR R1, R5, 4
	INT STR R1, R2, 8
	LDI R5, 127
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB23_4)
	SLT ADI R15, %lo(.LBB23_4)
	BRH C, R15
; %bb.2:
	LDI R5, 0
	SUB R3, R5, R0
	H LDI R15, %hi(.LBB23_4)
	SLT ADI R15, %lo(.LBB23_4)
	BRH EQ, R15
; %bb.3:
	LDI R5, 2
	LSH R2, R5, R2
	LDI R5, 0
	H LDI R5, irq_table
	SLT ADI R5, irq_table
	INT LOD R5, R5, 0
	ADD R5, R2, R2
	INT STR R2, R3, 0
.LBB23_4:
	LDI R2, 13
	RSH R4, R2, R2
	LDI R3, 112
	AND R2, R3, R2
	LDI R3, 1
	NOR R2, R3, R2
	NOR R2, R2, R2
	INT STR R1, R2, 0
.LBB23_5:
	SLT ADI R14, -4
	RET
.Lfunc_end23:
	.size	initMSI, .Lfunc_end23-initMSI
                                        ; -- End function
	.globl	initLAPIC                       ; -- Begin function initLAPIC
	.type	initLAPIC,@function
initLAPIC:                              ; @initLAPIC
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
	LDI R1, 2
	LDI R2, 512
	LDI R8, 0
	H LDI R8, irq_table
	SLT ADI R8, irq_table
	LDI R3, 0
	H LDI R3, irq_table
	SLT ADI R3, irq_table
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB24_2)
	SLT ADI R15, %lo(.LBB24_2)
	BRH NE, R15
; %bb.1:
	INT LOD R8, R1, 0
	LDI R3, 0
	H LDI R3, doubleFault
	SLT ADI R3, doubleFault
	INT STR R1, R3, 20
	LDI R3, 0
	H LDI R3, invalidOpCode
	SLT ADI R3, invalidOpCode
	INT STR R1, R3, 16
	LDI R3, 0
	H LDI R3, generalProtectionFault
	SLT ADI R3, generalProtectionFault
	INT STR R1, R3, 12
	LDI R3, 0
	H LDI R3, alignamentFault
	SLT ADI R3, alignamentFault
	INT STR R1, R3, 8
	LDI R3, 0
	H LDI R3, pageFault
	SLT ADI R3, pageFault
	INT STR R1, R3, 4
	LDI R1, 0
	H LDI R1, entryHandler
	SLT ADI R1, entryHandler
	;APP
	CYR R1, SR12
	;NO_APP
	LDI R1, 0
	H LDI R1, 65248
	SLT ADI R1, 0
	LDI R3, 0
	H LDI R3, Registros
	SLT ADI R3, Registros
	INT STR R3, R1, 0
	INT STR R1, R1, 0
	LDI R1, 0
	H LDI R1, 65248
	SLT ADI R1, 4
	INT STR R1, R2, 0
	LDI R1, 0
	H LDI R1, 65248
	SLT ADI R1, 12
	INT STR R1, R2, 0
	LDI R1, 3
	LDI R2, 0
	H LDI R2, 65248
	SLT ADI R2, 8
	INT STR R2, R1, 0
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R2, 4
	NOR R1, R2, R1
	NOR R1, R1, R1
	;APP
	CYR R1, SR8
	;NO_APP
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.LBB24_2:
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.Lfunc_end24:
	.size	initLAPIC, .Lfunc_end24-initLAPIC
                                        ; -- End function
	.globl	pageFault                       ; -- Begin function pageFault
	.type	pageFault,@function
pageFault:                              ; @pageFault
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
	SLT ADD R2, R0, R8
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -5
	AND R1, R2, R1
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	LDI R2, 1
	CHAR STR R1, R2, 4
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.29
	SLT ADI R1, .L.str.29
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	;APP
	HLT
	;NO_APP
	SLT ADD R8, R0, R1
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.Lfunc_end25:
	.size	pageFault, .Lfunc_end25-pageFault
                                        ; -- End function
	.globl	alignamentFault                 ; -- Begin function alignamentFault
	.type	alignamentFault,@function
alignamentFault:                        ; @alignamentFault
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
	SLT ADD R2, R0, R8
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -5
	AND R1, R2, R1
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	LDI R2, 1
	CHAR STR R1, R2, 4
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.1.32
	SLT ADI R1, .L.str.1.32
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	;APP
	HLT
	;NO_APP
	SLT ADD R8, R0, R1
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.Lfunc_end26:
	.size	alignamentFault, .Lfunc_end26-alignamentFault
                                        ; -- End function
	.globl	generalProtectionFault          ; -- Begin function generalProtectionFault
	.type	generalProtectionFault,@function
generalProtectionFault:                 ; @generalProtectionFault
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
	SLT ADD R2, R0, R8
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -5
	AND R1, R2, R1
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	LDI R2, 1
	CHAR STR R1, R2, 4
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.2.35
	SLT ADI R1, .L.str.2.35
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	;APP
	HLT
	;NO_APP
	SLT ADD R8, R0, R1
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.Lfunc_end27:
	.size	generalProtectionFault, .Lfunc_end27-generalProtectionFault
                                        ; -- End function
	.globl	invalidOpCode                   ; -- Begin function invalidOpCode
	.type	invalidOpCode,@function
invalidOpCode:                          ; @invalidOpCode
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
	SLT ADD R2, R0, R8
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -5
	AND R1, R2, R1
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	LDI R2, 1
	CHAR STR R1, R2, 4
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.3.38
	SLT ADI R1, .L.str.3.38
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	;APP
	HLT
	;NO_APP
	SLT ADD R8, R0, R1
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.Lfunc_end28:
	.size	invalidOpCode, .Lfunc_end28-invalidOpCode
                                        ; -- End function
	.globl	doubleFault                     ; -- Begin function doubleFault
	.type	doubleFault,@function
doubleFault:                            ; @doubleFault
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
	SLT ADD R2, R0, R8
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -5
	AND R1, R2, R1
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	LDI R2, 1
	CHAR STR R1, R2, 4
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.4.41
	SLT ADI R1, .L.str.4.41
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	;APP
	HLT
	;NO_APP
	SLT ADD R8, R0, R1
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.Lfunc_end29:
	.size	doubleFault, .Lfunc_end29-doubleFault
                                        ; -- End function
	.globl	syscallsHandler                 ; -- Begin function syscallsHandler
	.type	syscallsHandler,@function
syscallsHandler:                        ; @syscallsHandler
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R3, R0, R1
	ADI R1, 4
	SLT ADI R14, -4
	RET
.Lfunc_end30:
	.size	syscallsHandler, .Lfunc_end30-syscallsHandler
                                        ; -- End function
	.globl	ToAscii                         ; -- Begin function ToAscii
	.type	ToAscii,@function
ToAscii:                                ; @ToAscii
; %bb.0:
	SLT ADI R14, 32
	INT STR R14, R8, -8
	INT STR R14, R9, -12
	INT STR R14, R10, -16
	INT STR R14, R11, -20
	INT STR R14, R12, -24
	INT STR R14, R13, -28
	SLT ADD R2, R0, R8
	;APP
	CYE SR8, R11
	;NO_APP
	;APP
	CYE SR8, R2
	;NO_APP
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -5
	AND R2, R3, R2
	;APP
	CYR R2, SR8
	;NO_APP
	LDI R2, 0
	H LDI R2, current_pool_index
	SLT ADI R2, current_pool_index
	INT LOD R2, R2, 0
	LDI R10, 0
	SUB R2, R10, R0
	H LDI R15, %hi(.LBB31_2)
	SLT ADI R15, %lo(.LBB31_2)
	BRH EQ, R15
; %bb.1:
	INT LOD R2, R9, 0
	H LDI R15, %hi(.LBB31_5)
	SLT ADI R15, %lo(.LBB31_5)
	JMP R15
.LBB31_2:
	SLT ADD R1, R0, R12
	LDI R9, 0
	LDI R2, 4
	SLT ADD R9, R0, R1
	LDI R3, 0
	H LDI R3, current_pool_index
	SLT ADI R3, current_pool_index
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB31_56)
	SLT ADI R15, %lo(.LBB31_56)
	BRH NE, R15
; %bb.3:
	LDI R2, 256
	SLT ADD R9, R0, R1
	LDI R3, 0
	H LDI R3, ascii_pool
	SLT ADI R3, ascii_pool
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB31_56)
	SLT ADI R15, %lo(.LBB31_56)
	BRH NE, R15
; %bb.4:
	LDI R1, 0
	H LDI R1, current_pool_index
	SLT ADI R1, current_pool_index
	INT LOD R1, R2, 0
	INT STR R2, R9, 0
	SLT ADD R12, R0, R1
.LBB31_5:
	SLT ADD R9, R0, R5
	ADI R5, 1
	LDI R4, 31
	LDI R3, 1
	SLT ADD R5, R0, R6
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB31_7)
	SLT ADI R15, %lo(.LBB31_7)
	BRH EQ, R15
; %bb.6:
	RSH R5, R4, R6
	LSH R6, R3, R7
	SUB R6, R7, R6
.LBB31_7:
	LDI R7, 29
	RSH R6, R7, R6
	ADD R5, R6, R6
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -8
	AND R6, R7, R6
	SUB R5, R6, R5
	LDI R6, 0
	H LDI R6, ascii_pool
	SLT ADI R6, ascii_pool
	INT LOD R6, R6, 0
	INT STR R2, R5, 0
	LDI R2, 5
	LSH R9, R2, R2
	ADD R6, R2, R2
	;APP
	CYR R11, SR8
	;NO_APP
	CHAR STR R2, R10, 31
	SLT ADD R2, R0, R5
	ADI R5, 31
	SUB R8, R10, R0
	H LDI R15, %hi(.LBB31_42)
	SLT ADI R15, %lo(.LBB31_42)
	BRH EQ, R15
; %bb.8:
	LDI R6, 2
	SUB R8, R6, R0
	H LDI R15, %hi(.LBB31_36)
	SLT ADI R15, %lo(.LBB31_36)
	BRH EQ, R15
; %bb.9:
	LDI R6, 3
	SUB R8, R6, R0
	H LDI R15, %hi(.LBB31_10)
	SLT ADI R15, %lo(.LBB31_10)
	BRH NE, R15
; %bb.11:
	LDI R3, 8
	RSH R1, R3, R3
	LDI R6, 15
	AND R3, R6, R3
	LDI R4, 48
	LDI R7, 10
	SUB R3, R7, R0
	H LDI R15, %hi(.LBB31_12)
	SLT ADI R15, %lo(.LBB31_12)
	BRH C, R15
; %bb.13:
	ADI R3, 55
	H LDI R15, %hi(.LBB31_14)
	SLT ADI R15, %lo(.LBB31_14)
	JMP R15
.LBB31_36:
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB31_57)
	SLT ADI R15, %lo(.LBB31_57)
	BRH EQ, R15
; %bb.37:
	LDI R3, 15
	LDI R4, 48
	LDI R6, 10
	LDI R7, 4
	SLT ADD R5, R0, R2
	H LDI R15, %hi(.LBB31_38)
	SLT ADI R15, %lo(.LBB31_38)
	JMP R15
.LBB31_40:                              ;   in Loop: Header=BB31_38 Depth=1
	ADI R5, 55
.LBB31_41:                              ;   in Loop: Header=BB31_38 Depth=1
	CHAR STR R2, R5, -1
	RSH R1, R7, R1
	ADI R2, -1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB31_55)
	SLT ADI R15, %lo(.LBB31_55)
	BRH EQ, R15
.LBB31_38:                              ; =>This Inner Loop Header: Depth=1
	AND R1, R3, R5
	SUB R5, R6, R0
	H LDI R15, %hi(.LBB31_40)
	SLT ADI R15, %lo(.LBB31_40)
	BRH NC, R15
; %bb.39:                               ;   in Loop: Header=BB31_38 Depth=1
	NOR R5, R4, R5
	NOR R5, R5, R5
	H LDI R15, %hi(.LBB31_41)
	SLT ADI R15, %lo(.LBB31_41)
	JMP R15
.LBB31_42:
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -1
	SLT ADD R3, R0, R6
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB31_44)
	SLT ADI R15, %lo(.LBB31_44)
	BRH N, R15
; %bb.43:
	SLT ADD R10, R0, R6
.LBB31_44:
	SLT ADD R1, R0, R7
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB31_46)
	SLT ADI R15, %lo(.LBB31_46)
	BRH EQ, R15
; %bb.45:
	RSH R1, R4, R7
	LSH R7, R3, R8
	SUB R7, R8, R7
.LBB31_46:
	XOR R1, R7, R1
	SUB R1, R7, R1
	H LDI R15, %hi(.LBB31_47)
	SLT ADI R15, %lo(.LBB31_47)
	JMP R15
.LBB31_10:
	SLT ADD R3, R0, R6
.LBB31_47:
	INT STR R14, R6, -4
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB31_58)
	SLT ADI R15, %lo(.LBB31_58)
	BRH EQ, R15
; %bb.48:
	LDI R2, 0
	H LDI R2, 52429
	SLT ADI R2, -13107
	LDI R7, 3
	LDI R8, 10
	LDI R9, 48
	LDI R11, 9
	H LDI R15, %hi(.LBB31_49)
	SLT ADI R15, %lo(.LBB31_49)
	JMP R15
.LBB31_51:                              ;   in Loop: Header=BB31_49 Depth=1
	AND R1, R2, R1
	MUL R12, R2, R13
	GOF R6
	ADD R6, R1, R1
	ADD R1, R12, R1
	RSH R1, R7, R1
	MUL R1, R8, R6
	SUB R12, R6, R6
	NOR R6, R9, R6
	NOR R6, R6, R6
	CHAR STR R5, R6, -1
	ADI R5, -1
	SUB R11, R12, R0
	H LDI R15, %hi(.LBB31_52)
	SLT ADI R15, %lo(.LBB31_52)
	BRH NC, R15
.LBB31_49:                              ; =>This Inner Loop Header: Depth=1
	SLT ADD R1, R0, R12
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB31_51)
	SLT ADI R15, %lo(.LBB31_51)
	BRH EQ, R15
; %bb.50:                               ;   in Loop: Header=BB31_49 Depth=1
	RSH R12, R4, R1
	LSH R1, R3, R13
	SUB R1, R13, R1
	H LDI R15, %hi(.LBB31_51)
	SLT ADI R15, %lo(.LBB31_51)
	JMP R15
.LBB31_12:
	NOR R3, R4, R3
	NOR R3, R3, R3
.LBB31_14:
	LDI R5, 4
	RSH R1, R5, R5
	AND R5, R6, R5
	SUB R5, R7, R0
	H LDI R15, %hi(.LBB31_15)
	SLT ADI R15, %lo(.LBB31_15)
	BRH C, R15
; %bb.16:
	ADI R5, 55
	AND R1, R6, R8
	SUB R8, R7, R0
	H LDI R15, %hi(.LBB31_19)
	SLT ADI R15, %lo(.LBB31_19)
	BRH NC, R15
.LBB31_18:
	NOR R8, R4, R8
	NOR R8, R8, R8
	H LDI R15, %hi(.LBB31_20)
	SLT ADI R15, %lo(.LBB31_20)
	JMP R15
.LBB31_15:
	NOR R5, R4, R5
	NOR R5, R5, R5
	AND R1, R6, R8
	SUB R8, R7, R0
	H LDI R15, %hi(.LBB31_18)
	SLT ADI R15, %lo(.LBB31_18)
	BRH C, R15
.LBB31_19:
	ADI R8, 55
.LBB31_20:
	LDI R9, 24
	RSH R1, R9, R9
	AND R9, R6, R9
	SUB R9, R7, R0
	H LDI R15, %hi(.LBB31_21)
	SLT ADI R15, %lo(.LBB31_21)
	BRH C, R15
; %bb.22:
	ADI R9, 55
	H LDI R15, %hi(.LBB31_23)
	SLT ADI R15, %lo(.LBB31_23)
	JMP R15
.LBB31_21:
	NOR R9, R4, R9
	NOR R9, R9, R9
.LBB31_23:
	LDI R10, 20
	RSH R1, R10, R10
	AND R10, R6, R10
	SUB R10, R7, R0
	H LDI R15, %hi(.LBB31_24)
	SLT ADI R15, %lo(.LBB31_24)
	BRH C, R15
; %bb.25:
	ADI R10, 55
	H LDI R15, %hi(.LBB31_26)
	SLT ADI R15, %lo(.LBB31_26)
	JMP R15
.LBB31_24:
	NOR R10, R4, R10
	NOR R10, R10, R10
.LBB31_26:
	LDI R11, 16
	RSH R1, R11, R11
	AND R11, R6, R11
	SUB R11, R7, R0
	H LDI R15, %hi(.LBB31_27)
	SLT ADI R15, %lo(.LBB31_27)
	BRH C, R15
; %bb.28:
	ADI R11, 55
	H LDI R15, %hi(.LBB31_29)
	SLT ADI R15, %lo(.LBB31_29)
	JMP R15
.LBB31_27:
	NOR R11, R4, R11
	NOR R11, R11, R11
.LBB31_29:
	LDI R12, 12
	RSH R1, R12, R12
	AND R12, R6, R6
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB31_30)
	SLT ADI R15, %lo(.LBB31_30)
	BRH C, R15
; %bb.31:
	ADI R6, 55
	H LDI R15, %hi(.LBB31_32)
	SLT ADI R15, %lo(.LBB31_32)
	JMP R15
.LBB31_30:
	NOR R6, R4, R6
	NOR R6, R6, R6
.LBB31_32:
	LDI R7, 28
	RSH R1, R7, R7
	LDI R12, 0
	H LDI R12, 40960
	SLT ADI R12, 0
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB31_33)
	SLT ADI R15, %lo(.LBB31_33)
	BRH C, R15
; %bb.34:
	ADI R7, 55
	H LDI R15, %hi(.LBB31_35)
	SLT ADI R15, %lo(.LBB31_35)
	JMP R15
.LBB31_33:
	NOR R7, R4, R1
	NOR R1, R1, R7
.LBB31_35:
	CHAR STR R2, R8, 30
	CHAR STR R2, R7, 23
	CHAR STR R2, R5, 29
	CHAR STR R2, R3, 28
	CHAR STR R2, R6, 27
	CHAR STR R2, R11, 26
	CHAR STR R2, R10, 25
	CHAR STR R2, R9, 24
	ADI R2, 23
	H LDI R15, %hi(.LBB31_55)
	SLT ADI R15, %lo(.LBB31_55)
	JMP R15
.LBB31_58:
	LDI R1, 48
	CHAR STR R2, R1, 30
	ADI R2, 30
	SLT ADD R2, R0, R5
.LBB31_52:
	INT LOD R14, R1, -4
	AND R1, R3, R1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB31_54)
	SLT ADI R15, %lo(.LBB31_54)
	BRH NE, R15
; %bb.53:
	LDI R1, 45
	CHAR STR R5, R1, -1
	ADI R5, -1
.LBB31_54:
	SLT ADD R5, R0, R2
.LBB31_55:
	SLT ADD R2, R0, R1
	INT LOD R14, R13, -28
	INT LOD R14, R12, -24
	INT LOD R14, R11, -20
	INT LOD R14, R10, -16
	INT LOD R14, R9, -12
	INT LOD R14, R8, -8
	SLT ADI R14, -32
	RET
.LBB31_57:
	LDI R1, 48
	CHAR STR R2, R1, 30
	ADI R2, 30
	H LDI R15, %hi(.LBB31_55)
	SLT ADI R15, %lo(.LBB31_55)
	JMP R15
.LBB31_56:
	;APP
	CYR R11, SR8
	;NO_APP
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.Lfunc_end31:
	.size	ToAscii, .Lfunc_end31-ToAscii
                                        ; -- End function
	.globl	__udivsi3                       ; -- Begin function __udivsi3
	.type	__udivsi3,@function
__udivsi3:                              ; @__udivsi3
; %bb.0:
	SLT ADI R14, 16
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	LDI R4, 0
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB32_1)
	SLT ADI R15, %lo(.LBB32_1)
	BRH EQ, R15
; %bb.2:                                ; %.preheader
	LDI R5, 31
	LDI R6, 1
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -1
	SLT ADD R4, R0, R8
	SLT ADD R4, R0, R3
	H LDI R15, %hi(.LBB32_3)
	SLT ADI R15, %lo(.LBB32_3)
	JMP R15
.LBB32_7:                               ;   in Loop: Header=BB32_3 Depth=1
	SUB R8, R10, R8
	NOR R9, R3, R3
	NOR R3, R3, R3
	ADI R5, -1
	SUB R5, R7, R0
	H LDI R15, %hi(.LBB32_8)
	SLT ADI R15, %lo(.LBB32_8)
	BRH EQ, R15
.LBB32_3:                               ; =>This Inner Loop Header: Depth=1
	LSH R8, R6, R8
	RSH R1, R5, R9
	AND R9, R6, R9
	NOR R9, R8, R8
	NOR R8, R8, R8
	SLT ADD R4, R0, R9
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB32_5)
	SLT ADI R15, %lo(.LBB32_5)
	BRH C, R15
; %bb.4:                                ;   in Loop: Header=BB32_3 Depth=1
	LSH R6, R5, R9
.LBB32_5:                               ;   in Loop: Header=BB32_3 Depth=1
	SLT ADD R4, R0, R10
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB32_7)
	SLT ADI R15, %lo(.LBB32_7)
	BRH C, R15
; %bb.6:                                ;   in Loop: Header=BB32_3 Depth=1
	SLT ADD R2, R0, R10
	H LDI R15, %hi(.LBB32_7)
	SLT ADI R15, %lo(.LBB32_7)
	JMP R15
.LBB32_1:
	SLT ADD R4, R0, R3
.LBB32_8:
	SLT ADD R3, R0, R1
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -16
	RET
.Lfunc_end32:
	.size	__udivsi3, .Lfunc_end32-__udivsi3
                                        ; -- End function
	.globl	__umodsi3                       ; -- Begin function __umodsi3
	.type	__umodsi3,@function
__umodsi3:                              ; @__umodsi3
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R1, R0, R3
	LDI R1, 0
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB33_66)
	SLT ADI R15, %lo(.LBB33_66)
	BRH EQ, R15
; %bb.1:
	LDI R4, 31
	RSH R3, R4, R4
	SLT ADD R1, R0, R5
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB33_3)
	SLT ADI R15, %lo(.LBB33_3)
	BRH C, R15
; %bb.2:
	SLT ADD R2, R0, R5
.LBB33_3:
	SUB R4, R5, R5
	LDI R4, 1
	LSH R5, R4, R5
	LDI R6, 30
	RSH R3, R6, R6
	AND R6, R4, R6
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_5)
	SLT ADI R15, %lo(.LBB33_5)
	BRH C, R15
; %bb.4:
	SLT ADD R2, R0, R6
.LBB33_5:
	SUB R5, R6, R5
	LDI R6, 29
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_7)
	SLT ADI R15, %lo(.LBB33_7)
	BRH C, R15
; %bb.6:
	SLT ADD R2, R0, R6
.LBB33_7:
	SUB R5, R6, R5
	LDI R6, 28
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_9)
	SLT ADI R15, %lo(.LBB33_9)
	BRH C, R15
; %bb.8:
	SLT ADD R2, R0, R6
.LBB33_9:
	SUB R5, R6, R5
	LDI R6, 27
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_11)
	SLT ADI R15, %lo(.LBB33_11)
	BRH C, R15
; %bb.10:
	SLT ADD R2, R0, R6
.LBB33_11:
	SUB R5, R6, R5
	LDI R6, 26
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_13)
	SLT ADI R15, %lo(.LBB33_13)
	BRH C, R15
; %bb.12:
	SLT ADD R2, R0, R6
.LBB33_13:
	SUB R5, R6, R5
	LDI R6, 25
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_15)
	SLT ADI R15, %lo(.LBB33_15)
	BRH C, R15
; %bb.14:
	SLT ADD R2, R0, R6
.LBB33_15:
	SUB R5, R6, R5
	LDI R6, 24
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_17)
	SLT ADI R15, %lo(.LBB33_17)
	BRH C, R15
; %bb.16:
	SLT ADD R2, R0, R6
.LBB33_17:
	SUB R5, R6, R5
	LDI R6, 23
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_19)
	SLT ADI R15, %lo(.LBB33_19)
	BRH C, R15
; %bb.18:
	SLT ADD R2, R0, R6
.LBB33_19:
	SUB R5, R6, R5
	LDI R6, 22
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_21)
	SLT ADI R15, %lo(.LBB33_21)
	BRH C, R15
; %bb.20:
	SLT ADD R2, R0, R6
.LBB33_21:
	SUB R5, R6, R5
	LDI R6, 21
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_23)
	SLT ADI R15, %lo(.LBB33_23)
	BRH C, R15
; %bb.22:
	SLT ADD R2, R0, R6
.LBB33_23:
	SUB R5, R6, R5
	LDI R6, 20
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_25)
	SLT ADI R15, %lo(.LBB33_25)
	BRH C, R15
; %bb.24:
	SLT ADD R2, R0, R6
.LBB33_25:
	SUB R5, R6, R5
	LDI R6, 19
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_27)
	SLT ADI R15, %lo(.LBB33_27)
	BRH C, R15
; %bb.26:
	SLT ADD R2, R0, R6
.LBB33_27:
	SUB R5, R6, R5
	LDI R6, 18
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_29)
	SLT ADI R15, %lo(.LBB33_29)
	BRH C, R15
; %bb.28:
	SLT ADD R2, R0, R6
.LBB33_29:
	SUB R5, R6, R5
	LDI R6, 17
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_31)
	SLT ADI R15, %lo(.LBB33_31)
	BRH C, R15
; %bb.30:
	SLT ADD R2, R0, R6
.LBB33_31:
	SUB R5, R6, R5
	LDI R6, 16
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_33)
	SLT ADI R15, %lo(.LBB33_33)
	BRH C, R15
; %bb.32:
	SLT ADD R2, R0, R6
.LBB33_33:
	SUB R5, R6, R5
	LDI R6, 15
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_35)
	SLT ADI R15, %lo(.LBB33_35)
	BRH C, R15
; %bb.34:
	SLT ADD R2, R0, R6
.LBB33_35:
	SUB R5, R6, R5
	LDI R6, 14
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_37)
	SLT ADI R15, %lo(.LBB33_37)
	BRH C, R15
; %bb.36:
	SLT ADD R2, R0, R6
.LBB33_37:
	SUB R5, R6, R5
	LDI R6, 13
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_39)
	SLT ADI R15, %lo(.LBB33_39)
	BRH C, R15
; %bb.38:
	SLT ADD R2, R0, R6
.LBB33_39:
	SUB R5, R6, R5
	LDI R6, 12
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_41)
	SLT ADI R15, %lo(.LBB33_41)
	BRH C, R15
; %bb.40:
	SLT ADD R2, R0, R6
.LBB33_41:
	SUB R5, R6, R5
	LDI R6, 11
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_43)
	SLT ADI R15, %lo(.LBB33_43)
	BRH C, R15
; %bb.42:
	SLT ADD R2, R0, R6
.LBB33_43:
	SUB R5, R6, R5
	LDI R6, 10
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_45)
	SLT ADI R15, %lo(.LBB33_45)
	BRH C, R15
; %bb.44:
	SLT ADD R2, R0, R6
.LBB33_45:
	SUB R5, R6, R5
	LDI R6, 9
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_47)
	SLT ADI R15, %lo(.LBB33_47)
	BRH C, R15
; %bb.46:
	SLT ADD R2, R0, R6
.LBB33_47:
	SUB R5, R6, R5
	LDI R6, 8
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_49)
	SLT ADI R15, %lo(.LBB33_49)
	BRH C, R15
; %bb.48:
	SLT ADD R2, R0, R6
.LBB33_49:
	SUB R5, R6, R5
	LDI R6, 7
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_51)
	SLT ADI R15, %lo(.LBB33_51)
	BRH C, R15
; %bb.50:
	SLT ADD R2, R0, R6
.LBB33_51:
	SUB R5, R6, R5
	LDI R6, 6
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_53)
	SLT ADI R15, %lo(.LBB33_53)
	BRH C, R15
; %bb.52:
	SLT ADD R2, R0, R6
.LBB33_53:
	SUB R5, R6, R5
	LDI R6, 5
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_55)
	SLT ADI R15, %lo(.LBB33_55)
	BRH C, R15
; %bb.54:
	SLT ADD R2, R0, R6
.LBB33_55:
	SUB R5, R6, R5
	LDI R6, 4
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_57)
	SLT ADI R15, %lo(.LBB33_57)
	BRH C, R15
; %bb.56:
	SLT ADD R2, R0, R6
.LBB33_57:
	SUB R5, R6, R5
	LDI R6, 3
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_59)
	SLT ADI R15, %lo(.LBB33_59)
	BRH C, R15
; %bb.58:
	SLT ADD R2, R0, R6
.LBB33_59:
	SUB R5, R6, R5
	LDI R6, 2
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_61)
	SLT ADI R15, %lo(.LBB33_61)
	BRH C, R15
; %bb.60:
	SLT ADD R2, R0, R6
.LBB33_61:
	SUB R5, R6, R5
	RSH R3, R4, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB33_63)
	SLT ADI R15, %lo(.LBB33_63)
	BRH C, R15
; %bb.62:
	SLT ADD R2, R0, R6
.LBB33_63:
	SUB R5, R6, R5
	AND R3, R4, R3
	LSH R5, R4, R4
	NOR R3, R4, R3
	NOR R3, R3, R3
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB33_65)
	SLT ADI R15, %lo(.LBB33_65)
	BRH C, R15
; %bb.64:
	SLT ADD R2, R0, R1
.LBB33_65:
	SUB R3, R1, R1
.LBB33_66:
	SLT ADI R14, -4
	RET
.Lfunc_end33:
	.size	__umodsi3, .Lfunc_end33-__umodsi3
                                        ; -- End function
	.globl	strcmp                          ; -- Begin function strcmp
	.type	strcmp,@function
strcmp:                                 ; @strcmp
; %bb.0:
	SLT ADI R14, 28
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	INT STR R14, R13, -24
	LDI R4, 3
	AND R1, R4, R5
	LDI R3, 0
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB34_1)
	SLT ADI R15, %lo(.LBB34_1)
	BRH EQ, R15
.LBB34_9:                               ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R5, 0
	CHAR LOD R1, R6, 0
	SUB R6, R3, R0
	H LDI R15, %hi(.LBB34_11)
	SLT ADI R15, %lo(.LBB34_11)
	BRH EQ, R15
; %bb.10:                               ;   in Loop: Header=BB34_9 Depth=1
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB34_11)
	SLT ADI R15, %lo(.LBB34_11)
	BRH NE, R15
; %bb.8:                                ;   in Loop: Header=BB34_9 Depth=1
	ADI R2, 1
	ADI R1, 1
	AND R1, R4, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB34_9)
	SLT ADI R15, %lo(.LBB34_9)
	BRH NE, R15
.LBB34_1:
	LDI R5, 4095
	AND R1, R5, R4
	LDI R6, 4092
	SUB R6, R4, R0
	H LDI R15, %hi(.LBB34_13)
	SLT ADI R15, %lo(.LBB34_13)
	BRH C, R15
; %bb.2:
	AND R2, R5, R4
	SUB R6, R4, R0
	H LDI R15, %hi(.LBB34_13)
	SLT ADI R15, %lo(.LBB34_13)
	BRH C, R15
; %bb.3:
	LDI R11, 0
	H LDI R11, 32897
	SLT ADI R11, -32640
	LDI R4, 255
.LBB34_4:                               ; =>This Inner Loop Header: Depth=1
	INT LOD R1, R7, 0
	INT LOD R2, R8, 0
	LDI R9, 0
	H LDI R9, 257
	SLT ADI R9, 256
	SUB R9, R7, R12
	NOR R12, R7, R12
	NOR R12, R12, R12
	AND R12, R11, R12
	SUB R12, R11, R0
	H LDI R15, %hi(.LBB34_6)
	SLT ADI R15, %lo(.LBB34_6)
	BRH NE, R15
; %bb.5:                                ;   in Loop: Header=BB34_4 Depth=1
	SUB R7, R8, R0
	H LDI R15, %hi(.LBB34_28)
	SLT ADI R15, %lo(.LBB34_28)
	BRH EQ, R15
.LBB34_6:                               ;   in Loop: Header=BB34_4 Depth=1
	AND R7, R4, R12
	SUB R12, R3, R0
	H LDI R15, %hi(.LBB34_7)
	SLT ADI R15, %lo(.LBB34_7)
	BRH EQ, R15
; %bb.20:                               ;   in Loop: Header=BB34_4 Depth=1
	AND R8, R4, R9
	AND R7, R4, R10
	SLT ADD R7, R0, R12
	SLT ADD R8, R0, R13
	SUB R10, R9, R0
	H LDI R15, %hi(.LBB34_27)
	SLT ADI R15, %lo(.LBB34_27)
	BRH NE, R15
; %bb.21:                               ;   in Loop: Header=BB34_4 Depth=1
	LDI R9, 8
	RSH R8, R9, R13
	RSH R7, R9, R12
	AND R12, R4, R9
	SUB R9, R3, R0
	H LDI R15, %hi(.LBB34_27)
	SLT ADI R15, %lo(.LBB34_27)
	BRH EQ, R15
; %bb.22:                               ;   in Loop: Header=BB34_4 Depth=1
	AND R13, R4, R9
	AND R12, R4, R10
	SUB R10, R9, R0
	H LDI R15, %hi(.LBB34_27)
	SLT ADI R15, %lo(.LBB34_27)
	BRH NE, R15
; %bb.23:                               ;   in Loop: Header=BB34_4 Depth=1
	LDI R9, 16
	RSH R8, R9, R13
	RSH R7, R9, R12
	AND R12, R4, R9
	SUB R9, R3, R0
	H LDI R15, %hi(.LBB34_27)
	SLT ADI R15, %lo(.LBB34_27)
	BRH EQ, R15
; %bb.24:                               ;   in Loop: Header=BB34_4 Depth=1
	AND R13, R4, R9
	AND R12, R4, R10
	SUB R10, R9, R0
	H LDI R15, %hi(.LBB34_27)
	SLT ADI R15, %lo(.LBB34_27)
	BRH NE, R15
; %bb.25:                               ;   in Loop: Header=BB34_4 Depth=1
	LDI R9, 24
	RSH R8, R9, R13
	RSH R7, R9, R12
	SUB R12, R3, R0
	H LDI R15, %hi(.LBB34_27)
	SLT ADI R15, %lo(.LBB34_27)
	BRH EQ, R15
; %bb.26:                               ;   in Loop: Header=BB34_4 Depth=1
	SUB R12, R13, R0
	H LDI R15, %hi(.LBB34_27)
	SLT ADI R15, %lo(.LBB34_27)
	BRH NE, R15
.LBB34_28:                              ;   in Loop: Header=BB34_4 Depth=1
	ADI R2, 4
	ADI R1, 4
	AND R1, R5, R7
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB34_13)
	SLT ADI R15, %lo(.LBB34_13)
	BRH C, R15
; %bb.29:                               ;   in Loop: Header=BB34_4 Depth=1
	AND R2, R5, R7
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB34_4)
	SLT ADI R15, %lo(.LBB34_4)
	BRH NC, R15
.LBB34_13:
	CHAR LOD R1, R5, 0
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB34_19)
	SLT ADI R15, %lo(.LBB34_19)
	BRH EQ, R15
; %bb.14:                               ; %.preheader
	ADI R1, 1
	LDI R4, 255
.LBB34_15:                              ; =>This Inner Loop Header: Depth=1
	AND R5, R4, R6
	CHAR LOD R2, R7, 0
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB34_16)
	SLT ADI R15, %lo(.LBB34_16)
	BRH NE, R15
; %bb.17:                               ;   in Loop: Header=BB34_15 Depth=1
	ADI R2, 1
	CHAR LOD R1, R5, 0
	ADI R1, 1
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB34_15)
	SLT ADI R15, %lo(.LBB34_15)
	BRH NE, R15
	H LDI R15, %hi(.LBB34_18)
	SLT ADI R15, %lo(.LBB34_18)
	JMP R15
.LBB34_11:
	SUB R6, R5, R1
	H LDI R15, %hi(.LBB34_12)
	SLT ADI R15, %lo(.LBB34_12)
	JMP R15
.LBB34_16:
	SLT ADD R5, R0, R3
.LBB34_18:
	AND R3, R4, R3
.LBB34_19:
	CHAR LOD R2, R1, 0
	SUB R3, R1, R1
	H LDI R15, %hi(.LBB34_12)
	SLT ADI R15, %lo(.LBB34_12)
	JMP R15
.LBB34_7:
	SLT ADD R7, R0, R12
	SLT ADD R8, R0, R13
.LBB34_27:
	AND R13, R4, R1
	AND R12, R4, R2
	SUB R2, R1, R1
.LBB34_12:
	INT LOD R14, R13, -24
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -28
	RET
.Lfunc_end34:
	.size	strcmp, .Lfunc_end34-strcmp
                                        ; -- End function
	.globl	strlen                          ; -- Begin function strlen
	.type	strlen,@function
strlen:                                 ; @strlen
; %bb.0:
	SLT ADI R14, 12
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	LDI R4, 3
	AND R1, R4, R2
	LDI R3, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB35_1)
	SLT ADI R15, %lo(.LBB35_1)
	BRH EQ, R15
; %bb.8:
	SLT ADD R1, R0, R2
.LBB35_9:                               ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R5, 0
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB35_17)
	SLT ADI R15, %lo(.LBB35_17)
	BRH EQ, R15
; %bb.10:                               ;   in Loop: Header=BB35_9 Depth=1
	ADI R2, 1
	AND R2, R4, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB35_9)
	SLT ADI R15, %lo(.LBB35_9)
	BRH NE, R15
	H LDI R15, %hi(.LBB35_2)
	SLT ADI R15, %lo(.LBB35_2)
	JMP R15
.LBB35_1:
	SLT ADD R1, R0, R2
.LBB35_2:
	LDI R4, 4095
	AND R2, R4, R6
	LDI R5, 4092
	SUB R5, R6, R0
	H LDI R15, %hi(.LBB35_15)
	SLT ADI R15, %lo(.LBB35_15)
	BRH C, R15
; %bb.3:
	LDI R6, 0
	H LDI R6, 257
	SLT ADI R6, 256
	LDI R7, 0
	H LDI R7, 32897
	SLT ADI R7, -32640
.LBB35_4:                               ; =>This Inner Loop Header: Depth=1
	INT LOD R2, R8, 0
	SUB R6, R8, R9
	NOR R9, R8, R9
	NOR R9, R9, R9
	AND R9, R7, R9
	SUB R9, R7, R0
	H LDI R15, %hi(.LBB35_5)
	SLT ADI R15, %lo(.LBB35_5)
	BRH NE, R15
; %bb.14:                               ;   in Loop: Header=BB35_4 Depth=1
	ADI R2, 4
	AND R2, R4, R8
	SUB R5, R8, R0
	H LDI R15, %hi(.LBB35_4)
	SLT ADI R15, %lo(.LBB35_4)
	BRH NC, R15
.LBB35_15:
	ADI R2, -1
.LBB35_16:                              ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R4, 1
	ADI R2, 1
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB35_16)
	SLT ADI R15, %lo(.LBB35_16)
	BRH NE, R15
.LBB35_17:
	SUB R2, R1, R1
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -12
	RET
.LBB35_5:
	LDI R4, 255
	AND R8, R4, R4
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB35_17)
	SLT ADI R15, %lo(.LBB35_17)
	BRH EQ, R15
; %bb.6:
	LDI R4, 0
	H LDI R4, 1
	SLT ADI R4, -256
	AND R8, R4, R4
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB35_7)
	SLT ADI R15, %lo(.LBB35_7)
	BRH EQ, R15
; %bb.11:
	LDI R4, 0
	H LDI R4, 255
	SLT ADI R4, 0
	AND R8, R4, R4
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB35_12)
	SLT ADI R15, %lo(.LBB35_12)
	BRH EQ, R15
; %bb.13:
	ADI R2, 3
	H LDI R15, %hi(.LBB35_17)
	SLT ADI R15, %lo(.LBB35_17)
	JMP R15
.LBB35_7:
	ADI R2, 1
	H LDI R15, %hi(.LBB35_17)
	SLT ADI R15, %lo(.LBB35_17)
	JMP R15
.LBB35_12:
	ADI R2, 2
	H LDI R15, %hi(.LBB35_17)
	SLT ADI R15, %lo(.LBB35_17)
	JMP R15
.Lfunc_end35:
	.size	strlen, .Lfunc_end35-strlen
                                        ; -- End function
	.globl	memcmp                          ; -- Begin function memcmp
	.type	memcmp,@function
memcmp:                                 ; @memcmp
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R1, R0, R4
	LDI R1, 0
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB36_4)
	SLT ADI R15, %lo(.LBB36_4)
	BRH EQ, R15
.LBB36_2:                               ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R5, 0
	CHAR LOD R4, R6, 0
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB36_3)
	SLT ADI R15, %lo(.LBB36_3)
	BRH NE, R15
; %bb.1:                                ;   in Loop: Header=BB36_2 Depth=1
	ADI R4, 1
	ADI R2, 1
	ADI R3, -1
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB36_2)
	SLT ADI R15, %lo(.LBB36_2)
	BRH NE, R15
	H LDI R15, %hi(.LBB36_4)
	SLT ADI R15, %lo(.LBB36_4)
	JMP R15
.LBB36_3:
	SUB R6, R5, R1
.LBB36_4:
	SLT ADI R14, -4
	RET
.Lfunc_end36:
	.size	memcmp, .Lfunc_end36-memcmp
                                        ; -- End function
	.globl	strncpy                         ; -- Begin function strncpy
	.type	strncpy,@function
strncpy:                                ; @strncpy
; %bb.0:
	SLT ADI R14, 24
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	LDI R4, 0
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB37_30)
	SLT ADI R15, %lo(.LBB37_30)
	BRH EQ, R15
; %bb.1:
	LDI R6, 3
	AND R1, R6, R5
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB37_2)
	SLT ADI R15, %lo(.LBB37_2)
	BRH EQ, R15
; %bb.3:                                ; %.preheader9
	LDI R8, 1
	SLT ADD R1, R0, R5
.LBB37_4:                               ; =>This Inner Loop Header: Depth=1
	SLT ADD R3, R0, R7
	CHAR LOD R2, R3, 0
	CHAR STR R5, R3, 0
	ADI R5, 1
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB37_17)
	SLT ADI R15, %lo(.LBB37_17)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB37_4 Depth=1
	AND R5, R6, R9
	SLT ADD R7, R0, R3
	ADI R3, -1
	ADI R2, 1
	SUB R9, R4, R0
	H LDI R15, %hi(.LBB37_7)
	SLT ADI R15, %lo(.LBB37_7)
	BRH EQ, R15
; %bb.6:                                ;   in Loop: Header=BB37_4 Depth=1
	SUB R7, R8, R0
	H LDI R15, %hi(.LBB37_4)
	SLT ADI R15, %lo(.LBB37_4)
	BRH NE, R15
	H LDI R15, %hi(.LBB37_7)
	SLT ADI R15, %lo(.LBB37_7)
	JMP R15
.LBB37_2:
	SLT ADD R1, R0, R5
.LBB37_7:
	AND R2, R6, R7
	SUB R7, R4, R0
	H LDI R15, %hi(.LBB37_13)
	SLT ADI R15, %lo(.LBB37_13)
	BRH NE, R15
; %bb.8:
	LDI R7, 4
	SUB R3, R7, R0
	H LDI R15, %hi(.LBB37_13)
	SLT ADI R15, %lo(.LBB37_13)
	BRH C, R15
; %bb.9:                                ; %.preheader6
	LDI R7, 4095
	LDI R8, 4092
	LDI R9, 0
	H LDI R9, 257
	SLT ADI R9, 256
	LDI R10, 0
	H LDI R10, 32897
	SLT ADI R10, -32640
.LBB37_10:                              ; =>This Inner Loop Header: Depth=1
	AND R2, R7, R11
	SUB R8, R11, R0
	H LDI R15, %hi(.LBB37_14)
	SLT ADI R15, %lo(.LBB37_14)
	BRH C, R15
; %bb.11:                               ;   in Loop: Header=BB37_10 Depth=1
	INT LOD R2, R11, 0
	SUB R9, R11, R12
	NOR R12, R11, R12
	NOR R12, R12, R12
	AND R12, R10, R12
	SUB R12, R10, R0
	H LDI R15, %hi(.LBB37_14)
	SLT ADI R15, %lo(.LBB37_14)
	BRH NE, R15
; %bb.12:                               ;   in Loop: Header=BB37_10 Depth=1
	INT STR R5, R11, 0
	ADI R2, 4
	ADI R5, 4
	ADI R3, -4
	SUB R6, R3, R0
	H LDI R15, %hi(.LBB37_10)
	SLT ADI R15, %lo(.LBB37_10)
	BRH C, R15
.LBB37_13:
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB37_30)
	SLT ADI R15, %lo(.LBB37_30)
	BRH EQ, R15
.LBB37_14:
	ADI R5, 1
.LBB37_15:                              ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R7, 0
	CHAR STR R5, R7, -1
	SUB R7, R4, R0
	H LDI R15, %hi(.LBB37_16)
	SLT ADI R15, %lo(.LBB37_16)
	BRH EQ, R15
; %bb.31:                               ;   in Loop: Header=BB37_15 Depth=1
	ADI R5, 1
	ADI R2, 1
	ADI R3, -1
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB37_15)
	SLT ADI R15, %lo(.LBB37_15)
	BRH NE, R15
	H LDI R15, %hi(.LBB37_30)
	SLT ADI R15, %lo(.LBB37_30)
	JMP R15
.LBB37_16:
	SLT ADD R3, R0, R7
.LBB37_17:
	ADI R7, -1
	SUB R7, R4, R0
	H LDI R15, %hi(.LBB37_30)
	SLT ADI R15, %lo(.LBB37_30)
	BRH EQ, R15
; %bb.18:
	AND R5, R6, R2
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB37_22)
	SLT ADI R15, %lo(.LBB37_22)
	BRH EQ, R15
; %bb.19:
	LDI R2, 1
.LBB37_20:                              ; =>This Inner Loop Header: Depth=1
	SLT ADD R7, R0, R3
	ADI R7, -1
	CHAR STR R5, R4, 0
	ADI R5, 1
	AND R5, R6, R8
	SUB R8, R4, R0
	H LDI R15, %hi(.LBB37_22)
	SLT ADI R15, %lo(.LBB37_22)
	BRH EQ, R15
; %bb.21:                               ;   in Loop: Header=BB37_20 Depth=1
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB37_20)
	SLT ADI R15, %lo(.LBB37_20)
	BRH NE, R15
.LBB37_22:
	LDI R2, 4
	SUB R7, R2, R0
	H LDI R15, %hi(.LBB37_27)
	SLT ADI R15, %lo(.LBB37_27)
	BRH C, R15
; %bb.23:
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -4
	AND R7, R2, R2
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB37_26)
	SLT ADI R15, %lo(.LBB37_26)
	BRH EQ, R15
; %bb.24:                               ; %dynamic-memset-expansion-main-body.preheader
	SLT ADD R4, R0, R3
.LBB37_25:                              ; %dynamic-memset-expansion-main-body
                                        ; =>This Inner Loop Header: Depth=1
	ADD R5, R3, R8
	CHAR STR R8, R4, 0
	ADI R3, 1
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB37_25)
	SLT ADI R15, %lo(.LBB37_25)
	BRH C, R15
.LBB37_26:                              ; %dynamic-memset-post-expansion
	AND R7, R6, R7
	ADD R5, R2, R5
.LBB37_27:
	SUB R7, R4, R0
	H LDI R15, %hi(.LBB37_30)
	SLT ADI R15, %lo(.LBB37_30)
	BRH EQ, R15
; %bb.28:                               ; %dynamic-memset-expansion-main-body2.preheader
	SLT ADD R4, R0, R2
.LBB37_29:                              ; %dynamic-memset-expansion-main-body2
                                        ; =>This Inner Loop Header: Depth=1
	ADD R5, R2, R3
	CHAR STR R3, R4, 0
	ADI R2, 1
	SUB R2, R7, R0
	H LDI R15, %hi(.LBB37_29)
	SLT ADI R15, %lo(.LBB37_29)
	BRH C, R15
.LBB37_30:
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -24
	RET
.Lfunc_end37:
	.size	strncpy, .Lfunc_end37-strncpy
                                        ; -- End function
	.globl	strtok                          ; -- Begin function strtok
	.type	strtok,@function
strtok:                                 ; @strtok
; %bb.0:
	SLT ADI R14, 56
	INT STR R14, R8, -36
	INT STR R14, R9, -40
	INT STR R14, R10, -44
	INT STR R14, R11, -48
	INT STR R14, R12, -52
	SLT ADD R1, R0, R3
	LDI R1, 0
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB38_2)
	SLT ADI R15, %lo(.LBB38_2)
	BRH EQ, R15
; %bb.1:
	LDI R4, 0
	H LDI R4, strtok.last_token
	SLT ADI R4, strtok.last_token
	INT STR R4, R3, 0
	H LDI R15, %hi(.LBB38_3)
	SLT ADI R15, %lo(.LBB38_3)
	JMP R15
.LBB38_2:
	LDI R3, 0
	H LDI R3, strtok.last_token
	SLT ADI R3, strtok.last_token
	INT LOD R3, R3, 0
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB38_14)
	SLT ADI R15, %lo(.LBB38_14)
	BRH EQ, R15
.LBB38_3:
	CHAR LOD R3, R7, 0
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB38_14)
	SLT ADI R15, %lo(.LBB38_14)
	BRH EQ, R15
; %bb.4:
	ADD R14, R0, R4
	SLT ADI R4, -32
	INT STR R4, R1, 28
	INT STR R4, R1, 24
	INT STR R4, R1, 20
	INT STR R4, R1, 16
	INT STR R4, R1, 12
	INT STR R4, R1, 8
	INT STR R4, R1, 4
	INT STR R4, R1, 0
	CHAR LOD R2, R10, 0
	LDI R5, 31
	LDI R6, 3
	LDI R8, 28
	LDI R9, 1
	SUB R10, R1, R0
	H LDI R15, %hi(.LBB38_7)
	SLT ADI R15, %lo(.LBB38_7)
	BRH EQ, R15
; %bb.5:                                ; %.preheader2
	ADI R2, 1
.LBB38_6:                               ; =>This Inner Loop Header: Depth=1
	AND R10, R5, R11
	LSH R9, R11, R11
	RSH R10, R6, R10
	AND R10, R8, R10
	ADD R4, R10, R10
	INT LOD R10, R12, 0
	NOR R12, R11, R11
	NOR R11, R11, R11
	INT STR R10, R11, 0
	CHAR LOD R2, R10, 0
	ADI R2, 1
	SUB R10, R1, R0
	H LDI R15, %hi(.LBB38_6)
	SLT ADI R15, %lo(.LBB38_6)
	BRH NE, R15
.LBB38_7:
	ADI R3, 1
	LDI R2, 0
	H LDI R2, strtok.last_token
	SLT ADI R2, strtok.last_token
.LBB38_8:                               ; =>This Inner Loop Header: Depth=1
	AND R7, R5, R10
	RSH R7, R6, R11
	AND R11, R8, R11
	ADD R4, R11, R11
	INT LOD R11, R11, 0
	RSH R11, R10, R10
	AND R10, R9, R10
	SUB R10, R1, R0
	H LDI R15, %hi(.LBB38_9)
	SLT ADI R15, %lo(.LBB38_9)
	BRH EQ, R15
; %bb.15:                               ;   in Loop: Header=BB38_8 Depth=1
	INT STR R2, R3, 0
	CHAR LOD R3, R7, 0
	ADI R3, 1
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB38_8)
	SLT ADI R15, %lo(.LBB38_8)
	BRH NE, R15
	H LDI R15, %hi(.LBB38_14)
	SLT ADI R15, %lo(.LBB38_14)
	JMP R15
.LBB38_9:                               ; %.preheader
	SLT ADD R3, R0, R2
	ADI R2, -1
	LDI R10, 0
	H LDI R10, strtok.last_token
	SLT ADI R10, strtok.last_token
.LBB38_10:                              ; =>This Inner Loop Header: Depth=1
	AND R7, R5, R11
	RSH R7, R6, R7
	AND R7, R8, R7
	ADD R4, R7, R7
	INT LOD R7, R7, 0
	RSH R7, R11, R7
	AND R7, R9, R7
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB38_11)
	SLT ADI R15, %lo(.LBB38_11)
	BRH NE, R15
; %bb.12:                               ;   in Loop: Header=BB38_10 Depth=1
	INT STR R10, R3, 0
	CHAR LOD R3, R7, 0
	ADI R3, 1
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB38_10)
	SLT ADI R15, %lo(.LBB38_10)
	BRH NE, R15
	H LDI R15, %hi(.LBB38_13)
	SLT ADI R15, %lo(.LBB38_13)
	JMP R15
.LBB38_11:
	CHAR STR R3, R1, -1
	LDI R1, 0
	H LDI R1, strtok.last_token
	SLT ADI R1, strtok.last_token
	INT STR R1, R3, 0
.LBB38_13:
	SLT ADD R2, R0, R1
.LBB38_14:
	INT LOD R14, R12, -52
	INT LOD R14, R11, -48
	INT LOD R14, R10, -44
	INT LOD R14, R9, -40
	INT LOD R14, R8, -36
	SLT ADI R14, -56
	RET
.Lfunc_end38:
	.size	strtok, .Lfunc_end38-strtok
                                        ; -- End function
	.globl	allocatePool                    ; -- Begin function allocatePool
	.type	allocatePool,@function
allocatePool:                           ; @allocatePool
; %bb.0:
	SLT ADI R14, 40
	INT STR R14, R8, -16
	INT STR R14, R9, -20
	INT STR R14, R10, -24
	INT STR R14, R11, -28
	INT STR R14, R12, -32
	INT STR R14, R13, -36
	SLT ADD R1, R0, R4
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	SLT ADD R2, R0, R5
	ADI R5, -4089
	LDI R6, 0
	H LDI R6, 0
	SLT ADI R6, -4088
	SUB R5, R6, R0
	H LDI R15, %hi(.LBB39_20)
	SLT ADI R15, %lo(.LBB39_20)
	BRH C, R15
; %bb.1:
	LDI R5, 6
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB39_20)
	SLT ADI R15, %lo(.LBB39_20)
	BRH C, R15
; %bb.2:
	LDI R10, 0
	SUB R3, R10, R0
	H LDI R15, %hi(.LBB39_20)
	SLT ADI R15, %lo(.LBB39_20)
	BRH EQ, R15
; %bb.3:
	;APP
	CYE SR8, R1
	;NO_APP
	INT STR R14, R1, -8
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -5
	AND R1, R5, R1
	;APP
	CYR R1, SR8
	;NO_APP
	ADI R2, 3
	LDI R1, 8188
	AND R2, R1, R12
	LDI R7, 0
	H LDI R7, poolFreeList
	SLT ADI R7, poolFreeList
	SLT ADD R12, R0, R13
	ADI R13, 8
	LDI R1, 16
	LDI R2, 24
	LDI R11, 8
	SLT ADD R10, R0, R5
.LBB39_4:                               ; =>This Inner Loop Header: Depth=1
	SLT ADD R5, R0, R6
	CHAR LOD R7, R5, 2
	LSH R5, R1, R5
	CHAR LOD R7, R8, 3
	LSH R8, R2, R8
	NOR R8, R5, R5
	CHAR LOD R7, R8, 1
	LSH R8, R11, R8
	CHAR LOD R7, R7, 0
	NOR R8, R7, R7
	NOR R5, R5, R5
	NOR R7, R7, R7
	NOR R5, R7, R5
	NOR R5, R5, R5
	SUB R5, R10, R0
	H LDI R15, %hi(.LBB39_12)
	SLT ADI R15, %lo(.LBB39_12)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB39_4 Depth=1
	CHAR LOD R5, R7, 6
	LSH R7, R1, R7
	CHAR LOD R5, R8, 7
	LSH R8, R2, R8
	NOR R8, R7, R7
	CHAR LOD R5, R8, 5
	LSH R8, R11, R8
	CHAR LOD R5, R9, 4
	NOR R8, R9, R8
	NOR R7, R7, R7
	NOR R8, R8, R8
	NOR R7, R8, R7
	NOR R7, R7, R8
	SLT ADD R5, R0, R7
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB39_4)
	SLT ADI R15, %lo(.LBB39_4)
	BRH C, R15
; %bb.6:
	SLT ADD R12, R0, R4
	ADI R4, 12
	SUB R8, R4, R0
	H LDI R15, %hi(.LBB39_7)
	SLT ADI R15, %lo(.LBB39_7)
	BRH NC, R15
; %bb.9:
	CHAR LOD R5, R4, 2
	LSH R4, R1, R4
	CHAR LOD R5, R7, 3
	LSH R7, R2, R7
	NOR R7, R4, R4
	CHAR LOD R5, R7, 1
	LSH R7, R11, R7
	CHAR LOD R5, R8, 0
	NOR R7, R8, R7
	NOR R4, R4, R4
	NOR R7, R7, R7
	NOR R4, R7, R4
	NOR R4, R4, R4
	SUB R6, R10, R0
	H LDI R15, %hi(.LBB39_8)
	SLT ADI R15, %lo(.LBB39_8)
	BRH NE, R15
.LBB39_10:
	LDI R1, 0
	H LDI R1, poolFreeList
	SLT ADI R1, poolFreeList
	INT STR R1, R4, 0
	H LDI R15, %hi(.LBB39_11)
	SLT ADI R15, %lo(.LBB39_11)
	JMP R15
.LBB39_12:
	LDI R5, 0
	H LDI R5, poolRemaining
	SLT ADI R5, poolRemaining
	INT LOD R5, R6, 0
	LDI R5, 0
	H LDI R5, poolBump
	SLT ADI R5, poolBump
	INT LOD R5, R5, 0
	SUB R5, R10, R0
	H LDI R15, %hi(.LBB39_14)
	SLT ADI R15, %lo(.LBB39_14)
	BRH EQ, R15
; %bb.13:
	SUB R6, R13, R0
	H LDI R15, %hi(.LBB39_19)
	SLT ADI R15, %lo(.LBB39_19)
	BRH NC, R15
.LBB39_14:
	INT STR R14, R3, -4
	SUB R5, R10, R0
	H LDI R15, %hi(.LBB39_17)
	SLT ADI R15, %lo(.LBB39_17)
	BRH EQ, R15
; %bb.15:
	LDI R3, 12
	SUB R6, R3, R0
	H LDI R15, %hi(.LBB39_17)
	SLT ADI R15, %lo(.LBB39_17)
	BRH C, R15
; %bb.16:
	ADI R6, -8
	RSH R6, R2, R3
	CHAR STR R5, R3, 7
	RSH R6, R1, R3
	CHAR STR R5, R3, 6
	CHAR STR R5, R6, 4
	RSH R6, R11, R3
	CHAR STR R5, R3, 5
	LDI R3, 0
	H LDI R3, poolFreeList
	SLT ADI R3, poolFreeList
	INT LOD R3, R6, 0
	RSH R6, R2, R2
	CHAR STR R5, R2, 3
	RSH R6, R1, R1
	CHAR STR R5, R1, 2
	CHAR STR R5, R6, 0
	RSH R6, R11, R1
	CHAR STR R5, R1, 1
	INT STR R3, R5, 0
.LBB39_17:
	LDI R1, 0
	H LDI R1, poolRemaining
	SLT ADI R1, poolRemaining
	INT STR R1, R10, 0
	LDI R1, 0
	H LDI R1, poolBump
	SLT ADI R1, poolBump
	INT STR R1, R10, 0
	ADD R14, R0, R8
	SLT ADI R8, -12
	INT STR R8, R10, 0
	LDI R3, 1
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	SLT ADD R4, R0, R2
	SLT ADD R8, R0, R4
	H LDI R15, %hi(allocatePages)
	SLT ADI R15, %lo(allocatePages)
	CAL R15
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB39_18)
	SLT ADI R15, %lo(.LBB39_18)
	BRH EQ, R15
; %bb.21:
	INT LOD R14, R1, -8
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	H LDI R15, %hi(.LBB39_20)
	SLT ADI R15, %lo(.LBB39_20)
	JMP R15
.LBB39_7:
	SUB R8, R12, R7
	ADI R7, -8
	RSH R7, R2, R8
	ADD R5, R12, R4
	CHAR STR R4, R8, 15
	RSH R7, R1, R8
	CHAR STR R4, R8, 14
	CHAR STR R4, R7, 12
	RSH R7, R11, R7
	CHAR STR R4, R7, 13
	CHAR LOD R5, R7, 0
	CHAR LOD R5, R8, 1
	CHAR LOD R5, R9, 2
	CHAR LOD R5, R13, 3
	CHAR STR R4, R13, 11
	CHAR STR R4, R9, 10
	CHAR STR R4, R8, 9
	CHAR STR R4, R7, 8
	RSH R12, R11, R7
	CHAR STR R5, R12, 4
	CHAR STR R5, R7, 5
	CHAR STR R5, R10, 6
	CHAR STR R5, R10, 7
	ADI R4, 8
	SUB R6, R10, R0
	H LDI R15, %hi(.LBB39_10)
	SLT ADI R15, %lo(.LBB39_10)
	BRH EQ, R15
.LBB39_8:
	RSH R4, R2, R2
	CHAR STR R6, R2, 3
	RSH R4, R1, R1
	CHAR STR R6, R1, 2
	CHAR STR R6, R4, 0
	RSH R4, R11, R1
	CHAR STR R6, R1, 1
.LBB39_11:
	ADI R5, 8
	INT STR R3, R5, 0
	INT LOD R14, R1, -8
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R15, %hi(.LBB39_20)
	SLT ADI R15, %lo(.LBB39_20)
	JMP R15
.LBB39_18:
	LDI R6, 4096
	INT LOD R8, R5, 0
	INT LOD R14, R3, -4
.LBB39_19:
	RSH R12, R11, R1
	CHAR STR R5, R12, 4
	CHAR STR R5, R1, 5
	CHAR STR R5, R10, 3
	CHAR STR R5, R10, 2
	CHAR STR R5, R10, 1
	CHAR STR R5, R10, 0
	CHAR STR R5, R10, 7
	CHAR STR R5, R10, 6
	SUB R6, R13, R1
	LDI R2, 0
	H LDI R2, poolRemaining
	SLT ADI R2, poolRemaining
	INT STR R2, R1, 0
	ADD R5, R13, R1
	LDI R2, 0
	H LDI R2, poolBump
	SLT ADI R2, poolBump
	INT STR R2, R1, 0
	ADI R5, 8
	INT STR R3, R5, 0
	INT LOD R14, R1, -8
	;APP
	CYR R1, SR8
	;NO_APP
	SLT ADD R10, R0, R1
.LBB39_20:
	INT LOD R14, R13, -36
	INT LOD R14, R12, -32
	INT LOD R14, R11, -28
	INT LOD R14, R10, -24
	INT LOD R14, R9, -20
	INT LOD R14, R8, -16
	SLT ADI R14, -40
	RET
.Lfunc_end39:
	.size	allocatePool, .Lfunc_end39-allocatePool
                                        ; -- End function
	.globl	allocatePages                   ; -- Begin function allocatePages
	.type	allocatePages,@function
allocatePages:                          ; @allocatePages
; %bb.0:
	SLT ADI R14, 52
	INT STR R14, R8, -28
	INT STR R14, R9, -32
	INT STR R14, R10, -36
	INT STR R14, R11, -40
	INT STR R14, R12, -44
	INT STR R14, R13, -48
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -1
	LDI R8, 0
	SUB R3, R8, R0
	H LDI R15, %hi(.LBB40_27)
	SLT ADI R15, %lo(.LBB40_27)
	BRH EQ, R15
; %bb.1:
	LDI R7, 6
	SUB R7, R2, R0
	H LDI R15, %hi(.LBB40_27)
	SLT ADI R15, %lo(.LBB40_27)
	BRH C, R15
; %bb.2:
	SUB R4, R8, R0
	H LDI R15, %hi(.LBB40_27)
	SLT ADI R15, %lo(.LBB40_27)
	BRH EQ, R15
; %bb.3:
	INT STR R14, R2, -20
	;APP
	CYE SR8, R5
	;NO_APP
	INT STR R14, R5, -24
	;APP
	CYE SR8, R5
	;NO_APP
	LDI R6, 0
	H LDI R6, 0
	SLT ADI R6, -5
	AND R5, R6, R5
	;APP
	CYR R5, SR8
	;NO_APP
	LDI R5, 0
	H LDI R5, varMap
	SLT ADI R5, varMap
	INT LOD R5, R2, 0
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB40_5)
	SLT ADI R15, %lo(.LBB40_5)
	BRH EQ, R15
; %bb.4:
	LDI R5, 0
	H LDI R5, mapEntries
	SLT ADI R5, mapEntries
	INT LOD R5, R7, 0
	SUB R7, R8, R0
	H LDI R15, %hi(.LBB40_6)
	SLT ADI R15, %lo(.LBB40_6)
	BRH NE, R15
	H LDI R15, %hi(.LBB40_25)
	SLT ADI R15, %lo(.LBB40_25)
	JMP R15
.LBB40_5:
	LDI R2, 8192
	INT STR R5, R2, 0
	INT STR R2, R2, 0
	LDI R5, 255
	LDI R9, 8196
	INT STR R9, R5, 0
	LDI R9, 4096
	LDI R10, 8200
	INT STR R10, R9, 0
	LDI R10, 1
	LDI R11, 8204
	INT STR R11, R10, 0
	LDI R11, 0
	H LDI R11, 65248
	SLT ADI R11, -12288
	LDI R12, 8208
	INT STR R12, R11, 0
	LDI R11, 8212
	INT STR R11, R5, 0
	LDI R11, 8216
	INT STR R11, R9, 0
	LDI R9, 8220
	INT STR R9, R7, 0
	LDI R9, 0
	H LDI R9, 272
	SLT ADI R9, -4096
	LDI R11, 8224
	INT STR R11, R9, 0
	LDI R9, 8228
	INT STR R9, R5, 0
	LDI R5, 0
	H LDI R5, 16
	SLT ADI R5, 0
	LDI R9, 8232
	INT STR R9, R5, 0
	LDI R5, 8236
	INT STR R5, R10, 0
	LDI R5, 0
	H LDI R5, mapEntries
	SLT ADI R5, mapEntries
	INT STR R5, R7, 0
.LBB40_6:
	LDI R5, 12
	LSH R3, R5, R3
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -1
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB40_17)
	SLT ADI R15, %lo(.LBB40_17)
	BRH EQ, R15
; %bb.7:
	LDI R5, 4095
	AND R1, R5, R5
	SUB R5, R8, R0
	H LDI R15, %hi(.LBB40_25)
	SLT ADI R15, %lo(.LBB40_25)
	BRH NE, R15
; %bb.8:                                ; %.preheader6
	ADD R3, R1, R5
	INT STR R14, R5, -16
	LDI R9, 0
	SLT ADD R2, R0, R12
	ADI R12, 4
	LDI R13, 255
	SLT ADD R9, R0, R5
	H LDI R15, %hi(.LBB40_11)
	SLT ADI R15, %lo(.LBB40_11)
	JMP R15
.LBB40_9:                               ;   in Loop: Header=BB40_11 Depth=1
	ADD R10, R5, R5
.LBB40_10:                              ;   in Loop: Header=BB40_11 Depth=1
	ADI R12, 8
	ADI R9, 1
	SUB R7, R9, R0
	H LDI R15, %hi(.LBB40_25)
	SLT ADI R15, %lo(.LBB40_25)
	BRH EQ, R15
.LBB40_11:                              ; =>This Inner Loop Header: Depth=1
	INT LOD R12, R10, -4
	INT LOD R12, R11, 0
	SUB R11, R13, R0
	H LDI R15, %hi(.LBB40_9)
	SLT ADI R15, %lo(.LBB40_9)
	BRH NE, R15
; %bb.12:                               ;   in Loop: Header=BB40_11 Depth=1
	ADD R10, R5, R11
	SUB R10, R3, R0
	H LDI R15, %hi(.LBB40_16)
	SLT ADI R15, %lo(.LBB40_16)
	BRH C, R15
; %bb.13:                               ;   in Loop: Header=BB40_11 Depth=1
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB40_16)
	SLT ADI R15, %lo(.LBB40_16)
	BRH C, R15
; %bb.14:                               ;   in Loop: Header=BB40_11 Depth=1
	SLT ADD R11, R0, R5
	INT LOD R14, R6, -16
	SUB R11, R6, R0
	H LDI R15, %hi(.LBB40_10)
	SLT ADI R15, %lo(.LBB40_10)
	BRH C, R15
	H LDI R15, %hi(.LBB40_21)
	SLT ADI R15, %lo(.LBB40_21)
	JMP R15
.LBB40_16:                              ;   in Loop: Header=BB40_11 Depth=1
	SLT ADD R11, R0, R5
	H LDI R15, %hi(.LBB40_10)
	SLT ADI R15, %lo(.LBB40_10)
	JMP R15
.LBB40_17:                              ; %.preheader3
	LDI R9, 0
	SLT ADD R2, R0, R5
	ADI R5, 4
	LDI R11, 255
	SLT ADD R9, R0, R1
	H LDI R15, %hi(.LBB40_19)
	SLT ADI R15, %lo(.LBB40_19)
	JMP R15
.LBB40_18:                              ;   in Loop: Header=BB40_19 Depth=1
	ADD R10, R1, R1
	ADI R5, 8
	ADI R9, 1
	SUB R7, R9, R0
	H LDI R15, %hi(.LBB40_25)
	SLT ADI R15, %lo(.LBB40_25)
	BRH EQ, R15
.LBB40_19:                              ; =>This Inner Loop Header: Depth=1
	INT LOD R5, R10, -4
	INT LOD R5, R12, 0
	SUB R12, R11, R0
	H LDI R15, %hi(.LBB40_18)
	SLT ADI R15, %lo(.LBB40_18)
	BRH NE, R15
; %bb.20:                               ;   in Loop: Header=BB40_19 Depth=1
	SUB R10, R3, R0
	H LDI R15, %hi(.LBB40_18)
	SLT ADI R15, %lo(.LBB40_18)
	BRH C, R15
.LBB40_21:
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -1
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB40_25)
	SLT ADI R15, %lo(.LBB40_25)
	BRH EQ, R15
; %bb.22:
	INT STR R14, R4, -16
	SUB R9, R8, R0
	H LDI R15, %hi(.LBB40_28)
	SLT ADI R15, %lo(.LBB40_28)
	BRH EQ, R15
; %bb.23:                               ; %.preheader1
	SLT ADD R2, R0, R5
	SLT ADD R9, R0, R12
	SLT ADD R8, R0, R11
.LBB40_24:                              ; =>This Inner Loop Header: Depth=1
	INT LOD R5, R4, 0
	ADD R4, R11, R11
	ADI R5, 8
	ADI R12, -1
	SUB R12, R8, R0
	H LDI R15, %hi(.LBB40_24)
	SLT ADI R15, %lo(.LBB40_24)
	BRH NE, R15
	H LDI R15, %hi(.LBB40_29)
	SLT ADI R15, %lo(.LBB40_29)
	JMP R15
.LBB40_25:
	INT LOD R14, R1, -24
	;APP
	CYR R1, SR8
	;NO_APP
.LBB40_26:
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -1
.LBB40_27:
	SLT ADD R5, R0, R1
	INT LOD R14, R13, -48
	INT LOD R14, R12, -44
	INT LOD R14, R11, -40
	INT LOD R14, R10, -36
	INT LOD R14, R9, -32
	INT LOD R14, R8, -28
	SLT ADI R14, -52
	RET
.LBB40_28:
	SLT ADD R8, R0, R11
.LBB40_29:
	LDI R5, 1
	SLT ADD R5, R0, R12
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB40_31)
	SLT ADI R15, %lo(.LBB40_31)
	BRH NE, R15
; %bb.30:
	SLT ADD R8, R0, R12
.LBB40_31:
	SUB R1, R11, R13
	ADD R13, R3, R4
	SUB R10, R4, R0
	H LDI R15, %hi(.LBB40_33)
	SLT ADI R15, %lo(.LBB40_33)
	BRH NE, R15
; %bb.32:
	SLT ADD R8, R0, R5
.LBB40_33:
	ADD R5, R12, R5
	ADD R5, R7, R8
	LDI R12, 512
	SUB R12, R8, R0
	H LDI R15, %hi(.LBB40_35)
	SLT ADI R15, %lo(.LBB40_35)
	BRH NC, R15
; %bb.34:
	INT LOD R14, R1, -24
	;APP
	CYR R1, SR8
	;NO_APP
	H LDI R15, %hi(.LBB40_26)
	SLT ADI R15, %lo(.LBB40_26)
	JMP R15
.LBB40_35:
	INT STR R14, R13, -4
	INT STR R14, R8, -12
	INT STR R14, R4, -8
	LDI R12, 0
	SUB R5, R12, R0
	H LDI R15, %hi(.LBB40_39)
	SLT ADI R15, %lo(.LBB40_39)
	BRH EQ, R15
; %bb.36:
	ADD R5, R9, R4
	INT LOD R14, R5, -12
	ADI R5, -1
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB40_39)
	SLT ADI R15, %lo(.LBB40_39)
	BRH NC, R15
; %bb.37:                               ; %.preheader
	INT LOD R14, R8, -12
	LDI R12, 3
	SLT ADD R12, R0, R13
	LSH R8, R13, R12
	LSH R7, R13, R7
	ADD R7, R2, R7
	ADD R12, R2, R12
	ADI R12, -8
	ADI R7, -8
.LBB40_38:                              ; =>This Inner Loop Header: Depth=1
	INT LOD R7, R8, 0
	INT LOD R7, R13, 4
	INT STR R12, R13, 4
	INT STR R12, R8, 0
	ADI R12, -8
	ADI R7, -8
	ADI R5, -1
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB40_38)
	SLT ADI R15, %lo(.LBB40_38)
	BRH C, R15
.LBB40_39:
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB40_41)
	SLT ADI R15, %lo(.LBB40_41)
	BRH EQ, R15
; %bb.40:
	LDI R11, 3
	LSH R9, R11, R4
	ADD R2, R4, R4
	LDI R5, 255
	INT STR R4, R5, 4
	INT LOD R14, R5, -4
	INT STR R4, R5, 0
	ADI R9, 1
	INT LOD R14, R7, -24
	INT LOD R14, R8, -8
	H LDI R15, %hi(.LBB40_42)
	SLT ADI R15, %lo(.LBB40_42)
	JMP R15
.LBB40_41:
	INT LOD R14, R7, -24
	INT LOD R14, R8, -8
	LDI R11, 3
.LBB40_42:
	INT LOD R14, R6, -20
	LSH R9, R11, R4
	ADD R2, R4, R5
	INT STR R5, R6, 4
	INT STR R5, R3, 0
	SUB R10, R8, R0
	H LDI R15, %hi(.LBB40_44)
	SLT ADI R15, %lo(.LBB40_44)
	BRH EQ, R15
; %bb.43:
	SUB R10, R8, R2
	LDI R3, 255
	INT STR R5, R3, 12
	INT STR R5, R2, 8
.LBB40_44:
	LDI R2, 0
	H LDI R2, mapEntries
	SLT ADI R2, mapEntries
	INT LOD R14, R3, -12
	INT STR R2, R3, 0
	INT LOD R14, R2, -16
	INT STR R2, R1, 0
	;APP
	CYR R7, SR8
	;NO_APP
	LDI R5, 0
	H LDI R15, %hi(.LBB40_27)
	SLT ADI R15, %lo(.LBB40_27)
	JMP R15
.Lfunc_end40:
	.size	allocatePages, .Lfunc_end40-allocatePages
                                        ; -- End function
	.globl	freePool                        ; -- Begin function freePool
	.type	freePool,@function
freePool:                               ; @freePool
; %bb.0:
	SLT ADI R14, 36
	INT STR R14, R8, -12
	INT STR R14, R9, -16
	INT STR R14, R10, -20
	INT STR R14, R11, -24
	INT STR R14, R12, -28
	INT STR R14, R13, -32
	LDI R9, 0
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB41_29)
	SLT ADI R15, %lo(.LBB41_29)
	BRH EQ, R15
; %bb.1:
	INT LOD R1, R2, 0
	SUB R2, R9, R0
	H LDI R15, %hi(.LBB41_29)
	SLT ADI R15, %lo(.LBB41_29)
	BRH EQ, R15
; %bb.2:
	;APP
	CYE SR8, R8
	;NO_APP
	;APP
	CYE SR8, R2
	;NO_APP
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -5
	AND R2, R3, R2
	;APP
	CYR R2, SR8
	;NO_APP
	INT LOD R1, R2, 0
	INT STR R1, R9, 0
	LDI R3, 0
	H LDI R3, poolFreeList
	SLT ADI R3, poolFreeList
	SLT ADD R2, R0, R10
	ADI R10, -8
	LDI R13, 16
	LDI R12, 24
	LDI R11, 8
	SLT ADD R9, R0, R4
.LBB41_3:                               ; =>This Inner Loop Header: Depth=1
	SLT ADD R4, R0, R1
	CHAR LOD R3, R4, 2
	LSH R4, R13, R4
	CHAR LOD R3, R5, 3
	LSH R5, R12, R5
	NOR R5, R4, R4
	CHAR LOD R3, R5, 1
	LSH R5, R11, R5
	CHAR LOD R3, R3, 0
	NOR R5, R3, R3
	NOR R4, R4, R4
	NOR R3, R3, R3
	NOR R4, R3, R3
	NOR R3, R3, R4
	SUB R4, R9, R0
	H LDI R15, %hi(.LBB41_5)
	SLT ADI R15, %lo(.LBB41_5)
	BRH EQ, R15
; %bb.4:                                ;   in Loop: Header=BB41_3 Depth=1
	SLT ADD R4, R0, R3
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB41_3)
	SLT ADI R15, %lo(.LBB41_3)
	BRH C, R15
.LBB41_5:
	RSH R4, R12, R3
	CHAR STR R10, R3, 3
	RSH R4, R13, R3
	CHAR STR R10, R3, 2
	CHAR STR R10, R4, 0
	RSH R4, R11, R3
	CHAR STR R10, R3, 1
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB41_7)
	SLT ADI R15, %lo(.LBB41_7)
	BRH EQ, R15
; %bb.6:
	RSH R10, R12, R3
	CHAR STR R1, R3, 3
	RSH R10, R13, R3
	CHAR STR R1, R3, 2
	CHAR STR R1, R10, 0
	RSH R10, R11, R3
	CHAR STR R1, R3, 1
	H LDI R15, %hi(.LBB41_8)
	SLT ADI R15, %lo(.LBB41_8)
	JMP R15
.LBB41_7:
	LDI R3, 0
	H LDI R3, poolFreeList
	SLT ADI R3, poolFreeList
	INT STR R3, R10, 0
.LBB41_8:
	CHAR LOD R10, R3, 2
	LSH R3, R13, R3
	CHAR LOD R10, R4, 3
	LSH R4, R12, R4
	NOR R4, R3, R3
	CHAR LOD R10, R4, 1
	LSH R4, R11, R4
	CHAR LOD R10, R5, 0
	NOR R4, R5, R4
	NOR R3, R3, R3
	NOR R4, R4, R4
	NOR R3, R4, R3
	NOR R3, R3, R4
	LDI R3, 4095
	SUB R4, R9, R0
	H LDI R15, %hi(.LBB41_9)
	SLT ADI R15, %lo(.LBB41_9)
	BRH EQ, R15
; %bb.10:
	CHAR LOD R2, R5, -2
	LSH R5, R13, R5
	CHAR LOD R2, R6, -1
	LSH R6, R12, R6
	NOR R6, R5, R5
	CHAR LOD R2, R6, -3
	LSH R6, R11, R6
	CHAR LOD R2, R7, -4
	NOR R6, R7, R6
	NOR R5, R5, R5
	NOR R6, R6, R6
	NOR R5, R6, R5
	NOR R5, R5, R5
	ADD R2, R5, R6
	SUB R6, R4, R0
	H LDI R15, %hi(.LBB41_13)
	SLT ADI R15, %lo(.LBB41_13)
	BRH NE, R15
; %bb.11:
	XOR R4, R10, R6
	SUB R3, R6, R0
	H LDI R15, %hi(.LBB41_13)
	SLT ADI R15, %lo(.LBB41_13)
	BRH C, R15
; %bb.12:
	CHAR LOD R4, R6, 6
	LSH R6, R13, R6
	CHAR LOD R4, R7, 7
	LSH R7, R12, R7
	NOR R7, R6, R6
	CHAR LOD R4, R7, 5
	LSH R7, R11, R7
	SLT ADD R8, R0, R3
	CHAR LOD R4, R8, 4
	NOR R7, R8, R7
	NOR R6, R6, R6
	NOR R7, R7, R7
	NOR R6, R7, R6
	NOR R6, R6, R6
	ADD R5, R6, R5
	ADI R5, 8
	RSH R5, R12, R6
	CHAR STR R2, R6, -1
	RSH R5, R13, R6
	CHAR STR R2, R6, -2
	CHAR STR R2, R5, -4
	RSH R5, R11, R5
	CHAR STR R2, R5, -3
	CHAR LOD R4, R5, 3
	LSH R5, R12, R6
	CHAR LOD R4, R7, 0
	CHAR LOD R4, R8, 1
	CHAR LOD R4, R4, 2
	CHAR STR R2, R5, -5
	LSH R4, R13, R5
	CHAR STR R2, R4, -6
	CHAR STR R2, R8, -7
	CHAR STR R2, R7, -8
	NOR R6, R5, R4
	LSH R8, R11, R5
	SLT ADD R3, R0, R8
	LDI R3, 4095
	NOR R5, R7, R5
	NOR R4, R4, R4
	NOR R5, R5, R5
	NOR R4, R5, R4
	NOR R4, R4, R4
.LBB41_13:
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB41_14)
	SLT ADI R15, %lo(.LBB41_14)
	BRH NE, R15
	H LDI R15, %hi(.LBB41_17)
	SLT ADI R15, %lo(.LBB41_17)
	JMP R15
.LBB41_9:
	SLT ADD R9, R0, R4
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB41_17)
	SLT ADI R15, %lo(.LBB41_17)
	BRH EQ, R15
.LBB41_14:
	CHAR LOD R1, R5, 6
	LSH R5, R13, R5
	CHAR LOD R1, R6, 7
	LSH R6, R12, R6
	NOR R6, R5, R5
	CHAR LOD R1, R6, 5
	LSH R6, R11, R6
	CHAR LOD R1, R7, 4
	NOR R6, R7, R6
	NOR R5, R5, R5
	NOR R6, R6, R6
	NOR R5, R6, R5
	NOR R5, R5, R5
	ADD R1, R5, R6
	ADI R6, 8
	SUB R6, R10, R0
	H LDI R15, %hi(.LBB41_17)
	SLT ADI R15, %lo(.LBB41_17)
	BRH NE, R15
; %bb.15:
	XOR R1, R10, R6
	SUB R3, R6, R0
	H LDI R15, %hi(.LBB41_17)
	SLT ADI R15, %lo(.LBB41_17)
	BRH C, R15
; %bb.16:
	CHAR LOD R2, R6, -2
	LSH R6, R13, R6
	CHAR LOD R2, R7, -1
	LSH R7, R12, R7
	NOR R7, R6, R6
	CHAR LOD R2, R7, -3
	LSH R7, R11, R7
	CHAR LOD R2, R2, -4
	NOR R7, R2, R2
	NOR R6, R6, R6
	NOR R2, R2, R2
	NOR R6, R2, R2
	NOR R2, R2, R2
	ADD R5, R2, R2
	RSH R4, R13, R5
	CHAR STR R1, R5, 2
	RSH R4, R12, R5
	CHAR STR R1, R5, 3
	CHAR STR R1, R4, 0
	RSH R4, R11, R4
	CHAR STR R1, R4, 1
	ADI R2, 8
	RSH R2, R13, R4
	CHAR STR R1, R4, 6
	RSH R2, R12, R4
	CHAR STR R1, R4, 7
	CHAR STR R1, R2, 4
	RSH R2, R11, R2
	CHAR STR R1, R2, 5
	SLT ADD R1, R0, R10
.LBB41_17:
	AND R10, R3, R1
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB41_28)
	SLT ADI R15, %lo(.LBB41_28)
	BRH NE, R15
; %bb.18:
	CHAR LOD R10, R1, 6
	LSH R1, R13, R1
	CHAR LOD R10, R2, 7
	LSH R2, R12, R2
	NOR R2, R1, R1
	CHAR LOD R10, R2, 5
	LSH R2, R11, R2
	CHAR LOD R10, R3, 4
	NOR R2, R3, R2
	NOR R1, R1, R1
	NOR R2, R2, R2
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 4088
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB41_28)
	SLT ADI R15, %lo(.LBB41_28)
	BRH NE, R15
; %bb.19:
	INT STR R14, R8, -4
	ADD R14, R0, R8
	SLT ADI R8, -8
	INT STR R8, R10, 0
	LDI R1, 1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(freePages)
	SLT ADI R15, %lo(freePages)
	CAL R15
	INT LOD R8, R1, 0
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB41_27)
	SLT ADI R15, %lo(.LBB41_27)
	BRH NE, R15
; %bb.20:
	LDI R1, 0
	H LDI R1, poolFreeList
	SLT ADI R1, poolFreeList
	INT LOD R1, R2, 0
	SUB R10, R2, R0
	H LDI R15, %hi(.LBB41_21)
	SLT ADI R15, %lo(.LBB41_21)
	BRH EQ, R15
.LBB41_22:                              ; =>This Inner Loop Header: Depth=1
	SLT ADD R2, R0, R1
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB41_25)
	SLT ADI R15, %lo(.LBB41_25)
	BRH EQ, R15
; %bb.23:                               ;   in Loop: Header=BB41_22 Depth=1
	CHAR LOD R1, R2, 2
	LSH R2, R13, R2
	CHAR LOD R1, R3, 3
	LSH R3, R12, R3
	NOR R3, R2, R2
	CHAR LOD R1, R3, 1
	LSH R3, R11, R3
	CHAR LOD R1, R4, 0
	NOR R3, R4, R3
	NOR R2, R2, R2
	NOR R3, R3, R3
	NOR R2, R3, R2
	NOR R2, R2, R2
	SUB R2, R10, R0
	H LDI R15, %hi(.LBB41_22)
	SLT ADI R15, %lo(.LBB41_22)
	BRH NE, R15
; %bb.24:
	CHAR LOD R10, R2, 1
	CHAR LOD R10, R3, 0
	CHAR LOD R10, R4, 3
	CHAR LOD R10, R5, 2
	CHAR STR R1, R5, 2
	CHAR STR R1, R4, 3
	CHAR STR R1, R3, 0
	CHAR STR R1, R2, 1
	H LDI R15, %hi(.LBB41_25)
	SLT ADI R15, %lo(.LBB41_25)
	JMP R15
.LBB41_21:
	CHAR LOD R10, R2, 2
	LSH R2, R13, R2
	CHAR LOD R10, R3, 3
	LSH R3, R12, R3
	NOR R3, R2, R2
	CHAR LOD R10, R3, 1
	LSH R3, R11, R3
	CHAR LOD R10, R4, 0
	NOR R3, R4, R3
	NOR R2, R2, R2
	NOR R3, R3, R3
	NOR R2, R3, R2
	NOR R2, R2, R2
	INT STR R1, R2, 0
.LBB41_25:
	LDI R1, 0
	H LDI R1, poolBump
	SLT ADI R1, poolBump
	INT LOD R1, R2, 0
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -4096
	AND R2, R3, R2
	SUB R2, R10, R0
	H LDI R15, %hi(.LBB41_27)
	SLT ADI R15, %lo(.LBB41_27)
	BRH NE, R15
; %bb.26:
	LDI R2, 0
	H LDI R2, poolRemaining
	SLT ADI R2, poolRemaining
	INT STR R2, R9, 0
	INT STR R1, R9, 0
.LBB41_27:
	INT LOD R14, R8, -4
.LBB41_28:
	;APP
	CYR R8, SR8
	;NO_APP
.LBB41_29:
	INT LOD R14, R13, -32
	INT LOD R14, R12, -28
	INT LOD R14, R11, -24
	INT LOD R14, R10, -20
	INT LOD R14, R9, -16
	INT LOD R14, R8, -12
	SLT ADI R14, -36
	RET
.Lfunc_end41:
	.size	freePool, .Lfunc_end41-freePool
                                        ; -- End function
	.globl	freePages                       ; -- Begin function freePages
	.type	freePages,@function
freePages:                              ; @freePages
; %bb.0:
	SLT ADI R14, 56
	INT STR R14, R8, -32
	INT STR R14, R9, -36
	INT STR R14, R10, -40
	INT STR R14, R11, -44
	INT STR R14, R12, -48
	INT STR R14, R13, -52
	LDI R3, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB42_28)
	SLT ADI R15, %lo(.LBB42_28)
	BRH EQ, R15
; %bb.1:
	SUB R1, R3, R0
	H LDI R15, %hi(.LBB42_28)
	SLT ADI R15, %lo(.LBB42_28)
	BRH EQ, R15
; %bb.2:
	INT LOD R2, R4, 0
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB42_28)
	SLT ADI R15, %lo(.LBB42_28)
	BRH EQ, R15
; %bb.3:
	INT STR R14, R2, -28
	;APP
	CYE SR8, R2
	;NO_APP
	;APP
	CYE SR8, R4
	;NO_APP
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -5
	AND R4, R5, R4
	;APP
	CYR R4, SR8
	;NO_APP
	LDI R4, 0
	H LDI R4, varMap
	SLT ADI R4, varMap
	INT LOD R4, R5, 0
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB42_4)
	SLT ADI R15, %lo(.LBB42_4)
	BRH EQ, R15
; %bb.5:
	LDI R4, 0
	H LDI R4, mapEntries
	SLT ADI R4, mapEntries
	INT LOD R4, R10, 0
	SUB R10, R3, R0
	H LDI R15, %hi(.LBB42_6)
	SLT ADI R15, %lo(.LBB42_6)
	BRH NE, R15
.LBB42_10:
	;APP
	CYR R2, SR8
	;NO_APP
	H LDI R15, %hi(.LBB42_28)
	SLT ADI R15, %lo(.LBB42_28)
	JMP R15
.LBB42_4:
	LDI R5, 8192
	INT STR R4, R5, 0
	INT STR R5, R5, 0
	LDI R4, 255
	LDI R5, 8196
	INT STR R5, R4, 0
	LDI R5, 4096
	LDI R6, 8200
	INT STR R6, R5, 0
	LDI R6, 1
	LDI R7, 8204
	INT STR R7, R6, 0
	LDI R7, 0
	H LDI R7, 65248
	SLT ADI R7, -12288
	LDI R8, 8208
	INT STR R8, R7, 0
	LDI R7, 8212
	INT STR R7, R4, 0
	LDI R7, 8216
	INT STR R7, R5, 0
	LDI R10, 6
	LDI R5, 8220
	INT STR R5, R10, 0
	LDI R5, 0
	H LDI R5, 272
	SLT ADI R5, -4096
	LDI R7, 8224
	INT STR R7, R5, 0
	LDI R5, 8228
	INT STR R5, R4, 0
	LDI R4, 0
	H LDI R4, 16
	SLT ADI R4, 0
	LDI R5, 8232
	INT STR R5, R4, 0
	LDI R4, 8236
	INT STR R4, R6, 0
	LDI R4, 0
	H LDI R4, mapEntries
	SLT ADI R4, mapEntries
	INT STR R4, R10, 0
.LBB42_6:
	LDI R4, 12
	LSH R1, R4, R1
	SUB R3, R10, R8
	LDI R4, 0
	H LDI R4, varMap
	SLT ADI R4, varMap
	INT LOD R4, R6, 0
	INT LOD R14, R4, -28
	INT LOD R4, R7, 0
	INT STR R14, R6, -24
	SLT ADD R3, R0, R5
	SLT ADD R3, R0, R9
	H LDI R15, %hi(.LBB42_7)
	SLT ADI R15, %lo(.LBB42_7)
	JMP R15
.LBB42_8:                               ;   in Loop: Header=BB42_7 Depth=1
	INT LOD R6, R11, 0
.LBB42_9:                               ;   in Loop: Header=BB42_7 Depth=1
	ADD R11, R9, R9
	ADI R6, 8
	ADI R5, -1
	SUB R8, R5, R0
	H LDI R15, %hi(.LBB42_10)
	SLT ADI R15, %lo(.LBB42_10)
	BRH EQ, R15
.LBB42_7:                               ; =>This Inner Loop Header: Depth=1
	SUB R7, R9, R0
	H LDI R15, %hi(.LBB42_8)
	SLT ADI R15, %lo(.LBB42_8)
	BRH C, R15
; %bb.11:                               ;   in Loop: Header=BB42_7 Depth=1
	SUB R7, R9, R13
	ADD R13, R1, R12
	INT LOD R6, R11, 0
	SUB R11, R12, R0
	H LDI R15, %hi(.LBB42_9)
	SLT ADI R15, %lo(.LBB42_9)
	BRH C, R15
; %bb.12:
	INT LOD R6, R4, 4
	LDI R8, 255
	INT STR R14, R4, -16
	SUB R4, R8, R0
	H LDI R15, %hi(.LBB42_27)
	SLT ADI R15, %lo(.LBB42_27)
	BRH EQ, R15
; %bb.13:
	LDI R4, 1
	SLT ADD R4, R0, R8
	SUB R9, R7, R0
	H LDI R15, %hi(.LBB42_15)
	SLT ADI R15, %lo(.LBB42_15)
	BRH NE, R15
; %bb.14:
	SLT ADD R3, R0, R8
.LBB42_15:
	SUB R11, R12, R0
	H LDI R15, %hi(.LBB42_17)
	SLT ADI R15, %lo(.LBB42_17)
	BRH NE, R15
; %bb.16:
	SLT ADD R3, R0, R4
.LBB42_17:
	ADD R4, R8, R4
	INT STR R14, R4, -20
	ADD R4, R10, R4
	LDI R8, 512
	INT STR R14, R4, -12
	SUB R8, R4, R0
	H LDI R15, %hi(.LBB42_27)
	SLT ADI R15, %lo(.LBB42_27)
	BRH C, R15
; %bb.18:
	INT STR R14, R2, -8
	SUB R3, R5, R2
	INT STR R14, R2, -4
	LDI R2, 0
	INT LOD R14, R3, -20
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB42_22)
	SLT ADI R15, %lo(.LBB42_22)
	BRH EQ, R15
; %bb.19:
	SUB R3, R5, R2
	INT LOD R14, R3, -12
	ADI R3, -1
	INT STR R14, R2, -20
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB42_22)
	SLT ADI R15, %lo(.LBB42_22)
	BRH NC, R15
; %bb.20:                               ; %.preheader
	INT LOD R14, R2, -12
	LDI R4, 3
	SLT ADD R4, R0, R8
	LSH R2, R8, R4
	LSH R10, R8, R10
	INT LOD R14, R2, -24
	ADD R10, R2, R10
	ADD R4, R2, R4
	ADI R4, -8
	ADI R10, -8
.LBB42_21:                              ; =>This Inner Loop Header: Depth=1
	INT LOD R10, R2, 0
	INT LOD R10, R8, 4
	INT STR R4, R8, 4
	INT STR R4, R2, 0
	ADI R4, -8
	ADI R10, -8
	ADI R3, -1
	INT LOD R14, R2, -20
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB42_21)
	SLT ADI R15, %lo(.LBB42_21)
	BRH C, R15
.LBB42_22:
	INT LOD R14, R3, -4
	SUB R9, R7, R0
	H LDI R15, %hi(.LBB42_24)
	SLT ADI R15, %lo(.LBB42_24)
	BRH EQ, R15
; %bb.23:
	INT LOD R14, R2, -16
	INT STR R6, R2, 4
	INT STR R6, R13, 0
	LDI R2, 1
	SUB R2, R5, R3
.LBB42_24:
	INT LOD R14, R8, -28
	LDI R2, 3
	LSH R3, R2, R2
	INT LOD R14, R3, -24
	ADD R3, R2, R2
	LDI R3, 255
	INT STR R2, R3, 4
	INT STR R2, R1, 0
	SUB R11, R12, R0
	H LDI R15, %hi(.LBB42_26)
	SLT ADI R15, %lo(.LBB42_26)
	BRH EQ, R15
; %bb.25:
	SUB R11, R12, R1
	INT LOD R14, R3, -16
	INT STR R2, R3, 12
	INT STR R2, R1, 8
.LBB42_26:
	LDI R1, 0
	H LDI R1, mapEntries
	SLT ADI R1, mapEntries
	INT LOD R14, R2, -12
	INT STR R1, R2, 0
	H LDI R15, %hi(coalesceMap)
	SLT ADI R15, %lo(coalesceMap)
	CAL R15
	LDI R1, 0
	INT STR R8, R1, 0
	INT LOD R14, R2, -8
.LBB42_27:
	;APP
	CYR R2, SR8
	;NO_APP
.LBB42_28:
	INT LOD R14, R13, -52
	INT LOD R14, R12, -48
	INT LOD R14, R11, -44
	INT LOD R14, R10, -40
	INT LOD R14, R9, -36
	INT LOD R14, R8, -32
	SLT ADI R14, -56
	RET
.Lfunc_end42:
	.size	freePages, .Lfunc_end42-freePages
                                        ; -- End function
	.type	coalesceMap,@function           ; -- Begin function coalesceMap
coalesceMap:                            ; @coalesceMap
; %bb.0:
	SLT ADI R14, 36
	INT STR R14, R8, -12
	INT STR R14, R9, -16
	INT STR R14, R10, -20
	INT STR R14, R11, -24
	INT STR R14, R12, -28
	INT STR R14, R13, -32
	LDI R1, 0
	H LDI R1, mapEntries
	SLT ADI R1, mapEntries
	INT LOD R1, R10, 0
	LDI R1, 2
	SUB R10, R1, R0
	H LDI R15, %hi(.LBB43_16)
	SLT ADI R15, %lo(.LBB43_16)
	BRH C, R15
; %bb.1:
	LDI R2, 0
	LDI R3, 1
	LDI R1, 0
	H LDI R1, varMap
	SLT ADI R1, varMap
	INT LOD R1, R4, 0
	SLT ADD R4, R0, R1
	ADI R1, -1
	INT STR R14, R1, -4
	SLT ADD R4, R0, R1
	ADI R1, 8
	INT STR R14, R1, -8
	LDI R7, 3
	SLT ADD R3, R0, R13
	SLT ADD R2, R0, R5
	H LDI R15, %hi(.LBB43_2)
	SLT ADI R15, %lo(.LBB43_2)
	JMP R15
.LBB43_14:                              ;   in Loop: Header=BB43_2 Depth=1
	SLT ADD R11, R0, R10
	LDI R1, 0
	H LDI R1, mapEntries
	SLT ADI R1, mapEntries
	INT STR R1, R10, 0
	ADI R9, -1
.LBB43_15:                              ;   in Loop: Header=BB43_2 Depth=1
	SLT ADD R9, R0, R5
	ADI R5, 1
	ADI R9, 2
	SLT ADD R9, R0, R13
	SUB R9, R10, R0
	H LDI R15, %hi(.LBB43_16)
	SLT ADI R15, %lo(.LBB43_16)
	BRH NC, R15
.LBB43_2:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB43_13 Depth 2
                                        ;     Child Loop BB43_8 Depth 2
	SLT ADD R5, R0, R9
	LSH R13, R7, R12
	LSH R9, R7, R1
	ADD R4, R1, R11
	ADD R4, R12, R5
	INT LOD R5, R1, 4
	INT LOD R11, R6, 4
	SUB R6, R1, R0
	H LDI R15, %hi(.LBB43_15)
	SLT ADI R15, %lo(.LBB43_15)
	BRH NE, R15
; %bb.3:                                ;   in Loop: Header=BB43_2 Depth=1
	INT LOD R5, R1, 0
	LDI R6, 0
	H LDI R6, 0
	SLT ADI R6, -1
	XOR R1, R6, R8
	INT LOD R11, R6, 0
	SUB R8, R6, R0
	H LDI R15, %hi(.LBB43_15)
	SLT ADI R15, %lo(.LBB43_15)
	BRH C, R15
; %bb.4:                                ;   in Loop: Header=BB43_2 Depth=1
	ADD R1, R6, R1
	INT STR R11, R1, 0
	SLT ADD R13, R0, R1
	ADI R1, 1
	SLT ADD R10, R0, R11
	ADI R11, -1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB43_14)
	SLT ADI R15, %lo(.LBB43_14)
	BRH NC, R15
; %bb.5:                                ;   in Loop: Header=BB43_2 Depth=1
	SUB R11, R13, R1
	LSH R1, R7, R1
	INT LOD R14, R6, -8
	ADD R6, R12, R13
	SUB R13, R5, R0
	H LDI R15, %hi(.LBB43_11)
	SLT ADI R15, %lo(.LBB43_11)
	BRH NC, R15
; %bb.6:                                ; %memmove_copy_backwards
                                        ;   in Loop: Header=BB43_2 Depth=1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB43_14)
	SLT ADI R15, %lo(.LBB43_14)
	BRH EQ, R15
; %bb.7:                                ; %memmove_bwd_main_loop.preheader
                                        ;   in Loop: Header=BB43_2 Depth=1
	LSH R10, R7, R1
	INT LOD R14, R5, -4
	ADD R5, R1, R10
	SUB R12, R1, R12
	ADI R12, 8
	H LDI R15, %hi(.LBB43_8)
	SLT ADI R15, %lo(.LBB43_8)
	JMP R15
.LBB43_10:                              ; %memmove_bwd_main_loop
                                        ;   in Loop: Header=BB43_8 Depth=2
	AND R1, R3, R1
	ADI R10, -1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB43_14)
	SLT ADI R15, %lo(.LBB43_14)
	BRH NE, R15
.LBB43_8:                               ; %memmove_bwd_main_loop
                                        ;   Parent Loop BB43_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	CHAR LOD R10, R1, 0
	CHAR STR R10, R1, -8
	ADI R12, 1
	SLT ADD R3, R0, R1
	SUB R12, R2, R0
	H LDI R15, %hi(.LBB43_10)
	SLT ADI R15, %lo(.LBB43_10)
	BRH EQ, R15
; %bb.9:                                ; %memmove_bwd_main_loop
                                        ;   in Loop: Header=BB43_8 Depth=2
	SLT ADD R2, R0, R1
	H LDI R15, %hi(.LBB43_10)
	SLT ADI R15, %lo(.LBB43_10)
	JMP R15
.LBB43_11:                              ; %memmove_copy_forward
                                        ;   in Loop: Header=BB43_2 Depth=1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB43_14)
	SLT ADI R15, %lo(.LBB43_14)
	BRH EQ, R15
; %bb.12:                               ; %memmove_fwd_main_loop.preheader
                                        ;   in Loop: Header=BB43_2 Depth=1
	LSH R10, R7, R1
	SUB R1, R12, R5
	ADI R5, -8
.LBB43_13:                              ; %memmove_fwd_main_loop
                                        ;   Parent Loop BB43_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	CHAR LOD R13, R1, 0
	CHAR STR R13, R1, -8
	ADI R13, 1
	ADI R5, -1
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB43_13)
	SLT ADI R15, %lo(.LBB43_13)
	BRH NE, R15
	H LDI R15, %hi(.LBB43_14)
	SLT ADI R15, %lo(.LBB43_14)
	JMP R15
.LBB43_16:
	INT LOD R14, R13, -32
	INT LOD R14, R12, -28
	INT LOD R14, R11, -24
	INT LOD R14, R10, -20
	INT LOD R14, R9, -16
	INT LOD R14, R8, -12
	SLT ADI R14, -36
	RET
.Lfunc_end43:
	.size	coalesceMap, .Lfunc_end43-coalesceMap
                                        ; -- End function
	.globl	allocateIOMemory                ; -- Begin function allocateIOMemory
	.type	allocateIOMemory,@function
allocateIOMemory:                       ; @allocateIOMemory
; %bb.0:
	SLT ADI R14, 56
	INT STR R14, R8, -32
	INT STR R14, R9, -36
	INT STR R14, R10, -40
	INT STR R14, R11, -44
	INT STR R14, R12, -48
	INT STR R14, R13, -52
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB44_62)
	SLT ADI R15, %lo(.LBB44_62)
	BRH NC, R15
; %bb.1:
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -4096
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB44_62)
	SLT ADI R15, %lo(.LBB44_62)
	BRH C, R15
; %bb.2:
	;APP
	CYE SR8, R3
	;NO_APP
	INT STR R14, R3, -8
	;APP
	CYE SR8, R3
	;NO_APP
	LDI R4, 0
	H LDI R4, 0
	SLT ADI R4, -5
	AND R3, R4, R3
	;APP
	CYR R3, SR8
	;NO_APP
	LDI R3, 0
	H LDI R3, varMap
	SLT ADI R3, varMap
	INT LOD R3, R4, 0
	LDI R12, 0
	LDI R7, 255
	LDI R10, 6
	SUB R4, R12, R0
	H LDI R15, %hi(.LBB44_4)
	SLT ADI R15, %lo(.LBB44_4)
	BRH EQ, R15
; %bb.3:
	LDI R3, 0
	H LDI R3, mapEntries
	SLT ADI R3, mapEntries
	INT LOD R3, R3, 0
	SUB R3, R12, R0
	H LDI R15, %hi(.LBB44_5)
	SLT ADI R15, %lo(.LBB44_5)
	BRH NE, R15
	H LDI R15, %hi(.LBB44_61)
	SLT ADI R15, %lo(.LBB44_61)
	JMP R15
.LBB44_4:
	LDI R4, 8192
	INT STR R3, R4, 0
	INT STR R4, R4, 0
	LDI R3, 8196
	INT STR R3, R7, 0
	LDI R3, 4096
	LDI R6, 8200
	INT STR R6, R3, 0
	LDI R6, 1
	LDI R8, 8204
	INT STR R8, R6, 0
	LDI R8, 0
	H LDI R8, 65248
	SLT ADI R8, -12288
	LDI R9, 8208
	INT STR R9, R8, 0
	LDI R8, 8212
	INT STR R8, R7, 0
	LDI R8, 8216
	INT STR R8, R3, 0
	LDI R3, 8220
	INT STR R3, R10, 0
	LDI R3, 0
	H LDI R3, 272
	SLT ADI R3, -4096
	LDI R8, 8224
	INT STR R8, R3, 0
	LDI R3, 8228
	INT STR R3, R7, 0
	LDI R3, 0
	H LDI R3, 16
	SLT ADI R3, 0
	LDI R8, 8232
	INT STR R8, R3, 0
	LDI R3, 8236
	INT STR R3, R6, 0
	LDI R3, 0
	H LDI R3, mapEntries
	SLT ADI R3, mapEntries
	INT STR R3, R10, 0
	SLT ADD R10, R0, R3
.LBB44_5:
	AND R1, R5, R8
	ADI R2, 4095
	AND R2, R5, R2
	INT STR R14, R4, -28
	SLT ADD R4, R0, R1
	ADI R1, 4
	SLT ADD R3, R0, R5
	SLT ADD R12, R0, R6
	LDI R4, 6
	H LDI R15, %hi(.LBB44_7)
	SLT ADI R15, %lo(.LBB44_7)
	JMP R15
.LBB44_6:                               ;   in Loop: Header=BB44_7 Depth=1
	ADD R9, R6, R6
	ADI R1, 8
	ADI R5, -1
	SUB R5, R12, R0
	H LDI R15, %hi(.LBB44_14)
	SLT ADI R15, %lo(.LBB44_14)
	BRH EQ, R15
.LBB44_7:                               ; =>This Inner Loop Header: Depth=1
	SUB R6, R2, R0
	H LDI R15, %hi(.LBB44_14)
	SLT ADI R15, %lo(.LBB44_14)
	BRH NC, R15
; %bb.8:                                ;   in Loop: Header=BB44_7 Depth=1
	INT LOD R1, R9, -4
	SUB R8, R6, R0
	H LDI R15, %hi(.LBB44_10)
	SLT ADI R15, %lo(.LBB44_10)
	BRH C, R15
; %bb.9:                                ;   in Loop: Header=BB44_7 Depth=1
	SUB R8, R6, R10
	SUB R10, R9, R0
	H LDI R15, %hi(.LBB44_6)
	SLT ADI R15, %lo(.LBB44_6)
	BRH NC, R15
.LBB44_10:                              ;   in Loop: Header=BB44_7 Depth=1
	INT LOD R1, R10, 0
	SUB R10, R7, R0
	H LDI R15, %hi(.LBB44_6)
	SLT ADI R15, %lo(.LBB44_6)
	BRH EQ, R15
; %bb.11:                               ;   in Loop: Header=BB44_7 Depth=1
	SUB R10, R4, R0
	H LDI R15, %hi(.LBB44_6)
	SLT ADI R15, %lo(.LBB44_6)
	BRH EQ, R15
; %bb.12:
	INT LOD R14, R1, -8
	;APP
	CYR R1, SR8
	;NO_APP
	H LDI R15, %hi(.LBB44_13)
	SLT ADI R15, %lo(.LBB44_13)
	JMP R15
.LBB44_14:
	SLT ADD R3, R0, R1
	ADI R1, -511
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -513
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB44_16)
	SLT ADI R15, %lo(.LBB44_16)
	BRH NC, R15
; %bb.15:
	INT LOD R14, R1, -8
	;APP
	CYR R1, SR8
	;NO_APP
.LBB44_13:
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -1
	H LDI R15, %hi(.LBB44_62)
	SLT ADI R15, %lo(.LBB44_62)
	JMP R15
.LBB44_16:                              ; %.preheader4
	INT LOD R14, R10, -28
	SLT ADD R10, R0, R1
	ADI R1, -8
	INT STR R14, R1, -4
	LDI R5, 1
	SLT ADD R12, R0, R6
	SLT ADD R12, R0, R13
	H LDI R15, %hi(.LBB44_18)
	SLT ADI R15, %lo(.LBB44_18)
	JMP R15
.LBB44_17:                              ;   in Loop: Header=BB44_18 Depth=1
	ADD R11, R13, R13
	SLT ADD R5, R0, R1
	ADD R1, R6, R6
	SUB R6, R3, R0
	H LDI R15, %hi(.LBB44_42)
	SLT ADI R15, %lo(.LBB44_42)
	BRH NC, R15
.LBB44_18:                              ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB44_34 Depth 2
	SUB R13, R2, R0
	H LDI R15, %hi(.LBB44_42)
	SLT ADI R15, %lo(.LBB44_42)
	BRH NC, R15
; %bb.19:                               ;   in Loop: Header=BB44_18 Depth=1
	LDI R1, 3
	LSH R6, R1, R1
	ADD R10, R1, R7
	INT LOD R7, R11, 0
	SUB R8, R13, R0
	H LDI R15, %hi(.LBB44_21)
	SLT ADI R15, %lo(.LBB44_21)
	BRH C, R15
; %bb.20:                               ;   in Loop: Header=BB44_18 Depth=1
	SUB R8, R13, R1
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB44_17)
	SLT ADI R15, %lo(.LBB44_17)
	BRH NC, R15
.LBB44_21:                              ;   in Loop: Header=BB44_18 Depth=1
	INT LOD R7, R1, 4
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB44_17)
	SLT ADI R15, %lo(.LBB44_17)
	BRH EQ, R15
; %bb.22:                               ;   in Loop: Header=BB44_18 Depth=1
	INT STR R14, R1, -24
	SUB R2, R13, R1
	SLT ADD R2, R0, R9
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB44_24)
	SLT ADI R15, %lo(.LBB44_24)
	BRH C, R15
; %bb.23:                               ;   in Loop: Header=BB44_18 Depth=1
	ADD R11, R13, R9
.LBB44_24:                              ;   in Loop: Header=BB44_18 Depth=1
	SLT ADD R5, R0, R1
	SUB R13, R8, R0
	H LDI R15, %hi(.LBB44_26)
	SLT ADI R15, %lo(.LBB44_26)
	BRH C, R15
; %bb.25:                               ;   in Loop: Header=BB44_18 Depth=1
	SLT ADD R12, R0, R1
.LBB44_26:                              ;   in Loop: Header=BB44_18 Depth=1
	SUB R9, R13, R4
	INT STR R14, R4, -20
	SUB R11, R4, R0
	H LDI R15, %hi(.LBB44_28)
	SLT ADI R15, %lo(.LBB44_28)
	BRH NE, R15
; %bb.27:                               ;   in Loop: Header=BB44_18 Depth=1
	SLT ADD R12, R0, R5
.LBB44_28:                              ;   in Loop: Header=BB44_18 Depth=1
	SLT ADD R13, R0, R4
	SUB R8, R13, R0
	H LDI R15, %hi(.LBB44_30)
	SLT ADI R15, %lo(.LBB44_30)
	BRH C, R15
; %bb.29:                               ;   in Loop: Header=BB44_18 Depth=1
	SLT ADD R8, R0, R4
.LBB44_30:                              ;   in Loop: Header=BB44_18 Depth=1
	INT STR R14, R4, -16
	ADD R5, R1, R1
	ADD R1, R3, R10
	LDI R4, 512
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB44_63)
	SLT ADI R15, %lo(.LBB44_63)
	BRH C, R15
; %bb.31:                               ;   in Loop: Header=BB44_18 Depth=1
	INT STR R14, R9, -12
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB44_35)
	SLT ADI R15, %lo(.LBB44_35)
	BRH EQ, R15
; %bb.32:                               ;   in Loop: Header=BB44_18 Depth=1
	ADD R1, R6, R1
	SLT ADD R10, R0, R5
	ADI R5, -1
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB44_35)
	SLT ADI R15, %lo(.LBB44_35)
	BRH NC, R15
; %bb.33:                               ; %.preheader
                                        ;   in Loop: Header=BB44_18 Depth=1
	LDI R4, 3
	LSH R10, R4, R12
	INT LOD R14, R9, -4
	ADD R9, R12, R12
	LSH R3, R4, R3
	ADD R9, R3, R3
.LBB44_34:                              ;   Parent Loop BB44_18 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	INT LOD R3, R4, 0
	INT LOD R3, R9, 4
	INT STR R12, R9, 4
	INT STR R12, R4, 0
	ADI R12, -8
	ADI R3, -8
	ADI R5, -1
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB44_34)
	SLT ADI R15, %lo(.LBB44_34)
	BRH C, R15
.LBB44_35:                              ;   in Loop: Header=BB44_18 Depth=1
	SLT ADD R6, R0, R1
	INT LOD R14, R9, -24
	INT LOD R14, R3, -16
	SUB R13, R8, R0
	H LDI R15, %hi(.LBB44_37)
	SLT ADI R15, %lo(.LBB44_37)
	BRH NC, R15
; %bb.36:                               ;   in Loop: Header=BB44_18 Depth=1
	SUB R3, R13, R1
	INT STR R7, R9, 4
	INT STR R7, R1, 0
	SLT ADD R6, R0, R1
	ADI R1, 1
.LBB44_37:                              ;   in Loop: Header=BB44_18 Depth=1
	INT LOD R14, R7, -12
	SUB R7, R3, R3
	LDI R4, 3
	LSH R1, R4, R1
	INT LOD R14, R4, -28
	ADD R4, R1, R1
	LDI R4, 6
	INT STR R1, R4, 4
	INT STR R1, R3, 0
	LDI R5, 1
	INT LOD R14, R3, -20
	SUB R11, R3, R0
	H LDI R15, %hi(.LBB44_39)
	SLT ADI R15, %lo(.LBB44_39)
	BRH EQ, R15
; %bb.38:                               ;   in Loop: Header=BB44_18 Depth=1
	SUB R11, R3, R3
	INT STR R1, R9, 12
	INT STR R1, R3, 8
.LBB44_39:                              ;   in Loop: Header=BB44_18 Depth=1
	LDI R1, 2
	SUB R13, R8, R0
	H LDI R15, %hi(.LBB44_41)
	SLT ADI R15, %lo(.LBB44_41)
	BRH C, R15
; %bb.40:                               ;   in Loop: Header=BB44_18 Depth=1
	SLT ADD R5, R0, R1
.LBB44_41:                              ;   in Loop: Header=BB44_18 Depth=1
	LDI R3, 0
	H LDI R3, mapEntries
	SLT ADI R3, mapEntries
	INT STR R3, R10, 0
	SLT ADD R10, R0, R3
	SLT ADD R7, R0, R13
	INT LOD R14, R10, -28
	LDI R12, 0
	ADD R1, R6, R6
	SUB R6, R3, R0
	H LDI R15, %hi(.LBB44_18)
	SLT ADI R15, %lo(.LBB44_18)
	BRH C, R15
.LBB44_42:
	LDI R1, 2
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB44_61)
	SLT ADI R15, %lo(.LBB44_61)
	BRH C, R15
; %bb.43:
	LDI R2, 0
	LDI R6, 1
	SLT ADD R10, R0, R1
	ADI R1, -1
	INT STR R14, R1, -24
	SLT ADD R10, R0, R8
	ADI R8, 8
	LDI R9, 0
	H LDI R9, 0
	SLT ADI R9, -1
	SLT ADD R6, R0, R12
	SLT ADD R2, R0, R1
	H LDI R15, %hi(.LBB44_46)
	SLT ADI R15, %lo(.LBB44_46)
	JMP R15
.LBB44_44:                              ;   in Loop: Header=BB44_46 Depth=1
	INT LOD R14, R10, -28
.LBB44_45:                              ;   in Loop: Header=BB44_46 Depth=1
	SLT ADD R11, R0, R1
	ADI R1, 1
	ADI R11, 2
	SLT ADD R11, R0, R12
	SUB R11, R3, R0
	H LDI R15, %hi(.LBB44_61)
	SLT ADI R15, %lo(.LBB44_61)
	BRH NC, R15
.LBB44_46:                              ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB44_58 Depth 2
                                        ;     Child Loop BB44_53 Depth 2
	SLT ADD R1, R0, R11
	LDI R1, 3
	LSH R12, R1, R5
	LSH R11, R1, R1
	ADD R10, R1, R1
	ADD R10, R5, R13
	INT LOD R13, R4, 4
	INT LOD R1, R7, 4
	SUB R7, R4, R0
	H LDI R15, %hi(.LBB44_45)
	SLT ADI R15, %lo(.LBB44_45)
	BRH NE, R15
; %bb.47:                               ;   in Loop: Header=BB44_46 Depth=1
	INT LOD R13, R7, 0
	XOR R7, R9, R4
	INT LOD R1, R10, 0
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB44_44)
	SLT ADI R15, %lo(.LBB44_44)
	BRH C, R15
; %bb.48:                               ;   in Loop: Header=BB44_46 Depth=1
	ADD R7, R10, R4
	INT STR R1, R4, 0
	SLT ADD R12, R0, R1
	ADI R1, 1
	SUB R1, R3, R0
	H LDI R15, %hi(.LBB44_55)
	SLT ADI R15, %lo(.LBB44_55)
	BRH NC, R15
; %bb.49:                               ;   in Loop: Header=BB44_46 Depth=1
	SLT ADD R3, R0, R1
	ADI R1, -1
	SUB R1, R12, R4
	LDI R7, 3
	LSH R4, R7, R7
	ADD R8, R5, R12
	SUB R12, R13, R0
	H LDI R15, %hi(.LBB44_56)
	SLT ADI R15, %lo(.LBB44_56)
	BRH NC, R15
; %bb.50:                               ; %memmove_copy_backwards
                                        ;   in Loop: Header=BB44_46 Depth=1
	INT LOD R14, R10, -28
	SUB R7, R2, R0
	H LDI R15, %hi(.LBB44_59)
	SLT ADI R15, %lo(.LBB44_59)
	BRH EQ, R15
; %bb.51:                               ; %memmove_bwd_main_loop.preheader
                                        ;   in Loop: Header=BB44_46 Depth=1
	LDI R4, 3
	LSH R3, R4, R4
	INT LOD R14, R3, -24
	ADD R3, R4, R3
	SUB R5, R4, R5
	ADI R5, 8
	H LDI R15, %hi(.LBB44_53)
	SLT ADI R15, %lo(.LBB44_53)
	JMP R15
.LBB44_52:                              ; %memmove_bwd_main_loop
                                        ;   in Loop: Header=BB44_53 Depth=2
	AND R7, R6, R4
	ADI R3, -1
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB44_59)
	SLT ADI R15, %lo(.LBB44_59)
	BRH NE, R15
.LBB44_53:                              ; %memmove_bwd_main_loop
                                        ;   Parent Loop BB44_46 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	CHAR LOD R3, R4, 0
	CHAR STR R3, R4, -8
	ADI R5, 1
	SLT ADD R6, R0, R7
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB44_52)
	SLT ADI R15, %lo(.LBB44_52)
	BRH EQ, R15
; %bb.54:                               ; %memmove_bwd_main_loop
                                        ;   in Loop: Header=BB44_53 Depth=2
	SLT ADD R2, R0, R7
	H LDI R15, %hi(.LBB44_52)
	SLT ADI R15, %lo(.LBB44_52)
	JMP R15
.LBB44_55:                              ;   in Loop: Header=BB44_46 Depth=1
	ADI R3, -1
	INT LOD R14, R10, -28
	H LDI R15, %hi(.LBB44_60)
	SLT ADI R15, %lo(.LBB44_60)
	JMP R15
.LBB44_56:                              ; %memmove_copy_forward
                                        ;   in Loop: Header=BB44_46 Depth=1
	INT LOD R14, R10, -28
	SUB R7, R2, R0
	H LDI R15, %hi(.LBB44_59)
	SLT ADI R15, %lo(.LBB44_59)
	BRH EQ, R15
; %bb.57:                               ; %memmove_fwd_main_loop.preheader
                                        ;   in Loop: Header=BB44_46 Depth=1
	LDI R4, 3
	LSH R3, R4, R3
	SUB R3, R5, R3
	ADI R3, -8
.LBB44_58:                              ; %memmove_fwd_main_loop
                                        ;   Parent Loop BB44_46 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	CHAR LOD R12, R4, 0
	CHAR STR R12, R4, -8
	ADI R12, 1
	ADI R3, -1
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB44_58)
	SLT ADI R15, %lo(.LBB44_58)
	BRH NE, R15
.LBB44_59:                              ;   in Loop: Header=BB44_46 Depth=1
	SLT ADD R1, R0, R3
.LBB44_60:                              ;   in Loop: Header=BB44_46 Depth=1
	LDI R1, 0
	H LDI R1, mapEntries
	SLT ADI R1, mapEntries
	INT STR R1, R3, 0
	ADI R11, -1
	H LDI R15, %hi(.LBB44_45)
	SLT ADI R15, %lo(.LBB44_45)
	JMP R15
.LBB44_61:
	INT LOD R14, R1, -8
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R3, 0
.LBB44_62:
	SLT ADD R3, R0, R1
	INT LOD R14, R13, -52
	INT LOD R14, R12, -48
	INT LOD R14, R11, -44
	INT LOD R14, R10, -40
	INT LOD R14, R9, -36
	INT LOD R14, R8, -32
	SLT ADI R14, -56
	RET
.LBB44_63:
	INT LOD R14, R1, -8
	;APP
	CYR R1, SR8
	;NO_APP
	H LDI R15, %hi(.LBB44_13)
	SLT ADI R15, %lo(.LBB44_13)
	JMP R15
.Lfunc_end44:
	.size	allocateIOMemory, .Lfunc_end44-allocateIOMemory
                                        ; -- End function
	.globl	getVarMap                       ; -- Begin function getVarMap
	.type	getVarMap,@function
getVarMap:                              ; @getVarMap
; %bb.0:
	SLT ADI R14, 4
	;APP
	CYE SR8, R2
	;NO_APP
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -5
	AND R1, R3, R1
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R3, 0
	H LDI R3, varMap
	SLT ADI R3, varMap
	INT LOD R3, R1, 0
	LDI R4, 0
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB45_2)
	SLT ADI R15, %lo(.LBB45_2)
	BRH NE, R15
; %bb.1:
	LDI R1, 8192
	INT STR R3, R1, 0
	INT STR R1, R1, 0
	LDI R3, 255
	LDI R4, 8196
	INT STR R4, R3, 0
	LDI R4, 4096
	LDI R5, 8200
	INT STR R5, R4, 0
	LDI R5, 1
	LDI R6, 8204
	INT STR R6, R5, 0
	LDI R6, 0
	H LDI R6, 65248
	SLT ADI R6, -12288
	LDI R7, 8208
	INT STR R7, R6, 0
	LDI R6, 8212
	INT STR R6, R3, 0
	LDI R6, 8216
	INT STR R6, R4, 0
	LDI R4, 6
	LDI R6, 8220
	INT STR R6, R4, 0
	LDI R6, 0
	H LDI R6, 272
	SLT ADI R6, -4096
	LDI R7, 8224
	INT STR R7, R6, 0
	LDI R6, 8228
	INT STR R6, R3, 0
	LDI R3, 0
	H LDI R3, 16
	SLT ADI R3, 0
	LDI R6, 8232
	INT STR R6, R3, 0
	LDI R3, 8236
	INT STR R3, R5, 0
	LDI R3, 0
	H LDI R3, mapEntries
	SLT ADI R3, mapEntries
	INT STR R3, R4, 0
.LBB45_2:
	;APP
	CYR R2, SR8
	;NO_APP
	SLT ADI R14, -4
	RET
.Lfunc_end45:
	.size	getVarMap, .Lfunc_end45-getVarMap
                                        ; -- End function
	.globl	help                            ; -- Begin function help
	.type	help,@function
help:                                   ; @help
; %bb.0:
	SLT ADI R14, 16
	INT STR R14, R8, -12
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.50
	SLT ADI R1, .L.str.50
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.51
	SLT ADI R1, .L.str.1.51
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.13
	SLT ADI R1, .L.str.13
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.52
	SLT ADI R1, .L.str.2.52
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.51
	SLT ADI R1, .L.str.1.51
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.14
	SLT ADI R1, .L.str.14
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.52
	SLT ADI R1, .L.str.2.52
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.51
	SLT ADI R1, .L.str.1.51
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.15
	SLT ADI R1, .L.str.15
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.52
	SLT ADI R1, .L.str.2.52
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.51
	SLT ADI R1, .L.str.1.51
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.16
	SLT ADI R1, .L.str.16
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.52
	SLT ADI R1, .L.str.2.52
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.51
	SLT ADI R1, .L.str.1.51
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.17
	SLT ADI R1, .L.str.17
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.52
	SLT ADI R1, .L.str.2.52
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.21
	SLT ADI R1, .L.str.21
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADD R14, R0, R8
	SLT ADI R8, -8
	LDI R2, 8
	SLT ADD R8, R0, R1
	H LDI R15, %hi(readInput)
	SLT ADI R15, %lo(readInput)
	CAL R15
	CHAR LOD R8, R1, 0
	LDI R2, 223
	AND R1, R2, R1
	LDI R2, 81
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB46_2)
	SLT ADI R15, %lo(.LBB46_2)
	BRH EQ, R15
; %bb.1:
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.50
	SLT ADI R1, .L.str.50
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.51
	SLT ADI R1, .L.str.1.51
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.18
	SLT ADI R1, .L.str.18
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.52
	SLT ADI R1, .L.str.2.52
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.51
	SLT ADI R1, .L.str.1.51
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.19
	SLT ADI R1, .L.str.19
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.52
	SLT ADI R1, .L.str.2.52
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.51
	SLT ADI R1, .L.str.1.51
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.20
	SLT ADI R1, .L.str.20
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.52
	SLT ADI R1, .L.str.2.52
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB46_2:
	INT LOD R14, R8, -12
	SLT ADI R14, -16
	RET
.Lfunc_end46:
	.size	help, .Lfunc_end46-help
                                        ; -- End function
	.globl	sysOff                          ; -- Begin function sysOff
	.type	sysOff,@function
sysOff:                                 ; @sysOff
; %bb.0:
	SLT ADI R14, 4
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.3.53
	SLT ADI R1, .L.str.3.53
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.Lfunc_end47:
	.size	sysOff, .Lfunc_end47-sysOff
                                        ; -- End function
	.globl	reset                           ; -- Begin function reset
	.type	reset,@function
reset:                                  ; @reset
; %bb.0:
	SLT ADI R14, 4
	;APP
	H LDI R14, 0
SLT ADI R14, 4096
H LDI R15, %hi(main) 
SLT ADI R15, %lo(main) 
JMP R15
	;NO_APP
.Lfunc_end48:
	.size	reset, .Lfunc_end48-reset
                                        ; -- End function
	.globl	initSO                          ; -- Begin function initSO
	.type	initSO,@function
initSO:                                 ; @initSO
; %bb.0:
	SLT ADI R14, 4
	SLT ADI R14, -4
	RET
.Lfunc_end49:
	.size	initSO, .Lfunc_end49-initSO
                                        ; -- End function
	.globl	enumdisp                        ; -- Begin function enumdisp
	.type	enumdisp,@function
enumdisp:                               ; @enumdisp
; %bb.0:
	SLT ADI R14, 44
	INT STR R14, R8, -20
	INT STR R14, R9, -24
	INT STR R14, R10, -28
	INT STR R14, R11, -32
	INT STR R14, R12, -36
	INT STR R14, R13, -40
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.4.54
	SLT ADI R1, .L.str.4.54
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R9, 0
	H LDI R9, Globals
	SLT ADI R9, Globals
	INT LOD R9, R1, 0
	INT LOD R1, R1, 0
	SLT ADD R8, R0, R2
	H LDI R15, %hi(ToAscii)
	SLT ADI R15, %lo(ToAscii)
	CAL R15
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.5
	SLT ADI R1, .L.str.5
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.6
	SLT ADI R1, .L.str.6
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.7.55
	SLT ADI R1, .L.str.7.55
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	INT LOD R9, R1, 0
	INT LOD R1, R1, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB50_12)
	SLT ADI R15, %lo(.LBB50_12)
	BRH EQ, R15
; %bb.1:                                ; %.preheader1
	ADD R14, R0, R10
	INT STR R14, R10, -4
	SLT ADI R10, -8
	LDI R13, 1
	SLT ADD R8, R0, R9
	H LDI R15, %hi(.LBB50_2)
	SLT ADI R15, %lo(.LBB50_2)
	JMP R15
.LBB50_11:                              ;   in Loop: Header=BB50_2 Depth=1
	INT LOD R11, R1, 0
	INT LOD R1, R1, 0
	SUB R9, R1, R0
	H LDI R15, %hi(.LBB50_12)
	SLT ADI R15, %lo(.LBB50_12)
	BRH NC, R15
.LBB50_2:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB50_4 Depth 2
	LDI R1, 20
	MUL R9, R1, R11
	LDI R1, 0
	H LDI R1, mapa
	SLT ADI R1, mapa
	INT LOD R1, R1, 0
	ADD R1, R11, R1
	INT LOD R1, R1, 12
	LDI R2, 3
	H LDI R15, %hi(ToAscii)
	SLT ADI R15, %lo(ToAscii)
	CAL R15
	SLT ADD R1, R0, R12
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	SLT ADD R12, R0, R1
	H LDI R15, %hi(strlen)
	SLT ADI R15, %lo(strlen)
	CAL R15
	SLT ADD R1, R0, R12
	LDI R1, 32
	SHORT STR R10, R1, 0
	LDI R1, 12
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB50_7)
	SLT ADI R15, %lo(.LBB50_7)
	BRH N, R15
; %bb.3:                                ; %.preheader
                                        ;   in Loop: Header=BB50_2 Depth=1
	ADI R12, -13
	H LDI R15, %hi(.LBB50_4)
	SLT ADI R15, %lo(.LBB50_4)
	JMP R15
.LBB50_6:                               ;   in Loop: Header=BB50_4 Depth=2
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB50_7)
	SLT ADI R15, %lo(.LBB50_7)
	BRH EQ, R15
.LBB50_4:                               ;   Parent Loop BB50_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	SLT ADD R10, R0, R1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADI R12, 1
	SLT ADD R13, R0, R1
	SUB R12, R8, R0
	H LDI R15, %hi(.LBB50_6)
	SLT ADI R15, %lo(.LBB50_6)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB50_4 Depth=2
	SLT ADD R8, R0, R1
	H LDI R15, %hi(.LBB50_6)
	SLT ADI R15, %lo(.LBB50_6)
	JMP R15
.LBB50_7:                               ;   in Loop: Header=BB50_2 Depth=1
	LDI R1, 0
	H LDI R1, mapa
	SLT ADI R1, mapa
	INT LOD R1, R1, 0
	ADD R1, R11, R1
	CHAR LOD R1, R2, 16
	LDI R3, 20
	LSH R2, R3, R2
	CHAR LOD R1, R3, 17
	LDI R4, 15
	LSH R3, R4, R3
	NOR R2, R3, R2
	CHAR LOD R1, R1, 18
	LDI R3, 12
	LSH R1, R3, R1
	NOR R2, R2, R2
	NOR R2, R1, R1
	NOR R1, R1, R1
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 0
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 3
	H LDI R15, %hi(ToAscii)
	SLT ADI R15, %lo(ToAscii)
	CAL R15
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.52
	SLT ADI R1, .L.str.2.52
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADI R9, 1
	LDI R1, 0
	H LDI R1, 43691
	SLT ADI R1, -21845
	MUL R9, R1, R2
	LDI R11, 0
	H LDI R11, Globals
	SLT ADI R11, Globals
	INT LOD R11, R1, 0
	INT LOD R1, R1, 0
	LDI R3, 0
	H LDI R3, 21845
	SLT ADI R3, 21845
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB50_11)
	SLT ADI R15, %lo(.LBB50_11)
	BRH C, R15
; %bb.8:                                ;   in Loop: Header=BB50_2 Depth=1
	SUB R9, R1, R0
	H LDI R15, %hi(.LBB50_11)
	SLT ADI R15, %lo(.LBB50_11)
	BRH NC, R15
; %bb.9:                                ;   in Loop: Header=BB50_2 Depth=1
	LDI R1, 0
	H LDI R1, .L.str.21
	SLT ADI R1, .L.str.21
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	INT LOD R14, R12, -4
	SLT ADI R12, -16
	SLT ADD R12, R0, R1
	LDI R2, 8
	H LDI R15, %hi(readInput)
	SLT ADI R15, %lo(readInput)
	CAL R15
	CHAR LOD R12, R1, 0
	LDI R2, 223
	AND R1, R2, R1
	LDI R2, 81
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB50_12)
	SLT ADI R15, %lo(.LBB50_12)
	BRH EQ, R15
; %bb.10:                               ;   in Loop: Header=BB50_2 Depth=1
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.6
	SLT ADI R1, .L.str.6
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.7.55
	SLT ADI R1, .L.str.7.55
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(.LBB50_11)
	SLT ADI R15, %lo(.LBB50_11)
	JMP R15
.LBB50_12:
	INT LOD R14, R13, -40
	INT LOD R14, R12, -36
	INT LOD R14, R11, -32
	INT LOD R14, R10, -28
	INT LOD R14, R9, -24
	INT LOD R14, R8, -20
	SLT ADI R14, -44
	RET
.Lfunc_end50:
	.size	enumdisp, .Lfunc_end50-enumdisp
                                        ; -- End function
	.globl	lsboot                          ; -- Begin function lsboot
	.type	lsboot,@function
lsboot:                                 ; @lsboot
; %bb.0:
	SLT ADI R14, 48
	INT STR R14, R8, -24
	INT STR R14, R9, -28
	INT STR R14, R10, -32
	INT STR R14, R11, -36
	INT STR R14, R12, -40
	INT STR R14, R13, -44
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.4.54
	SLT ADI R1, .L.str.4.54
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R13, 0
	H LDI R13, Globals
	SLT ADI R13, Globals
	INT LOD R13, R1, 0
	INT LOD R1, R1, 8
	SLT ADD R8, R0, R2
	H LDI R15, %hi(ToAscii)
	SLT ADI R15, %lo(ToAscii)
	CAL R15
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.8
	SLT ADI R1, .L.str.8
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.9
	SLT ADI R1, .L.str.9
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.10
	SLT ADI R1, .L.str.10
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	INT LOD R13, R1, 0
	INT LOD R1, R1, 8
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB51_14)
	SLT ADI R15, %lo(.LBB51_14)
	BRH EQ, R15
; %bb.1:                                ; %.preheader1
	LDI R3, 40
	LDI R4, 0
	H LDI R4, nvmDevs
	SLT ADI R4, nvmDevs
	LDI R10, 1
	ADD R14, R0, R9
	INT STR R14, R9, -4
	SLT ADI R9, -12
	SLT ADD R8, R0, R11
	INT STR R14, R8, -8
	H LDI R15, %hi(.LBB51_2)
	SLT ADI R15, %lo(.LBB51_2)
	JMP R15
.LBB51_12:                              ;   in Loop: Header=BB51_2 Depth=1
	LDI R3, 40
	LDI R4, 0
	H LDI R4, nvmDevs
	SLT ADI R4, nvmDevs
.LBB51_13:                              ;   in Loop: Header=BB51_2 Depth=1
	ADI R11, 1
	INT LOD R13, R1, 0
	INT LOD R1, R1, 8
	SUB R11, R1, R0
	H LDI R15, %hi(.LBB51_14)
	SLT ADI R15, %lo(.LBB51_14)
	BRH NC, R15
.LBB51_2:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB51_5 Depth 2
	MUL R11, R3, R1
	INT LOD R4, R2, 0
	ADD R2, R1, R12
	CHAR LOD R12, R1, 20
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB51_13)
	SLT ADI R15, %lo(.LBB51_13)
	BRH NE, R15
; %bb.3:                                ;   in Loop: Header=BB51_2 Depth=1
	SLT ADD R11, R0, R1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(ToAscii)
	SLT ADI R15, %lo(ToAscii)
	CAL R15
	SLT ADD R1, R0, R13
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	SLT ADD R13, R0, R1
	H LDI R15, %hi(strlen)
	SLT ADI R15, %lo(strlen)
	CAL R15
	SLT ADD R1, R0, R13
	LDI R1, 32
	SHORT STR R9, R1, 0
	LDI R1, 5
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB51_8)
	SLT ADI R15, %lo(.LBB51_8)
	BRH N, R15
; %bb.4:                                ; %.preheader
                                        ;   in Loop: Header=BB51_2 Depth=1
	ADI R13, -6
	H LDI R15, %hi(.LBB51_5)
	SLT ADI R15, %lo(.LBB51_5)
	JMP R15
.LBB51_7:                               ;   in Loop: Header=BB51_5 Depth=2
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB51_8)
	SLT ADI R15, %lo(.LBB51_8)
	BRH EQ, R15
.LBB51_5:                               ;   Parent Loop BB51_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	SLT ADD R9, R0, R1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADI R13, 1
	SLT ADD R10, R0, R1
	SUB R13, R8, R0
	H LDI R15, %hi(.LBB51_7)
	SLT ADI R15, %lo(.LBB51_7)
	BRH EQ, R15
; %bb.6:                                ;   in Loop: Header=BB51_5 Depth=2
	SLT ADD R8, R0, R1
	H LDI R15, %hi(.LBB51_7)
	SLT ADI R15, %lo(.LBB51_7)
	JMP R15
.LBB51_8:                               ;   in Loop: Header=BB51_2 Depth=1
	ADI R12, 28
	SLT ADD R12, R0, R1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.52
	SLT ADI R1, .L.str.2.52
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, 43691
	SLT ADI R1, -21845
	INT LOD R14, R4, -8
	MUL R4, R1, R1
	LDI R2, 0
	H LDI R2, 54613
	SLT ADI R2, 21845
	ADD R1, R2, R2
	ADI R4, 1
	LDI R13, 0
	H LDI R13, Globals
	SLT ADI R13, Globals
	INT LOD R13, R1, 0
	INT LOD R1, R1, 8
	LDI R3, 0
	H LDI R3, 21845
	SLT ADI R3, 21844
	INT STR R14, R4, -8
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB51_12)
	SLT ADI R15, %lo(.LBB51_12)
	BRH C, R15
; %bb.9:                                ;   in Loop: Header=BB51_2 Depth=1
	SUB R4, R1, R0
	H LDI R15, %hi(.LBB51_12)
	SLT ADI R15, %lo(.LBB51_12)
	BRH NC, R15
; %bb.10:                               ;   in Loop: Header=BB51_2 Depth=1
	LDI R1, 0
	H LDI R1, .L.str.21
	SLT ADI R1, .L.str.21
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	INT LOD R14, R12, -4
	SLT ADI R12, -20
	SLT ADD R12, R0, R1
	LDI R2, 8
	H LDI R15, %hi(readInput)
	SLT ADI R15, %lo(readInput)
	CAL R15
	CHAR LOD R12, R1, 0
	LDI R2, 223
	AND R1, R2, R1
	LDI R2, 81
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB51_14)
	SLT ADI R15, %lo(.LBB51_14)
	BRH EQ, R15
; %bb.11:                               ;   in Loop: Header=BB51_2 Depth=1
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.9
	SLT ADI R1, .L.str.9
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.10
	SLT ADI R1, .L.str.10
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(.LBB51_12)
	SLT ADI R15, %lo(.LBB51_12)
	JMP R15
.LBB51_14:
	INT LOD R14, R13, -44
	INT LOD R14, R12, -40
	INT LOD R14, R11, -36
	INT LOD R14, R10, -32
	INT LOD R14, R9, -28
	INT LOD R14, R8, -24
	SLT ADI R14, -48
	RET
.Lfunc_end51:
	.size	lsboot, .Lfunc_end51-lsboot
                                        ; -- End function
	.globl	setboot                         ; -- Begin function setboot
	.type	setboot,@function
setboot:                                ; @setboot
; %bb.0:
	SLT ADI R14, 4
	SLT ADI R14, -4
	RET
.Lfunc_end52:
	.size	setboot, .Lfunc_end52-setboot
                                        ; -- End function
	.globl	cls                             ; -- Begin function cls
	.type	cls,@function
cls:                                    ; @cls
; %bb.0:
	SLT ADI R14, 4
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	SLT ADI R14, -4
	RET
.Lfunc_end53:
	.size	cls, .Lfunc_end53-cls
                                        ; -- End function
	.globl	BiosShell                       ; -- Begin function BiosShell
	.type	BiosShell,@function
BiosShell:                              ; @BiosShell
; %bb.0:
	SLT ADI R14, 60
	INT STR R14, R8, -36
	INT STR R14, R9, -40
	INT STR R14, R10, -44
	INT STR R14, R11, -48
	INT STR R14, R12, -52
	INT STR R14, R13, -56
	LDI R13, 4
	LDI R8, 0
	ADD R14, R0, R9
	SLT ADI R9, -32
	LDI R10, 32
	LDI R11, 5
	LDI R12, 7
	H LDI R15, %hi(.LBB54_1)
	SLT ADI R15, %lo(.LBB54_1)
	JMP R15
.LBB54_2:                               ;   in Loop: Header=BB54_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos
	SLT ADI R1, tabla_comandos
.LBB54_17:                              ;   in Loop: Header=BB54_1 Depth=1
	INT LOD R1, R1, 4
	CAL R1
.LBB54_1:                               ; =>This Inner Loop Header: Depth=1
	;APP
	CYE SR8, R1
	;NO_APP
	NOR R1, R13, R1
	NOR R1, R1, R1
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R1, .L.str.11
	SLT ADI R1, .L.str.11
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	SLT ADD R9, R0, R1
	SLT ADD R10, R0, R2
	H LDI R15, %hi(readInput)
	SLT ADI R15, %lo(readInput)
	CAL R15
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.13
	SLT ADI R2, .L.str.13
	SLT ADD R11, R0, R3
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB54_2)
	SLT ADI R15, %lo(.LBB54_2)
	BRH EQ, R15
; %bb.3:                                ;   in Loop: Header=BB54_1 Depth=1
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.14
	SLT ADI R2, .L.str.14
	SLT ADD R12, R0, R3
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB54_4)
	SLT ADI R15, %lo(.LBB54_4)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB54_1 Depth=1
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.15
	SLT ADI R2, .L.str.15
	LDI R3, 6
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB54_6)
	SLT ADI R15, %lo(.LBB54_6)
	BRH EQ, R15
; %bb.7:                                ;   in Loop: Header=BB54_1 Depth=1
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.16
	SLT ADI R2, .L.str.16
	SLT ADD R12, R0, R3
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB54_8)
	SLT ADI R15, %lo(.LBB54_8)
	BRH EQ, R15
; %bb.9:                                ;   in Loop: Header=BB54_1 Depth=1
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.17
	SLT ADI R2, .L.str.17
	LDI R3, 9
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB54_10)
	SLT ADI R15, %lo(.LBB54_10)
	BRH EQ, R15
; %bb.11:                               ;   in Loop: Header=BB54_1 Depth=1
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.18
	SLT ADI R2, .L.str.18
	SLT ADD R12, R0, R3
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB54_12)
	SLT ADI R15, %lo(.LBB54_12)
	BRH EQ, R15
; %bb.13:                               ;   in Loop: Header=BB54_1 Depth=1
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.19
	SLT ADI R2, .L.str.19
	LDI R3, 8
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB54_14)
	SLT ADI R15, %lo(.LBB54_14)
	BRH EQ, R15
; %bb.15:                               ;   in Loop: Header=BB54_1 Depth=1
	CHAR LOD R9, R1, 2
	LDI R2, 16
	LSH R1, R2, R1
	CHAR LOD R9, R2, 3
	LDI R3, 24
	LSH R2, R3, R2
	NOR R2, R1, R1
	CHAR LOD R9, R2, 1
	LDI R3, 8
	LSH R2, R3, R2
	CHAR LOD R9, R3, 0
	NOR R2, R3, R2
	NOR R1, R1, R1
	NOR R2, R2, R2
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 0
	H LDI R2, 115
	SLT ADI R2, 27747
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB54_16)
	SLT ADI R15, %lo(.LBB54_16)
	BRH EQ, R15
; %bb.18:                               ;   in Loop: Header=BB54_1 Depth=1
	CHAR LOD R9, R1, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB54_1)
	SLT ADI R15, %lo(.LBB54_1)
	BRH EQ, R15
; %bb.19:                               ;   in Loop: Header=BB54_1 Depth=1
	LDI R1, 0
	H LDI R1, .L.str.12
	SLT ADI R1, .L.str.12
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(.LBB54_1)
	SLT ADI R15, %lo(.LBB54_1)
	JMP R15
.LBB54_4:                               ;   in Loop: Header=BB54_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+8
	SLT ADI R1, tabla_comandos+8
	H LDI R15, %hi(.LBB54_17)
	SLT ADI R15, %lo(.LBB54_17)
	JMP R15
.LBB54_6:                               ;   in Loop: Header=BB54_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+16
	SLT ADI R1, tabla_comandos+16
	H LDI R15, %hi(.LBB54_17)
	SLT ADI R15, %lo(.LBB54_17)
	JMP R15
.LBB54_8:                               ;   in Loop: Header=BB54_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+24
	SLT ADI R1, tabla_comandos+24
	H LDI R15, %hi(.LBB54_17)
	SLT ADI R15, %lo(.LBB54_17)
	JMP R15
.LBB54_10:                              ;   in Loop: Header=BB54_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+32
	SLT ADI R1, tabla_comandos+32
	H LDI R15, %hi(.LBB54_17)
	SLT ADI R15, %lo(.LBB54_17)
	JMP R15
.LBB54_12:                              ;   in Loop: Header=BB54_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+40
	SLT ADI R1, tabla_comandos+40
	H LDI R15, %hi(.LBB54_17)
	SLT ADI R15, %lo(.LBB54_17)
	JMP R15
.LBB54_14:                              ;   in Loop: Header=BB54_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+48
	SLT ADI R1, tabla_comandos+48
	H LDI R15, %hi(.LBB54_17)
	SLT ADI R15, %lo(.LBB54_17)
	JMP R15
.LBB54_16:                              ;   in Loop: Header=BB54_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+56
	SLT ADI R1, tabla_comandos+56
	H LDI R15, %hi(.LBB54_17)
	SLT ADI R15, %lo(.LBB54_17)
	JMP R15
.Lfunc_end54:
	.size	BiosShell, .Lfunc_end54-BiosShell
                                        ; -- End function
	.type	.L.str,@object                  ; @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"No se encontraron Memorias secundarias\n"
	.size	.L.str, 40

	.type	.L.str.1,@object                ; @.str.1
.L.str.1:
	.asciz	"No hay teclado conectado\n"
	.size	.L.str.1, 26

	.type	kq,@object                      ; @kq
	.local	kq
	.comm	kq,4,4
	.type	kb_registers,@object            ; @kb_registers
	.local	kb_registers
	.comm	kb_registers,4,4
	.type	.L.str.4,@object                ; @.str.4
.L.str.4:
	.asciz	"\nIRQs deshabilitadas. Imposible leer datos.\n"
	.size	.L.str.4, 45

	.type	.L.str.1.3,@object              ; @.str.1.3
.L.str.1.3:
	.asciz	"\b"
	.size	.L.str.1.3, 2

	.type	.L.str.2,@object                ; @.str.2
.L.str.2:
	.asciz	"\n"
	.size	.L.str.2, 2

	.type	.L.str.3,@object                ; @.str.3
.L.str.3:
	.asciz	"\nError alojando memoria para el buffer de teclado"
	.size	.L.str.3, 50

	.type	.L.str.7,@object                ; @.str.7
.L.str.7:
	.asciz	"\nError alojando memoria para tabla NVM"
	.size	.L.str.7, 39

	.type	.L.str.1.8,@object              ; @.str.1.8
.L.str.1.8:
	.asciz	"\nError alojando paginas DMA para NVM"
	.size	.L.str.1.8, 37

	.type	.L.str.3.9,@object              ; @.str.3.9
.L.str.3.9:
	.asciz	"\nDispositivo NVM inexistente"
	.size	.L.str.3.9, 29

	.type	current_display,@object         ; @current_display
	.local	current_display
	.comm	current_display,4,4
	.type	display_queue,@object           ; @display_queue
	.local	display_queue
	.comm	display_queue,4,4
	.type	irq_table,@object               ; @irq_table
	.local	irq_table
	.comm	irq_table,4,4
	.type	Registros,@object               ; @Registros
	.section	.bss,"aw",@nobits
	.globl	Registros
	.p2align	2, 0x0
Registros:
	.long	0
	.size	Registros, 4

	.type	.L.str.22,@object               ; @.str.22
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.22:
	.asciz	"Fatal Error: Unhandled IRQ"
	.size	.L.str.22, 27

	.type	.L.str.29,@object               ; @.str.29
.L.str.29:
	.asciz	"\nFatal Error: Page Fault without MMU"
	.size	.L.str.29, 37

	.type	.L.str.1.32,@object             ; @.str.1.32
.L.str.1.32:
	.asciz	"\nFatal Error: Alignament Fault"
	.size	.L.str.1.32, 31

	.type	.L.str.2.35,@object             ; @.str.2.35
.L.str.2.35:
	.asciz	"\nFatal Error: General Protection Fault"
	.size	.L.str.2.35, 39

	.type	.L.str.3.38,@object             ; @.str.3.38
.L.str.3.38:
	.asciz	"\nFatal Error: Invalid OpCode"
	.size	.L.str.3.38, 29

	.type	.L.str.4.41,@object             ; @.str.4.41
.L.str.4.41:
	.asciz	"\nFatal Error: Double Fault"
	.size	.L.str.4.41, 27

	.type	current_pool_index,@object      ; @current_pool_index
	.local	current_pool_index
	.comm	current_pool_index,4,4
	.type	ascii_pool,@object              ; @ascii_pool
	.local	ascii_pool
	.comm	ascii_pool,4,4
	.type	strtok.last_token,@object       ; @strtok.last_token
	.local	strtok.last_token
	.comm	strtok.last_token,4,4
	.type	poolFreeList,@object            ; @poolFreeList
	.local	poolFreeList
	.comm	poolFreeList,4,4
	.type	poolBump,@object                ; @poolBump
	.local	poolBump
	.comm	poolBump,4,4
	.type	poolRemaining,@object           ; @poolRemaining
	.local	poolRemaining
	.comm	poolRemaining,4,4
	.type	varMap,@object                  ; @varMap
	.local	varMap
	.comm	varMap,4,4
	.type	mapEntries,@object              ; @mapEntries
	.local	mapEntries
	.comm	mapEntries,4,4
	.type	.L.str.50,@object               ; @.str.50
.L.str.50:
	.asciz	"El sistema permite estos comandos: \n"
	.size	.L.str.50, 37

	.type	.L.str.1.51,@object             ; @.str.1.51
.L.str.1.51:
	.asciz	"- "
	.size	.L.str.1.51, 3

	.type	tabla_comandos,@object          ; @tabla_comandos
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
tabla_comandos:
	.long	.L.str.13
	.long	help
	.long	.L.str.14
	.long	sysOff
	.long	.L.str.15
	.long	reset
	.long	.L.str.16
	.long	initSO
	.long	.L.str.17
	.long	enumdisp
	.long	.L.str.18
	.long	lsboot
	.long	.L.str.19
	.long	setboot
	.long	.L.str.20
	.long	cls
	.size	tabla_comandos, 64

	.type	.L.str.2.52,@object             ; @.str.2.52
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.2.52:
	.asciz	"\n"
	.size	.L.str.2.52, 2

	.type	.L.str.3.53,@object             ; @.str.3.53
.L.str.3.53:
	.asciz	"Apagando sistema..."
	.size	.L.str.3.53, 20

	.type	.L.str.4.54,@object             ; @.str.4.54
.L.str.4.54:
	.asciz	"Hay "
	.size	.L.str.4.54, 5

	.type	Globals,@object                 ; @Globals
	.section	.bss,"aw",@nobits
	.globl	Globals
	.p2align	2, 0x0
Globals:
	.long	0
	.size	Globals, 4

	.type	.L.str.5,@object                ; @.str.5
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.5:
	.asciz	" dispositivos conectados\n"
	.size	.L.str.5, 26

	.type	.L.str.6,@object                ; @.str.6
.L.str.6:
	.asciz	"Class Code   ECAM Address\n"
	.size	.L.str.6, 27

	.type	.L.str.7.55,@object             ; @.str.7.55
.L.str.7.55:
	.asciz	"------------ ------------\n"
	.size	.L.str.7.55, 27

	.type	mapa,@object                    ; @mapa
	.section	.bss,"aw",@nobits
	.globl	mapa
	.p2align	2, 0x0
mapa:
	.long	0
	.size	mapa, 4

	.type	.L.str.8,@object                ; @.str.8
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.8:
	.asciz	" NVMs conectados\n"
	.size	.L.str.8, 18

	.type	.L.str.9,@object                ; @.str.9
.L.str.9:
	.asciz	"ID    Nombre\n"
	.size	.L.str.9, 14

	.type	.L.str.10,@object               ; @.str.10
.L.str.10:
	.asciz	"--    -----------\n"
	.size	.L.str.10, 19

	.type	nvmDevs,@object                 ; @nvmDevs
	.section	.bss,"aw",@nobits
	.globl	nvmDevs
	.p2align	2, 0x0
nvmDevs:
	.long	0
	.size	nvmDevs, 4

	.type	.L.str.11,@object               ; @.str.11
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.11:
	.asciz	">"
	.size	.L.str.11, 2

	.type	.L.str.12,@object               ; @.str.12
.L.str.12:
	.asciz	"Comando no reconocido. Use 'help' para ver los comandos reconocidos\n"
	.size	.L.str.12, 69

	.type	.L.str.13,@object               ; @.str.13
.L.str.13:
	.asciz	"help"
	.size	.L.str.13, 5

	.type	.L.str.14,@object               ; @.str.14
.L.str.14:
	.asciz	"sysOff"
	.size	.L.str.14, 7

	.type	.L.str.15,@object               ; @.str.15
.L.str.15:
	.asciz	"reset"
	.size	.L.str.15, 6

	.type	.L.str.16,@object               ; @.str.16
.L.str.16:
	.asciz	"initSO"
	.size	.L.str.16, 7

	.type	.L.str.17,@object               ; @.str.17
.L.str.17:
	.asciz	"enumdisp"
	.size	.L.str.17, 9

	.type	.L.str.18,@object               ; @.str.18
.L.str.18:
	.asciz	"lsboot"
	.size	.L.str.18, 7

	.type	.L.str.19,@object               ; @.str.19
.L.str.19:
	.asciz	"setboot"
	.size	.L.str.19, 8

	.type	.L.str.20,@object               ; @.str.20
.L.str.20:
	.asciz	"cls"
	.size	.L.str.20, 4

	.type	.L.str.21,@object               ; @.str.21
.L.str.21:
	.asciz	"Continuar? (c/Enter, q para salir): "
	.size	.L.str.21, 37

	.ident	"clang version 24.0.0git (https://github.com/Licha-M/llvm-project-ISA32-LM.git 2be4a0c0192624151272935c0f47976a434289a2)"
	.section	".note.GNU-stack","",@progbits

; ════════════════════ .start auto-generado ════════════════════
; Inicio en palabra ROM 7945 (byte 0x007C24)
; .start:
;	H LDI R14, 0		; SP = 0x00001000
;	SLT ADI R14, 4096
;	H LDI R15, %hi(main)
;	SLT ADI R15, %lo(main)
;	JMP R15

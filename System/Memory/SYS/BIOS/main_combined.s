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
	SLT ADI R14, 12
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	LDI R3, 1
	LDI R8, 0
	SLT ADD R8, R0, R1
	SLT ADD R8, R0, R2
	SLT ADD R8, R0, R4
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
	LDI R2, 20
	LDI R9, 0
	H LDI R9, Globals
	SLT ADI R9, Globals
	SLT ADD R8, R0, R1
	LDI R3, 0
	H LDI R3, Globals
	SLT ADI R3, Globals
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
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
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 4
	INT LOD R1, R1, 0
	INT LOD R9, R2, 0
	INT STR R2, R1, 16
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -12
	RET
.Lfunc_end1:
	.size	initGlobalVars, .Lfunc_end1-initGlobalVars
                                        ; -- End function
	.globl	main                            ; -- Begin function main
	.type	main,@function
main:                                   ; @main
; %bb.0:
	SLT ADI R14, 12
	INT STR R14, R8, -4
	INT STR R14, R9, -8
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
	LDI R3, 1
	LDI R8, 0
	SLT ADD R8, R0, R1
	SLT ADD R8, R0, R2
	SLT ADD R8, R0, R4
	H LDI R15, %hi(allocatePages)
	SLT ADI R15, %lo(allocatePages)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB2_4)
	SLT ADI R15, %lo(.LBB2_4)
	BRH EQ, R15
.LBB2_3:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB2_3)
	SLT ADI R15, %lo(.LBB2_3)
	JMP R15
.LBB2_1:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB2_1)
	SLT ADI R15, %lo(.LBB2_1)
	JMP R15
.LBB2_4:
	LDI R2, 20
	LDI R9, 0
	H LDI R9, Globals
	SLT ADI R9, Globals
	SLT ADD R8, R0, R1
	LDI R3, 0
	H LDI R3, Globals
	SLT ADI R3, Globals
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB2_6)
	SLT ADI R15, %lo(.LBB2_6)
	BRH EQ, R15
.LBB2_5:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB2_5)
	SLT ADI R15, %lo(.LBB2_5)
	JMP R15
.LBB2_6:
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 4
	INT LOD R1, R1, 0
	INT LOD R9, R2, 0
	INT STR R2, R1, 16
	H LDI R15, %hi(initLAPIC)
	SLT ADI R15, %lo(initLAPIC)
	CAL R15
	H LDI R15, %hi(PCIe_Bus_Enumeration)
	SLT ADI R15, %lo(PCIe_Bus_Enumeration)
	CAL R15
	H LDI R15, %hi(displaySearch)
	SLT ADI R15, %lo(displaySearch)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB2_7)
	SLT ADI R15, %lo(.LBB2_7)
	BRH EQ, R15
; %bb.8:
	H LDI R15, %hi(nvmSearch)
	SLT ADI R15, %lo(nvmSearch)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB2_9)
	SLT ADI R15, %lo(.LBB2_9)
	BRH EQ, R15
; %bb.11:
	H LDI R15, %hi(keyboardSearch)
	SLT ADI R15, %lo(keyboardSearch)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB2_12)
	SLT ADI R15, %lo(.LBB2_12)
	BRH EQ, R15
; %bb.14:
	H LDI R15, %hi(BiosShell)
	SLT ADI R15, %lo(BiosShell)
	CAL R15
	LDI R1, 0
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -12
	RET
.LBB2_7:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB2_7)
	SLT ADI R15, %lo(.LBB2_7)
	JMP R15
.LBB2_9:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str
	SLT ADI R1, .L.str
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB2_10:                               ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB2_10)
	SLT ADI R15, %lo(.LBB2_10)
	JMP R15
.LBB2_12:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.1
	SLT ADI R1, .L.str.1
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB2_13:                               ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB2_13)
	SLT ADI R15, %lo(.LBB2_13)
	JMP R15
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
	LDI R2, 0
	H LDI R2, Globals
	SLT ADI R2, Globals
	INT LOD R2, R2, 0
	INT STR R2, R1, 8
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB6_13)
	SLT ADI R15, %lo(.LBB6_13)
	BRH EQ, R15
; %bb.1:
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
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R3, 8
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB6_13)
	SLT ADI R15, %lo(.LBB6_13)
	BRH EQ, R15
; %bb.4:                                ; %.preheader
	ADI R1, 8
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
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	ADI R8, 1
	INT LOD R1, R3, 8
	ADI R1, 8
	SUB R8, R3, R0
	H LDI R15, %hi(.LBB6_11)
	SLT ADI R15, %lo(.LBB6_11)
	BRH NC, R15
.LBB6_5:                                ; =>This Inner Loop Header: Depth=1
	INT STR R1, R8, 0
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
	INT STR R1, R2, 8
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
	INT LOD R5, R5, 8
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB8_2)
	SLT ADI R15, %lo(.LBB8_2)
	BRH NC, R15
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
	INT LOD R5, R5, 8
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB9_2)
	SLT ADI R15, %lo(.LBB9_2)
	BRH NC, R15
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
	SLT ADI R14, 28
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	INT STR R14, R13, -24
	LDI R1, 0
	H LDI R1, 7
	SLT ADI R1, 0
	H LDI R15, %hi(searchFirst)
	SLT ADI R15, %lo(searchFirst)
	CAL R15
	SLT ADD R1, R0, R8
	LDI R9, 0
	SUB R8, R9, R0
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
	CHAR LOD R1, R13, 16
	CHAR LOD R1, R12, 17
	CHAR LOD R1, R10, 18
	LDI R1, 4
	LDI R2, 16
	LDI R3, 0
	H LDI R3, current_display
	SLT ADI R3, current_display
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB10_5)
	SLT ADI R15, %lo(.LBB10_5)
	BRH NE, R15
; %bb.2:
	LDI R1, 5
	LDI R2, 468
	LDI R11, 0
	H LDI R11, display_queue
	SLT ADI R11, display_queue
	LDI R3, 0
	H LDI R3, display_queue
	SLT ADI R3, display_queue
	H LDI R15, %hi(allocatePool)
	SLT ADI R15, %lo(allocatePool)
	CAL R15
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB10_5)
	SLT ADI R15, %lo(.LBB10_5)
	BRH NE, R15
; %bb.3:
	INT LOD R11, R1, 0
	CHAR STR R1, R9, 64
	CHAR STR R1, R9, 65
	CHAR STR R1, R9, 66
	LDI R1, 20
	LSH R13, R1, R1
	LDI R2, 15
	LSH R12, R2, R2
	NOR R2, R1, R1
	LDI R11, 0
	H LDI R11, current_display
	SLT ADI R11, current_display
	INT LOD R11, R2, 0
	CHAR STR R2, R9, 12
	LDI R3, 12
	LSH R10, R3, R3
	NOR R1, R1, R1
	NOR R1, R3, R1
	NOR R1, R1, R1
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 4
	NOR R1, R3, R3
	NOR R3, R3, R3
	LDI R4, 3
	INT STR R3, R4, 0
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 16
	NOR R1, R3, R3
	NOR R3, R3, R3
	INT LOD R3, R3, 0
	INT STR R2, R3, 4
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 0
	NOR R1, R2, R1
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
	INT LOD R14, R13, -24
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -28
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
	SLT ADI R14, 52
	INT STR R14, R8, -28
	INT STR R14, R9, -32
	INT STR R14, R10, -36
	INT STR R14, R11, -40
	INT STR R14, R12, -44
	INT STR R14, R13, -48
	INT STR R14, R3, -4
	SLT ADD R2, R0, R11
	LDI R2, 0
	H LDI R2, Globals
	SLT ADI R2, Globals
	INT LOD R2, R2, 0
	CHAR LOD R2, R2, 4
	LDI R5, 1
	SUB R2, R5, R0
	H LDI R15, %hi(.LBB12_1)
	SLT ADI R15, %lo(.LBB12_1)
	BRH EQ, R15
; %bb.9:
	LDI R3, 0
	LDI R4, 3
	SLT ADD R5, R0, R6
	SUB R11, R4, R0
	H LDI R15, %hi(.LBB12_11)
	SLT ADI R15, %lo(.LBB12_11)
	BRH NE, R15
; %bb.10:
	SLT ADD R3, R0, R6
.LBB12_11:
	INT LOD R14, R2, -4
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB12_13)
	SLT ADI R15, %lo(.LBB12_13)
	BRH N, R15
; %bb.12:
	SLT ADD R3, R0, R5
.LBB12_13:
	AND R6, R5, R2
	LDI R5, 2
	RSH R11, R5, R5
	NOR R5, R2, R2
	NOR R2, R2, R2
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB12_14)
	SLT ADI R15, %lo(.LBB12_14)
	BRH EQ, R15
; %bb.24:
	LDI R8, 0
	LDI R5, 1
	LDI R2, 4
	SUB R11, R2, R0
	H LDI R15, %hi(.LBB12_26)
	SLT ADI R15, %lo(.LBB12_26)
	BRH EQ, R15
; %bb.25:
	SLT ADD R8, R0, R5
.LBB12_26:
	LDI R6, 0
	H LDI R6, 65520
	SLT ADI R6, -1
	LDI R3, 1
	SUB R6, R1, R0
	H LDI R15, %hi(.LBB12_28)
	SLT ADI R15, %lo(.LBB12_28)
	BRH C, R15
; %bb.27:
	SLT ADD R8, R0, R3
.LBB12_28:
	AND R3, R5, R3
	LDI R9, 0
	H LDI R9, display_queue
	SLT ADI R9, display_queue
	LDI R2, 1
	AND R3, R2, R6
	LDI R13, 79
.LBB12_29:                              ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB12_30 Depth 2
                                        ;     Child Loop BB12_34 Depth 2
	INT LOD R9, R3, 0
	CHAR LOD R3, R3, 66
	LDI R2, 4
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB12_31)
	SLT ADI R15, %lo(.LBB12_31)
	BRH C, R15
.LBB12_30:                              ;   Parent Loop BB12_29 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	;APP
	HLT
	;NO_APP
	INT LOD R9, R3, 0
	CHAR LOD R3, R3, 66
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB12_30)
	SLT ADI R15, %lo(.LBB12_30)
	BRH C, R15
.LBB12_31:                              ;   in Loop: Header=BB12_29 Depth=1
	;APP
	CYE SR8, R2
	;NO_APP
	INT STR R14, R2, -8
	;APP
	CYE SR8, R3
	;NO_APP
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -5
	AND R3, R2, R3
	;APP
	CYR R3, SR8
	;NO_APP
	INT LOD R9, R12, 0
	CHAR LOD R12, R7, 65
	SLT ADD R6, R0, R5
	SUB R6, R8, R0
	H LDI R15, %hi(.LBB12_32)
	SLT ADI R15, %lo(.LBB12_32)
	BRH EQ, R15
; %bb.33:                               ;   in Loop: Header=BB12_29 Depth=1
	LDI R2, 80
	MUL R7, R2, R10
	ADD R12, R10, R12
	ADI R12, 67
	SLT ADD R8, R0, R6
.LBB12_34:                              ;   Parent Loop BB12_29 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ADD R1, R6, R3
	CHAR LOD R3, R3, 0
	SUB R3, R8, R0
	H LDI R15, %hi(.LBB12_37)
	SLT ADI R15, %lo(.LBB12_37)
	BRH EQ, R15
; %bb.35:                               ;   in Loop: Header=BB12_34 Depth=2
	ADD R12, R6, R2
	CHAR STR R2, R3, 0
	ADI R6, 1
	SUB R6, R13, R0
	H LDI R15, %hi(.LBB12_34)
	SLT ADI R15, %lo(.LBB12_34)
	BRH NE, R15
; %bb.36:                               ;   in Loop: Header=BB12_29 Depth=1
	SLT ADD R13, R0, R6
.LBB12_37:                              ;   in Loop: Header=BB12_29 Depth=1
	ADD R12, R6, R2
	CHAR STR R2, R8, 0
	ADD R1, R6, R1
	INT LOD R9, R12, 0
	ADD R12, R10, R10
	ADI R10, 67
	H LDI R15, %hi(.LBB12_38)
	SLT ADI R15, %lo(.LBB12_38)
	JMP R15
.LBB12_32:                              ;   in Loop: Header=BB12_29 Depth=1
	SLT ADD R1, R0, R10
.LBB12_38:                              ;   in Loop: Header=BB12_29 Depth=1
	LDI R2, 4
	LSH R7, R2, R2
	ADD R12, R2, R3
	INT STR R3, R10, 0
	INT LOD R9, R6, 0
	ADD R6, R2, R2
	CHAR LOD R10, R3, 0
	INT LOD R14, R10, -4
	INT STR R2, R10, 12
	INT STR R2, R11, 8
	CHAR STR R2, R3, 4
	ADI R7, 1
	AND R7, R4, R2
	CHAR STR R6, R2, 65
	SLT ADD R6, R0, R2
	ADI R2, 66
	CHAR LOD R2, R2, 0
	ADI R2, 1
	CHAR STR R6, R2, 66
	LDI R2, 0
	H LDI R2, current_display
	SLT ADI R2, current_display
	INT LOD R2, R7, 0
	CHAR LOD R7, R2, 12
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB12_46)
	SLT ADI R15, %lo(.LBB12_46)
	BRH NE, R15
; %bb.39:                               ;   in Loop: Header=BB12_29 Depth=1
	LDI R2, 1
	CHAR STR R7, R2, 12
	CHAR LOD R6, R2, 64
	LDI R3, 4
	LSH R2, R3, R2
	ADD R6, R2, R10
	INT LOD R7, R7, 4
	INT LOD R10, R6, 8
	SLT ADD R6, R0, R3
	ADI R3, -1
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB12_44)
	SLT ADI R15, %lo(.LBB12_44)
	BRH C, R15
; %bb.40:                               ;   in Loop: Header=BB12_29 Depth=1
	LDI R2, 2
	LSH R3, R2, R2
	LDI R3, 0
	H LDI R3, .LJTI12_0
	SLT ADI R3, .LJTI12_0
	ADD R3, R2, R2
	INT LOD R2, R2, 0
	JMP R2
.LBB12_41:                              ;   in Loop: Header=BB12_29 Depth=1
	INT LOD R10, R2, 12
	INT STR R7, R2, 8
	CHAR LOD R10, R2, 4
	INT STR R7, R2, 4
	LDI R6, 1
	H LDI R15, %hi(.LBB12_45)
	SLT ADI R15, %lo(.LBB12_45)
	JMP R15
.LBB12_42:                              ;   in Loop: Header=BB12_29 Depth=1
	INT LOD R10, R2, 12
	INT STR R7, R2, 8
	LDI R6, 2
	H LDI R15, %hi(.LBB12_45)
	SLT ADI R15, %lo(.LBB12_45)
	JMP R15
.LBB12_43:                              ;   in Loop: Header=BB12_29 Depth=1
	INT LOD R10, R2, 0
	INT STR R7, R2, 4
	LDI R6, 4
	H LDI R15, %hi(.LBB12_45)
	SLT ADI R15, %lo(.LBB12_45)
	JMP R15
.LBB12_44:                              ;   in Loop: Header=BB12_29 Depth=1
	SLT ADD R8, R0, R6
.LBB12_45:                              ;   in Loop: Header=BB12_29 Depth=1
	INT STR R7, R6, 0
.LBB12_46:                              ;   in Loop: Header=BB12_29 Depth=1
	INT LOD R14, R2, -8
	;APP
	CYR R2, SR8
	;NO_APP
	SLT ADD R5, R0, R6
	SUB R6, R8, R0
	H LDI R15, %hi(.LBB12_48)
	SLT ADI R15, %lo(.LBB12_48)
	BRH EQ, R15
; %bb.47:                               ;   in Loop: Header=BB12_29 Depth=1
	CHAR LOD R1, R2, 0
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB12_29)
	SLT ADI R15, %lo(.LBB12_29)
	BRH NE, R15
	H LDI R15, %hi(.LBB12_48)
	SLT ADI R15, %lo(.LBB12_48)
	JMP R15
.LBB12_14:
	LDI R3, 0
	H LDI R3, current_display
	SLT ADI R3, current_display
	INT LOD R3, R2, 0
	CHAR LOD R2, R2, 12
	LDI R5, 1
	SUB R2, R5, R0
	H LDI R15, %hi(.LBB12_17)
	SLT ADI R15, %lo(.LBB12_17)
	BRH NE, R15
; %bb.15:                               ; %.preheader
	LDI R2, 0
.LBB12_16:                              ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	INT LOD R3, R5, 0
	CHAR LOD R5, R5, 12
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB12_16)
	SLT ADI R15, %lo(.LBB12_16)
	BRH NE, R15
.LBB12_17:
	;APP
	CYE SR8, R5
	;NO_APP
	;APP
	CYE SR8, R2
	;NO_APP
	LDI R6, 0
	H LDI R6, 0
	SLT ADI R6, -5
	AND R2, R6, R2
	;APP
	CYR R2, SR8
	;NO_APP
	INT LOD R3, R2, 0
	INT LOD R2, R6, 4
	SLT ADD R11, R0, R2
	ADI R2, -1
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB12_22)
	SLT ADI R15, %lo(.LBB12_22)
	BRH C, R15
; %bb.18:
	LDI R3, 2
	LSH R2, R3, R2
	LDI R3, 0
	H LDI R3, .LJTI12_1
	SLT ADI R3, .LJTI12_1
	ADD R3, R2, R2
	INT LOD R2, R2, 0
	JMP R2
.LBB12_19:
	CHAR LOD R1, R1, 0
	INT LOD R14, R2, -4
	INT STR R6, R2, 8
	INT STR R6, R1, 4
	LDI R11, 1
	H LDI R15, %hi(.LBB12_23)
	SLT ADI R15, %lo(.LBB12_23)
	JMP R15
.LBB12_20:
	INT LOD R14, R1, -4
	INT STR R6, R1, 8
	LDI R11, 2
	H LDI R15, %hi(.LBB12_23)
	SLT ADI R15, %lo(.LBB12_23)
	JMP R15
.LBB12_21:
	INT STR R6, R1, 4
	LDI R11, 4
	H LDI R15, %hi(.LBB12_23)
	SLT ADI R15, %lo(.LBB12_23)
	JMP R15
.LBB12_22:
	LDI R11, 0
.LBB12_23:
	INT STR R6, R11, 0
	;APP
	CYR R5, SR8
	;NO_APP
.LBB12_48:
	INT LOD R14, R13, -48
	INT LOD R14, R12, -44
	INT LOD R14, R11, -40
	INT LOD R14, R10, -36
	INT LOD R14, R9, -32
	INT LOD R14, R8, -28
	SLT ADI R14, -52
	RET
.LBB12_1:
	LDI R2, 0
	H LDI R2, 65520
	SLT ADI R2, 0
	SLT ADD R1, R0, R3
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB12_8)
	SLT ADI R15, %lo(.LBB12_8)
	BRH C, R15
; %bb.2:
	LDI R2, 4
	SLT ADD R1, R0, R3
	SUB R11, R2, R0
	H LDI R15, %hi(.LBB12_8)
	SLT ADI R15, %lo(.LBB12_8)
	BRH NE, R15
; %bb.3:
	LDI R4, 0
	LDI R2, 0
	H LDI R2, display_queue
	SLT ADI R2, display_queue
	INT LOD R2, R5, 0
	ADI R5, 387
	LDI R6, 79
	SLT ADD R4, R0, R3
.LBB12_4:                               ; =>This Inner Loop Header: Depth=1
	ADD R1, R3, R2
	CHAR LOD R2, R2, 0
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB12_5)
	SLT ADI R15, %lo(.LBB12_5)
	BRH EQ, R15
; %bb.6:                                ;   in Loop: Header=BB12_4 Depth=1
	ADD R5, R3, R7
	CHAR STR R7, R2, 0
	ADI R3, 1
	SUB R3, R6, R0
	H LDI R15, %hi(.LBB12_4)
	SLT ADI R15, %lo(.LBB12_4)
	BRH NE, R15
	H LDI R15, %hi(.LBB12_7)
	SLT ADI R15, %lo(.LBB12_7)
	JMP R15
.LBB12_5:
	SLT ADD R3, R0, R6
.LBB12_7:
	ADD R5, R6, R2
	CHAR STR R2, R4, 0
	LDI R2, 0
	H LDI R2, display_queue
	SLT ADI R2, display_queue
	INT LOD R2, R3, 0
	ADI R3, 387
.LBB12_8:
	ADD R14, R0, R4
	SLT ADI R4, -24
	INT STR R4, R3, 0
	CHAR LOD R1, R1, 0
	CHAR STR R4, R1, 4
	LDI R1, 0
	CHAR STR R4, R1, 5
	CHAR STR R4, R1, 6
	CHAR STR R4, R1, 7
	INT LOD R14, R1, -4
	INT STR R4, R1, 12
	INT STR R4, R11, 8
	SLT ADD R4, R0, R1
	H LDI R15, %hi(tty_execute_request)
	SLT ADI R15, %lo(tty_execute_request)
	CAL R15
	H LDI R15, %hi(.LBB12_48)
	SLT ADI R15, %lo(.LBB12_48)
	JMP R15
.Lfunc_end12:
	.size	ttyWrite, .Lfunc_end12-ttyWrite
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
	.type	.LJTI12_0,@object
.LJTI12_0:
	.long	.LBB12_41
	.long	.LBB12_42
	.long	.LBB12_45
	.long	.LBB12_43
	.size	.LJTI12_0, 16
	.type	.LJTI12_1,@object
.LJTI12_1:
	.long	.LBB12_19
	.long	.LBB12_20
	.long	.LBB12_23
	.long	.LBB12_21
	.size	.LJTI12_1, 16
                                        ; -- End function
	.text
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
	H LDI R15, %hi(.LBB13_5)
	SLT ADI R15, %lo(.LBB13_5)
	BRH C, R15
; %bb.1:
	LDI R5, 2
	LSH R4, R5, R4
	LDI R5, 0
	H LDI R5, .LJTI13_0
	SLT ADI R5, .LJTI13_0
	ADD R5, R4, R4
	INT LOD R4, R4, 0
	JMP R4
.LBB13_2:
	INT LOD R1, R3, 12
	INT STR R2, R3, 8
	CHAR LOD R1, R1, 4
	INT STR R2, R1, 4
	LDI R3, 1
	H LDI R15, %hi(.LBB13_6)
	SLT ADI R15, %lo(.LBB13_6)
	JMP R15
.LBB13_3:
	INT LOD R1, R1, 12
	INT STR R2, R1, 8
	LDI R3, 2
	H LDI R15, %hi(.LBB13_6)
	SLT ADI R15, %lo(.LBB13_6)
	JMP R15
.LBB13_4:
	INT LOD R1, R1, 0
	INT STR R2, R1, 4
	LDI R3, 4
	H LDI R15, %hi(.LBB13_6)
	SLT ADI R15, %lo(.LBB13_6)
	JMP R15
.LBB13_5:
	LDI R3, 0
.LBB13_6:
	INT STR R2, R3, 0
	SLT ADI R14, -4
	RET
.Lfunc_end13:
	.size	tty_execute_request, .Lfunc_end13-tty_execute_request
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
	.type	.LJTI13_0,@object
.LJTI13_0:
	.long	.LBB13_2
	.long	.LBB13_3
	.long	.LBB13_6
	.long	.LBB13_4
	.size	.LJTI13_0, 16
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
.Lfunc_end14:
	.size	biosClear, .Lfunc_end14-biosClear
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
	H LDI R15, %hi(.LBB15_1)
	SLT ADI R15, %lo(.LBB15_1)
	BRH EQ, R15
; %bb.2:
	SLT ADD R3, R0, R4
	H LDI R15, %hi(.LBB15_3)
	SLT ADI R15, %lo(.LBB15_3)
	JMP R15
.LBB15_1:
	LDI R4, 2
.LBB15_3:
	CHAR LOD R1, R6, 1
	LDI R5, 0
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB15_5)
	SLT ADI R15, %lo(.LBB15_5)
	BRH EQ, R15
; %bb.4:
	LDI R4, 4
.LBB15_5:
	NOR R2, R6, R6
	NOR R6, R6, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB15_7)
	SLT ADI R15, %lo(.LBB15_7)
	BRH EQ, R15
; %bb.6:
	SLT ADD R5, R0, R3
.LBB15_7:
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
.Lfunc_end15:
	.size	biosWrite, .Lfunc_end15-biosWrite
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
	SLT ADD R3, R0, R7
	INT STR R14, R2, -20
	SLT ADD R1, R0, R6
	LDI R1, 255
	SUB R1, R6, R0
	H LDI R15, %hi(.LBB16_41)
	SLT ADI R15, %lo(.LBB16_41)
	BRH C, R15
; %bb.1:
	LDI R1, 20
	LSH R6, R1, R2
	LDI R10, 1
	LDI R1, 0
	H LDI R1, 1
	SLT ADI R1, -28672
	INT STR R14, R2, -16
	NOR R2, R1, R1
	NOR R1, R1, R9
	LDI R5, 0
	H LDI R5, 57344
	SLT ADI R5, 0
	LDI R8, 0
	H LDI R8, 49152
	SLT ADI R8, 0
	INT STR R14, R7, -8
	INT STR R14, R6, -4
	H LDI R15, %hi(.LBB16_2)
	SLT ADI R15, %lo(.LBB16_2)
	JMP R15
.LBB16_5:                               ;   in Loop: Header=BB16_2 Depth=1
	LDI R8, 0
	H LDI R8, 49152
	SLT ADI R8, 0
	SUB R3, R11, R0
	H LDI R15, %hi(.LBB16_16)
	SLT ADI R15, %lo(.LBB16_16)
	BRH EQ, R15
.LBB16_40:                              ;   in Loop: Header=BB16_2 Depth=1
	LDI R1, 0
	H LDI R1, 1
	SLT ADI R1, -32768
	ADD R9, R1, R9
	ADI R10, 1
	LDI R1, 32
	SUB R10, R1, R0
	H LDI R15, %hi(.LBB16_41)
	SLT ADI R15, %lo(.LBB16_41)
	BRH EQ, R15
.LBB16_2:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB16_12 Depth 2
	LDI R1, 15
	LSH R10, R1, R1
	INT LOD R14, R2, -16
	ADD R1, R2, R12
	NOR R12, R5, R1
	NOR R1, R1, R1
	INT LOD R1, R1, 0
	LDI R2, 0
	H LDI R2, 1
	SLT ADI R2, -1
	AND R1, R2, R1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB16_40)
	SLT ADI R15, %lo(.LBB16_40)
	BRH EQ, R15
; %bb.3:                                ;   in Loop: Header=BB16_2 Depth=1
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R2, 0
	LDI R3, 63
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB16_41)
	SLT ADI R15, %lo(.LBB16_41)
	BRH C, R15
; %bb.4:                                ;   in Loop: Header=BB16_2 Depth=1
	INT LOD R7, R3, 0
	ADD R3, R8, R3
	LDI R4, 20
	MUL R2, R4, R8
	LDI R2, 0
	H LDI R2, mapa
	SLT ADI R2, mapa
	INT LOD R2, R2, 0
	ADD R2, R8, R2
	INT STR R2, R3, 0
	CHAR STR R2, R6, 16
	CHAR STR R2, R10, 17
	LDI R11, 0
	CHAR STR R2, R11, 18
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 8
	NOR R12, R3, R3
	NOR R3, R3, R3
	INT LOD R3, R13, 0
	LDI R3, 24
	RSH R13, R3, R3
	LDI R4, 127
	AND R3, R4, R3
	INT STR R2, R13, 12
	LDI R4, 1
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB16_5)
	SLT ADI R15, %lo(.LBB16_5)
	BRH NE, R15
; %bb.6:                                ;   in Loop: Header=BB16_2 Depth=1
	INT STR R14, R9, -12
	INT LOD R7, R3, 0
	LDI R4, 0
	H LDI R4, 1
	SLT ADI R4, -1
	ADD R3, R4, R3
	LDI R4, 0
	H LDI R4, 65535
	SLT ADI R4, 0
	AND R3, R4, R3
	INT STR R7, R3, 0
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, 0
	ADD R3, R4, R3
	INT STR R2, R3, 0
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 16
	NOR R12, R1, R1
	SLT ADD R6, R0, R9
	NOR R1, R1, R6
	INT LOD R14, R2, -20
	INT LOD R2, R1, 0
	INT LOD R6, R3, 0
	LDI R4, 0
	H LDI R4, 65280
	SLT ADI R4, 0
	AND R3, R4, R3
	LDI R4, 255
	AND R1, R4, R4
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
	INT STR R6, R3, 0
	INT LOD R2, R3, 0
	ADI R3, 1
	INT STR R2, R3, 0
	SLT ADD R7, R0, R3
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	INT LOD R14, R7, -8
	LDI R1, 0
	H LDI R1, mapa
	SLT ADI R1, mapa
	INT LOD R1, R2, 0
	ADD R2, R8, R1
	INT LOD R7, R3, 0
	INT LOD R1, R4, 0
	LDI R5, 0
	H LDI R5, 16384
	SLT ADI R5, 0
	ADD R4, R5, R4
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB16_8)
	SLT ADI R15, %lo(.LBB16_8)
	BRH NC, R15
; %bb.7:                                ;   in Loop: Header=BB16_2 Depth=1
	LDI R4, 0
	H LDI R4, 1
	SLT ADI R4, -1
	ADD R3, R4, R3
	LDI R4, 0
	H LDI R4, 65535
	SLT ADI R4, 0
	AND R3, R4, R3
	INT STR R7, R3, 0
.LBB16_8:                               ;   in Loop: Header=BB16_2 Depth=1
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 16
	ADD R12, R3, R3
	INT LOD R3, R4, 0
	LDI R5, 0
	H LDI R5, 65280
	SLT ADI R5, 255
	AND R4, R5, R4
	INT LOD R14, R5, -20
	INT LOD R5, R5, 0
	LDI R6, 16
	LSH R5, R6, R5
	LDI R6, 0
	H LDI R6, 255
	SLT ADI R6, 0
	ADD R5, R6, R5
	AND R5, R6, R5
	NOR R4, R5, R4
	NOR R4, R4, R4
	NOR R4, R9, R4
	NOR R4, R4, R4
	INT STR R3, R4, 0
	INT LOD R7, R3, 0
	LDI R8, 0
	H LDI R8, 49152
	SLT ADI R8, 0
	ADD R3, R8, R5
	INT STR R1, R5, 4
	INT LOD R1, R4, 0
	SUB R5, R4, R4
	INT STR R1, R4, 8
	INT LOD R1, R6, 0
	LDI R4, 0
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_10)
	SLT ADI R15, %lo(.LBB16_10)
	BRH NC, R15
; %bb.9:                                ;   in Loop: Header=BB16_2 Depth=1
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 4
	NOR R12, R4, R4
	NOR R4, R4, R4
	INT LOD R1, R1, 0
	LDI R5, 3
	INT STR R4, R5, 0
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, -1
	ADD R3, R4, R3
	LDI R4, 0
	H LDI R4, 65535
	SLT ADI R4, 0
	AND R3, R4, R3
	LDI R4, 16
	RSH R1, R4, R1
	NOR R1, R3, R1
	NOR R1, R1, R4
.LBB16_10:                              ;   in Loop: Header=BB16_2 Depth=1
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 24
	NOR R12, R1, R1
	NOR R1, R1, R1
	INT STR R1, R4, 0
	INT LOD R14, R6, -4
	INT LOD R14, R9, -12
	LDI R5, 0
	H LDI R5, 57344
	SLT ADI R5, 0
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB16_40)
	SLT ADI R15, %lo(.LBB16_40)
	BRH N, R15
; %bb.11:                               ; %.preheader
                                        ;   in Loop: Header=BB16_2 Depth=1
	SLT ADD R9, R0, R12
	LDI R13, 0
	H LDI R15, %hi(.LBB16_12)
	SLT ADI R15, %lo(.LBB16_12)
	JMP R15
.LBB16_39:                              ;   in Loop: Header=BB16_12 Depth=2
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 24
	ADD R12, R1, R1
	INT STR R1, R4, 0
	ADI R12, 4096
	INT LOD R14, R6, -4
	INT LOD R14, R9, -12
	LDI R5, 0
	H LDI R5, 57344
	SLT ADI R5, 0
	LDI R1, 7
	SUB R13, R1, R0
	H LDI R15, %hi(.LBB16_40)
	SLT ADI R15, %lo(.LBB16_40)
	BRH NC, R15
.LBB16_12:                              ;   Parent Loop BB16_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ADD R12, R5, R1
	INT LOD R1, R1, 0
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -1
	AND R1, R3, R1
	SUB R1, R3, R0
	H LDI R15, %hi(.LBB16_40)
	SLT ADI R15, %lo(.LBB16_40)
	BRH EQ, R15
; %bb.13:                               ;   in Loop: Header=BB16_12 Depth=2
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R3, 0
	LDI R4, 63
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB16_41)
	SLT ADI R15, %lo(.LBB16_41)
	BRH C, R15
; %bb.14:                               ;   in Loop: Header=BB16_12 Depth=2
	ADI R13, 1
	INT LOD R7, R4, 0
	ADD R4, R8, R4
	LDI R5, 20
	LDI R11, 0
	H LDI R11, 49152
	SLT ADI R11, 0
	MUL R3, R5, R8
	ADD R2, R8, R2
	INT STR R2, R4, 0
	CHAR STR R2, R6, 16
	CHAR STR R2, R10, 17
	CHAR STR R2, R13, 18
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 8
	ADD R12, R3, R3
	INT LOD R3, R3, 0
	INT STR R2, R3, 12
	LDI R4, 24
	RSH R3, R4, R3
	LDI R4, 127
	AND R3, R4, R3
	LDI R4, 1
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB16_15)
	SLT ADI R15, %lo(.LBB16_15)
	BRH NE, R15
; %bb.35:                               ;   in Loop: Header=BB16_12 Depth=2
	INT LOD R7, R3, 0
	LDI R4, 0
	H LDI R4, 1
	SLT ADI R4, -1
	ADD R3, R4, R3
	LDI R4, 0
	H LDI R4, 65535
	SLT ADI R4, 0
	AND R3, R4, R3
	INT STR R7, R3, 0
	ADD R3, R11, R3
	INT STR R2, R3, 0
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 16
	ADD R12, R1, R9
	INT LOD R14, R2, -20
	INT LOD R2, R1, 0
	INT LOD R9, R3, 0
	LDI R4, 0
	H LDI R4, 65280
	SLT ADI R4, 0
	AND R3, R4, R5
	LDI R3, 255
	AND R1, R3, R3
	LDI R4, 16
	LSH R3, R4, R4
	NOR R5, R4, R4
	NOR R4, R4, R4
	NOR R4, R6, R4
	LDI R5, 8
	LSH R3, R5, R11
	NOR R4, R4, R3
	NOR R3, R11, R3
	NOR R3, R3, R3
	INT STR R9, R3, 0
	INT LOD R2, R3, 0
	ADI R3, 1
	INT STR R2, R3, 0
	SLT ADD R7, R0, R3
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	INT LOD R14, R7, -8
	LDI R1, 0
	H LDI R1, mapa
	SLT ADI R1, mapa
	INT LOD R1, R2, 0
	ADD R2, R8, R1
	INT LOD R7, R3, 0
	INT LOD R1, R4, 0
	LDI R5, 0
	H LDI R5, 16384
	SLT ADI R5, 0
	ADD R4, R5, R4
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB16_37)
	SLT ADI R15, %lo(.LBB16_37)
	BRH NC, R15
; %bb.36:                               ;   in Loop: Header=BB16_12 Depth=2
	LDI R4, 0
	H LDI R4, 1
	SLT ADI R4, -1
	ADD R3, R4, R3
	LDI R4, 0
	H LDI R4, 65535
	SLT ADI R4, 0
	AND R3, R4, R3
	INT STR R7, R3, 0
.LBB16_37:                              ;   in Loop: Header=BB16_12 Depth=2
	INT LOD R9, R3, 0
	LDI R4, 0
	H LDI R4, 65280
	SLT ADI R4, 255
	AND R3, R4, R3
	INT LOD R14, R4, -20
	INT LOD R4, R4, 0
	LDI R5, 16
	LSH R4, R5, R4
	LDI R5, 0
	H LDI R5, 255
	SLT ADI R5, 0
	ADD R4, R5, R4
	AND R4, R5, R4
	NOR R3, R4, R3
	NOR R3, R3, R3
	NOR R3, R11, R3
	NOR R3, R3, R3
	INT STR R9, R3, 0
	INT LOD R7, R3, 0
	LDI R8, 0
	H LDI R8, 49152
	SLT ADI R8, 0
	ADD R3, R8, R5
	INT STR R1, R5, 4
	INT LOD R1, R4, 0
	SUB R5, R4, R4
	INT STR R1, R4, 8
	INT LOD R1, R6, 0
	LDI R11, 0
	SLT ADD R11, R0, R4
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB16_39)
	SLT ADI R15, %lo(.LBB16_39)
	BRH NC, R15
; %bb.38:                               ;   in Loop: Header=BB16_12 Depth=2
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 4
	ADD R12, R4, R4
	INT LOD R1, R1, 0
	LDI R5, 3
	INT STR R4, R5, 0
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, -1
	ADD R3, R4, R3
	LDI R4, 0
	H LDI R4, 65535
	SLT ADI R4, 0
	AND R3, R4, R3
	LDI R4, 16
	RSH R1, R4, R1
	NOR R1, R3, R1
	NOR R1, R1, R4
	H LDI R15, %hi(.LBB16_39)
	SLT ADI R15, %lo(.LBB16_39)
	JMP R15
.LBB16_15:                              ;   in Loop: Header=BB16_2 Depth=1
	LDI R5, 0
	H LDI R5, 57344
	SLT ADI R5, 0
	LDI R8, 0
	H LDI R8, 49152
	SLT ADI R8, 0
	LDI R4, 0
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB16_40)
	SLT ADI R15, %lo(.LBB16_40)
	BRH NE, R15
.LBB16_16:
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 16
	ADD R12, R3, R6
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -1
	INT STR R6, R3, 0
	INT LOD R6, R4, 0
	LDI R9, 0
	SUB R4, R9, R0
	H LDI R15, %hi(.LBB16_20)
	SLT ADI R15, %lo(.LBB16_20)
	BRH EQ, R15
; %bb.17:
	LDI R5, 4096
	INT LOD R7, R7, 0
	ADD R7, R8, R7
	INT STR R6, R7, 0
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB16_19)
	SLT ADI R15, %lo(.LBB16_19)
	BRH NC, R15
; %bb.18:
	ADI R4, 4095
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -4096
	AND R4, R5, R5
.LBB16_19:
	INT LOD R14, R7, -8
	INT LOD R7, R4, 0
	ADD R4, R5, R4
	INT STR R7, R4, 0
.LBB16_20:
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 20
	ADD R12, R4, R4
	INT STR R4, R3, 0
	INT LOD R4, R3, 0
	SUB R3, R9, R0
	H LDI R15, %hi(.LBB16_24)
	SLT ADI R15, %lo(.LBB16_24)
	BRH EQ, R15
; %bb.21:
	INT LOD R7, R5, 0
	LDI R6, 0
	H LDI R6, 49152
	SLT ADI R6, 0
	ADD R5, R6, R5
	INT STR R4, R5, 0
	LDI R4, 4096
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB16_23)
	SLT ADI R15, %lo(.LBB16_23)
	BRH NC, R15
; %bb.22:
	ADI R3, 4095
	LDI R4, 0
	H LDI R4, 0
	SLT ADI R4, -4096
	AND R3, R4, R4
.LBB16_23:
	INT LOD R7, R3, 0
	ADD R3, R4, R3
	INT STR R7, R3, 0
.LBB16_24:
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 24
	ADD R12, R3, R5
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -1
	INT STR R5, R3, 0
	INT LOD R5, R4, 0
	SUB R4, R9, R0
	H LDI R15, %hi(.LBB16_28)
	SLT ADI R15, %lo(.LBB16_28)
	BRH EQ, R15
; %bb.25:
	INT LOD R7, R6, 0
	LDI R7, 0
	H LDI R7, 49152
	SLT ADI R7, 0
	ADD R6, R7, R6
	INT STR R5, R6, 0
	LDI R5, 4096
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB16_27)
	SLT ADI R15, %lo(.LBB16_27)
	BRH NC, R15
; %bb.26:
	ADI R4, 4095
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -4096
	AND R4, R5, R5
.LBB16_27:
	INT LOD R14, R7, -8
	INT LOD R7, R4, 0
	ADD R4, R5, R4
	INT STR R7, R4, 0
.LBB16_28:
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 28
	ADD R12, R4, R4
	INT STR R4, R3, 0
	INT LOD R4, R3, 0
	SUB R3, R9, R0
	H LDI R15, %hi(.LBB16_29)
	SLT ADI R15, %lo(.LBB16_29)
	BRH EQ, R15
; %bb.30:
	INT LOD R7, R5, 0
	LDI R6, 0
	H LDI R6, 49152
	SLT ADI R6, 0
	ADD R5, R6, R5
	INT STR R4, R5, 0
	LDI R4, 4097
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB16_31)
	SLT ADI R15, %lo(.LBB16_31)
	BRH NC, R15
; %bb.32:
	INT LOD R7, R3, 0
	ADI R3, 4096
	H LDI R15, %hi(.LBB16_33)
	SLT ADI R15, %lo(.LBB16_33)
	JMP R15
.LBB16_29:
	INT LOD R7, R3, 0
	H LDI R15, %hi(.LBB16_34)
	SLT ADI R15, %lo(.LBB16_34)
	JMP R15
.LBB16_31:
	ADI R3, 4095
	LDI R4, 0
	H LDI R4, 0
	SLT ADI R4, -4096
	AND R3, R4, R3
	INT LOD R7, R4, 0
	ADD R4, R3, R3
.LBB16_33:
	INT STR R7, R3, 0
.LBB16_34:
	INT LOD R2, R4, 0
	SUB R3, R4, R3
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, 0
	ADD R3, R4, R3
	INT STR R2, R3, 8
	INT LOD R7, R3, 0
	ADD R3, R4, R3
	INT STR R2, R3, 4
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
.LBB16_41:
	INT LOD R14, R13, -44
	INT LOD R14, R12, -40
	INT LOD R14, R11, -36
	INT LOD R14, R10, -32
	INT LOD R14, R9, -28
	INT LOD R14, R8, -24
	SLT ADI R14, -48
	RET
.Lfunc_end16:
	.size	bus_Enumeration, .Lfunc_end16-bus_Enumeration
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
	H LDI R15, %hi(.LBB17_2)
	SLT ADI R15, %lo(.LBB17_2)
	BRH NE, R15
; %bb.1:
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT STR R1, R10, 0
	SLT ADD R10, R0, R1
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
.LBB17_2:
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.Lfunc_end17:
	.size	PCIe_Bus_Enumeration, .Lfunc_end17-PCIe_Bus_Enumeration
                                        ; -- End function
	.globl	searchFirst                     ; -- Begin function searchFirst
	.type	searchFirst,@function
searchFirst:                            ; @searchFirst
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R1, R0, R2
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R3, 0
	LDI R1, 0
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB18_4)
	SLT ADI R15, %lo(.LBB18_4)
	BRH EQ, R15
; %bb.1:
	LDI R4, 0
	H LDI R4, mapa
	SLT ADI R4, mapa
	INT LOD R4, R4, 0
	ADI R4, 12
	LDI R5, 0
	H LDI R5, 256
	SLT ADI R5, -1
.LBB18_2:                               ; =>This Inner Loop Header: Depth=1
	INT LOD R4, R6, 0
	AND R6, R5, R6
	SUB R6, R2, R0
	H LDI R15, %hi(.LBB18_5)
	SLT ADI R15, %lo(.LBB18_5)
	BRH EQ, R15
; %bb.3:                                ;   in Loop: Header=BB18_2 Depth=1
	ADI R4, 20
	ADI R1, 1
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB18_2)
	SLT ADI R15, %lo(.LBB18_2)
	BRH NE, R15
.LBB18_4:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
.LBB18_5:
	SLT ADI R14, -4
	RET
.Lfunc_end18:
	.size	searchFirst, .Lfunc_end18-searchFirst
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
	SLT ADD R1, R0, R8
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R4, 0
	INT LOD R4, R7, 0
	LDI R1, 0
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB19_7)
	SLT ADI R15, %lo(.LBB19_7)
	BRH EQ, R15
; %bb.1:
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
	SLT ADD R1, R0, R13
	H LDI R15, %hi(.LBB19_2)
	SLT ADI R15, %lo(.LBB19_2)
	JMP R15
.LBB19_6:                               ;   in Loop: Header=BB19_2 Depth=1
	ADI R5, 20
	ADI R13, 1
	SUB R13, R7, R0
	H LDI R15, %hi(.LBB19_7)
	SLT ADI R15, %lo(.LBB19_7)
	BRH NC, R15
.LBB19_2:                               ; =>This Inner Loop Header: Depth=1
	INT LOD R5, R3, -6
	AND R3, R6, R3
	SUB R3, R8, R0
	H LDI R15, %hi(.LBB19_6)
	SLT ADI R15, %lo(.LBB19_6)
	BRH NE, R15
; %bb.3:                                ;   in Loop: Header=BB19_2 Depth=1
	CHAR LOD R5, R3, -2
	LDI R7, 20
	LSH R3, R7, R3
	CHAR LOD R5, R7, -1
	LDI R9, 15
	LSH R7, R9, R7
	NOR R3, R7, R3
	CHAR LOD R5, R7, 0
	LDI R9, 12
	LSH R7, R9, R7
	NOR R3, R3, R3
	NOR R3, R7, R3
	NOR R3, R3, R3
	NOR R3, R10, R3
	LSH R1, R11, R7
	ADD R2, R7, R7
	NOR R3, R3, R3
	INT STR R7, R3, 0
	SLT ADD R1, R0, R3
	ADI R3, 1
	SUB R12, R1, R0
	H LDI R15, %hi(.LBB19_4)
	SLT ADI R15, %lo(.LBB19_4)
	BRH C, R15
; %bb.5:                                ;   in Loop: Header=BB19_2 Depth=1
	INT LOD R4, R7, 0
	SLT ADD R3, R0, R1
	H LDI R15, %hi(.LBB19_6)
	SLT ADI R15, %lo(.LBB19_6)
	JMP R15
.LBB19_4:
	SLT ADD R3, R0, R1
.LBB19_7:
	INT LOD R14, R13, -24
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -28
	RET
.Lfunc_end19:
	.size	search, .Lfunc_end19-search
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
	H LDI R15, %hi(.LBB20_2)
	SLT ADI R15, %lo(.LBB20_2)
	BRH EQ, R15
; %bb.1:
	LDI R4, 4
	NOR R2, R4, R4
	NOR R4, R4, R4
	;APP
	CYR R4, SR8
	;NO_APP
.LBB20_2:
	SUB R8, R3, R0
	H LDI R15, %hi(.LBB20_8)
	SLT ADI R15, %lo(.LBB20_8)
	BRH EQ, R15
; %bb.3:
	LDI R1, 127
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB20_4)
	SLT ADI R15, %lo(.LBB20_4)
	BRH C, R15
; %bb.5:
	LDI R1, 2
	LSH R8, R1, R1
	LDI R4, 0
	H LDI R4, irq_table
	SLT ADI R4, irq_table
	INT LOD R4, R4, 0
	ADD R4, R1, R1
	INT LOD R1, R4, 0
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB20_6)
	SLT ADI R15, %lo(.LBB20_6)
	BRH EQ, R15
; %bb.13:
	SLT ADD R2, R0, R1
	SLT ADD R9, R0, R2
	SLT ADD R8, R0, R3
	CAL R4
	H LDI R15, %hi(.LBB20_9)
	SLT ADI R15, %lo(.LBB20_9)
	JMP R15
.LBB20_8:
	SLT ADD R9, R0, R3
	H LDI R15, %hi(syscallsHandler)
	SLT ADI R15, %lo(syscallsHandler)
	CAL R15
.LBB20_9:
	SLT ADD R1, R0, R9
	H LDI R15, %hi(.LBB20_10)
	SLT ADI R15, %lo(.LBB20_10)
	JMP R15
.LBB20_4:
	LDI R1, 0
	H LDI R1, .L.str.1.23
	SLT ADI R1, .L.str.1.23
	H LDI R15, %hi(.LBB20_7)
	SLT ADI R15, %lo(.LBB20_7)
	JMP R15
.LBB20_6:
	LDI R1, 0
	H LDI R1, .L.str.22
	SLT ADI R1, .L.str.22
.LBB20_7:
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
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	;APP
	HLT
	;NO_APP
.LBB20_10:
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
	H LDI R15, %hi(.LBB20_12)
	SLT ADI R15, %lo(.LBB20_12)
	BRH C, R15
; %bb.11:
	LDI R1, 0
	H LDI R1, Registros
	SLT ADI R1, Registros
	INT LOD R1, R1, 0
	LDI R2, 1
	INT STR R1, R2, 16
.LBB20_12:
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -24
	RET
.Lfunc_end20:
	.size	mainHandler, .Lfunc_end20-mainHandler
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
.Lfunc_end21:
	.size	entryHandler, .Lfunc_end21-entryHandler
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
	H LDI R15, %hi(.LBB22_5)
	SLT ADI R15, %lo(.LBB22_5)
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
	H LDI R15, %hi(.LBB22_4)
	SLT ADI R15, %lo(.LBB22_4)
	BRH C, R15
; %bb.2:
	LDI R5, 0
	SUB R3, R5, R0
	H LDI R15, %hi(.LBB22_4)
	SLT ADI R15, %lo(.LBB22_4)
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
.LBB22_4:
	LDI R2, 13
	RSH R4, R2, R2
	LDI R3, 112
	AND R2, R3, R2
	LDI R3, 1
	NOR R2, R3, R2
	NOR R2, R2, R2
	INT STR R1, R2, 0
.LBB22_5:
	SLT ADI R14, -4
	RET
.Lfunc_end22:
	.size	initMSI, .Lfunc_end22-initMSI
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
	H LDI R15, %hi(.LBB23_2)
	SLT ADI R15, %lo(.LBB23_2)
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
.LBB23_2:
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.Lfunc_end23:
	.size	initLAPIC, .Lfunc_end23-initLAPIC
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
	H LDI R1, .L.str.30
	SLT ADI R1, .L.str.30
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
.Lfunc_end24:
	.size	pageFault, .Lfunc_end24-pageFault
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
	H LDI R1, .L.str.1.33
	SLT ADI R1, .L.str.1.33
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
	.size	alignamentFault, .Lfunc_end25-alignamentFault
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
	H LDI R1, .L.str.2.36
	SLT ADI R1, .L.str.2.36
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
	.size	generalProtectionFault, .Lfunc_end26-generalProtectionFault
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
	H LDI R1, .L.str.3.39
	SLT ADI R1, .L.str.3.39
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
	.size	invalidOpCode, .Lfunc_end27-invalidOpCode
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
	H LDI R1, .L.str.4.42
	SLT ADI R1, .L.str.4.42
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
	.size	doubleFault, .Lfunc_end28-doubleFault
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
.Lfunc_end29:
	.size	syscallsHandler, .Lfunc_end29-syscallsHandler
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
	H LDI R15, %hi(.LBB30_2)
	SLT ADI R15, %lo(.LBB30_2)
	BRH EQ, R15
; %bb.1:
	INT LOD R2, R9, 0
	H LDI R15, %hi(.LBB30_5)
	SLT ADI R15, %lo(.LBB30_5)
	JMP R15
.LBB30_2:
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
	H LDI R15, %hi(.LBB30_56)
	SLT ADI R15, %lo(.LBB30_56)
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
	H LDI R15, %hi(.LBB30_56)
	SLT ADI R15, %lo(.LBB30_56)
	BRH NE, R15
; %bb.4:
	LDI R1, 0
	H LDI R1, current_pool_index
	SLT ADI R1, current_pool_index
	INT LOD R1, R2, 0
	INT STR R2, R9, 0
	SLT ADD R12, R0, R1
.LBB30_5:
	SLT ADD R9, R0, R5
	ADI R5, 1
	LDI R4, 31
	LDI R3, 1
	SLT ADD R5, R0, R6
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB30_7)
	SLT ADI R15, %lo(.LBB30_7)
	BRH EQ, R15
; %bb.6:
	RSH R5, R4, R6
	LSH R6, R3, R7
	SUB R6, R7, R6
.LBB30_7:
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
	H LDI R15, %hi(.LBB30_42)
	SLT ADI R15, %lo(.LBB30_42)
	BRH EQ, R15
; %bb.8:
	LDI R6, 2
	SUB R8, R6, R0
	H LDI R15, %hi(.LBB30_36)
	SLT ADI R15, %lo(.LBB30_36)
	BRH EQ, R15
; %bb.9:
	LDI R6, 3
	SUB R8, R6, R0
	H LDI R15, %hi(.LBB30_10)
	SLT ADI R15, %lo(.LBB30_10)
	BRH NE, R15
; %bb.11:
	LDI R3, 8
	RSH R1, R3, R3
	LDI R6, 15
	AND R3, R6, R3
	LDI R4, 48
	LDI R7, 10
	SUB R3, R7, R0
	H LDI R15, %hi(.LBB30_12)
	SLT ADI R15, %lo(.LBB30_12)
	BRH C, R15
; %bb.13:
	ADI R3, 55
	H LDI R15, %hi(.LBB30_14)
	SLT ADI R15, %lo(.LBB30_14)
	JMP R15
.LBB30_36:
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB30_57)
	SLT ADI R15, %lo(.LBB30_57)
	BRH EQ, R15
; %bb.37:
	LDI R3, 15
	LDI R4, 48
	LDI R6, 10
	LDI R7, 4
	SLT ADD R5, R0, R2
	H LDI R15, %hi(.LBB30_38)
	SLT ADI R15, %lo(.LBB30_38)
	JMP R15
.LBB30_40:                              ;   in Loop: Header=BB30_38 Depth=1
	ADI R5, 55
.LBB30_41:                              ;   in Loop: Header=BB30_38 Depth=1
	CHAR STR R2, R5, -1
	RSH R1, R7, R1
	ADI R2, -1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB30_55)
	SLT ADI R15, %lo(.LBB30_55)
	BRH EQ, R15
.LBB30_38:                              ; =>This Inner Loop Header: Depth=1
	AND R1, R3, R5
	SUB R5, R6, R0
	H LDI R15, %hi(.LBB30_40)
	SLT ADI R15, %lo(.LBB30_40)
	BRH NC, R15
; %bb.39:                               ;   in Loop: Header=BB30_38 Depth=1
	NOR R5, R4, R5
	NOR R5, R5, R5
	H LDI R15, %hi(.LBB30_41)
	SLT ADI R15, %lo(.LBB30_41)
	JMP R15
.LBB30_42:
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -1
	SLT ADD R3, R0, R6
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB30_44)
	SLT ADI R15, %lo(.LBB30_44)
	BRH N, R15
; %bb.43:
	SLT ADD R10, R0, R6
.LBB30_44:
	SLT ADD R1, R0, R7
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB30_46)
	SLT ADI R15, %lo(.LBB30_46)
	BRH EQ, R15
; %bb.45:
	RSH R1, R4, R7
	LSH R7, R3, R8
	SUB R7, R8, R7
.LBB30_46:
	XOR R1, R7, R1
	SUB R1, R7, R1
	H LDI R15, %hi(.LBB30_47)
	SLT ADI R15, %lo(.LBB30_47)
	JMP R15
.LBB30_10:
	SLT ADD R3, R0, R6
.LBB30_47:
	INT STR R14, R6, -4
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB30_58)
	SLT ADI R15, %lo(.LBB30_58)
	BRH EQ, R15
; %bb.48:
	LDI R2, 0
	H LDI R2, 52429
	SLT ADI R2, -13107
	LDI R7, 3
	LDI R8, 10
	LDI R9, 48
	LDI R11, 9
	H LDI R15, %hi(.LBB30_49)
	SLT ADI R15, %lo(.LBB30_49)
	JMP R15
.LBB30_51:                              ;   in Loop: Header=BB30_49 Depth=1
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
	H LDI R15, %hi(.LBB30_52)
	SLT ADI R15, %lo(.LBB30_52)
	BRH NC, R15
.LBB30_49:                              ; =>This Inner Loop Header: Depth=1
	SLT ADD R1, R0, R12
	SUB R4, R10, R0
	H LDI R15, %hi(.LBB30_51)
	SLT ADI R15, %lo(.LBB30_51)
	BRH EQ, R15
; %bb.50:                               ;   in Loop: Header=BB30_49 Depth=1
	RSH R12, R4, R1
	LSH R1, R3, R13
	SUB R1, R13, R1
	H LDI R15, %hi(.LBB30_51)
	SLT ADI R15, %lo(.LBB30_51)
	JMP R15
.LBB30_12:
	NOR R3, R4, R3
	NOR R3, R3, R3
.LBB30_14:
	LDI R5, 4
	RSH R1, R5, R5
	AND R5, R6, R5
	SUB R5, R7, R0
	H LDI R15, %hi(.LBB30_15)
	SLT ADI R15, %lo(.LBB30_15)
	BRH C, R15
; %bb.16:
	ADI R5, 55
	AND R1, R6, R8
	SUB R8, R7, R0
	H LDI R15, %hi(.LBB30_19)
	SLT ADI R15, %lo(.LBB30_19)
	BRH NC, R15
.LBB30_18:
	NOR R8, R4, R8
	NOR R8, R8, R8
	H LDI R15, %hi(.LBB30_20)
	SLT ADI R15, %lo(.LBB30_20)
	JMP R15
.LBB30_15:
	NOR R5, R4, R5
	NOR R5, R5, R5
	AND R1, R6, R8
	SUB R8, R7, R0
	H LDI R15, %hi(.LBB30_18)
	SLT ADI R15, %lo(.LBB30_18)
	BRH C, R15
.LBB30_19:
	ADI R8, 55
.LBB30_20:
	LDI R9, 24
	RSH R1, R9, R9
	AND R9, R6, R9
	SUB R9, R7, R0
	H LDI R15, %hi(.LBB30_21)
	SLT ADI R15, %lo(.LBB30_21)
	BRH C, R15
; %bb.22:
	ADI R9, 55
	H LDI R15, %hi(.LBB30_23)
	SLT ADI R15, %lo(.LBB30_23)
	JMP R15
.LBB30_21:
	NOR R9, R4, R9
	NOR R9, R9, R9
.LBB30_23:
	LDI R10, 20
	RSH R1, R10, R10
	AND R10, R6, R10
	SUB R10, R7, R0
	H LDI R15, %hi(.LBB30_24)
	SLT ADI R15, %lo(.LBB30_24)
	BRH C, R15
; %bb.25:
	ADI R10, 55
	H LDI R15, %hi(.LBB30_26)
	SLT ADI R15, %lo(.LBB30_26)
	JMP R15
.LBB30_24:
	NOR R10, R4, R10
	NOR R10, R10, R10
.LBB30_26:
	LDI R11, 16
	RSH R1, R11, R11
	AND R11, R6, R11
	SUB R11, R7, R0
	H LDI R15, %hi(.LBB30_27)
	SLT ADI R15, %lo(.LBB30_27)
	BRH C, R15
; %bb.28:
	ADI R11, 55
	H LDI R15, %hi(.LBB30_29)
	SLT ADI R15, %lo(.LBB30_29)
	JMP R15
.LBB30_27:
	NOR R11, R4, R11
	NOR R11, R11, R11
.LBB30_29:
	LDI R12, 12
	RSH R1, R12, R12
	AND R12, R6, R6
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB30_30)
	SLT ADI R15, %lo(.LBB30_30)
	BRH C, R15
; %bb.31:
	ADI R6, 55
	H LDI R15, %hi(.LBB30_32)
	SLT ADI R15, %lo(.LBB30_32)
	JMP R15
.LBB30_30:
	NOR R6, R4, R6
	NOR R6, R6, R6
.LBB30_32:
	LDI R7, 28
	RSH R1, R7, R7
	LDI R12, 0
	H LDI R12, 40960
	SLT ADI R12, 0
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB30_33)
	SLT ADI R15, %lo(.LBB30_33)
	BRH C, R15
; %bb.34:
	ADI R7, 55
	H LDI R15, %hi(.LBB30_35)
	SLT ADI R15, %lo(.LBB30_35)
	JMP R15
.LBB30_33:
	NOR R7, R4, R1
	NOR R1, R1, R7
.LBB30_35:
	CHAR STR R2, R8, 30
	CHAR STR R2, R7, 23
	CHAR STR R2, R5, 29
	CHAR STR R2, R3, 28
	CHAR STR R2, R6, 27
	CHAR STR R2, R11, 26
	CHAR STR R2, R10, 25
	CHAR STR R2, R9, 24
	ADI R2, 23
	H LDI R15, %hi(.LBB30_55)
	SLT ADI R15, %lo(.LBB30_55)
	JMP R15
.LBB30_58:
	LDI R1, 48
	CHAR STR R2, R1, 30
	ADI R2, 30
	SLT ADD R2, R0, R5
.LBB30_52:
	INT LOD R14, R1, -4
	AND R1, R3, R1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB30_54)
	SLT ADI R15, %lo(.LBB30_54)
	BRH NE, R15
; %bb.53:
	LDI R1, 45
	CHAR STR R5, R1, -1
	ADI R5, -1
.LBB30_54:
	SLT ADD R5, R0, R2
.LBB30_55:
	SLT ADD R2, R0, R1
	INT LOD R14, R13, -28
	INT LOD R14, R12, -24
	INT LOD R14, R11, -20
	INT LOD R14, R10, -16
	INT LOD R14, R9, -12
	INT LOD R14, R8, -8
	SLT ADI R14, -32
	RET
.LBB30_57:
	LDI R1, 48
	CHAR STR R2, R1, 30
	ADI R2, 30
	H LDI R15, %hi(.LBB30_55)
	SLT ADI R15, %lo(.LBB30_55)
	JMP R15
.LBB30_56:
	;APP
	CYR R11, SR8
	;NO_APP
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.Lfunc_end30:
	.size	ToAscii, .Lfunc_end30-ToAscii
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
	H LDI R15, %hi(.LBB31_1)
	SLT ADI R15, %lo(.LBB31_1)
	BRH EQ, R15
; %bb.2:                                ; %.preheader
	LDI R5, 31
	LDI R6, 1
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -1
	SLT ADD R4, R0, R8
	SLT ADD R4, R0, R3
	H LDI R15, %hi(.LBB31_3)
	SLT ADI R15, %lo(.LBB31_3)
	JMP R15
.LBB31_7:                               ;   in Loop: Header=BB31_3 Depth=1
	SUB R8, R10, R8
	NOR R9, R3, R3
	NOR R3, R3, R3
	ADI R5, -1
	SUB R5, R7, R0
	H LDI R15, %hi(.LBB31_8)
	SLT ADI R15, %lo(.LBB31_8)
	BRH EQ, R15
.LBB31_3:                               ; =>This Inner Loop Header: Depth=1
	LSH R8, R6, R8
	RSH R1, R5, R9
	AND R9, R6, R9
	NOR R9, R8, R8
	NOR R8, R8, R8
	SLT ADD R4, R0, R9
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB31_5)
	SLT ADI R15, %lo(.LBB31_5)
	BRH C, R15
; %bb.4:                                ;   in Loop: Header=BB31_3 Depth=1
	LSH R6, R5, R9
.LBB31_5:                               ;   in Loop: Header=BB31_3 Depth=1
	SLT ADD R4, R0, R10
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB31_7)
	SLT ADI R15, %lo(.LBB31_7)
	BRH C, R15
; %bb.6:                                ;   in Loop: Header=BB31_3 Depth=1
	SLT ADD R2, R0, R10
	H LDI R15, %hi(.LBB31_7)
	SLT ADI R15, %lo(.LBB31_7)
	JMP R15
.LBB31_1:
	SLT ADD R4, R0, R3
.LBB31_8:
	SLT ADD R3, R0, R1
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -16
	RET
.Lfunc_end31:
	.size	__udivsi3, .Lfunc_end31-__udivsi3
                                        ; -- End function
	.globl	__umodsi3                       ; -- Begin function __umodsi3
	.type	__umodsi3,@function
__umodsi3:                              ; @__umodsi3
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R1, R0, R3
	LDI R1, 0
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB32_66)
	SLT ADI R15, %lo(.LBB32_66)
	BRH EQ, R15
; %bb.1:
	LDI R4, 31
	RSH R3, R4, R4
	SLT ADD R1, R0, R5
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB32_3)
	SLT ADI R15, %lo(.LBB32_3)
	BRH C, R15
; %bb.2:
	SLT ADD R2, R0, R5
.LBB32_3:
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
	H LDI R15, %hi(.LBB32_5)
	SLT ADI R15, %lo(.LBB32_5)
	BRH C, R15
; %bb.4:
	SLT ADD R2, R0, R6
.LBB32_5:
	SUB R5, R6, R5
	LDI R6, 29
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_7)
	SLT ADI R15, %lo(.LBB32_7)
	BRH C, R15
; %bb.6:
	SLT ADD R2, R0, R6
.LBB32_7:
	SUB R5, R6, R5
	LDI R6, 28
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_9)
	SLT ADI R15, %lo(.LBB32_9)
	BRH C, R15
; %bb.8:
	SLT ADD R2, R0, R6
.LBB32_9:
	SUB R5, R6, R5
	LDI R6, 27
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_11)
	SLT ADI R15, %lo(.LBB32_11)
	BRH C, R15
; %bb.10:
	SLT ADD R2, R0, R6
.LBB32_11:
	SUB R5, R6, R5
	LDI R6, 26
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_13)
	SLT ADI R15, %lo(.LBB32_13)
	BRH C, R15
; %bb.12:
	SLT ADD R2, R0, R6
.LBB32_13:
	SUB R5, R6, R5
	LDI R6, 25
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_15)
	SLT ADI R15, %lo(.LBB32_15)
	BRH C, R15
; %bb.14:
	SLT ADD R2, R0, R6
.LBB32_15:
	SUB R5, R6, R5
	LDI R6, 24
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_17)
	SLT ADI R15, %lo(.LBB32_17)
	BRH C, R15
; %bb.16:
	SLT ADD R2, R0, R6
.LBB32_17:
	SUB R5, R6, R5
	LDI R6, 23
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_19)
	SLT ADI R15, %lo(.LBB32_19)
	BRH C, R15
; %bb.18:
	SLT ADD R2, R0, R6
.LBB32_19:
	SUB R5, R6, R5
	LDI R6, 22
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_21)
	SLT ADI R15, %lo(.LBB32_21)
	BRH C, R15
; %bb.20:
	SLT ADD R2, R0, R6
.LBB32_21:
	SUB R5, R6, R5
	LDI R6, 21
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_23)
	SLT ADI R15, %lo(.LBB32_23)
	BRH C, R15
; %bb.22:
	SLT ADD R2, R0, R6
.LBB32_23:
	SUB R5, R6, R5
	LDI R6, 20
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_25)
	SLT ADI R15, %lo(.LBB32_25)
	BRH C, R15
; %bb.24:
	SLT ADD R2, R0, R6
.LBB32_25:
	SUB R5, R6, R5
	LDI R6, 19
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_27)
	SLT ADI R15, %lo(.LBB32_27)
	BRH C, R15
; %bb.26:
	SLT ADD R2, R0, R6
.LBB32_27:
	SUB R5, R6, R5
	LDI R6, 18
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_29)
	SLT ADI R15, %lo(.LBB32_29)
	BRH C, R15
; %bb.28:
	SLT ADD R2, R0, R6
.LBB32_29:
	SUB R5, R6, R5
	LDI R6, 17
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_31)
	SLT ADI R15, %lo(.LBB32_31)
	BRH C, R15
; %bb.30:
	SLT ADD R2, R0, R6
.LBB32_31:
	SUB R5, R6, R5
	LDI R6, 16
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_33)
	SLT ADI R15, %lo(.LBB32_33)
	BRH C, R15
; %bb.32:
	SLT ADD R2, R0, R6
.LBB32_33:
	SUB R5, R6, R5
	LDI R6, 15
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_35)
	SLT ADI R15, %lo(.LBB32_35)
	BRH C, R15
; %bb.34:
	SLT ADD R2, R0, R6
.LBB32_35:
	SUB R5, R6, R5
	LDI R6, 14
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_37)
	SLT ADI R15, %lo(.LBB32_37)
	BRH C, R15
; %bb.36:
	SLT ADD R2, R0, R6
.LBB32_37:
	SUB R5, R6, R5
	LDI R6, 13
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_39)
	SLT ADI R15, %lo(.LBB32_39)
	BRH C, R15
; %bb.38:
	SLT ADD R2, R0, R6
.LBB32_39:
	SUB R5, R6, R5
	LDI R6, 12
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_41)
	SLT ADI R15, %lo(.LBB32_41)
	BRH C, R15
; %bb.40:
	SLT ADD R2, R0, R6
.LBB32_41:
	SUB R5, R6, R5
	LDI R6, 11
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_43)
	SLT ADI R15, %lo(.LBB32_43)
	BRH C, R15
; %bb.42:
	SLT ADD R2, R0, R6
.LBB32_43:
	SUB R5, R6, R5
	LDI R6, 10
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_45)
	SLT ADI R15, %lo(.LBB32_45)
	BRH C, R15
; %bb.44:
	SLT ADD R2, R0, R6
.LBB32_45:
	SUB R5, R6, R5
	LDI R6, 9
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_47)
	SLT ADI R15, %lo(.LBB32_47)
	BRH C, R15
; %bb.46:
	SLT ADD R2, R0, R6
.LBB32_47:
	SUB R5, R6, R5
	LDI R6, 8
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_49)
	SLT ADI R15, %lo(.LBB32_49)
	BRH C, R15
; %bb.48:
	SLT ADD R2, R0, R6
.LBB32_49:
	SUB R5, R6, R5
	LDI R6, 7
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_51)
	SLT ADI R15, %lo(.LBB32_51)
	BRH C, R15
; %bb.50:
	SLT ADD R2, R0, R6
.LBB32_51:
	SUB R5, R6, R5
	LDI R6, 6
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_53)
	SLT ADI R15, %lo(.LBB32_53)
	BRH C, R15
; %bb.52:
	SLT ADD R2, R0, R6
.LBB32_53:
	SUB R5, R6, R5
	LDI R6, 5
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_55)
	SLT ADI R15, %lo(.LBB32_55)
	BRH C, R15
; %bb.54:
	SLT ADD R2, R0, R6
.LBB32_55:
	SUB R5, R6, R5
	LDI R6, 4
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_57)
	SLT ADI R15, %lo(.LBB32_57)
	BRH C, R15
; %bb.56:
	SLT ADD R2, R0, R6
.LBB32_57:
	SUB R5, R6, R5
	LDI R6, 3
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_59)
	SLT ADI R15, %lo(.LBB32_59)
	BRH C, R15
; %bb.58:
	SLT ADD R2, R0, R6
.LBB32_59:
	SUB R5, R6, R5
	LDI R6, 2
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_61)
	SLT ADI R15, %lo(.LBB32_61)
	BRH C, R15
; %bb.60:
	SLT ADD R2, R0, R6
.LBB32_61:
	SUB R5, R6, R5
	RSH R3, R4, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB32_63)
	SLT ADI R15, %lo(.LBB32_63)
	BRH C, R15
; %bb.62:
	SLT ADD R2, R0, R6
.LBB32_63:
	SUB R5, R6, R5
	AND R3, R4, R3
	LSH R5, R4, R4
	NOR R3, R4, R3
	NOR R3, R3, R3
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB32_65)
	SLT ADI R15, %lo(.LBB32_65)
	BRH C, R15
; %bb.64:
	SLT ADD R2, R0, R1
.LBB32_65:
	SUB R3, R1, R1
.LBB32_66:
	SLT ADI R14, -4
	RET
.Lfunc_end32:
	.size	__umodsi3, .Lfunc_end32-__umodsi3
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
	H LDI R15, %hi(.LBB33_1)
	SLT ADI R15, %lo(.LBB33_1)
	BRH EQ, R15
.LBB33_9:                               ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R5, 0
	CHAR LOD R1, R6, 0
	SUB R6, R3, R0
	H LDI R15, %hi(.LBB33_11)
	SLT ADI R15, %lo(.LBB33_11)
	BRH EQ, R15
; %bb.10:                               ;   in Loop: Header=BB33_9 Depth=1
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB33_11)
	SLT ADI R15, %lo(.LBB33_11)
	BRH NE, R15
; %bb.8:                                ;   in Loop: Header=BB33_9 Depth=1
	ADI R2, 1
	ADI R1, 1
	AND R1, R4, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB33_9)
	SLT ADI R15, %lo(.LBB33_9)
	BRH NE, R15
.LBB33_1:
	LDI R5, 4095
	AND R1, R5, R4
	LDI R6, 4092
	SUB R6, R4, R0
	H LDI R15, %hi(.LBB33_13)
	SLT ADI R15, %lo(.LBB33_13)
	BRH C, R15
; %bb.2:
	AND R2, R5, R4
	SUB R6, R4, R0
	H LDI R15, %hi(.LBB33_13)
	SLT ADI R15, %lo(.LBB33_13)
	BRH C, R15
; %bb.3:
	LDI R11, 0
	H LDI R11, 32897
	SLT ADI R11, -32640
	LDI R4, 255
.LBB33_4:                               ; =>This Inner Loop Header: Depth=1
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
	H LDI R15, %hi(.LBB33_6)
	SLT ADI R15, %lo(.LBB33_6)
	BRH NE, R15
; %bb.5:                                ;   in Loop: Header=BB33_4 Depth=1
	SUB R7, R8, R0
	H LDI R15, %hi(.LBB33_28)
	SLT ADI R15, %lo(.LBB33_28)
	BRH EQ, R15
.LBB33_6:                               ;   in Loop: Header=BB33_4 Depth=1
	AND R7, R4, R12
	SUB R12, R3, R0
	H LDI R15, %hi(.LBB33_7)
	SLT ADI R15, %lo(.LBB33_7)
	BRH EQ, R15
; %bb.20:                               ;   in Loop: Header=BB33_4 Depth=1
	AND R8, R4, R9
	AND R7, R4, R10
	SLT ADD R7, R0, R12
	SLT ADD R8, R0, R13
	SUB R10, R9, R0
	H LDI R15, %hi(.LBB33_27)
	SLT ADI R15, %lo(.LBB33_27)
	BRH NE, R15
; %bb.21:                               ;   in Loop: Header=BB33_4 Depth=1
	LDI R9, 8
	RSH R8, R9, R13
	RSH R7, R9, R12
	AND R12, R4, R9
	SUB R9, R3, R0
	H LDI R15, %hi(.LBB33_27)
	SLT ADI R15, %lo(.LBB33_27)
	BRH EQ, R15
; %bb.22:                               ;   in Loop: Header=BB33_4 Depth=1
	AND R13, R4, R9
	AND R12, R4, R10
	SUB R10, R9, R0
	H LDI R15, %hi(.LBB33_27)
	SLT ADI R15, %lo(.LBB33_27)
	BRH NE, R15
; %bb.23:                               ;   in Loop: Header=BB33_4 Depth=1
	LDI R9, 16
	RSH R8, R9, R13
	RSH R7, R9, R12
	AND R12, R4, R9
	SUB R9, R3, R0
	H LDI R15, %hi(.LBB33_27)
	SLT ADI R15, %lo(.LBB33_27)
	BRH EQ, R15
; %bb.24:                               ;   in Loop: Header=BB33_4 Depth=1
	AND R13, R4, R9
	AND R12, R4, R10
	SUB R10, R9, R0
	H LDI R15, %hi(.LBB33_27)
	SLT ADI R15, %lo(.LBB33_27)
	BRH NE, R15
; %bb.25:                               ;   in Loop: Header=BB33_4 Depth=1
	LDI R9, 24
	RSH R8, R9, R13
	RSH R7, R9, R12
	SUB R12, R3, R0
	H LDI R15, %hi(.LBB33_27)
	SLT ADI R15, %lo(.LBB33_27)
	BRH EQ, R15
; %bb.26:                               ;   in Loop: Header=BB33_4 Depth=1
	SUB R12, R13, R0
	H LDI R15, %hi(.LBB33_27)
	SLT ADI R15, %lo(.LBB33_27)
	BRH NE, R15
.LBB33_28:                              ;   in Loop: Header=BB33_4 Depth=1
	ADI R2, 4
	ADI R1, 4
	AND R1, R5, R7
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB33_13)
	SLT ADI R15, %lo(.LBB33_13)
	BRH C, R15
; %bb.29:                               ;   in Loop: Header=BB33_4 Depth=1
	AND R2, R5, R7
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB33_4)
	SLT ADI R15, %lo(.LBB33_4)
	BRH NC, R15
.LBB33_13:
	CHAR LOD R1, R5, 0
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB33_19)
	SLT ADI R15, %lo(.LBB33_19)
	BRH EQ, R15
; %bb.14:                               ; %.preheader
	ADI R1, 1
	LDI R4, 255
.LBB33_15:                              ; =>This Inner Loop Header: Depth=1
	AND R5, R4, R6
	CHAR LOD R2, R7, 0
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB33_16)
	SLT ADI R15, %lo(.LBB33_16)
	BRH NE, R15
; %bb.17:                               ;   in Loop: Header=BB33_15 Depth=1
	ADI R2, 1
	CHAR LOD R1, R5, 0
	ADI R1, 1
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB33_15)
	SLT ADI R15, %lo(.LBB33_15)
	BRH NE, R15
	H LDI R15, %hi(.LBB33_18)
	SLT ADI R15, %lo(.LBB33_18)
	JMP R15
.LBB33_11:
	SUB R6, R5, R1
	H LDI R15, %hi(.LBB33_12)
	SLT ADI R15, %lo(.LBB33_12)
	JMP R15
.LBB33_16:
	SLT ADD R5, R0, R3
.LBB33_18:
	AND R3, R4, R3
.LBB33_19:
	CHAR LOD R2, R1, 0
	SUB R3, R1, R1
	H LDI R15, %hi(.LBB33_12)
	SLT ADI R15, %lo(.LBB33_12)
	JMP R15
.LBB33_7:
	SLT ADD R7, R0, R12
	SLT ADD R8, R0, R13
.LBB33_27:
	AND R13, R4, R1
	AND R12, R4, R2
	SUB R2, R1, R1
.LBB33_12:
	INT LOD R14, R13, -24
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -28
	RET
.Lfunc_end33:
	.size	strcmp, .Lfunc_end33-strcmp
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
	H LDI R15, %hi(.LBB34_1)
	SLT ADI R15, %lo(.LBB34_1)
	BRH EQ, R15
; %bb.8:
	SLT ADD R1, R0, R2
.LBB34_9:                               ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R5, 0
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB34_17)
	SLT ADI R15, %lo(.LBB34_17)
	BRH EQ, R15
; %bb.10:                               ;   in Loop: Header=BB34_9 Depth=1
	ADI R2, 1
	AND R2, R4, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB34_9)
	SLT ADI R15, %lo(.LBB34_9)
	BRH NE, R15
	H LDI R15, %hi(.LBB34_2)
	SLT ADI R15, %lo(.LBB34_2)
	JMP R15
.LBB34_1:
	SLT ADD R1, R0, R2
.LBB34_2:
	LDI R4, 4095
	AND R2, R4, R6
	LDI R5, 4092
	SUB R5, R6, R0
	H LDI R15, %hi(.LBB34_15)
	SLT ADI R15, %lo(.LBB34_15)
	BRH C, R15
; %bb.3:
	LDI R6, 0
	H LDI R6, 257
	SLT ADI R6, 256
	LDI R7, 0
	H LDI R7, 32897
	SLT ADI R7, -32640
.LBB34_4:                               ; =>This Inner Loop Header: Depth=1
	INT LOD R2, R8, 0
	SUB R6, R8, R9
	NOR R9, R8, R9
	NOR R9, R9, R9
	AND R9, R7, R9
	SUB R9, R7, R0
	H LDI R15, %hi(.LBB34_5)
	SLT ADI R15, %lo(.LBB34_5)
	BRH NE, R15
; %bb.14:                               ;   in Loop: Header=BB34_4 Depth=1
	ADI R2, 4
	AND R2, R4, R8
	SUB R5, R8, R0
	H LDI R15, %hi(.LBB34_4)
	SLT ADI R15, %lo(.LBB34_4)
	BRH NC, R15
.LBB34_15:
	ADI R2, -1
.LBB34_16:                              ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R4, 1
	ADI R2, 1
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB34_16)
	SLT ADI R15, %lo(.LBB34_16)
	BRH NE, R15
.LBB34_17:
	SUB R2, R1, R1
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -12
	RET
.LBB34_5:
	LDI R4, 255
	AND R8, R4, R4
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB34_17)
	SLT ADI R15, %lo(.LBB34_17)
	BRH EQ, R15
; %bb.6:
	LDI R4, 0
	H LDI R4, 1
	SLT ADI R4, -256
	AND R8, R4, R4
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB34_7)
	SLT ADI R15, %lo(.LBB34_7)
	BRH EQ, R15
; %bb.11:
	LDI R4, 0
	H LDI R4, 255
	SLT ADI R4, 0
	AND R8, R4, R4
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB34_12)
	SLT ADI R15, %lo(.LBB34_12)
	BRH EQ, R15
; %bb.13:
	ADI R2, 3
	H LDI R15, %hi(.LBB34_17)
	SLT ADI R15, %lo(.LBB34_17)
	JMP R15
.LBB34_7:
	ADI R2, 1
	H LDI R15, %hi(.LBB34_17)
	SLT ADI R15, %lo(.LBB34_17)
	JMP R15
.LBB34_12:
	ADI R2, 2
	H LDI R15, %hi(.LBB34_17)
	SLT ADI R15, %lo(.LBB34_17)
	JMP R15
.Lfunc_end34:
	.size	strlen, .Lfunc_end34-strlen
                                        ; -- End function
	.globl	memcmp                          ; -- Begin function memcmp
	.type	memcmp,@function
memcmp:                                 ; @memcmp
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R1, R0, R4
	LDI R1, 0
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB35_4)
	SLT ADI R15, %lo(.LBB35_4)
	BRH EQ, R15
.LBB35_2:                               ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R5, 0
	CHAR LOD R4, R6, 0
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB35_3)
	SLT ADI R15, %lo(.LBB35_3)
	BRH NE, R15
; %bb.1:                                ;   in Loop: Header=BB35_2 Depth=1
	ADI R4, 1
	ADI R2, 1
	ADI R3, -1
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB35_2)
	SLT ADI R15, %lo(.LBB35_2)
	BRH NE, R15
	H LDI R15, %hi(.LBB35_4)
	SLT ADI R15, %lo(.LBB35_4)
	JMP R15
.LBB35_3:
	SUB R6, R5, R1
.LBB35_4:
	SLT ADI R14, -4
	RET
.Lfunc_end35:
	.size	memcmp, .Lfunc_end35-memcmp
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
	H LDI R15, %hi(.LBB36_30)
	SLT ADI R15, %lo(.LBB36_30)
	BRH EQ, R15
; %bb.1:
	LDI R6, 3
	AND R1, R6, R5
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB36_2)
	SLT ADI R15, %lo(.LBB36_2)
	BRH EQ, R15
; %bb.3:                                ; %.preheader9
	LDI R8, 1
	SLT ADD R1, R0, R5
.LBB36_4:                               ; =>This Inner Loop Header: Depth=1
	SLT ADD R3, R0, R7
	CHAR LOD R2, R3, 0
	CHAR STR R5, R3, 0
	ADI R5, 1
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB36_17)
	SLT ADI R15, %lo(.LBB36_17)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB36_4 Depth=1
	AND R5, R6, R9
	SLT ADD R7, R0, R3
	ADI R3, -1
	ADI R2, 1
	SUB R9, R4, R0
	H LDI R15, %hi(.LBB36_7)
	SLT ADI R15, %lo(.LBB36_7)
	BRH EQ, R15
; %bb.6:                                ;   in Loop: Header=BB36_4 Depth=1
	SUB R7, R8, R0
	H LDI R15, %hi(.LBB36_4)
	SLT ADI R15, %lo(.LBB36_4)
	BRH NE, R15
	H LDI R15, %hi(.LBB36_7)
	SLT ADI R15, %lo(.LBB36_7)
	JMP R15
.LBB36_2:
	SLT ADD R1, R0, R5
.LBB36_7:
	AND R2, R6, R7
	SUB R7, R4, R0
	H LDI R15, %hi(.LBB36_13)
	SLT ADI R15, %lo(.LBB36_13)
	BRH NE, R15
; %bb.8:
	LDI R7, 4
	SUB R3, R7, R0
	H LDI R15, %hi(.LBB36_13)
	SLT ADI R15, %lo(.LBB36_13)
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
.LBB36_10:                              ; =>This Inner Loop Header: Depth=1
	AND R2, R7, R11
	SUB R8, R11, R0
	H LDI R15, %hi(.LBB36_14)
	SLT ADI R15, %lo(.LBB36_14)
	BRH C, R15
; %bb.11:                               ;   in Loop: Header=BB36_10 Depth=1
	INT LOD R2, R11, 0
	SUB R9, R11, R12
	NOR R12, R11, R12
	NOR R12, R12, R12
	AND R12, R10, R12
	SUB R12, R10, R0
	H LDI R15, %hi(.LBB36_14)
	SLT ADI R15, %lo(.LBB36_14)
	BRH NE, R15
; %bb.12:                               ;   in Loop: Header=BB36_10 Depth=1
	INT STR R5, R11, 0
	ADI R2, 4
	ADI R5, 4
	ADI R3, -4
	SUB R6, R3, R0
	H LDI R15, %hi(.LBB36_10)
	SLT ADI R15, %lo(.LBB36_10)
	BRH C, R15
.LBB36_13:
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB36_30)
	SLT ADI R15, %lo(.LBB36_30)
	BRH EQ, R15
.LBB36_14:
	ADI R5, 1
.LBB36_15:                              ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R7, 0
	CHAR STR R5, R7, -1
	SUB R7, R4, R0
	H LDI R15, %hi(.LBB36_16)
	SLT ADI R15, %lo(.LBB36_16)
	BRH EQ, R15
; %bb.31:                               ;   in Loop: Header=BB36_15 Depth=1
	ADI R5, 1
	ADI R2, 1
	ADI R3, -1
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB36_15)
	SLT ADI R15, %lo(.LBB36_15)
	BRH NE, R15
	H LDI R15, %hi(.LBB36_30)
	SLT ADI R15, %lo(.LBB36_30)
	JMP R15
.LBB36_16:
	SLT ADD R3, R0, R7
.LBB36_17:
	ADI R7, -1
	SUB R7, R4, R0
	H LDI R15, %hi(.LBB36_30)
	SLT ADI R15, %lo(.LBB36_30)
	BRH EQ, R15
; %bb.18:
	AND R5, R6, R2
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB36_22)
	SLT ADI R15, %lo(.LBB36_22)
	BRH EQ, R15
; %bb.19:
	LDI R2, 1
.LBB36_20:                              ; =>This Inner Loop Header: Depth=1
	SLT ADD R7, R0, R3
	ADI R7, -1
	CHAR STR R5, R4, 0
	ADI R5, 1
	AND R5, R6, R8
	SUB R8, R4, R0
	H LDI R15, %hi(.LBB36_22)
	SLT ADI R15, %lo(.LBB36_22)
	BRH EQ, R15
; %bb.21:                               ;   in Loop: Header=BB36_20 Depth=1
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB36_20)
	SLT ADI R15, %lo(.LBB36_20)
	BRH NE, R15
.LBB36_22:
	LDI R2, 4
	SUB R7, R2, R0
	H LDI R15, %hi(.LBB36_27)
	SLT ADI R15, %lo(.LBB36_27)
	BRH C, R15
; %bb.23:
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -4
	AND R7, R2, R2
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB36_26)
	SLT ADI R15, %lo(.LBB36_26)
	BRH EQ, R15
; %bb.24:                               ; %dynamic-memset-expansion-main-body.preheader
	SLT ADD R4, R0, R3
.LBB36_25:                              ; %dynamic-memset-expansion-main-body
                                        ; =>This Inner Loop Header: Depth=1
	ADD R5, R3, R8
	CHAR STR R8, R4, 0
	ADI R3, 1
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB36_25)
	SLT ADI R15, %lo(.LBB36_25)
	BRH C, R15
.LBB36_26:                              ; %dynamic-memset-post-expansion
	AND R7, R6, R7
	ADD R5, R2, R5
.LBB36_27:
	SUB R7, R4, R0
	H LDI R15, %hi(.LBB36_30)
	SLT ADI R15, %lo(.LBB36_30)
	BRH EQ, R15
; %bb.28:                               ; %dynamic-memset-expansion-main-body2.preheader
	SLT ADD R4, R0, R2
.LBB36_29:                              ; %dynamic-memset-expansion-main-body2
                                        ; =>This Inner Loop Header: Depth=1
	ADD R5, R2, R3
	CHAR STR R3, R4, 0
	ADI R2, 1
	SUB R2, R7, R0
	H LDI R15, %hi(.LBB36_29)
	SLT ADI R15, %lo(.LBB36_29)
	BRH C, R15
.LBB36_30:
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -24
	RET
.Lfunc_end36:
	.size	strncpy, .Lfunc_end36-strncpy
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
	H LDI R15, %hi(.LBB37_2)
	SLT ADI R15, %lo(.LBB37_2)
	BRH EQ, R15
; %bb.1:
	LDI R4, 0
	H LDI R4, strtok.last_token
	SLT ADI R4, strtok.last_token
	INT STR R4, R3, 0
	H LDI R15, %hi(.LBB37_3)
	SLT ADI R15, %lo(.LBB37_3)
	JMP R15
.LBB37_2:
	LDI R3, 0
	H LDI R3, strtok.last_token
	SLT ADI R3, strtok.last_token
	INT LOD R3, R3, 0
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB37_14)
	SLT ADI R15, %lo(.LBB37_14)
	BRH EQ, R15
.LBB37_3:
	CHAR LOD R3, R7, 0
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB37_14)
	SLT ADI R15, %lo(.LBB37_14)
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
	H LDI R15, %hi(.LBB37_7)
	SLT ADI R15, %lo(.LBB37_7)
	BRH EQ, R15
; %bb.5:                                ; %.preheader2
	ADI R2, 1
.LBB37_6:                               ; =>This Inner Loop Header: Depth=1
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
	H LDI R15, %hi(.LBB37_6)
	SLT ADI R15, %lo(.LBB37_6)
	BRH NE, R15
.LBB37_7:
	ADI R3, 1
	LDI R2, 0
	H LDI R2, strtok.last_token
	SLT ADI R2, strtok.last_token
.LBB37_8:                               ; =>This Inner Loop Header: Depth=1
	AND R7, R5, R10
	RSH R7, R6, R11
	AND R11, R8, R11
	ADD R4, R11, R11
	INT LOD R11, R11, 0
	RSH R11, R10, R10
	AND R10, R9, R10
	SUB R10, R1, R0
	H LDI R15, %hi(.LBB37_9)
	SLT ADI R15, %lo(.LBB37_9)
	BRH EQ, R15
; %bb.15:                               ;   in Loop: Header=BB37_8 Depth=1
	INT STR R2, R3, 0
	CHAR LOD R3, R7, 0
	ADI R3, 1
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB37_8)
	SLT ADI R15, %lo(.LBB37_8)
	BRH NE, R15
	H LDI R15, %hi(.LBB37_14)
	SLT ADI R15, %lo(.LBB37_14)
	JMP R15
.LBB37_9:                               ; %.preheader
	SLT ADD R3, R0, R2
	ADI R2, -1
	LDI R10, 0
	H LDI R10, strtok.last_token
	SLT ADI R10, strtok.last_token
.LBB37_10:                              ; =>This Inner Loop Header: Depth=1
	AND R7, R5, R11
	RSH R7, R6, R7
	AND R7, R8, R7
	ADD R4, R7, R7
	INT LOD R7, R7, 0
	RSH R7, R11, R7
	AND R7, R9, R7
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB37_11)
	SLT ADI R15, %lo(.LBB37_11)
	BRH NE, R15
; %bb.12:                               ;   in Loop: Header=BB37_10 Depth=1
	INT STR R10, R3, 0
	CHAR LOD R3, R7, 0
	ADI R3, 1
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB37_10)
	SLT ADI R15, %lo(.LBB37_10)
	BRH NE, R15
	H LDI R15, %hi(.LBB37_13)
	SLT ADI R15, %lo(.LBB37_13)
	JMP R15
.LBB37_11:
	CHAR STR R3, R1, -1
	LDI R1, 0
	H LDI R1, strtok.last_token
	SLT ADI R1, strtok.last_token
	INT STR R1, R3, 0
.LBB37_13:
	SLT ADD R2, R0, R1
.LBB37_14:
	INT LOD R14, R12, -52
	INT LOD R14, R11, -48
	INT LOD R14, R10, -44
	INT LOD R14, R9, -40
	INT LOD R14, R8, -36
	SLT ADI R14, -56
	RET
.Lfunc_end37:
	.size	strtok, .Lfunc_end37-strtok
                                        ; -- End function
	.globl	allocatePool                    ; -- Begin function allocatePool
	.type	allocatePool,@function
allocatePool:                           ; @allocatePool
; %bb.0:
	SLT ADI R14, 4
	LDI R1, 0
	SLT ADI R14, -4
	RET
.Lfunc_end38:
	.size	allocatePool, .Lfunc_end38-allocatePool
                                        ; -- End function
	.globl	allocatePages                   ; -- Begin function allocatePages
	.type	allocatePages,@function
allocatePages:                          ; @allocatePages
; %bb.0:
	SLT ADI R14, 4
	LDI R1, 0
	SLT ADI R14, -4
	RET
.Lfunc_end39:
	.size	allocatePages, .Lfunc_end39-allocatePages
                                        ; -- End function
	.globl	help                            ; -- Begin function help
	.type	help,@function
help:                                   ; @help
; %bb.0:
	SLT ADI R14, 16
	INT STR R14, R8, -12
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.49
	SLT ADI R1, .L.str.49
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.50
	SLT ADI R1, .L.str.1.50
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
	H LDI R1, .L.str.2.51
	SLT ADI R1, .L.str.2.51
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.50
	SLT ADI R1, .L.str.1.50
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
	H LDI R1, .L.str.2.51
	SLT ADI R1, .L.str.2.51
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.50
	SLT ADI R1, .L.str.1.50
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
	H LDI R1, .L.str.2.51
	SLT ADI R1, .L.str.2.51
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.50
	SLT ADI R1, .L.str.1.50
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
	H LDI R1, .L.str.2.51
	SLT ADI R1, .L.str.2.51
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.50
	SLT ADI R1, .L.str.1.50
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
	H LDI R1, .L.str.2.51
	SLT ADI R1, .L.str.2.51
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
	H LDI R15, %hi(.LBB40_2)
	SLT ADI R15, %lo(.LBB40_2)
	BRH EQ, R15
; %bb.1:
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.49
	SLT ADI R1, .L.str.49
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.50
	SLT ADI R1, .L.str.1.50
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
	H LDI R1, .L.str.2.51
	SLT ADI R1, .L.str.2.51
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.50
	SLT ADI R1, .L.str.1.50
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
	H LDI R1, .L.str.2.51
	SLT ADI R1, .L.str.2.51
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.50
	SLT ADI R1, .L.str.1.50
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
	H LDI R1, .L.str.2.51
	SLT ADI R1, .L.str.2.51
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB40_2:
	INT LOD R14, R8, -12
	SLT ADI R14, -16
	RET
.Lfunc_end40:
	.size	help, .Lfunc_end40-help
                                        ; -- End function
	.globl	sysOff                          ; -- Begin function sysOff
	.type	sysOff,@function
sysOff:                                 ; @sysOff
; %bb.0:
	SLT ADI R14, 4
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.3.52
	SLT ADI R1, .L.str.3.52
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.Lfunc_end41:
	.size	sysOff, .Lfunc_end41-sysOff
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
.Lfunc_end42:
	.size	reset, .Lfunc_end42-reset
                                        ; -- End function
	.globl	initSO                          ; -- Begin function initSO
	.type	initSO,@function
initSO:                                 ; @initSO
; %bb.0:
	SLT ADI R14, 4
	SLT ADI R14, -4
	RET
.Lfunc_end43:
	.size	initSO, .Lfunc_end43-initSO
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
	H LDI R1, .L.str.4.53
	SLT ADI R1, .L.str.4.53
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
	H LDI R1, .L.str.7.54
	SLT ADI R1, .L.str.7.54
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	INT LOD R9, R1, 0
	INT LOD R1, R1, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB44_12)
	SLT ADI R15, %lo(.LBB44_12)
	BRH EQ, R15
; %bb.1:                                ; %.preheader1
	LDI R11, 20
	ADD R14, R0, R10
	INT STR R14, R10, -4
	SLT ADI R10, -8
	LDI R13, 1
	SLT ADD R8, R0, R9
	H LDI R15, %hi(.LBB44_2)
	SLT ADI R15, %lo(.LBB44_2)
	JMP R15
.LBB44_11:                              ;   in Loop: Header=BB44_2 Depth=1
	SUB R9, R1, R0
	H LDI R15, %hi(.LBB44_12)
	SLT ADI R15, %lo(.LBB44_12)
	BRH NC, R15
.LBB44_2:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB44_4 Depth 2
	MUL R9, R11, R11
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
	H LDI R15, %hi(.LBB44_7)
	SLT ADI R15, %lo(.LBB44_7)
	BRH N, R15
; %bb.3:                                ; %.preheader
                                        ;   in Loop: Header=BB44_2 Depth=1
	ADI R12, -13
	H LDI R15, %hi(.LBB44_4)
	SLT ADI R15, %lo(.LBB44_4)
	JMP R15
.LBB44_6:                               ;   in Loop: Header=BB44_4 Depth=2
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB44_7)
	SLT ADI R15, %lo(.LBB44_7)
	BRH EQ, R15
.LBB44_4:                               ;   Parent Loop BB44_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	SLT ADD R10, R0, R1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADI R12, 1
	SLT ADD R13, R0, R1
	SUB R12, R8, R0
	H LDI R15, %hi(.LBB44_6)
	SLT ADI R15, %lo(.LBB44_6)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB44_4 Depth=2
	SLT ADD R8, R0, R1
	H LDI R15, %hi(.LBB44_6)
	SLT ADI R15, %lo(.LBB44_6)
	JMP R15
.LBB44_7:                               ;   in Loop: Header=BB44_2 Depth=1
	LDI R1, 0
	H LDI R1, mapa
	SLT ADI R1, mapa
	INT LOD R1, R1, 0
	ADD R1, R11, R1
	CHAR LOD R1, R2, 16
	LDI R11, 20
	LSH R2, R11, R2
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
	H LDI R1, .L.str.2.51
	SLT ADI R1, .L.str.2.51
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADI R9, 1
	LDI R1, 0
	H LDI R1, 43691
	SLT ADI R1, -21845
	MUL R9, R1, R2
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R1, 0
	LDI R3, 0
	H LDI R3, 21845
	SLT ADI R3, 21845
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB44_11)
	SLT ADI R15, %lo(.LBB44_11)
	BRH C, R15
; %bb.8:                                ;   in Loop: Header=BB44_2 Depth=1
	SUB R9, R1, R0
	H LDI R15, %hi(.LBB44_11)
	SLT ADI R15, %lo(.LBB44_11)
	BRH NC, R15
; %bb.9:                                ;   in Loop: Header=BB44_2 Depth=1
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
	H LDI R15, %hi(.LBB44_12)
	SLT ADI R15, %lo(.LBB44_12)
	BRH EQ, R15
; %bb.10:                               ;   in Loop: Header=BB44_2 Depth=1
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
	H LDI R1, .L.str.7.54
	SLT ADI R1, .L.str.7.54
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	INT LOD R1, R1, 0
	H LDI R15, %hi(.LBB44_11)
	SLT ADI R15, %lo(.LBB44_11)
	JMP R15
.LBB44_12:
	INT LOD R14, R13, -40
	INT LOD R14, R12, -36
	INT LOD R14, R11, -32
	INT LOD R14, R10, -28
	INT LOD R14, R9, -24
	INT LOD R14, R8, -20
	SLT ADI R14, -44
	RET
.Lfunc_end44:
	.size	enumdisp, .Lfunc_end44-enumdisp
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
	H LDI R1, .L.str.4.53
	SLT ADI R1, .L.str.4.53
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R9, 0
	H LDI R9, Globals
	SLT ADI R9, Globals
	INT LOD R9, R1, 0
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
	INT LOD R9, R1, 0
	INT LOD R1, R2, 8
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB45_14)
	SLT ADI R15, %lo(.LBB45_14)
	BRH EQ, R15
; %bb.1:                                ; %.preheader1
	LDI R4, 40
	LDI R5, 0
	H LDI R5, nvmDevs
	SLT ADI R5, nvmDevs
	LDI R10, 1
	ADD R14, R0, R9
	INT STR R14, R9, -4
	SLT ADI R9, -12
	SLT ADD R8, R0, R11
	SLT ADD R8, R0, R13
	H LDI R15, %hi(.LBB45_2)
	SLT ADI R15, %lo(.LBB45_2)
	JMP R15
.LBB45_12:                              ;   in Loop: Header=BB45_2 Depth=1
	LDI R4, 40
	LDI R5, 0
	H LDI R5, nvmDevs
	SLT ADI R5, nvmDevs
.LBB45_13:                              ;   in Loop: Header=BB45_2 Depth=1
	ADI R11, 1
	INT LOD R1, R2, 8
	SUB R11, R2, R0
	H LDI R15, %hi(.LBB45_14)
	SLT ADI R15, %lo(.LBB45_14)
	BRH NC, R15
.LBB45_2:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB45_5 Depth 2
	MUL R11, R4, R2
	INT LOD R5, R3, 0
	ADD R3, R2, R12
	CHAR LOD R12, R2, 20
	SUB R2, R10, R0
	H LDI R15, %hi(.LBB45_13)
	SLT ADI R15, %lo(.LBB45_13)
	BRH NE, R15
; %bb.3:                                ;   in Loop: Header=BB45_2 Depth=1
	INT STR R14, R13, -8
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
	H LDI R15, %hi(.LBB45_8)
	SLT ADI R15, %lo(.LBB45_8)
	BRH N, R15
; %bb.4:                                ; %.preheader
                                        ;   in Loop: Header=BB45_2 Depth=1
	ADI R13, -6
	H LDI R15, %hi(.LBB45_5)
	SLT ADI R15, %lo(.LBB45_5)
	JMP R15
.LBB45_7:                               ;   in Loop: Header=BB45_5 Depth=2
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB45_8)
	SLT ADI R15, %lo(.LBB45_8)
	BRH EQ, R15
.LBB45_5:                               ;   Parent Loop BB45_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	SLT ADD R9, R0, R1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADI R13, 1
	SLT ADD R10, R0, R1
	SUB R13, R8, R0
	H LDI R15, %hi(.LBB45_7)
	SLT ADI R15, %lo(.LBB45_7)
	BRH EQ, R15
; %bb.6:                                ;   in Loop: Header=BB45_5 Depth=2
	SLT ADD R8, R0, R1
	H LDI R15, %hi(.LBB45_7)
	SLT ADI R15, %lo(.LBB45_7)
	JMP R15
.LBB45_8:                               ;   in Loop: Header=BB45_2 Depth=1
	ADI R12, 28
	SLT ADD R12, R0, R1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.51
	SLT ADI R1, .L.str.2.51
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, 43691
	SLT ADI R1, -21845
	INT LOD R14, R13, -8
	MUL R13, R1, R1
	LDI R2, 0
	H LDI R2, 54613
	SLT ADI R2, 21845
	ADD R1, R2, R2
	ADI R13, 1
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	LDI R3, 0
	H LDI R3, 21845
	SLT ADI R3, 21844
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB45_12)
	SLT ADI R15, %lo(.LBB45_12)
	BRH C, R15
; %bb.9:                                ;   in Loop: Header=BB45_2 Depth=1
	INT LOD R1, R2, 8
	SUB R13, R2, R0
	H LDI R15, %hi(.LBB45_12)
	SLT ADI R15, %lo(.LBB45_12)
	BRH NC, R15
; %bb.10:                               ;   in Loop: Header=BB45_2 Depth=1
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
	H LDI R15, %hi(.LBB45_14)
	SLT ADI R15, %lo(.LBB45_14)
	BRH EQ, R15
; %bb.11:                               ;   in Loop: Header=BB45_2 Depth=1
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
	LDI R1, 0
	H LDI R1, Globals
	SLT ADI R1, Globals
	INT LOD R1, R1, 0
	H LDI R15, %hi(.LBB45_12)
	SLT ADI R15, %lo(.LBB45_12)
	JMP R15
.LBB45_14:
	INT LOD R14, R13, -44
	INT LOD R14, R12, -40
	INT LOD R14, R11, -36
	INT LOD R14, R10, -32
	INT LOD R14, R9, -28
	INT LOD R14, R8, -24
	SLT ADI R14, -48
	RET
.Lfunc_end45:
	.size	lsboot, .Lfunc_end45-lsboot
                                        ; -- End function
	.globl	setboot                         ; -- Begin function setboot
	.type	setboot,@function
setboot:                                ; @setboot
; %bb.0:
	SLT ADI R14, 4
	SLT ADI R14, -4
	RET
.Lfunc_end46:
	.size	setboot, .Lfunc_end46-setboot
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
.Lfunc_end47:
	.size	cls, .Lfunc_end47-cls
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
	H LDI R15, %hi(.LBB48_1)
	SLT ADI R15, %lo(.LBB48_1)
	JMP R15
.LBB48_2:                               ;   in Loop: Header=BB48_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos
	SLT ADI R1, tabla_comandos
.LBB48_17:                              ;   in Loop: Header=BB48_1 Depth=1
	INT LOD R1, R1, 4
	CAL R1
.LBB48_1:                               ; =>This Inner Loop Header: Depth=1
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
	H LDI R15, %hi(.LBB48_2)
	SLT ADI R15, %lo(.LBB48_2)
	BRH EQ, R15
; %bb.3:                                ;   in Loop: Header=BB48_1 Depth=1
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.14
	SLT ADI R2, .L.str.14
	SLT ADD R12, R0, R3
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB48_4)
	SLT ADI R15, %lo(.LBB48_4)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB48_1 Depth=1
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.15
	SLT ADI R2, .L.str.15
	LDI R3, 6
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB48_6)
	SLT ADI R15, %lo(.LBB48_6)
	BRH EQ, R15
; %bb.7:                                ;   in Loop: Header=BB48_1 Depth=1
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.16
	SLT ADI R2, .L.str.16
	SLT ADD R12, R0, R3
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB48_8)
	SLT ADI R15, %lo(.LBB48_8)
	BRH EQ, R15
; %bb.9:                                ;   in Loop: Header=BB48_1 Depth=1
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.17
	SLT ADI R2, .L.str.17
	LDI R3, 9
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB48_10)
	SLT ADI R15, %lo(.LBB48_10)
	BRH EQ, R15
; %bb.11:                               ;   in Loop: Header=BB48_1 Depth=1
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.18
	SLT ADI R2, .L.str.18
	SLT ADD R12, R0, R3
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB48_12)
	SLT ADI R15, %lo(.LBB48_12)
	BRH EQ, R15
; %bb.13:                               ;   in Loop: Header=BB48_1 Depth=1
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.19
	SLT ADI R2, .L.str.19
	LDI R3, 8
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB48_14)
	SLT ADI R15, %lo(.LBB48_14)
	BRH EQ, R15
; %bb.15:                               ;   in Loop: Header=BB48_1 Depth=1
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
	H LDI R15, %hi(.LBB48_16)
	SLT ADI R15, %lo(.LBB48_16)
	BRH EQ, R15
; %bb.18:                               ;   in Loop: Header=BB48_1 Depth=1
	CHAR LOD R9, R1, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB48_1)
	SLT ADI R15, %lo(.LBB48_1)
	BRH EQ, R15
; %bb.19:                               ;   in Loop: Header=BB48_1 Depth=1
	LDI R1, 0
	H LDI R1, .L.str.12
	SLT ADI R1, .L.str.12
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(.LBB48_1)
	SLT ADI R15, %lo(.LBB48_1)
	JMP R15
.LBB48_4:                               ;   in Loop: Header=BB48_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+8
	SLT ADI R1, tabla_comandos+8
	H LDI R15, %hi(.LBB48_17)
	SLT ADI R15, %lo(.LBB48_17)
	JMP R15
.LBB48_6:                               ;   in Loop: Header=BB48_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+16
	SLT ADI R1, tabla_comandos+16
	H LDI R15, %hi(.LBB48_17)
	SLT ADI R15, %lo(.LBB48_17)
	JMP R15
.LBB48_8:                               ;   in Loop: Header=BB48_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+24
	SLT ADI R1, tabla_comandos+24
	H LDI R15, %hi(.LBB48_17)
	SLT ADI R15, %lo(.LBB48_17)
	JMP R15
.LBB48_10:                              ;   in Loop: Header=BB48_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+32
	SLT ADI R1, tabla_comandos+32
	H LDI R15, %hi(.LBB48_17)
	SLT ADI R15, %lo(.LBB48_17)
	JMP R15
.LBB48_12:                              ;   in Loop: Header=BB48_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+40
	SLT ADI R1, tabla_comandos+40
	H LDI R15, %hi(.LBB48_17)
	SLT ADI R15, %lo(.LBB48_17)
	JMP R15
.LBB48_14:                              ;   in Loop: Header=BB48_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+48
	SLT ADI R1, tabla_comandos+48
	H LDI R15, %hi(.LBB48_17)
	SLT ADI R15, %lo(.LBB48_17)
	JMP R15
.LBB48_16:                              ;   in Loop: Header=BB48_1 Depth=1
	LDI R1, 0
	H LDI R1, tabla_comandos+56
	SLT ADI R1, tabla_comandos+56
	H LDI R15, %hi(.LBB48_17)
	SLT ADI R15, %lo(.LBB48_17)
	JMP R15
.Lfunc_end48:
	.size	BiosShell, .Lfunc_end48-BiosShell
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

	.type	.L.str.1.23,@object             ; @.str.1.23
.L.str.1.23:
	.asciz	"Fatal Error: Over Limit IRQ"
	.size	.L.str.1.23, 28

	.type	.L.str.30,@object               ; @.str.30
.L.str.30:
	.asciz	"\nFatal Error: Page Fault without MMU"
	.size	.L.str.30, 37

	.type	.L.str.1.33,@object             ; @.str.1.33
.L.str.1.33:
	.asciz	"\nFatal Error: Alignament Fault"
	.size	.L.str.1.33, 31

	.type	.L.str.2.36,@object             ; @.str.2.36
.L.str.2.36:
	.asciz	"\nFatal Error: General Protection Fault"
	.size	.L.str.2.36, 39

	.type	.L.str.3.39,@object             ; @.str.3.39
.L.str.3.39:
	.asciz	"\nFatal Error: Invalid OpCode"
	.size	.L.str.3.39, 29

	.type	.L.str.4.42,@object             ; @.str.4.42
.L.str.4.42:
	.asciz	"\nFatal Error: Double Fault"
	.size	.L.str.4.42, 27

	.type	current_pool_index,@object      ; @current_pool_index
	.local	current_pool_index
	.comm	current_pool_index,4,4
	.type	ascii_pool,@object              ; @ascii_pool
	.local	ascii_pool
	.comm	ascii_pool,4,4
	.type	strtok.last_token,@object       ; @strtok.last_token
	.local	strtok.last_token
	.comm	strtok.last_token,4,4
	.type	.L.str.49,@object               ; @.str.49
.L.str.49:
	.asciz	"El sistema permite estos comandos: \n"
	.size	.L.str.49, 37

	.type	.L.str.1.50,@object             ; @.str.1.50
.L.str.1.50:
	.asciz	"- "
	.size	.L.str.1.50, 3

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

	.type	.L.str.2.51,@object             ; @.str.2.51
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.2.51:
	.asciz	"\n"
	.size	.L.str.2.51, 2

	.type	.L.str.3.52,@object             ; @.str.3.52
.L.str.3.52:
	.asciz	"Apagando sistema..."
	.size	.L.str.3.52, 20

	.type	.L.str.4.53,@object             ; @.str.4.53
.L.str.4.53:
	.asciz	"Hay "
	.size	.L.str.4.53, 5

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

	.type	.L.str.7.54,@object             ; @.str.7.54
.L.str.7.54:
	.asciz	"------------ ------------\n"
	.size	.L.str.7.54, 27

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
; Inicio en palabra ROM 5411 (byte 0x00548C)
; .start:
;	H LDI R14, 0		; SP = 0x00001000
;	SLT ADI R14, 4096
;	H LDI R15, %hi(main)
;	SLT ADI R15, %lo(main)
;	JMP R15

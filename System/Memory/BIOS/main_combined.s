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
	.globl	main                            ; -- Begin function main
	.type	main,@function
main:                                   ; @main
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
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
	H LDI R15, %hi(.LBB1_1)
	SLT ADI R15, %lo(.LBB1_1)
	BRH EQ, R15
; %bb.2:
	LDI R1, 0
	H LDI R1, .L.str
	SLT ADI R1, .L.str
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
	LDI R1, 0
	H LDI R1, map_size
	SLT ADI R1, map_size
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
	H LDI R1, .L.str.2
	SLT ADI R1, .L.str.2
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.3
	SLT ADI R1, .L.str.3
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(nvmSearch)
	SLT ADI R15, %lo(nvmSearch)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB1_3)
	SLT ADI R15, %lo(.LBB1_3)
	BRH EQ, R15
; %bb.5:
	H LDI R15, %hi(keyboardSearch)
	SLT ADI R15, %lo(keyboardSearch)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB1_6)
	SLT ADI R15, %lo(.LBB1_6)
	BRH EQ, R15
; %bb.8:
	H LDI R15, %hi(BiosShell)
	SLT ADI R15, %lo(BiosShell)
	CAL R15
	LDI R1, 0
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.LBB1_1:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB1_1)
	SLT ADI R15, %lo(.LBB1_1)
	JMP R15
.LBB1_3:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.4
	SLT ADI R1, .L.str.4
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB1_4:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB1_4)
	SLT ADI R15, %lo(.LBB1_4)
	JMP R15
.LBB1_6:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.5
	SLT ADI R1, .L.str.5
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB1_7:                                ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB1_7)
	SLT ADI R15, %lo(.LBB1_7)
	JMP R15
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        ; -- End function
	.globl	keyboard_IRQHandler             ; -- Begin function keyboard_IRQHandler
	.type	keyboard_IRQHandler,@function
keyboard_IRQHandler:                    ; @keyboard_IRQHandler
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R2, R0, R1
	LDI R2, 0
	H LDI R2, kb_registers
	SLT ADI R2, kb_registers
	INT LOD R2, R3, 0
	INT LOD R3, R2, 4
	LDI R4, 2
	INT STR R3, R4, 0
	LDI R3, 0
	H LDI R3, kq_head
	SLT ADI R3, kq_head
	CHAR LOD R3, R4, 0
	ADI R4, 1
	LDI R5, 63
	AND R4, R5, R4
	LDI R5, 0
	H LDI R5, kq_tail
	SLT ADI R5, kq_tail
	CHAR LOD R5, R5, 0
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB2_2)
	SLT ADI R15, %lo(.LBB2_2)
	BRH EQ, R15
; %bb.1:
	CHAR LOD R3, R5, 0
	LDI R6, 0
	H LDI R6, key_queue
	SLT ADI R6, key_queue
	ADD R5, R6, R5
	CHAR STR R5, R2, 0
	CHAR STR R3, R4, 0
.LBB2_2:
	SLT ADI R14, -4
	RET
.Lfunc_end2:
	.size	keyboard_IRQHandler, .Lfunc_end2-keyboard_IRQHandler
                                        ; -- End function
	.globl	keyboardSearch                  ; -- Begin function keyboardSearch
	.type	keyboardSearch,@function
keyboardSearch:                         ; @keyboardSearch
; %bb.0:
	SLT ADI R14, 16
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	LDI R1, 0
	H LDI R1, 9
	SLT ADI R1, 0
	H LDI R15, %hi(searchFirst)
	SLT ADI R15, %lo(searchFirst)
	CAL R15
	SLT ADD R1, R0, R8
	LDI R9, 0
	SUB R8, R9, R0
	H LDI R15, %hi(.LBB3_2)
	SLT ADI R15, %lo(.LBB3_2)
	BRH N, R15
; %bb.1:
	LDI R1, 20
	MUL R8, R1, R2
	LDI R3, 0
	H LDI R3, mapa
	SLT ADI R3, mapa
	INT LOD R3, R3, 0
	ADD R3, R2, R2
	CHAR LOD R2, R3, 16
	LSH R3, R1, R1
	CHAR LOD R2, R3, 17
	LDI R4, 15
	LSH R3, R4, R3
	NOR R3, R1, R1
	CHAR LOD R2, R2, 18
	LDI R3, 12
	LSH R2, R3, R2
	NOR R1, R1, R1
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 4
	NOR R1, R2, R2
	NOR R2, R2, R2
	LDI R9, 1
	INT STR R2, R9, 0
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 16
	NOR R1, R2, R2
	NOR R2, R2, R2
	INT LOD R2, R2, 0
	LDI R10, 0
	H LDI R10, kb_registers
	SLT ADI R10, kb_registers
	INT STR R10, R2, 0
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
	INT LOD R10, R1, 0
	INT STR R1, R9, 0
.LBB3_2:
	LDI R1, 0
	H LDI R1, KeyboardDetected
	SLT ADI R1, KeyboardDetected
	CHAR STR R1, R9, 0
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	XOR R8, R1, R1
	LDI R2, 31
	RSH R1, R2, R1
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -16
	RET
.Lfunc_end3:
	.size	keyboardSearch, .Lfunc_end3-keyboardSearch
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
	LDI R4, 0
	INT STR R14, R1, -4
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB4_35)
	SLT ADI R15, %lo(.LBB4_35)
	BRH EQ, R15
; %bb.1:
	LDI R5, 1
	SUB R2, R5, R0
	H LDI R15, %hi(.LBB4_35)
	SLT ADI R15, %lo(.LBB4_35)
	BRH N, R15
; %bb.2:
	INT LOD R14, R1, -4
	CHAR STR R1, R4, 0
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R3, 4
	AND R1, R3, R1
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB4_4)
	SLT ADI R15, %lo(.LBB4_4)
	BRH NE, R15
; %bb.3:
	LDI R1, 0
	H LDI R1, .L.str.6
	SLT ADI R1, .L.str.6
	H LDI R15, %hi(.LBB4_34)
	SLT ADI R15, %lo(.LBB4_34)
	JMP R15
.LBB4_4:
	ADI R2, -1
	INT STR R14, R2, -8
	LDI R13, 0
	H LDI R13, kq_tail
	SLT ADI R13, kq_tail
	LDI R9, 0
	H LDI R9, kq_head
	SLT ADI R9, kq_head
	LDI R6, 0
	H LDI R6, key_queue
	SLT ADI R6, key_queue
	LDI R7, 63
	LDI R11, 12
	SLT ADD R4, R0, R1
	SLT ADD R4, R0, R10
	H LDI R15, %hi(.LBB4_6)
	SLT ADI R15, %lo(.LBB4_6)
	JMP R15
.LBB4_5:                                ;   in Loop: Header=BB4_6 Depth=1
	;APP
	HLT
	;NO_APP
.LBB4_6:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_7 Depth 2
	CHAR LOD R13, R2, 0
	CHAR LOD R9, R3, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB4_5)
	SLT ADI R15, %lo(.LBB4_5)
	BRH EQ, R15
.LBB4_7:                                ;   Parent Loop BB4_6 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	CHAR LOD R13, R2, 0
	CHAR LOD R9, R3, 0
	SLT ADD R5, R0, R12
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB4_9)
	SLT ADI R15, %lo(.LBB4_9)
	BRH NE, R15
; %bb.8:                                ;   in Loop: Header=BB4_7 Depth=2
	SLT ADD R4, R0, R12
.LBB4_9:                                ;   in Loop: Header=BB4_7 Depth=2
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB4_30)
	SLT ADI R15, %lo(.LBB4_30)
	BRH EQ, R15
; %bb.10:                               ;   in Loop: Header=BB4_7 Depth=2
	CHAR LOD R13, R2, 0
	ADD R2, R6, R2
	CHAR LOD R2, R8, 0
	CHAR LOD R13, R2, 0
	ADI R2, 1
	AND R2, R7, R2
	CHAR STR R13, R2, 0
	SUB R11, R8, R0
	H LDI R15, %hi(.LBB4_18)
	SLT ADI R15, %lo(.LBB4_18)
	BRH N, R15
; %bb.11:                               ;   in Loop: Header=BB4_7 Depth=2
	LDI R2, 8
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB4_36)
	SLT ADI R15, %lo(.LBB4_36)
	BRH EQ, R15
; %bb.12:                               ;   in Loop: Header=BB4_7 Depth=2
	LDI R2, 10
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB4_13)
	SLT ADI R15, %lo(.LBB4_13)
	BRH NE, R15
	H LDI R15, %hi(.LBB4_20)
	SLT ADI R15, %lo(.LBB4_20)
	JMP R15
.LBB4_18:                               ;   in Loop: Header=BB4_7 Depth=2
	LDI R2, 127
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB4_19)
	SLT ADI R15, %lo(.LBB4_19)
	BRH NE, R15
.LBB4_36:                               ;   in Loop: Header=BB4_7 Depth=2
	SUB R10, R5, R0
	H LDI R15, %hi(.LBB4_16)
	SLT ADI R15, %lo(.LBB4_16)
	BRH N, R15
; %bb.37:                               ;   in Loop: Header=BB4_7 Depth=2
	SLT ADD R11, R0, R9
	SLT ADD R10, R0, R11
	ADI R11, -1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB4_40)
	SLT ADI R15, %lo(.LBB4_40)
	BRH NN, R15
; %bb.38:                               ;   in Loop: Header=BB4_7 Depth=2
	SLT ADD R11, R0, R10
	H LDI R15, %hi(.LBB4_39)
	SLT ADI R15, %lo(.LBB4_39)
	JMP R15
.LBB4_40:                               ;   in Loop: Header=BB4_7 Depth=2
	LDI R1, 0
	H LDI R1, .L.str.1.3
	SLT ADI R1, .L.str.1.3
	SLT ADD R5, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R7, 63
	LDI R6, 0
	H LDI R6, key_queue
	SLT ADI R6, key_queue
	LDI R5, 1
	LDI R4, 0
	SLT ADD R11, R0, R10
	SLT ADD R11, R0, R1
.LBB4_39:                               ;   in Loop: Header=BB4_7 Depth=2
	SLT ADD R9, R0, R11
	LDI R9, 0
	H LDI R9, kq_head
	SLT ADI R9, kq_head
	H LDI R15, %hi(.LBB4_16)
	SLT ADI R15, %lo(.LBB4_16)
	JMP R15
.LBB4_19:                               ;   in Loop: Header=BB4_7 Depth=2
	LDI R2, 13
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB4_20)
	SLT ADI R15, %lo(.LBB4_20)
	BRH EQ, R15
.LBB4_13:                               ;   in Loop: Header=BB4_7 Depth=2
	SLT ADD R8, R0, R2
	ADI R2, -32
	LDI R3, 255
	AND R2, R3, R2
	LDI R3, 94
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB4_16)
	SLT ADI R15, %lo(.LBB4_16)
	BRH C, R15
; %bb.14:                               ;   in Loop: Header=BB4_7 Depth=2
	INT LOD R14, R2, -8
	SUB R10, R2, R0
	H LDI R15, %hi(.LBB4_16)
	SLT ADI R15, %lo(.LBB4_16)
	BRH NN, R15
; %bb.15:                               ;   in Loop: Header=BB4_7 Depth=2
	INT LOD R14, R2, -4
	ADD R2, R10, R2
	CHAR STR R2, R8, 0
	ADI R10, 1
.LBB4_16:                               ;   in Loop: Header=BB4_7 Depth=2
	LDI R2, 13
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB4_30)
	SLT ADI R15, %lo(.LBB4_30)
	BRH EQ, R15
; %bb.17:                               ;   in Loop: Header=BB4_7 Depth=2
	LDI R2, 10
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB4_7)
	SLT ADI R15, %lo(.LBB4_7)
	BRH NE, R15
	H LDI R15, %hi(.LBB4_30)
	SLT ADI R15, %lo(.LBB4_30)
	JMP R15
.LBB4_20:                               ;   in Loop: Header=BB4_6 Depth=1
	SLT ADD R5, R0, R2
	LDI R3, 10
	SUB R8, R3, R0
	H LDI R15, %hi(.LBB4_22)
	SLT ADI R15, %lo(.LBB4_22)
	BRH EQ, R15
; %bb.21:                               ;   in Loop: Header=BB4_6 Depth=1
	SLT ADD R4, R0, R2
.LBB4_22:                               ;   in Loop: Header=BB4_6 Depth=1
	SLT ADD R5, R0, R3
	LDI R12, 13
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB4_24)
	SLT ADI R15, %lo(.LBB4_24)
	BRH EQ, R15
; %bb.23:                               ;   in Loop: Header=BB4_6 Depth=1
	SLT ADD R4, R0, R3
.LBB4_24:                               ;   in Loop: Header=BB4_6 Depth=1
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB4_25)
	SLT ADI R15, %lo(.LBB4_25)
	BRH NE, R15
; %bb.26:                               ;   in Loop: Header=BB4_6 Depth=1
	CHAR LOD R13, R2, 0
	CHAR LOD R9, R3, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB4_29)
	SLT ADI R15, %lo(.LBB4_29)
	BRH EQ, R15
; %bb.27:                               ;   in Loop: Header=BB4_6 Depth=1
	CHAR LOD R13, R2, 0
	ADD R2, R6, R2
	CHAR LOD R2, R2, 0
	LDI R3, 10
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB4_29)
	SLT ADI R15, %lo(.LBB4_29)
	BRH NE, R15
; %bb.28:                               ;   in Loop: Header=BB4_6 Depth=1
	CHAR LOD R13, R2, 0
	ADI R2, 1
	AND R2, R7, R2
	CHAR STR R13, R2, 0
.LBB4_29:                               ;   in Loop: Header=BB4_6 Depth=1
	SLT ADD R5, R0, R12
.LBB4_30:                               ;   in Loop: Header=BB4_6 Depth=1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB4_32)
	SLT ADI R15, %lo(.LBB4_32)
	BRH NN, R15
.LBB4_31:                               ;   in Loop: Header=BB4_6 Depth=1
	INT LOD R14, R3, -4
	ADD R3, R10, R2
	CHAR STR R2, R4, 0
	ADD R3, R1, R1
	SLT ADD R4, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R7, 63
	LDI R6, 0
	H LDI R6, key_queue
	SLT ADI R6, key_queue
	LDI R5, 1
	LDI R4, 0
	SLT ADD R10, R0, R1
.LBB4_32:                               ;   in Loop: Header=BB4_6 Depth=1
	AND R12, R5, R2
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB4_6)
	SLT ADI R15, %lo(.LBB4_6)
	BRH EQ, R15
	H LDI R15, %hi(.LBB4_33)
	SLT ADI R15, %lo(.LBB4_33)
	JMP R15
.LBB4_25:                               ;   in Loop: Header=BB4_6 Depth=1
	NOR R2, R3, R2
	NOR R2, R2, R12
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB4_31)
	SLT ADI R15, %lo(.LBB4_31)
	BRH N, R15
	H LDI R15, %hi(.LBB4_32)
	SLT ADI R15, %lo(.LBB4_32)
	JMP R15
.LBB4_33:
	INT LOD R14, R1, -4
	ADD R1, R10, R1
	LDI R2, 0
	CHAR STR R1, R2, 0
	LDI R1, 0
	H LDI R1, .L.str.2.4
	SLT ADI R1, .L.str.2.4
.LBB4_34:
	LDI R2, 0
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB4_35:
	SLT ADD R10, R0, R1
	INT LOD R14, R13, -32
	INT LOD R14, R12, -28
	INT LOD R14, R11, -24
	INT LOD R14, R10, -20
	INT LOD R14, R9, -16
	INT LOD R14, R8, -12
	SLT ADI R14, -36
	RET
.Lfunc_end4:
	.size	readInput, .Lfunc_end4-readInput
                                        ; -- End function
	.globl	nvmSearch                       ; -- Begin function nvmSearch
	.type	nvmSearch,@function
nvmSearch:                              ; @nvmSearch
; %bb.0:
	SLT ADI R14, 164
	INT STR R14, R8, -140
	INT STR R14, R9, -144
	INT STR R14, R10, -148
	INT STR R14, R11, -152
	INT STR R14, R12, -156
	INT STR R14, R13, -160
	ADD R14, R0, R8
	SLT ADI R8, -136
	LDI R1, 0
	H LDI R1, 1
	SLT ADI R1, 2050
	SLT ADD R8, R0, R2
	H LDI R15, %hi(search)
	SLT ADI R15, %lo(search)
	CAL R15
	LDI R2, 0
	H LDI R2, nvmCount
	SLT ADI R2, nvmCount
	INT STR R2, R1, 0
	LDI R2, 1
	INT STR R14, R1, -4
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB5_3)
	SLT ADI R15, %lo(.LBB5_3)
	BRH N, R15
; %bb.1:                                ; %.preheader
	LDI R13, 0
	INT LOD R14, R1, -4
	SUB R13, R1, R1
	INT STR R14, R1, -8
	LDI R11, 0
	H LDI R11, 2180
	SLT ADI R11, 2048
	LDI R9, 0
	H LDI R9, 2176
	SLT ADI R9, 0
	LDI R10, 0
	H LDI R10, 2112
	SLT ADI R10, 2048
	SLT ADD R13, R0, R12
.LBB5_2:                                ; =>This Inner Loop Header: Depth=1
	INT LOD R8, R1, 0
	INT STR R10, R13, 8
	CHAR STR R10, R13, 4
	LDI R2, 3
	INT STR R1, R2, 4
	INT LOD R1, R2, 16
	INT STR R10, R2, 0
	INT STR R2, R9, 4
	INT STR R2, R11, 8
	SLT ADD R12, R0, R2
	ADI R2, 125
	LDI R3, 0
	H LDI R3, nvm_IRQHandler
	SLT ADI R3, nvm_IRQHandler
	H LDI R15, %hi(initMSI)
	SLT ADI R15, %lo(initMSI)
	CAL R15
	INT LOD R10, R1, 0
	LDI R2, 1
	INT STR R1, R2, 0
	ADI R8, 4
	ADI R10, 12
	ADI R9, 2048
	ADI R11, 1024
	ADI R12, -1
	INT LOD R14, R1, -8
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB5_2)
	SLT ADI R15, %lo(.LBB5_2)
	BRH NE, R15
.LBB5_3:
	LDI R1, 1
	INT LOD R14, R2, -4
	LDI R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB5_5)
	SLT ADI R15, %lo(.LBB5_5)
	BRH N, R15
; %bb.4:
	SLT ADD R3, R0, R1
.LBB5_5:
	LDI R2, 0
	H LDI R2, NvmDetected
	SLT ADI R2, NvmDetected
	CHAR STR R2, R1, 0
	INT LOD R14, R13, -160
	INT LOD R14, R12, -156
	INT LOD R14, R11, -152
	INT LOD R14, R10, -148
	INT LOD R14, R9, -144
	INT LOD R14, R8, -140
	SLT ADI R14, -164
	RET
.Lfunc_end5:
	.size	nvmSearch, .Lfunc_end5-nvmSearch
                                        ; -- End function
	.type	nvm_IRQHandler,@function        ; -- Begin function nvm_IRQHandler
nvm_IRQHandler:                         ; @nvm_IRQHandler
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R2, R0, R1
	LDI R2, 125
	SUB R2, R3, R2
	LDI R3, 0
	H LDI R3, nvmCount
	SLT ADI R3, nvmCount
	INT LOD R3, R3, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB6_3)
	SLT ADI R15, %lo(.LBB6_3)
	BRH NC, R15
; %bb.1:
	LDI R3, 10
	LSH R2, R3, R3
	LDI R4, 12
	MUL R2, R4, R2
	LDI R4, 0
	H LDI R4, 2112
	SLT ADI R4, 2048
	ADD R2, R4, R2
	INT LOD R2, R4, 8
	LDI R5, 3
	LSH R4, R5, R5
	ADD R3, R5, R3
	LDI R5, 0
	H LDI R5, 2180
	SLT ADI R5, 2048
	ADD R3, R5, R3
	INT LOD R3, R3, 0
	LDI R5, 0
	H LDI R5, 256
	SLT ADI R5, -1
	AND R3, R5, R3
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB6_3)
	SLT ADI R15, %lo(.LBB6_3)
	BRH NE, R15
; %bb.2:
	LDI R3, 1
	CHAR STR R2, R3, 4
.LBB6_3:
	SLT ADI R14, -4
	RET
.Lfunc_end6:
	.size	nvm_IRQHandler, .Lfunc_end6-nvm_IRQHandler
                                        ; -- End function
	.globl	nvm_read_sectors                ; -- Begin function nvm_read_sectors
	.type	nvm_read_sectors,@function
nvm_read_sectors:                       ; @nvm_read_sectors
; %bb.0:
	SLT ADI R14, 24
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	LDI R5, 0
	H LDI R5, nvmCount
	SLT ADI R5, nvmCount
	INT LOD R5, R5, 0
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB7_1)
	SLT ADI R15, %lo(.LBB7_1)
	BRH NC, R15
; %bb.2:
	LDI R9, 12
	MUL R1, R9, R5
	LDI R6, 0
	H LDI R6, 2112
	SLT ADI R6, 2048
	ADD R5, R6, R5
	INT LOD R5, R7, 8
	;APP
	CYE SR8, R6
	;NO_APP
	;APP
	CYE SR8, R10
	;NO_APP
	LDI R8, 0
	H LDI R8, 0
	SLT ADI R8, -5
	AND R10, R8, R10
	;APP
	CYR R10, SR8
	;NO_APP
	LDI R10, 10
	LSH R1, R10, R10
	LDI R11, 3
	LSH R7, R11, R11
	ADD R10, R11, R10
	LDI R11, 0
	H LDI R11, 2180
	SLT ADI R11, 2048
	ADD R10, R11, R10
	LDI R11, 0
	H LDI R11, 0
	SLT ADI R11, -1
	INT STR R10, R11, 0
	LDI R10, 11
	LSH R1, R10, R10
	LDI R1, 4
	LSH R7, R1, R11
	ADD R10, R11, R10
	LDI R11, 0
	H LDI R11, 2176
	SLT ADI R11, 0
	ADD R10, R11, R10
	LDI R11, 0
	CHAR STR R5, R11, 4
	NOR R10, R1, R12
	NOR R12, R12, R12
	INT STR R12, R4, 0
	LDI R4, 8
	NOR R10, R4, R4
	NOR R4, R4, R4
	INT STR R4, R2, 0
	NOR R10, R9, R2
	NOR R2, R2, R2
	INT STR R2, R3, 0
	INT STR R10, R7, 0
	LDI R2, 1
	INT LOD R5, R3, 0
	CHAR STR R3, R2, 12
	CHAR LOD R5, R3, 4
	SUB R3, R11, R0
	H LDI R15, %hi(.LBB7_4)
	SLT ADI R15, %lo(.LBB7_4)
	BRH NE, R15
.LBB7_3:                                ; =>This Inner Loop Header: Depth=1
	;APP
	CYE SR8, R3
	;NO_APP
	NOR R3, R1, R3
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
	AND R3, R8, R3
	;APP
	CYR R3, SR8
	;NO_APP
	CHAR LOD R5, R3, 4
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB7_3)
	SLT ADI R15, %lo(.LBB7_3)
	BRH NE, R15
.LBB7_4:
	ADI R7, 1
	LDI R1, 127
	AND R7, R1, R1
	INT STR R5, R1, 8
	;APP
	CYR R6, SR8
	;NO_APP
	LDI R1, 0
	H LDI R15, %hi(.LBB7_5)
	SLT ADI R15, %lo(.LBB7_5)
	JMP R15
.LBB7_1:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.1.9
	SLT ADI R1, .L.str.1.9
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 2
.LBB7_5:
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -24
	RET
.Lfunc_end7:
	.size	nvm_read_sectors, .Lfunc_end7-nvm_read_sectors
                                        ; -- End function
	.globl	nvm_write_sectors               ; -- Begin function nvm_write_sectors
	.type	nvm_write_sectors,@function
nvm_write_sectors:                      ; @nvm_write_sectors
; %bb.0:
	SLT ADI R14, 24
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	LDI R5, 0
	H LDI R5, nvmCount
	SLT ADI R5, nvmCount
	INT LOD R5, R5, 0
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB8_1)
	SLT ADI R15, %lo(.LBB8_1)
	BRH NC, R15
; %bb.2:
	LDI R9, 12
	MUL R1, R9, R5
	LDI R6, 0
	H LDI R6, 2112
	SLT ADI R6, 2048
	ADD R5, R6, R5
	INT LOD R5, R7, 8
	;APP
	CYE SR8, R6
	;NO_APP
	;APP
	CYE SR8, R10
	;NO_APP
	LDI R8, 0
	H LDI R8, 0
	SLT ADI R8, -5
	AND R10, R8, R10
	;APP
	CYR R10, SR8
	;NO_APP
	LDI R10, 10
	LSH R1, R10, R10
	LDI R11, 3
	LSH R7, R11, R11
	ADD R10, R11, R10
	LDI R11, 0
	H LDI R11, 2180
	SLT ADI R11, 2048
	ADD R10, R11, R10
	LDI R11, 0
	H LDI R11, 0
	SLT ADI R11, -1
	INT STR R10, R11, 0
	LDI R10, 11
	LSH R1, R10, R10
	LDI R1, 4
	LSH R7, R1, R11
	ADD R10, R11, R10
	LDI R11, 0
	H LDI R11, 2176
	SLT ADI R11, 0
	ADD R10, R11, R10
	LDI R11, 0
	CHAR STR R5, R11, 4
	NOR R10, R1, R12
	NOR R12, R12, R12
	INT STR R12, R4, 0
	LDI R4, 8
	NOR R10, R4, R4
	NOR R4, R4, R4
	INT STR R4, R2, 0
	NOR R10, R9, R2
	NOR R2, R2, R2
	INT STR R2, R3, 0
	LDI R2, 0
	H LDI R2, 256
	SLT ADI R2, 0
	NOR R7, R2, R2
	NOR R2, R2, R2
	INT STR R10, R2, 0
	LDI R2, 1
	INT LOD R5, R3, 0
	CHAR STR R3, R2, 12
	CHAR LOD R5, R3, 4
	SUB R3, R11, R0
	H LDI R15, %hi(.LBB8_4)
	SLT ADI R15, %lo(.LBB8_4)
	BRH NE, R15
.LBB8_3:                                ; =>This Inner Loop Header: Depth=1
	;APP
	CYE SR8, R3
	;NO_APP
	NOR R3, R1, R3
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
	AND R3, R8, R3
	;APP
	CYR R3, SR8
	;NO_APP
	CHAR LOD R5, R3, 4
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB8_3)
	SLT ADI R15, %lo(.LBB8_3)
	BRH NE, R15
.LBB8_4:
	ADI R7, 1
	LDI R1, 127
	AND R7, R1, R1
	INT STR R5, R1, 8
	;APP
	CYR R6, SR8
	;NO_APP
	LDI R1, 0
	H LDI R15, %hi(.LBB8_5)
	SLT ADI R15, %lo(.LBB8_5)
	JMP R15
.LBB8_1:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.1.9
	SLT ADI R1, .L.str.1.9
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 2
.LBB8_5:
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -24
	RET
.Lfunc_end8:
	.size	nvm_write_sectors, .Lfunc_end8-nvm_write_sectors
                                        ; -- End function
	.globl	displaySearch                   ; -- Begin function displaySearch
	.type	displaySearch,@function
displaySearch:                          ; @displaySearch
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
	LDI R1, 0
	H LDI R1, 7
	SLT ADI R1, 0
	H LDI R15, %hi(searchFirst)
	SLT ADI R15, %lo(searchFirst)
	CAL R15
	SLT ADD R1, R0, R8
	LDI R1, 0
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB9_2)
	SLT ADI R15, %lo(.LBB9_2)
	BRH N, R15
; %bb.1:
	LDI R2, 20
	MUL R8, R2, R3
	LDI R4, 0
	H LDI R4, mapa
	SLT ADI R4, mapa
	INT LOD R4, R4, 0
	ADD R4, R3, R3
	CHAR LOD R3, R4, 16
	CHAR LOD R3, R5, 17
	CHAR LOD R3, R3, 18
	LDI R6, 0
	H LDI R6, display_queue+64
	SLT ADI R6, display_queue+64
	CHAR STR R6, R1, 0
	LDI R6, 0
	H LDI R6, display_queue+65
	SLT ADI R6, display_queue+65
	CHAR STR R6, R1, 0
	LDI R6, 0
	H LDI R6, display_queue+66
	SLT ADI R6, display_queue+66
	CHAR STR R6, R1, 0
	LDI R6, 0
	H LDI R6, hardware_busy
	SLT ADI R6, hardware_busy
	CHAR STR R6, R1, 0
	LSH R4, R2, R1
	LDI R2, 15
	LSH R5, R2, R2
	NOR R2, R1, R1
	LDI R2, 12
	LSH R3, R2, R2
	NOR R1, R1, R1
	NOR R1, R2, R1
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
	SLT ADI R2, 16
	NOR R1, R2, R2
	NOR R2, R2, R2
	INT LOD R2, R2, 0
	LDI R3, 0
	H LDI R3, current_display.1
	SLT ADI R3, current_display.1
	INT STR R3, R2, 0
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 0
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 127
	LDI R3, 0
	H LDI R3, tty_IRQHandler
	SLT ADI R3, tty_IRQHandler
	H LDI R15, %hi(initMSI)
	SLT ADI R15, %lo(initMSI)
	CAL R15
	LDI R1, 1
.LBB9_2:
	LDI R2, 0
	H LDI R2, DisplayDetected
	SLT ADI R2, DisplayDetected
	CHAR STR R2, R1, 0
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	XOR R8, R1, R1
	LDI R2, 31
	RSH R1, R2, R1
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.Lfunc_end9:
	.size	displaySearch, .Lfunc_end9-displaySearch
                                        ; -- End function
	.type	tty_IRQHandler,@function        ; -- Begin function tty_IRQHandler
tty_IRQHandler:                         ; @tty_IRQHandler
; %bb.0:
	SLT ADI R14, 8
	INT STR R14, R8, -4
	SLT ADD R2, R0, R1
	LDI R2, 0
	H LDI R2, display_queue+64
	SLT ADI R2, display_queue+64
	CHAR LOD R2, R3, 0
	ADI R3, 1
	LDI R4, 3
	AND R3, R4, R3
	CHAR STR R2, R3, 0
	LDI R3, 0
	H LDI R3, display_queue+66
	SLT ADI R3, display_queue+66
	CHAR LOD R3, R4, 0
	ADI R4, -1
	CHAR STR R3, R4, 0
	CHAR LOD R3, R4, 0
	LDI R3, 0
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB10_1)
	SLT ADI R15, %lo(.LBB10_1)
	BRH NE, R15
; %bb.2:
	LDI R2, 0
	H LDI R2, hardware_busy
	SLT ADI R2, hardware_busy
	CHAR STR R2, R3, 0
.LBB10_3:
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.LBB10_1:
	CHAR LOD R2, R2, 0
	LDI R3, 4
	LSH R2, R3, R2
	LDI R3, 0
	H LDI R3, display_queue
	SLT ADI R3, display_queue
	ADD R2, R3, R2
	SLT ADD R1, R0, R8
	SLT ADD R2, R0, R1
	H LDI R15, %hi(tty_execute_request)
	SLT ADI R15, %lo(tty_execute_request)
	CAL R15
	SLT ADD R8, R0, R1
	H LDI R15, %hi(.LBB10_3)
	SLT ADI R15, %lo(.LBB10_3)
	JMP R15
.Lfunc_end10:
	.size	tty_IRQHandler, .Lfunc_end10-tty_IRQHandler
                                        ; -- End function
	.type	tty_execute_request,@function   ; -- Begin function tty_execute_request
tty_execute_request:                    ; @tty_execute_request
; %bb.0:
	SLT ADI R14, 4
	LDI R2, 0
	H LDI R2, current_display.1
	SLT ADI R2, current_display.1
	INT LOD R2, R2, 0
	INT LOD R1, R3, 8
	SLT ADD R3, R0, R4
	ADI R4, -1
	LDI R5, 3
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB11_5)
	SLT ADI R15, %lo(.LBB11_5)
	BRH C, R15
; %bb.1:
	LDI R5, 2
	LSH R4, R5, R4
	LDI R5, 0
	H LDI R5, .LJTI11_0
	SLT ADI R5, .LJTI11_0
	ADD R5, R4, R4
	INT LOD R4, R4, 0
	JMP R4
.LBB11_2:
	INT LOD R1, R3, 12
	INT STR R2, R3, 8
	CHAR LOD R1, R1, 4
	INT STR R2, R1, 4
	LDI R3, 1
	H LDI R15, %hi(.LBB11_6)
	SLT ADI R15, %lo(.LBB11_6)
	JMP R15
.LBB11_3:
	INT LOD R1, R1, 12
	INT STR R2, R1, 8
	LDI R3, 2
	H LDI R15, %hi(.LBB11_6)
	SLT ADI R15, %lo(.LBB11_6)
	JMP R15
.LBB11_4:
	INT LOD R1, R1, 0
	INT STR R2, R1, 4
	LDI R3, 4
	H LDI R15, %hi(.LBB11_6)
	SLT ADI R15, %lo(.LBB11_6)
	JMP R15
.LBB11_5:
	LDI R3, 0
.LBB11_6:
	INT STR R2, R3, 0
	SLT ADI R14, -4
	RET
.Lfunc_end11:
	.size	tty_execute_request, .Lfunc_end11-tty_execute_request
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
	.type	.LJTI11_0,@object
.LJTI11_0:
	.long	.LBB11_2
	.long	.LBB11_3
	.long	.LBB11_6
	.long	.LBB11_4
	.size	.LJTI11_0, 16
                                        ; -- End function
	.text
	.globl	biosClear                       ; -- Begin function biosClear
	.type	biosClear,@function
biosClear:                              ; @biosClear
; %bb.0:
	SLT ADI R14, 4
	LDI R1, 0
	H LDI R1, system_panic
	SLT ADI R1, system_panic
	CHAR LOD R1, R1, 0
	LDI R2, 1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB12_1)
	SLT ADI R15, %lo(.LBB12_1)
	BRH EQ, R15
; %bb.2:
	LDI R1, 0
	H LDI R1, hardware_busy
	SLT ADI R1, hardware_busy
	CHAR LOD R1, R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB12_5)
	SLT ADI R15, %lo(.LBB12_5)
	BRH NE, R15
; %bb.3:                                ; %.preheader
	LDI R2, 0
.LBB12_4:                               ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	CHAR LOD R1, R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB12_4)
	SLT ADI R15, %lo(.LBB12_4)
	BRH NE, R15
.LBB12_5:
	;APP
	CYE SR8, R1
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
	H LDI R2, current_display.1
	SLT ADI R2, current_display.1
	INT LOD R2, R2, 0
	LDI R3, 3
	INT STR R2, R3, 0
	;APP
	CYR R1, SR8
	;NO_APP
.LBB12_6:
	SLT ADI R14, -4
	RET
.LBB12_1:
	LDI R1, 0
	H LDI R1, current_display.1
	SLT ADI R1, current_display.1
	INT LOD R1, R1, 0
	LDI R2, 3
	INT STR R1, R2, 0
	H LDI R15, %hi(.LBB12_6)
	SLT ADI R15, %lo(.LBB12_6)
	JMP R15
.Lfunc_end12:
	.size	biosClear, .Lfunc_end12-biosClear
                                        ; -- End function
	.globl	biosWrite                       ; -- Begin function biosWrite
	.type	biosWrite,@function
biosWrite:                              ; @biosWrite
; %bb.0:
	SLT ADI R14, 20
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	CHAR LOD R1, R4, 0
	LDI R5, 1
	LDI R3, 8
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB13_1)
	SLT ADI R15, %lo(.LBB13_1)
	BRH EQ, R15
; %bb.2:
	SLT ADD R5, R0, R3
	H LDI R15, %hi(.LBB13_3)
	SLT ADI R15, %lo(.LBB13_3)
	JMP R15
.LBB13_1:
	LDI R3, 2
.LBB13_3:
	CHAR LOD R1, R7, 1
	LDI R6, 0
	SUB R7, R6, R0
	H LDI R15, %hi(.LBB13_5)
	SLT ADI R15, %lo(.LBB13_5)
	BRH EQ, R15
; %bb.4:
	LDI R3, 4
.LBB13_5:
	NOR R2, R7, R7
	NOR R7, R7, R8
	SLT ADD R5, R0, R7
	SUB R8, R6, R0
	H LDI R15, %hi(.LBB13_7)
	SLT ADI R15, %lo(.LBB13_7)
	BRH EQ, R15
; %bb.6:
	SLT ADD R6, R0, R7
.LBB13_7:
	ADD R2, R7, R2
	LDI R6, 0
	H LDI R6, system_panic
	SLT ADI R6, system_panic
	CHAR LOD R6, R6, 0
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB13_8)
	SLT ADI R15, %lo(.LBB13_8)
	BRH EQ, R15
; %bb.14:
	LDI R5, 0
	LDI R6, 1
	SUB R6, R2, R0
	H LDI R15, %hi(.LBB13_16)
	SLT ADI R15, %lo(.LBB13_16)
	BRH N, R15
; %bb.15:
	SLT ADD R5, R0, R6
.LBB13_16:
	LDI R4, 2
	RSH R3, R4, R7
	NOR R7, R6, R6
	NOR R6, R6, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB13_23)
	SLT ADI R15, %lo(.LBB13_23)
	BRH EQ, R15
; %bb.17:
	LDI R7, 0
	H LDI R7, display_queue+66
	SLT ADI R7, display_queue+66
	CHAR LOD R7, R5, 0
	LDI R6, 4
	SUB R5, R6, R0
	H LDI R15, %hi(.LBB13_20)
	SLT ADI R15, %lo(.LBB13_20)
	BRH C, R15
; %bb.18:
	LDI R5, 3
.LBB13_19:                              ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	CHAR LOD R7, R8, 0
	SUB R5, R8, R0
	H LDI R15, %hi(.LBB13_19)
	SLT ADI R15, %lo(.LBB13_19)
	BRH C, R15
.LBB13_20:
	;APP
	CYE SR8, R5
	;NO_APP
	;APP
	CYE SR8, R8
	;NO_APP
	LDI R9, 0
	H LDI R9, 0
	SLT ADI R9, -5
	AND R8, R9, R8
	;APP
	CYR R8, SR8
	;NO_APP
	LDI R9, 0
	H LDI R9, display_queue+65
	SLT ADI R9, display_queue+65
	CHAR LOD R9, R8, 0
	LSH R8, R6, R10
	LDI R8, 0
	H LDI R8, display_queue
	SLT ADI R8, display_queue
	ADD R10, R8, R10
	INT STR R10, R1, 0
	CHAR LOD R1, R1, 0
	CHAR LOD R9, R10, 0
	LSH R10, R6, R10
	LDI R11, 0
	H LDI R11, display_queue+4
	SLT ADI R11, display_queue+4
	ADD R10, R11, R10
	CHAR STR R10, R1, 0
	CHAR LOD R9, R1, 0
	LSH R1, R6, R10
	LDI R1, 0
	H LDI R1, display_queue+8
	SLT ADI R1, display_queue+8
	ADD R10, R1, R10
	INT STR R10, R3, 0
	CHAR LOD R9, R3, 0
	LSH R3, R6, R3
	LDI R10, 0
	H LDI R10, display_queue+12
	SLT ADI R10, display_queue+12
	ADD R3, R10, R3
	INT STR R3, R2, 0
	CHAR LOD R9, R2, 0
	ADI R2, 1
	LDI R3, 3
	AND R2, R3, R2
	CHAR STR R9, R2, 0
	CHAR LOD R7, R2, 0
	ADI R2, 1
	CHAR STR R7, R2, 0
	LDI R2, 0
	H LDI R2, hardware_busy
	SLT ADI R2, hardware_busy
	CHAR LOD R2, R7, 0
	LDI R9, 0
	SUB R7, R9, R0
	H LDI R15, %hi(.LBB13_37)
	SLT ADI R15, %lo(.LBB13_37)
	BRH NE, R15
; %bb.21:
	LDI R7, 1
	CHAR STR R2, R7, 0
	LDI R2, 0
	H LDI R2, display_queue+64
	SLT ADI R2, display_queue+64
	CHAR LOD R2, R2, 0
	LSH R2, R6, R6
	ADD R6, R1, R2
	LDI R1, 0
	H LDI R1, current_display.1
	SLT ADI R1, current_display.1
	INT LOD R1, R1, 0
	INT LOD R2, R2, 0
	SLT ADD R2, R0, R7
	ADI R7, -1
	SUB R3, R7, R0
	H LDI R15, %hi(.LBB13_35)
	SLT ADI R15, %lo(.LBB13_35)
	BRH C, R15
; %bb.22:
	ADD R6, R8, R3
	LSH R7, R4, R4
	LDI R6, 0
	H LDI R6, .LJTI13_0
	SLT ADI R6, .LJTI13_0
	ADD R6, R4, R4
	INT LOD R4, R4, 0
	JMP R4
.LBB13_32:
	INT LOD R3, R2, 12
	INT STR R1, R2, 8
	CHAR LOD R3, R2, 4
	INT STR R1, R2, 4
	LDI R2, 1
	H LDI R15, %hi(.LBB13_36)
	SLT ADI R15, %lo(.LBB13_36)
	JMP R15
.LBB13_23:
	LDI R5, 0
	H LDI R5, hardware_busy
	SLT ADI R5, hardware_busy
	CHAR LOD R5, R6, 0
	LDI R7, 1
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB13_26)
	SLT ADI R15, %lo(.LBB13_26)
	BRH NE, R15
; %bb.24:                               ; %.preheader
	LDI R6, 0
.LBB13_25:                              ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	CHAR LOD R5, R7, 0
	SUB R7, R6, R0
	H LDI R15, %hi(.LBB13_25)
	SLT ADI R15, %lo(.LBB13_25)
	BRH NE, R15
.LBB13_26:
	;APP
	CYE SR8, R5
	;NO_APP
	;APP
	CYE SR8, R6
	;NO_APP
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -5
	AND R6, R7, R6
	;APP
	CYR R6, SR8
	;NO_APP
	LDI R6, 0
	H LDI R6, current_display.1
	SLT ADI R6, current_display.1
	INT LOD R6, R6, 0
	LDI R7, 4
	SUB R3, R7, R0
	H LDI R15, %hi(.LBB13_30)
	SLT ADI R15, %lo(.LBB13_30)
	BRH EQ, R15
; %bb.27:
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB13_29)
	SLT ADI R15, %lo(.LBB13_29)
	BRH NE, R15
; %bb.28:
	LDI R4, 8
	H LDI R15, %hi(.LBB13_31)
	SLT ADI R15, %lo(.LBB13_31)
	JMP R15
.LBB13_29:
	CHAR LOD R1, R1, 0
	INT STR R6, R2, 8
.LBB13_30:
	LDI R4, 4
	SLT ADD R1, R0, R2
.LBB13_31:
	ADD R6, R4, R1
	INT STR R1, R2, 0
	INT STR R6, R3, 0
	;APP
	CYR R5, SR8
	;NO_APP
	H LDI R15, %hi(.LBB13_38)
	SLT ADI R15, %lo(.LBB13_38)
	JMP R15
.LBB13_33:
	INT LOD R3, R2, 12
	INT STR R1, R2, 8
	LDI R2, 2
	H LDI R15, %hi(.LBB13_36)
	SLT ADI R15, %lo(.LBB13_36)
	JMP R15
.LBB13_34:
	INT LOD R3, R2, 0
	INT STR R1, R2, 4
	LDI R2, 4
	H LDI R15, %hi(.LBB13_36)
	SLT ADI R15, %lo(.LBB13_36)
	JMP R15
.LBB13_35:
	LDI R2, 0
.LBB13_36:
	INT STR R1, R2, 0
.LBB13_37:
	;APP
	CYR R5, SR8
	;NO_APP
.LBB13_38:
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -20
	RET
.LBB13_8:
	LDI R5, 0
	H LDI R5, current_display.1
	SLT ADI R5, current_display.1
	INT LOD R5, R5, 0
	LDI R6, 4
	SUB R3, R6, R0
	H LDI R15, %hi(.LBB13_12)
	SLT ADI R15, %lo(.LBB13_12)
	BRH EQ, R15
; %bb.9:
	LDI R1, 2
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB13_11)
	SLT ADI R15, %lo(.LBB13_11)
	BRH NE, R15
; %bb.10:
	LDI R6, 8
	H LDI R15, %hi(.LBB13_13)
	SLT ADI R15, %lo(.LBB13_13)
	JMP R15
.LBB13_12:
	SLT ADD R1, R0, R2
	H LDI R15, %hi(.LBB13_13)
	SLT ADI R15, %lo(.LBB13_13)
	JMP R15
.LBB13_11:
	INT STR R5, R2, 8
	SLT ADD R4, R0, R2
.LBB13_13:
	ADD R5, R6, R1
	INT STR R1, R2, 0
	INT STR R5, R3, 0
	H LDI R15, %hi(.LBB13_38)
	SLT ADI R15, %lo(.LBB13_38)
	JMP R15
.Lfunc_end13:
	.size	biosWrite, .Lfunc_end13-biosWrite
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
	.type	.LJTI13_0,@object
.LJTI13_0:
	.long	.LBB13_32
	.long	.LBB13_33
	.long	.LBB13_36
	.long	.LBB13_34
	.size	.LJTI13_0, 16
                                        ; -- End function
	.text
	.globl	fat_mount                       ; -- Begin function fat_mount
	.type	fat_mount,@function
fat_mount:                              ; @fat_mount
; %bb.0:
	SLT ADI R14, 4108
	INT STR R14, R8, -4100
	INT STR R14, R9, -4104
	LDI R1, 0
	H LDI R1, nvm_selected
	SLT ADI R1, nvm_selected
	INT LOD R1, R1, 0
	ADD R14, R0, R8
	SLT ADI R8, -4096
	LDI R2, 0
	LDI R9, 1
	SLT ADD R9, R0, R3
	SLT ADD R8, R0, R4
	H LDI R15, %hi(nvm_read_sectors)
	SLT ADI R15, %lo(nvm_read_sectors)
	CAL R15
	LDI R2, 2
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB14_3)
	SLT ADI R15, %lo(.LBB14_3)
	BRH EQ, R15
; %bb.1:
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB14_2)
	SLT ADI R15, %lo(.LBB14_2)
	BRH EQ, R15
; %bb.4:
	CHAR LOD R8, R2, 511
	LDI R1, 8
	LSH R2, R1, R2
	CHAR LOD R8, R3, 510
	NOR R2, R3, R2
	NOR R2, R2, R2
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -21931
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB14_5)
	SLT ADI R15, %lo(.LBB14_5)
	BRH NE, R15
; %bb.6:
	LDI R2, 0
	H LDI R2, nvm_selected
	SLT ADI R2, nvm_selected
	INT LOD R2, R4, 0
	LDI R3, 20
	MUL R4, R3, R4
	LDI R5, 0
	H LDI R5, current_vol
	SLT ADI R5, current_vol
	ADD R4, R5, R4
	CHAR LOD R8, R5, 16
	LSH R5, R1, R5
	CHAR LOD R8, R6, 15
	NOR R5, R6, R5
	NOR R5, R5, R5
	CHAR LOD R8, R6, 17
	CHAR LOD R8, R7, 18
	CHAR LOD R8, R9, 19
	INT STR R4, R5, 0
	LSH R9, R1, R4
	NOR R4, R7, R4
	NOR R4, R4, R4
	MUL R6, R4, R4
	ADD R4, R5, R4
	INT LOD R2, R5, 0
	MUL R5, R3, R5
	LDI R6, 0
	H LDI R6, current_vol+4
	SLT ADI R6, current_vol+4
	ADD R5, R6, R5
	INT STR R5, R4, 0
	INT LOD R2, R4, 0
	MUL R4, R3, R4
	LDI R5, 0
	H LDI R5, current_vol+8
	SLT ADI R5, current_vol+8
	ADD R4, R5, R4
	CHAR LOD R8, R5, 14
	INT STR R4, R5, 0
	INT LOD R2, R4, 0
	MUL R4, R3, R4
	LDI R6, 0
	H LDI R6, current_vol+12
	SLT ADI R6, current_vol+12
	ADD R4, R6, R4
	CHAR LOD R8, R6, 13
	LSH R6, R1, R1
	CHAR LOD R8, R6, 12
	NOR R1, R6, R1
	NOR R1, R1, R1
	MUL R1, R5, R5
	INT STR R4, R5, 0
	INT LOD R2, R2, 0
	MUL R2, R3, R2
	LDI R3, 0
	H LDI R3, current_vol+16
	SLT ADI R3, current_vol+16
	ADD R2, R3, R2
	SHORT STR R2, R1, 0
	LDI R1, 0
	H LDI R15, %hi(.LBB14_7)
	SLT ADI R15, %lo(.LBB14_7)
	JMP R15
.LBB14_3:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.1.15
	SLT ADI R1, .L.str.1.15
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 2
	H LDI R15, %hi(.LBB14_7)
	SLT ADI R15, %lo(.LBB14_7)
	JMP R15
.LBB14_5:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
.LBB14_7:
	INT LOD R14, R9, -4104
	INT LOD R14, R8, -4100
	SLT ADI R14, -4108
	RET
.LBB14_2:
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
	H LDI R1, system_panic
	SLT ADI R1, system_panic
	CHAR STR R1, R9, 0
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.14
	SLT ADI R1, .L.str.14
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.Lfunc_end14:
	.size	fat_mount, .Lfunc_end14-fat_mount
                                        ; -- End function
	.globl	fat_cluster_to_lba              ; -- Begin function fat_cluster_to_lba
	.type	fat_cluster_to_lba,@function
fat_cluster_to_lba:                     ; @fat_cluster_to_lba
; %bb.0:
	SLT ADI R14, 4
	LDI R2, 2
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB15_1)
	SLT ADI R15, %lo(.LBB15_1)
	BRH C, R15
; %bb.2:
	LDI R2, 0
	H LDI R2, nvm_selected
	SLT ADI R2, nvm_selected
	INT LOD R2, R3, 0
	LDI R4, 20
	MUL R3, R4, R3
	LDI R5, 0
	H LDI R5, current_vol+4
	SLT ADI R5, current_vol+4
	ADD R3, R5, R3
	INT LOD R3, R3, 0
	INT LOD R2, R2, 0
	MUL R2, R4, R2
	LDI R4, 0
	H LDI R4, current_vol+8
	SLT ADI R4, current_vol+8
	ADD R2, R4, R2
	ADI R1, -2
	INT LOD R2, R2, 0
	MUL R2, R1, R1
	ADD R1, R3, R1
	H LDI R15, %hi(.LBB15_3)
	SLT ADI R15, %lo(.LBB15_3)
	JMP R15
.LBB15_1:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
.LBB15_3:
	SLT ADI R14, -4
	RET
.Lfunc_end15:
	.size	fat_cluster_to_lba, .Lfunc_end15-fat_cluster_to_lba
                                        ; -- End function
	.globl	fat_find_file                   ; -- Begin function fat_find_file
	.type	fat_find_file,@function
fat_find_file:                          ; @fat_find_file
; %bb.0:
	SLT ADI R14, 48
	INT STR R14, R8, -24
	INT STR R14, R9, -28
	INT STR R14, R10, -32
	INT STR R14, R11, -36
	INT STR R14, R12, -40
	INT STR R14, R13, -44
	SLT ADD R3, R0, R10
	SLT ADD R2, R0, R11
	SLT ADD R1, R0, R9
	LDI R1, 0
	H LDI R1, nvm_selected
	SLT ADI R1, nvm_selected
	INT LOD R1, R3, 0
	LDI R2, 20
	MUL R3, R2, R3
	LDI R4, 0
	H LDI R4, current_vol+16
	SLT ADI R4, current_vol+16
	ADD R3, R4, R3
	SHORT LOD R3, R3, 0
	INT LOD R1, R4, 0
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	LDI R5, 4096
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB16_27)
	SLT ADI R15, %lo(.LBB16_27)
	BRH C, R15
; %bb.1:
	LDI R5, 0
	H LDI R5, 4096
	SLT ADI R5, -9
	SUB R5, R9, R0
	H LDI R15, %hi(.LBB16_27)
	SLT ADI R15, %lo(.LBB16_27)
	BRH C, R15
; %bb.2:
	MUL R4, R2, R1
	LDI R4, 0
	H LDI R4, current_vol+8
	SLT ADI R4, current_vol+8
	ADD R1, R4, R1
	INT LOD R1, R13, 0
	LDI R12, 0
	SUB R13, R12, R0
	H LDI R15, %hi(.LBB16_3)
	SLT ADI R15, %lo(.LBB16_3)
	BRH EQ, R15
; %bb.7:
	LDI R1, 0
	H LDI R1, 1
	SLT ADI R1, -1
	AND R3, R1, R1
	LDI R3, 21
	INT STR R14, R13, -20
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB16_8)
	SLT ADI R15, %lo(.LBB16_8)
	BRH NC, R15
; %bb.13:                               ; %.preheader5
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -17873
	MUL R1, R3, R1
	RSH R1, R2, R1
	INT STR R14, R1, -12
	LDI R8, 229
.LBB16_14:                              ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB16_16 Depth 2
                                        ;       Child Loop BB16_18 Depth 3
	SLT ADD R9, R0, R1
	H LDI R15, %hi(fat_cluster_to_lba)
	SLT ADI R15, %lo(fat_cluster_to_lba)
	CAL R15
	SLT ADD R1, R0, R2
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	INT STR R14, R2, -16
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB16_27)
	SLT ADI R15, %lo(.LBB16_27)
	BRH EQ, R15
; %bb.15:                               ; %.preheader3
                                        ;   in Loop: Header=BB16_14 Depth=1
	SLT ADD R12, R0, R1
	INT STR R14, R10, -4
.LBB16_16:                              ;   Parent Loop BB16_14 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB16_18 Depth 3
	SLT ADD R1, R0, R2
	INT LOD R14, R1, -16
	INT STR R14, R2, -8
	ADD R2, R1, R2
	LDI R1, 0
	H LDI R1, nvm_selected
	SLT ADI R1, nvm_selected
	INT LOD R1, R1, 0
	LDI R3, 1
	LDI R4, 0
	H LDI R4, fat_page_buffer
	SLT ADI R4, fat_page_buffer
	H LDI R15, %hi(nvm_read_sectors)
	SLT ADI R15, %lo(nvm_read_sectors)
	CAL R15
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB16_6)
	SLT ADI R15, %lo(.LBB16_6)
	BRH NE, R15
; %bb.17:                               ; %.preheader1
                                        ;   in Loop: Header=BB16_16 Depth=2
	LDI R10, 0
	H LDI R10, fat_page_buffer
	SLT ADI R10, fat_page_buffer
	INT LOD R14, R13, -12
	H LDI R15, %hi(.LBB16_18)
	SLT ADI R15, %lo(.LBB16_18)
	JMP R15
.LBB16_21:                              ;   in Loop: Header=BB16_18 Depth=3
	ADI R10, 22
	ADI R13, -1
	SUB R13, R12, R0
	H LDI R15, %hi(.LBB16_22)
	SLT ADI R15, %lo(.LBB16_22)
	BRH EQ, R15
.LBB16_18:                              ;   Parent Loop BB16_14 Depth=1
                                        ;     Parent Loop BB16_16 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	CHAR LOD R10, R1, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB16_21)
	SLT ADI R15, %lo(.LBB16_21)
	BRH EQ, R15
; %bb.19:                               ;   in Loop: Header=BB16_18 Depth=3
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB16_6)
	SLT ADI R15, %lo(.LBB16_6)
	BRH EQ, R15
; %bb.20:                               ;   in Loop: Header=BB16_18 Depth=3
	SLT ADD R10, R0, R1
	SLT ADD R11, R0, R2
	LDI R3, 13
	H LDI R15, %hi(memcmp)
	SLT ADI R15, %lo(memcmp)
	CAL R15
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB16_21)
	SLT ADI R15, %lo(.LBB16_21)
	BRH NE, R15
	H LDI R15, %hi(.LBB16_24)
	SLT ADI R15, %lo(.LBB16_24)
	JMP R15
.LBB16_22:                              ;   in Loop: Header=BB16_16 Depth=2
	INT LOD R14, R1, -8
	ADI R1, 1
	INT LOD R14, R10, -4
	INT LOD R14, R13, -20
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB16_16)
	SLT ADI R15, %lo(.LBB16_16)
	BRH NE, R15
; %bb.23:                               ;   in Loop: Header=BB16_14 Depth=1
	SLT ADD R9, R0, R1
	H LDI R15, %hi(fat_get_next_cluster)
	SLT ADI R15, %lo(fat_get_next_cluster)
	CAL R15
	SLT ADD R1, R0, R9
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	LDI R2, 0
	H LDI R2, 4096
	SLT ADI R2, -8
	SUB R9, R2, R0
	H LDI R15, %hi(.LBB16_14)
	SLT ADI R15, %lo(.LBB16_14)
	BRH C, R15
	H LDI R15, %hi(.LBB16_27)
	SLT ADI R15, %lo(.LBB16_27)
	JMP R15
.LBB16_3:
	LDI R8, 0
	H LDI R8, 4096
	SLT ADI R8, -8
.LBB16_4:                               ; =>This Inner Loop Header: Depth=1
	SLT ADD R9, R0, R1
	H LDI R15, %hi(fat_cluster_to_lba)
	SLT ADI R15, %lo(fat_cluster_to_lba)
	CAL R15
	SLT ADD R1, R0, R2
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB16_27)
	SLT ADI R15, %lo(.LBB16_27)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB16_4 Depth=1
	SLT ADD R9, R0, R1
	H LDI R15, %hi(fat_get_next_cluster)
	SLT ADI R15, %lo(fat_get_next_cluster)
	CAL R15
	SLT ADD R1, R0, R9
	SUB R9, R8, R0
	H LDI R15, %hi(.LBB16_4)
	SLT ADI R15, %lo(.LBB16_4)
	BRH C, R15
.LBB16_6:                               ; %.loopexit2
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
.LBB16_27:
	INT LOD R14, R13, -44
	INT LOD R14, R12, -40
	INT LOD R14, R11, -36
	INT LOD R14, R10, -32
	INT LOD R14, R9, -28
	INT LOD R14, R8, -24
	SLT ADI R14, -48
	RET
.LBB16_8:
	LDI R11, 0
	H LDI R11, nvm_selected
	SLT ADI R11, nvm_selected
	LDI R8, 1
.LBB16_9:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB16_10 Depth 2
	SLT ADD R9, R0, R1
	H LDI R15, %hi(fat_cluster_to_lba)
	SLT ADI R15, %lo(fat_cluster_to_lba)
	CAL R15
	SLT ADD R1, R0, R10
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	SUB R10, R1, R0
	H LDI R15, %hi(.LBB16_27)
	SLT ADI R15, %lo(.LBB16_27)
	BRH EQ, R15
.LBB16_10:                              ;   Parent Loop BB16_9 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	INT LOD R11, R1, 0
	SLT ADD R10, R0, R2
	SLT ADD R8, R0, R3
	LDI R4, 0
	H LDI R4, fat_page_buffer
	SLT ADI R4, fat_page_buffer
	H LDI R15, %hi(nvm_read_sectors)
	SLT ADI R15, %lo(nvm_read_sectors)
	CAL R15
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB16_6)
	SLT ADI R15, %lo(.LBB16_6)
	BRH NE, R15
; %bb.11:                               ;   in Loop: Header=BB16_10 Depth=2
	ADI R10, 1
	ADI R13, -1
	SUB R13, R12, R0
	H LDI R15, %hi(.LBB16_10)
	SLT ADI R15, %lo(.LBB16_10)
	BRH NE, R15
; %bb.12:                               ;   in Loop: Header=BB16_9 Depth=1
	SLT ADD R9, R0, R1
	H LDI R15, %hi(fat_get_next_cluster)
	SLT ADI R15, %lo(fat_get_next_cluster)
	CAL R15
	SLT ADD R1, R0, R9
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	INT LOD R14, R13, -20
	LDI R2, 0
	H LDI R2, 4096
	SLT ADI R2, -8
	SUB R9, R2, R0
	H LDI R15, %hi(.LBB16_9)
	SLT ADI R15, %lo(.LBB16_9)
	BRH C, R15
	H LDI R15, %hi(.LBB16_27)
	SLT ADI R15, %lo(.LBB16_27)
	JMP R15
.LBB16_24:
	INT LOD R14, R2, -4
	SUB R2, R12, R0
	H LDI R15, %hi(.LBB16_25)
	SLT ADI R15, %lo(.LBB16_25)
	BRH EQ, R15
; %bb.26:
	CHAR LOD R10, R1, 0
	CHAR STR R2, R1, 0
	SLT ADD R10, R0, R1
	ADI R1, 21
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 21
	SLT ADD R10, R0, R1
	ADI R1, 20
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 20
	SLT ADD R10, R0, R1
	ADI R1, 19
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 19
	SLT ADD R10, R0, R1
	ADI R1, 18
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 18
	SLT ADD R10, R0, R1
	ADI R1, 17
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 17
	SLT ADD R10, R0, R1
	ADI R1, 16
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 16
	SLT ADD R10, R0, R1
	ADI R1, 15
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 15
	SLT ADD R10, R0, R1
	ADI R1, 14
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 14
	SLT ADD R10, R0, R1
	ADI R1, 13
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 13
	SLT ADD R10, R0, R1
	ADI R1, 12
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 12
	SLT ADD R10, R0, R1
	ADI R1, 11
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 11
	SLT ADD R10, R0, R1
	ADI R1, 10
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 10
	SLT ADD R10, R0, R1
	ADI R1, 9
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 9
	SLT ADD R10, R0, R1
	ADI R1, 8
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 8
	SLT ADD R10, R0, R1
	ADI R1, 7
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 7
	SLT ADD R10, R0, R1
	ADI R1, 6
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 6
	SLT ADD R10, R0, R1
	ADI R1, 5
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 5
	SLT ADD R10, R0, R1
	ADI R1, 4
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 4
	SLT ADD R10, R0, R1
	ADI R1, 3
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 3
	SLT ADD R10, R0, R1
	ADI R1, 2
	CHAR LOD R1, R1, 0
	CHAR STR R2, R1, 2
	ADI R10, 1
	CHAR LOD R10, R1, 0
	CHAR STR R2, R1, 1
	LDI R1, 0
	H LDI R15, %hi(.LBB16_27)
	SLT ADI R15, %lo(.LBB16_27)
	JMP R15
.LBB16_25:
	SLT ADD R12, R0, R1
	H LDI R15, %hi(.LBB16_27)
	SLT ADI R15, %lo(.LBB16_27)
	JMP R15
.Lfunc_end16:
	.size	fat_find_file, .Lfunc_end16-fat_find_file
                                        ; -- End function
	.globl	fat_navigate_path               ; -- Begin function fat_navigate_path
	.type	fat_navigate_path,@function
fat_navigate_path:                      ; @fat_navigate_path
; %bb.0:
	SLT ADI R14, 180
	INT STR R14, R8, -156
	INT STR R14, R9, -160
	INT STR R14, R10, -164
	INT STR R14, R11, -168
	INT STR R14, R12, -172
	INT STR R14, R13, -176
	SLT ADD R2, R0, R8
	SLT ADD R1, R0, R2
	ADD R14, R0, R12
	SLT ADD R12, R0, R9
	SLT ADI R9, -152
	LDI R3, 128
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strncpy)
	SLT ADI R15, %lo(strncpy)
	CAL R15
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.16
	SLT ADI R2, .L.str.16
	H LDI R15, %hi(strtok)
	SLT ADI R15, %lo(strtok)
	CAL R15
	SLT ADD R1, R0, R2
	LDI R9, 0
	SUB R2, R9, R0
	H LDI R15, %hi(.LBB17_5)
	SLT ADI R15, %lo(.LBB17_5)
	BRH EQ, R15
; %bb.1:
	LDI R11, 2
	SLT ADD R12, R0, R10
	SLT ADI R10, -24
	LDI R13, 16
.LBB17_2:                               ; =>This Inner Loop Header: Depth=1
	SLT ADD R11, R0, R1
	SLT ADD R10, R0, R3
	H LDI R15, %hi(fat_find_file)
	SLT ADI R15, %lo(fat_find_file)
	CAL R15
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB17_8)
	SLT ADI R15, %lo(.LBB17_8)
	BRH NE, R15
; %bb.3:                                ;   in Loop: Header=BB17_2 Depth=1
	CHAR LOD R10, R1, 13
	AND R1, R13, R1
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB17_7)
	SLT ADI R15, %lo(.LBB17_7)
	BRH EQ, R15
; %bb.4:                                ;   in Loop: Header=BB17_2 Depth=1
	CHAR LOD R10, R1, 16
	LSH R1, R13, R1
	CHAR LOD R10, R2, 17
	LDI R3, 24
	LSH R2, R3, R2
	NOR R2, R1, R1
	CHAR LOD R10, R2, 15
	LDI R3, 8
	LSH R2, R3, R2
	CHAR LOD R10, R3, 14
	NOR R2, R3, R2
	NOR R1, R1, R1
	NOR R2, R2, R2
	NOR R1, R2, R1
	NOR R1, R1, R11
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.16
	SLT ADI R2, .L.str.16
	H LDI R15, %hi(strtok)
	SLT ADI R15, %lo(strtok)
	CAL R15
	SLT ADD R1, R0, R2
	SUB R2, R9, R0
	H LDI R15, %hi(.LBB17_2)
	SLT ADI R15, %lo(.LBB17_2)
	BRH NE, R15
	H LDI R15, %hi(.LBB17_5)
	SLT ADI R15, %lo(.LBB17_5)
	JMP R15
.LBB17_7:
	SLT ADD R9, R0, R1
	LDI R2, 0
	H LDI R2, .L.str.16
	SLT ADI R2, .L.str.16
	H LDI R15, %hi(strtok)
	SLT ADI R15, %lo(strtok)
	CAL R15
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB17_5)
	SLT ADI R15, %lo(.LBB17_5)
	BRH EQ, R15
.LBB17_8:
	LDI R9, 0
	H LDI R9, 0
	SLT ADI R9, -1
	H LDI R15, %hi(.LBB17_9)
	SLT ADI R15, %lo(.LBB17_9)
	JMP R15
.LBB17_5:
	SUB R8, R9, R0
	H LDI R15, %hi(.LBB17_9)
	SLT ADI R15, %lo(.LBB17_9)
	BRH EQ, R15
; %bb.6:
	SLT ADI R12, -24
	CHAR LOD R12, R1, 0
	CHAR STR R8, R1, 0
	SLT ADD R12, R0, R1
	ADI R1, 21
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 21
	SLT ADD R12, R0, R1
	ADI R1, 20
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 20
	SLT ADD R12, R0, R1
	ADI R1, 19
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 19
	SLT ADD R12, R0, R1
	ADI R1, 18
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 18
	SLT ADD R12, R0, R1
	ADI R1, 17
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 17
	SLT ADD R12, R0, R1
	ADI R1, 16
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 16
	SLT ADD R12, R0, R1
	ADI R1, 15
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 15
	SLT ADD R12, R0, R1
	ADI R1, 14
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 14
	SLT ADD R12, R0, R1
	ADI R1, 13
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 13
	SLT ADD R12, R0, R1
	ADI R1, 12
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 12
	SLT ADD R12, R0, R1
	ADI R1, 11
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 11
	SLT ADD R12, R0, R1
	ADI R1, 10
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 10
	SLT ADD R12, R0, R1
	ADI R1, 9
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 9
	SLT ADD R12, R0, R1
	ADI R1, 8
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 8
	SLT ADD R12, R0, R1
	ADI R1, 7
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 7
	SLT ADD R12, R0, R1
	ADI R1, 6
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 6
	SLT ADD R12, R0, R1
	ADI R1, 5
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 5
	SLT ADD R12, R0, R1
	ADI R1, 4
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 4
	SLT ADD R12, R0, R1
	ADI R1, 3
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 3
	SLT ADD R12, R0, R1
	ADI R1, 2
	CHAR LOD R1, R1, 0
	CHAR STR R8, R1, 2
	ADI R12, 1
	CHAR LOD R12, R1, 0
	CHAR STR R8, R1, 1
	LDI R9, 0
.LBB17_9:
	SLT ADD R9, R0, R1
	INT LOD R14, R13, -176
	INT LOD R14, R12, -172
	INT LOD R14, R11, -168
	INT LOD R14, R10, -164
	INT LOD R14, R9, -160
	INT LOD R14, R8, -156
	SLT ADI R14, -180
	RET
.Lfunc_end17:
	.size	fat_navigate_path, .Lfunc_end17-fat_navigate_path
                                        ; -- End function
	.globl	fat_get_next_cluster            ; -- Begin function fat_get_next_cluster
	.type	fat_get_next_cluster,@function
fat_get_next_cluster:                   ; @fat_get_next_cluster
; %bb.0:
	SLT ADI R14, 4124
	INT STR R14, R8, -4100
	INT STR R14, R9, -4104
	INT STR R14, R10, -4108
	INT STR R14, R11, -4112
	INT STR R14, R12, -4116
	INT STR R14, R13, -4120
	LDI R10, 0
	H LDI R10, nvm_selected
	SLT ADI R10, nvm_selected
	INT LOD R10, R2, 0
	LDI R9, 20
	MUL R2, R9, R2
	LDI R3, 0
	H LDI R3, current_vol
	SLT ADI R3, current_vol
	ADD R2, R3, R2
	INT LOD R2, R11, 0
	LDI R12, 2
	LSH R1, R12, R8
	INT LOD R10, R1, 0
	MUL R1, R9, R1
	LDI R13, 0
	H LDI R13, current_vol+16
	SLT ADI R13, current_vol+16
	ADD R1, R13, R1
	SHORT LOD R1, R2, 0
	SLT ADD R8, R0, R1
	H LDI R15, %hi(__udivsi3)
	SLT ADI R15, %lo(__udivsi3)
	CAL R15
	INT LOD R10, R2, 0
	MUL R2, R9, R3
	ADD R1, R11, R2
	ADD R3, R13, R1
	ADD R14, R0, R9
	SLT ADI R9, -4096
	SHORT LOD R1, R11, 0
	INT LOD R10, R1, 0
	LDI R10, 1
	SLT ADD R10, R0, R3
	SLT ADD R9, R0, R4
	H LDI R15, %hi(nvm_read_sectors)
	SLT ADI R15, %lo(nvm_read_sectors)
	CAL R15
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB18_3)
	SLT ADI R15, %lo(.LBB18_3)
	BRH EQ, R15
; %bb.1:
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB18_2)
	SLT ADI R15, %lo(.LBB18_2)
	BRH EQ, R15
; %bb.4:
	SLT ADD R8, R0, R1
	SLT ADD R11, R0, R2
	H LDI R15, %hi(__umodsi3)
	SLT ADI R15, %lo(__umodsi3)
	CAL R15
	LDI R2, 0
	H LDI R2, 1
	SLT ADI R2, -4
	AND R1, R2, R1
	ADD R9, R1, R1
	INT LOD R1, R2, 0
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -9
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB18_6)
	SLT ADI R15, %lo(.LBB18_6)
	BRH C, R15
; %bb.5:
	SLT ADD R2, R0, R1
	H LDI R15, %hi(.LBB18_6)
	SLT ADI R15, %lo(.LBB18_6)
	JMP R15
.LBB18_3:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.1.20
	SLT ADI R1, .L.str.1.20
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 2
.LBB18_6:
	INT LOD R14, R13, -4120
	INT LOD R14, R12, -4116
	INT LOD R14, R11, -4112
	INT LOD R14, R10, -4108
	INT LOD R14, R9, -4104
	INT LOD R14, R8, -4100
	SLT ADI R14, -4124
	RET
.LBB18_2:
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
	H LDI R1, system_panic
	SLT ADI R1, system_panic
	CHAR STR R1, R10, 0
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.19
	SLT ADI R1, .L.str.19
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.Lfunc_end18:
	.size	fat_get_next_cluster, .Lfunc_end18-fat_get_next_cluster
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
	H LDI R15, %hi(.LBB19_41)
	SLT ADI R15, %lo(.LBB19_41)
	BRH C, R15
; %bb.1:
	LDI R1, 20
	LSH R6, R1, R2
	LDI R8, 0
	LDI R1, 4096
	INT STR R14, R2, -16
	NOR R2, R1, R1
	NOR R1, R1, R5
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 0
	LDI R10, 0
	H LDI R10, 49152
	SLT ADI R10, 0
	LDI R9, 0
	H LDI R9, mapa
	SLT ADI R9, mapa
	SLT ADD R8, R0, R13
	INT STR R14, R7, -8
	INT STR R14, R6, -4
.LBB19_2:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB19_12 Depth 2
	LDI R1, 15
	LSH R13, R1, R1
	INT LOD R14, R2, -16
	NOR R1, R2, R1
	NOR R1, R1, R12
	NOR R12, R4, R1
	NOR R1, R1, R1
	INT LOD R1, R1, 0
	LDI R2, 0
	H LDI R2, 1
	SLT ADI R2, -1
	AND R1, R2, R1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB19_3)
	SLT ADI R15, %lo(.LBB19_3)
	BRH NE, R15
.LBB19_13:                              ;   in Loop: Header=BB19_2 Depth=1
	LDI R1, 1
	SUB R6, R8, R0
	H LDI R15, %hi(.LBB19_15)
	SLT ADI R15, %lo(.LBB19_15)
	BRH NE, R15
; %bb.14:                               ;   in Loop: Header=BB19_2 Depth=1
	SLT ADD R8, R0, R1
.LBB19_15:                              ;   in Loop: Header=BB19_2 Depth=1
	LDI R2, 1
	SUB R13, R8, R0
	H LDI R15, %hi(.LBB19_17)
	SLT ADI R15, %lo(.LBB19_17)
	BRH EQ, R15
; %bb.16:                               ;   in Loop: Header=BB19_2 Depth=1
	SLT ADD R8, R0, R2
.LBB19_17:                              ;   in Loop: Header=BB19_2 Depth=1
	AND R1, R2, R1
	LDI R2, 1
	AND R1, R2, R1
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB19_47)
	SLT ADI R15, %lo(.LBB19_47)
	BRH EQ, R15
	H LDI R15, %hi(.LBB19_41)
	SLT ADI R15, %lo(.LBB19_41)
	JMP R15
.LBB19_3:                               ;   in Loop: Header=BB19_2 Depth=1
	LDI R1, 0
	H LDI R1, map_size
	SLT ADI R1, map_size
	INT LOD R1, R1, 0
	LDI R2, 63
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB19_41)
	SLT ADI R15, %lo(.LBB19_41)
	BRH N, R15
; %bb.4:                                ;   in Loop: Header=BB19_2 Depth=1
	INT LOD R7, R2, 0
	ADD R2, R10, R2
	LDI R3, 20
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, 0
	MUL R1, R3, R10
	INT LOD R9, R1, 0
	ADD R1, R10, R1
	INT STR R1, R2, 0
	CHAR STR R1, R6, 16
	CHAR STR R1, R13, 17
	CHAR STR R1, R8, 18
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 8
	NOR R12, R2, R2
	NOR R2, R2, R2
	INT LOD R2, R11, 0
	LDI R2, 24
	RSH R11, R2, R2
	LDI R3, 127
	AND R2, R3, R2
	INT STR R1, R11, 12
	LDI R3, 1
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB19_6)
	SLT ADI R15, %lo(.LBB19_6)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB19_2 Depth=1
	LDI R10, 0
	H LDI R10, 49152
	SLT ADI R10, 0
.LBB19_21:                              ;   in Loop: Header=BB19_2 Depth=1
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 0
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB19_47)
	SLT ADI R15, %lo(.LBB19_47)
	BRH NE, R15
	H LDI R15, %hi(.LBB19_22)
	SLT ADI R15, %lo(.LBB19_22)
	JMP R15
.LBB19_6:                               ;   in Loop: Header=BB19_2 Depth=1
	INT STR R14, R5, -12
	INT LOD R7, R2, 0
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -1
	ADD R2, R3, R2
	LDI R3, 0
	H LDI R3, 65535
	SLT ADI R3, 0
	AND R2, R3, R2
	INT STR R7, R2, 0
	ADD R2, R4, R2
	INT STR R1, R2, 0
	LDI R2, 0
	H LDI R2, map_size
	SLT ADI R2, map_size
	INT LOD R2, R1, 0
	ADI R1, 1
	INT STR R2, R1, 0
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 16
	NOR R12, R1, R1
	NOR R1, R1, R9
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
	LSH R3, R5, R8
	NOR R4, R4, R3
	NOR R3, R8, R3
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
	INT LOD R1, R1, 0
	ADD R1, R10, R2
	INT LOD R7, R3, 0
	INT LOD R2, R4, 0
	LDI R5, 0
	H LDI R5, 16384
	SLT ADI R5, 0
	ADD R4, R5, R4
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB19_8)
	SLT ADI R15, %lo(.LBB19_8)
	BRH NC, R15
; %bb.7:                                ;   in Loop: Header=BB19_2 Depth=1
	LDI R4, 0
	H LDI R4, 1
	SLT ADI R4, -1
	ADD R3, R4, R3
	LDI R4, 0
	H LDI R4, 65535
	SLT ADI R4, 0
	AND R3, R4, R3
	INT STR R7, R3, 0
.LBB19_8:                               ;   in Loop: Header=BB19_2 Depth=1
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
	NOR R3, R8, R3
	NOR R3, R3, R3
	INT STR R9, R3, 0
	INT LOD R7, R3, 0
	LDI R10, 0
	H LDI R10, 49152
	SLT ADI R10, 0
	ADD R3, R10, R5
	INT STR R2, R5, 4
	INT LOD R2, R4, 0
	SUB R5, R4, R4
	INT STR R2, R4, 8
	INT LOD R2, R6, 0
	LDI R8, 0
	SLT ADD R8, R0, R4
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB19_10)
	SLT ADI R15, %lo(.LBB19_10)
	BRH NC, R15
; %bb.9:                                ;   in Loop: Header=BB19_2 Depth=1
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 4
	NOR R12, R4, R4
	NOR R4, R4, R4
	INT LOD R2, R2, 0
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
	RSH R2, R4, R2
	NOR R2, R3, R2
	NOR R2, R2, R4
.LBB19_10:                              ;   in Loop: Header=BB19_2 Depth=1
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 24
	NOR R12, R2, R2
	NOR R2, R2, R2
	INT STR R2, R4, 0
	INT LOD R14, R6, -4
	INT LOD R14, R5, -12
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 0
	LDI R9, 0
	H LDI R9, mapa
	SLT ADI R9, mapa
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -1
	SUB R2, R11, R0
	H LDI R15, %hi(.LBB19_11)
	SLT ADI R15, %lo(.LBB19_11)
	BRH NN, R15
.LBB19_47:                              ;   in Loop: Header=BB19_2 Depth=1
	ADI R13, 1
	LDI R1, 32
	SUB R13, R1, R0
	H LDI R15, %hi(.LBB19_41)
	SLT ADI R15, %lo(.LBB19_41)
	BRH EQ, R15
; %bb.48:                               ;   in Loop: Header=BB19_2 Depth=1
	LDI R1, 0
	H LDI R1, 1
	SLT ADI R1, -32768
	ADD R5, R1, R5
	H LDI R15, %hi(.LBB19_2)
	SLT ADI R15, %lo(.LBB19_2)
	JMP R15
.LBB19_11:                              ; %.preheader
                                        ;   in Loop: Header=BB19_2 Depth=1
	SLT ADD R5, R0, R12
	SLT ADD R8, R0, R11
	H LDI R15, %hi(.LBB19_12)
	SLT ADI R15, %lo(.LBB19_12)
	JMP R15
.LBB19_46:                              ;   in Loop: Header=BB19_12 Depth=2
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 24
	ADD R12, R2, R2
	INT STR R2, R4, 0
	ADI R12, 4096
	INT LOD R14, R6, -4
	INT LOD R14, R5, -12
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 0
	LDI R9, 0
	H LDI R9, mapa
	SLT ADI R9, mapa
	LDI R2, 7
	SUB R11, R2, R0
	H LDI R15, %hi(.LBB19_47)
	SLT ADI R15, %lo(.LBB19_47)
	BRH NC, R15
.LBB19_12:                              ;   Parent Loop BB19_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ADD R12, R4, R2
	INT LOD R2, R2, 0
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -1
	AND R2, R3, R2
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB19_13)
	SLT ADI R15, %lo(.LBB19_13)
	BRH EQ, R15
; %bb.18:                               ;   in Loop: Header=BB19_12 Depth=2
	LDI R2, 0
	H LDI R2, map_size
	SLT ADI R2, map_size
	INT LOD R2, R2, 0
	LDI R3, 63
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB19_41)
	SLT ADI R15, %lo(.LBB19_41)
	BRH N, R15
; %bb.19:                               ;   in Loop: Header=BB19_12 Depth=2
	ADI R11, 1
	INT LOD R7, R3, 0
	ADD R3, R10, R3
	LDI R4, 20
	LDI R9, 0
	H LDI R9, 49152
	SLT ADI R9, 0
	MUL R2, R4, R10
	ADD R1, R10, R1
	INT STR R1, R3, 0
	CHAR STR R1, R6, 16
	CHAR STR R1, R13, 17
	CHAR STR R1, R11, 18
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 8
	ADD R12, R2, R2
	INT LOD R2, R2, 0
	INT STR R1, R2, 12
	LDI R3, 24
	RSH R2, R3, R2
	LDI R3, 127
	AND R2, R3, R2
	LDI R3, 1
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB19_20)
	SLT ADI R15, %lo(.LBB19_20)
	BRH NE, R15
; %bb.42:                               ;   in Loop: Header=BB19_12 Depth=2
	INT LOD R7, R2, 0
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -1
	ADD R2, R3, R2
	LDI R3, 0
	H LDI R3, 65535
	SLT ADI R3, 0
	AND R2, R3, R2
	INT STR R7, R2, 0
	ADD R2, R9, R2
	INT STR R1, R2, 0
	LDI R2, 0
	H LDI R2, map_size
	SLT ADI R2, map_size
	INT LOD R2, R1, 0
	ADI R1, 1
	INT STR R2, R1, 0
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
	LSH R3, R5, R8
	NOR R4, R4, R3
	NOR R3, R8, R3
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
	INT LOD R1, R1, 0
	ADD R1, R10, R2
	INT LOD R7, R3, 0
	INT LOD R2, R4, 0
	LDI R5, 0
	H LDI R5, 16384
	SLT ADI R5, 0
	ADD R4, R5, R4
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB19_44)
	SLT ADI R15, %lo(.LBB19_44)
	BRH NC, R15
; %bb.43:                               ;   in Loop: Header=BB19_12 Depth=2
	LDI R4, 0
	H LDI R4, 1
	SLT ADI R4, -1
	ADD R3, R4, R3
	LDI R4, 0
	H LDI R4, 65535
	SLT ADI R4, 0
	AND R3, R4, R3
	INT STR R7, R3, 0
.LBB19_44:                              ;   in Loop: Header=BB19_12 Depth=2
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
	NOR R3, R8, R3
	NOR R3, R3, R3
	INT STR R9, R3, 0
	INT LOD R7, R3, 0
	LDI R10, 0
	H LDI R10, 49152
	SLT ADI R10, 0
	ADD R3, R10, R5
	INT STR R2, R5, 4
	INT LOD R2, R4, 0
	SUB R5, R4, R4
	INT STR R2, R4, 8
	INT LOD R2, R6, 0
	LDI R8, 0
	SLT ADD R8, R0, R4
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB19_46)
	SLT ADI R15, %lo(.LBB19_46)
	BRH NC, R15
; %bb.45:                               ;   in Loop: Header=BB19_12 Depth=2
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 4
	ADD R12, R4, R4
	INT LOD R2, R2, 0
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
	RSH R2, R4, R2
	NOR R2, R3, R2
	NOR R2, R2, R4
	H LDI R15, %hi(.LBB19_46)
	SLT ADI R15, %lo(.LBB19_46)
	JMP R15
.LBB19_20:                              ;   in Loop: Header=BB19_2 Depth=1
	LDI R10, 0
	H LDI R10, 49152
	SLT ADI R10, 0
	LDI R9, 0
	H LDI R9, mapa
	SLT ADI R9, mapa
	H LDI R15, %hi(.LBB19_21)
	SLT ADI R15, %lo(.LBB19_21)
	JMP R15
.LBB19_22:
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 16
	ADD R12, R2, R5
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -1
	INT STR R5, R3, 0
	INT LOD R5, R4, 0
	LDI R2, 0
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB19_26)
	SLT ADI R15, %lo(.LBB19_26)
	BRH EQ, R15
; %bb.23:
	INT LOD R7, R6, 0
	LDI R7, 0
	H LDI R7, 49152
	SLT ADI R7, 0
	ADD R6, R7, R6
	INT STR R5, R6, 0
	LDI R5, 4096
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB19_25)
	SLT ADI R15, %lo(.LBB19_25)
	BRH NC, R15
; %bb.24:
	ADI R4, 4095
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -4096
	AND R4, R5, R5
.LBB19_25:
	INT LOD R14, R7, -8
	INT LOD R7, R4, 0
	ADD R4, R5, R4
	INT STR R7, R4, 0
.LBB19_26:
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 20
	ADD R12, R4, R4
	INT STR R4, R3, 0
	INT LOD R4, R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB19_30)
	SLT ADI R15, %lo(.LBB19_30)
	BRH EQ, R15
; %bb.27:
	INT LOD R7, R5, 0
	LDI R6, 0
	H LDI R6, 49152
	SLT ADI R6, 0
	ADD R5, R6, R5
	INT STR R4, R5, 0
	LDI R4, 4096
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB19_29)
	SLT ADI R15, %lo(.LBB19_29)
	BRH NC, R15
; %bb.28:
	ADI R3, 4095
	LDI R4, 0
	H LDI R4, 0
	SLT ADI R4, -4096
	AND R3, R4, R4
.LBB19_29:
	INT LOD R7, R3, 0
	ADD R3, R4, R3
	INT STR R7, R3, 0
.LBB19_30:
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 24
	ADD R12, R3, R5
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -1
	INT STR R5, R3, 0
	INT LOD R5, R4, 0
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB19_34)
	SLT ADI R15, %lo(.LBB19_34)
	BRH EQ, R15
; %bb.31:
	INT LOD R7, R6, 0
	LDI R7, 0
	H LDI R7, 49152
	SLT ADI R7, 0
	ADD R6, R7, R6
	INT STR R5, R6, 0
	LDI R5, 4096
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB19_33)
	SLT ADI R15, %lo(.LBB19_33)
	BRH NC, R15
; %bb.32:
	ADI R4, 4095
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -4096
	AND R4, R5, R5
.LBB19_33:
	INT LOD R14, R7, -8
	INT LOD R7, R4, 0
	ADD R4, R5, R4
	INT STR R7, R4, 0
.LBB19_34:
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 28
	ADD R12, R4, R4
	INT STR R4, R3, 0
	INT LOD R4, R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB19_35)
	SLT ADI R15, %lo(.LBB19_35)
	BRH EQ, R15
; %bb.36:
	INT LOD R7, R2, 0
	LDI R5, 0
	H LDI R5, 49152
	SLT ADI R5, 0
	ADD R2, R5, R2
	INT STR R4, R2, 0
	LDI R2, 4097
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB19_37)
	SLT ADI R15, %lo(.LBB19_37)
	BRH NC, R15
; %bb.38:
	INT LOD R7, R2, 0
	ADI R2, 4096
	H LDI R15, %hi(.LBB19_39)
	SLT ADI R15, %lo(.LBB19_39)
	JMP R15
.LBB19_35:
	INT LOD R7, R2, 0
	H LDI R15, %hi(.LBB19_40)
	SLT ADI R15, %lo(.LBB19_40)
	JMP R15
.LBB19_37:
	ADI R3, 4095
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -4096
	AND R3, R2, R2
	INT LOD R7, R3, 0
	ADD R3, R2, R2
.LBB19_39:
	INT STR R7, R2, 0
.LBB19_40:
	INT LOD R1, R3, 0
	SUB R2, R3, R2
	LDI R3, 0
	H LDI R3, 49152
	SLT ADI R3, 0
	ADD R2, R3, R2
	INT STR R1, R2, 8
	INT LOD R7, R2, 0
	ADD R2, R3, R2
	INT STR R1, R2, 4
	LDI R1, 0
	H LDI R1, map_size
	SLT ADI R1, map_size
	INT LOD R1, R2, 0
	ADI R2, 1
	INT STR R1, R2, 0
.LBB19_41:
	INT LOD R14, R13, -44
	INT LOD R14, R12, -40
	INT LOD R14, R11, -36
	INT LOD R14, R10, -32
	INT LOD R14, R9, -28
	INT LOD R14, R8, -24
	SLT ADI R14, -48
	RET
.Lfunc_end19:
	.size	bus_Enumeration, .Lfunc_end19-bus_Enumeration
                                        ; -- End function
	.globl	PCIe_Bus_Enumeration            ; -- Begin function PCIe_Bus_Enumeration
	.type	PCIe_Bus_Enumeration,@function
PCIe_Bus_Enumeration:                   ; @PCIe_Bus_Enumeration
; %bb.0:
	SLT ADI R14, 12
	ADD R14, R0, R3
	SLT ADD R3, R0, R2
	SLT ADI R2, -8
	LDI R1, 1
	INT STR R2, R1, 0
	SLT ADI R3, -4
	LDI R1, 0
	INT STR R3, R1, 0
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	SLT ADI R14, -12
	RET
.Lfunc_end20:
	.size	PCIe_Bus_Enumeration, .Lfunc_end20-PCIe_Bus_Enumeration
                                        ; -- End function
	.globl	searchFirst                     ; -- Begin function searchFirst
	.type	searchFirst,@function
searchFirst:                            ; @searchFirst
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R1, R0, R2
	LDI R1, 0
	H LDI R1, map_size
	SLT ADI R1, map_size
	INT LOD R1, R3, 0
	LDI R1, 1
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB21_4)
	SLT ADI R15, %lo(.LBB21_4)
	BRH N, R15
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
.LBB21_2:                               ; =>This Inner Loop Header: Depth=1
	INT LOD R4, R6, 0
	AND R6, R5, R6
	SUB R6, R2, R0
	H LDI R15, %hi(.LBB21_5)
	SLT ADI R15, %lo(.LBB21_5)
	BRH EQ, R15
; %bb.3:                                ;   in Loop: Header=BB21_2 Depth=1
	ADI R4, 20
	ADI R1, 1
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB21_2)
	SLT ADI R15, %lo(.LBB21_2)
	BRH NE, R15
.LBB21_4:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
.LBB21_5:
	SLT ADI R14, -4
	RET
.Lfunc_end21:
	.size	searchFirst, .Lfunc_end21-searchFirst
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
	SLT ADD R1, R0, R7
	LDI R1, 0
	H LDI R1, map_size
	SLT ADI R1, map_size
	INT LOD R1, R4, 0
	LDI R1, 1
	SUB R4, R1, R0
	H LDI R15, %hi(.LBB22_1)
	SLT ADI R15, %lo(.LBB22_1)
	BRH N, R15
; %bb.2:
	LDI R1, 0
	LDI R3, 0
	H LDI R3, mapa
	SLT ADI R3, mapa
	INT LOD R3, R5, 0
	ADI R5, 18
	LDI R6, 0
	H LDI R6, 256
	SLT ADI R6, -1
	LDI R8, 15
	LDI R9, 12
	LDI R10, 0
	H LDI R10, 57344
	SLT ADI R10, 0
	LDI R11, 2
	LDI R12, 30
	SLT ADD R1, R0, R13
	H LDI R15, %hi(.LBB22_3)
	SLT ADI R15, %lo(.LBB22_3)
	JMP R15
.LBB22_7:                               ;   in Loop: Header=BB22_3 Depth=1
	ADI R5, 20
	ADI R13, 1
	SUB R13, R4, R0
	H LDI R15, %hi(.LBB22_8)
	SLT ADI R15, %lo(.LBB22_8)
	BRH NN, R15
.LBB22_3:                               ; =>This Inner Loop Header: Depth=1
	INT LOD R5, R3, -6
	AND R3, R6, R3
	SUB R3, R7, R0
	H LDI R15, %hi(.LBB22_7)
	SLT ADI R15, %lo(.LBB22_7)
	BRH NE, R15
; %bb.4:                                ;   in Loop: Header=BB22_3 Depth=1
	CHAR LOD R5, R3, -2
	LDI R4, 20
	LSH R3, R4, R3
	CHAR LOD R5, R4, -1
	LSH R4, R8, R4
	NOR R3, R4, R3
	CHAR LOD R5, R4, 0
	LSH R4, R9, R4
	NOR R3, R3, R3
	NOR R3, R4, R3
	NOR R3, R3, R3
	NOR R3, R10, R3
	LSH R1, R11, R4
	ADD R2, R4, R4
	NOR R3, R3, R3
	INT STR R4, R3, 0
	SLT ADD R1, R0, R3
	ADI R3, 1
	SUB R12, R1, R0
	H LDI R15, %hi(.LBB22_5)
	SLT ADI R15, %lo(.LBB22_5)
	BRH N, R15
; %bb.6:                                ;   in Loop: Header=BB22_3 Depth=1
	LDI R1, 0
	H LDI R1, map_size
	SLT ADI R1, map_size
	INT LOD R1, R4, 0
	SLT ADD R3, R0, R1
	H LDI R15, %hi(.LBB22_7)
	SLT ADI R15, %lo(.LBB22_7)
	JMP R15
.LBB22_1:
	LDI R1, 0
	H LDI R15, %hi(.LBB22_8)
	SLT ADI R15, %lo(.LBB22_8)
	JMP R15
.LBB22_5:
	SLT ADD R3, R0, R1
.LBB22_8:
	INT LOD R14, R13, -24
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -28
	RET
.Lfunc_end22:
	.size	search, .Lfunc_end22-search
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
	H LDI R15, %hi(.LBB23_2)
	SLT ADI R15, %lo(.LBB23_2)
	BRH EQ, R15
; %bb.1:
	LDI R4, 4
	NOR R2, R4, R4
	NOR R4, R4, R4
	;APP
	CYR R4, SR8
	;NO_APP
.LBB23_2:
	SUB R8, R3, R0
	H LDI R15, %hi(.LBB23_8)
	SLT ADI R15, %lo(.LBB23_8)
	BRH EQ, R15
; %bb.3:
	LDI R1, 127
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB23_4)
	SLT ADI R15, %lo(.LBB23_4)
	BRH C, R15
; %bb.5:
	LDI R1, 2
	LSH R8, R1, R1
	LDI R4, 0
	H LDI R4, irq_table
	SLT ADI R4, irq_table
	ADD R1, R4, R1
	INT LOD R1, R4, 0
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB23_6)
	SLT ADI R15, %lo(.LBB23_6)
	BRH EQ, R15
; %bb.13:
	SLT ADD R2, R0, R1
	SLT ADD R9, R0, R2
	SLT ADD R8, R0, R3
	CAL R4
	H LDI R15, %hi(.LBB23_9)
	SLT ADI R15, %lo(.LBB23_9)
	JMP R15
.LBB23_8:
	SLT ADD R9, R0, R3
	H LDI R15, %hi(syscallsHandler)
	SLT ADI R15, %lo(syscallsHandler)
	CAL R15
.LBB23_9:
	SLT ADD R1, R0, R9
	H LDI R15, %hi(.LBB23_10)
	SLT ADI R15, %lo(.LBB23_10)
	JMP R15
.LBB23_4:
	LDI R1, 0
	H LDI R1, .L.str.1.32
	SLT ADI R1, .L.str.1.32
	H LDI R15, %hi(.LBB23_7)
	SLT ADI R15, %lo(.LBB23_7)
	JMP R15
.LBB23_6:
	LDI R1, 0
	H LDI R1, .L.str.31
	SLT ADI R1, .L.str.31
.LBB23_7:
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
.LBB23_10:
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
	H LDI R15, %hi(.LBB23_12)
	SLT ADI R15, %lo(.LBB23_12)
	BRH C, R15
; %bb.11:
	LDI R1, 0
	H LDI R1, Registros
	SLT ADI R1, Registros
	INT LOD R1, R1, 0
	LDI R2, 1
	INT STR R1, R2, 16
.LBB23_12:
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -24
	RET
.Lfunc_end23:
	.size	mainHandler, .Lfunc_end23-mainHandler
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
.Lfunc_end24:
	.size	entryHandler, .Lfunc_end24-entryHandler
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
	H LDI R15, %hi(.LBB25_5)
	SLT ADI R15, %lo(.LBB25_5)
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
	H LDI R15, %hi(.LBB25_4)
	SLT ADI R15, %lo(.LBB25_4)
	BRH C, R15
; %bb.2:
	LDI R5, 0
	SUB R3, R5, R0
	H LDI R15, %hi(.LBB25_4)
	SLT ADI R15, %lo(.LBB25_4)
	BRH EQ, R15
; %bb.3:
	LDI R5, 2
	LSH R2, R5, R2
	LDI R5, 0
	H LDI R5, irq_table
	SLT ADI R5, irq_table
	ADD R2, R5, R2
	INT STR R2, R3, 0
.LBB25_4:
	LDI R2, 13
	RSH R4, R2, R2
	LDI R3, 112
	AND R2, R3, R2
	LDI R3, 1
	NOR R2, R3, R2
	NOR R2, R2, R2
	INT STR R1, R2, 0
.LBB25_5:
	SLT ADI R14, -4
	RET
.Lfunc_end25:
	.size	initMSI, .Lfunc_end25-initMSI
                                        ; -- End function
	.globl	initLAPIC                       ; -- Begin function initLAPIC
	.type	initLAPIC,@function
initLAPIC:                              ; @initLAPIC
; %bb.0:
	SLT ADI R14, 4
	LDI R1, 0
	H LDI R1, doubleFault
	SLT ADI R1, doubleFault
	LDI R2, 0
	H LDI R2, irq_table+20
	SLT ADI R2, irq_table+20
	INT STR R2, R1, 0
	LDI R1, 0
	H LDI R1, invalidOpCode
	SLT ADI R1, invalidOpCode
	LDI R2, 0
	H LDI R2, irq_table+16
	SLT ADI R2, irq_table+16
	INT STR R2, R1, 0
	LDI R1, 0
	H LDI R1, generalProtectionFault
	SLT ADI R1, generalProtectionFault
	LDI R2, 0
	H LDI R2, irq_table+12
	SLT ADI R2, irq_table+12
	INT STR R2, R1, 0
	LDI R1, 0
	H LDI R1, alignamentFault
	SLT ADI R1, alignamentFault
	LDI R2, 0
	H LDI R2, irq_table+8
	SLT ADI R2, irq_table+8
	INT STR R2, R1, 0
	LDI R1, 0
	H LDI R1, pageFault
	SLT ADI R1, pageFault
	LDI R2, 0
	H LDI R2, irq_table+4
	SLT ADI R2, irq_table+4
	INT STR R2, R1, 0
	LDI R1, 0
	H LDI R1, entryHandler
	SLT ADI R1, entryHandler
	;APP
	CYR R1, SR12
	;NO_APP
	LDI R1, 0
	H LDI R1, Registros
	SLT ADI R1, Registros
	INT LOD R1, R1, 0
	LDI R2, 0
	H LDI R2, 65248
	SLT ADI R2, 0
	INT STR R1, R2, 0
	LDI R2, 0
	INT STR R1, R2, 4
	INT STR R1, R2, 12
	LDI R2, 3
	INT STR R1, R2, 8
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R2, 4
	NOR R1, R2, R1
	NOR R1, R1, R1
	;APP
	CYR R1, SR8
	;NO_APP
	SLT ADI R14, -4
	RET
.Lfunc_end26:
	.size	initLAPIC, .Lfunc_end26-initLAPIC
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
	LDI R1, 1
	LDI R2, 0
	H LDI R2, system_panic
	SLT ADI R2, system_panic
	CHAR STR R2, R1, 0
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.39
	SLT ADI R1, .L.str.39
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
	.size	pageFault, .Lfunc_end27-pageFault
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
	LDI R1, 1
	LDI R2, 0
	H LDI R2, system_panic
	SLT ADI R2, system_panic
	CHAR STR R2, R1, 0
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.1.42
	SLT ADI R1, .L.str.1.42
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
	.size	alignamentFault, .Lfunc_end28-alignamentFault
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
	LDI R1, 1
	LDI R2, 0
	H LDI R2, system_panic
	SLT ADI R2, system_panic
	CHAR STR R2, R1, 0
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.2.45
	SLT ADI R1, .L.str.2.45
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
	.size	generalProtectionFault, .Lfunc_end29-generalProtectionFault
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
	LDI R1, 1
	LDI R2, 0
	H LDI R2, system_panic
	SLT ADI R2, system_panic
	CHAR STR R2, R1, 0
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.3.48
	SLT ADI R1, .L.str.3.48
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
.Lfunc_end30:
	.size	invalidOpCode, .Lfunc_end30-invalidOpCode
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
	LDI R1, 1
	LDI R2, 0
	H LDI R2, system_panic
	SLT ADI R2, system_panic
	CHAR STR R2, R1, 0
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.4.51
	SLT ADI R1, .L.str.4.51
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
.Lfunc_end31:
	.size	doubleFault, .Lfunc_end31-doubleFault
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
.Lfunc_end32:
	.size	syscallsHandler, .Lfunc_end32-syscallsHandler
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
	;APP
	CYE SR8, R3
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
	H LDI R4, current_pool_index
	SLT ADI R4, current_pool_index
	INT LOD R4, R5, 0
	SLT ADD R5, R0, R6
	ADI R6, 1
	LDI R7, 7
	AND R6, R7, R6
	INT STR R4, R6, 0
	;APP
	CYR R3, SR8
	;NO_APP
	LDI R3, 5
	LSH R5, R3, R4
	LDI R3, 0
	H LDI R3, ascii_pool
	SLT ADI R3, ascii_pool
	ADD R4, R3, R3
	LDI R5, 0
	H LDI R5, ascii_pool+31
	SLT ADI R5, ascii_pool+31
	ADD R4, R5, R5
	LDI R6, 1
	LDI R4, 0
	CHAR STR R5, R4, 0
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB33_35)
	SLT ADI R15, %lo(.LBB33_35)
	BRH EQ, R15
; %bb.1:
	LDI R7, 2
	SUB R2, R7, R0
	H LDI R15, %hi(.LBB33_29)
	SLT ADI R15, %lo(.LBB33_29)
	BRH EQ, R15
; %bb.2:
	LDI R7, 3
	SUB R2, R7, R0
	H LDI R15, %hi(.LBB33_3)
	SLT ADI R15, %lo(.LBB33_3)
	BRH NE, R15
; %bb.4:
	LDI R2, 8
	RSH R1, R2, R2
	LDI R6, 15
	AND R2, R6, R2
	LDI R4, 48
	LDI R7, 10
	SUB R2, R7, R0
	H LDI R15, %hi(.LBB33_5)
	SLT ADI R15, %lo(.LBB33_5)
	BRH C, R15
; %bb.6:
	ADI R2, 55
	H LDI R15, %hi(.LBB33_7)
	SLT ADI R15, %lo(.LBB33_7)
	JMP R15
.LBB33_29:
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB33_49)
	SLT ADI R15, %lo(.LBB33_49)
	BRH EQ, R15
; %bb.30:
	LDI R2, 15
	LDI R6, 48
	LDI R7, 10
	LDI R8, 4
	SLT ADD R5, R0, R3
	H LDI R15, %hi(.LBB33_31)
	SLT ADI R15, %lo(.LBB33_31)
	JMP R15
.LBB33_33:                              ;   in Loop: Header=BB33_31 Depth=1
	ADI R5, 55
.LBB33_34:                              ;   in Loop: Header=BB33_31 Depth=1
	CHAR STR R3, R5, -1
	RSH R1, R8, R1
	ADI R3, -1
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB33_48)
	SLT ADI R15, %lo(.LBB33_48)
	BRH EQ, R15
.LBB33_31:                              ; =>This Inner Loop Header: Depth=1
	AND R1, R2, R5
	SUB R5, R7, R0
	H LDI R15, %hi(.LBB33_33)
	SLT ADI R15, %lo(.LBB33_33)
	BRH NC, R15
; %bb.32:                               ;   in Loop: Header=BB33_31 Depth=1
	NOR R5, R6, R5
	NOR R5, R5, R5
	H LDI R15, %hi(.LBB33_34)
	SLT ADI R15, %lo(.LBB33_34)
	JMP R15
.LBB33_35:
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -1
	SLT ADD R6, R0, R2
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB33_37)
	SLT ADI R15, %lo(.LBB33_37)
	BRH N, R15
; %bb.36:
	SLT ADD R4, R0, R2
.LBB33_37:
	INT STR R14, R2, -4
	LDI R8, 31
	SLT ADD R1, R0, R7
	SUB R8, R4, R0
	H LDI R15, %hi(.LBB33_39)
	SLT ADI R15, %lo(.LBB33_39)
	BRH EQ, R15
; %bb.38:
	RSH R1, R8, R7
	LSH R7, R6, R8
	SUB R7, R8, R7
.LBB33_39:
	XOR R1, R7, R1
	SUB R1, R7, R1
	H LDI R15, %hi(.LBB33_40)
	SLT ADI R15, %lo(.LBB33_40)
	JMP R15
.LBB33_3:
	INT STR R14, R6, -4
.LBB33_40:
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB33_50)
	SLT ADI R15, %lo(.LBB33_50)
	BRH EQ, R15
; %bb.41:
	LDI R3, 31
	LDI R7, 0
	H LDI R7, 52429
	SLT ADI R7, -13107
	LDI R8, 3
	LDI R9, 10
	LDI R10, 48
	LDI R11, 9
	H LDI R15, %hi(.LBB33_42)
	SLT ADI R15, %lo(.LBB33_42)
	JMP R15
.LBB33_44:                              ;   in Loop: Header=BB33_42 Depth=1
	AND R1, R7, R1
	MUL R12, R7, R13
	GOF R2
	ADD R2, R1, R1
	ADD R1, R12, R1
	RSH R1, R8, R1
	MUL R1, R9, R2
	SUB R12, R2, R2
	NOR R2, R10, R2
	NOR R2, R2, R2
	CHAR STR R5, R2, -1
	ADI R5, -1
	SUB R11, R12, R0
	H LDI R15, %hi(.LBB33_45)
	SLT ADI R15, %lo(.LBB33_45)
	BRH NC, R15
.LBB33_42:                              ; =>This Inner Loop Header: Depth=1
	SLT ADD R1, R0, R12
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB33_44)
	SLT ADI R15, %lo(.LBB33_44)
	BRH EQ, R15
; %bb.43:                               ;   in Loop: Header=BB33_42 Depth=1
	RSH R12, R3, R1
	LSH R1, R6, R13
	SUB R1, R13, R1
	H LDI R15, %hi(.LBB33_44)
	SLT ADI R15, %lo(.LBB33_44)
	JMP R15
.LBB33_5:
	NOR R2, R4, R2
	NOR R2, R2, R2
.LBB33_7:
	LDI R5, 4
	RSH R1, R5, R5
	AND R5, R6, R5
	SUB R5, R7, R0
	H LDI R15, %hi(.LBB33_8)
	SLT ADI R15, %lo(.LBB33_8)
	BRH C, R15
; %bb.9:
	ADI R5, 55
	AND R1, R6, R8
	SUB R8, R7, R0
	H LDI R15, %hi(.LBB33_12)
	SLT ADI R15, %lo(.LBB33_12)
	BRH NC, R15
.LBB33_11:
	NOR R8, R4, R8
	NOR R8, R8, R8
	H LDI R15, %hi(.LBB33_13)
	SLT ADI R15, %lo(.LBB33_13)
	JMP R15
.LBB33_8:
	NOR R5, R4, R5
	NOR R5, R5, R5
	AND R1, R6, R8
	SUB R8, R7, R0
	H LDI R15, %hi(.LBB33_11)
	SLT ADI R15, %lo(.LBB33_11)
	BRH C, R15
.LBB33_12:
	ADI R8, 55
.LBB33_13:
	LDI R9, 24
	RSH R1, R9, R9
	AND R9, R6, R9
	SUB R9, R7, R0
	H LDI R15, %hi(.LBB33_14)
	SLT ADI R15, %lo(.LBB33_14)
	BRH C, R15
; %bb.15:
	ADI R9, 55
	H LDI R15, %hi(.LBB33_16)
	SLT ADI R15, %lo(.LBB33_16)
	JMP R15
.LBB33_14:
	NOR R9, R4, R9
	NOR R9, R9, R9
.LBB33_16:
	LDI R10, 20
	RSH R1, R10, R10
	AND R10, R6, R10
	SUB R10, R7, R0
	H LDI R15, %hi(.LBB33_17)
	SLT ADI R15, %lo(.LBB33_17)
	BRH C, R15
; %bb.18:
	ADI R10, 55
	H LDI R15, %hi(.LBB33_19)
	SLT ADI R15, %lo(.LBB33_19)
	JMP R15
.LBB33_17:
	NOR R10, R4, R10
	NOR R10, R10, R10
.LBB33_19:
	LDI R11, 16
	RSH R1, R11, R11
	AND R11, R6, R11
	SUB R11, R7, R0
	H LDI R15, %hi(.LBB33_20)
	SLT ADI R15, %lo(.LBB33_20)
	BRH C, R15
; %bb.21:
	ADI R11, 55
	H LDI R15, %hi(.LBB33_22)
	SLT ADI R15, %lo(.LBB33_22)
	JMP R15
.LBB33_20:
	NOR R11, R4, R11
	NOR R11, R11, R11
.LBB33_22:
	LDI R12, 12
	RSH R1, R12, R12
	AND R12, R6, R6
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB33_23)
	SLT ADI R15, %lo(.LBB33_23)
	BRH C, R15
; %bb.24:
	ADI R6, 55
	H LDI R15, %hi(.LBB33_25)
	SLT ADI R15, %lo(.LBB33_25)
	JMP R15
.LBB33_23:
	NOR R6, R4, R6
	NOR R6, R6, R6
.LBB33_25:
	LDI R7, 28
	RSH R1, R7, R7
	LDI R12, 0
	H LDI R12, 40960
	SLT ADI R12, 0
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB33_26)
	SLT ADI R15, %lo(.LBB33_26)
	BRH C, R15
; %bb.27:
	ADI R7, 55
	H LDI R15, %hi(.LBB33_28)
	SLT ADI R15, %lo(.LBB33_28)
	JMP R15
.LBB33_26:
	NOR R7, R4, R1
	NOR R1, R1, R7
.LBB33_28:
	CHAR STR R3, R8, 30
	CHAR STR R3, R7, 23
	CHAR STR R3, R5, 29
	CHAR STR R3, R2, 28
	CHAR STR R3, R6, 27
	CHAR STR R3, R11, 26
	CHAR STR R3, R10, 25
	CHAR STR R3, R9, 24
	ADI R3, 23
	H LDI R15, %hi(.LBB33_48)
	SLT ADI R15, %lo(.LBB33_48)
	JMP R15
.LBB33_50:
	LDI R1, 48
	CHAR STR R3, R1, 30
	ADI R3, 30
	SLT ADD R3, R0, R5
.LBB33_45:
	INT LOD R14, R1, -4
	AND R1, R6, R1
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB33_47)
	SLT ADI R15, %lo(.LBB33_47)
	BRH NE, R15
; %bb.46:
	LDI R1, 45
	CHAR STR R5, R1, -1
	ADI R5, -1
.LBB33_47:
	SLT ADD R5, R0, R3
.LBB33_48:
	SLT ADD R3, R0, R1
	INT LOD R14, R13, -28
	INT LOD R14, R12, -24
	INT LOD R14, R11, -20
	INT LOD R14, R10, -16
	INT LOD R14, R9, -12
	INT LOD R14, R8, -8
	SLT ADI R14, -32
	RET
.LBB33_49:
	LDI R1, 48
	CHAR STR R3, R1, 30
	ADI R3, 30
	H LDI R15, %hi(.LBB33_48)
	SLT ADI R15, %lo(.LBB33_48)
	JMP R15
.Lfunc_end33:
	.size	ToAscii, .Lfunc_end33-ToAscii
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
	H LDI R15, %hi(.LBB34_1)
	SLT ADI R15, %lo(.LBB34_1)
	BRH EQ, R15
; %bb.2:                                ; %.preheader
	LDI R5, 31
	LDI R6, 1
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -1
	SLT ADD R4, R0, R8
	SLT ADD R4, R0, R3
	H LDI R15, %hi(.LBB34_3)
	SLT ADI R15, %lo(.LBB34_3)
	JMP R15
.LBB34_7:                               ;   in Loop: Header=BB34_3 Depth=1
	SUB R8, R10, R8
	NOR R9, R3, R3
	NOR R3, R3, R3
	ADI R5, -1
	SUB R5, R7, R0
	H LDI R15, %hi(.LBB34_8)
	SLT ADI R15, %lo(.LBB34_8)
	BRH EQ, R15
.LBB34_3:                               ; =>This Inner Loop Header: Depth=1
	LSH R8, R6, R8
	RSH R1, R5, R9
	AND R9, R6, R9
	NOR R9, R8, R8
	NOR R8, R8, R8
	SLT ADD R4, R0, R9
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB34_5)
	SLT ADI R15, %lo(.LBB34_5)
	BRH C, R15
; %bb.4:                                ;   in Loop: Header=BB34_3 Depth=1
	LSH R6, R5, R9
.LBB34_5:                               ;   in Loop: Header=BB34_3 Depth=1
	SLT ADD R4, R0, R10
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB34_7)
	SLT ADI R15, %lo(.LBB34_7)
	BRH C, R15
; %bb.6:                                ;   in Loop: Header=BB34_3 Depth=1
	SLT ADD R2, R0, R10
	H LDI R15, %hi(.LBB34_7)
	SLT ADI R15, %lo(.LBB34_7)
	JMP R15
.LBB34_1:
	SLT ADD R4, R0, R3
.LBB34_8:
	SLT ADD R3, R0, R1
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -16
	RET
.Lfunc_end34:
	.size	__udivsi3, .Lfunc_end34-__udivsi3
                                        ; -- End function
	.globl	__umodsi3                       ; -- Begin function __umodsi3
	.type	__umodsi3,@function
__umodsi3:                              ; @__umodsi3
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R1, R0, R3
	LDI R1, 0
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB35_66)
	SLT ADI R15, %lo(.LBB35_66)
	BRH EQ, R15
; %bb.1:
	LDI R4, 31
	RSH R3, R4, R4
	SLT ADD R1, R0, R5
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB35_3)
	SLT ADI R15, %lo(.LBB35_3)
	BRH C, R15
; %bb.2:
	SLT ADD R2, R0, R5
.LBB35_3:
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
	H LDI R15, %hi(.LBB35_5)
	SLT ADI R15, %lo(.LBB35_5)
	BRH C, R15
; %bb.4:
	SLT ADD R2, R0, R6
.LBB35_5:
	SUB R5, R6, R5
	LDI R6, 29
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_7)
	SLT ADI R15, %lo(.LBB35_7)
	BRH C, R15
; %bb.6:
	SLT ADD R2, R0, R6
.LBB35_7:
	SUB R5, R6, R5
	LDI R6, 28
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_9)
	SLT ADI R15, %lo(.LBB35_9)
	BRH C, R15
; %bb.8:
	SLT ADD R2, R0, R6
.LBB35_9:
	SUB R5, R6, R5
	LDI R6, 27
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_11)
	SLT ADI R15, %lo(.LBB35_11)
	BRH C, R15
; %bb.10:
	SLT ADD R2, R0, R6
.LBB35_11:
	SUB R5, R6, R5
	LDI R6, 26
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_13)
	SLT ADI R15, %lo(.LBB35_13)
	BRH C, R15
; %bb.12:
	SLT ADD R2, R0, R6
.LBB35_13:
	SUB R5, R6, R5
	LDI R6, 25
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_15)
	SLT ADI R15, %lo(.LBB35_15)
	BRH C, R15
; %bb.14:
	SLT ADD R2, R0, R6
.LBB35_15:
	SUB R5, R6, R5
	LDI R6, 24
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_17)
	SLT ADI R15, %lo(.LBB35_17)
	BRH C, R15
; %bb.16:
	SLT ADD R2, R0, R6
.LBB35_17:
	SUB R5, R6, R5
	LDI R6, 23
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_19)
	SLT ADI R15, %lo(.LBB35_19)
	BRH C, R15
; %bb.18:
	SLT ADD R2, R0, R6
.LBB35_19:
	SUB R5, R6, R5
	LDI R6, 22
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_21)
	SLT ADI R15, %lo(.LBB35_21)
	BRH C, R15
; %bb.20:
	SLT ADD R2, R0, R6
.LBB35_21:
	SUB R5, R6, R5
	LDI R6, 21
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_23)
	SLT ADI R15, %lo(.LBB35_23)
	BRH C, R15
; %bb.22:
	SLT ADD R2, R0, R6
.LBB35_23:
	SUB R5, R6, R5
	LDI R6, 20
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_25)
	SLT ADI R15, %lo(.LBB35_25)
	BRH C, R15
; %bb.24:
	SLT ADD R2, R0, R6
.LBB35_25:
	SUB R5, R6, R5
	LDI R6, 19
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_27)
	SLT ADI R15, %lo(.LBB35_27)
	BRH C, R15
; %bb.26:
	SLT ADD R2, R0, R6
.LBB35_27:
	SUB R5, R6, R5
	LDI R6, 18
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_29)
	SLT ADI R15, %lo(.LBB35_29)
	BRH C, R15
; %bb.28:
	SLT ADD R2, R0, R6
.LBB35_29:
	SUB R5, R6, R5
	LDI R6, 17
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_31)
	SLT ADI R15, %lo(.LBB35_31)
	BRH C, R15
; %bb.30:
	SLT ADD R2, R0, R6
.LBB35_31:
	SUB R5, R6, R5
	LDI R6, 16
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_33)
	SLT ADI R15, %lo(.LBB35_33)
	BRH C, R15
; %bb.32:
	SLT ADD R2, R0, R6
.LBB35_33:
	SUB R5, R6, R5
	LDI R6, 15
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_35)
	SLT ADI R15, %lo(.LBB35_35)
	BRH C, R15
; %bb.34:
	SLT ADD R2, R0, R6
.LBB35_35:
	SUB R5, R6, R5
	LDI R6, 14
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_37)
	SLT ADI R15, %lo(.LBB35_37)
	BRH C, R15
; %bb.36:
	SLT ADD R2, R0, R6
.LBB35_37:
	SUB R5, R6, R5
	LDI R6, 13
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_39)
	SLT ADI R15, %lo(.LBB35_39)
	BRH C, R15
; %bb.38:
	SLT ADD R2, R0, R6
.LBB35_39:
	SUB R5, R6, R5
	LDI R6, 12
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_41)
	SLT ADI R15, %lo(.LBB35_41)
	BRH C, R15
; %bb.40:
	SLT ADD R2, R0, R6
.LBB35_41:
	SUB R5, R6, R5
	LDI R6, 11
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_43)
	SLT ADI R15, %lo(.LBB35_43)
	BRH C, R15
; %bb.42:
	SLT ADD R2, R0, R6
.LBB35_43:
	SUB R5, R6, R5
	LDI R6, 10
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_45)
	SLT ADI R15, %lo(.LBB35_45)
	BRH C, R15
; %bb.44:
	SLT ADD R2, R0, R6
.LBB35_45:
	SUB R5, R6, R5
	LDI R6, 9
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_47)
	SLT ADI R15, %lo(.LBB35_47)
	BRH C, R15
; %bb.46:
	SLT ADD R2, R0, R6
.LBB35_47:
	SUB R5, R6, R5
	LDI R6, 8
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_49)
	SLT ADI R15, %lo(.LBB35_49)
	BRH C, R15
; %bb.48:
	SLT ADD R2, R0, R6
.LBB35_49:
	SUB R5, R6, R5
	LDI R6, 7
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_51)
	SLT ADI R15, %lo(.LBB35_51)
	BRH C, R15
; %bb.50:
	SLT ADD R2, R0, R6
.LBB35_51:
	SUB R5, R6, R5
	LDI R6, 6
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_53)
	SLT ADI R15, %lo(.LBB35_53)
	BRH C, R15
; %bb.52:
	SLT ADD R2, R0, R6
.LBB35_53:
	SUB R5, R6, R5
	LDI R6, 5
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_55)
	SLT ADI R15, %lo(.LBB35_55)
	BRH C, R15
; %bb.54:
	SLT ADD R2, R0, R6
.LBB35_55:
	SUB R5, R6, R5
	LDI R6, 4
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_57)
	SLT ADI R15, %lo(.LBB35_57)
	BRH C, R15
; %bb.56:
	SLT ADD R2, R0, R6
.LBB35_57:
	SUB R5, R6, R5
	LDI R6, 3
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_59)
	SLT ADI R15, %lo(.LBB35_59)
	BRH C, R15
; %bb.58:
	SLT ADD R2, R0, R6
.LBB35_59:
	SUB R5, R6, R5
	LDI R6, 2
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_61)
	SLT ADI R15, %lo(.LBB35_61)
	BRH C, R15
; %bb.60:
	SLT ADD R2, R0, R6
.LBB35_61:
	SUB R5, R6, R5
	RSH R3, R4, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB35_63)
	SLT ADI R15, %lo(.LBB35_63)
	BRH C, R15
; %bb.62:
	SLT ADD R2, R0, R6
.LBB35_63:
	SUB R5, R6, R5
	AND R3, R4, R3
	LSH R5, R4, R4
	NOR R3, R4, R3
	NOR R3, R3, R3
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB35_65)
	SLT ADI R15, %lo(.LBB35_65)
	BRH C, R15
; %bb.64:
	SLT ADD R2, R0, R1
.LBB35_65:
	SUB R3, R1, R1
.LBB35_66:
	SLT ADI R14, -4
	RET
.Lfunc_end35:
	.size	__umodsi3, .Lfunc_end35-__umodsi3
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
	H LDI R15, %hi(.LBB36_5)
	SLT ADI R15, %lo(.LBB36_5)
	BRH EQ, R15
.LBB36_1:                               ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R5, 0
	CHAR LOD R1, R6, 0
	SUB R6, R3, R0
	H LDI R15, %hi(.LBB36_3)
	SLT ADI R15, %lo(.LBB36_3)
	BRH EQ, R15
; %bb.2:                                ;   in Loop: Header=BB36_1 Depth=1
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB36_3)
	SLT ADI R15, %lo(.LBB36_3)
	BRH NE, R15
; %bb.4:                                ;   in Loop: Header=BB36_1 Depth=1
	ADI R2, 1
	ADI R1, 1
	AND R1, R4, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB36_1)
	SLT ADI R15, %lo(.LBB36_1)
	BRH NE, R15
.LBB36_5:
	LDI R7, 8
	LDI R8, 0
	H LDI R8, 257
	SLT ADI R8, 256
	LDI R9, 0
	H LDI R9, 32897
	SLT ADI R9, -32640
	LDI R4, 255
	H LDI R15, %hi(.LBB36_6)
	SLT ADI R15, %lo(.LBB36_6)
	JMP R15
.LBB36_19:                              ;   in Loop: Header=BB36_6 Depth=1
	ADI R2, 4
	ADI R1, 4
.LBB36_6:                               ; =>This Inner Loop Header: Depth=1
	INT LOD R1, R10, 0
	INT LOD R2, R13, 0
	SUB R8, R10, R11
	NOR R11, R10, R11
	NOR R11, R11, R11
	AND R11, R9, R11
	SUB R11, R9, R0
	H LDI R15, %hi(.LBB36_8)
	SLT ADI R15, %lo(.LBB36_8)
	BRH NE, R15
; %bb.7:                                ;   in Loop: Header=BB36_6 Depth=1
	SUB R10, R13, R0
	H LDI R15, %hi(.LBB36_19)
	SLT ADI R15, %lo(.LBB36_19)
	BRH EQ, R15
.LBB36_8:                               ;   in Loop: Header=BB36_6 Depth=1
	AND R10, R4, R11
	SUB R11, R3, R0
	H LDI R15, %hi(.LBB36_9)
	SLT ADI R15, %lo(.LBB36_9)
	BRH EQ, R15
; %bb.10:                               ;   in Loop: Header=BB36_6 Depth=1
	AND R13, R4, R5
	AND R10, R4, R6
	SLT ADD R10, R0, R11
	SLT ADD R13, R0, R12
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB36_17)
	SLT ADI R15, %lo(.LBB36_17)
	BRH NE, R15
; %bb.11:                               ;   in Loop: Header=BB36_6 Depth=1
	RSH R13, R7, R12
	RSH R10, R7, R11
	AND R11, R4, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB36_17)
	SLT ADI R15, %lo(.LBB36_17)
	BRH EQ, R15
; %bb.12:                               ;   in Loop: Header=BB36_6 Depth=1
	AND R12, R4, R5
	AND R11, R4, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB36_17)
	SLT ADI R15, %lo(.LBB36_17)
	BRH NE, R15
; %bb.13:                               ;   in Loop: Header=BB36_6 Depth=1
	LDI R5, 16
	RSH R13, R5, R12
	RSH R10, R5, R11
	AND R11, R4, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB36_17)
	SLT ADI R15, %lo(.LBB36_17)
	BRH EQ, R15
; %bb.14:                               ;   in Loop: Header=BB36_6 Depth=1
	AND R12, R4, R5
	AND R11, R4, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB36_17)
	SLT ADI R15, %lo(.LBB36_17)
	BRH NE, R15
; %bb.15:                               ;   in Loop: Header=BB36_6 Depth=1
	LDI R5, 24
	RSH R13, R5, R12
	RSH R10, R5, R11
	SUB R11, R3, R0
	H LDI R15, %hi(.LBB36_17)
	SLT ADI R15, %lo(.LBB36_17)
	BRH EQ, R15
; %bb.16:                               ;   in Loop: Header=BB36_6 Depth=1
	SUB R11, R12, R0
	H LDI R15, %hi(.LBB36_19)
	SLT ADI R15, %lo(.LBB36_19)
	BRH EQ, R15
	H LDI R15, %hi(.LBB36_17)
	SLT ADI R15, %lo(.LBB36_17)
	JMP R15
.LBB36_3:
	SUB R6, R5, R1
	H LDI R15, %hi(.LBB36_18)
	SLT ADI R15, %lo(.LBB36_18)
	JMP R15
.LBB36_9:
	SLT ADD R10, R0, R11
	SLT ADD R13, R0, R12
.LBB36_17:
	AND R12, R4, R1
	AND R11, R4, R2
	SUB R2, R1, R1
.LBB36_18:
	INT LOD R14, R13, -24
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -28
	RET
.Lfunc_end36:
	.size	strcmp, .Lfunc_end36-strcmp
                                        ; -- End function
	.globl	strlen                          ; -- Begin function strlen
	.type	strlen,@function
strlen:                                 ; @strlen
; %bb.0:
	SLT ADI R14, 4
	LDI R4, 3
	AND R1, R4, R5
	LDI R3, 0
	SLT ADD R1, R0, R2
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB37_6)
	SLT ADI R15, %lo(.LBB37_6)
	BRH EQ, R15
; %bb.1:
	CHAR LOD R1, R2, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB37_2)
	SLT ADI R15, %lo(.LBB37_2)
	BRH EQ, R15
; %bb.4:                                ; %.preheader
	SLT ADD R1, R0, R5
	ADI R5, 1
.LBB37_5:                               ; =>This Inner Loop Header: Depth=1
	SLT ADD R5, R0, R2
	AND R2, R4, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB37_6)
	SLT ADI R15, %lo(.LBB37_6)
	BRH EQ, R15
; %bb.3:                                ;   in Loop: Header=BB37_5 Depth=1
	SLT ADD R2, R0, R5
	ADI R5, 1
	CHAR LOD R2, R6, 0
	SUB R6, R3, R0
	H LDI R15, %hi(.LBB37_5)
	SLT ADI R15, %lo(.LBB37_5)
	BRH NE, R15
	H LDI R15, %hi(.LBB37_14)
	SLT ADI R15, %lo(.LBB37_14)
	JMP R15
.LBB37_6:
	ADI R2, -2
	LDI R5, 0
	H LDI R5, 257
	SLT ADI R5, 256
	LDI R6, 0
	H LDI R6, 32897
	SLT ADI R6, -32640
.LBB37_7:                               ; =>This Inner Loop Header: Depth=1
	INT LOD R2, R4, 2
	ADI R2, 4
	SUB R5, R4, R7
	NOR R7, R4, R7
	NOR R7, R7, R7
	AND R7, R6, R7
	SUB R7, R6, R0
	H LDI R15, %hi(.LBB37_7)
	SLT ADI R15, %lo(.LBB37_7)
	BRH EQ, R15
; %bb.8:
	LDI R5, 255
	AND R4, R5, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB37_9)
	SLT ADI R15, %lo(.LBB37_9)
	BRH EQ, R15
; %bb.10:
	LDI R5, 0
	H LDI R5, 1
	SLT ADI R5, -256
	AND R4, R5, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB37_11)
	SLT ADI R15, %lo(.LBB37_11)
	BRH EQ, R15
; %bb.12:
	LDI R5, 0
	H LDI R5, 255
	SLT ADI R5, 0
	AND R4, R5, R4
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB37_14)
	SLT ADI R15, %lo(.LBB37_14)
	BRH EQ, R15
; %bb.13:
	ADI R2, 1
	H LDI R15, %hi(.LBB37_14)
	SLT ADI R15, %lo(.LBB37_14)
	JMP R15
.LBB37_2:
	SLT ADD R1, R0, R2
	H LDI R15, %hi(.LBB37_14)
	SLT ADI R15, %lo(.LBB37_14)
	JMP R15
.LBB37_9:
	ADI R2, -2
	H LDI R15, %hi(.LBB37_14)
	SLT ADI R15, %lo(.LBB37_14)
	JMP R15
.LBB37_11:
	ADI R2, -1
.LBB37_14:
	SUB R2, R1, R1
	SLT ADI R14, -4
	RET
.Lfunc_end37:
	.size	strlen, .Lfunc_end37-strlen
                                        ; -- End function
	.globl	memcmp                          ; -- Begin function memcmp
	.type	memcmp,@function
memcmp:                                 ; @memcmp
; %bb.0:
	SLT ADI R14, 4
	SLT ADD R1, R0, R4
	LDI R1, 0
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB38_4)
	SLT ADI R15, %lo(.LBB38_4)
	BRH EQ, R15
.LBB38_2:                               ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R5, 0
	CHAR LOD R4, R6, 0
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB38_3)
	SLT ADI R15, %lo(.LBB38_3)
	BRH NE, R15
; %bb.1:                                ;   in Loop: Header=BB38_2 Depth=1
	ADI R4, 1
	ADI R2, 1
	ADI R3, -1
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB38_2)
	SLT ADI R15, %lo(.LBB38_2)
	BRH NE, R15
	H LDI R15, %hi(.LBB38_4)
	SLT ADI R15, %lo(.LBB38_4)
	JMP R15
.LBB38_3:
	SUB R6, R5, R1
.LBB38_4:
	SLT ADI R14, -4
	RET
.Lfunc_end38:
	.size	memcmp, .Lfunc_end38-memcmp
                                        ; -- End function
	.globl	strncpy                         ; -- Begin function strncpy
	.type	strncpy,@function
strncpy:                                ; @strncpy
; %bb.0:
	SLT ADI R14, 28
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	INT STR R14, R13, -24
	LDI R4, 0
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB39_28)
	SLT ADI R15, %lo(.LBB39_28)
	BRH EQ, R15
; %bb.1:                                ; %.preheader8
	LDI R6, 3
	SLT ADD R4, R0, R8
.LBB39_2:                               ; =>This Inner Loop Header: Depth=1
	ADD R1, R8, R5
	AND R5, R6, R9
	ADD R2, R8, R7
	SUB R9, R4, R0
	H LDI R15, %hi(.LBB39_5)
	SLT ADI R15, %lo(.LBB39_5)
	BRH EQ, R15
; %bb.3:                                ;   in Loop: Header=BB39_2 Depth=1
	CHAR LOD R7, R7, 0
	CHAR STR R5, R7, 0
	SUB R7, R4, R0
	H LDI R15, %hi(.LBB39_15)
	SLT ADI R15, %lo(.LBB39_15)
	BRH EQ, R15
; %bb.4:                                ;   in Loop: Header=BB39_2 Depth=1
	ADI R8, 1
	SUB R3, R8, R0
	H LDI R15, %hi(.LBB39_2)
	SLT ADI R15, %lo(.LBB39_2)
	BRH NE, R15
	H LDI R15, %hi(.LBB39_28)
	SLT ADI R15, %lo(.LBB39_28)
	JMP R15
.LBB39_5:
	SUB R3, R8, R3
	AND R7, R6, R9
	SUB R9, R4, R0
	H LDI R15, %hi(.LBB39_12)
	SLT ADI R15, %lo(.LBB39_12)
	BRH NE, R15
; %bb.6:
	LDI R9, 4
	SUB R3, R9, R0
	H LDI R15, %hi(.LBB39_12)
	SLT ADI R15, %lo(.LBB39_12)
	BRH C, R15
; %bb.7:                                ; %.preheader6
	LDI R9, 0
	LDI R11, 0
	H LDI R11, 257
	SLT ADI R11, 256
	LDI R12, 0
	H LDI R12, 32897
	SLT ADI R12, -32640
.LBB39_8:                               ; =>This Inner Loop Header: Depth=1
	ADD R2, R9, R13
	ADD R13, R8, R13
	INT LOD R13, R13, 0
	SUB R11, R13, R10
	NOR R10, R13, R10
	NOR R10, R10, R10
	AND R10, R12, R10
	SUB R10, R12, R0
	H LDI R15, %hi(.LBB39_11)
	SLT ADI R15, %lo(.LBB39_11)
	BRH NE, R15
; %bb.9:                                ;   in Loop: Header=BB39_8 Depth=1
	ADD R1, R9, R10
	ADD R10, R8, R10
	INT STR R10, R13, 0
	ADI R9, 4
	ADI R3, -4
	SUB R6, R3, R0
	H LDI R15, %hi(.LBB39_8)
	SLT ADI R15, %lo(.LBB39_8)
	BRH C, R15
; %bb.10:
	LDI R2, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB39_28)
	SLT ADI R15, %lo(.LBB39_28)
	BRH EQ, R15
.LBB39_11:                              ; %.loopexit7
	ADD R7, R9, R7
	ADD R5, R9, R5
.LBB39_12:
	ADI R5, 1
.LBB39_13:                              ; =>This Inner Loop Header: Depth=1
	CHAR LOD R7, R2, 0
	CHAR STR R5, R2, -1
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB39_16)
	SLT ADI R15, %lo(.LBB39_16)
	BRH EQ, R15
; %bb.14:                               ;   in Loop: Header=BB39_13 Depth=1
	ADI R5, 1
	ADI R7, 1
	ADI R3, -1
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB39_13)
	SLT ADI R15, %lo(.LBB39_13)
	BRH NE, R15
	H LDI R15, %hi(.LBB39_28)
	SLT ADI R15, %lo(.LBB39_28)
	JMP R15
.LBB39_15:                              ; %.loopexit9
	SUB R3, R8, R3
	ADI R5, 1
.LBB39_16:
	ADI R3, -1
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB39_28)
	SLT ADI R15, %lo(.LBB39_28)
	BRH EQ, R15
; %bb.17:
	AND R5, R6, R2
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB39_20)
	SLT ADI R15, %lo(.LBB39_20)
	BRH EQ, R15
; %bb.18:
	LDI R2, 1
.LBB39_19:                              ; =>This Inner Loop Header: Depth=1
	SLT ADD R3, R0, R7
	ADI R3, -1
	CHAR STR R5, R4, 0
	ADI R5, 1
	AND R5, R6, R8
	SUB R8, R4, R0
	H LDI R15, %hi(.LBB39_20)
	SLT ADI R15, %lo(.LBB39_20)
	BRH EQ, R15
; %bb.29:                               ;   in Loop: Header=BB39_19 Depth=1
	SUB R7, R2, R0
	H LDI R15, %hi(.LBB39_19)
	SLT ADI R15, %lo(.LBB39_19)
	BRH NE, R15
.LBB39_20:
	LDI R2, 4
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB39_25)
	SLT ADI R15, %lo(.LBB39_25)
	BRH C, R15
; %bb.21:
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -4
	AND R3, R2, R2
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB39_24)
	SLT ADI R15, %lo(.LBB39_24)
	BRH EQ, R15
; %bb.22:                               ; %dynamic-memset-expansion-main-body.preheader
	SLT ADD R4, R0, R7
.LBB39_23:                              ; %dynamic-memset-expansion-main-body
                                        ; =>This Inner Loop Header: Depth=1
	ADD R5, R7, R8
	CHAR STR R8, R4, 0
	ADI R7, 1
	SUB R7, R2, R0
	H LDI R15, %hi(.LBB39_23)
	SLT ADI R15, %lo(.LBB39_23)
	BRH C, R15
.LBB39_24:                              ; %dynamic-memset-post-expansion
	AND R3, R6, R3
	ADD R5, R2, R5
.LBB39_25:
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB39_28)
	SLT ADI R15, %lo(.LBB39_28)
	BRH EQ, R15
; %bb.26:                               ; %dynamic-memset-expansion-main-body2.preheader
	SLT ADD R4, R0, R2
.LBB39_27:                              ; %dynamic-memset-expansion-main-body2
                                        ; =>This Inner Loop Header: Depth=1
	ADD R5, R2, R6
	CHAR STR R6, R4, 0
	ADI R2, 1
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB39_27)
	SLT ADI R15, %lo(.LBB39_27)
	BRH C, R15
.LBB39_28:
	INT LOD R14, R13, -24
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -28
	RET
.Lfunc_end39:
	.size	strncpy, .Lfunc_end39-strncpy
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
	H LDI R15, %hi(.LBB40_2)
	SLT ADI R15, %lo(.LBB40_2)
	BRH EQ, R15
; %bb.1:
	LDI R4, 0
	H LDI R4, strtok.last_token
	SLT ADI R4, strtok.last_token
	INT STR R4, R3, 0
	H LDI R15, %hi(.LBB40_3)
	SLT ADI R15, %lo(.LBB40_3)
	JMP R15
.LBB40_2:
	LDI R3, 0
	H LDI R3, strtok.last_token
	SLT ADI R3, strtok.last_token
	INT LOD R3, R3, 0
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB40_14)
	SLT ADI R15, %lo(.LBB40_14)
	BRH EQ, R15
.LBB40_3:
	CHAR LOD R3, R5, 0
	SUB R5, R1, R0
	H LDI R15, %hi(.LBB40_14)
	SLT ADI R15, %lo(.LBB40_14)
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
	LDI R6, 31
	LDI R7, 3
	LDI R8, 28
	LDI R9, 1
	SUB R10, R1, R0
	H LDI R15, %hi(.LBB40_7)
	SLT ADI R15, %lo(.LBB40_7)
	BRH EQ, R15
; %bb.5:                                ; %.preheader2
	ADI R2, 1
.LBB40_6:                               ; =>This Inner Loop Header: Depth=1
	AND R10, R6, R11
	LSH R9, R11, R11
	RSH R10, R7, R10
	AND R10, R8, R10
	ADD R4, R10, R10
	INT LOD R10, R12, 0
	NOR R12, R11, R11
	NOR R11, R11, R11
	INT STR R10, R11, 0
	CHAR LOD R2, R10, 0
	ADI R2, 1
	SUB R10, R1, R0
	H LDI R15, %hi(.LBB40_6)
	SLT ADI R15, %lo(.LBB40_6)
	BRH NE, R15
.LBB40_7:
	ADI R3, 1
	LDI R2, 0
	H LDI R2, strtok.last_token
	SLT ADI R2, strtok.last_token
.LBB40_8:                               ; =>This Inner Loop Header: Depth=1
	AND R5, R6, R10
	RSH R5, R7, R11
	AND R11, R8, R11
	ADD R4, R11, R11
	INT LOD R11, R11, 0
	RSH R11, R10, R10
	AND R10, R9, R10
	SUB R10, R1, R0
	H LDI R15, %hi(.LBB40_9)
	SLT ADI R15, %lo(.LBB40_9)
	BRH EQ, R15
; %bb.15:                               ;   in Loop: Header=BB40_8 Depth=1
	INT STR R2, R3, 0
	CHAR LOD R3, R5, 0
	ADI R3, 1
	SUB R5, R1, R0
	H LDI R15, %hi(.LBB40_8)
	SLT ADI R15, %lo(.LBB40_8)
	BRH NE, R15
	H LDI R15, %hi(.LBB40_14)
	SLT ADI R15, %lo(.LBB40_14)
	JMP R15
.LBB40_9:                               ; %.preheader
	SLT ADD R3, R0, R2
	ADI R2, -1
	LDI R10, 0
	H LDI R10, strtok.last_token
	SLT ADI R10, strtok.last_token
.LBB40_10:                              ; =>This Inner Loop Header: Depth=1
	AND R5, R6, R11
	RSH R5, R7, R5
	AND R5, R8, R5
	ADD R4, R5, R5
	INT LOD R5, R5, 0
	RSH R5, R11, R5
	AND R5, R9, R5
	SUB R5, R1, R0
	H LDI R15, %hi(.LBB40_11)
	SLT ADI R15, %lo(.LBB40_11)
	BRH NE, R15
; %bb.12:                               ;   in Loop: Header=BB40_10 Depth=1
	INT STR R10, R3, 0
	CHAR LOD R3, R5, 0
	ADI R3, 1
	SUB R5, R1, R0
	H LDI R15, %hi(.LBB40_10)
	SLT ADI R15, %lo(.LBB40_10)
	BRH NE, R15
	H LDI R15, %hi(.LBB40_13)
	SLT ADI R15, %lo(.LBB40_13)
	JMP R15
.LBB40_11:
	CHAR STR R3, R1, -1
	LDI R1, 0
	H LDI R1, strtok.last_token
	SLT ADI R1, strtok.last_token
	INT STR R1, R3, 0
.LBB40_13:
	SLT ADD R2, R0, R1
.LBB40_14:
	INT LOD R14, R12, -52
	INT LOD R14, R11, -48
	INT LOD R14, R10, -44
	INT LOD R14, R9, -40
	INT LOD R14, R8, -36
	SLT ADI R14, -56
	RET
.Lfunc_end40:
	.size	strtok, .Lfunc_end40-strtok
                                        ; -- End function
	.globl	help                            ; -- Begin function help
	.type	help,@function
help:                                   ; @help
; %bb.0:
	SLT ADI R14, 24
	INT STR R14, R8, -12
	INT STR R14, R9, -16
	INT STR R14, R10, -20
	LDI R1, 5
	LDI R10, 0
	H LDI R10, page_size
	SLT ADI R10, page_size
	INT STR R10, R1, 0
	LDI R8, 0
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
	H LDI R1, tabla_comandos
	SLT ADI R1, tabla_comandos
	INT LOD R1, R1, 0
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
	INT LOD R10, R1, 0
	LDI R2, 1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB41_3)
	SLT ADI R15, %lo(.LBB41_3)
	BRH NE, R15
; %bb.1:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.18
	SLT ADI R1, .L.str.18
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADD R14, R0, R9
	SLT ADI R9, -8
	LDI R2, 8
	SLT ADD R9, R0, R1
	H LDI R15, %hi(readInput)
	SLT ADI R15, %lo(readInput)
	CAL R15
	CHAR LOD R9, R1, 0
	LDI R2, 223
	AND R1, R2, R1
	LDI R2, 81
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB41_22)
	SLT ADI R15, %lo(.LBB41_22)
	BRH EQ, R15
; %bb.2:
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.8
	SLT ADI R1, .L.str.8
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB41_3:
	LDI R1, 0
	H LDI R1, .L.str.9
	SLT ADI R1, .L.str.9
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, tabla_comandos+8
	SLT ADI R1, tabla_comandos+8
	INT LOD R1, R1, 0
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
	INT LOD R10, R2, 0
	LDI R1, 2
	H LDI R15, %hi(__umodsi3)
	SLT ADI R15, %lo(__umodsi3)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB41_6)
	SLT ADI R15, %lo(.LBB41_6)
	BRH NE, R15
; %bb.4:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.18
	SLT ADI R1, .L.str.18
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADD R14, R0, R9
	SLT ADI R9, -8
	LDI R2, 8
	SLT ADD R9, R0, R1
	H LDI R15, %hi(readInput)
	SLT ADI R15, %lo(readInput)
	CAL R15
	CHAR LOD R9, R1, 0
	LDI R2, 223
	AND R1, R2, R1
	LDI R2, 81
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB41_22)
	SLT ADI R15, %lo(.LBB41_22)
	BRH EQ, R15
; %bb.5:
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.8
	SLT ADI R1, .L.str.8
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB41_6:
	LDI R1, 0
	H LDI R1, .L.str.9
	SLT ADI R1, .L.str.9
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, tabla_comandos+16
	SLT ADI R1, tabla_comandos+16
	INT LOD R1, R1, 0
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
	LDI R10, 0
	H LDI R10, page_size
	SLT ADI R10, page_size
	INT LOD R10, R2, 0
	LDI R1, 3
	H LDI R15, %hi(__umodsi3)
	SLT ADI R15, %lo(__umodsi3)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB41_9)
	SLT ADI R15, %lo(.LBB41_9)
	BRH NE, R15
; %bb.7:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.18
	SLT ADI R1, .L.str.18
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADD R14, R0, R9
	SLT ADI R9, -8
	LDI R2, 8
	SLT ADD R9, R0, R1
	H LDI R15, %hi(readInput)
	SLT ADI R15, %lo(readInput)
	CAL R15
	CHAR LOD R9, R1, 0
	LDI R2, 223
	AND R1, R2, R1
	LDI R2, 81
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB41_22)
	SLT ADI R15, %lo(.LBB41_22)
	BRH EQ, R15
; %bb.8:
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.8
	SLT ADI R1, .L.str.8
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB41_9:
	LDI R1, 0
	H LDI R1, .L.str.9
	SLT ADI R1, .L.str.9
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, tabla_comandos+24
	SLT ADI R1, tabla_comandos+24
	INT LOD R1, R1, 0
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
	INT LOD R10, R2, 0
	LDI R1, 4
	H LDI R15, %hi(__umodsi3)
	SLT ADI R15, %lo(__umodsi3)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB41_12)
	SLT ADI R15, %lo(.LBB41_12)
	BRH NE, R15
; %bb.10:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.18
	SLT ADI R1, .L.str.18
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADD R14, R0, R9
	SLT ADI R9, -8
	LDI R2, 8
	SLT ADD R9, R0, R1
	H LDI R15, %hi(readInput)
	SLT ADI R15, %lo(readInput)
	CAL R15
	CHAR LOD R9, R1, 0
	LDI R2, 223
	AND R1, R2, R1
	LDI R2, 81
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB41_22)
	SLT ADI R15, %lo(.LBB41_22)
	BRH EQ, R15
; %bb.11:
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.8
	SLT ADI R1, .L.str.8
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB41_12:
	LDI R1, 0
	H LDI R1, .L.str.9
	SLT ADI R1, .L.str.9
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, tabla_comandos+32
	SLT ADI R1, tabla_comandos+32
	INT LOD R1, R1, 0
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
	LDI R10, 0
	H LDI R10, page_size
	SLT ADI R10, page_size
	INT LOD R10, R2, 0
	LDI R1, 5
	H LDI R15, %hi(__umodsi3)
	SLT ADI R15, %lo(__umodsi3)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB41_15)
	SLT ADI R15, %lo(.LBB41_15)
	BRH NE, R15
; %bb.13:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.18
	SLT ADI R1, .L.str.18
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADD R14, R0, R9
	SLT ADI R9, -8
	LDI R2, 8
	SLT ADD R9, R0, R1
	H LDI R15, %hi(readInput)
	SLT ADI R15, %lo(readInput)
	CAL R15
	CHAR LOD R9, R1, 0
	LDI R2, 223
	AND R1, R2, R1
	LDI R2, 81
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB41_22)
	SLT ADI R15, %lo(.LBB41_22)
	BRH EQ, R15
; %bb.14:
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.8
	SLT ADI R1, .L.str.8
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB41_15:
	LDI R1, 0
	H LDI R1, .L.str.9
	SLT ADI R1, .L.str.9
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, tabla_comandos+40
	SLT ADI R1, tabla_comandos+40
	INT LOD R1, R1, 0
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
	INT LOD R10, R2, 0
	LDI R1, 6
	H LDI R15, %hi(__umodsi3)
	SLT ADI R15, %lo(__umodsi3)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB41_18)
	SLT ADI R15, %lo(.LBB41_18)
	BRH NE, R15
; %bb.16:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.18
	SLT ADI R1, .L.str.18
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADD R14, R0, R9
	SLT ADI R9, -8
	LDI R2, 8
	SLT ADD R9, R0, R1
	H LDI R15, %hi(readInput)
	SLT ADI R15, %lo(readInput)
	CAL R15
	CHAR LOD R9, R1, 0
	LDI R2, 223
	AND R1, R2, R1
	LDI R2, 81
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB41_22)
	SLT ADI R15, %lo(.LBB41_22)
	BRH EQ, R15
; %bb.17:
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.8
	SLT ADI R1, .L.str.8
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB41_18:
	LDI R1, 0
	H LDI R1, .L.str.9
	SLT ADI R1, .L.str.9
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, tabla_comandos+48
	SLT ADI R1, tabla_comandos+48
	INT LOD R1, R1, 0
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
	H LDI R1, page_size
	SLT ADI R1, page_size
	INT LOD R1, R2, 0
	LDI R1, 7
	H LDI R15, %hi(__umodsi3)
	SLT ADI R15, %lo(__umodsi3)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB41_21)
	SLT ADI R15, %lo(.LBB41_21)
	BRH NE, R15
; %bb.19:
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.18
	SLT ADI R1, .L.str.18
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
	H LDI R15, %hi(.LBB41_22)
	SLT ADI R15, %lo(.LBB41_22)
	BRH EQ, R15
; %bb.20:
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.8
	SLT ADI R1, .L.str.8
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB41_21:
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.9
	SLT ADI R1, .L.str.9
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, tabla_comandos+56
	SLT ADI R1, tabla_comandos+56
	INT LOD R1, R1, 0
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
.LBB41_22:
	INT LOD R14, R10, -20
	INT LOD R14, R9, -16
	INT LOD R14, R8, -12
	SLT ADI R14, -24
	RET
.Lfunc_end41:
	.size	help, .Lfunc_end41-help
                                        ; -- End function
	.globl	sysOff                          ; -- Begin function sysOff
	.type	sysOff,@function
sysOff:                                 ; @sysOff
; %bb.0:
	SLT ADI R14, 4
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.11
	SLT ADI R1, .L.str.11
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
.Lfunc_end42:
	.size	sysOff, .Lfunc_end42-sysOff
                                        ; -- End function
	.globl	reset                           ; -- Begin function reset
	.type	reset,@function
reset:                                  ; @reset
; %bb.0:
	SLT ADI R14, 4
	H LDI R15, %hi(main)
	SLT ADI R15, %lo(main)
	CAL R15
	SLT ADI R14, -4
	RET
.Lfunc_end43:
	.size	reset, .Lfunc_end43-reset
                                        ; -- End function
	.globl	initSO                          ; -- Begin function initSO
	.type	initSO,@function
initSO:                                 ; @initSO
; %bb.0:
	SLT ADI R14, 4
	SLT ADI R14, -4
	RET
.Lfunc_end44:
	.size	initSO, .Lfunc_end44-initSO
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
	LDI R1, 3
	LDI R2, 0
	H LDI R2, page_size
	SLT ADI R2, page_size
	INT STR R2, R1, 0
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.12
	SLT ADI R1, .L.str.12
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R9, 0
	H LDI R9, map_size
	SLT ADI R9, map_size
	INT LOD R9, R1, 0
	SLT ADD R8, R0, R2
	H LDI R15, %hi(ToAscii)
	SLT ADI R15, %lo(ToAscii)
	CAL R15
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
	H LDI R1, .L.str.14.69
	SLT ADI R1, .L.str.14.69
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
	INT LOD R9, R1, 0
	LDI R13, 1
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB45_11)
	SLT ADI R15, %lo(.LBB45_11)
	BRH N, R15
; %bb.1:                                ; %.preheader1
	LDI R11, 20
	ADD R14, R0, R10
	INT STR R14, R10, -4
	SLT ADI R10, -8
	SLT ADD R8, R0, R9
.LBB45_2:                               ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB45_4 Depth 2
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
	H LDI R15, %hi(.LBB45_7)
	SLT ADI R15, %lo(.LBB45_7)
	BRH N, R15
; %bb.3:                                ; %.preheader
                                        ;   in Loop: Header=BB45_2 Depth=1
	ADI R12, -13
	H LDI R15, %hi(.LBB45_4)
	SLT ADI R15, %lo(.LBB45_4)
	JMP R15
.LBB45_6:                               ;   in Loop: Header=BB45_4 Depth=2
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB45_7)
	SLT ADI R15, %lo(.LBB45_7)
	BRH EQ, R15
.LBB45_4:                               ;   Parent Loop BB45_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	SLT ADD R10, R0, R1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADI R12, 1
	SLT ADD R13, R0, R1
	SUB R12, R8, R0
	H LDI R15, %hi(.LBB45_6)
	SLT ADI R15, %lo(.LBB45_6)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB45_4 Depth=2
	SLT ADD R8, R0, R1
	H LDI R15, %hi(.LBB45_6)
	SLT ADI R15, %lo(.LBB45_6)
	JMP R15
.LBB45_7:                               ;   in Loop: Header=BB45_2 Depth=1
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
	H LDI R1, .L.str.10
	SLT ADI R1, .L.str.10
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADI R9, 1
	LDI R1, 0
	H LDI R1, map_size
	SLT ADI R1, map_size
	INT LOD R1, R1, 0
	SUB R9, R1, R0
	H LDI R15, %hi(.LBB45_11)
	SLT ADI R15, %lo(.LBB45_11)
	BRH NN, R15
; %bb.8:                                ;   in Loop: Header=BB45_2 Depth=1
	LDI R1, 0
	H LDI R1, page_size
	SLT ADI R1, page_size
	INT LOD R1, R1, 0
	DIV R9, R1, R1
	GOF R2
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB45_2)
	SLT ADI R15, %lo(.LBB45_2)
	BRH NE, R15
; %bb.9:                                ;   in Loop: Header=BB45_2 Depth=1
	LDI R1, 0
	H LDI R1, .L.str.18
	SLT ADI R1, .L.str.18
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
	H LDI R15, %hi(.LBB45_11)
	SLT ADI R15, %lo(.LBB45_11)
	BRH EQ, R15
; %bb.10:                               ;   in Loop: Header=BB45_2 Depth=1
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.14.69
	SLT ADI R1, .L.str.14.69
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
	H LDI R1, map_size
	SLT ADI R1, map_size
	INT LOD R1, R1, 0
	SUB R9, R1, R0
	H LDI R15, %hi(.LBB45_2)
	SLT ADI R15, %lo(.LBB45_2)
	BRH N, R15
.LBB45_11:
	INT LOD R14, R13, -40
	INT LOD R14, R12, -36
	INT LOD R14, R11, -32
	INT LOD R14, R10, -28
	INT LOD R14, R9, -24
	INT LOD R14, R8, -20
	SLT ADI R14, -44
	RET
.Lfunc_end45:
	.size	enumdisp, .Lfunc_end45-enumdisp
                                        ; -- End function
	.globl	lsboot                          ; -- Begin function lsboot
	.type	lsboot,@function
lsboot:                                 ; @lsboot
; %bb.0:
	SLT ADI R14, 4
	SLT ADI R14, -4
	RET
.Lfunc_end46:
	.size	lsboot, .Lfunc_end46-lsboot
                                        ; -- End function
	.globl	setboot                         ; -- Begin function setboot
	.type	setboot,@function
setboot:                                ; @setboot
; %bb.0:
	SLT ADI R14, 4
	SLT ADI R14, -4
	RET
.Lfunc_end47:
	.size	setboot, .Lfunc_end47-setboot
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
.Lfunc_end48:
	.size	cls, .Lfunc_end48-cls
                                        ; -- End function
	.globl	BiosShell                       ; -- Begin function BiosShell
	.type	BiosShell,@function
BiosShell:                              ; @BiosShell
; %bb.0:
	SLT ADI R14, 56
	INT STR R14, R8, -36
	INT STR R14, R9, -40
	INT STR R14, R10, -44
	INT STR R14, R11, -48
	INT STR R14, R12, -52
	LDI R11, 4
	LDI R8, 0
	ADD R14, R0, R9
	SLT ADI R9, -32
	LDI R10, 32
	H LDI R15, %hi(.LBB49_1)
	SLT ADI R15, %lo(.LBB49_1)
	JMP R15
.LBB49_11:                              ;   in Loop: Header=BB49_1 Depth=1
	INT LOD R12, R1, 4
	CAL R1
.LBB49_1:                               ; =>This Inner Loop Header: Depth=1
	;APP
	CYE SR8, R1
	;NO_APP
	NOR R1, R11, R1
	NOR R1, R1, R1
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R1, .L.str.16.72
	SLT ADI R1, .L.str.16.72
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	SLT ADD R9, R0, R1
	SLT ADD R10, R0, R2
	H LDI R15, %hi(readInput)
	SLT ADI R15, %lo(readInput)
	CAL R15
	LDI R12, 0
	H LDI R12, tabla_comandos
	SLT ADI R12, tabla_comandos
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB49_11)
	SLT ADI R15, %lo(.LBB49_11)
	BRH EQ, R15
; %bb.2:                                ;   in Loop: Header=BB49_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+8
	SLT ADI R12, tabla_comandos+8
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB49_11)
	SLT ADI R15, %lo(.LBB49_11)
	BRH EQ, R15
; %bb.3:                                ;   in Loop: Header=BB49_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+16
	SLT ADI R12, tabla_comandos+16
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB49_11)
	SLT ADI R15, %lo(.LBB49_11)
	BRH EQ, R15
; %bb.4:                                ;   in Loop: Header=BB49_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+24
	SLT ADI R12, tabla_comandos+24
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB49_11)
	SLT ADI R15, %lo(.LBB49_11)
	BRH EQ, R15
; %bb.5:                                ;   in Loop: Header=BB49_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+32
	SLT ADI R12, tabla_comandos+32
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB49_11)
	SLT ADI R15, %lo(.LBB49_11)
	BRH EQ, R15
; %bb.6:                                ;   in Loop: Header=BB49_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+40
	SLT ADI R12, tabla_comandos+40
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB49_11)
	SLT ADI R15, %lo(.LBB49_11)
	BRH EQ, R15
; %bb.7:                                ;   in Loop: Header=BB49_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+48
	SLT ADI R12, tabla_comandos+48
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB49_11)
	SLT ADI R15, %lo(.LBB49_11)
	BRH EQ, R15
; %bb.8:                                ;   in Loop: Header=BB49_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+56
	SLT ADI R12, tabla_comandos+56
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB49_11)
	SLT ADI R15, %lo(.LBB49_11)
	BRH EQ, R15
; %bb.9:                                ;   in Loop: Header=BB49_1 Depth=1
	CHAR LOD R9, R1, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB49_1)
	SLT ADI R15, %lo(.LBB49_1)
	BRH EQ, R15
; %bb.10:                               ;   in Loop: Header=BB49_1 Depth=1
	LDI R1, 0
	H LDI R1, .L.str.17
	SLT ADI R1, .L.str.17
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(.LBB49_1)
	SLT ADI R15, %lo(.LBB49_1)
	JMP R15
.Lfunc_end49:
	.size	BiosShell, .Lfunc_end49-BiosShell
                                        ; -- End function
	.type	.L.str,@object                  ; @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Enumeracion de buses finalizada.\n"
	.size	.L.str, 34

	.type	.L.str.1,@object                ; @.str.1
.L.str.1:
	.asciz	"Hay "
	.size	.L.str.1, 5

	.type	.L.str.2,@object                ; @.str.2
.L.str.2:
	.asciz	" dispositivos conectados.\n\n"
	.size	.L.str.2, 28

	.type	.L.str.3,@object                ; @.str.3
.L.str.3:
	.asciz	"LAPIC e IRQs inicializadas.\n\n"
	.size	.L.str.3, 30

	.type	.L.str.4,@object                ; @.str.4
.L.str.4:
	.asciz	"No se encontraron Memorias secundarias\n"
	.size	.L.str.4, 40

	.type	.L.str.5,@object                ; @.str.5
.L.str.5:
	.asciz	"No hay teclado conectado\n"
	.size	.L.str.5, 26

	.type	line_index,@object              ; @line_index
	.section	.bss,"aw",@nobits
	.globl	line_index
	.p2align	2, 0x0
line_index:
	.long	0                               ; 0x0
	.size	line_index, 4

	.type	line_ready,@object              ; @line_ready
	.globl	line_ready
line_ready:
	.byte	0                               ; 0x0
	.size	line_ready, 1

	.type	kb_registers,@object            ; @kb_registers
	.local	kb_registers
	.comm	kb_registers,4,4
	.type	kq_head,@object                 ; @kq_head
	.local	kq_head
	.comm	kq_head,1,1
	.type	kq_tail,@object                 ; @kq_tail
	.local	kq_tail
	.comm	kq_tail,1,1
	.type	key_queue,@object               ; @key_queue
	.local	key_queue
	.comm	key_queue,64,1
	.type	KeyboardDetected,@object        ; @KeyboardDetected
	.globl	KeyboardDetected
KeyboardDetected:
	.byte	0                               ; 0x0
	.size	KeyboardDetected, 1

	.type	.L.str.6,@object                ; @.str.6
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.6:
	.asciz	"\nIRQs deshabilitadas. Imposible leer datos.\n"
	.size	.L.str.6, 45

	.type	.L.str.1.3,@object              ; @.str.1.3
.L.str.1.3:
	.asciz	"\b"
	.size	.L.str.1.3, 2

	.type	.L.str.2.4,@object              ; @.str.2.4
.L.str.2.4:
	.asciz	"\n"
	.size	.L.str.2.4, 2

	.type	line_buffer,@object             ; @line_buffer
	.section	.bss,"aw",@nobits
	.globl	line_buffer
line_buffer:
	.zero	256
	.size	line_buffer, 256

	.type	nvmCount,@object                ; @nvmCount
	.globl	nvmCount
	.p2align	2, 0x0
nvmCount:
	.long	0                               ; 0x0
	.size	nvmCount, 4

	.type	NvmDetected,@object             ; @NvmDetected
	.globl	NvmDetected
NvmDetected:
	.byte	0                               ; 0x0
	.size	NvmDetected, 1

	.type	.L.str.1.9,@object              ; @.str.1.9
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1.9:
	.asciz	"\nDispositivo NVM inexistente"
	.size	.L.str.1.9, 29

	.type	DisplayDetected,@object         ; @DisplayDetected
	.section	.bss,"aw",@nobits
	.globl	DisplayDetected
DisplayDetected:
	.byte	0                               ; 0x0
	.size	DisplayDetected, 1

	.type	current_display.1,@object       ; @current_display.1
	.local	current_display.1
	.comm	current_display.1,4,4
	.type	display_queue,@object           ; @display_queue
	.local	display_queue
	.comm	display_queue,68,4
	.type	hardware_busy,@object           ; @hardware_busy
	.local	hardware_busy
	.comm	hardware_busy,1,1
	.type	.L.str.14,@object               ; @.str.14
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.14:
	.asciz	"Error en el acceso al NVM"
	.size	.L.str.14, 26

	.type	.L.str.1.15,@object             ; @.str.1.15
.L.str.1.15:
	.asciz	"Dispositivo NVM no reconocido"
	.size	.L.str.1.15, 30

	.type	fat_page_buffer,@object         ; @fat_page_buffer
	.local	fat_page_buffer
	.comm	fat_page_buffer,4096,1
	.type	.L.str.16,@object               ; @.str.16
.L.str.16:
	.asciz	"/"
	.size	.L.str.16, 2

	.type	current_vol,@object             ; @current_vol
	.section	.bss,"aw",@nobits
	.globl	current_vol
	.p2align	2, 0x0
current_vol:
	.zero	640
	.size	current_vol, 640

	.type	nvm_selected,@object            ; @nvm_selected
	.globl	nvm_selected
	.p2align	2, 0x0
nvm_selected:
	.long	0                               ; 0x0
	.size	nvm_selected, 4

	.type	.L.str.19,@object               ; @.str.19
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.19:
	.asciz	"Error en el acceso al NVM"
	.size	.L.str.19, 26

	.type	.L.str.1.20,@object             ; @.str.1.20
.L.str.1.20:
	.asciz	"Dispositivo NVM no reconocido"
	.size	.L.str.1.20, 30

	.type	Registros,@object               ; @Registros
	.data
	.globl	Registros
	.p2align	2, 0x0
Registros:
	.long	4276092928
	.size	Registros, 4

	.type	irq_table,@object               ; @irq_table
	.local	irq_table
	.comm	irq_table,512,4
	.type	.L.str.31,@object               ; @.str.31
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.31:
	.asciz	"Fatal Error: Unhandled IRQ"
	.size	.L.str.31, 27

	.type	.L.str.1.32,@object             ; @.str.1.32
.L.str.1.32:
	.asciz	"Fatal Error: Over Limit IRQ"
	.size	.L.str.1.32, 28

	.type	system_panic,@object            ; @system_panic
	.section	.bss,"aw",@nobits
	.globl	system_panic
system_panic:
	.byte	0                               ; 0x0
	.size	system_panic, 1

	.type	.L.str.39,@object               ; @.str.39
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.39:
	.asciz	"\nFatal Error: Page Fault without MMU"
	.size	.L.str.39, 37

	.type	.L.str.1.42,@object             ; @.str.1.42
.L.str.1.42:
	.asciz	"\nFatal Error: Alignament Fault"
	.size	.L.str.1.42, 31

	.type	.L.str.2.45,@object             ; @.str.2.45
.L.str.2.45:
	.asciz	"\nFatal Error: General Protection Fault"
	.size	.L.str.2.45, 39

	.type	.L.str.3.48,@object             ; @.str.3.48
.L.str.3.48:
	.asciz	"\nFatal Error: Invalid OpCode"
	.size	.L.str.3.48, 29

	.type	.L.str.4.51,@object             ; @.str.4.51
.L.str.4.51:
	.asciz	"\nFatal Error: Double Fault"
	.size	.L.str.4.51, 27

	.type	ascii_pool,@object              ; @ascii_pool
	.local	ascii_pool
	.comm	ascii_pool,256,1
	.type	current_pool_index,@object      ; @current_pool_index
	.local	current_pool_index
	.comm	current_pool_index,4,4
	.type	strtok.last_token,@object       ; @strtok.last_token
	.local	strtok.last_token
	.comm	strtok.last_token,4,4
	.type	.L.str.62,@object               ; @.str.62
.L.str.62:
	.asciz	"help"
	.size	.L.str.62, 5

	.type	.L.str.1.63,@object             ; @.str.1.63
.L.str.1.63:
	.asciz	"sysOff"
	.size	.L.str.1.63, 7

	.type	.L.str.2.64,@object             ; @.str.2.64
.L.str.2.64:
	.asciz	"reset"
	.size	.L.str.2.64, 6

	.type	.L.str.3.65,@object             ; @.str.3.65
.L.str.3.65:
	.asciz	"initSO"
	.size	.L.str.3.65, 7

	.type	.L.str.4.66,@object             ; @.str.4.66
.L.str.4.66:
	.asciz	"enumdisp"
	.size	.L.str.4.66, 9

	.type	.L.str.5.67,@object             ; @.str.5.67
.L.str.5.67:
	.asciz	"lsboot"
	.size	.L.str.5.67, 7

	.type	.L.str.6.68,@object             ; @.str.6.68
.L.str.6.68:
	.asciz	"setboot"
	.size	.L.str.6.68, 8

	.type	.L.str.7,@object                ; @.str.7
.L.str.7:
	.asciz	"cls"
	.size	.L.str.7, 4

	.type	tabla_comandos,@object          ; @tabla_comandos
	.data
	.globl	tabla_comandos
	.p2align	2, 0x0
tabla_comandos:
	.long	.L.str.62
	.long	help
	.long	.L.str.1.63
	.long	sysOff
	.long	.L.str.2.64
	.long	reset
	.long	.L.str.3.65
	.long	initSO
	.long	.L.str.4.66
	.long	enumdisp
	.long	.L.str.5.67
	.long	lsboot
	.long	.L.str.6.68
	.long	setboot
	.long	.L.str.7
	.long	cls
	.size	tabla_comandos, 64

	.type	page_size,@object               ; @page_size
	.section	.bss,"aw",@nobits
	.globl	page_size
	.p2align	2, 0x0
page_size:
	.long	0                               ; 0x0
	.size	page_size, 4

	.type	.L.str.8,@object                ; @.str.8
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.8:
	.asciz	"El sistema permite estos comandos: \n"
	.size	.L.str.8, 37

	.type	.L.str.9,@object                ; @.str.9
.L.str.9:
	.asciz	"- "
	.size	.L.str.9, 3

	.type	.L.str.10,@object               ; @.str.10
.L.str.10:
	.asciz	"\n"
	.size	.L.str.10, 2

	.type	.L.str.11,@object               ; @.str.11
.L.str.11:
	.asciz	"Apagando sistema..."
	.size	.L.str.11, 20

	.type	.L.str.12,@object               ; @.str.12
.L.str.12:
	.asciz	"Hay "
	.size	.L.str.12, 5

	.type	map_size,@object                ; @map_size
	.section	.bss,"aw",@nobits
	.globl	map_size
	.p2align	2, 0x0
map_size:
	.long	0                               ; 0x0
	.size	map_size, 4

	.type	.L.str.13,@object               ; @.str.13
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.13:
	.asciz	" dispositivos conectados\n"
	.size	.L.str.13, 26

	.type	.L.str.14.69,@object            ; @.str.14.69
.L.str.14.69:
	.asciz	"Class Code   ECAM Address\n"
	.size	.L.str.14.69, 27

	.type	.L.str.15,@object               ; @.str.15
.L.str.15:
	.asciz	"------------ ------------\n"
	.size	.L.str.15, 27

	.type	mapa,@object                    ; @mapa
	.data
	.globl	mapa
	.p2align	2, 0x0
mapa:
	.long	134217728
	.size	mapa, 4

	.type	.L.str.16.72,@object            ; @.str.16.72
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.16.72:
	.asciz	">"
	.size	.L.str.16.72, 2

	.type	.L.str.17,@object               ; @.str.17
.L.str.17:
	.asciz	"Comando no reconocido. Use 'help' para ver los comandos reconocidos\n"
	.size	.L.str.17, 69

	.type	.L.str.18,@object               ; @.str.18
.L.str.18:
	.asciz	"Continuar? (c/Enter, q para salir): "
	.size	.L.str.18, 37

	.ident	"clang version 24.0.0git (https://github.com/Licha-M/llvm-project-ISA32-LM.git bdb2313bc7d1b53523a2dc3574c87d2fca944b2d)"
	.section	".note.GNU-stack","",@progbits

; ════════════════════ .start auto-generado ════════════════════
; Inicio en palabra ROM 5799 (byte 0x005A9C)
; .start:
; ── Fase 1: Copiar 247 palabra(s) de .data  ROM → RAM ──────────────
;	H LDI R15, 0xFFF0		; Dir. ROM origen .data (palabra 5552, byte 0x0056C0)
;	SLT ADI R15, 0x56C0
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
;	INT LOD R15, R2, 40		; Leer palabra 10 de ROM (.data blob)
;	INT STR R1, R2, 40		; Escribir en RAM[0x04000028]
;	INT LOD R15, R2, 44		; Leer palabra 11 de ROM (.data blob)
;	INT STR R1, R2, 44		; Escribir en RAM[0x0400002C]
;	INT LOD R15, R2, 48		; Leer palabra 12 de ROM (.data blob)
;	INT STR R1, R2, 48		; Escribir en RAM[0x04000030]
;	INT LOD R15, R2, 52		; Leer palabra 13 de ROM (.data blob)
;	INT STR R1, R2, 52		; Escribir en RAM[0x04000034]
;	INT LOD R15, R2, 56		; Leer palabra 14 de ROM (.data blob)
;	INT STR R1, R2, 56		; Escribir en RAM[0x04000038]
;	INT LOD R15, R2, 60		; Leer palabra 15 de ROM (.data blob)
;	INT STR R1, R2, 60		; Escribir en RAM[0x0400003C]
;	INT LOD R15, R2, 64		; Leer palabra 16 de ROM (.data blob)
;	INT STR R1, R2, 64		; Escribir en RAM[0x04000040]
;	INT LOD R15, R2, 68		; Leer palabra 17 de ROM (.data blob)
;	INT STR R1, R2, 68		; Escribir en RAM[0x04000044]
;	INT LOD R15, R2, 72		; Leer palabra 18 de ROM (.data blob)
;	INT STR R1, R2, 72		; Escribir en RAM[0x04000048]
;	INT LOD R15, R2, 76		; Leer palabra 19 de ROM (.data blob)
;	INT STR R1, R2, 76		; Escribir en RAM[0x0400004C]
;	INT LOD R15, R2, 80		; Leer palabra 20 de ROM (.data blob)
;	INT STR R1, R2, 80		; Escribir en RAM[0x04000050]
;	INT LOD R15, R2, 84		; Leer palabra 21 de ROM (.data blob)
;	INT STR R1, R2, 84		; Escribir en RAM[0x04000054]
;	INT LOD R15, R2, 88		; Leer palabra 22 de ROM (.data blob)
;	INT STR R1, R2, 88		; Escribir en RAM[0x04000058]
;	INT LOD R15, R2, 92		; Leer palabra 23 de ROM (.data blob)
;	INT STR R1, R2, 92		; Escribir en RAM[0x0400005C]
;	INT LOD R15, R2, 96		; Leer palabra 24 de ROM (.data blob)
;	INT STR R1, R2, 96		; Escribir en RAM[0x04000060]
;	INT LOD R15, R2, 100		; Leer palabra 25 de ROM (.data blob)
;	INT STR R1, R2, 100		; Escribir en RAM[0x04000064]
;	INT LOD R15, R2, 104		; Leer palabra 26 de ROM (.data blob)
;	INT STR R1, R2, 104		; Escribir en RAM[0x04000068]
;	INT LOD R15, R2, 108		; Leer palabra 27 de ROM (.data blob)
;	INT STR R1, R2, 108		; Escribir en RAM[0x0400006C]
;	INT LOD R15, R2, 112		; Leer palabra 28 de ROM (.data blob)
;	INT STR R1, R2, 112		; Escribir en RAM[0x04000070]
;	INT LOD R15, R2, 116		; Leer palabra 29 de ROM (.data blob)
;	INT STR R1, R2, 116		; Escribir en RAM[0x04000074]
;	INT LOD R15, R2, 120		; Leer palabra 30 de ROM (.data blob)
;	INT STR R1, R2, 120		; Escribir en RAM[0x04000078]
;	INT LOD R15, R2, 124		; Leer palabra 31 de ROM (.data blob)
;	INT STR R1, R2, 124		; Escribir en RAM[0x0400007C]
;	INT LOD R15, R2, 128		; Leer palabra 32 de ROM (.data blob)
;	INT STR R1, R2, 128		; Escribir en RAM[0x04000080]
;	INT LOD R15, R2, 132		; Leer palabra 33 de ROM (.data blob)
;	INT STR R1, R2, 132		; Escribir en RAM[0x04000084]
;	INT LOD R15, R2, 136		; Leer palabra 34 de ROM (.data blob)
;	INT STR R1, R2, 136		; Escribir en RAM[0x04000088]
;	INT LOD R15, R2, 140		; Leer palabra 35 de ROM (.data blob)
;	INT STR R1, R2, 140		; Escribir en RAM[0x0400008C]
;	INT LOD R15, R2, 144		; Leer palabra 36 de ROM (.data blob)
;	INT STR R1, R2, 144		; Escribir en RAM[0x04000090]
;	INT LOD R15, R2, 148		; Leer palabra 37 de ROM (.data blob)
;	INT STR R1, R2, 148		; Escribir en RAM[0x04000094]
;	INT LOD R15, R2, 152		; Leer palabra 38 de ROM (.data blob)
;	INT STR R1, R2, 152		; Escribir en RAM[0x04000098]
;	INT LOD R15, R2, 156		; Leer palabra 39 de ROM (.data blob)
;	INT STR R1, R2, 156		; Escribir en RAM[0x0400009C]
;	INT LOD R15, R2, 160		; Leer palabra 40 de ROM (.data blob)
;	INT STR R1, R2, 160		; Escribir en RAM[0x040000A0]
;	INT LOD R15, R2, 164		; Leer palabra 41 de ROM (.data blob)
;	INT STR R1, R2, 164		; Escribir en RAM[0x040000A4]
;	INT LOD R15, R2, 168		; Leer palabra 42 de ROM (.data blob)
;	INT STR R1, R2, 168		; Escribir en RAM[0x040000A8]
;	INT LOD R15, R2, 172		; Leer palabra 43 de ROM (.data blob)
;	INT STR R1, R2, 172		; Escribir en RAM[0x040000AC]
;	INT LOD R15, R2, 176		; Leer palabra 44 de ROM (.data blob)
;	INT STR R1, R2, 176		; Escribir en RAM[0x040000B0]
;	INT LOD R15, R2, 180		; Leer palabra 45 de ROM (.data blob)
;	INT STR R1, R2, 180		; Escribir en RAM[0x040000B4]
;	INT LOD R15, R2, 184		; Leer palabra 46 de ROM (.data blob)
;	INT STR R1, R2, 184		; Escribir en RAM[0x040000B8]
;	INT LOD R15, R2, 188		; Leer palabra 47 de ROM (.data blob)
;	INT STR R1, R2, 188		; Escribir en RAM[0x040000BC]
;	INT LOD R15, R2, 192		; Leer palabra 48 de ROM (.data blob)
;	INT STR R1, R2, 192		; Escribir en RAM[0x040000C0]
;	INT LOD R15, R2, 196		; Leer palabra 49 de ROM (.data blob)
;	INT STR R1, R2, 196		; Escribir en RAM[0x040000C4]
;	INT LOD R15, R2, 200		; Leer palabra 50 de ROM (.data blob)
;	INT STR R1, R2, 200		; Escribir en RAM[0x040000C8]
;	INT LOD R15, R2, 204		; Leer palabra 51 de ROM (.data blob)
;	INT STR R1, R2, 204		; Escribir en RAM[0x040000CC]
;	INT LOD R15, R2, 208		; Leer palabra 52 de ROM (.data blob)
;	INT STR R1, R2, 208		; Escribir en RAM[0x040000D0]
;	INT LOD R15, R2, 212		; Leer palabra 53 de ROM (.data blob)
;	INT STR R1, R2, 212		; Escribir en RAM[0x040000D4]
;	INT LOD R15, R2, 216		; Leer palabra 54 de ROM (.data blob)
;	INT STR R1, R2, 216		; Escribir en RAM[0x040000D8]
;	INT LOD R15, R2, 220		; Leer palabra 55 de ROM (.data blob)
;	INT STR R1, R2, 220		; Escribir en RAM[0x040000DC]
;	INT LOD R15, R2, 224		; Leer palabra 56 de ROM (.data blob)
;	INT STR R1, R2, 224		; Escribir en RAM[0x040000E0]
;	INT LOD R15, R2, 228		; Leer palabra 57 de ROM (.data blob)
;	INT STR R1, R2, 228		; Escribir en RAM[0x040000E4]
;	INT LOD R15, R2, 232		; Leer palabra 58 de ROM (.data blob)
;	INT STR R1, R2, 232		; Escribir en RAM[0x040000E8]
;	INT LOD R15, R2, 236		; Leer palabra 59 de ROM (.data blob)
;	INT STR R1, R2, 236		; Escribir en RAM[0x040000EC]
;	INT LOD R15, R2, 240		; Leer palabra 60 de ROM (.data blob)
;	INT STR R1, R2, 240		; Escribir en RAM[0x040000F0]
;	INT LOD R15, R2, 244		; Leer palabra 61 de ROM (.data blob)
;	INT STR R1, R2, 244		; Escribir en RAM[0x040000F4]
;	INT LOD R15, R2, 248		; Leer palabra 62 de ROM (.data blob)
;	INT STR R1, R2, 248		; Escribir en RAM[0x040000F8]
;	INT LOD R15, R2, 252		; Leer palabra 63 de ROM (.data blob)
;	INT STR R1, R2, 252		; Escribir en RAM[0x040000FC]
;	INT LOD R15, R2, 256		; Leer palabra 64 de ROM (.data blob)
;	INT STR R1, R2, 256		; Escribir en RAM[0x04000100]
;	INT LOD R15, R2, 260		; Leer palabra 65 de ROM (.data blob)
;	INT STR R1, R2, 260		; Escribir en RAM[0x04000104]
;	INT LOD R15, R2, 264		; Leer palabra 66 de ROM (.data blob)
;	INT STR R1, R2, 264		; Escribir en RAM[0x04000108]
;	INT LOD R15, R2, 268		; Leer palabra 67 de ROM (.data blob)
;	INT STR R1, R2, 268		; Escribir en RAM[0x0400010C]
;	INT LOD R15, R2, 272		; Leer palabra 68 de ROM (.data blob)
;	INT STR R1, R2, 272		; Escribir en RAM[0x04000110]
;	INT LOD R15, R2, 276		; Leer palabra 69 de ROM (.data blob)
;	INT STR R1, R2, 276		; Escribir en RAM[0x04000114]
;	INT LOD R15, R2, 280		; Leer palabra 70 de ROM (.data blob)
;	INT STR R1, R2, 280		; Escribir en RAM[0x04000118]
;	INT LOD R15, R2, 284		; Leer palabra 71 de ROM (.data blob)
;	INT STR R1, R2, 284		; Escribir en RAM[0x0400011C]
;	INT LOD R15, R2, 288		; Leer palabra 72 de ROM (.data blob)
;	INT STR R1, R2, 288		; Escribir en RAM[0x04000120]
;	INT LOD R15, R2, 292		; Leer palabra 73 de ROM (.data blob)
;	INT STR R1, R2, 292		; Escribir en RAM[0x04000124]
;	INT LOD R15, R2, 296		; Leer palabra 74 de ROM (.data blob)
;	INT STR R1, R2, 296		; Escribir en RAM[0x04000128]
;	INT LOD R15, R2, 300		; Leer palabra 75 de ROM (.data blob)
;	INT STR R1, R2, 300		; Escribir en RAM[0x0400012C]
;	INT LOD R15, R2, 304		; Leer palabra 76 de ROM (.data blob)
;	INT STR R1, R2, 304		; Escribir en RAM[0x04000130]
;	INT LOD R15, R2, 308		; Leer palabra 77 de ROM (.data blob)
;	INT STR R1, R2, 308		; Escribir en RAM[0x04000134]
;	INT LOD R15, R2, 312		; Leer palabra 78 de ROM (.data blob)
;	INT STR R1, R2, 312		; Escribir en RAM[0x04000138]
;	INT LOD R15, R2, 316		; Leer palabra 79 de ROM (.data blob)
;	INT STR R1, R2, 316		; Escribir en RAM[0x0400013C]
;	INT LOD R15, R2, 320		; Leer palabra 80 de ROM (.data blob)
;	INT STR R1, R2, 320		; Escribir en RAM[0x04000140]
;	INT LOD R15, R2, 324		; Leer palabra 81 de ROM (.data blob)
;	INT STR R1, R2, 324		; Escribir en RAM[0x04000144]
;	INT LOD R15, R2, 328		; Leer palabra 82 de ROM (.data blob)
;	INT STR R1, R2, 328		; Escribir en RAM[0x04000148]
;	INT LOD R15, R2, 332		; Leer palabra 83 de ROM (.data blob)
;	INT STR R1, R2, 332		; Escribir en RAM[0x0400014C]
;	INT LOD R15, R2, 336		; Leer palabra 84 de ROM (.data blob)
;	INT STR R1, R2, 336		; Escribir en RAM[0x04000150]
;	INT LOD R15, R2, 340		; Leer palabra 85 de ROM (.data blob)
;	INT STR R1, R2, 340		; Escribir en RAM[0x04000154]
;	INT LOD R15, R2, 344		; Leer palabra 86 de ROM (.data blob)
;	INT STR R1, R2, 344		; Escribir en RAM[0x04000158]
;	INT LOD R15, R2, 348		; Leer palabra 87 de ROM (.data blob)
;	INT STR R1, R2, 348		; Escribir en RAM[0x0400015C]
;	INT LOD R15, R2, 352		; Leer palabra 88 de ROM (.data blob)
;	INT STR R1, R2, 352		; Escribir en RAM[0x04000160]
;	INT LOD R15, R2, 356		; Leer palabra 89 de ROM (.data blob)
;	INT STR R1, R2, 356		; Escribir en RAM[0x04000164]
;	INT LOD R15, R2, 360		; Leer palabra 90 de ROM (.data blob)
;	INT STR R1, R2, 360		; Escribir en RAM[0x04000168]
;	INT LOD R15, R2, 364		; Leer palabra 91 de ROM (.data blob)
;	INT STR R1, R2, 364		; Escribir en RAM[0x0400016C]
;	INT LOD R15, R2, 368		; Leer palabra 92 de ROM (.data blob)
;	INT STR R1, R2, 368		; Escribir en RAM[0x04000170]
;	INT LOD R15, R2, 372		; Leer palabra 93 de ROM (.data blob)
;	INT STR R1, R2, 372		; Escribir en RAM[0x04000174]
;	INT LOD R15, R2, 376		; Leer palabra 94 de ROM (.data blob)
;	INT STR R1, R2, 376		; Escribir en RAM[0x04000178]
;	INT LOD R15, R2, 380		; Leer palabra 95 de ROM (.data blob)
;	INT STR R1, R2, 380		; Escribir en RAM[0x0400017C]
;	INT LOD R15, R2, 384		; Leer palabra 96 de ROM (.data blob)
;	INT STR R1, R2, 384		; Escribir en RAM[0x04000180]
;	INT LOD R15, R2, 388		; Leer palabra 97 de ROM (.data blob)
;	INT STR R1, R2, 388		; Escribir en RAM[0x04000184]
;	INT LOD R15, R2, 392		; Leer palabra 98 de ROM (.data blob)
;	INT STR R1, R2, 392		; Escribir en RAM[0x04000188]
;	INT LOD R15, R2, 396		; Leer palabra 99 de ROM (.data blob)
;	INT STR R1, R2, 396		; Escribir en RAM[0x0400018C]
;	INT LOD R15, R2, 400		; Leer palabra 100 de ROM (.data blob)
;	INT STR R1, R2, 400		; Escribir en RAM[0x04000190]
;	INT LOD R15, R2, 404		; Leer palabra 101 de ROM (.data blob)
;	INT STR R1, R2, 404		; Escribir en RAM[0x04000194]
;	INT LOD R15, R2, 408		; Leer palabra 102 de ROM (.data blob)
;	INT STR R1, R2, 408		; Escribir en RAM[0x04000198]
;	INT LOD R15, R2, 412		; Leer palabra 103 de ROM (.data blob)
;	INT STR R1, R2, 412		; Escribir en RAM[0x0400019C]
;	INT LOD R15, R2, 416		; Leer palabra 104 de ROM (.data blob)
;	INT STR R1, R2, 416		; Escribir en RAM[0x040001A0]
;	INT LOD R15, R2, 420		; Leer palabra 105 de ROM (.data blob)
;	INT STR R1, R2, 420		; Escribir en RAM[0x040001A4]
;	INT LOD R15, R2, 424		; Leer palabra 106 de ROM (.data blob)
;	INT STR R1, R2, 424		; Escribir en RAM[0x040001A8]
;	INT LOD R15, R2, 428		; Leer palabra 107 de ROM (.data blob)
;	INT STR R1, R2, 428		; Escribir en RAM[0x040001AC]
;	INT LOD R15, R2, 432		; Leer palabra 108 de ROM (.data blob)
;	INT STR R1, R2, 432		; Escribir en RAM[0x040001B0]
;	INT LOD R15, R2, 436		; Leer palabra 109 de ROM (.data blob)
;	INT STR R1, R2, 436		; Escribir en RAM[0x040001B4]
;	INT LOD R15, R2, 440		; Leer palabra 110 de ROM (.data blob)
;	INT STR R1, R2, 440		; Escribir en RAM[0x040001B8]
;	INT LOD R15, R2, 444		; Leer palabra 111 de ROM (.data blob)
;	INT STR R1, R2, 444		; Escribir en RAM[0x040001BC]
;	INT LOD R15, R2, 448		; Leer palabra 112 de ROM (.data blob)
;	INT STR R1, R2, 448		; Escribir en RAM[0x040001C0]
;	INT LOD R15, R2, 452		; Leer palabra 113 de ROM (.data blob)
;	INT STR R1, R2, 452		; Escribir en RAM[0x040001C4]
;	INT LOD R15, R2, 456		; Leer palabra 114 de ROM (.data blob)
;	INT STR R1, R2, 456		; Escribir en RAM[0x040001C8]
;	INT LOD R15, R2, 460		; Leer palabra 115 de ROM (.data blob)
;	INT STR R1, R2, 460		; Escribir en RAM[0x040001CC]
;	INT LOD R15, R2, 464		; Leer palabra 116 de ROM (.data blob)
;	INT STR R1, R2, 464		; Escribir en RAM[0x040001D0]
;	INT LOD R15, R2, 468		; Leer palabra 117 de ROM (.data blob)
;	INT STR R1, R2, 468		; Escribir en RAM[0x040001D4]
;	INT LOD R15, R2, 472		; Leer palabra 118 de ROM (.data blob)
;	INT STR R1, R2, 472		; Escribir en RAM[0x040001D8]
;	INT LOD R15, R2, 476		; Leer palabra 119 de ROM (.data blob)
;	INT STR R1, R2, 476		; Escribir en RAM[0x040001DC]
;	INT LOD R15, R2, 480		; Leer palabra 120 de ROM (.data blob)
;	INT STR R1, R2, 480		; Escribir en RAM[0x040001E0]
;	INT LOD R15, R2, 484		; Leer palabra 121 de ROM (.data blob)
;	INT STR R1, R2, 484		; Escribir en RAM[0x040001E4]
;	INT LOD R15, R2, 488		; Leer palabra 122 de ROM (.data blob)
;	INT STR R1, R2, 488		; Escribir en RAM[0x040001E8]
;	INT LOD R15, R2, 492		; Leer palabra 123 de ROM (.data blob)
;	INT STR R1, R2, 492		; Escribir en RAM[0x040001EC]
;	INT LOD R15, R2, 496		; Leer palabra 124 de ROM (.data blob)
;	INT STR R1, R2, 496		; Escribir en RAM[0x040001F0]
;	INT LOD R15, R2, 500		; Leer palabra 125 de ROM (.data blob)
;	INT STR R1, R2, 500		; Escribir en RAM[0x040001F4]
;	INT LOD R15, R2, 504		; Leer palabra 126 de ROM (.data blob)
;	INT STR R1, R2, 504		; Escribir en RAM[0x040001F8]
;	INT LOD R15, R2, 508		; Leer palabra 127 de ROM (.data blob)
;	INT STR R1, R2, 508		; Escribir en RAM[0x040001FC]
;	INT LOD R15, R2, 512		; Leer palabra 128 de ROM (.data blob)
;	INT STR R1, R2, 512		; Escribir en RAM[0x04000200]
;	INT LOD R15, R2, 516		; Leer palabra 129 de ROM (.data blob)
;	INT STR R1, R2, 516		; Escribir en RAM[0x04000204]
;	INT LOD R15, R2, 520		; Leer palabra 130 de ROM (.data blob)
;	INT STR R1, R2, 520		; Escribir en RAM[0x04000208]
;	INT LOD R15, R2, 524		; Leer palabra 131 de ROM (.data blob)
;	INT STR R1, R2, 524		; Escribir en RAM[0x0400020C]
;	INT LOD R15, R2, 528		; Leer palabra 132 de ROM (.data blob)
;	INT STR R1, R2, 528		; Escribir en RAM[0x04000210]
;	INT LOD R15, R2, 532		; Leer palabra 133 de ROM (.data blob)
;	INT STR R1, R2, 532		; Escribir en RAM[0x04000214]
;	INT LOD R15, R2, 536		; Leer palabra 134 de ROM (.data blob)
;	INT STR R1, R2, 536		; Escribir en RAM[0x04000218]
;	INT LOD R15, R2, 540		; Leer palabra 135 de ROM (.data blob)
;	INT STR R1, R2, 540		; Escribir en RAM[0x0400021C]
;	INT LOD R15, R2, 544		; Leer palabra 136 de ROM (.data blob)
;	INT STR R1, R2, 544		; Escribir en RAM[0x04000220]
;	INT LOD R15, R2, 548		; Leer palabra 137 de ROM (.data blob)
;	INT STR R1, R2, 548		; Escribir en RAM[0x04000224]
;	INT LOD R15, R2, 552		; Leer palabra 138 de ROM (.data blob)
;	INT STR R1, R2, 552		; Escribir en RAM[0x04000228]
;	INT LOD R15, R2, 556		; Leer palabra 139 de ROM (.data blob)
;	INT STR R1, R2, 556		; Escribir en RAM[0x0400022C]
;	INT LOD R15, R2, 560		; Leer palabra 140 de ROM (.data blob)
;	INT STR R1, R2, 560		; Escribir en RAM[0x04000230]
;	INT LOD R15, R2, 564		; Leer palabra 141 de ROM (.data blob)
;	INT STR R1, R2, 564		; Escribir en RAM[0x04000234]
;	INT LOD R15, R2, 568		; Leer palabra 142 de ROM (.data blob)
;	INT STR R1, R2, 568		; Escribir en RAM[0x04000238]
;	INT LOD R15, R2, 572		; Leer palabra 143 de ROM (.data blob)
;	INT STR R1, R2, 572		; Escribir en RAM[0x0400023C]
;	INT LOD R15, R2, 576		; Leer palabra 144 de ROM (.data blob)
;	INT STR R1, R2, 576		; Escribir en RAM[0x04000240]
;	INT LOD R15, R2, 580		; Leer palabra 145 de ROM (.data blob)
;	INT STR R1, R2, 580		; Escribir en RAM[0x04000244]
;	INT LOD R15, R2, 584		; Leer palabra 146 de ROM (.data blob)
;	INT STR R1, R2, 584		; Escribir en RAM[0x04000248]
;	INT LOD R15, R2, 588		; Leer palabra 147 de ROM (.data blob)
;	INT STR R1, R2, 588		; Escribir en RAM[0x0400024C]
;	INT LOD R15, R2, 592		; Leer palabra 148 de ROM (.data blob)
;	INT STR R1, R2, 592		; Escribir en RAM[0x04000250]
;	INT LOD R15, R2, 596		; Leer palabra 149 de ROM (.data blob)
;	INT STR R1, R2, 596		; Escribir en RAM[0x04000254]
;	INT LOD R15, R2, 600		; Leer palabra 150 de ROM (.data blob)
;	INT STR R1, R2, 600		; Escribir en RAM[0x04000258]
;	INT LOD R15, R2, 604		; Leer palabra 151 de ROM (.data blob)
;	INT STR R1, R2, 604		; Escribir en RAM[0x0400025C]
;	INT LOD R15, R2, 608		; Leer palabra 152 de ROM (.data blob)
;	INT STR R1, R2, 608		; Escribir en RAM[0x04000260]
;	INT LOD R15, R2, 612		; Leer palabra 153 de ROM (.data blob)
;	INT STR R1, R2, 612		; Escribir en RAM[0x04000264]
;	INT LOD R15, R2, 616		; Leer palabra 154 de ROM (.data blob)
;	INT STR R1, R2, 616		; Escribir en RAM[0x04000268]
;	INT LOD R15, R2, 620		; Leer palabra 155 de ROM (.data blob)
;	INT STR R1, R2, 620		; Escribir en RAM[0x0400026C]
;	INT LOD R15, R2, 624		; Leer palabra 156 de ROM (.data blob)
;	INT STR R1, R2, 624		; Escribir en RAM[0x04000270]
;	INT LOD R15, R2, 628		; Leer palabra 157 de ROM (.data blob)
;	INT STR R1, R2, 628		; Escribir en RAM[0x04000274]
;	INT LOD R15, R2, 632		; Leer palabra 158 de ROM (.data blob)
;	INT STR R1, R2, 632		; Escribir en RAM[0x04000278]
;	INT LOD R15, R2, 636		; Leer palabra 159 de ROM (.data blob)
;	INT STR R1, R2, 636		; Escribir en RAM[0x0400027C]
;	INT LOD R15, R2, 640		; Leer palabra 160 de ROM (.data blob)
;	INT STR R1, R2, 640		; Escribir en RAM[0x04000280]
;	INT LOD R15, R2, 644		; Leer palabra 161 de ROM (.data blob)
;	INT STR R1, R2, 644		; Escribir en RAM[0x04000284]
;	INT LOD R15, R2, 648		; Leer palabra 162 de ROM (.data blob)
;	INT STR R1, R2, 648		; Escribir en RAM[0x04000288]
;	INT LOD R15, R2, 652		; Leer palabra 163 de ROM (.data blob)
;	INT STR R1, R2, 652		; Escribir en RAM[0x0400028C]
;	INT LOD R15, R2, 656		; Leer palabra 164 de ROM (.data blob)
;	INT STR R1, R2, 656		; Escribir en RAM[0x04000290]
;	INT LOD R15, R2, 660		; Leer palabra 165 de ROM (.data blob)
;	INT STR R1, R2, 660		; Escribir en RAM[0x04000294]
;	INT LOD R15, R2, 664		; Leer palabra 166 de ROM (.data blob)
;	INT STR R1, R2, 664		; Escribir en RAM[0x04000298]
;	INT LOD R15, R2, 668		; Leer palabra 167 de ROM (.data blob)
;	INT STR R1, R2, 668		; Escribir en RAM[0x0400029C]
;	INT LOD R15, R2, 672		; Leer palabra 168 de ROM (.data blob)
;	INT STR R1, R2, 672		; Escribir en RAM[0x040002A0]
;	INT LOD R15, R2, 676		; Leer palabra 169 de ROM (.data blob)
;	INT STR R1, R2, 676		; Escribir en RAM[0x040002A4]
;	INT LOD R15, R2, 680		; Leer palabra 170 de ROM (.data blob)
;	INT STR R1, R2, 680		; Escribir en RAM[0x040002A8]
;	INT LOD R15, R2, 684		; Leer palabra 171 de ROM (.data blob)
;	INT STR R1, R2, 684		; Escribir en RAM[0x040002AC]
;	INT LOD R15, R2, 688		; Leer palabra 172 de ROM (.data blob)
;	INT STR R1, R2, 688		; Escribir en RAM[0x040002B0]
;	INT LOD R15, R2, 692		; Leer palabra 173 de ROM (.data blob)
;	INT STR R1, R2, 692		; Escribir en RAM[0x040002B4]
;	INT LOD R15, R2, 696		; Leer palabra 174 de ROM (.data blob)
;	INT STR R1, R2, 696		; Escribir en RAM[0x040002B8]
;	INT LOD R15, R2, 700		; Leer palabra 175 de ROM (.data blob)
;	INT STR R1, R2, 700		; Escribir en RAM[0x040002BC]
;	INT LOD R15, R2, 704		; Leer palabra 176 de ROM (.data blob)
;	INT STR R1, R2, 704		; Escribir en RAM[0x040002C0]
;	INT LOD R15, R2, 708		; Leer palabra 177 de ROM (.data blob)
;	INT STR R1, R2, 708		; Escribir en RAM[0x040002C4]
;	INT LOD R15, R2, 712		; Leer palabra 178 de ROM (.data blob)
;	INT STR R1, R2, 712		; Escribir en RAM[0x040002C8]
;	INT LOD R15, R2, 716		; Leer palabra 179 de ROM (.data blob)
;	INT STR R1, R2, 716		; Escribir en RAM[0x040002CC]
;	INT LOD R15, R2, 720		; Leer palabra 180 de ROM (.data blob)
;	INT STR R1, R2, 720		; Escribir en RAM[0x040002D0]
;	INT LOD R15, R2, 724		; Leer palabra 181 de ROM (.data blob)
;	INT STR R1, R2, 724		; Escribir en RAM[0x040002D4]
;	INT LOD R15, R2, 728		; Leer palabra 182 de ROM (.data blob)
;	INT STR R1, R2, 728		; Escribir en RAM[0x040002D8]
;	INT LOD R15, R2, 732		; Leer palabra 183 de ROM (.data blob)
;	INT STR R1, R2, 732		; Escribir en RAM[0x040002DC]
;	INT LOD R15, R2, 736		; Leer palabra 184 de ROM (.data blob)
;	INT STR R1, R2, 736		; Escribir en RAM[0x040002E0]
;	INT LOD R15, R2, 740		; Leer palabra 185 de ROM (.data blob)
;	INT STR R1, R2, 740		; Escribir en RAM[0x040002E4]
;	INT LOD R15, R2, 744		; Leer palabra 186 de ROM (.data blob)
;	INT STR R1, R2, 744		; Escribir en RAM[0x040002E8]
;	INT LOD R15, R2, 748		; Leer palabra 187 de ROM (.data blob)
;	INT STR R1, R2, 748		; Escribir en RAM[0x040002EC]
;	INT LOD R15, R2, 752		; Leer palabra 188 de ROM (.data blob)
;	INT STR R1, R2, 752		; Escribir en RAM[0x040002F0]
;	INT LOD R15, R2, 756		; Leer palabra 189 de ROM (.data blob)
;	INT STR R1, R2, 756		; Escribir en RAM[0x040002F4]
;	INT LOD R15, R2, 760		; Leer palabra 190 de ROM (.data blob)
;	INT STR R1, R2, 760		; Escribir en RAM[0x040002F8]
;	INT LOD R15, R2, 764		; Leer palabra 191 de ROM (.data blob)
;	INT STR R1, R2, 764		; Escribir en RAM[0x040002FC]
;	INT LOD R15, R2, 768		; Leer palabra 192 de ROM (.data blob)
;	INT STR R1, R2, 768		; Escribir en RAM[0x04000300]
;	INT LOD R15, R2, 772		; Leer palabra 193 de ROM (.data blob)
;	INT STR R1, R2, 772		; Escribir en RAM[0x04000304]
;	INT LOD R15, R2, 776		; Leer palabra 194 de ROM (.data blob)
;	INT STR R1, R2, 776		; Escribir en RAM[0x04000308]
;	INT LOD R15, R2, 780		; Leer palabra 195 de ROM (.data blob)
;	INT STR R1, R2, 780		; Escribir en RAM[0x0400030C]
;	INT LOD R15, R2, 784		; Leer palabra 196 de ROM (.data blob)
;	INT STR R1, R2, 784		; Escribir en RAM[0x04000310]
;	INT LOD R15, R2, 788		; Leer palabra 197 de ROM (.data blob)
;	INT STR R1, R2, 788		; Escribir en RAM[0x04000314]
;	INT LOD R15, R2, 792		; Leer palabra 198 de ROM (.data blob)
;	INT STR R1, R2, 792		; Escribir en RAM[0x04000318]
;	INT LOD R15, R2, 796		; Leer palabra 199 de ROM (.data blob)
;	INT STR R1, R2, 796		; Escribir en RAM[0x0400031C]
;	INT LOD R15, R2, 800		; Leer palabra 200 de ROM (.data blob)
;	INT STR R1, R2, 800		; Escribir en RAM[0x04000320]
;	INT LOD R15, R2, 804		; Leer palabra 201 de ROM (.data blob)
;	INT STR R1, R2, 804		; Escribir en RAM[0x04000324]
;	INT LOD R15, R2, 808		; Leer palabra 202 de ROM (.data blob)
;	INT STR R1, R2, 808		; Escribir en RAM[0x04000328]
;	INT LOD R15, R2, 812		; Leer palabra 203 de ROM (.data blob)
;	INT STR R1, R2, 812		; Escribir en RAM[0x0400032C]
;	INT LOD R15, R2, 816		; Leer palabra 204 de ROM (.data blob)
;	INT STR R1, R2, 816		; Escribir en RAM[0x04000330]
;	INT LOD R15, R2, 820		; Leer palabra 205 de ROM (.data blob)
;	INT STR R1, R2, 820		; Escribir en RAM[0x04000334]
;	INT LOD R15, R2, 824		; Leer palabra 206 de ROM (.data blob)
;	INT STR R1, R2, 824		; Escribir en RAM[0x04000338]
;	INT LOD R15, R2, 828		; Leer palabra 207 de ROM (.data blob)
;	INT STR R1, R2, 828		; Escribir en RAM[0x0400033C]
;	INT LOD R15, R2, 832		; Leer palabra 208 de ROM (.data blob)
;	INT STR R1, R2, 832		; Escribir en RAM[0x04000340]
;	INT LOD R15, R2, 836		; Leer palabra 209 de ROM (.data blob)
;	INT STR R1, R2, 836		; Escribir en RAM[0x04000344]
;	INT LOD R15, R2, 840		; Leer palabra 210 de ROM (.data blob)
;	INT STR R1, R2, 840		; Escribir en RAM[0x04000348]
;	INT LOD R15, R2, 844		; Leer palabra 211 de ROM (.data blob)
;	INT STR R1, R2, 844		; Escribir en RAM[0x0400034C]
;	INT LOD R15, R2, 848		; Leer palabra 212 de ROM (.data blob)
;	INT STR R1, R2, 848		; Escribir en RAM[0x04000350]
;	INT LOD R15, R2, 852		; Leer palabra 213 de ROM (.data blob)
;	INT STR R1, R2, 852		; Escribir en RAM[0x04000354]
;	INT LOD R15, R2, 856		; Leer palabra 214 de ROM (.data blob)
;	INT STR R1, R2, 856		; Escribir en RAM[0x04000358]
;	INT LOD R15, R2, 860		; Leer palabra 215 de ROM (.data blob)
;	INT STR R1, R2, 860		; Escribir en RAM[0x0400035C]
;	INT LOD R15, R2, 864		; Leer palabra 216 de ROM (.data blob)
;	INT STR R1, R2, 864		; Escribir en RAM[0x04000360]
;	INT LOD R15, R2, 868		; Leer palabra 217 de ROM (.data blob)
;	INT STR R1, R2, 868		; Escribir en RAM[0x04000364]
;	INT LOD R15, R2, 872		; Leer palabra 218 de ROM (.data blob)
;	INT STR R1, R2, 872		; Escribir en RAM[0x04000368]
;	INT LOD R15, R2, 876		; Leer palabra 219 de ROM (.data blob)
;	INT STR R1, R2, 876		; Escribir en RAM[0x0400036C]
;	INT LOD R15, R2, 880		; Leer palabra 220 de ROM (.data blob)
;	INT STR R1, R2, 880		; Escribir en RAM[0x04000370]
;	INT LOD R15, R2, 884		; Leer palabra 221 de ROM (.data blob)
;	INT STR R1, R2, 884		; Escribir en RAM[0x04000374]
;	INT LOD R15, R2, 888		; Leer palabra 222 de ROM (.data blob)
;	INT STR R1, R2, 888		; Escribir en RAM[0x04000378]
;	INT LOD R15, R2, 892		; Leer palabra 223 de ROM (.data blob)
;	INT STR R1, R2, 892		; Escribir en RAM[0x0400037C]
;	INT LOD R15, R2, 896		; Leer palabra 224 de ROM (.data blob)
;	INT STR R1, R2, 896		; Escribir en RAM[0x04000380]
;	INT LOD R15, R2, 900		; Leer palabra 225 de ROM (.data blob)
;	INT STR R1, R2, 900		; Escribir en RAM[0x04000384]
;	INT LOD R15, R2, 904		; Leer palabra 226 de ROM (.data blob)
;	INT STR R1, R2, 904		; Escribir en RAM[0x04000388]
;	INT LOD R15, R2, 908		; Leer palabra 227 de ROM (.data blob)
;	INT STR R1, R2, 908		; Escribir en RAM[0x0400038C]
;	INT LOD R15, R2, 912		; Leer palabra 228 de ROM (.data blob)
;	INT STR R1, R2, 912		; Escribir en RAM[0x04000390]
;	INT LOD R15, R2, 916		; Leer palabra 229 de ROM (.data blob)
;	INT STR R1, R2, 916		; Escribir en RAM[0x04000394]
;	INT LOD R15, R2, 920		; Leer palabra 230 de ROM (.data blob)
;	INT STR R1, R2, 920		; Escribir en RAM[0x04000398]
;	INT LOD R15, R2, 924		; Leer palabra 231 de ROM (.data blob)
;	INT STR R1, R2, 924		; Escribir en RAM[0x0400039C]
;	INT LOD R15, R2, 928		; Leer palabra 232 de ROM (.data blob)
;	INT STR R1, R2, 928		; Escribir en RAM[0x040003A0]
;	INT LOD R15, R2, 932		; Leer palabra 233 de ROM (.data blob)
;	INT STR R1, R2, 932		; Escribir en RAM[0x040003A4]
;	INT LOD R15, R2, 936		; Leer palabra 234 de ROM (.data blob)
;	INT STR R1, R2, 936		; Escribir en RAM[0x040003A8]
;	INT LOD R15, R2, 940		; Leer palabra 235 de ROM (.data blob)
;	INT STR R1, R2, 940		; Escribir en RAM[0x040003AC]
;	INT LOD R15, R2, 944		; Leer palabra 236 de ROM (.data blob)
;	INT STR R1, R2, 944		; Escribir en RAM[0x040003B0]
;	INT LOD R15, R2, 948		; Leer palabra 237 de ROM (.data blob)
;	INT STR R1, R2, 948		; Escribir en RAM[0x040003B4]
;	INT LOD R15, R2, 952		; Leer palabra 238 de ROM (.data blob)
;	INT STR R1, R2, 952		; Escribir en RAM[0x040003B8]
;	INT LOD R15, R2, 956		; Leer palabra 239 de ROM (.data blob)
;	INT STR R1, R2, 956		; Escribir en RAM[0x040003BC]
;	INT LOD R15, R2, 960		; Leer palabra 240 de ROM (.data blob)
;	INT STR R1, R2, 960		; Escribir en RAM[0x040003C0]
;	INT LOD R15, R2, 964		; Leer palabra 241 de ROM (.data blob)
;	INT STR R1, R2, 964		; Escribir en RAM[0x040003C4]
;	INT LOD R15, R2, 968		; Leer palabra 242 de ROM (.data blob)
;	INT STR R1, R2, 968		; Escribir en RAM[0x040003C8]
;	INT LOD R15, R2, 972		; Leer palabra 243 de ROM (.data blob)
;	INT STR R1, R2, 972		; Escribir en RAM[0x040003CC]
;	INT LOD R15, R2, 976		; Leer palabra 244 de ROM (.data blob)
;	INT STR R1, R2, 976		; Escribir en RAM[0x040003D0]
;	INT LOD R15, R2, 980		; Leer palabra 245 de ROM (.data blob)
;	INT STR R1, R2, 980		; Escribir en RAM[0x040003D4]
;	INT LOD R15, R2, 984		; Leer palabra 246 de ROM (.data blob)
;	INT STR R1, R2, 984		; Escribir en RAM[0x040003D8]
; ── Fase 3: Saltar a main ──────────────────────────────────────────────────
;	H LDI R15, %hi(main)		; Parte alta de la dirección de main
;	SLT ADI R15, %lo(main)	; Parte baja
;	JMP R15

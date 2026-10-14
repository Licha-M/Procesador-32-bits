	.file	"llvm-link"
	.text
	.globl	final                           ; -- Begin function final
	.type	final,@function
final:                                  ; @final
; %bb.0:                                ; %entry
	SLT ADI R14, 4
.LBB0_1:                                ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
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
; %bb.0:                                ; %entry
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
; %bb.2:                                ; %if.end
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
; %bb.5:                                ; %if.end4
	H LDI R15, %hi(keyboardSearch)
	SLT ADI R15, %lo(keyboardSearch)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB1_6)
	SLT ADI R15, %lo(.LBB1_6)
	BRH EQ, R15
; %bb.8:                                ; %if.end7
	H LDI R15, %hi(BiosShell)
	SLT ADI R15, %lo(BiosShell)
	CAL R15
	LDI R1, 0
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.LBB1_1:                                ; %while.body.i
                                        ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB1_1)
	SLT ADI R15, %lo(.LBB1_1)
	JMP R15
.LBB1_3:                                ; %if.then3
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.4
	SLT ADI R1, .L.str.4
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB1_4:                                ; %while.body.i8
                                        ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB1_4)
	SLT ADI R15, %lo(.LBB1_4)
	JMP R15
.LBB1_6:                                ; %if.then6
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.5
	SLT ADI R1, .L.str.5
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB1_7:                                ; %while.body.i10
                                        ; =>This Inner Loop Header: Depth=1
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
; %bb.0:                                ; %entry
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
; %bb.1:                                ; %if.then
	CHAR LOD R3, R5, 0
	LDI R6, 0
	H LDI R6, key_queue
	SLT ADI R6, key_queue
	ADD R5, R6, R5
	CHAR STR R5, R2, 0
	CHAR STR R3, R4, 0
.LBB2_2:                                ; %if.end
	SLT ADI R14, -4
	RET
.Lfunc_end2:
	.size	keyboard_IRQHandler, .Lfunc_end2-keyboard_IRQHandler
                                        ; -- End function
	.globl	keyboardSearch                  ; -- Begin function keyboardSearch
	.type	keyboardSearch,@function
keyboardSearch:                         ; @keyboardSearch
; %bb.0:                                ; %entry
	SLT ADI R14, 16
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	LDI R1, 0
	H LDI R1, 9
	SLT ADI R1, 0
	H LDI R15, %hi(search)
	SLT ADI R15, %lo(search)
	CAL R15
	SLT ADD R1, R0, R8
	LDI R9, 0
	SUB R8, R9, R0
	H LDI R15, %hi(.LBB3_2)
	SLT ADI R15, %lo(.LBB3_2)
	BRH N, R15
; %bb.1:                                ; %if.end
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
.LBB3_2:                                ; %cleanup
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
; %bb.0:                                ; %entry
	SLT ADI R14, 36
	INT STR R14, R8, -12
	INT STR R14, R9, -16
	INT STR R14, R10, -20
	INT STR R14, R11, -24
	INT STR R14, R12, -28
	INT STR R14, R13, -32
	LDI R11, 0
	H LDI R11, 0
	SLT ADI R11, -1
	LDI R3, 0
	INT STR R14, R1, -4
	SUB R1, R3, R0
	H LDI R15, %hi(.LBB4_29)
	SLT ADI R15, %lo(.LBB4_29)
	BRH EQ, R15
; %bb.1:                                ; %entry
	LDI R4, 1
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB4_29)
	SLT ADI R15, %lo(.LBB4_29)
	BRH N, R15
; %bb.2:                                ; %if.end
	INT LOD R14, R1, -4
	CHAR STR R1, R3, 0
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R3, 4
	AND R1, R3, R1
	LDI R11, 0
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB4_4)
	SLT ADI R15, %lo(.LBB4_4)
	BRH NE, R15
; %bb.3:
	LDI R11, 0
	H LDI R11, 0
	SLT ADI R11, -1
	LDI R1, 0
	H LDI R1, .L.str.6
	SLT ADI R1, .L.str.6
	H LDI R15, %hi(.LBB4_28)
	SLT ADI R15, %lo(.LBB4_28)
	JMP R15
.LBB4_4:                                ; %while.cond.preheader
	ADI R2, -1
	INT STR R14, R2, -8
	LDI R13, 0
	H LDI R13, kq_tail
	SLT ADI R13, kq_tail
	LDI R10, 0
	H LDI R10, kq_head
	SLT ADI R10, kq_head
	LDI R5, 0
	H LDI R5, key_queue
	SLT ADI R5, key_queue
	LDI R8, 63
	LDI R12, 12
	SLT ADD R11, R0, R1
	H LDI R15, %hi(.LBB4_5)
	SLT ADI R15, %lo(.LBB4_5)
	JMP R15
.LBB4_26:                               ; %if.end86
                                        ;   in Loop: Header=BB4_5 Depth=1
	SUB R9, R2, R0
	H LDI R15, %hi(.LBB4_27)
	SLT ADI R15, %lo(.LBB4_27)
	BRH NE, R15
.LBB4_5:                                ; %while.cond4.preheader
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_6 Depth 2
	CHAR LOD R13, R2, 0
	CHAR LOD R10, R3, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB4_6)
	SLT ADI R15, %lo(.LBB4_6)
	BRH NE, R15
; %bb.30:                               ; %while.body8
                                        ;   in Loop: Header=BB4_5 Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB4_5)
	SLT ADI R15, %lo(.LBB4_5)
	JMP R15
.LBB4_19:                               ; %if.then60
                                        ;   in Loop: Header=BB4_6 Depth=2
	LDI R1, 0
	H LDI R1, .L.str.1.3
	SLT ADI R1, .L.str.1.3
	SLT ADD R4, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R5, 0
	H LDI R5, key_queue
	SLT ADI R5, key_queue
	LDI R4, 1
	SLT ADD R9, R0, R11
	SLT ADD R9, R0, R1
.LBB4_6:                                ; %while.cond9.preheader
                                        ;   Parent Loop BB4_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	CHAR LOD R13, R2, 0
	CHAR LOD R10, R3, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB4_23)
	SLT ADI R15, %lo(.LBB4_23)
	BRH EQ, R15
; %bb.7:                                ; %while.body15
                                        ;   in Loop: Header=BB4_6 Depth=2
	CHAR LOD R13, R2, 0
	ADD R2, R5, R2
	CHAR LOD R2, R2, 0
	CHAR LOD R13, R3, 0
	ADI R3, 1
	AND R3, R8, R3
	CHAR STR R13, R3, 0
	SUB R12, R2, R0
	H LDI R15, %hi(.LBB4_11)
	SLT ADI R15, %lo(.LBB4_11)
	BRH N, R15
; %bb.8:                                ; %while.body15
                                        ;   in Loop: Header=BB4_6 Depth=2
	LDI R3, 8
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB4_16)
	SLT ADI R15, %lo(.LBB4_16)
	BRH EQ, R15
; %bb.9:                                ; %while.body15
                                        ;   in Loop: Header=BB4_6 Depth=2
	LDI R3, 10
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB4_20)
	SLT ADI R15, %lo(.LBB4_20)
	BRH NE, R15
	H LDI R15, %hi(.LBB4_10)
	SLT ADI R15, %lo(.LBB4_10)
	JMP R15
.LBB4_11:                               ; %while.body15
                                        ;   in Loop: Header=BB4_6 Depth=2
	LDI R3, 127
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB4_12)
	SLT ADI R15, %lo(.LBB4_12)
	BRH NE, R15
.LBB4_16:                               ; %if.then54
                                        ;   in Loop: Header=BB4_6 Depth=2
	SUB R11, R4, R0
	H LDI R15, %hi(.LBB4_6)
	SLT ADI R15, %lo(.LBB4_6)
	BRH N, R15
; %bb.17:                               ; %if.then57
                                        ;   in Loop: Header=BB4_6 Depth=2
	SLT ADD R11, R0, R9
	ADI R9, -1
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB4_19)
	SLT ADI R15, %lo(.LBB4_19)
	BRH NN, R15
; %bb.18:                               ;   in Loop: Header=BB4_6 Depth=2
	SLT ADD R9, R0, R11
	H LDI R15, %hi(.LBB4_6)
	SLT ADI R15, %lo(.LBB4_6)
	JMP R15
.LBB4_12:                               ; %while.body15
                                        ;   in Loop: Header=BB4_6 Depth=2
	LDI R3, 13
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB4_13)
	SLT ADI R15, %lo(.LBB4_13)
	BRH EQ, R15
.LBB4_20:                               ; %if.else63
                                        ;   in Loop: Header=BB4_6 Depth=2
	SLT ADD R2, R0, R3
	ADI R3, -32
	LDI R6, 255
	AND R3, R6, R3
	LDI R6, 94
	SUB R6, R3, R0
	H LDI R15, %hi(.LBB4_6)
	SLT ADI R15, %lo(.LBB4_6)
	BRH C, R15
; %bb.21:                               ; %if.else63
                                        ;   in Loop: Header=BB4_6 Depth=2
	INT LOD R14, R3, -8
	SUB R11, R3, R0
	H LDI R15, %hi(.LBB4_6)
	SLT ADI R15, %lo(.LBB4_6)
	BRH NN, R15
; %bb.22:                               ; %if.then74
                                        ;   in Loop: Header=BB4_6 Depth=2
	INT LOD R14, R3, -4
	ADD R3, R11, R3
	CHAR STR R3, R2, 0
	ADI R11, 1
	H LDI R15, %hi(.LBB4_6)
	SLT ADI R15, %lo(.LBB4_6)
	JMP R15
.LBB4_23:                               ;   in Loop: Header=BB4_5 Depth=1
	LDI R2, 0
	SLT ADD R2, R0, R9
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB4_26)
	SLT ADI R15, %lo(.LBB4_26)
	BRH NN, R15
	H LDI R15, %hi(.LBB4_25)
	SLT ADI R15, %lo(.LBB4_25)
	JMP R15
.LBB4_13:                               ; %land.lhs.true
                                        ;   in Loop: Header=BB4_5 Depth=1
	CHAR LOD R13, R2, 0
	CHAR LOD R10, R3, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB4_10)
	SLT ADI R15, %lo(.LBB4_10)
	BRH EQ, R15
; %bb.14:                               ; %land.lhs.true35
                                        ;   in Loop: Header=BB4_5 Depth=1
	CHAR LOD R13, R2, 0
	ADD R2, R5, R2
	CHAR LOD R2, R2, 0
	LDI R3, 10
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB4_10)
	SLT ADI R15, %lo(.LBB4_10)
	BRH NE, R15
; %bb.15:                               ; %if.then41
                                        ;   in Loop: Header=BB4_5 Depth=1
	CHAR LOD R13, R2, 0
	ADI R2, 1
	AND R2, R8, R2
	CHAR STR R13, R2, 0
.LBB4_10:                               ;   in Loop: Header=BB4_5 Depth=1
	SLT ADD R4, R0, R9
	LDI R2, 0
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB4_26)
	SLT ADI R15, %lo(.LBB4_26)
	BRH NN, R15
.LBB4_25:                               ; %if.then83
                                        ;   in Loop: Header=BB4_5 Depth=1
	INT LOD R14, R3, -4
	ADD R3, R11, R2
	LDI R4, 0
	CHAR STR R2, R4, 0
	ADD R3, R1, R1
	LDI R2, 0
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R5, 0
	H LDI R5, key_queue
	SLT ADI R5, key_queue
	LDI R4, 1
	LDI R2, 0
	SLT ADD R11, R0, R1
	H LDI R15, %hi(.LBB4_26)
	SLT ADI R15, %lo(.LBB4_26)
	JMP R15
.LBB4_27:                               ; %while.end87
	INT LOD R14, R1, -4
	ADD R1, R11, R1
	CHAR STR R1, R2, 0
	LDI R1, 0
	H LDI R1, .L.str.2.4
	SLT ADI R1, .L.str.2.4
.LBB4_28:                               ; %return.sink.split
	LDI R2, 0
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB4_29:                               ; %return
	SLT ADD R11, R0, R1
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
; %bb.0:                                ; %entry
	SLT ADI R14, 12
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	LDI R1, 0
	H LDI R1, 1
	SLT ADI R1, 2050
	H LDI R15, %hi(search)
	SLT ADI R15, %lo(search)
	CAL R15
	SLT ADD R1, R0, R8
	LDI R1, 0
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB5_2)
	SLT ADI R15, %lo(.LBB5_2)
	BRH N, R15
; %bb.1:                                ; %if.end
	LDI R2, 20
	MUL R8, R2, R3
	LDI R4, 0
	H LDI R4, mapa
	SLT ADI R4, mapa
	INT LOD R4, R4, 0
	ADD R4, R3, R3
	CHAR LOD R3, R4, 16
	LSH R4, R2, R2
	CHAR LOD R3, R4, 17
	LDI R5, 15
	LSH R4, R5, R4
	NOR R4, R2, R2
	CHAR LOD R3, R3, 18
	LDI R4, 0
	H LDI R4, hardware_busy
	SLT ADI R4, hardware_busy
	CHAR STR R4, R1, 0
	LDI R4, 12
	LSH R3, R4, R3
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
	LDI R4, 0
	H LDI R4, nvm_registers
	SLT ADI R4, nvm_registers
	INT STR R4, R3, 0
	LDI R9, 1
	INT STR R3, R9, 0
	LDI R4, 0
	H LDI R4, 2176
	SLT ADI R4, 0
	INT STR R3, R4, 4
	LDI R4, 0
	H LDI R4, 2176
	SLT ADI R4, 2048
	INT STR R3, R4, 8
	LDI R3, 0
	H LDI R3, head_index
	SLT ADI R3, head_index
	INT STR R3, R1, 0
	LDI R3, 0
	H LDI R3, tail_index
	SLT ADI R3, tail_index
	INT STR R3, R1, 0
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 0
	NOR R2, R1, R1
	NOR R1, R1, R1
	LDI R2, 125
	LDI R3, 0
	H LDI R3, nvm_IRQHandler
	SLT ADI R3, nvm_IRQHandler
	H LDI R15, %hi(initMSI)
	SLT ADI R15, %lo(initMSI)
	CAL R15
	SLT ADD R9, R0, R1
.LBB5_2:                                ; %cleanup
	LDI R2, 0
	H LDI R2, NvmDetected
	SLT ADI R2, NvmDetected
	CHAR STR R2, R1, 0
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
	XOR R8, R1, R1
	LDI R2, 31
	RSH R1, R2, R1
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -12
	RET
.Lfunc_end5:
	.size	nvmSearch, .Lfunc_end5-nvmSearch
                                        ; -- End function
	.type	nvm_IRQHandler,@function        ; -- Begin function nvm_IRQHandler
nvm_IRQHandler:                         ; @nvm_IRQHandler
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	SLT ADD R2, R0, R1
	LDI R2, 0
	H LDI R2, tail_index
	SLT ADI R2, tail_index
	INT LOD R2, R3, 0
	LDI R4, 3
	LSH R3, R4, R3
	LDI R4, 0
	H LDI R4, 2176
	SLT ADI R4, 2048
	ADD R3, R4, R3
	INT LOD R3, R3, 0
	LDI R4, 0
	H LDI R4, 256
	SLT ADI R4, -1
	AND R3, R4, R3
	INT LOD R2, R4, 0
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB6_4)
	SLT ADI R15, %lo(.LBB6_4)
	BRH NE, R15
; %bb.1:                                ; %if.then
	INT LOD R2, R3, 0
	ADI R3, 1
	LDI R4, 127
	AND R3, R4, R3
	INT STR R2, R3, 0
	INT LOD R2, R2, 0
	LDI R3, 0
	H LDI R3, head_index
	SLT ADI R3, head_index
	INT LOD R3, R3, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB6_3)
	SLT ADI R15, %lo(.LBB6_3)
	BRH NE, R15
; %bb.2:                                ; %if.then3
	LDI R2, 0
	LDI R3, 0
	H LDI R3, hardware_busy
	SLT ADI R3, hardware_busy
	CHAR STR R3, R2, 0
	H LDI R15, %hi(.LBB6_5)
	SLT ADI R15, %lo(.LBB6_5)
	JMP R15
.LBB6_4:                                ; %if.else4
	LDI R2, 1
	LDI R3, 0
	H LDI R3, hardware_busy
	SLT ADI R3, hardware_busy
	CHAR STR R3, R2, 0
	LDI R3, 0
	H LDI R3, nvm_registers
	SLT ADI R3, nvm_registers
	INT LOD R3, R3, 0
	CHAR STR R3, R2, 12
	H LDI R15, %hi(.LBB6_5)
	SLT ADI R15, %lo(.LBB6_5)
	JMP R15
.LBB6_3:                                ; %if.else
	LDI R2, 0
	H LDI R2, nvm_registers
	SLT ADI R2, nvm_registers
	INT LOD R2, R2, 0
	LDI R3, 1
	CHAR STR R2, R3, 12
.LBB6_5:                                ; %if.end6
	SLT ADI R14, -4
	RET
.Lfunc_end6:
	.size	nvm_IRQHandler, .Lfunc_end6-nvm_IRQHandler
                                        ; -- End function
	.globl	accesNvm                        ; -- Begin function accesNvm
	.type	accesNvm,@function
accesNvm:                               ; @accesNvm
; %bb.0:                                ; %entry
	SLT ADI R14, 20
	INT STR R14, R8, -8
	INT STR R14, R9, -12
	INT STR R14, R10, -16
	LDI R5, 2
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB7_1)
	SLT ADI R15, %lo(.LBB7_1)
	BRH NC, R15
; %bb.2:                                ; %if.end
	LDI R5, 0
	H LDI R5, head_index
	SLT ADI R5, head_index
	INT LOD R5, R6, 0
	ADI R6, 1
	LDI R7, 127
	AND R6, R7, R7
	ADD R14, R0, R6
	SLT ADI R6, -4
	INT STR R6, R7, 0
	INT LOD R6, R9, 0
	LDI R8, 0
	H LDI R8, tail_index
	SLT ADI R8, tail_index
	INT LOD R8, R10, 0
	LDI R7, 4
	SUB R9, R10, R0
	H LDI R15, %hi(.LBB7_4)
	SLT ADI R15, %lo(.LBB7_4)
	BRH NE, R15
.LBB7_3:                                ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	;APP
	CYE SR8, R9
	;NO_APP
	NOR R9, R7, R9
	NOR R9, R9, R9
	;APP
	CYR R9, SR8
	;NO_APP
	;APP
	HLT
	;NO_APP
	INT LOD R6, R9, 0
	INT LOD R8, R10, 0
	SUB R9, R10, R0
	H LDI R15, %hi(.LBB7_3)
	SLT ADI R15, %lo(.LBB7_3)
	BRH EQ, R15
.LBB7_4:                                ; %while.end
	INT LOD R5, R8, 0
	LSH R8, R7, R8
	LDI R9, 0
	H LDI R9, 2176
	SLT ADI R9, 0
	ADD R8, R9, R8
	NOR R8, R7, R7
	NOR R7, R7, R7
	INT STR R7, R2, 0
	LDI R2, 12
	NOR R8, R2, R2
	NOR R2, R2, R2
	INT STR R2, R4, 0
	LDI R2, 8
	NOR R8, R2, R2
	NOR R2, R2, R2
	INT STR R2, R3, 0
	LDI R2, 24
	LSH R1, R2, R1
	LDI R2, 0
	H LDI R2, 256
	SLT ADI R2, -1
	INT LOD R5, R3, 0
	AND R3, R2, R2
	NOR R2, R1, R1
	NOR R1, R1, R1
	INT STR R8, R1, 0
	INT LOD R6, R1, 0
	INT STR R5, R1, 0
	LDI R1, 0
	H LDI R1, hardware_busy
	SLT ADI R1, hardware_busy
	CHAR LOD R1, R2, 0
	LDI R3, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB7_6)
	SLT ADI R15, %lo(.LBB7_6)
	BRH NE, R15
; %bb.5:                                ; %if.then7
	LDI R2, 0
	H LDI R2, nvm_registers
	SLT ADI R2, nvm_registers
	INT LOD R2, R2, 0
	LDI R3, 1
	CHAR STR R2, R3, 12
	CHAR STR R1, R3, 0
	H LDI R15, %hi(.LBB7_6)
	SLT ADI R15, %lo(.LBB7_6)
	JMP R15
.LBB7_1:                                ; %if.then
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.9
	SLT ADI R1, .L.str.9
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB7_6:                                ; %return
	INT LOD R14, R10, -16
	INT LOD R14, R9, -12
	INT LOD R14, R8, -8
	SLT ADI R14, -20
	RET
.Lfunc_end7:
	.size	accesNvm, .Lfunc_end7-accesNvm
                                        ; -- End function
	.globl	displaySearch                   ; -- Begin function displaySearch
	.type	displaySearch,@function
displaySearch:                          ; @displaySearch
; %bb.0:                                ; %entry
	SLT ADI R14, 8
	INT STR R14, R8, -4
	LDI R1, 0
	H LDI R1, 7
	SLT ADI R1, 0
	H LDI R15, %hi(search)
	SLT ADI R15, %lo(search)
	CAL R15
	SLT ADD R1, R0, R8
	LDI R1, 0
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB8_2)
	SLT ADI R15, %lo(.LBB8_2)
	BRH N, R15
; %bb.1:                                ; %if.end
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
	H LDI R6, hardware_busy.12
	SLT ADI R6, hardware_busy.12
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
.LBB8_2:                                ; %cleanup
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
.Lfunc_end8:
	.size	displaySearch, .Lfunc_end8-displaySearch
                                        ; -- End function
	.type	tty_IRQHandler,@function        ; -- Begin function tty_IRQHandler
tty_IRQHandler:                         ; @tty_IRQHandler
; %bb.0:                                ; %entry
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
	H LDI R15, %hi(.LBB9_1)
	SLT ADI R15, %lo(.LBB9_1)
	BRH NE, R15
; %bb.2:                                ; %if.else
	LDI R2, 0
	H LDI R2, hardware_busy.12
	SLT ADI R2, hardware_busy.12
	CHAR STR R2, R3, 0
.LBB9_3:                                ; %if.end
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.LBB9_1:                                ; %if.then
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
	H LDI R15, %hi(.LBB9_3)
	SLT ADI R15, %lo(.LBB9_3)
	JMP R15
.Lfunc_end9:
	.size	tty_IRQHandler, .Lfunc_end9-tty_IRQHandler
                                        ; -- End function
	.type	tty_execute_request,@function   ; -- Begin function tty_execute_request
tty_execute_request:                    ; @tty_execute_request
; %bb.0:                                ; %entry
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
	H LDI R15, %hi(.LBB10_5)
	SLT ADI R15, %lo(.LBB10_5)
	BRH C, R15
; %bb.1:                                ; %entry
	LDI R5, 2
	LSH R4, R5, R4
	LDI R5, 0
	H LDI R5, .LJTI10_0
	SLT ADI R5, .LJTI10_0
	ADD R5, R4, R4
	INT LOD R4, R4, 0
	JMP R4
.LBB10_2:                               ; %sw.bb
	INT LOD R1, R3, 12
	INT STR R2, R3, 8
	CHAR LOD R1, R1, 4
	INT STR R2, R1, 4
	LDI R3, 1
	H LDI R15, %hi(.LBB10_6)
	SLT ADI R15, %lo(.LBB10_6)
	JMP R15
.LBB10_3:                               ; %sw.bb2
	INT LOD R1, R1, 12
	INT STR R2, R1, 8
	LDI R3, 2
	H LDI R15, %hi(.LBB10_6)
	SLT ADI R15, %lo(.LBB10_6)
	JMP R15
.LBB10_4:                               ; %sw.bb10
	INT LOD R1, R1, 0
	INT STR R2, R1, 4
	LDI R3, 4
	H LDI R15, %hi(.LBB10_6)
	SLT ADI R15, %lo(.LBB10_6)
	JMP R15
.LBB10_5:                               ; %sw.default
	LDI R3, 0
.LBB10_6:                               ; %sw.epilog
	INT STR R2, R3, 0
	SLT ADI R14, -4
	RET
.Lfunc_end10:
	.size	tty_execute_request, .Lfunc_end10-tty_execute_request
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
	.type	.LJTI10_0,@object
.LJTI10_0:
	.long	.LBB10_2
	.long	.LBB10_3
	.long	.LBB10_6
	.long	.LBB10_4
	.size	.LJTI10_0, 16
                                        ; -- End function
	.text
	.globl	biosClear                       ; -- Begin function biosClear
	.type	biosClear,@function
biosClear:                              ; @biosClear
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	LDI R1, 0
	H LDI R1, system_panic
	SLT ADI R1, system_panic
	CHAR LOD R1, R1, 0
	LDI R1, 0
	H LDI R1, hardware_busy.12
	SLT ADI R1, hardware_busy.12
	CHAR LOD R1, R2, 0
	LDI R3, 1
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB11_3)
	SLT ADI R15, %lo(.LBB11_3)
	BRH NE, R15
; %bb.1:                                ; %while.body.i.preheader
	LDI R2, 0
.LBB11_2:                               ; %while.body.i
                                        ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	CHAR LOD R1, R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB11_2)
	SLT ADI R15, %lo(.LBB11_2)
	BRH NE, R15
.LBB11_3:                               ; %while.end.i
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
	SLT ADI R14, -4
	RET
.Lfunc_end11:
	.size	biosClear, .Lfunc_end11-biosClear
                                        ; -- End function
	.globl	biosWrite                       ; -- Begin function biosWrite
	.type	biosWrite,@function
biosWrite:                              ; @biosWrite
; %bb.0:                                ; %entry
	SLT ADI R14, 36
	INT STR R14, R8, -20
	INT STR R14, R9, -24
	INT STR R14, R10, -28
	INT STR R14, R11, -32
	CHAR LOD R1, R5, 0
	LDI R6, 1
	LDI R3, 8
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB12_1)
	SLT ADI R15, %lo(.LBB12_1)
	BRH EQ, R15
; %bb.2:                                ; %entry
	SLT ADD R6, R0, R3
	H LDI R15, %hi(.LBB12_3)
	SLT ADI R15, %lo(.LBB12_3)
	JMP R15
.LBB12_1:
	LDI R3, 2
.LBB12_3:                               ; %entry
	CHAR LOD R1, R7, 1
	LDI R4, 0
	SUB R7, R4, R0
	H LDI R15, %hi(.LBB12_5)
	SLT ADI R15, %lo(.LBB12_5)
	BRH EQ, R15
; %bb.4:                                ; %entry
	LDI R3, 4
.LBB12_5:                               ; %entry
	NOR R2, R7, R7
	NOR R7, R7, R8
	SLT ADD R6, R0, R7
	SUB R8, R4, R0
	H LDI R15, %hi(.LBB12_7)
	SLT ADI R15, %lo(.LBB12_7)
	BRH EQ, R15
; %bb.6:                                ; %entry
	SLT ADD R4, R0, R7
.LBB12_7:                               ; %entry
	ADD R2, R7, R4
	LDI R2, 0
	H LDI R2, system_panic
	SLT ADI R2, system_panic
	CHAR LOD R2, R2, 0
	SUB R2, R6, R0
	H LDI R15, %hi(.LBB12_8)
	SLT ADI R15, %lo(.LBB12_8)
	BRH EQ, R15
; %bb.9:                                ; %if.end.i
	LDI R5, 0
	SUB R6, R4, R0
	H LDI R15, %hi(.LBB12_11)
	SLT ADI R15, %lo(.LBB12_11)
	BRH N, R15
; %bb.10:                               ; %if.end.i
	SLT ADD R5, R0, R6
.LBB12_11:                              ; %if.end.i
	LDI R2, 2
	RSH R3, R2, R7
	NOR R7, R6, R6
	NOR R6, R6, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB12_18)
	SLT ADI R15, %lo(.LBB12_18)
	BRH EQ, R15
; %bb.12:                               ; %while.cond12.preheader.i
	LDI R7, 0
	H LDI R7, display_queue+66
	SLT ADI R7, display_queue+66
	CHAR LOD R7, R5, 0
	LDI R6, 4
	SUB R5, R6, R0
	H LDI R15, %hi(.LBB12_15)
	SLT ADI R15, %lo(.LBB12_15)
	BRH C, R15
; %bb.13:
	LDI R5, 3
.LBB12_14:                              ; %while.body15.i
                                        ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	CHAR LOD R7, R8, 0
	SUB R5, R8, R0
	H LDI R15, %hi(.LBB12_14)
	SLT ADI R15, %lo(.LBB12_14)
	BRH C, R15
.LBB12_15:                              ; %while.end16.i
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
	INT STR R3, R4, 0
	CHAR LOD R9, R3, 0
	ADI R3, 1
	LDI R4, 3
	AND R3, R4, R3
	CHAR STR R9, R3, 0
	CHAR LOD R7, R3, 0
	ADI R3, 1
	CHAR STR R7, R3, 0
	LDI R3, 0
	H LDI R3, hardware_busy.12
	SLT ADI R3, hardware_busy.12
	CHAR LOD R3, R7, 0
	LDI R9, 0
	SUB R7, R9, R0
	H LDI R15, %hi(.LBB12_32)
	SLT ADI R15, %lo(.LBB12_32)
	BRH NE, R15
; %bb.16:                               ; %if.then34.i
	LDI R7, 1
	CHAR STR R3, R7, 0
	LDI R3, 0
	H LDI R3, display_queue+64
	SLT ADI R3, display_queue+64
	CHAR LOD R3, R3, 0
	LSH R3, R6, R6
	ADD R6, R1, R3
	LDI R1, 0
	H LDI R1, current_display.1
	SLT ADI R1, current_display.1
	INT LOD R1, R1, 0
	INT LOD R3, R3, 0
	SLT ADD R3, R0, R7
	ADI R7, -1
	SUB R4, R7, R0
	H LDI R15, %hi(.LBB12_30)
	SLT ADI R15, %lo(.LBB12_30)
	BRH C, R15
; %bb.17:                               ; %if.then34.i
	ADD R6, R8, R4
	LSH R7, R2, R2
	LDI R6, 0
	H LDI R6, .LJTI12_0
	SLT ADI R6, .LJTI12_0
	ADD R6, R2, R2
	INT LOD R2, R2, 0
	JMP R2
.LBB12_27:                              ; %sw.bb.i58.i
	INT LOD R4, R2, 12
	INT STR R1, R2, 8
	CHAR LOD R4, R2, 4
	INT STR R1, R2, 4
	LDI R3, 1
	H LDI R15, %hi(.LBB12_31)
	SLT ADI R15, %lo(.LBB12_31)
	JMP R15
.LBB12_18:                              ; %while.cond.preheader.i
	LDI R5, 0
	H LDI R5, hardware_busy.12
	SLT ADI R5, hardware_busy.12
	CHAR LOD R5, R6, 0
	LDI R7, 1
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB12_21)
	SLT ADI R15, %lo(.LBB12_21)
	BRH NE, R15
; %bb.19:                               ; %while.body.i.preheader
	LDI R6, 0
.LBB12_20:                              ; %while.body.i
                                        ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	CHAR LOD R5, R7, 0
	SUB R7, R6, R0
	H LDI R15, %hi(.LBB12_20)
	SLT ADI R15, %lo(.LBB12_20)
	BRH NE, R15
.LBB12_21:                              ; %while.end.i
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
	H LDI R15, %hi(.LBB12_25)
	SLT ADI R15, %lo(.LBB12_25)
	BRH EQ, R15
; %bb.22:                               ; %while.end.i
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB12_24)
	SLT ADI R15, %lo(.LBB12_24)
	BRH NE, R15
; %bb.23:
	LDI R2, 8
	H LDI R15, %hi(.LBB12_26)
	SLT ADI R15, %lo(.LBB12_26)
	JMP R15
.LBB12_24:                              ; %sw.bb.i.i
	CHAR LOD R1, R1, 0
	INT STR R6, R4, 8
.LBB12_25:                              ; %sw.bb10.i.i
	LDI R2, 4
	SLT ADD R1, R0, R4
.LBB12_26:                              ; %tty_execute_request.exit.i
	ADD R6, R2, R1
	INT STR R1, R4, 0
	INT STR R6, R3, 0
	;APP
	CYR R5, SR8
	;NO_APP
	H LDI R15, %hi(.LBB12_33)
	SLT ADI R15, %lo(.LBB12_33)
	JMP R15
.LBB12_28:                              ; %sw.bb2.i55.i
	INT LOD R4, R2, 12
	INT STR R1, R2, 8
	LDI R3, 2
	H LDI R15, %hi(.LBB12_31)
	SLT ADI R15, %lo(.LBB12_31)
	JMP R15
.LBB12_29:                              ; %sw.bb10.i52.i
	INT LOD R4, R2, 0
	INT STR R1, R2, 4
	LDI R3, 4
	H LDI R15, %hi(.LBB12_31)
	SLT ADI R15, %lo(.LBB12_31)
	JMP R15
.LBB12_30:                              ; %sw.default.i64.i
	LDI R3, 0
.LBB12_31:                              ; %tty_execute_request.exit65.i
	INT STR R1, R3, 0
.LBB12_32:                              ; %if.end37.i
	;APP
	CYR R5, SR8
	;NO_APP
.LBB12_33:                              ; %ttyWrite.exit
	INT LOD R14, R11, -32
	INT LOD R14, R10, -28
	INT LOD R14, R9, -24
	INT LOD R14, R8, -20
	SLT ADI R14, -36
	RET
.LBB12_8:                               ; %if.then.i
	ADD R14, R0, R2
	SLT ADI R2, -16
	CHAR STR R2, R5, 4
	INT STR R2, R1, 0
	LDI R1, 0
	CHAR STR R2, R1, 5
	CHAR STR R2, R1, 6
	CHAR STR R2, R1, 7
	INT STR R2, R4, 12
	INT STR R2, R3, 8
	SLT ADD R2, R0, R1
	H LDI R15, %hi(tty_execute_request)
	SLT ADI R15, %lo(tty_execute_request)
	CAL R15
	H LDI R15, %hi(.LBB12_33)
	SLT ADI R15, %lo(.LBB12_33)
	JMP R15
.Lfunc_end12:
	.size	biosWrite, .Lfunc_end12-biosWrite
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
	.type	.LJTI12_0,@object
.LJTI12_0:
	.long	.LBB12_27
	.long	.LBB12_28
	.long	.LBB12_31
	.long	.LBB12_29
	.size	.LJTI12_0, 16
                                        ; -- End function
	.text
	.globl	bus_Enumeration                 ; -- Begin function bus_Enumeration
	.type	bus_Enumeration,@function
bus_Enumeration:                        ; @bus_Enumeration
; %bb.0:                                ; %entry
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
	H LDI R15, %hi(.LBB13_41)
	SLT ADI R15, %lo(.LBB13_41)
	BRH C, R15
; %bb.1:                                ; %for.cond.preheader
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
.LBB13_2:                               ; %for.cond2.preheader
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB13_12 Depth 2
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
	H LDI R15, %hi(.LBB13_3)
	SLT ADI R15, %lo(.LBB13_3)
	BRH NE, R15
.LBB13_13:                              ; %if.then11
                                        ;   in Loop: Header=BB13_2 Depth=1
	LDI R1, 1
	SUB R6, R8, R0
	H LDI R15, %hi(.LBB13_15)
	SLT ADI R15, %lo(.LBB13_15)
	BRH NE, R15
; %bb.14:                               ; %if.then11
                                        ;   in Loop: Header=BB13_2 Depth=1
	SLT ADD R8, R0, R1
.LBB13_15:                              ; %if.then11
                                        ;   in Loop: Header=BB13_2 Depth=1
	LDI R2, 1
	SUB R13, R8, R0
	H LDI R15, %hi(.LBB13_17)
	SLT ADI R15, %lo(.LBB13_17)
	BRH EQ, R15
; %bb.16:                               ; %if.then11
                                        ;   in Loop: Header=BB13_2 Depth=1
	SLT ADD R8, R0, R2
.LBB13_17:                              ; %if.then11
                                        ;   in Loop: Header=BB13_2 Depth=1
	AND R1, R2, R1
	LDI R2, 1
	AND R1, R2, R1
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB13_47)
	SLT ADI R15, %lo(.LBB13_47)
	BRH EQ, R15
	H LDI R15, %hi(.LBB13_41)
	SLT ADI R15, %lo(.LBB13_41)
	JMP R15
.LBB13_3:                               ; %if.end16.peel
                                        ;   in Loop: Header=BB13_2 Depth=1
	LDI R1, 0
	H LDI R1, map_size
	SLT ADI R1, map_size
	INT LOD R1, R1, 0
	LDI R2, 63
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB13_41)
	SLT ADI R15, %lo(.LBB13_41)
	BRH N, R15
; %bb.4:                                ; %if.end19.peel
                                        ;   in Loop: Header=BB13_2 Depth=1
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
	H LDI R15, %hi(.LBB13_6)
	SLT ADI R15, %lo(.LBB13_6)
	BRH EQ, R15
; %bb.5:                                ; %if.end19.peel
                                        ;   in Loop: Header=BB13_2 Depth=1
	LDI R10, 0
	H LDI R10, 49152
	SLT ADI R10, 0
.LBB13_21:                              ; %if.end19
                                        ;   in Loop: Header=BB13_2 Depth=1
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 0
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB13_47)
	SLT ADI R15, %lo(.LBB13_47)
	BRH NE, R15
	H LDI R15, %hi(.LBB13_22)
	SLT ADI R15, %lo(.LBB13_22)
	JMP R15
.LBB13_6:                               ; %if.then79.peel
                                        ;   in Loop: Header=BB13_2 Depth=1
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
	H LDI R15, %hi(.LBB13_8)
	SLT ADI R15, %lo(.LBB13_8)
	BRH NC, R15
; %bb.7:                                ; %if.then103.peel
                                        ;   in Loop: Header=BB13_2 Depth=1
	LDI R4, 0
	H LDI R4, 1
	SLT ADI R4, -1
	ADD R3, R4, R3
	LDI R4, 0
	H LDI R4, 65535
	SLT ADI R4, 0
	AND R3, R4, R3
	INT STR R7, R3, 0
.LBB13_8:                               ; %if.end106.peel
                                        ;   in Loop: Header=BB13_2 Depth=1
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
	H LDI R15, %hi(.LBB13_10)
	SLT ADI R15, %lo(.LBB13_10)
	BRH NC, R15
; %bb.9:                                ; %if.then130.peel
                                        ;   in Loop: Header=BB13_2 Depth=1
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
.LBB13_10:                              ; %if.end139.peel
                                        ;   in Loop: Header=BB13_2 Depth=1
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
	H LDI R15, %hi(.LBB13_11)
	SLT ADI R15, %lo(.LBB13_11)
	BRH NN, R15
.LBB13_47:                              ; %for.inc164
                                        ;   in Loop: Header=BB13_2 Depth=1
	ADI R13, 1
	LDI R1, 32
	SUB R13, R1, R0
	H LDI R15, %hi(.LBB13_41)
	SLT ADI R15, %lo(.LBB13_41)
	BRH EQ, R15
; %bb.48:                               ; %for.cond2.preheader.backedge
                                        ;   in Loop: Header=BB13_2 Depth=1
	LDI R1, 0
	H LDI R1, 1
	SLT ADI R1, -32768
	ADD R5, R1, R5
	H LDI R15, %hi(.LBB13_2)
	SLT ADI R15, %lo(.LBB13_2)
	JMP R15
.LBB13_11:                              ; %for.body5.preheader
                                        ;   in Loop: Header=BB13_2 Depth=1
	SLT ADD R5, R0, R12
	SLT ADD R8, R0, R11
	H LDI R15, %hi(.LBB13_12)
	SLT ADI R15, %lo(.LBB13_12)
	JMP R15
.LBB13_46:                              ; %if.end139
                                        ;   in Loop: Header=BB13_12 Depth=2
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
	H LDI R15, %hi(.LBB13_47)
	SLT ADI R15, %lo(.LBB13_47)
	BRH NC, R15
.LBB13_12:                              ; %for.body5
                                        ;   Parent Loop BB13_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ADD R12, R4, R2
	INT LOD R2, R2, 0
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -1
	AND R2, R3, R2
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB13_13)
	SLT ADI R15, %lo(.LBB13_13)
	BRH EQ, R15
; %bb.18:                               ; %if.end16
                                        ;   in Loop: Header=BB13_12 Depth=2
	LDI R2, 0
	H LDI R2, map_size
	SLT ADI R2, map_size
	INT LOD R2, R2, 0
	LDI R3, 63
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB13_41)
	SLT ADI R15, %lo(.LBB13_41)
	BRH N, R15
; %bb.19:                               ; %if.end19
                                        ;   in Loop: Header=BB13_12 Depth=2
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
	H LDI R15, %hi(.LBB13_20)
	SLT ADI R15, %lo(.LBB13_20)
	BRH NE, R15
; %bb.42:                               ; %if.then79
                                        ;   in Loop: Header=BB13_12 Depth=2
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
	H LDI R15, %hi(.LBB13_44)
	SLT ADI R15, %lo(.LBB13_44)
	BRH NC, R15
; %bb.43:                               ; %if.then103
                                        ;   in Loop: Header=BB13_12 Depth=2
	LDI R4, 0
	H LDI R4, 1
	SLT ADI R4, -1
	ADD R3, R4, R3
	LDI R4, 0
	H LDI R4, 65535
	SLT ADI R4, 0
	AND R3, R4, R3
	INT STR R7, R3, 0
.LBB13_44:                              ; %if.end106
                                        ;   in Loop: Header=BB13_12 Depth=2
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
	H LDI R15, %hi(.LBB13_46)
	SLT ADI R15, %lo(.LBB13_46)
	BRH NC, R15
; %bb.45:                               ; %if.then130
                                        ;   in Loop: Header=BB13_12 Depth=2
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
	H LDI R15, %hi(.LBB13_46)
	SLT ADI R15, %lo(.LBB13_46)
	JMP R15
.LBB13_20:                              ; %if.end19
                                        ;   in Loop: Header=BB13_2 Depth=1
	LDI R10, 0
	H LDI R10, 49152
	SLT ADI R10, 0
	LDI R9, 0
	H LDI R9, mapa
	SLT ADI R9, mapa
	H LDI R15, %hi(.LBB13_21)
	SLT ADI R15, %lo(.LBB13_21)
	JMP R15
.LBB13_22:                              ; %for.cond35.preheader
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
	H LDI R15, %hi(.LBB13_26)
	SLT ADI R15, %lo(.LBB13_26)
	BRH EQ, R15
; %bb.23:                               ; %if.end50
	INT LOD R7, R6, 0
	LDI R7, 0
	H LDI R7, 49152
	SLT ADI R7, 0
	ADD R6, R7, R6
	INT STR R5, R6, 0
	LDI R5, 4096
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB13_25)
	SLT ADI R15, %lo(.LBB13_25)
	BRH NC, R15
; %bb.24:
	ADI R4, 4095
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -4096
	AND R4, R5, R5
.LBB13_25:                              ; %if.end50
	INT LOD R14, R7, -8
	INT LOD R7, R4, 0
	ADD R4, R5, R4
	INT STR R7, R4, 0
.LBB13_26:                              ; %for.inc
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 20
	ADD R12, R4, R4
	INT STR R4, R3, 0
	INT LOD R4, R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB13_30)
	SLT ADI R15, %lo(.LBB13_30)
	BRH EQ, R15
; %bb.27:                               ; %if.end50.1
	INT LOD R7, R5, 0
	LDI R6, 0
	H LDI R6, 49152
	SLT ADI R6, 0
	ADD R5, R6, R5
	INT STR R4, R5, 0
	LDI R4, 4096
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB13_29)
	SLT ADI R15, %lo(.LBB13_29)
	BRH NC, R15
; %bb.28:
	ADI R3, 4095
	LDI R4, 0
	H LDI R4, 0
	SLT ADI R4, -4096
	AND R3, R4, R4
.LBB13_29:                              ; %if.end50.1
	INT LOD R7, R3, 0
	ADD R3, R4, R3
	INT STR R7, R3, 0
.LBB13_30:                              ; %for.inc.1
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
	H LDI R15, %hi(.LBB13_34)
	SLT ADI R15, %lo(.LBB13_34)
	BRH EQ, R15
; %bb.31:                               ; %if.end50.2
	INT LOD R7, R6, 0
	LDI R7, 0
	H LDI R7, 49152
	SLT ADI R7, 0
	ADD R6, R7, R6
	INT STR R5, R6, 0
	LDI R5, 4096
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB13_33)
	SLT ADI R15, %lo(.LBB13_33)
	BRH NC, R15
; %bb.32:
	ADI R4, 4095
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -4096
	AND R4, R5, R5
.LBB13_33:                              ; %if.end50.2
	INT LOD R14, R7, -8
	INT LOD R7, R4, 0
	ADD R4, R5, R4
	INT STR R7, R4, 0
.LBB13_34:                              ; %for.inc.2
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 28
	ADD R12, R4, R4
	INT STR R4, R3, 0
	INT LOD R4, R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB13_35)
	SLT ADI R15, %lo(.LBB13_35)
	BRH EQ, R15
; %bb.36:                               ; %if.end50.3
	INT LOD R7, R2, 0
	LDI R5, 0
	H LDI R5, 49152
	SLT ADI R5, 0
	ADD R2, R5, R2
	INT STR R4, R2, 0
	LDI R2, 4097
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB13_37)
	SLT ADI R15, %lo(.LBB13_37)
	BRH NC, R15
; %bb.38:                               ; %if.then54.3
	INT LOD R7, R2, 0
	ADI R2, 4096
	H LDI R15, %hi(.LBB13_39)
	SLT ADI R15, %lo(.LBB13_39)
	JMP R15
.LBB13_35:                              ; %for.inc.2.for.inc.3_crit_edge
	INT LOD R7, R2, 0
	H LDI R15, %hi(.LBB13_40)
	SLT ADI R15, %lo(.LBB13_40)
	JMP R15
.LBB13_37:                              ; %if.else.3
	ADI R3, 4095
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -4096
	AND R3, R2, R2
	INT LOD R7, R3, 0
	ADD R3, R2, R2
.LBB13_39:                              ; %for.inc.3
	INT STR R7, R2, 0
.LBB13_40:                              ; %for.inc.3
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
.LBB13_41:                              ; %for.end168
	INT LOD R14, R13, -44
	INT LOD R14, R12, -40
	INT LOD R14, R11, -36
	INT LOD R14, R10, -32
	INT LOD R14, R9, -28
	INT LOD R14, R8, -24
	SLT ADI R14, -48
	RET
.Lfunc_end13:
	.size	bus_Enumeration, .Lfunc_end13-bus_Enumeration
                                        ; -- End function
	.globl	PCIe_Bus_Enumeration            ; -- Begin function PCIe_Bus_Enumeration
	.type	PCIe_Bus_Enumeration,@function
PCIe_Bus_Enumeration:                   ; @PCIe_Bus_Enumeration
; %bb.0:                                ; %entry
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
.Lfunc_end14:
	.size	PCIe_Bus_Enumeration, .Lfunc_end14-PCIe_Bus_Enumeration
                                        ; -- End function
	.globl	search                          ; -- Begin function search
	.type	search,@function
search:                                 ; @search
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	SLT ADD R1, R0, R2
	LDI R1, 0
	H LDI R1, map_size
	SLT ADI R1, map_size
	INT LOD R1, R3, 0
	LDI R1, 1
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB15_4)
	SLT ADI R15, %lo(.LBB15_4)
	BRH N, R15
; %bb.1:                                ; %for.body.lr.ph
	LDI R1, 0
	LDI R4, 0
	H LDI R4, mapa
	SLT ADI R4, mapa
	INT LOD R4, R4, 0
	ADI R4, 12
	LDI R5, 0
	H LDI R5, 256
	SLT ADI R5, -1
.LBB15_2:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	INT LOD R4, R6, 0
	AND R6, R5, R6
	SUB R6, R2, R0
	H LDI R15, %hi(.LBB15_5)
	SLT ADI R15, %lo(.LBB15_5)
	BRH EQ, R15
; %bb.3:                                ; %for.inc
                                        ;   in Loop: Header=BB15_2 Depth=1
	ADI R4, 20
	ADI R1, 1
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB15_2)
	SLT ADI R15, %lo(.LBB15_2)
	BRH NE, R15
.LBB15_4:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
.LBB15_5:                               ; %cleanup
	SLT ADI R14, -4
	RET
.Lfunc_end15:
	.size	search, .Lfunc_end15-search
                                        ; -- End function
	.globl	mainHandler                     ; -- Begin function mainHandler
	.type	mainHandler,@function
mainHandler:                            ; @mainHandler
; %bb.0:                                ; %entry
	SLT ADI R14, 24
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	;APP
	CYE SR1, R8
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
	CYE SR7, R9
	;NO_APP
	LDI R3, 0
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB16_2)
	SLT ADI R15, %lo(.LBB16_2)
	BRH EQ, R15
; %bb.1:                                ; %if.then
	LDI R4, 4
	NOR R2, R4, R4
	NOR R4, R4, R4
	;APP
	CYR R4, SR8
	;NO_APP
.LBB16_2:                               ; %if.end
	SUB R9, R3, R0
	H LDI R15, %hi(.LBB16_8)
	SLT ADI R15, %lo(.LBB16_8)
	BRH EQ, R15
; %bb.3:                                ; %if.then2
	LDI R1, 127
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB16_4)
	SLT ADI R15, %lo(.LBB16_4)
	BRH C, R15
; %bb.5:                                ; %land.lhs.true
	LDI R1, 2
	LSH R9, R1, R1
	LDI R4, 0
	H LDI R4, irq_table
	SLT ADI R4, irq_table
	ADD R1, R4, R1
	INT LOD R1, R4, 0
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB16_6)
	SLT ADI R15, %lo(.LBB16_6)
	BRH EQ, R15
; %bb.13:                               ; %if.then5
	SLT ADD R2, R0, R1
	SLT ADD R8, R0, R2
	CAL R4
	H LDI R15, %hi(.LBB16_9)
	SLT ADI R15, %lo(.LBB16_9)
	JMP R15
.LBB16_8:                               ; %if.else9
	SLT ADD R8, R0, R3
	H LDI R15, %hi(syscallsHandler)
	SLT ADI R15, %lo(syscallsHandler)
	CAL R15
.LBB16_9:                               ; %if.end11
	SLT ADD R1, R0, R8
	H LDI R15, %hi(.LBB16_10)
	SLT ADI R15, %lo(.LBB16_10)
	JMP R15
.LBB16_4:
	LDI R1, 0
	H LDI R1, .L.str.1.24
	SLT ADI R1, .L.str.1.24
	H LDI R15, %hi(.LBB16_7)
	SLT ADI R15, %lo(.LBB16_7)
	JMP R15
.LBB16_6:
	LDI R1, 0
	H LDI R1, .L.str.23
	SLT ADI R1, .L.str.23
.LBB16_7:                               ; %if.else
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
.LBB16_10:                              ; %if.end11
	;APP
	CYR R10, SR8
	;NO_APP
	;APP
	CYR R8, SR1
	;NO_APP
	;APP
	CYR R11, SR9
	;NO_APP
	;APP
	CYR R12, SR10
	;NO_APP
	LDI R1, 16
	SUB R9, R1, R0
	H LDI R15, %hi(.LBB16_12)
	SLT ADI R15, %lo(.LBB16_12)
	BRH C, R15
; %bb.11:                               ; %if.then13
	LDI R1, 0
	H LDI R1, Registros
	SLT ADI R1, Registros
	INT LOD R1, R1, 0
	LDI R2, 1
	INT STR R1, R2, 16
.LBB16_12:                              ; %if.end14
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -24
	RET
.Lfunc_end16:
	.size	mainHandler, .Lfunc_end16-mainHandler
                                        ; -- End function
	.globl	entryHandler                    ; -- Begin function entryHandler
	.type	entryHandler,@function
entryHandler:                           ; @entryHandler
; %bb.0:                                ; %entry
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
.Lfunc_end17:
	.size	entryHandler, .Lfunc_end17-entryHandler
                                        ; -- End function
	.globl	initMSI                         ; -- Begin function initMSI
	.type	initMSI,@function
initMSI:                                ; @initMSI
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	INT LOD R1, R4, 36
	ADD R4, R1, R1
	INT LOD R1, R4, 0
	LDI R5, 255
	AND R4, R5, R4
	LDI R5, 5
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB18_5)
	SLT ADI R15, %lo(.LBB18_5)
	BRH NE, R15
; %bb.1:                                ; %if.then
	INT LOD R1, R4, 0
	LDI R5, 0
	H LDI R5, 65248
	SLT ADI R5, 44
	INT STR R1, R5, 4
	INT STR R1, R2, 8
	LDI R5, 127
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB18_4)
	SLT ADI R15, %lo(.LBB18_4)
	BRH C, R15
; %bb.2:                                ; %if.then
	LDI R5, 0
	SUB R3, R5, R0
	H LDI R15, %hi(.LBB18_4)
	SLT ADI R15, %lo(.LBB18_4)
	BRH EQ, R15
; %bb.3:                                ; %if.then11
	LDI R5, 2
	LSH R2, R5, R2
	LDI R5, 0
	H LDI R5, irq_table
	SLT ADI R5, irq_table
	ADD R2, R5, R2
	INT STR R2, R3, 0
.LBB18_4:                               ; %if.end
	LDI R2, 13
	RSH R4, R2, R2
	LDI R3, 112
	AND R2, R3, R2
	LDI R3, 1
	NOR R2, R3, R2
	NOR R2, R2, R2
	INT STR R1, R2, 0
.LBB18_5:                               ; %if.end14
	SLT ADI R14, -4
	RET
.Lfunc_end18:
	.size	initMSI, .Lfunc_end18-initMSI
                                        ; -- End function
	.globl	initLAPIC                       ; -- Begin function initLAPIC
	.type	initLAPIC,@function
initLAPIC:                              ; @initLAPIC
; %bb.0:                                ; %entry
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
.Lfunc_end19:
	.size	initLAPIC, .Lfunc_end19-initLAPIC
                                        ; -- End function
	.globl	pageFault                       ; -- Begin function pageFault
	.type	pageFault,@function
pageFault:                              ; @pageFault
; %bb.0:                                ; %entry
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
	H LDI R1, .L.str.31
	SLT ADI R1, .L.str.31
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
.Lfunc_end20:
	.size	pageFault, .Lfunc_end20-pageFault
                                        ; -- End function
	.globl	alignamentFault                 ; -- Begin function alignamentFault
	.type	alignamentFault,@function
alignamentFault:                        ; @alignamentFault
; %bb.0:                                ; %entry
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
	H LDI R1, .L.str.1.34
	SLT ADI R1, .L.str.1.34
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
.Lfunc_end21:
	.size	alignamentFault, .Lfunc_end21-alignamentFault
                                        ; -- End function
	.globl	generalProtectionFault          ; -- Begin function generalProtectionFault
	.type	generalProtectionFault,@function
generalProtectionFault:                 ; @generalProtectionFault
; %bb.0:                                ; %entry
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
	H LDI R1, .L.str.2.37
	SLT ADI R1, .L.str.2.37
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
.Lfunc_end22:
	.size	generalProtectionFault, .Lfunc_end22-generalProtectionFault
                                        ; -- End function
	.globl	invalidOpCode                   ; -- Begin function invalidOpCode
	.type	invalidOpCode,@function
invalidOpCode:                          ; @invalidOpCode
; %bb.0:                                ; %entry
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
	H LDI R1, .L.str.3.40
	SLT ADI R1, .L.str.3.40
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
.Lfunc_end23:
	.size	invalidOpCode, .Lfunc_end23-invalidOpCode
                                        ; -- End function
	.globl	doubleFault                     ; -- Begin function doubleFault
	.type	doubleFault,@function
doubleFault:                            ; @doubleFault
; %bb.0:                                ; %entry
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
	H LDI R1, .L.str.4.43
	SLT ADI R1, .L.str.4.43
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
	.size	doubleFault, .Lfunc_end24-doubleFault
                                        ; -- End function
	.globl	syscallsHandler                 ; -- Begin function syscallsHandler
	.type	syscallsHandler,@function
syscallsHandler:                        ; @syscallsHandler
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	SLT ADD R3, R0, R1
	ADI R1, 4
	SLT ADI R14, -4
	RET
.Lfunc_end25:
	.size	syscallsHandler, .Lfunc_end25-syscallsHandler
                                        ; -- End function
	.globl	ToAscii                         ; -- Begin function ToAscii
	.type	ToAscii,@function
ToAscii:                                ; @ToAscii
; %bb.0:                                ; %entry
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
	H LDI R15, %hi(.LBB26_35)
	SLT ADI R15, %lo(.LBB26_35)
	BRH EQ, R15
; %bb.1:                                ; %entry
	LDI R7, 2
	SUB R2, R7, R0
	H LDI R15, %hi(.LBB26_29)
	SLT ADI R15, %lo(.LBB26_29)
	BRH EQ, R15
; %bb.2:                                ; %entry
	LDI R7, 3
	SUB R2, R7, R0
	H LDI R15, %hi(.LBB26_3)
	SLT ADI R15, %lo(.LBB26_3)
	BRH NE, R15
; %bb.4:                                ; %for.body.preheader
	LDI R2, 8
	RSH R1, R2, R2
	LDI R6, 15
	AND R2, R6, R2
	LDI R4, 48
	LDI R7, 10
	SUB R2, R7, R0
	H LDI R15, %hi(.LBB26_5)
	SLT ADI R15, %lo(.LBB26_5)
	BRH C, R15
; %bb.6:                                ; %for.body.preheader
	ADI R2, 55
	H LDI R15, %hi(.LBB26_7)
	SLT ADI R15, %lo(.LBB26_7)
	JMP R15
.LBB26_29:                              ; %if.then10
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB26_49)
	SLT ADI R15, %lo(.LBB26_49)
	BRH EQ, R15
; %bb.30:
	LDI R2, 15
	LDI R6, 48
	LDI R7, 10
	LDI R8, 4
	SLT ADD R5, R0, R3
	H LDI R15, %hi(.LBB26_31)
	SLT ADI R15, %lo(.LBB26_31)
	JMP R15
.LBB26_33:                              ; %while.body
                                        ;   in Loop: Header=BB26_31 Depth=1
	ADI R5, 55
.LBB26_34:                              ; %while.body
                                        ;   in Loop: Header=BB26_31 Depth=1
	CHAR STR R3, R5, -1
	RSH R1, R8, R1
	ADI R3, -1
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB26_48)
	SLT ADI R15, %lo(.LBB26_48)
	BRH EQ, R15
.LBB26_31:                              ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	AND R1, R2, R5
	SUB R5, R7, R0
	H LDI R15, %hi(.LBB26_33)
	SLT ADI R15, %lo(.LBB26_33)
	BRH NC, R15
; %bb.32:                               ;   in Loop: Header=BB26_31 Depth=1
	NOR R5, R6, R5
	NOR R5, R5, R5
	H LDI R15, %hi(.LBB26_34)
	SLT ADI R15, %lo(.LBB26_34)
	JMP R15
.LBB26_35:                              ; %if.then35
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -1
	SLT ADD R6, R0, R2
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB26_37)
	SLT ADI R15, %lo(.LBB26_37)
	BRH N, R15
; %bb.36:                               ; %if.then35
	SLT ADD R4, R0, R2
.LBB26_37:                              ; %if.then35
	INT STR R14, R2, -4
	LDI R8, 31
	SLT ADD R1, R0, R7
	SUB R8, R4, R0
	H LDI R15, %hi(.LBB26_39)
	SLT ADI R15, %lo(.LBB26_39)
	BRH EQ, R15
; %bb.38:                               ; %if.then35
	RSH R1, R8, R7
	LSH R7, R6, R8
	SUB R7, R8, R7
.LBB26_39:                              ; %if.then35
	XOR R1, R7, R1
	SUB R1, R7, R1
	H LDI R15, %hi(.LBB26_40)
	SLT ADI R15, %lo(.LBB26_40)
	JMP R15
.LBB26_3:
	INT STR R14, R6, -4
.LBB26_40:                              ; %if.end40
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB26_50)
	SLT ADI R15, %lo(.LBB26_50)
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
	H LDI R15, %hi(.LBB26_42)
	SLT ADI R15, %lo(.LBB26_42)
	JMP R15
.LBB26_44:                              ; %while.body51
                                        ;   in Loop: Header=BB26_42 Depth=1
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
	H LDI R15, %hi(.LBB26_45)
	SLT ADI R15, %lo(.LBB26_45)
	BRH NC, R15
.LBB26_42:                              ; %while.body51
                                        ; =>This Inner Loop Header: Depth=1
	SLT ADD R1, R0, R12
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB26_44)
	SLT ADI R15, %lo(.LBB26_44)
	BRH EQ, R15
; %bb.43:                               ; %while.body51
                                        ;   in Loop: Header=BB26_42 Depth=1
	RSH R12, R3, R1
	LSH R1, R6, R13
	SUB R1, R13, R1
	H LDI R15, %hi(.LBB26_44)
	SLT ADI R15, %lo(.LBB26_44)
	JMP R15
.LBB26_5:
	NOR R2, R4, R2
	NOR R2, R2, R2
.LBB26_7:                               ; %for.body.preheader
	LDI R5, 4
	RSH R1, R5, R5
	AND R5, R6, R5
	SUB R5, R7, R0
	H LDI R15, %hi(.LBB26_8)
	SLT ADI R15, %lo(.LBB26_8)
	BRH C, R15
; %bb.9:                                ; %for.body.preheader
	ADI R5, 55
	AND R1, R6, R8
	SUB R8, R7, R0
	H LDI R15, %hi(.LBB26_12)
	SLT ADI R15, %lo(.LBB26_12)
	BRH NC, R15
.LBB26_11:
	NOR R8, R4, R8
	NOR R8, R8, R8
	H LDI R15, %hi(.LBB26_13)
	SLT ADI R15, %lo(.LBB26_13)
	JMP R15
.LBB26_8:
	NOR R5, R4, R5
	NOR R5, R5, R5
	AND R1, R6, R8
	SUB R8, R7, R0
	H LDI R15, %hi(.LBB26_11)
	SLT ADI R15, %lo(.LBB26_11)
	BRH C, R15
.LBB26_12:                              ; %for.body.preheader
	ADI R8, 55
.LBB26_13:                              ; %for.body.preheader
	LDI R9, 24
	RSH R1, R9, R9
	AND R9, R6, R9
	SUB R9, R7, R0
	H LDI R15, %hi(.LBB26_14)
	SLT ADI R15, %lo(.LBB26_14)
	BRH C, R15
; %bb.15:                               ; %for.body.preheader
	ADI R9, 55
	H LDI R15, %hi(.LBB26_16)
	SLT ADI R15, %lo(.LBB26_16)
	JMP R15
.LBB26_14:
	NOR R9, R4, R9
	NOR R9, R9, R9
.LBB26_16:                              ; %for.body.preheader
	LDI R10, 20
	RSH R1, R10, R10
	AND R10, R6, R10
	SUB R10, R7, R0
	H LDI R15, %hi(.LBB26_17)
	SLT ADI R15, %lo(.LBB26_17)
	BRH C, R15
; %bb.18:                               ; %for.body.preheader
	ADI R10, 55
	H LDI R15, %hi(.LBB26_19)
	SLT ADI R15, %lo(.LBB26_19)
	JMP R15
.LBB26_17:
	NOR R10, R4, R10
	NOR R10, R10, R10
.LBB26_19:                              ; %for.body.preheader
	LDI R11, 16
	RSH R1, R11, R11
	AND R11, R6, R11
	SUB R11, R7, R0
	H LDI R15, %hi(.LBB26_20)
	SLT ADI R15, %lo(.LBB26_20)
	BRH C, R15
; %bb.21:                               ; %for.body.preheader
	ADI R11, 55
	H LDI R15, %hi(.LBB26_22)
	SLT ADI R15, %lo(.LBB26_22)
	JMP R15
.LBB26_20:
	NOR R11, R4, R11
	NOR R11, R11, R11
.LBB26_22:                              ; %for.body.preheader
	LDI R12, 12
	RSH R1, R12, R12
	AND R12, R6, R6
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB26_23)
	SLT ADI R15, %lo(.LBB26_23)
	BRH C, R15
; %bb.24:                               ; %for.body.preheader
	ADI R6, 55
	H LDI R15, %hi(.LBB26_25)
	SLT ADI R15, %lo(.LBB26_25)
	JMP R15
.LBB26_23:
	NOR R6, R4, R6
	NOR R6, R6, R6
.LBB26_25:                              ; %for.body.preheader
	LDI R7, 28
	RSH R1, R7, R7
	LDI R12, 0
	H LDI R12, 40960
	SLT ADI R12, 0
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB26_26)
	SLT ADI R15, %lo(.LBB26_26)
	BRH C, R15
; %bb.27:                               ; %for.body.preheader
	ADI R7, 55
	H LDI R15, %hi(.LBB26_28)
	SLT ADI R15, %lo(.LBB26_28)
	JMP R15
.LBB26_26:
	NOR R7, R4, R1
	NOR R1, R1, R7
.LBB26_28:                              ; %for.body.preheader
	CHAR STR R3, R8, 30
	CHAR STR R3, R7, 23
	CHAR STR R3, R5, 29
	CHAR STR R3, R2, 28
	CHAR STR R3, R6, 27
	CHAR STR R3, R11, 26
	CHAR STR R3, R10, 25
	CHAR STR R3, R9, 24
	ADI R3, 23
	H LDI R15, %hi(.LBB26_48)
	SLT ADI R15, %lo(.LBB26_48)
	JMP R15
.LBB26_50:                              ; %if.then45
	LDI R1, 48
	CHAR STR R3, R1, 30
	ADI R3, 30
	SLT ADD R3, R0, R5
.LBB26_45:                              ; %if.end59
	INT LOD R14, R1, -4
	AND R1, R6, R1
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB26_47)
	SLT ADI R15, %lo(.LBB26_47)
	BRH NE, R15
; %bb.46:                               ; %if.then61
	LDI R1, 45
	CHAR STR R5, R1, -1
	ADI R5, -1
.LBB26_47:                              ; %cleanup
	SLT ADD R5, R0, R3
.LBB26_48:                              ; %cleanup
	SLT ADD R3, R0, R1
	INT LOD R14, R13, -28
	INT LOD R14, R12, -24
	INT LOD R14, R11, -20
	INT LOD R14, R10, -16
	INT LOD R14, R9, -12
	INT LOD R14, R8, -8
	SLT ADI R14, -32
	RET
.LBB26_49:                              ; %if.then13
	LDI R1, 48
	CHAR STR R3, R1, 30
	ADI R3, 30
	H LDI R15, %hi(.LBB26_48)
	SLT ADI R15, %lo(.LBB26_48)
	JMP R15
.Lfunc_end26:
	.size	ToAscii, .Lfunc_end26-ToAscii
                                        ; -- End function
	.globl	__udivsi3                       ; -- Begin function __udivsi3
	.type	__udivsi3,@function
__udivsi3:                              ; @__udivsi3
; %bb.0:                                ; %entry
	SLT ADI R14, 16
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	LDI R4, 0
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB27_1)
	SLT ADI R15, %lo(.LBB27_1)
	BRH EQ, R15
; %bb.2:                                ; %for.body.preheader
	LDI R5, 31
	LDI R6, 1
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -1
	SLT ADD R4, R0, R8
	SLT ADD R4, R0, R3
	H LDI R15, %hi(.LBB27_3)
	SLT ADI R15, %lo(.LBB27_3)
	JMP R15
.LBB27_7:                               ; %for.body
                                        ;   in Loop: Header=BB27_3 Depth=1
	SUB R8, R10, R8
	NOR R9, R3, R3
	NOR R3, R3, R3
	ADI R5, -1
	SUB R5, R7, R0
	H LDI R15, %hi(.LBB27_8)
	SLT ADI R15, %lo(.LBB27_8)
	BRH EQ, R15
.LBB27_3:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	LSH R8, R6, R8
	RSH R1, R5, R9
	AND R9, R6, R9
	NOR R9, R8, R8
	NOR R8, R8, R8
	SLT ADD R4, R0, R9
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB27_5)
	SLT ADI R15, %lo(.LBB27_5)
	BRH C, R15
; %bb.4:                                ; %for.body
                                        ;   in Loop: Header=BB27_3 Depth=1
	LSH R6, R5, R9
.LBB27_5:                               ; %for.body
                                        ;   in Loop: Header=BB27_3 Depth=1
	SLT ADD R4, R0, R10
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB27_7)
	SLT ADI R15, %lo(.LBB27_7)
	BRH C, R15
; %bb.6:                                ; %for.body
                                        ;   in Loop: Header=BB27_3 Depth=1
	SLT ADD R2, R0, R10
	H LDI R15, %hi(.LBB27_7)
	SLT ADI R15, %lo(.LBB27_7)
	JMP R15
.LBB27_1:
	SLT ADD R4, R0, R3
.LBB27_8:                               ; %return
	SLT ADD R3, R0, R1
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -16
	RET
.Lfunc_end27:
	.size	__udivsi3, .Lfunc_end27-__udivsi3
                                        ; -- End function
	.globl	__umodsi3                       ; -- Begin function __umodsi3
	.type	__umodsi3,@function
__umodsi3:                              ; @__umodsi3
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	SLT ADD R1, R0, R3
	LDI R1, 0
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB28_66)
	SLT ADI R15, %lo(.LBB28_66)
	BRH EQ, R15
; %bb.1:                                ; %for.body.preheader
	LDI R4, 31
	RSH R3, R4, R4
	SLT ADD R1, R0, R5
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB28_3)
	SLT ADI R15, %lo(.LBB28_3)
	BRH C, R15
; %bb.2:                                ; %for.body.preheader
	SLT ADD R2, R0, R5
.LBB28_3:                               ; %for.body.preheader
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
	H LDI R15, %hi(.LBB28_5)
	SLT ADI R15, %lo(.LBB28_5)
	BRH C, R15
; %bb.4:                                ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_5:                               ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 29
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_7)
	SLT ADI R15, %lo(.LBB28_7)
	BRH C, R15
; %bb.6:                                ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_7:                               ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 28
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_9)
	SLT ADI R15, %lo(.LBB28_9)
	BRH C, R15
; %bb.8:                                ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_9:                               ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 27
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_11)
	SLT ADI R15, %lo(.LBB28_11)
	BRH C, R15
; %bb.10:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_11:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 26
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_13)
	SLT ADI R15, %lo(.LBB28_13)
	BRH C, R15
; %bb.12:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_13:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 25
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_15)
	SLT ADI R15, %lo(.LBB28_15)
	BRH C, R15
; %bb.14:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_15:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 24
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_17)
	SLT ADI R15, %lo(.LBB28_17)
	BRH C, R15
; %bb.16:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_17:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 23
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_19)
	SLT ADI R15, %lo(.LBB28_19)
	BRH C, R15
; %bb.18:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_19:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 22
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_21)
	SLT ADI R15, %lo(.LBB28_21)
	BRH C, R15
; %bb.20:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_21:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 21
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_23)
	SLT ADI R15, %lo(.LBB28_23)
	BRH C, R15
; %bb.22:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_23:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 20
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_25)
	SLT ADI R15, %lo(.LBB28_25)
	BRH C, R15
; %bb.24:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_25:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 19
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_27)
	SLT ADI R15, %lo(.LBB28_27)
	BRH C, R15
; %bb.26:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_27:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 18
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_29)
	SLT ADI R15, %lo(.LBB28_29)
	BRH C, R15
; %bb.28:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_29:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 17
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_31)
	SLT ADI R15, %lo(.LBB28_31)
	BRH C, R15
; %bb.30:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_31:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 16
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_33)
	SLT ADI R15, %lo(.LBB28_33)
	BRH C, R15
; %bb.32:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_33:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 15
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_35)
	SLT ADI R15, %lo(.LBB28_35)
	BRH C, R15
; %bb.34:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_35:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 14
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_37)
	SLT ADI R15, %lo(.LBB28_37)
	BRH C, R15
; %bb.36:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_37:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 13
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_39)
	SLT ADI R15, %lo(.LBB28_39)
	BRH C, R15
; %bb.38:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_39:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 12
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_41)
	SLT ADI R15, %lo(.LBB28_41)
	BRH C, R15
; %bb.40:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_41:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 11
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_43)
	SLT ADI R15, %lo(.LBB28_43)
	BRH C, R15
; %bb.42:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_43:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 10
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_45)
	SLT ADI R15, %lo(.LBB28_45)
	BRH C, R15
; %bb.44:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_45:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 9
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_47)
	SLT ADI R15, %lo(.LBB28_47)
	BRH C, R15
; %bb.46:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_47:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 8
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_49)
	SLT ADI R15, %lo(.LBB28_49)
	BRH C, R15
; %bb.48:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_49:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 7
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_51)
	SLT ADI R15, %lo(.LBB28_51)
	BRH C, R15
; %bb.50:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_51:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 6
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_53)
	SLT ADI R15, %lo(.LBB28_53)
	BRH C, R15
; %bb.52:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_53:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 5
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_55)
	SLT ADI R15, %lo(.LBB28_55)
	BRH C, R15
; %bb.54:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_55:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 4
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_57)
	SLT ADI R15, %lo(.LBB28_57)
	BRH C, R15
; %bb.56:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_57:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 3
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_59)
	SLT ADI R15, %lo(.LBB28_59)
	BRH C, R15
; %bb.58:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_59:                              ; %for.body.preheader
	SUB R5, R6, R5
	LDI R6, 2
	RSH R3, R6, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_61)
	SLT ADI R15, %lo(.LBB28_61)
	BRH C, R15
; %bb.60:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_61:                              ; %for.body.preheader
	SUB R5, R6, R5
	RSH R3, R4, R6
	AND R6, R4, R6
	LSH R5, R4, R5
	NOR R6, R5, R5
	NOR R5, R5, R5
	SLT ADD R1, R0, R6
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB28_63)
	SLT ADI R15, %lo(.LBB28_63)
	BRH C, R15
; %bb.62:                               ; %for.body.preheader
	SLT ADD R2, R0, R6
.LBB28_63:                              ; %for.body.preheader
	SUB R5, R6, R5
	AND R3, R4, R3
	LSH R5, R4, R4
	NOR R3, R4, R3
	NOR R3, R3, R3
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB28_65)
	SLT ADI R15, %lo(.LBB28_65)
	BRH C, R15
; %bb.64:                               ; %for.body.preheader
	SLT ADD R2, R0, R1
.LBB28_65:                              ; %for.body.preheader
	SUB R3, R1, R1
.LBB28_66:                              ; %return
	SLT ADI R14, -4
	RET
.Lfunc_end28:
	.size	__umodsi3, .Lfunc_end28-__umodsi3
                                        ; -- End function
	.globl	strcmp                          ; -- Begin function strcmp
	.type	strcmp,@function
strcmp:                                 ; @strcmp
; %bb.0:                                ; %entry
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
	H LDI R15, %hi(.LBB29_5)
	SLT ADI R15, %lo(.LBB29_5)
	BRH EQ, R15
.LBB29_1:                               ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R5, 0
	CHAR LOD R1, R6, 0
	SUB R6, R3, R0
	H LDI R15, %hi(.LBB29_3)
	SLT ADI R15, %lo(.LBB29_3)
	BRH EQ, R15
; %bb.2:                                ; %while.body
                                        ;   in Loop: Header=BB29_1 Depth=1
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB29_3)
	SLT ADI R15, %lo(.LBB29_3)
	BRH NE, R15
; %bb.4:                                ; %if.end
                                        ;   in Loop: Header=BB29_1 Depth=1
	ADI R2, 1
	ADI R1, 1
	AND R1, R4, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB29_1)
	SLT ADI R15, %lo(.LBB29_1)
	BRH NE, R15
.LBB29_5:                               ; %while.cond9.preheader
	LDI R7, 8
	LDI R8, 0
	H LDI R8, 257
	SLT ADI R8, 256
	LDI R9, 0
	H LDI R9, 32897
	SLT ADI R9, -32640
	LDI R4, 255
	H LDI R15, %hi(.LBB29_6)
	SLT ADI R15, %lo(.LBB29_6)
	JMP R15
.LBB29_19:                              ; %cleanup39
                                        ;   in Loop: Header=BB29_6 Depth=1
	ADI R2, 4
	ADI R1, 4
.LBB29_6:                               ; %while.cond9
                                        ; =>This Inner Loop Header: Depth=1
	INT LOD R1, R10, 0
	INT LOD R2, R13, 0
	SUB R8, R10, R11
	NOR R11, R10, R11
	NOR R11, R11, R11
	AND R11, R9, R11
	SUB R11, R9, R0
	H LDI R15, %hi(.LBB29_8)
	SLT ADI R15, %lo(.LBB29_8)
	BRH NE, R15
; %bb.7:                                ; %while.cond9
                                        ;   in Loop: Header=BB29_6 Depth=1
	SUB R10, R13, R0
	H LDI R15, %hi(.LBB29_19)
	SLT ADI R15, %lo(.LBB29_19)
	BRH EQ, R15
.LBB29_8:                               ; %for.body.preheader
                                        ;   in Loop: Header=BB29_6 Depth=1
	AND R10, R4, R11
	SUB R11, R3, R0
	H LDI R15, %hi(.LBB29_9)
	SLT ADI R15, %lo(.LBB29_9)
	BRH EQ, R15
; %bb.10:                               ; %for.body.preheader
                                        ;   in Loop: Header=BB29_6 Depth=1
	AND R13, R4, R5
	AND R10, R4, R6
	SLT ADD R10, R0, R11
	SLT ADD R13, R0, R12
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB29_17)
	SLT ADI R15, %lo(.LBB29_17)
	BRH NE, R15
; %bb.11:                               ; %for.cond
                                        ;   in Loop: Header=BB29_6 Depth=1
	RSH R13, R7, R12
	RSH R10, R7, R11
	AND R11, R4, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB29_17)
	SLT ADI R15, %lo(.LBB29_17)
	BRH EQ, R15
; %bb.12:                               ; %for.cond
                                        ;   in Loop: Header=BB29_6 Depth=1
	AND R12, R4, R5
	AND R11, R4, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB29_17)
	SLT ADI R15, %lo(.LBB29_17)
	BRH NE, R15
; %bb.13:                               ; %for.cond.1
                                        ;   in Loop: Header=BB29_6 Depth=1
	LDI R5, 16
	RSH R13, R5, R12
	RSH R10, R5, R11
	AND R11, R4, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB29_17)
	SLT ADI R15, %lo(.LBB29_17)
	BRH EQ, R15
; %bb.14:                               ; %for.cond.1
                                        ;   in Loop: Header=BB29_6 Depth=1
	AND R12, R4, R5
	AND R11, R4, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB29_17)
	SLT ADI R15, %lo(.LBB29_17)
	BRH NE, R15
; %bb.15:                               ; %for.cond.2
                                        ;   in Loop: Header=BB29_6 Depth=1
	LDI R5, 24
	RSH R13, R5, R12
	RSH R10, R5, R11
	SUB R11, R3, R0
	H LDI R15, %hi(.LBB29_17)
	SLT ADI R15, %lo(.LBB29_17)
	BRH EQ, R15
; %bb.16:                               ; %for.cond.2
                                        ;   in Loop: Header=BB29_6 Depth=1
	SUB R11, R12, R0
	H LDI R15, %hi(.LBB29_19)
	SLT ADI R15, %lo(.LBB29_19)
	BRH EQ, R15
	H LDI R15, %hi(.LBB29_17)
	SLT ADI R15, %lo(.LBB29_17)
	JMP R15
.LBB29_3:                               ; %if.then
	SUB R6, R5, R1
	H LDI R15, %hi(.LBB29_18)
	SLT ADI R15, %lo(.LBB29_18)
	JMP R15
.LBB29_9:
	SLT ADD R10, R0, R11
	SLT ADD R13, R0, R12
.LBB29_17:                              ; %cleanup39.thread
	AND R12, R4, R1
	AND R11, R4, R2
	SUB R2, R1, R1
.LBB29_18:                              ; %return
	INT LOD R14, R13, -24
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -28
	RET
.Lfunc_end29:
	.size	strcmp, .Lfunc_end29-strcmp
                                        ; -- End function
	.globl	strlen                          ; -- Begin function strlen
	.type	strlen,@function
strlen:                                 ; @strlen
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	LDI R4, 3
	AND R1, R4, R5
	LDI R3, 0
	SLT ADD R1, R0, R2
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB30_6)
	SLT ADI R15, %lo(.LBB30_6)
	BRH EQ, R15
; %bb.1:                                ; %while.body.preheader
	CHAR LOD R1, R2, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB30_2)
	SLT ADI R15, %lo(.LBB30_2)
	BRH EQ, R15
; %bb.4:                                ; %if.end.preheader
	SLT ADD R1, R0, R5
	ADI R5, 1
.LBB30_5:                               ; %if.end
                                        ; =>This Inner Loop Header: Depth=1
	SLT ADD R5, R0, R2
	AND R2, R4, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB30_6)
	SLT ADI R15, %lo(.LBB30_6)
	BRH EQ, R15
; %bb.3:                                ; %while.body
                                        ;   in Loop: Header=BB30_5 Depth=1
	SLT ADD R2, R0, R5
	ADI R5, 1
	CHAR LOD R2, R6, 0
	SUB R6, R3, R0
	H LDI R15, %hi(.LBB30_5)
	SLT ADI R15, %lo(.LBB30_5)
	BRH NE, R15
	H LDI R15, %hi(.LBB30_14)
	SLT ADI R15, %lo(.LBB30_14)
	JMP R15
.LBB30_6:                               ; %while.cond2.preheader
	ADI R2, -2
	LDI R5, 0
	H LDI R5, 257
	SLT ADI R5, 256
	LDI R6, 0
	H LDI R6, 32897
	SLT ADI R6, -32640
.LBB30_7:                               ; %while.cond2
                                        ; =>This Inner Loop Header: Depth=1
	INT LOD R2, R4, 2
	ADI R2, 4
	SUB R5, R4, R7
	NOR R7, R4, R7
	NOR R7, R7, R7
	AND R7, R6, R7
	SUB R7, R6, R0
	H LDI R15, %hi(.LBB30_7)
	SLT ADI R15, %lo(.LBB30_7)
	BRH EQ, R15
; %bb.8:                                ; %if.then7
	LDI R5, 255
	AND R4, R5, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB30_9)
	SLT ADI R15, %lo(.LBB30_9)
	BRH EQ, R15
; %bb.10:                               ; %if.end15
	LDI R5, 0
	H LDI R5, 1
	SLT ADI R5, -256
	AND R4, R5, R5
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB30_11)
	SLT ADI R15, %lo(.LBB30_11)
	BRH EQ, R15
; %bb.12:                               ; %if.end24
	LDI R5, 0
	H LDI R5, 255
	SLT ADI R5, 0
	AND R4, R5, R4
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB30_14)
	SLT ADI R15, %lo(.LBB30_14)
	BRH EQ, R15
; %bb.13:                               ; %if.end34
	ADI R2, 1
	H LDI R15, %hi(.LBB30_14)
	SLT ADI R15, %lo(.LBB30_14)
	JMP R15
.LBB30_2:
	SLT ADD R1, R0, R2
	H LDI R15, %hi(.LBB30_14)
	SLT ADI R15, %lo(.LBB30_14)
	JMP R15
.LBB30_9:                               ; %if.then11
	ADI R2, -2
	H LDI R15, %hi(.LBB30_14)
	SLT ADI R15, %lo(.LBB30_14)
	JMP R15
.LBB30_11:                              ; %if.then20
	ADI R2, -1
.LBB30_14:                              ; %cleanup44
	SUB R2, R1, R1
	SLT ADI R14, -4
	RET
.Lfunc_end30:
	.size	strlen, .Lfunc_end30-strlen
                                        ; -- End function
	.globl	help                            ; -- Begin function help
	.type	help,@function
help:                                   ; @help
; %bb.0:                                ; %land.lhs.true
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
	H LDI R1, .L.str.9.55
	SLT ADI R1, .L.str.9.55
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
	H LDI R15, %hi(.LBB31_3)
	SLT ADI R15, %lo(.LBB31_3)
	BRH NE, R15
; %bb.1:                                ; %if.then
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
	LDI R2, 32
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 113
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB31_22)
	SLT ADI R15, %lo(.LBB31_22)
	BRH EQ, R15
; %bb.2:                                ; %if.end
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
.LBB31_3:                               ; %land.lhs.true.1
	LDI R1, 0
	H LDI R1, .L.str.9.55
	SLT ADI R1, .L.str.9.55
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
	H LDI R15, %hi(.LBB31_4)
	SLT ADI R15, %lo(.LBB31_4)
	BRH EQ, R15
.LBB31_6:                               ; %land.lhs.true.2
	LDI R1, 0
	H LDI R1, .L.str.9.55
	SLT ADI R1, .L.str.9.55
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
	H LDI R15, %hi(.LBB31_7)
	SLT ADI R15, %lo(.LBB31_7)
	BRH EQ, R15
.LBB31_9:                               ; %land.lhs.true.3
	LDI R1, 0
	H LDI R1, .L.str.9.55
	SLT ADI R1, .L.str.9.55
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
	H LDI R15, %hi(.LBB31_10)
	SLT ADI R15, %lo(.LBB31_10)
	BRH EQ, R15
.LBB31_12:                              ; %land.lhs.true.4
	LDI R1, 0
	H LDI R1, .L.str.9.55
	SLT ADI R1, .L.str.9.55
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
	H LDI R15, %hi(.LBB31_13)
	SLT ADI R15, %lo(.LBB31_13)
	BRH EQ, R15
.LBB31_15:                              ; %land.lhs.true.5
	LDI R1, 0
	H LDI R1, .L.str.9.55
	SLT ADI R1, .L.str.9.55
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
	H LDI R15, %hi(.LBB31_16)
	SLT ADI R15, %lo(.LBB31_16)
	BRH EQ, R15
.LBB31_18:                              ; %land.lhs.true.6
	LDI R1, 0
	H LDI R1, .L.str.9.55
	SLT ADI R1, .L.str.9.55
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
	H LDI R15, %hi(.LBB31_19)
	SLT ADI R15, %lo(.LBB31_19)
	BRH EQ, R15
.LBB31_21:                              ; %for.inc.7
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.9.55
	SLT ADI R1, .L.str.9.55
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
	H LDI R15, %hi(.LBB31_22)
	SLT ADI R15, %lo(.LBB31_22)
	JMP R15
.LBB31_4:                               ; %if.then.1
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
	LDI R2, 32
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 113
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB31_22)
	SLT ADI R15, %lo(.LBB31_22)
	BRH EQ, R15
; %bb.5:                                ; %if.end.1
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
	H LDI R15, %hi(.LBB31_6)
	SLT ADI R15, %lo(.LBB31_6)
	JMP R15
.LBB31_7:                               ; %if.then.2
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
	LDI R2, 32
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 113
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB31_22)
	SLT ADI R15, %lo(.LBB31_22)
	BRH EQ, R15
; %bb.8:                                ; %if.end.2
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
	H LDI R15, %hi(.LBB31_9)
	SLT ADI R15, %lo(.LBB31_9)
	JMP R15
.LBB31_10:                              ; %if.then.3
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
	LDI R2, 32
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 113
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB31_22)
	SLT ADI R15, %lo(.LBB31_22)
	BRH EQ, R15
; %bb.11:                               ; %if.end.3
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
	H LDI R15, %hi(.LBB31_12)
	SLT ADI R15, %lo(.LBB31_12)
	JMP R15
.LBB31_13:                              ; %if.then.4
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
	LDI R2, 32
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 113
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB31_22)
	SLT ADI R15, %lo(.LBB31_22)
	BRH EQ, R15
; %bb.14:                               ; %if.end.4
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
	H LDI R15, %hi(.LBB31_15)
	SLT ADI R15, %lo(.LBB31_15)
	JMP R15
.LBB31_16:                              ; %if.then.5
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
	LDI R2, 32
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 113
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB31_22)
	SLT ADI R15, %lo(.LBB31_22)
	BRH EQ, R15
; %bb.17:                               ; %if.end.5
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
	H LDI R15, %hi(.LBB31_18)
	SLT ADI R15, %lo(.LBB31_18)
	JMP R15
.LBB31_19:                              ; %if.then.6
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
	LDI R2, 32
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 113
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB31_20)
	SLT ADI R15, %lo(.LBB31_20)
	BRH NE, R15
.LBB31_22:                              ; %cleanup
	INT LOD R14, R10, -20
	INT LOD R14, R9, -16
	INT LOD R14, R8, -12
	SLT ADI R14, -24
	RET
.LBB31_20:                              ; %if.end.6
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
	H LDI R15, %hi(.LBB31_21)
	SLT ADI R15, %lo(.LBB31_21)
	JMP R15
.Lfunc_end31:
	.size	help, .Lfunc_end31-help
                                        ; -- End function
	.globl	sysOff                          ; -- Begin function sysOff
	.type	sysOff,@function
sysOff:                                 ; @sysOff
; %bb.0:                                ; %entry
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
.Lfunc_end32:
	.size	sysOff, .Lfunc_end32-sysOff
                                        ; -- End function
	.globl	reset                           ; -- Begin function reset
	.type	reset,@function
reset:                                  ; @reset
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	H LDI R15, %hi(main)
	SLT ADI R15, %lo(main)
	CAL R15
	SLT ADI R14, -4
	RET
.Lfunc_end33:
	.size	reset, .Lfunc_end33-reset
                                        ; -- End function
	.globl	initSO                          ; -- Begin function initSO
	.type	initSO,@function
initSO:                                 ; @initSO
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	SLT ADI R14, -4
	RET
.Lfunc_end34:
	.size	initSO, .Lfunc_end34-initSO
                                        ; -- End function
	.globl	enumdisp                        ; -- Begin function enumdisp
	.type	enumdisp,@function
enumdisp:                               ; @enumdisp
; %bb.0:                                ; %entry
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
	H LDI R1, .L.str.14
	SLT ADI R1, .L.str.14
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
	H LDI R15, %hi(.LBB35_11)
	SLT ADI R15, %lo(.LBB35_11)
	BRH N, R15
; %bb.1:                                ; %for.body.preheader
	LDI R11, 20
	ADD R14, R0, R10
	INT STR R14, R10, -4
	SLT ADI R10, -8
	SLT ADD R8, R0, R9
.LBB35_2:                               ; %for.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB35_4 Depth 2
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
	H LDI R15, %hi(.LBB35_7)
	SLT ADI R15, %lo(.LBB35_7)
	BRH N, R15
; %bb.3:                                ; %for.body.i.preheader
                                        ;   in Loop: Header=BB35_2 Depth=1
	ADI R12, -13
	H LDI R15, %hi(.LBB35_4)
	SLT ADI R15, %lo(.LBB35_4)
	JMP R15
.LBB35_6:                               ; %for.body.i
                                        ;   in Loop: Header=BB35_4 Depth=2
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB35_7)
	SLT ADI R15, %lo(.LBB35_7)
	BRH EQ, R15
.LBB35_4:                               ; %for.body.i
                                        ;   Parent Loop BB35_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	SLT ADD R10, R0, R1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADI R12, 1
	SLT ADD R13, R0, R1
	SUB R12, R8, R0
	H LDI R15, %hi(.LBB35_6)
	SLT ADI R15, %lo(.LBB35_6)
	BRH EQ, R15
; %bb.5:                                ; %for.body.i
                                        ;   in Loop: Header=BB35_4 Depth=2
	SLT ADD R8, R0, R1
	H LDI R15, %hi(.LBB35_6)
	SLT ADI R15, %lo(.LBB35_6)
	JMP R15
.LBB35_7:                               ; %writePadded.exit
                                        ;   in Loop: Header=BB35_2 Depth=1
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
	H LDI R15, %hi(.LBB35_11)
	SLT ADI R15, %lo(.LBB35_11)
	BRH NN, R15
; %bb.8:                                ; %land.lhs.true
                                        ;   in Loop: Header=BB35_2 Depth=1
	LDI R1, 0
	H LDI R1, page_size
	SLT ADI R1, page_size
	INT LOD R1, R1, 0
	DIV R9, R1, R1
	GOF R2
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB35_2)
	SLT ADI R15, %lo(.LBB35_2)
	BRH NE, R15
; %bb.9:                                ; %if.then
                                        ;   in Loop: Header=BB35_2 Depth=1
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
	LDI R2, 32
	NOR R1, R2, R1
	NOR R1, R1, R1
	LDI R2, 113
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB35_11)
	SLT ADI R15, %lo(.LBB35_11)
	BRH EQ, R15
; %bb.10:                               ; %if.end
                                        ;   in Loop: Header=BB35_2 Depth=1
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.14
	SLT ADI R1, .L.str.14
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
	H LDI R15, %hi(.LBB35_2)
	SLT ADI R15, %lo(.LBB35_2)
	BRH N, R15
.LBB35_11:                              ; %cleanup
	INT LOD R14, R13, -40
	INT LOD R14, R12, -36
	INT LOD R14, R11, -32
	INT LOD R14, R10, -28
	INT LOD R14, R9, -24
	INT LOD R14, R8, -20
	SLT ADI R14, -44
	RET
.Lfunc_end35:
	.size	enumdisp, .Lfunc_end35-enumdisp
                                        ; -- End function
	.globl	lsboot                          ; -- Begin function lsboot
	.type	lsboot,@function
lsboot:                                 ; @lsboot
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	SLT ADI R14, -4
	RET
.Lfunc_end36:
	.size	lsboot, .Lfunc_end36-lsboot
                                        ; -- End function
	.globl	setboot                         ; -- Begin function setboot
	.type	setboot,@function
setboot:                                ; @setboot
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	SLT ADI R14, -4
	RET
.Lfunc_end37:
	.size	setboot, .Lfunc_end37-setboot
                                        ; -- End function
	.globl	cls                             ; -- Begin function cls
	.type	cls,@function
cls:                                    ; @cls
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	SLT ADI R14, -4
	RET
.Lfunc_end38:
	.size	cls, .Lfunc_end38-cls
                                        ; -- End function
	.globl	BiosShell                       ; -- Begin function BiosShell
	.type	BiosShell,@function
BiosShell:                              ; @BiosShell
; %bb.0:                                ; %entry
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
	H LDI R15, %hi(.LBB39_1)
	SLT ADI R15, %lo(.LBB39_1)
	JMP R15
.LBB39_11:                              ; %if.then
                                        ;   in Loop: Header=BB39_1 Depth=1
	INT LOD R12, R1, 4
	CAL R1
.LBB39_1:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	;APP
	CYE SR8, R1
	;NO_APP
	NOR R1, R11, R1
	NOR R1, R1, R1
	;APP
	CYR R1, SR8
	;NO_APP
	LDI R1, 0
	H LDI R1, .L.str.16
	SLT ADI R1, .L.str.16
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
	H LDI R15, %hi(.LBB39_11)
	SLT ADI R15, %lo(.LBB39_11)
	BRH EQ, R15
; %bb.2:                                ; %for.cond
                                        ;   in Loop: Header=BB39_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+8
	SLT ADI R12, tabla_comandos+8
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB39_11)
	SLT ADI R15, %lo(.LBB39_11)
	BRH EQ, R15
; %bb.3:                                ; %for.cond.1
                                        ;   in Loop: Header=BB39_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+16
	SLT ADI R12, tabla_comandos+16
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB39_11)
	SLT ADI R15, %lo(.LBB39_11)
	BRH EQ, R15
; %bb.4:                                ; %for.cond.2
                                        ;   in Loop: Header=BB39_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+24
	SLT ADI R12, tabla_comandos+24
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB39_11)
	SLT ADI R15, %lo(.LBB39_11)
	BRH EQ, R15
; %bb.5:                                ; %for.cond.3
                                        ;   in Loop: Header=BB39_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+32
	SLT ADI R12, tabla_comandos+32
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB39_11)
	SLT ADI R15, %lo(.LBB39_11)
	BRH EQ, R15
; %bb.6:                                ; %for.cond.4
                                        ;   in Loop: Header=BB39_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+40
	SLT ADI R12, tabla_comandos+40
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB39_11)
	SLT ADI R15, %lo(.LBB39_11)
	BRH EQ, R15
; %bb.7:                                ; %for.cond.5
                                        ;   in Loop: Header=BB39_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+48
	SLT ADI R12, tabla_comandos+48
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB39_11)
	SLT ADI R15, %lo(.LBB39_11)
	BRH EQ, R15
; %bb.8:                                ; %for.cond.6
                                        ;   in Loop: Header=BB39_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+56
	SLT ADI R12, tabla_comandos+56
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB39_11)
	SLT ADI R15, %lo(.LBB39_11)
	BRH EQ, R15
; %bb.9:                                ; %for.cond.7
                                        ;   in Loop: Header=BB39_1 Depth=1
	CHAR LOD R9, R1, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB39_1)
	SLT ADI R15, %lo(.LBB39_1)
	BRH EQ, R15
; %bb.10:                               ; %if.then8
                                        ;   in Loop: Header=BB39_1 Depth=1
	LDI R1, 0
	H LDI R1, .L.str.17
	SLT ADI R1, .L.str.17
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(.LBB39_1)
	SLT ADI R15, %lo(.LBB39_1)
	JMP R15
.Lfunc_end39:
	.size	BiosShell, .Lfunc_end39-BiosShell
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

	.type	NvmDetected,@object             ; @NvmDetected
	.globl	NvmDetected
NvmDetected:
	.byte	0                               ; 0x0
	.size	NvmDetected, 1

	.type	.L.str.9,@object                ; @.str.9
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.9:
	.asciz	"\nComando de NVM no reconocido"
	.size	.L.str.9, 30

	.type	head_index,@object              ; @head_index
	.local	head_index
	.comm	head_index,4,4
	.type	tail_index,@object              ; @tail_index
	.local	tail_index
	.comm	tail_index,4,4
	.type	hardware_busy,@object           ; @hardware_busy
	.local	hardware_busy
	.comm	hardware_busy,1,1
	.type	nvm_registers,@object           ; @nvm_registers
	.local	nvm_registers
	.comm	nvm_registers,4,4
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
	.type	hardware_busy.12,@object        ; @hardware_busy.12
	.local	hardware_busy.12
	.comm	hardware_busy.12,1,1
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
	.type	.L.str.23,@object               ; @.str.23
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.23:
	.asciz	"Fatal Error: Unhandled IRQ"
	.size	.L.str.23, 27

	.type	.L.str.1.24,@object             ; @.str.1.24
.L.str.1.24:
	.asciz	"Fatal Error: Over Limit IRQ"
	.size	.L.str.1.24, 28

	.type	system_panic,@object            ; @system_panic
	.section	.bss,"aw",@nobits
	.globl	system_panic
system_panic:
	.byte	0                               ; 0x0
	.size	system_panic, 1

	.type	.L.str.31,@object               ; @.str.31
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.31:
	.asciz	"\nFatal Error: Page Fault without MMU"
	.size	.L.str.31, 37

	.type	.L.str.1.34,@object             ; @.str.1.34
.L.str.1.34:
	.asciz	"\nFatal Error: Alignament Fault"
	.size	.L.str.1.34, 31

	.type	.L.str.2.37,@object             ; @.str.2.37
.L.str.2.37:
	.asciz	"\nFatal Error: General Protection Fault"
	.size	.L.str.2.37, 39

	.type	.L.str.3.40,@object             ; @.str.3.40
.L.str.3.40:
	.asciz	"\nFatal Error: Invalid OpCode"
	.size	.L.str.3.40, 29

	.type	.L.str.4.43,@object             ; @.str.4.43
.L.str.4.43:
	.asciz	"\nFatal Error: Double Fault"
	.size	.L.str.4.43, 27

	.type	ascii_pool,@object              ; @ascii_pool
	.local	ascii_pool
	.comm	ascii_pool,256,1
	.type	current_pool_index,@object      ; @current_pool_index
	.local	current_pool_index
	.comm	current_pool_index,4,4
	.type	.L.str.48,@object               ; @.str.48
.L.str.48:
	.asciz	"help"
	.size	.L.str.48, 5

	.type	.L.str.1.49,@object             ; @.str.1.49
.L.str.1.49:
	.asciz	"sysOff"
	.size	.L.str.1.49, 7

	.type	.L.str.2.50,@object             ; @.str.2.50
.L.str.2.50:
	.asciz	"reset"
	.size	.L.str.2.50, 6

	.type	.L.str.3.51,@object             ; @.str.3.51
.L.str.3.51:
	.asciz	"initSO"
	.size	.L.str.3.51, 7

	.type	.L.str.4.52,@object             ; @.str.4.52
.L.str.4.52:
	.asciz	"enumdisp"
	.size	.L.str.4.52, 9

	.type	.L.str.5.53,@object             ; @.str.5.53
.L.str.5.53:
	.asciz	"lsboot"
	.size	.L.str.5.53, 7

	.type	.L.str.6.54,@object             ; @.str.6.54
.L.str.6.54:
	.asciz	"setboot"
	.size	.L.str.6.54, 8

	.type	.L.str.7,@object                ; @.str.7
.L.str.7:
	.asciz	"cls"
	.size	.L.str.7, 4

	.type	tabla_comandos,@object          ; @tabla_comandos
	.data
	.globl	tabla_comandos
	.p2align	2, 0x0
tabla_comandos:
	.long	.L.str.48
	.long	help
	.long	.L.str.1.49
	.long	sysOff
	.long	.L.str.2.50
	.long	reset
	.long	.L.str.3.51
	.long	initSO
	.long	.L.str.4.52
	.long	enumdisp
	.long	.L.str.5.53
	.long	lsboot
	.long	.L.str.6.54
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

	.type	.L.str.9.55,@object             ; @.str.9.55
.L.str.9.55:
	.asciz	"- "
	.size	.L.str.9.55, 3

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

	.type	.L.str.14,@object               ; @.str.14
.L.str.14:
	.asciz	"Class Code   ECAM Address\n"
	.size	.L.str.14, 27

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

	.type	.L.str.16,@object               ; @.str.16
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.16:
	.asciz	">"
	.size	.L.str.16, 2

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
; Inicio en palabra ROM 4400 (byte 0x0044C0)
; .start:
; ── Fase 1: Copiar 219 palabra(s) de .data  ROM → RAM ──────────────
;	H LDI R15, 0xFFF0		; Dir. ROM origen .data (palabra 4181, byte 0x004154)
;	SLT ADI R15, 0x4154
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
; ── Fase 3: Saltar a main ──────────────────────────────────────────────────
;	H LDI R15, %hi(main)		; Parte alta de la dirección de main
;	SLT ADI R15, %lo(main)	; Parte baja
;	JMP R15

	.file	"llvm-link"
	.text
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
	H LDI R15, %hi(.LBB0_2)
	SLT ADI R15, %lo(.LBB0_2)
	BRH EQ, R15
; %bb.1:                                ; %if.then
	CHAR LOD R3, R5, 0
	LDI R6, 0
	H LDI R6, key_queue
	SLT ADI R6, key_queue
	ADD R5, R6, R5
	CHAR STR R5, R2, 0
	CHAR STR R3, R4, 0
.LBB0_2:                                ; %if.end
	SLT ADI R14, -4
	RET
.Lfunc_end0:
	.size	keyboard_IRQHandler, .Lfunc_end0-keyboard_IRQHandler
                                        ; -- End function
	.globl	initKeyboard                    ; -- Begin function initKeyboard
	.type	initKeyboard,@function
initKeyboard:                           ; @initKeyboard
; %bb.0:                                ; %entry
	SLT ADI R14, 12
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	LDI R8, 1
	INT STR R1, R8, 4
	INT LOD R1, R2, 16
	LDI R9, 0
	H LDI R9, kb_registers
	SLT ADI R9, kb_registers
	INT STR R9, R2, 0
	LDI R2, 126
	LDI R3, 0
	H LDI R3, keyboard_IRQHandler
	SLT ADI R3, keyboard_IRQHandler
	H LDI R15, %hi(initMSI)
	SLT ADI R15, %lo(initMSI)
	CAL R15
	INT LOD R9, R1, 0
	INT STR R1, R8, 0
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -12
	RET
.Lfunc_end1:
	.size	initKeyboard, .Lfunc_end1-initKeyboard
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
	H LDI R15, %hi(.LBB2_2)
	SLT ADI R15, %lo(.LBB2_2)
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
.LBB2_2:                                ; %cleanup
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
.Lfunc_end2:
	.size	keyboardSearch, .Lfunc_end2-keyboardSearch
                                        ; -- End function
	.globl	read                            ; -- Begin function read
	.type	read,@function
read:                                   ; @read
; %bb.0:                                ; %entry
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
	H LDI R15, %hi(.LBB3_35)
	SLT ADI R15, %lo(.LBB3_35)
	BRH EQ, R15
; %bb.1:                                ; %entry
	LDI R5, 1
	SUB R2, R5, R0
	H LDI R15, %hi(.LBB3_35)
	SLT ADI R15, %lo(.LBB3_35)
	BRH N, R15
; %bb.2:                                ; %if.end
	INT LOD R14, R1, -4
	CHAR STR R1, R4, 0
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R3, 4
	AND R1, R3, R1
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB3_4)
	SLT ADI R15, %lo(.LBB3_4)
	BRH NE, R15
; %bb.3:
	LDI R1, 0
	H LDI R1, .L.str
	SLT ADI R1, .L.str
	H LDI R15, %hi(.LBB3_34)
	SLT ADI R15, %lo(.LBB3_34)
	JMP R15
.LBB3_4:                                ; %while.cond.preheader
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
	H LDI R15, %hi(.LBB3_6)
	SLT ADI R15, %lo(.LBB3_6)
	JMP R15
.LBB3_5:                                ; %while.body8
                                        ;   in Loop: Header=BB3_6 Depth=1
	;APP
	HLT
	;NO_APP
.LBB3_6:                                ; %while.body8
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_7 Depth 2
	CHAR LOD R13, R2, 0
	CHAR LOD R9, R3, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB3_5)
	SLT ADI R15, %lo(.LBB3_5)
	BRH EQ, R15
.LBB3_7:                                ; %land.rhs
                                        ;   Parent Loop BB3_6 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	CHAR LOD R13, R2, 0
	CHAR LOD R9, R3, 0
	SLT ADD R5, R0, R12
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB3_9)
	SLT ADI R15, %lo(.LBB3_9)
	BRH NE, R15
; %bb.8:                                ; %land.rhs
                                        ;   in Loop: Header=BB3_7 Depth=2
	SLT ADD R4, R0, R12
.LBB3_9:                                ; %land.rhs
                                        ;   in Loop: Header=BB3_7 Depth=2
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB3_30)
	SLT ADI R15, %lo(.LBB3_30)
	BRH EQ, R15
; %bb.10:                               ; %while.body15
                                        ;   in Loop: Header=BB3_7 Depth=2
	CHAR LOD R13, R2, 0
	ADD R2, R6, R2
	CHAR LOD R2, R8, 0
	CHAR LOD R13, R2, 0
	ADI R2, 1
	AND R2, R7, R2
	CHAR STR R13, R2, 0
	SUB R11, R8, R0
	H LDI R15, %hi(.LBB3_18)
	SLT ADI R15, %lo(.LBB3_18)
	BRH N, R15
; %bb.11:                               ; %while.body15
                                        ;   in Loop: Header=BB3_7 Depth=2
	LDI R2, 8
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB3_36)
	SLT ADI R15, %lo(.LBB3_36)
	BRH EQ, R15
; %bb.12:                               ; %while.body15
                                        ;   in Loop: Header=BB3_7 Depth=2
	LDI R2, 10
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB3_13)
	SLT ADI R15, %lo(.LBB3_13)
	BRH NE, R15
	H LDI R15, %hi(.LBB3_20)
	SLT ADI R15, %lo(.LBB3_20)
	JMP R15
.LBB3_18:                               ; %while.body15
                                        ;   in Loop: Header=BB3_7 Depth=2
	LDI R2, 127
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB3_19)
	SLT ADI R15, %lo(.LBB3_19)
	BRH NE, R15
.LBB3_36:                               ; %if.then54
                                        ;   in Loop: Header=BB3_7 Depth=2
	SUB R10, R5, R0
	H LDI R15, %hi(.LBB3_16)
	SLT ADI R15, %lo(.LBB3_16)
	BRH N, R15
; %bb.37:                               ; %if.then57
                                        ;   in Loop: Header=BB3_7 Depth=2
	SLT ADD R11, R0, R9
	SLT ADD R10, R0, R11
	ADI R11, -1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB3_40)
	SLT ADI R15, %lo(.LBB3_40)
	BRH NN, R15
; %bb.38:                               ;   in Loop: Header=BB3_7 Depth=2
	SLT ADD R11, R0, R10
	H LDI R15, %hi(.LBB3_39)
	SLT ADI R15, %lo(.LBB3_39)
	JMP R15
.LBB3_40:                               ; %if.then60
                                        ;   in Loop: Header=BB3_7 Depth=2
	LDI R1, 0
	H LDI R1, .L.str.1
	SLT ADI R1, .L.str.1
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
.LBB3_39:                               ; %cleanup
                                        ;   in Loop: Header=BB3_7 Depth=2
	SLT ADD R9, R0, R11
	LDI R9, 0
	H LDI R9, kq_head
	SLT ADI R9, kq_head
	H LDI R15, %hi(.LBB3_16)
	SLT ADI R15, %lo(.LBB3_16)
	JMP R15
.LBB3_19:                               ; %while.body15
                                        ;   in Loop: Header=BB3_7 Depth=2
	LDI R2, 13
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB3_20)
	SLT ADI R15, %lo(.LBB3_20)
	BRH EQ, R15
.LBB3_13:                               ; %if.else63
                                        ;   in Loop: Header=BB3_7 Depth=2
	SLT ADD R8, R0, R2
	ADI R2, -32
	LDI R3, 255
	AND R2, R3, R2
	LDI R3, 94
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB3_16)
	SLT ADI R15, %lo(.LBB3_16)
	BRH C, R15
; %bb.14:                               ; %if.else63
                                        ;   in Loop: Header=BB3_7 Depth=2
	INT LOD R14, R2, -8
	SUB R10, R2, R0
	H LDI R15, %hi(.LBB3_16)
	SLT ADI R15, %lo(.LBB3_16)
	BRH NN, R15
; %bb.15:                               ; %if.then74
                                        ;   in Loop: Header=BB3_7 Depth=2
	INT LOD R14, R2, -4
	ADD R2, R10, R2
	CHAR STR R2, R8, 0
	ADI R10, 1
.LBB3_16:                               ; %cleanup
                                        ;   in Loop: Header=BB3_7 Depth=2
	LDI R2, 13
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB3_30)
	SLT ADI R15, %lo(.LBB3_30)
	BRH EQ, R15
; %bb.17:                               ; %cleanup
                                        ;   in Loop: Header=BB3_7 Depth=2
	LDI R2, 10
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB3_7)
	SLT ADI R15, %lo(.LBB3_7)
	BRH NE, R15
	H LDI R15, %hi(.LBB3_30)
	SLT ADI R15, %lo(.LBB3_30)
	JMP R15
.LBB3_20:                               ; %if.then27
                                        ;   in Loop: Header=BB3_6 Depth=1
	SLT ADD R5, R0, R2
	LDI R3, 10
	SUB R8, R3, R0
	H LDI R15, %hi(.LBB3_22)
	SLT ADI R15, %lo(.LBB3_22)
	BRH EQ, R15
; %bb.21:                               ; %if.then27
                                        ;   in Loop: Header=BB3_6 Depth=1
	SLT ADD R4, R0, R2
.LBB3_22:                               ; %if.then27
                                        ;   in Loop: Header=BB3_6 Depth=1
	SLT ADD R5, R0, R3
	LDI R12, 13
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB3_24)
	SLT ADI R15, %lo(.LBB3_24)
	BRH EQ, R15
; %bb.23:                               ; %if.then27
                                        ;   in Loop: Header=BB3_6 Depth=1
	SLT ADD R4, R0, R3
.LBB3_24:                               ; %if.then27
                                        ;   in Loop: Header=BB3_6 Depth=1
	SUB R8, R12, R0
	H LDI R15, %hi(.LBB3_25)
	SLT ADI R15, %lo(.LBB3_25)
	BRH NE, R15
; %bb.26:                               ; %land.lhs.true
                                        ;   in Loop: Header=BB3_6 Depth=1
	CHAR LOD R13, R2, 0
	CHAR LOD R9, R3, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB3_29)
	SLT ADI R15, %lo(.LBB3_29)
	BRH EQ, R15
; %bb.27:                               ; %land.lhs.true35
                                        ;   in Loop: Header=BB3_6 Depth=1
	CHAR LOD R13, R2, 0
	ADD R2, R6, R2
	CHAR LOD R2, R2, 0
	LDI R3, 10
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB3_29)
	SLT ADI R15, %lo(.LBB3_29)
	BRH NE, R15
; %bb.28:                               ; %if.then41
                                        ;   in Loop: Header=BB3_6 Depth=1
	CHAR LOD R13, R2, 0
	ADI R2, 1
	AND R2, R7, R2
	CHAR STR R13, R2, 0
.LBB3_29:                               ; %while.end80
                                        ;   in Loop: Header=BB3_6 Depth=1
	SLT ADD R5, R0, R12
.LBB3_30:                               ; %while.end80
                                        ;   in Loop: Header=BB3_6 Depth=1
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB3_32)
	SLT ADI R15, %lo(.LBB3_32)
	BRH NN, R15
.LBB3_31:                               ; %if.then83
                                        ;   in Loop: Header=BB3_6 Depth=1
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
.LBB3_32:                               ; %if.end86
                                        ;   in Loop: Header=BB3_6 Depth=1
	AND R12, R5, R2
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB3_6)
	SLT ADI R15, %lo(.LBB3_6)
	BRH EQ, R15
	H LDI R15, %hi(.LBB3_33)
	SLT ADI R15, %lo(.LBB3_33)
	JMP R15
.LBB3_25:                               ;   in Loop: Header=BB3_6 Depth=1
	NOR R2, R3, R2
	NOR R2, R2, R12
	SUB R1, R10, R0
	H LDI R15, %hi(.LBB3_31)
	SLT ADI R15, %lo(.LBB3_31)
	BRH N, R15
	H LDI R15, %hi(.LBB3_32)
	SLT ADI R15, %lo(.LBB3_32)
	JMP R15
.LBB3_33:                               ; %while.end87
	INT LOD R14, R1, -4
	ADD R1, R10, R1
	LDI R2, 0
	CHAR STR R1, R2, 0
	LDI R1, 0
	H LDI R1, .L.str.2
	SLT ADI R1, .L.str.2
.LBB3_34:                               ; %return.sink.split
	LDI R2, 0
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB3_35:                               ; %return
	SLT ADD R10, R0, R1
	INT LOD R14, R13, -32
	INT LOD R14, R12, -28
	INT LOD R14, R11, -24
	INT LOD R14, R10, -20
	INT LOD R14, R9, -16
	INT LOD R14, R8, -12
	SLT ADI R14, -36
	RET
.Lfunc_end3:
	.size	read, .Lfunc_end3-read
                                        ; -- End function
	.globl	initGpu                         ; -- Begin function initGpu
	.type	initGpu,@function
initGpu:                                ; @initGpu
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	LDI R2, 0
	INT STR R1, R2, 4
	SLT ADI R14, -4
	RET
.Lfunc_end4:
	.size	initGpu, .Lfunc_end4-initGpu
                                        ; -- End function
	.globl	gpuWrite                        ; -- Begin function gpuWrite
	.type	gpuWrite,@function
gpuWrite:                               ; @gpuWrite
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	SLT ADI R14, -4
	RET
.Lfunc_end5:
	.size	gpuWrite, .Lfunc_end5-gpuWrite
                                        ; -- End function
	.globl	displaySearch                   ; -- Begin function displaySearch
	.type	displaySearch,@function
displaySearch:                          ; @displaySearch
; %bb.0:                                ; %entry
	SLT ADI R14, 12
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	LDI R1, 0
	H LDI R1, 7
	SLT ADI R1, 0
	H LDI R15, %hi(search)
	SLT ADI R15, %lo(search)
	CAL R15
	SLT ADD R1, R0, R8
	LDI R1, 0
	SUB R8, R1, R0
	H LDI R15, %hi(.LBB6_2)
	SLT ADI R15, %lo(.LBB6_2)
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
	H LDI R3, current_display+4
	SLT ADI R3, current_display+4
	INT STR R3, R2, 0
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
	LDI R1, 0
	H LDI R1, ttyWrite
	SLT ADI R1, ttyWrite
	LDI R2, 0
	H LDI R2, current_display
	SLT ADI R2, current_display
	INT STR R2, R1, 0
	LDI R1, 0
	H LDI R1, current_display+8
	SLT ADI R1, current_display+8
	INT STR R1, R9, 0
	LDI R1, 1
.LBB6_2:                                ; %cleanup
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
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -12
	RET
.Lfunc_end6:
	.size	displaySearch, .Lfunc_end6-displaySearch
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
	H LDI R15, %hi(.LBB7_1)
	SLT ADI R15, %lo(.LBB7_1)
	BRH NE, R15
; %bb.2:                                ; %if.else
	LDI R2, 0
	H LDI R2, hardware_busy
	SLT ADI R2, hardware_busy
	CHAR STR R2, R3, 0
.LBB7_3:                                ; %if.end
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.LBB7_1:                                ; %if.then
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
	H LDI R15, %hi(.LBB7_3)
	SLT ADI R15, %lo(.LBB7_3)
	JMP R15
.Lfunc_end7:
	.size	tty_IRQHandler, .Lfunc_end7-tty_IRQHandler
                                        ; -- End function
	.type	ttyWrite,@function              ; -- Begin function ttyWrite
ttyWrite:                               ; @ttyWrite
; %bb.0:                                ; %entry
	SLT ADI R14, 24
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	LDI R4, 0
	H LDI R4, system_panic
	SLT ADI R4, system_panic
	CHAR LOD R4, R4, 0
	LDI R5, 1
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB8_1)
	SLT ADI R15, %lo(.LBB8_1)
	BRH EQ, R15
; %bb.8:                                ; %if.end
	LDI R6, 0
	LDI R4, 3
	SLT ADD R5, R0, R7
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB8_10)
	SLT ADI R15, %lo(.LBB8_10)
	BRH NE, R15
; %bb.9:                                ; %if.end
	SLT ADD R6, R0, R7
.LBB8_10:                               ; %if.end
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB8_12)
	SLT ADI R15, %lo(.LBB8_12)
	BRH N, R15
; %bb.11:                               ; %if.end
	SLT ADD R6, R0, R5
.LBB8_12:                               ; %if.end
	AND R7, R5, R7
	LDI R5, 2
	RSH R2, R5, R8
	NOR R8, R7, R7
	NOR R7, R7, R7
	SUB R7, R6, R0
	H LDI R15, %hi(.LBB8_18)
	SLT ADI R15, %lo(.LBB8_18)
	BRH EQ, R15
; %bb.13:                               ; %while.cond12.preheader
	LDI R8, 0
	H LDI R8, display_queue+66
	SLT ADI R8, display_queue+66
	CHAR LOD R8, R6, 0
	LDI R7, 4
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB8_15)
	SLT ADI R15, %lo(.LBB8_15)
	BRH C, R15
.LBB8_14:                               ; %while.body15
                                        ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	CHAR LOD R8, R6, 0
	SUB R4, R6, R0
	H LDI R15, %hi(.LBB8_14)
	SLT ADI R15, %lo(.LBB8_14)
	BRH C, R15
.LBB8_15:                               ; %while.end16
	;APP
	CYE SR8, R6
	;NO_APP
	;APP
	CYE SR8, R9
	;NO_APP
	LDI R10, 0
	H LDI R10, 0
	SLT ADI R10, -5
	AND R9, R10, R9
	;APP
	CYR R9, SR8
	;NO_APP
	LDI R10, 0
	H LDI R10, display_queue+65
	SLT ADI R10, display_queue+65
	CHAR LOD R10, R9, 0
	LSH R9, R7, R11
	LDI R9, 0
	H LDI R9, display_queue
	SLT ADI R9, display_queue
	ADD R11, R9, R11
	INT STR R11, R1, 0
	CHAR LOD R1, R1, 0
	CHAR LOD R10, R11, 0
	LSH R11, R7, R11
	LDI R12, 0
	H LDI R12, display_queue+4
	SLT ADI R12, display_queue+4
	ADD R11, R12, R11
	CHAR STR R11, R1, 0
	CHAR LOD R10, R1, 0
	LSH R1, R7, R11
	LDI R1, 0
	H LDI R1, display_queue+8
	SLT ADI R1, display_queue+8
	ADD R11, R1, R11
	INT STR R11, R2, 0
	CHAR LOD R10, R2, 0
	LSH R2, R7, R2
	LDI R11, 0
	H LDI R11, display_queue+12
	SLT ADI R11, display_queue+12
	ADD R2, R11, R2
	INT STR R2, R3, 0
	CHAR LOD R10, R2, 0
	ADI R2, 1
	AND R2, R4, R2
	CHAR STR R10, R2, 0
	CHAR LOD R8, R2, 0
	ADI R2, 1
	CHAR STR R8, R2, 0
	LDI R2, 0
	H LDI R2, hardware_busy
	SLT ADI R2, hardware_busy
	CHAR LOD R2, R3, 0
	LDI R8, 0
	SUB R3, R8, R0
	H LDI R15, %hi(.LBB8_33)
	SLT ADI R15, %lo(.LBB8_33)
	BRH NE, R15
; %bb.16:                               ; %if.then34
	LDI R3, 1
	CHAR STR R2, R3, 0
	LDI R2, 0
	H LDI R2, display_queue+64
	SLT ADI R2, display_queue+64
	CHAR LOD R2, R2, 0
	LSH R2, R7, R3
	ADD R3, R1, R2
	LDI R1, 0
	H LDI R1, current_display+4
	SLT ADI R1, current_display+4
	INT LOD R1, R1, 0
	INT LOD R2, R2, 0
	SLT ADD R2, R0, R7
	ADI R7, -1
	SUB R4, R7, R0
	H LDI R15, %hi(.LBB8_31)
	SLT ADI R15, %lo(.LBB8_31)
	BRH C, R15
; %bb.17:                               ; %if.then34
	ADD R3, R9, R3
	LSH R7, R5, R4
	LDI R5, 0
	H LDI R5, .LJTI8_0
	SLT ADI R5, .LJTI8_0
	ADD R5, R4, R4
	INT LOD R4, R4, 0
	JMP R4
.LBB8_28:                               ; %sw.bb.i73
	INT LOD R3, R2, 12
	INT STR R1, R2, 8
	CHAR LOD R3, R2, 4
	INT STR R1, R2, 4
	LDI R2, 1
	H LDI R15, %hi(.LBB8_32)
	SLT ADI R15, %lo(.LBB8_32)
	JMP R15
.LBB8_18:                               ; %while.cond.preheader
	LDI R6, 0
	H LDI R6, hardware_busy
	SLT ADI R6, hardware_busy
	CHAR LOD R6, R7, 0
	LDI R8, 1
	SUB R7, R8, R0
	H LDI R15, %hi(.LBB8_21)
	SLT ADI R15, %lo(.LBB8_21)
	BRH NE, R15
; %bb.19:                               ; %while.body.preheader
	LDI R7, 0
.LBB8_20:                               ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	CHAR LOD R6, R8, 0
	SUB R8, R7, R0
	H LDI R15, %hi(.LBB8_20)
	SLT ADI R15, %lo(.LBB8_20)
	BRH NE, R15
.LBB8_21:                               ; %while.end
	;APP
	CYE SR8, R6
	;NO_APP
	;APP
	CYE SR8, R7
	;NO_APP
	LDI R8, 0
	H LDI R8, 0
	SLT ADI R8, -5
	AND R7, R8, R7
	;APP
	CYR R7, SR8
	;NO_APP
	LDI R7, 0
	H LDI R7, current_display+4
	SLT ADI R7, current_display+4
	INT LOD R7, R7, 0
	SLT ADD R2, R0, R8
	ADI R8, -1
	SUB R4, R8, R0
	H LDI R15, %hi(.LBB8_26)
	SLT ADI R15, %lo(.LBB8_26)
	BRH C, R15
; %bb.22:                               ; %while.end
	LSH R8, R5, R4
	LDI R5, 0
	H LDI R5, .LJTI8_1
	SLT ADI R5, .LJTI8_1
	ADD R5, R4, R4
	INT LOD R4, R4, 0
	JMP R4
.LBB8_23:                               ; %sw.bb.i58
	CHAR LOD R1, R1, 0
	INT STR R7, R3, 8
	INT STR R7, R1, 4
	LDI R2, 1
	H LDI R15, %hi(.LBB8_27)
	SLT ADI R15, %lo(.LBB8_27)
	JMP R15
.LBB8_24:                               ; %sw.bb2.i55
	INT STR R7, R3, 8
	LDI R2, 2
	H LDI R15, %hi(.LBB8_27)
	SLT ADI R15, %lo(.LBB8_27)
	JMP R15
.LBB8_25:                               ; %sw.bb10.i52
	INT STR R7, R1, 4
	LDI R2, 4
	H LDI R15, %hi(.LBB8_27)
	SLT ADI R15, %lo(.LBB8_27)
	JMP R15
.LBB8_26:                               ; %sw.default.i64
	LDI R2, 0
.LBB8_27:                               ; %tty_execute_request.exit65
	INT STR R7, R2, 0
	;APP
	CYR R6, SR8
	;NO_APP
	H LDI R15, %hi(.LBB8_34)
	SLT ADI R15, %lo(.LBB8_34)
	JMP R15
.LBB8_29:                               ; %sw.bb2.i70
	INT LOD R3, R2, 12
	INT STR R1, R2, 8
	LDI R2, 2
	H LDI R15, %hi(.LBB8_32)
	SLT ADI R15, %lo(.LBB8_32)
	JMP R15
.LBB8_30:                               ; %sw.bb10.i67
	INT LOD R3, R2, 0
	INT STR R1, R2, 4
	LDI R2, 4
	H LDI R15, %hi(.LBB8_32)
	SLT ADI R15, %lo(.LBB8_32)
	JMP R15
.LBB8_31:                               ; %sw.default.i79
	LDI R2, 0
.LBB8_32:                               ; %tty_execute_request.exit80
	INT STR R1, R2, 0
.LBB8_33:                               ; %if.end37
	;APP
	CYR R6, SR8
	;NO_APP
.LBB8_34:                               ; %return
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -24
	RET
.LBB8_1:                                ; %if.then
	LDI R4, 0
	H LDI R4, current_display+4
	SLT ADI R4, current_display+4
	INT LOD R4, R4, 0
	SLT ADD R2, R0, R5
	ADI R5, -1
	LDI R6, 3
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB8_6)
	SLT ADI R15, %lo(.LBB8_6)
	BRH C, R15
; %bb.2:                                ; %if.then
	LDI R6, 2
	LSH R5, R6, R5
	LDI R6, 0
	H LDI R6, .LJTI8_2
	SLT ADI R6, .LJTI8_2
	ADD R6, R5, R5
	INT LOD R5, R5, 0
	JMP R5
.LBB8_3:                                ; %sw.bb.i
	CHAR LOD R1, R1, 0
	INT STR R4, R3, 8
	INT STR R4, R1, 4
	LDI R2, 1
	INT STR R4, R2, 0
	H LDI R15, %hi(.LBB8_34)
	SLT ADI R15, %lo(.LBB8_34)
	JMP R15
.LBB8_4:                                ; %sw.bb2.i
	INT STR R4, R3, 8
	LDI R2, 2
	INT STR R4, R2, 0
	H LDI R15, %hi(.LBB8_34)
	SLT ADI R15, %lo(.LBB8_34)
	JMP R15
.LBB8_5:                                ; %sw.bb10.i
	INT STR R4, R1, 4
	LDI R2, 4
	INT STR R4, R2, 0
	H LDI R15, %hi(.LBB8_34)
	SLT ADI R15, %lo(.LBB8_34)
	JMP R15
.LBB8_6:                                ; %sw.default.i
	LDI R2, 0
.LBB8_7:                                ; %tty_execute_request.exit
	INT STR R4, R2, 0
	H LDI R15, %hi(.LBB8_34)
	SLT ADI R15, %lo(.LBB8_34)
	JMP R15
.Lfunc_end8:
	.size	ttyWrite, .Lfunc_end8-ttyWrite
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
	.type	.LJTI8_0,@object
.LJTI8_0:
	.long	.LBB8_28
	.long	.LBB8_29
	.long	.LBB8_32
	.long	.LBB8_30
	.size	.LJTI8_0, 16
	.type	.LJTI8_1,@object
.LJTI8_1:
	.long	.LBB8_23
	.long	.LBB8_24
	.long	.LBB8_27
	.long	.LBB8_25
	.size	.LJTI8_1, 16
	.type	.LJTI8_2,@object
.LJTI8_2:
	.long	.LBB8_3
	.long	.LBB8_4
	.long	.LBB8_7
	.long	.LBB8_5
	.size	.LJTI8_2, 16
                                        ; -- End function
	.text
	.type	tty_execute_request,@function   ; -- Begin function tty_execute_request
tty_execute_request:                    ; @tty_execute_request
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	LDI R2, 0
	H LDI R2, current_display+4
	SLT ADI R2, current_display+4
	INT LOD R2, R2, 0
	INT LOD R1, R3, 8
	SLT ADD R3, R0, R4
	ADI R4, -1
	LDI R5, 3
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB9_5)
	SLT ADI R15, %lo(.LBB9_5)
	BRH C, R15
; %bb.1:                                ; %entry
	LDI R5, 2
	LSH R4, R5, R4
	LDI R5, 0
	H LDI R5, .LJTI9_0
	SLT ADI R5, .LJTI9_0
	ADD R5, R4, R4
	INT LOD R4, R4, 0
	JMP R4
.LBB9_2:                                ; %sw.bb
	INT LOD R1, R3, 12
	INT STR R2, R3, 8
	CHAR LOD R1, R1, 4
	INT STR R2, R1, 4
	LDI R3, 1
	H LDI R15, %hi(.LBB9_6)
	SLT ADI R15, %lo(.LBB9_6)
	JMP R15
.LBB9_3:                                ; %sw.bb2
	INT LOD R1, R1, 12
	INT STR R2, R1, 8
	LDI R3, 2
	H LDI R15, %hi(.LBB9_6)
	SLT ADI R15, %lo(.LBB9_6)
	JMP R15
.LBB9_4:                                ; %sw.bb10
	INT LOD R1, R1, 0
	INT STR R2, R1, 4
	LDI R3, 4
	H LDI R15, %hi(.LBB9_6)
	SLT ADI R15, %lo(.LBB9_6)
	JMP R15
.LBB9_5:                                ; %sw.default
	LDI R3, 0
.LBB9_6:                                ; %sw.epilog
	INT STR R2, R3, 0
	SLT ADI R14, -4
	RET
.Lfunc_end9:
	.size	tty_execute_request, .Lfunc_end9-tty_execute_request
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
	.type	.LJTI9_0,@object
.LJTI9_0:
	.long	.LBB9_2
	.long	.LBB9_3
	.long	.LBB9_6
	.long	.LBB9_4
	.size	.LJTI9_0, 16
                                        ; -- End function
	.text
	.globl	biosClear                       ; -- Begin function biosClear
	.type	biosClear,@function
biosClear:                              ; @biosClear
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	LDI R1, 0
	H LDI R1, current_display
	SLT ADI R1, current_display
	INT LOD R1, R4, 0
	LDI R2, 3
	LDI R1, 0
	SLT ADD R1, R0, R3
	CAL R4
	SLT ADI R14, -4
	RET
.Lfunc_end10:
	.size	biosClear, .Lfunc_end10-biosClear
                                        ; -- End function
	.globl	biosWrite                       ; -- Begin function biosWrite
	.type	biosWrite,@function
biosWrite:                              ; @biosWrite
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	CHAR LOD R1, R4, 0
	LDI R3, 1
	LDI R5, 8
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB11_1)
	SLT ADI R15, %lo(.LBB11_1)
	BRH EQ, R15
; %bb.2:                                ; %entry
	SLT ADD R3, R0, R4
	H LDI R15, %hi(.LBB11_3)
	SLT ADI R15, %lo(.LBB11_3)
	JMP R15
.LBB11_1:
	LDI R4, 2
.LBB11_3:                               ; %entry
	CHAR LOD R1, R6, 1
	LDI R5, 0
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB11_5)
	SLT ADI R15, %lo(.LBB11_5)
	BRH EQ, R15
; %bb.4:                                ; %entry
	LDI R4, 4
.LBB11_5:                               ; %entry
	NOR R2, R6, R6
	NOR R6, R6, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB11_7)
	SLT ADI R15, %lo(.LBB11_7)
	BRH EQ, R15
; %bb.6:                                ; %entry
	SLT ADD R5, R0, R3
.LBB11_7:                               ; %entry
	ADD R2, R3, R3
	LDI R2, 0
	H LDI R2, current_display
	SLT ADI R2, current_display
	INT LOD R2, R5, 0
	SLT ADD R4, R0, R2
	CAL R5
	SLT ADI R14, -4
	RET
.Lfunc_end11:
	.size	biosWrite, .Lfunc_end11-biosWrite
                                        ; -- End function
	.globl	ToAscii                         ; -- Begin function ToAscii
	.type	ToAscii,@function
ToAscii:                                ; @ToAscii
; %bb.0:                                ; %entry
	SLT ADI R14, 24
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
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
	H LDI R15, %hi(.LBB12_35)
	SLT ADI R15, %lo(.LBB12_35)
	BRH EQ, R15
; %bb.1:                                ; %entry
	LDI R7, 2
	SUB R2, R7, R0
	H LDI R15, %hi(.LBB12_29)
	SLT ADI R15, %lo(.LBB12_29)
	BRH EQ, R15
; %bb.2:                                ; %entry
	LDI R7, 3
	SUB R2, R7, R0
	H LDI R15, %hi(.LBB12_3)
	SLT ADI R15, %lo(.LBB12_3)
	BRH NE, R15
; %bb.4:                                ; %for.body.preheader
	LDI R2, 8
	RSH R1, R2, R2
	LDI R6, 15
	AND R2, R6, R2
	LDI R4, 48
	LDI R7, 10
	SUB R2, R7, R0
	H LDI R15, %hi(.LBB12_5)
	SLT ADI R15, %lo(.LBB12_5)
	BRH C, R15
; %bb.6:                                ; %for.body.preheader
	ADI R2, 55
	H LDI R15, %hi(.LBB12_7)
	SLT ADI R15, %lo(.LBB12_7)
	JMP R15
.LBB12_29:                              ; %if.then10
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB12_49)
	SLT ADI R15, %lo(.LBB12_49)
	BRH EQ, R15
; %bb.30:
	LDI R2, 15
	LDI R6, 48
	LDI R7, 10
	LDI R8, 4
	SLT ADD R5, R0, R3
	H LDI R15, %hi(.LBB12_31)
	SLT ADI R15, %lo(.LBB12_31)
	JMP R15
.LBB12_33:                              ; %while.body
                                        ;   in Loop: Header=BB12_31 Depth=1
	ADI R5, 55
.LBB12_34:                              ; %while.body
                                        ;   in Loop: Header=BB12_31 Depth=1
	CHAR STR R3, R5, -1
	RSH R1, R8, R1
	ADI R3, -1
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB12_48)
	SLT ADI R15, %lo(.LBB12_48)
	BRH EQ, R15
.LBB12_31:                              ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	AND R1, R2, R5
	SUB R5, R7, R0
	H LDI R15, %hi(.LBB12_33)
	SLT ADI R15, %lo(.LBB12_33)
	BRH NC, R15
; %bb.32:                               ;   in Loop: Header=BB12_31 Depth=1
	NOR R5, R6, R5
	NOR R5, R5, R5
	H LDI R15, %hi(.LBB12_34)
	SLT ADI R15, %lo(.LBB12_34)
	JMP R15
.LBB12_35:                              ; %if.then35
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -1
	SLT ADD R6, R0, R2
	SUB R7, R1, R0
	H LDI R15, %hi(.LBB12_37)
	SLT ADI R15, %lo(.LBB12_37)
	BRH N, R15
; %bb.36:                               ; %if.then35
	SLT ADD R4, R0, R2
.LBB12_37:                              ; %if.then35
	LDI R8, 31
	SLT ADD R1, R0, R7
	SUB R8, R4, R0
	H LDI R15, %hi(.LBB12_39)
	SLT ADI R15, %lo(.LBB12_39)
	BRH EQ, R15
; %bb.38:                               ; %if.then35
	RSH R1, R8, R7
	LSH R7, R6, R8
	SUB R7, R8, R7
.LBB12_39:                              ; %if.then35
	XOR R1, R7, R1
	SUB R1, R7, R1
	H LDI R15, %hi(.LBB12_40)
	SLT ADI R15, %lo(.LBB12_40)
	JMP R15
.LBB12_3:
	SLT ADD R6, R0, R2
.LBB12_40:                              ; %if.end40
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB12_50)
	SLT ADI R15, %lo(.LBB12_50)
	BRH EQ, R15
; %bb.41:
	LDI R3, 31
	LDI R7, 0
	H LDI R7, 52429
	SLT ADI R7, -13107
	LDI R8, 3
	LDI R9, 246
	H LDI R15, %hi(.LBB12_42)
	SLT ADI R15, %lo(.LBB12_42)
	JMP R15
.LBB12_44:                              ; %while.body51
                                        ;   in Loop: Header=BB12_42 Depth=1
	AND R10, R7, R10
	MUL R1, R7, R11
	GOF R12
	ADD R12, R10, R10
	ADD R10, R1, R10
	RSH R10, R8, R10
	MUL R10, R9, R11
	ADD R11, R1, R1
	ADI R1, 48
	CHAR STR R5, R1, -1
	ADI R5, -1
	SLT ADD R10, R0, R1
	SUB R10, R4, R0
	H LDI R15, %hi(.LBB12_45)
	SLT ADI R15, %lo(.LBB12_45)
	BRH EQ, R15
.LBB12_42:                              ; %while.body51
                                        ; =>This Inner Loop Header: Depth=1
	SLT ADD R1, R0, R10
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB12_44)
	SLT ADI R15, %lo(.LBB12_44)
	BRH EQ, R15
; %bb.43:                               ; %while.body51
                                        ;   in Loop: Header=BB12_42 Depth=1
	RSH R1, R3, R10
	LSH R10, R6, R11
	SUB R10, R11, R10
	H LDI R15, %hi(.LBB12_44)
	SLT ADI R15, %lo(.LBB12_44)
	JMP R15
.LBB12_5:
	NOR R2, R4, R2
	NOR R2, R2, R2
.LBB12_7:                               ; %for.body.preheader
	LDI R5, 4
	RSH R1, R5, R5
	AND R5, R6, R5
	SUB R5, R7, R0
	H LDI R15, %hi(.LBB12_8)
	SLT ADI R15, %lo(.LBB12_8)
	BRH C, R15
; %bb.9:                                ; %for.body.preheader
	ADI R5, 55
	AND R1, R6, R8
	SUB R8, R7, R0
	H LDI R15, %hi(.LBB12_12)
	SLT ADI R15, %lo(.LBB12_12)
	BRH NC, R15
.LBB12_11:
	NOR R8, R4, R8
	NOR R8, R8, R8
	H LDI R15, %hi(.LBB12_13)
	SLT ADI R15, %lo(.LBB12_13)
	JMP R15
.LBB12_8:
	NOR R5, R4, R5
	NOR R5, R5, R5
	AND R1, R6, R8
	SUB R8, R7, R0
	H LDI R15, %hi(.LBB12_11)
	SLT ADI R15, %lo(.LBB12_11)
	BRH C, R15
.LBB12_12:                              ; %for.body.preheader
	ADI R8, 55
.LBB12_13:                              ; %for.body.preheader
	LDI R9, 24
	RSH R1, R9, R9
	AND R9, R6, R9
	SUB R9, R7, R0
	H LDI R15, %hi(.LBB12_14)
	SLT ADI R15, %lo(.LBB12_14)
	BRH C, R15
; %bb.15:                               ; %for.body.preheader
	ADI R9, 55
	H LDI R15, %hi(.LBB12_16)
	SLT ADI R15, %lo(.LBB12_16)
	JMP R15
.LBB12_14:
	NOR R9, R4, R9
	NOR R9, R9, R9
.LBB12_16:                              ; %for.body.preheader
	LDI R10, 20
	RSH R1, R10, R10
	AND R10, R6, R10
	SUB R10, R7, R0
	H LDI R15, %hi(.LBB12_17)
	SLT ADI R15, %lo(.LBB12_17)
	BRH C, R15
; %bb.18:                               ; %for.body.preheader
	ADI R10, 55
	H LDI R15, %hi(.LBB12_19)
	SLT ADI R15, %lo(.LBB12_19)
	JMP R15
.LBB12_17:
	NOR R10, R4, R10
	NOR R10, R10, R10
.LBB12_19:                              ; %for.body.preheader
	LDI R11, 16
	RSH R1, R11, R11
	AND R11, R6, R11
	SUB R11, R7, R0
	H LDI R15, %hi(.LBB12_20)
	SLT ADI R15, %lo(.LBB12_20)
	BRH C, R15
; %bb.21:                               ; %for.body.preheader
	ADI R11, 55
	H LDI R15, %hi(.LBB12_22)
	SLT ADI R15, %lo(.LBB12_22)
	JMP R15
.LBB12_20:
	NOR R11, R4, R11
	NOR R11, R11, R11
.LBB12_22:                              ; %for.body.preheader
	LDI R12, 12
	RSH R1, R12, R12
	AND R12, R6, R6
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB12_23)
	SLT ADI R15, %lo(.LBB12_23)
	BRH C, R15
; %bb.24:                               ; %for.body.preheader
	ADI R6, 55
	H LDI R15, %hi(.LBB12_25)
	SLT ADI R15, %lo(.LBB12_25)
	JMP R15
.LBB12_23:
	NOR R6, R4, R6
	NOR R6, R6, R6
.LBB12_25:                              ; %for.body.preheader
	LDI R7, 28
	RSH R1, R7, R7
	LDI R12, 0
	H LDI R12, 40960
	SLT ADI R12, 0
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB12_26)
	SLT ADI R15, %lo(.LBB12_26)
	BRH C, R15
; %bb.27:                               ; %for.body.preheader
	ADI R7, 55
	H LDI R15, %hi(.LBB12_28)
	SLT ADI R15, %lo(.LBB12_28)
	JMP R15
.LBB12_26:
	NOR R7, R4, R1
	NOR R1, R1, R7
.LBB12_28:                              ; %for.body.preheader
	CHAR STR R3, R8, 30
	CHAR STR R3, R7, 23
	CHAR STR R3, R5, 29
	CHAR STR R3, R2, 28
	CHAR STR R3, R6, 27
	CHAR STR R3, R11, 26
	CHAR STR R3, R10, 25
	CHAR STR R3, R9, 24
	ADI R3, 23
	H LDI R15, %hi(.LBB12_48)
	SLT ADI R15, %lo(.LBB12_48)
	JMP R15
.LBB12_50:                              ; %if.then45
	LDI R1, 48
	CHAR STR R3, R1, 30
	ADI R3, 30
	SLT ADD R3, R0, R5
.LBB12_45:                              ; %if.end64
	AND R2, R6, R1
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB12_47)
	SLT ADI R15, %lo(.LBB12_47)
	BRH NE, R15
; %bb.46:                               ; %if.then66
	LDI R1, 45
	CHAR STR R5, R1, -1
	ADI R5, -1
.LBB12_47:                              ; %cleanup
	SLT ADD R5, R0, R3
.LBB12_48:                              ; %cleanup
	SLT ADD R3, R0, R1
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -24
	RET
.LBB12_49:                              ; %if.then13
	LDI R1, 48
	CHAR STR R3, R1, 30
	ADI R3, 30
	H LDI R15, %hi(.LBB12_48)
	SLT ADI R15, %lo(.LBB12_48)
	JMP R15
.Lfunc_end12:
	.size	ToAscii, .Lfunc_end12-ToAscii
                                        ; -- End function
	.globl	strcmp                          ; -- Begin function strcmp
	.type	strcmp,@function
strcmp:                                 ; @strcmp
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	CHAR LOD R1, R5, 0
	LDI R3, 0
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB13_6)
	SLT ADI R15, %lo(.LBB13_6)
	BRH EQ, R15
; %bb.1:                                ; %land.rhs.preheader
	ADI R1, 1
	LDI R4, 255
.LBB13_2:                               ; %land.rhs
                                        ; =>This Inner Loop Header: Depth=1
	AND R5, R4, R6
	CHAR LOD R2, R7, 0
	SUB R6, R7, R0
	H LDI R15, %hi(.LBB13_3)
	SLT ADI R15, %lo(.LBB13_3)
	BRH NE, R15
; %bb.4:                                ; %while.body
                                        ;   in Loop: Header=BB13_2 Depth=1
	ADI R2, 1
	CHAR LOD R1, R5, 0
	ADI R1, 1
	SUB R5, R3, R0
	H LDI R15, %hi(.LBB13_2)
	SLT ADI R15, %lo(.LBB13_2)
	BRH NE, R15
	H LDI R15, %hi(.LBB13_5)
	SLT ADI R15, %lo(.LBB13_5)
	JMP R15
.LBB13_3:
	SLT ADD R5, R0, R3
.LBB13_5:                               ; %while.end.loopexit
	AND R3, R4, R3
.LBB13_6:                               ; %while.end
	CHAR LOD R2, R1, 0
	SUB R3, R1, R1
	SLT ADI R14, -4
	RET
.Lfunc_end13:
	.size	strcmp, .Lfunc_end13-strcmp
                                        ; -- End function
	.globl	strlen                          ; -- Begin function strlen
	.type	strlen,@function
strlen:                                 ; @strlen
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	LDI R4, 3
	AND R1, R4, R5
	LDI R2, 0
	SLT ADD R1, R0, R3
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB14_6)
	SLT ADI R15, %lo(.LBB14_6)
	BRH EQ, R15
; %bb.1:                                ; %while.body.preheader
	CHAR LOD R1, R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB14_2)
	SLT ADI R15, %lo(.LBB14_2)
	BRH EQ, R15
; %bb.4:                                ; %if.end.preheader
	SLT ADD R1, R0, R5
	ADI R5, 1
.LBB14_5:                               ; %if.end
                                        ; =>This Inner Loop Header: Depth=1
	SLT ADD R5, R0, R3
	AND R3, R4, R5
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB14_6)
	SLT ADI R15, %lo(.LBB14_6)
	BRH EQ, R15
; %bb.3:                                ; %while.body
                                        ;   in Loop: Header=BB14_5 Depth=1
	SLT ADD R3, R0, R5
	ADI R5, 1
	CHAR LOD R3, R6, 0
	SUB R6, R2, R0
	H LDI R15, %hi(.LBB14_5)
	SLT ADI R15, %lo(.LBB14_5)
	BRH NE, R15
	H LDI R15, %hi(.LBB14_9)
	SLT ADI R15, %lo(.LBB14_9)
	JMP R15
.LBB14_6:                               ; %while.cond3.preheader
	ADI R3, -5
	LDI R4, 0
	H LDI R4, 257
	SLT ADI R4, 256
	LDI R5, 0
	H LDI R5, 32897
	SLT ADI R5, -32640
.LBB14_7:                               ; %while.cond3
                                        ; =>This Inner Loop Header: Depth=1
	INT LOD R3, R6, 5
	SUB R4, R6, R7
	NOR R7, R6, R6
	ADI R3, 4
	NOR R6, R6, R6
	AND R6, R5, R6
	SUB R6, R5, R0
	H LDI R15, %hi(.LBB14_7)
	SLT ADI R15, %lo(.LBB14_7)
	BRH EQ, R15
.LBB14_8:                               ; %while.cond13
                                        ; =>This Inner Loop Header: Depth=1
	CHAR LOD R3, R4, 1
	ADI R3, 1
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB14_8)
	SLT ADI R15, %lo(.LBB14_8)
	BRH NE, R15
.LBB14_9:                               ; %cleanup24
	SUB R3, R1, R1
	SLT ADI R14, -4
	RET
.LBB14_2:
	SLT ADD R1, R0, R3
	H LDI R15, %hi(.LBB14_9)
	SLT ADI R15, %lo(.LBB14_9)
	JMP R15
.Lfunc_end14:
	.size	strlen, .Lfunc_end14-strlen
                                        ; -- End function
	.globl	bus_Enumeration                 ; -- Begin function bus_Enumeration
	.type	bus_Enumeration,@function
bus_Enumeration:                        ; @bus_Enumeration
; %bb.0:                                ; %entry
	SLT ADI R14, 52
	INT STR R14, R8, -28
	INT STR R14, R9, -32
	INT STR R14, R10, -36
	INT STR R14, R11, -40
	INT STR R14, R12, -44
	INT STR R14, R13, -48
	SLT ADD R3, R0, R7
	SLT ADD R2, R0, R6
	SLT ADD R1, R0, R5
	LDI R1, 255
	SUB R1, R5, R0
	H LDI R15, %hi(.LBB15_31)
	SLT ADI R15, %lo(.LBB15_31)
	BRH C, R15
; %bb.1:                                ; %for.cond.preheader
	LDI R1, 20
	LSH R5, R1, R1
	INT STR R14, R1, -16
	LDI R9, 0
	LDI R4, 1
	LDI R11, 0
	H LDI R11, map_size
	SLT ADI R11, map_size
	LDI R8, 0
	H LDI R8, 49152
	SLT ADI R8, 0
	LDI R10, 0
	H LDI R10, mapa
	SLT ADI R10, mapa
	INT STR R14, R9, -12
	INT STR R14, R7, -8
	INT STR R14, R5, -4
.LBB15_2:                               ; %for.cond2.preheader
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB15_3 Depth 2
	SLT ADD R9, R0, R13
	SLT ADD R9, R0, R1
.LBB15_3:                               ; %for.body5
                                        ;   Parent Loop BB15_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	INT STR R14, R1, -24
	INT LOD R14, R1, -16
	ADD R1, R13, R12
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
	H LDI R15, %hi(.LBB15_4)
	SLT ADI R15, %lo(.LBB15_4)
	BRH EQ, R15
; %bb.9:                                ; %if.end16
                                        ;   in Loop: Header=BB15_3 Depth=2
	INT LOD R11, R1, 0
	LDI R2, 63
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB15_31)
	SLT ADI R15, %lo(.LBB15_31)
	BRH N, R15
; %bb.10:                               ; %if.end19
                                        ;   in Loop: Header=BB15_3 Depth=2
	INT LOD R7, R2, 0
	ADD R2, R8, R2
	LDI R3, 20
	LDI R11, 0
	H LDI R11, 49152
	SLT ADI R11, 0
	MUL R1, R3, R8
	INT LOD R10, R1, 0
	ADD R1, R8, R1
	INT STR R1, R2, 0
	CHAR STR R1, R5, 16
	INT LOD R14, R2, -12
	CHAR STR R1, R2, 17
	INT LOD R14, R2, -24
	CHAR STR R1, R2, 18
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 8
	ADD R12, R2, R2
	INT LOD R2, R10, 0
	LDI R2, 24
	RSH R10, R2, R2
	LDI R3, 127
	AND R2, R3, R2
	INT STR R1, R10, 12
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB15_11)
	SLT ADI R15, %lo(.LBB15_11)
	BRH NE, R15
; %bb.32:                               ; %if.then79
                                        ;   in Loop: Header=BB15_3 Depth=2
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
	ADD R2, R11, R2
	INT STR R1, R2, 0
	LDI R2, 0
	H LDI R2, map_size
	SLT ADI R2, map_size
	INT LOD R2, R1, 0
	ADI R1, 1
	INT STR R2, R1, 0
	INT STR R14, R12, -20
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 16
	ADD R12, R1, R9
	INT LOD R6, R1, 0
	INT LOD R9, R2, 0
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
	NOR R2, R5, R2
	LDI R4, 8
	LSH R3, R4, R11
	NOR R2, R2, R2
	NOR R2, R11, R2
	NOR R2, R2, R2
	INT STR R9, R2, 0
	INT LOD R6, R2, 0
	ADI R2, 1
	INT STR R6, R2, 0
	SLT ADD R6, R0, R12
	SLT ADD R6, R0, R2
	SLT ADD R7, R0, R3
	H LDI R15, %hi(bus_Enumeration)
	SLT ADI R15, %lo(bus_Enumeration)
	CAL R15
	INT LOD R14, R7, -8
	LDI R1, 0
	H LDI R1, mapa
	SLT ADI R1, mapa
	INT LOD R1, R1, 0
	ADD R1, R8, R1
	INT LOD R7, R2, 0
	INT LOD R1, R3, 0
	LDI R4, 0
	H LDI R4, 16384
	SLT ADI R4, 0
	ADD R3, R4, R3
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB15_34)
	SLT ADI R15, %lo(.LBB15_34)
	BRH NC, R15
; %bb.33:                               ; %if.then103
                                        ;   in Loop: Header=BB15_3 Depth=2
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -1
	ADD R2, R3, R2
	LDI R3, 0
	H LDI R3, 65535
	SLT ADI R3, 0
	AND R2, R3, R2
	INT STR R7, R2, 0
.LBB15_34:                              ; %if.end106
                                        ;   in Loop: Header=BB15_3 Depth=2
	INT LOD R9, R2, 0
	LDI R3, 0
	H LDI R3, 65280
	SLT ADI R3, 255
	AND R2, R3, R2
	SLT ADD R12, R0, R6
	INT LOD R6, R3, 0
	LDI R4, 16
	LSH R3, R4, R3
	LDI R4, 0
	H LDI R4, 255
	SLT ADI R4, 0
	ADD R3, R4, R3
	AND R3, R4, R3
	NOR R2, R3, R2
	NOR R2, R2, R2
	NOR R2, R11, R2
	NOR R2, R2, R2
	INT STR R9, R2, 0
	INT LOD R7, R2, 0
	LDI R3, 0
	H LDI R3, 49152
	SLT ADI R3, 0
	ADD R2, R3, R4
	INT STR R1, R4, 4
	INT LOD R1, R3, 0
	SUB R4, R3, R3
	INT STR R1, R3, 8
	INT LOD R1, R5, 0
	LDI R9, 0
	SLT ADD R9, R0, R3
	INT LOD R14, R8, -20
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB15_36)
	SLT ADI R15, %lo(.LBB15_36)
	BRH NC, R15
; %bb.35:                               ; %if.then130
                                        ;   in Loop: Header=BB15_3 Depth=2
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 4
	ADD R8, R3, R3
	INT LOD R1, R1, 0
	LDI R4, 3
	INT STR R3, R4, 0
	LDI R3, 0
	H LDI R3, 49152
	SLT ADI R3, -1
	ADD R2, R3, R2
	LDI R3, 0
	H LDI R3, 65535
	SLT ADI R3, 0
	AND R2, R3, R2
	LDI R3, 16
	RSH R1, R3, R1
	NOR R1, R2, R1
	NOR R1, R1, R3
.LBB15_36:                              ; %if.end139
                                        ;   in Loop: Header=BB15_3 Depth=2
	LDI R1, 0
	H LDI R1, 57344
	SLT ADI R1, 24
	ADD R8, R1, R1
	INT STR R1, R3, 0
	LDI R4, 1
	SLT ADD R4, R0, R1
	LDI R11, 0
	H LDI R11, map_size
	SLT ADI R11, map_size
	SUB R10, R9, R0
	H LDI R15, %hi(.LBB15_38)
	SLT ADI R15, %lo(.LBB15_38)
	BRH N, R15
; %bb.37:                               ; %if.end139
                                        ;   in Loop: Header=BB15_3 Depth=2
	SLT ADD R9, R0, R1
.LBB15_38:                              ; %if.end139
                                        ;   in Loop: Header=BB15_3 Depth=2
	SLT ADD R4, R0, R2
	INT LOD R14, R5, -4
	LDI R8, 0
	H LDI R8, 49152
	SLT ADI R8, 0
	SUB R13, R9, R0
	H LDI R15, %hi(.LBB15_40)
	SLT ADI R15, %lo(.LBB15_40)
	BRH NE, R15
; %bb.39:                               ; %if.end139
                                        ;   in Loop: Header=BB15_3 Depth=2
	SLT ADD R9, R0, R2
.LBB15_40:                              ; %if.end139
                                        ;   in Loop: Header=BB15_3 Depth=2
	NOR R2, R1, R1
	NOR R1, R1, R1
	LDI R10, 0
	H LDI R10, mapa
	SLT ADI R10, mapa
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB15_42)
	SLT ADI R15, %lo(.LBB15_42)
	BRH NE, R15
; %bb.41:                               ; %if.end139
                                        ;   in Loop: Header=BB15_3 Depth=2
	ADI R13, 4096
	INT LOD R14, R3, -24
	SLT ADD R3, R0, R1
	ADI R1, 1
	LDI R2, 7
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB15_3)
	SLT ADI R15, %lo(.LBB15_3)
	BRH C, R15
	H LDI R15, %hi(.LBB15_42)
	SLT ADI R15, %lo(.LBB15_42)
	JMP R15
.LBB15_11:                              ; %if.end19
                                        ;   in Loop: Header=BB15_2 Depth=1
	LDI R10, 0
	H LDI R10, mapa
	SLT ADI R10, mapa
	LDI R8, 0
	H LDI R8, 49152
	SLT ADI R8, 0
	LDI R11, 0
	H LDI R11, map_size
	SLT ADI R11, map_size
	SUB R2, R9, R0
	H LDI R15, %hi(.LBB15_12)
	SLT ADI R15, %lo(.LBB15_12)
	BRH EQ, R15
	H LDI R15, %hi(.LBB15_42)
	SLT ADI R15, %lo(.LBB15_42)
	JMP R15
.LBB15_4:                               ; %if.then11
                                        ;   in Loop: Header=BB15_2 Depth=1
	SLT ADD R4, R0, R1
	SUB R5, R9, R0
	H LDI R15, %hi(.LBB15_6)
	SLT ADI R15, %lo(.LBB15_6)
	BRH NE, R15
; %bb.5:                                ; %if.then11
                                        ;   in Loop: Header=BB15_2 Depth=1
	SLT ADD R9, R0, R1
.LBB15_6:                               ; %if.then11
                                        ;   in Loop: Header=BB15_2 Depth=1
	SLT ADD R4, R0, R2
	INT LOD R14, R3, -12
	SUB R3, R9, R0
	H LDI R15, %hi(.LBB15_8)
	SLT ADI R15, %lo(.LBB15_8)
	BRH EQ, R15
; %bb.7:                                ; %if.then11
                                        ;   in Loop: Header=BB15_2 Depth=1
	SLT ADD R9, R0, R2
.LBB15_8:                               ; %if.then11
                                        ;   in Loop: Header=BB15_2 Depth=1
	AND R1, R2, R1
	AND R1, R4, R1
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB15_31)
	SLT ADI R15, %lo(.LBB15_31)
	BRH NE, R15
.LBB15_42:                              ; %for.inc164
                                        ;   in Loop: Header=BB15_2 Depth=1
	INT LOD R14, R2, -12
	ADI R2, 1
	LDI R1, 32
	INT STR R14, R2, -12
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB15_31)
	SLT ADI R15, %lo(.LBB15_31)
	BRH EQ, R15
; %bb.43:                               ; %for.cond2.preheader.backedge
                                        ;   in Loop: Header=BB15_2 Depth=1
	INT LOD R14, R1, -16
	LDI R2, 0
	H LDI R2, 1
	SLT ADI R2, -32768
	ADD R1, R2, R1
	INT STR R14, R1, -16
	H LDI R15, %hi(.LBB15_2)
	SLT ADI R15, %lo(.LBB15_2)
	JMP R15
.LBB15_12:                              ; %for.cond35.preheader
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 16
	SLT ADD R12, R0, R8
	ADD R8, R2, R6
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -1
	INT STR R6, R3, 0
	INT LOD R6, R4, 0
	LDI R2, 0
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB15_16)
	SLT ADI R15, %lo(.LBB15_16)
	BRH EQ, R15
; %bb.13:                               ; %if.end50
	LDI R5, 4096
	INT LOD R7, R7, 0
	LDI R8, 0
	H LDI R8, 49152
	SLT ADI R8, 0
	ADD R7, R8, R7
	INT STR R6, R7, 0
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB15_15)
	SLT ADI R15, %lo(.LBB15_15)
	BRH NC, R15
; %bb.14:
	ADI R4, 4095
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -4096
	AND R4, R5, R5
.LBB15_15:                              ; %if.end50
	INT LOD R14, R7, -8
	INT LOD R7, R4, 0
	ADD R4, R5, R4
	INT STR R7, R4, 0
	SLT ADD R12, R0, R8
.LBB15_16:                              ; %for.inc
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 20
	ADD R8, R4, R4
	INT STR R4, R3, 0
	INT LOD R4, R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB15_20)
	SLT ADI R15, %lo(.LBB15_20)
	BRH EQ, R15
; %bb.17:                               ; %if.end50.1
	INT LOD R7, R5, 0
	LDI R6, 0
	H LDI R6, 49152
	SLT ADI R6, 0
	ADD R5, R6, R5
	INT STR R4, R5, 0
	LDI R4, 4096
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB15_19)
	SLT ADI R15, %lo(.LBB15_19)
	BRH NC, R15
; %bb.18:
	ADI R3, 4095
	LDI R4, 0
	H LDI R4, 0
	SLT ADI R4, -4096
	AND R3, R4, R4
.LBB15_19:                              ; %if.end50.1
	INT LOD R7, R3, 0
	ADD R3, R4, R3
	INT STR R7, R3, 0
.LBB15_20:                              ; %for.inc.1
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 24
	ADD R8, R3, R5
	LDI R3, 0
	H LDI R3, 0
	SLT ADI R3, -1
	INT STR R5, R3, 0
	INT LOD R5, R4, 0
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB15_24)
	SLT ADI R15, %lo(.LBB15_24)
	BRH EQ, R15
; %bb.21:                               ; %if.end50.2
	INT LOD R7, R6, 0
	LDI R7, 0
	H LDI R7, 49152
	SLT ADI R7, 0
	ADD R6, R7, R6
	INT STR R5, R6, 0
	LDI R5, 4096
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB15_23)
	SLT ADI R15, %lo(.LBB15_23)
	BRH NC, R15
; %bb.22:
	ADI R4, 4095
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -4096
	AND R4, R5, R5
.LBB15_23:                              ; %if.end50.2
	INT LOD R14, R7, -8
	INT LOD R7, R4, 0
	ADD R4, R5, R4
	INT STR R7, R4, 0
.LBB15_24:                              ; %for.inc.2
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 28
	ADD R8, R4, R4
	INT STR R4, R3, 0
	INT LOD R4, R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB15_25)
	SLT ADI R15, %lo(.LBB15_25)
	BRH EQ, R15
; %bb.26:                               ; %if.end50.3
	INT LOD R7, R2, 0
	LDI R5, 0
	H LDI R5, 49152
	SLT ADI R5, 0
	ADD R2, R5, R2
	INT STR R4, R2, 0
	LDI R2, 4097
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB15_27)
	SLT ADI R15, %lo(.LBB15_27)
	BRH NC, R15
; %bb.28:                               ; %if.then54.3
	INT LOD R7, R2, 0
	ADI R2, 4096
	H LDI R15, %hi(.LBB15_29)
	SLT ADI R15, %lo(.LBB15_29)
	JMP R15
.LBB15_25:                              ; %for.inc.2.for.inc.3_crit_edge
	INT LOD R7, R2, 0
	H LDI R15, %hi(.LBB15_30)
	SLT ADI R15, %lo(.LBB15_30)
	JMP R15
.LBB15_27:                              ; %if.else.3
	ADI R3, 4095
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -4096
	AND R3, R2, R2
	INT LOD R7, R3, 0
	ADD R3, R2, R2
.LBB15_29:                              ; %for.inc.3
	INT STR R7, R2, 0
.LBB15_30:                              ; %for.inc.3
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
.LBB15_31:                              ; %for.end168
	INT LOD R14, R13, -48
	INT LOD R14, R12, -44
	INT LOD R14, R11, -40
	INT LOD R14, R10, -36
	INT LOD R14, R9, -32
	INT LOD R14, R8, -28
	SLT ADI R14, -52
	RET
.Lfunc_end15:
	.size	bus_Enumeration, .Lfunc_end15-bus_Enumeration
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
.Lfunc_end16:
	.size	PCIe_Bus_Enumeration, .Lfunc_end16-PCIe_Bus_Enumeration
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
	H LDI R15, %hi(.LBB17_4)
	SLT ADI R15, %lo(.LBB17_4)
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
.LBB17_2:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	INT LOD R4, R6, 0
	AND R6, R5, R6
	SUB R6, R2, R0
	H LDI R15, %hi(.LBB17_5)
	SLT ADI R15, %lo(.LBB17_5)
	BRH EQ, R15
; %bb.3:                                ; %for.inc
                                        ;   in Loop: Header=BB17_2 Depth=1
	ADI R4, 20
	ADI R1, 1
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB17_2)
	SLT ADI R15, %lo(.LBB17_2)
	BRH NE, R15
.LBB17_4:
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -1
.LBB17_5:                               ; %cleanup
	SLT ADI R14, -4
	RET
.Lfunc_end17:
	.size	search, .Lfunc_end17-search
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
	H LDI R15, %hi(.LBB18_2)
	SLT ADI R15, %lo(.LBB18_2)
	BRH EQ, R15
; %bb.1:                                ; %if.then
	LDI R4, 4
	NOR R2, R4, R4
	NOR R4, R4, R4
	;APP
	CYR R4, SR8
	;NO_APP
.LBB18_2:                               ; %if.end
	SUB R9, R3, R0
	H LDI R15, %hi(.LBB18_8)
	SLT ADI R15, %lo(.LBB18_8)
	BRH EQ, R15
; %bb.3:                                ; %if.then2
	LDI R1, 127
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB18_4)
	SLT ADI R15, %lo(.LBB18_4)
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
	H LDI R15, %hi(.LBB18_6)
	SLT ADI R15, %lo(.LBB18_6)
	BRH EQ, R15
; %bb.13:                               ; %if.then5
	SLT ADD R2, R0, R1
	SLT ADD R8, R0, R2
	CAL R4
	H LDI R15, %hi(.LBB18_9)
	SLT ADI R15, %lo(.LBB18_9)
	JMP R15
.LBB18_8:                               ; %if.else9
	SLT ADD R8, R0, R3
	H LDI R15, %hi(syscallsHandler)
	SLT ADI R15, %lo(syscallsHandler)
	CAL R15
.LBB18_9:                               ; %if.end11
	SLT ADD R1, R0, R8
	H LDI R15, %hi(.LBB18_10)
	SLT ADI R15, %lo(.LBB18_10)
	JMP R15
.LBB18_4:
	LDI R1, 0
	H LDI R1, .L.str.1.6
	SLT ADI R1, .L.str.1.6
	H LDI R15, %hi(.LBB18_7)
	SLT ADI R15, %lo(.LBB18_7)
	JMP R15
.LBB18_6:
	LDI R1, 0
	H LDI R1, .L.str.5
	SLT ADI R1, .L.str.5
.LBB18_7:                               ; %if.else
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
.LBB18_10:                              ; %if.end11
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
	H LDI R15, %hi(.LBB18_12)
	SLT ADI R15, %lo(.LBB18_12)
	BRH C, R15
; %bb.11:                               ; %if.then13
	LDI R1, 0
	H LDI R1, Registros
	SLT ADI R1, Registros
	INT LOD R1, R1, 0
	LDI R2, 1
	INT STR R1, R2, 16
.LBB18_12:                              ; %if.end14
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -24
	RET
.Lfunc_end18:
	.size	mainHandler, .Lfunc_end18-mainHandler
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
.Lfunc_end19:
	.size	entryHandler, .Lfunc_end19-entryHandler
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
	H LDI R15, %hi(.LBB20_5)
	SLT ADI R15, %lo(.LBB20_5)
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
	H LDI R15, %hi(.LBB20_4)
	SLT ADI R15, %lo(.LBB20_4)
	BRH C, R15
; %bb.2:                                ; %if.then
	LDI R5, 0
	SUB R3, R5, R0
	H LDI R15, %hi(.LBB20_4)
	SLT ADI R15, %lo(.LBB20_4)
	BRH EQ, R15
; %bb.3:                                ; %if.then11
	LDI R5, 2
	LSH R2, R5, R2
	LDI R5, 0
	H LDI R5, irq_table
	SLT ADI R5, irq_table
	ADD R2, R5, R2
	INT STR R2, R3, 0
.LBB20_4:                               ; %if.end
	LDI R2, 13
	RSH R4, R2, R2
	LDI R3, 112
	AND R2, R3, R2
	LDI R3, 1
	NOR R2, R3, R2
	NOR R2, R2, R2
	INT STR R1, R2, 0
.LBB20_5:                               ; %if.end14
	SLT ADI R14, -4
	RET
.Lfunc_end20:
	.size	initMSI, .Lfunc_end20-initMSI
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
.Lfunc_end21:
	.size	initLAPIC, .Lfunc_end21-initLAPIC
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
	H LDI R1, .L.str.11
	SLT ADI R1, .L.str.11
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
	.size	pageFault, .Lfunc_end22-pageFault
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
	H LDI R1, .L.str.1.14
	SLT ADI R1, .L.str.1.14
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
	.size	alignamentFault, .Lfunc_end23-alignamentFault
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
	H LDI R1, .L.str.2.17
	SLT ADI R1, .L.str.2.17
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
	.size	generalProtectionFault, .Lfunc_end24-generalProtectionFault
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
	H LDI R1, .L.str.3
	SLT ADI R1, .L.str.3
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
	.size	invalidOpCode, .Lfunc_end25-invalidOpCode
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
	H LDI R1, .L.str.4
	SLT ADI R1, .L.str.4
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
	.size	doubleFault, .Lfunc_end26-doubleFault
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
.Lfunc_end27:
	.size	syscallsHandler, .Lfunc_end27-syscallsHandler
                                        ; -- End function
	.globl	final                           ; -- Begin function final
	.type	final,@function
final:                                  ; @final
; %bb.0:                                ; %entry
	SLT ADI R14, 4
.LBB28_1:                               ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB28_1)
	SLT ADI R15, %lo(.LBB28_1)
	JMP R15
.Lfunc_end28:
	.size	final, .Lfunc_end28-final
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
	H LDI R15, %hi(.LBB29_1)
	SLT ADI R15, %lo(.LBB29_1)
	BRH EQ, R15
; %bb.2:                                ; %if.end
	LDI R1, 0
	H LDI R1, .L.str.28
	SLT ADI R1, .L.str.28
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.29
	SLT ADI R1, .L.str.1.29
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
	H LDI R1, .L.str.2.30
	SLT ADI R1, .L.str.2.30
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.3.31
	SLT ADI R1, .L.str.3.31
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(keyboardSearch)
	SLT ADI R15, %lo(keyboardSearch)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB29_3)
	SLT ADI R15, %lo(.LBB29_3)
	BRH EQ, R15
; %bb.5:                                ; %if.end4
	H LDI R15, %hi(BiosShell)
	SLT ADI R15, %lo(BiosShell)
	CAL R15
	LDI R1, 0
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.LBB29_1:                               ; %while.body.i
                                        ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB29_1)
	SLT ADI R15, %lo(.LBB29_1)
	JMP R15
.LBB29_3:                               ; %if.then3
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.4.32
	SLT ADI R1, .L.str.4.32
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB29_4:                               ; %while.body.i5
                                        ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB29_4)
	SLT ADI R15, %lo(.LBB29_4)
	JMP R15
.Lfunc_end29:
	.size	main, .Lfunc_end29-main
                                        ; -- End function
	.globl	help                            ; -- Begin function help
	.type	help,@function
help:                                   ; @help
; %bb.0:                                ; %entry
	SLT ADI R14, 36
	INT STR R14, R8, -12
	INT STR R14, R9, -16
	INT STR R14, R10, -20
	INT STR R14, R11, -24
	INT STR R14, R12, -28
	INT STR R14, R13, -32
	LDI R1, 5
	LDI R2, 0
	H LDI R2, page_size
	SLT ADI R2, page_size
	INT STR R2, R1, 0
	LDI R8, 0
	LDI R1, 0
	H LDI R1, .L.str.8
	SLT ADI R1, .L.str.8
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R12, 0
	H LDI R12, 0
	SLT ADI R12, -8
	LDI R13, 0
	H LDI R13, tabla_comandos
	SLT ADI R13, tabla_comandos
	LDI R10, 0
	H LDI R10, 0
	SLT ADI R10, -1
	ADD R14, R0, R9
	SLT ADI R9, -8
	LDI R11, 1
	H LDI R15, %hi(.LBB30_1)
	SLT ADI R15, %lo(.LBB30_1)
	JMP R15
.LBB30_7:                               ; %for.inc
                                        ;   in Loop: Header=BB30_1 Depth=1
	ADI R13, 8
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB30_8)
	SLT ADI R15, %lo(.LBB30_8)
	BRH EQ, R15
.LBB30_1:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	LDI R1, 0
	H LDI R1, .L.str.9
	SLT ADI R1, .L.str.9
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	INT LOD R13, R1, 0
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
	SUB R12, R10, R0
	H LDI R15, %hi(.LBB30_8)
	SLT ADI R15, %lo(.LBB30_8)
	BRH EQ, R15
; %bb.2:                                ; %land.lhs.true
                                        ;   in Loop: Header=BB30_1 Depth=1
	SLT ADD R12, R0, R1
	ADI R1, 9
	LDI R2, 0
	H LDI R2, page_size
	SLT ADI R2, page_size
	INT LOD R2, R2, 0
	H LDI R15, %hi(__umodsi3)
	SLT ADI R15, %lo(__umodsi3)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB30_5)
	SLT ADI R15, %lo(.LBB30_5)
	BRH NE, R15
; %bb.3:                                ; %if.then
                                        ;   in Loop: Header=BB30_1 Depth=1
	LDI R1, 0
	H LDI R1, .L.str.18
	SLT ADI R1, .L.str.18
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	SLT ADD R9, R0, R1
	LDI R2, 8
	H LDI R15, %hi(read)
	SLT ADI R15, %lo(read)
	CAL R15
	CHAR LOD R9, R1, 0
	LDI R2, 223
	AND R1, R2, R1
	LDI R2, 81
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB30_8)
	SLT ADI R15, %lo(.LBB30_8)
	BRH EQ, R15
; %bb.4:                                ; %if.end
                                        ;   in Loop: Header=BB30_1 Depth=1
	H LDI R15, %hi(biosClear)
	SLT ADI R15, %lo(biosClear)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.8
	SLT ADI R1, .L.str.8
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB30_5:                               ; %for.inc
                                        ;   in Loop: Header=BB30_1 Depth=1
	ADI R12, 1
	SLT ADD R11, R0, R1
	SUB R12, R8, R0
	H LDI R15, %hi(.LBB30_7)
	SLT ADI R15, %lo(.LBB30_7)
	BRH EQ, R15
; %bb.6:                                ; %for.inc
                                        ;   in Loop: Header=BB30_1 Depth=1
	SLT ADD R8, R0, R1
	H LDI R15, %hi(.LBB30_7)
	SLT ADI R15, %lo(.LBB30_7)
	JMP R15
.LBB30_8:                               ; %cleanup
	INT LOD R14, R13, -32
	INT LOD R14, R12, -28
	INT LOD R14, R11, -24
	INT LOD R14, R10, -20
	INT LOD R14, R9, -16
	INT LOD R14, R8, -12
	SLT ADI R14, -36
	RET
.Lfunc_end30:
	.size	help, .Lfunc_end30-help
                                        ; -- End function
	.globl	sysOff                          ; -- Begin function sysOff
	.type	sysOff,@function
sysOff:                                 ; @sysOff
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.11.39
	SLT ADI R1, .L.str.11.39
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(final)
	SLT ADI R15, %lo(final)
	CAL R15
	SLT ADI R14, -4
	RET
.Lfunc_end31:
	.size	sysOff, .Lfunc_end31-sysOff
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
.Lfunc_end32:
	.size	reset, .Lfunc_end32-reset
                                        ; -- End function
	.globl	initSO                          ; -- Begin function initSO
	.type	initSO,@function
initSO:                                 ; @initSO
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	SLT ADI R14, -4
	RET
.Lfunc_end33:
	.size	initSO, .Lfunc_end33-initSO
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
	H LDI R15, %hi(.LBB34_11)
	SLT ADI R15, %lo(.LBB34_11)
	BRH N, R15
; %bb.1:                                ; %for.body.preheader
	LDI R11, 20
	ADD R14, R0, R10
	INT STR R14, R10, -4
	SLT ADI R10, -8
	SLT ADD R8, R0, R9
.LBB34_2:                               ; %for.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB34_4 Depth 2
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
	H LDI R15, %hi(.LBB34_7)
	SLT ADI R15, %lo(.LBB34_7)
	BRH N, R15
; %bb.3:                                ; %for.body.i.preheader
                                        ;   in Loop: Header=BB34_2 Depth=1
	ADI R12, -13
	H LDI R15, %hi(.LBB34_4)
	SLT ADI R15, %lo(.LBB34_4)
	JMP R15
.LBB34_6:                               ; %for.body.i
                                        ;   in Loop: Header=BB34_4 Depth=2
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB34_7)
	SLT ADI R15, %lo(.LBB34_7)
	BRH EQ, R15
.LBB34_4:                               ; %for.body.i
                                        ;   Parent Loop BB34_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	SLT ADD R10, R0, R1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	ADI R12, 1
	SLT ADD R13, R0, R1
	SUB R12, R8, R0
	H LDI R15, %hi(.LBB34_6)
	SLT ADI R15, %lo(.LBB34_6)
	BRH EQ, R15
; %bb.5:                                ; %for.body.i
                                        ;   in Loop: Header=BB34_4 Depth=2
	SLT ADD R8, R0, R1
	H LDI R15, %hi(.LBB34_6)
	SLT ADI R15, %lo(.LBB34_6)
	JMP R15
.LBB34_7:                               ; %writePadded.exit
                                        ;   in Loop: Header=BB34_2 Depth=1
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
	H LDI R15, %hi(.LBB34_11)
	SLT ADI R15, %lo(.LBB34_11)
	BRH NN, R15
; %bb.8:                                ; %land.lhs.true
                                        ;   in Loop: Header=BB34_2 Depth=1
	LDI R1, 0
	H LDI R1, page_size
	SLT ADI R1, page_size
	INT LOD R1, R1, 0
	DIV R9, R1, R1
	GOF R2
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB34_2)
	SLT ADI R15, %lo(.LBB34_2)
	BRH NE, R15
; %bb.9:                                ; %if.then
                                        ;   in Loop: Header=BB34_2 Depth=1
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
	H LDI R15, %hi(read)
	SLT ADI R15, %lo(read)
	CAL R15
	CHAR LOD R12, R1, 0
	LDI R2, 223
	AND R1, R2, R1
	LDI R2, 81
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB34_11)
	SLT ADI R15, %lo(.LBB34_11)
	BRH EQ, R15
; %bb.10:                               ; %if.end
                                        ;   in Loop: Header=BB34_2 Depth=1
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
	H LDI R15, %hi(.LBB34_2)
	SLT ADI R15, %lo(.LBB34_2)
	BRH N, R15
.LBB34_11:                              ; %cleanup
	INT LOD R14, R13, -40
	INT LOD R14, R12, -36
	INT LOD R14, R11, -32
	INT LOD R14, R10, -28
	INT LOD R14, R9, -24
	INT LOD R14, R8, -20
	SLT ADI R14, -44
	RET
.Lfunc_end34:
	.size	enumdisp, .Lfunc_end34-enumdisp
                                        ; -- End function
	.globl	lsboot                          ; -- Begin function lsboot
	.type	lsboot,@function
lsboot:                                 ; @lsboot
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	SLT ADI R14, -4
	RET
.Lfunc_end35:
	.size	lsboot, .Lfunc_end35-lsboot
                                        ; -- End function
	.globl	setboot                         ; -- Begin function setboot
	.type	setboot,@function
setboot:                                ; @setboot
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	SLT ADI R14, -4
	RET
.Lfunc_end36:
	.size	setboot, .Lfunc_end36-setboot
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
.Lfunc_end37:
	.size	cls, .Lfunc_end37-cls
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
	H LDI R15, %hi(.LBB38_1)
	SLT ADI R15, %lo(.LBB38_1)
	JMP R15
.LBB38_11:                              ; %cleanup.thread
                                        ;   in Loop: Header=BB38_1 Depth=1
	INT LOD R12, R1, 4
	CAL R1
.LBB38_1:                               ; %while.cond
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
	H LDI R15, %hi(read)
	SLT ADI R15, %lo(read)
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
	H LDI R15, %hi(.LBB38_11)
	SLT ADI R15, %lo(.LBB38_11)
	BRH EQ, R15
; %bb.2:                                ; %for.cond
                                        ;   in Loop: Header=BB38_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+8
	SLT ADI R12, tabla_comandos+8
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB38_11)
	SLT ADI R15, %lo(.LBB38_11)
	BRH EQ, R15
; %bb.3:                                ; %for.cond.1
                                        ;   in Loop: Header=BB38_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+16
	SLT ADI R12, tabla_comandos+16
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB38_11)
	SLT ADI R15, %lo(.LBB38_11)
	BRH EQ, R15
; %bb.4:                                ; %for.cond.2
                                        ;   in Loop: Header=BB38_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+24
	SLT ADI R12, tabla_comandos+24
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB38_11)
	SLT ADI R15, %lo(.LBB38_11)
	BRH EQ, R15
; %bb.5:                                ; %for.cond.3
                                        ;   in Loop: Header=BB38_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+32
	SLT ADI R12, tabla_comandos+32
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB38_11)
	SLT ADI R15, %lo(.LBB38_11)
	BRH EQ, R15
; %bb.6:                                ; %for.cond.4
                                        ;   in Loop: Header=BB38_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+40
	SLT ADI R12, tabla_comandos+40
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB38_11)
	SLT ADI R15, %lo(.LBB38_11)
	BRH EQ, R15
; %bb.7:                                ; %for.cond.5
                                        ;   in Loop: Header=BB38_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+48
	SLT ADI R12, tabla_comandos+48
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB38_11)
	SLT ADI R15, %lo(.LBB38_11)
	BRH EQ, R15
; %bb.8:                                ; %for.cond.6
                                        ;   in Loop: Header=BB38_1 Depth=1
	LDI R12, 0
	H LDI R12, tabla_comandos+56
	SLT ADI R12, tabla_comandos+56
	INT LOD R12, R2, 0
	SLT ADD R9, R0, R1
	H LDI R15, %hi(strcmp)
	SLT ADI R15, %lo(strcmp)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB38_11)
	SLT ADI R15, %lo(.LBB38_11)
	BRH EQ, R15
; %bb.9:                                ; %for.cond.7
                                        ;   in Loop: Header=BB38_1 Depth=1
	CHAR LOD R9, R1, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB38_1)
	SLT ADI R15, %lo(.LBB38_1)
	BRH EQ, R15
; %bb.10:                               ; %if.then8
                                        ;   in Loop: Header=BB38_1 Depth=1
	LDI R1, 0
	H LDI R1, .L.str.17
	SLT ADI R1, .L.str.17
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(.LBB38_1)
	SLT ADI R15, %lo(.LBB38_1)
	JMP R15
.Lfunc_end38:
	.size	BiosShell, .Lfunc_end38-BiosShell
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
	H LDI R15, %hi(.LBB39_1)
	SLT ADI R15, %lo(.LBB39_1)
	BRH EQ, R15
; %bb.2:                                ; %for.body.preheader
	LDI R5, 31
	LDI R6, 1
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -1
	SLT ADD R4, R0, R8
	SLT ADD R4, R0, R3
	H LDI R15, %hi(.LBB39_3)
	SLT ADI R15, %lo(.LBB39_3)
	JMP R15
.LBB39_7:                               ; %for.body
                                        ;   in Loop: Header=BB39_3 Depth=1
	SUB R8, R10, R8
	NOR R9, R3, R3
	NOR R3, R3, R3
	ADI R5, -1
	SUB R5, R7, R0
	H LDI R15, %hi(.LBB39_8)
	SLT ADI R15, %lo(.LBB39_8)
	BRH EQ, R15
.LBB39_3:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	LSH R8, R6, R8
	RSH R1, R5, R9
	AND R9, R6, R9
	NOR R9, R8, R8
	NOR R8, R8, R8
	SLT ADD R4, R0, R9
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB39_5)
	SLT ADI R15, %lo(.LBB39_5)
	BRH C, R15
; %bb.4:                                ; %for.body
                                        ;   in Loop: Header=BB39_3 Depth=1
	LSH R6, R5, R9
.LBB39_5:                               ; %for.body
                                        ;   in Loop: Header=BB39_3 Depth=1
	SLT ADD R4, R0, R10
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB39_7)
	SLT ADI R15, %lo(.LBB39_7)
	BRH C, R15
; %bb.6:                                ; %for.body
                                        ;   in Loop: Header=BB39_3 Depth=1
	SLT ADD R2, R0, R10
	H LDI R15, %hi(.LBB39_7)
	SLT ADI R15, %lo(.LBB39_7)
	JMP R15
.LBB39_1:
	SLT ADD R4, R0, R3
.LBB39_8:                               ; %return
	SLT ADD R3, R0, R1
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -16
	RET
.Lfunc_end39:
	.size	__udivsi3, .Lfunc_end39-__udivsi3
                                        ; -- End function
	.globl	__umodsi3                       ; -- Begin function __umodsi3
	.type	__umodsi3,@function
__umodsi3:                              ; @__umodsi3
; %bb.0:                                ; %entry
	SLT ADI R14, 8
	INT STR R14, R8, -4
	LDI R4, 0
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB40_1)
	SLT ADI R15, %lo(.LBB40_1)
	BRH EQ, R15
; %bb.2:                                ; %for.body.preheader
	LDI R5, 31
	LDI R6, 1
	LDI R7, 0
	H LDI R7, 0
	SLT ADI R7, -1
	SLT ADD R4, R0, R3
	H LDI R15, %hi(.LBB40_3)
	SLT ADI R15, %lo(.LBB40_3)
	JMP R15
.LBB40_5:                               ; %for.body
                                        ;   in Loop: Header=BB40_3 Depth=1
	SUB R3, R8, R3
	ADI R5, -1
	SUB R5, R7, R0
	H LDI R15, %hi(.LBB40_6)
	SLT ADI R15, %lo(.LBB40_6)
	BRH EQ, R15
.LBB40_3:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	LSH R3, R6, R3
	RSH R1, R5, R8
	AND R8, R6, R8
	NOR R8, R3, R3
	NOR R3, R3, R3
	SLT ADD R4, R0, R8
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB40_5)
	SLT ADI R15, %lo(.LBB40_5)
	BRH C, R15
; %bb.4:                                ; %for.body
                                        ;   in Loop: Header=BB40_3 Depth=1
	SLT ADD R2, R0, R8
	H LDI R15, %hi(.LBB40_5)
	SLT ADI R15, %lo(.LBB40_5)
	JMP R15
.LBB40_1:
	SLT ADD R4, R0, R3
.LBB40_6:                               ; %return
	SLT ADD R3, R0, R1
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.Lfunc_end40:
	.size	__umodsi3, .Lfunc_end40-__umodsi3
                                        ; -- End function
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
	.globl	kb_registers
	.p2align	2, 0x0
kb_registers:
	.long	0
	.size	kb_registers, 4

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

	.type	.L.str,@object                  ; @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"\nIRQs deshabilitadas. Imposible leer datos.\n"
	.size	.L.str, 45

	.type	.L.str.1,@object                ; @.str.1
.L.str.1:
	.asciz	"\b"
	.size	.L.str.1, 2

	.type	.L.str.2,@object                ; @.str.2
.L.str.2:
	.asciz	"\n"
	.size	.L.str.2, 2

	.type	line_buffer,@object             ; @line_buffer
	.section	.bss,"aw",@nobits
	.globl	line_buffer
line_buffer:
	.zero	256
	.size	line_buffer, 256

	.type	hardware_busy,@object           ; @hardware_busy
	.globl	hardware_busy
hardware_busy:
	.byte	0                               ; 0x0
	.size	hardware_busy, 1

	.type	DisplayDetected,@object         ; @DisplayDetected
	.globl	DisplayDetected
DisplayDetected:
	.byte	0                               ; 0x0
	.size	DisplayDetected, 1

	.type	current_display,@object         ; @current_display
	.globl	current_display
	.p2align	2, 0x0
current_display:
	.zero	12
	.size	current_display, 12

	.type	ascii_pool,@object              ; @ascii_pool
	.local	ascii_pool
	.comm	ascii_pool,256,1
	.type	current_pool_index,@object      ; @current_pool_index
	.local	current_pool_index
	.comm	current_pool_index,4,4
	.type	display_queue,@object           ; @display_queue
	.globl	display_queue
	.p2align	2, 0x0
display_queue:
	.zero	68
	.size	display_queue, 68

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
	.type	.L.str.5,@object                ; @.str.5
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.5:
	.asciz	"Fatal Error: Unhandled IRQ"
	.size	.L.str.5, 27

	.type	.L.str.1.6,@object              ; @.str.1.6
.L.str.1.6:
	.asciz	"Fatal Error: Over Limit IRQ"
	.size	.L.str.1.6, 28

	.type	system_panic,@object            ; @system_panic
	.section	.bss,"aw",@nobits
	.globl	system_panic
system_panic:
	.byte	0                               ; 0x0
	.size	system_panic, 1

	.type	.L.str.11,@object               ; @.str.11
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.11:
	.asciz	"\nFatal Error: Page Fault without MMU"
	.size	.L.str.11, 37

	.type	.L.str.1.14,@object             ; @.str.1.14
.L.str.1.14:
	.asciz	"\nFatal Error: Alignament Fault"
	.size	.L.str.1.14, 31

	.type	.L.str.2.17,@object             ; @.str.2.17
.L.str.2.17:
	.asciz	"\nFatal Error: General Protection Fault"
	.size	.L.str.2.17, 39

	.type	.L.str.3,@object                ; @.str.3
.L.str.3:
	.asciz	"\nFatal Error: Invalid OpCode"
	.size	.L.str.3, 29

	.type	.L.str.4,@object                ; @.str.4
.L.str.4:
	.asciz	"\nFatal Error: Double Fault"
	.size	.L.str.4, 27

	.type	.L.str.28,@object               ; @.str.28
.L.str.28:
	.asciz	"Enumeracion de buses finalizada.\n"
	.size	.L.str.28, 34

	.type	.L.str.1.29,@object             ; @.str.1.29
.L.str.1.29:
	.asciz	"Hay "
	.size	.L.str.1.29, 5

	.type	.L.str.2.30,@object             ; @.str.2.30
.L.str.2.30:
	.asciz	" dispositivos conectados.\n\n"
	.size	.L.str.2.30, 28

	.type	.L.str.3.31,@object             ; @.str.3.31
.L.str.3.31:
	.asciz	"LAPIC e IRQs inicializadas.\n\n"
	.size	.L.str.3.31, 30

	.type	.L.str.4.32,@object             ; @.str.4.32
.L.str.4.32:
	.asciz	"No hay teclado conectado\n"
	.size	.L.str.4.32, 26

	.type	.L.str.33,@object               ; @.str.33
.L.str.33:
	.asciz	"help"
	.size	.L.str.33, 5

	.type	.L.str.1.34,@object             ; @.str.1.34
.L.str.1.34:
	.asciz	"sysOff"
	.size	.L.str.1.34, 7

	.type	.L.str.2.35,@object             ; @.str.2.35
.L.str.2.35:
	.asciz	"reset"
	.size	.L.str.2.35, 6

	.type	.L.str.3.36,@object             ; @.str.3.36
.L.str.3.36:
	.asciz	"initSO"
	.size	.L.str.3.36, 7

	.type	.L.str.4.37,@object             ; @.str.4.37
.L.str.4.37:
	.asciz	"enumdisp"
	.size	.L.str.4.37, 9

	.type	.L.str.5.38,@object             ; @.str.5.38
.L.str.5.38:
	.asciz	"lsboot"
	.size	.L.str.5.38, 7

	.type	.L.str.6,@object                ; @.str.6
.L.str.6:
	.asciz	"setboot"
	.size	.L.str.6, 8

	.type	.L.str.7,@object                ; @.str.7
.L.str.7:
	.asciz	"cls"
	.size	.L.str.7, 4

	.type	tabla_comandos,@object          ; @tabla_comandos
	.data
	.globl	tabla_comandos
	.p2align	2, 0x0
tabla_comandos:
	.long	.L.str.33
	.long	help
	.long	.L.str.1.34
	.long	sysOff
	.long	.L.str.2.35
	.long	reset
	.long	.L.str.3.36
	.long	initSO
	.long	.L.str.4.37
	.long	enumdisp
	.long	.L.str.5.38
	.long	lsboot
	.long	.L.str.6
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

	.type	.L.str.11.39,@object            ; @.str.11.39
.L.str.11.39:
	.asciz	"Apagando sistema..."
	.size	.L.str.11.39, 20

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

	.ident	"clang version 24.0.0git (https://github.com/Licha-M/llvm-project-ISA32-LM.git d33ce74c388f2cbe2dc6054b24a7b70e0b1e7d5b)"
	.section	".note.GNU-stack","",@progbits

; ════════════════════ .start auto-generado ════════════════════
; Inicio en palabra ROM 3138 (byte 0x003108)
; .start:
; ── Fase 1: Copiar 210 palabra(s) de .data  ROM → RAM ──────────────
;	H LDI R15, 0xFFF0		; Dir. ROM origen .data (palabra 2928, byte 0x002DC0)
;	SLT ADI R15, 0x2DC0
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
; ── Fase 3: Saltar a main ──────────────────────────────────────────────────
;	H LDI R15, %hi(main)		; Parte alta de la dirección de main
;	SLT ADI R15, %lo(main)	; Parte baja
;	JMP R15

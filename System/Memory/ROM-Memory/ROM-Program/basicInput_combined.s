	.file	"llvm-link"
	.text
	.globl	keyboard_IRQHandler             ; -- Begin function keyboard_IRQHandler
	.type	keyboard_IRQHandler,@function
keyboard_IRQHandler:                    ; @keyboard_IRQHandler
; %bb.0:                                ; %entry
	SLT ADI R14, 16
	INT STR R14, R8, -8
	INT STR R14, R9, -12
	SLT ADD R2, R0, R8
	LDI R9, 0
	H LDI R9, kb_registers
	SLT ADI R9, kb_registers
	INT LOD R9, R1, 0
	INT LOD R1, R3, 4
	LDI R1, 0
	H LDI R1, line_ready
	SLT ADI R1, line_ready
	CHAR LOD R1, R1, 0
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB0_10)
	SLT ADI R15, %lo(.LBB0_10)
	BRH NE, R15
; %bb.1:                                ; %if.then
	LDI R1, 255
	AND R3, R1, R4
	LDI R1, 0
	H LDI R1, line_index
	SLT ADI R1, line_index
	INT LOD R1, R1, 0
	LDI R5, 8
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB0_5)
	SLT ADI R15, %lo(.LBB0_5)
	BRH EQ, R15
; %bb.2:                                ; %if.then
	LDI R5, 13
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB0_4)
	SLT ADI R15, %lo(.LBB0_4)
	BRH EQ, R15
; %bb.3:                                ; %if.then
	LDI R5, 10
	SUB R4, R5, R0
	H LDI R15, %hi(.LBB0_7)
	SLT ADI R15, %lo(.LBB0_7)
	BRH NE, R15
.LBB0_4:                                ; %if.then6
	LDI R3, 0
	H LDI R3, line_buffer
	SLT ADI R3, line_buffer
	ADD R1, R3, R1
	CHAR STR R1, R2, 0
	LDI R1, 1
	LDI R3, 0
	H LDI R3, line_ready
	SLT ADI R3, line_ready
	CHAR STR R3, R1, 0
	LDI R1, 0
	H LDI R1, .L.str
	SLT ADI R1, .L.str
	H LDI R15, %hi(.LBB0_9)
	SLT ADI R15, %lo(.LBB0_9)
	JMP R15
.LBB0_5:                                ; %if.then10
	LDI R2, 1
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB0_10)
	SLT ADI R15, %lo(.LBB0_10)
	BRH N, R15
; %bb.6:                                ; %if.then13
	LDI R1, 0
	H LDI R1, line_index
	SLT ADI R1, line_index
	INT LOD R1, R2, 0
	ADI R2, -1
	INT STR R1, R2, 0
	LDI R2, 1
	LDI R1, 0
	H LDI R1, .L.str.1
	SLT ADI R1, .L.str.1
	H LDI R15, %hi(.LBB0_9)
	SLT ADI R15, %lo(.LBB0_9)
	JMP R15
.LBB0_7:                                ; %if.else14
	LDI R4, 254
	SUB R4, R1, R0
	H LDI R15, %hi(.LBB0_10)
	SLT ADI R15, %lo(.LBB0_10)
	BRH N, R15
; %bb.8:                                ; %if.then17
	LDI R1, 0
	H LDI R1, line_index
	SLT ADI R1, line_index
	INT LOD R1, R4, 0
	LDI R5, 0
	H LDI R5, line_buffer
	SLT ADI R5, line_buffer
	ADD R4, R5, R4
	CHAR STR R4, R3, 0
	INT LOD R1, R4, 0
	ADI R4, 1
	INT STR R1, R4, 0
	ADD R14, R0, R1
	SLT ADI R1, -4
	CHAR STR R1, R3, 0
	CHAR STR R1, R2, 1
.LBB0_9:                                ; %if.end22
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB0_10:                               ; %if.end22
	INT LOD R9, R1, 0
	LDI R2, 2
	INT STR R1, R2, 0
	SLT ADD R8, R0, R1
	INT LOD R14, R9, -12
	INT LOD R14, R8, -8
	SLT ADI R14, -16
	RET
.Lfunc_end0:
	.size	keyboard_IRQHandler, .Lfunc_end0-keyboard_IRQHandler
                                        ; -- End function
	.globl	initKeyboard                    ; -- Begin function initKeyboard
	.type	initKeyboard,@function
initKeyboard:                           ; @initKeyboard
; %bb.0:                                ; %entry
	SLT ADI R14, 20
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	LDI R8, 1
	INT STR R1, R8, 4
	INT LOD R1, R2, 16
	LDI R9, 0
	H LDI R9, kb_registers
	SLT ADI R9, kb_registers
	INT STR R9, R2, 0
	INT LOD R1, R3, 36
	ADD R3, R1, R10
	INT LOD R10, R1, 0
	LDI R3, 255
	AND R1, R3, R1
	LDI R3, 5
	SUB R1, R3, R0
	H LDI R15, %hi(.LBB1_2)
	SLT ADI R15, %lo(.LBB1_2)
	BRH NE, R15
; %bb.1:                                ; %if.then
	INT LOD R10, R11, 0
	LDI R1, 0
	H LDI R1, 65248
	SLT ADI R1, 44
	INT STR R10, R1, 4
	LDI R1, 127
	INT STR R10, R1, 8
	LDI R1, 126
	LDI R2, 0
	H LDI R2, keyboard_IRQHandler
	SLT ADI R2, keyboard_IRQHandler
	H LDI R15, %hi(registerIRQHandler)
	SLT ADI R15, %lo(registerIRQHandler)
	CAL R15
	LDI R1, 13
	RSH R11, R1, R1
	LDI R2, 112
	AND R1, R2, R1
	NOR R1, R8, R1
	NOR R1, R1, R1
	INT STR R10, R1, 0
	INT LOD R9, R2, 0
.LBB1_2:                                ; %if.end
	INT STR R2, R8, 0
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -20
	RET
.Lfunc_end1:
	.size	initKeyboard, .Lfunc_end1-initKeyboard
                                        ; -- End function
	.globl	keyboardSearch                  ; -- Begin function keyboardSearch
	.type	keyboardSearch,@function
keyboardSearch:                         ; @keyboardSearch
; %bb.0:                                ; %entry
	SLT ADI R14, 24
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	LDI R1, 0
	H LDI R1, 9
	SLT ADI R1, 0
	H LDI R15, %hi(search)
	SLT ADI R15, %lo(search)
	CAL R15
	LDI R8, 0
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB2_4)
	SLT ADI R15, %lo(.LBB2_4)
	BRH N, R15
; %bb.1:                                ; %if.end
	LDI R2, 20
	MUL R1, R2, R3
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
	LDI R4, 12
	LSH R3, R4, R3
	NOR R2, R2, R2
	NOR R2, R3, R2
	NOR R2, R2, R3
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 4
	NOR R3, R2, R2
	NOR R2, R2, R2
	LDI R8, 1
	INT STR R2, R8, 0
	LDI R2, 0
	H LDI R2, 57344
	SLT ADI R2, 16
	NOR R3, R2, R2
	NOR R2, R2, R2
	INT LOD R2, R2, 0
	LDI R9, 0
	H LDI R9, kb_registers
	SLT ADI R9, kb_registers
	INT STR R9, R2, 0
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 36
	NOR R3, R4, R4
	NOR R4, R4, R4
	INT LOD R4, R4, 0
	ADD R4, R3, R3
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 0
	ADD R3, R4, R10
	LDI R3, 255
	INT LOD R10, R4, 0
	AND R4, R3, R3
	LDI R4, 5
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB2_3)
	SLT ADI R15, %lo(.LBB2_3)
	BRH NE, R15
; %bb.2:                                ; %if.then.i
	INT LOD R10, R12, 0
	LDI R2, 0
	H LDI R2, 65248
	SLT ADI R2, 44
	INT STR R10, R2, 4
	LDI R2, 127
	INT STR R10, R2, 8
	LDI R2, 126
	SLT ADD R1, R0, R11
	SLT ADD R2, R0, R1
	LDI R2, 0
	H LDI R2, keyboard_IRQHandler
	SLT ADI R2, keyboard_IRQHandler
	H LDI R15, %hi(registerIRQHandler)
	SLT ADI R15, %lo(registerIRQHandler)
	CAL R15
	SLT ADD R11, R0, R1
	LDI R2, 13
	RSH R12, R2, R2
	LDI R3, 112
	AND R2, R3, R2
	NOR R2, R8, R2
	NOR R2, R2, R2
	INT STR R10, R2, 0
	INT LOD R9, R2, 0
.LBB2_3:                                ; %initKeyboard.exit
	INT STR R2, R8, 0
.LBB2_4:                                ; %cleanup
	LDI R2, 0
	H LDI R2, KeyboardDetected
	SLT ADI R2, KeyboardDetected
	CHAR STR R2, R8, 0
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -1
	XOR R1, R2, R1
	LDI R2, 31
	RSH R1, R2, R1
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -24
	RET
.Lfunc_end2:
	.size	keyboardSearch, .Lfunc_end2-keyboardSearch
                                        ; -- End function
	.globl	read                            ; -- Begin function read
	.type	read,@function
read:                                   ; @read
; %bb.0:                                ; %entry
	SLT ADI R14, 20
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	SLT ADD R2, R0, R9
	SLT ADD R1, R0, R8
	;APP
	CYE SR8, R1
	;NO_APP
	LDI R2, 4
	AND R1, R2, R1
	LDI R11, 0
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB3_1)
	SLT ADI R15, %lo(.LBB3_1)
	BRH NE, R15
; %bb.10:                               ; %if.else
	LDI R10, 0
	LDI R1, 0
	H LDI R1, .L.str.2
	SLT ADI R1, .L.str.2
	SLT ADD R10, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB3_11)
	SLT ADI R15, %lo(.LBB3_11)
	JMP R15
.LBB3_1:                                ; %if.then
	H LDI R15, %hi(irqOff)
	SLT ADI R15, %lo(irqOff)
	CAL R15
	LDI R1, 0
	H LDI R1, line_index
	SLT ADI R1, line_index
	INT STR R1, R11, 0
	LDI R10, 0
	H LDI R10, line_ready
	SLT ADI R10, line_ready
	CHAR STR R10, R11, 0
	H LDI R15, %hi(irqOn)
	SLT ADI R15, %lo(irqOn)
	CAL R15
	CHAR LOD R10, R1, 0
	SUB R1, R11, R0
	H LDI R15, %hi(.LBB3_4)
	SLT ADI R15, %lo(.LBB3_4)
	BRH NE, R15
; %bb.2:                                ; %while.body.preheader
	LDI R1, 1
.LBB3_3:                                ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	CHAR LOD R10, R2, 0
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB3_3)
	SLT ADI R15, %lo(.LBB3_3)
	BRH NE, R15
.LBB3_4:                                ; %while.end
	H LDI R15, %hi(irqOff)
	SLT ADI R15, %lo(irqOff)
	CAL R15
	LDI R1, 0
	LDI R2, 2
	SLT ADD R1, R0, R10
	SUB R9, R2, R0
	H LDI R15, %hi(.LBB3_9)
	SLT ADI R15, %lo(.LBB3_9)
	BRH N, R15
; %bb.5:                                ; %land.rhs.preheader
	ADI R9, -1
	LDI R2, 0
	H LDI R2, line_buffer
	SLT ADI R2, line_buffer
	SLT ADD R1, R0, R10
.LBB3_6:                                ; %land.rhs
                                        ; =>This Inner Loop Header: Depth=1
	ADD R10, R2, R3
	CHAR LOD R3, R4, 0
	SUB R4, R1, R0
	H LDI R15, %hi(.LBB3_9)
	SLT ADI R15, %lo(.LBB3_9)
	BRH EQ, R15
; %bb.7:                                ; %while.body4
                                        ;   in Loop: Header=BB3_6 Depth=1
	ADD R8, R10, R4
	CHAR LOD R3, R3, 0
	CHAR STR R4, R3, 0
	ADI R10, 1
	SUB R9, R10, R0
	H LDI R15, %hi(.LBB3_6)
	SLT ADI R15, %lo(.LBB3_6)
	BRH NE, R15
; %bb.8:
	SLT ADD R9, R0, R10
.LBB3_9:                                ; %while.end7
	ADD R8, R10, R2
	CHAR STR R2, R1, 0
	H LDI R15, %hi(irqOn)
	SLT ADI R15, %lo(irqOn)
	CAL R15
.LBB3_11:                               ; %cleanup
	SLT ADD R10, R0, R1
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -20
	RET
.Lfunc_end3:
	.size	read, .Lfunc_end3-read
                                        ; -- End function
	.globl	tty_IRQHandler                  ; -- Begin function tty_IRQHandler
	.type	tty_IRQHandler,@function
tty_IRQHandler:                         ; @tty_IRQHandler
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	SLT ADD R2, R0, R1
	LDI R2, 0
	H LDI R2, display_queue+66
	SLT ADI R2, display_queue+66
	CHAR LOD R2, R5, 0
	LDI R4, 0
	LDI R3, 3
	SUB R5, R4, R0
	H LDI R15, %hi(.LBB4_2)
	SLT ADI R15, %lo(.LBB4_2)
	BRH EQ, R15
; %bb.1:                                ; %if.then
	LDI R5, 0
	H LDI R5, display_queue+64
	SLT ADI R5, display_queue+64
	CHAR LOD R5, R6, 0
	ADI R6, 1
	AND R6, R3, R6
	CHAR STR R5, R6, 0
	CHAR LOD R2, R5, 0
	ADI R5, -1
	CHAR STR R2, R5, 0
.LBB4_2:                                ; %if.end
	CHAR LOD R2, R2, 0
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB4_6)
	SLT ADI R15, %lo(.LBB4_6)
	BRH EQ, R15
; %bb.3:                                ; %if.then7
	LDI R2, 0
	H LDI R2, display_queue+64
	SLT ADI R2, display_queue+64
	CHAR LOD R2, R5, 0
	LDI R2, 0
	H LDI R2, current_display+4
	SLT ADI R2, current_display+4
	INT LOD R2, R2, 0
	INT STR R2, R4, 12
	INT STR R2, R4, 8
	INT STR R2, R4, 4
	LDI R4, 4
	LSH R5, R4, R5
	LDI R4, 0
	H LDI R4, display_queue+8
	SLT ADI R4, display_queue+8
	ADD R5, R4, R4
	INT LOD R4, R4, 0
	SLT ADD R4, R0, R6
	ADI R6, -1
	SUB R3, R6, R0
	H LDI R15, %hi(.LBB4_9)
	SLT ADI R15, %lo(.LBB4_9)
	BRH C, R15
; %bb.4:                                ; %if.then7
	LDI R3, 0
	H LDI R3, display_queue
	SLT ADI R3, display_queue
	ADD R5, R3, R3
	LDI R5, 2
	LSH R6, R5, R5
	LDI R6, 0
	H LDI R6, .LJTI4_0
	SLT ADI R6, .LJTI4_0
	ADD R6, R5, R5
	INT LOD R5, R5, 0
	JMP R5
.LBB4_5:                                ; %sw.bb.i
	INT LOD R3, R4, 12
	INT STR R2, R4, 12
	CHAR LOD R3, R3, 4
	INT STR R2, R3, 4
	LDI R4, 1
	H LDI R15, %hi(.LBB4_10)
	SLT ADI R15, %lo(.LBB4_10)
	JMP R15
.LBB4_6:                                ; %if.else
	LDI R2, 0
	H LDI R2, hardware_busy
	SLT ADI R2, hardware_busy
	CHAR STR R2, R4, 0
	H LDI R15, %hi(.LBB4_11)
	SLT ADI R15, %lo(.LBB4_11)
	JMP R15
.LBB4_7:                                ; %sw.bb5.i
	INT LOD R3, R3, 12
	INT STR R2, R3, 12
	LDI R4, 2
	H LDI R15, %hi(.LBB4_10)
	SLT ADI R15, %lo(.LBB4_10)
	JMP R15
.LBB4_8:                                ; %sw.bb13.i
	INT LOD R3, R4, 12
	INT STR R2, R4, 8
	INT LOD R3, R3, 0
	INT STR R2, R3, 4
	LDI R4, 4
	H LDI R15, %hi(.LBB4_10)
	SLT ADI R15, %lo(.LBB4_10)
	JMP R15
.LBB4_9:                                ; %sw.default.i
	LDI R4, 0
.LBB4_10:                               ; %tty_execute_request.exit
	INT STR R2, R4, 0
.LBB4_11:                               ; %if.end8
	SLT ADI R14, -4
	RET
.Lfunc_end4:
	.size	tty_IRQHandler, .Lfunc_end4-tty_IRQHandler
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
	.type	.LJTI4_0,@object
.LJTI4_0:
	.long	.LBB4_5
	.long	.LBB4_7
	.long	.LBB4_10
	.long	.LBB4_8
	.size	.LJTI4_0, 16
                                        ; -- End function
	.text
	.globl	ttyWrite                        ; -- Begin function ttyWrite
	.type	ttyWrite,@function
ttyWrite:                               ; @ttyWrite
; %bb.0:                                ; %entry
	SLT ADI R14, 32
	INT STR R14, R8, -8
	INT STR R14, R9, -12
	INT STR R14, R10, -16
	INT STR R14, R11, -20
	INT STR R14, R12, -24
	INT STR R14, R13, -28
	SLT ADD R3, R0, R9
	SLT ADD R2, R0, R8
	SLT ADD R1, R0, R10
	LDI R1, 0
	H LDI R1, system_panic
	SLT ADI R1, system_panic
	CHAR LOD R1, R1, 0
	LDI R12, 0
	SUB R1, R12, R0
	H LDI R15, %hi(.LBB5_1)
	SLT ADI R15, %lo(.LBB5_1)
	BRH EQ, R15
; %bb.7:                                ; %if.then
	LDI R1, 0
	H LDI R1, current_display+4
	SLT ADI R1, current_display+4
	INT LOD R1, R1, 0
	INT STR R1, R12, 12
	INT STR R1, R12, 8
	INT STR R1, R12, 4
	SLT ADD R8, R0, R2
	ADI R2, -1
	LDI R3, 3
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB5_12)
	SLT ADI R15, %lo(.LBB5_12)
	BRH C, R15
; %bb.8:                                ; %if.then
	LDI R3, 2
	LSH R2, R3, R2
	LDI R3, 0
	H LDI R3, .LJTI5_1
	SLT ADI R3, .LJTI5_1
	ADD R3, R2, R2
	INT LOD R2, R2, 0
	JMP R2
.LBB5_9:                                ; %sw.bb.i
	INT STR R1, R9, 12
	INT STR R1, R12, 4
	LDI R8, 1
	INT STR R1, R8, 0
	H LDI R15, %hi(.LBB5_20)
	SLT ADI R15, %lo(.LBB5_20)
	JMP R15
.LBB5_1:                                ; %while.cond.preheader
	LDI R11, 0
	H LDI R11, display_queue+66
	SLT ADI R11, display_queue+66
	CHAR LOD R11, R1, 0
	LDI R13, 4
	SUB R1, R13, R0
	H LDI R15, %hi(.LBB5_4)
	SLT ADI R15, %lo(.LBB5_4)
	BRH C, R15
; %bb.2:
	LDI R1, 3
.LBB5_3:                                ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	CHAR LOD R11, R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB5_3)
	SLT ADI R15, %lo(.LBB5_3)
	BRH C, R15
.LBB5_4:                                ; %while.end
	;APP
	CYE SR8, R1
	;NO_APP
	INT STR R14, R1, -4
	H LDI R15, %hi(irqOff)
	SLT ADI R15, %lo(irqOff)
	CAL R15
	LDI R1, 0
	H LDI R1, display_queue+65
	SLT ADI R1, display_queue+65
	CHAR LOD R1, R2, 0
	LSH R2, R13, R3
	LDI R2, 0
	H LDI R2, display_queue
	SLT ADI R2, display_queue
	ADD R3, R2, R3
	INT STR R3, R10, 0
	CHAR LOD R10, R3, 0
	CHAR LOD R1, R4, 0
	LSH R4, R13, R4
	LDI R5, 0
	H LDI R5, display_queue+4
	SLT ADI R5, display_queue+4
	ADD R4, R5, R4
	CHAR STR R4, R3, 0
	CHAR LOD R1, R3, 0
	LSH R3, R13, R4
	LDI R3, 0
	H LDI R3, display_queue+8
	SLT ADI R3, display_queue+8
	ADD R4, R3, R4
	INT STR R4, R8, 0
	CHAR LOD R1, R4, 0
	LSH R4, R13, R4
	LDI R5, 0
	H LDI R5, display_queue+12
	SLT ADI R5, display_queue+12
	ADD R4, R5, R4
	INT STR R4, R9, 0
	CHAR LOD R1, R5, 0
	ADI R5, 1
	LDI R4, 3
	AND R5, R4, R5
	CHAR STR R1, R5, 0
	CHAR LOD R11, R1, 0
	ADI R1, 1
	CHAR STR R11, R1, 0
	LDI R1, 0
	H LDI R1, hardware_busy
	SLT ADI R1, hardware_busy
	CHAR LOD R1, R5, 0
	SUB R5, R12, R0
	H LDI R15, %hi(.LBB5_19)
	SLT ADI R15, %lo(.LBB5_19)
	BRH NE, R15
; %bb.5:                                ; %if.then18
	LDI R5, 1
	CHAR STR R1, R5, 0
	LDI R1, 0
	H LDI R1, display_queue+64
	SLT ADI R1, display_queue+64
	CHAR LOD R1, R5, 0
	LDI R1, 0
	H LDI R1, current_display+4
	SLT ADI R1, current_display+4
	INT LOD R1, R1, 0
	INT STR R1, R12, 12
	INT STR R1, R12, 8
	INT STR R1, R12, 4
	LSH R5, R13, R5
	ADD R5, R3, R3
	INT LOD R3, R3, 0
	SLT ADD R3, R0, R6
	ADI R6, -1
	SUB R4, R6, R0
	H LDI R15, %hi(.LBB5_17)
	SLT ADI R15, %lo(.LBB5_17)
	BRH C, R15
; %bb.6:                                ; %if.then18
	ADD R5, R2, R2
	LDI R4, 2
	LSH R6, R4, R4
	LDI R5, 0
	H LDI R5, .LJTI5_0
	SLT ADI R5, .LJTI5_0
	ADD R5, R4, R4
	INT LOD R4, R4, 0
	JMP R4
.LBB5_14:                               ; %sw.bb.i35
	INT LOD R2, R3, 12
	INT STR R1, R3, 12
	CHAR LOD R2, R2, 4
	INT STR R1, R2, 4
	LDI R3, 1
	H LDI R15, %hi(.LBB5_18)
	SLT ADI R15, %lo(.LBB5_18)
	JMP R15
.LBB5_10:                               ; %sw.bb5.i
	INT STR R1, R9, 12
	LDI R8, 2
	INT STR R1, R8, 0
	H LDI R15, %hi(.LBB5_20)
	SLT ADI R15, %lo(.LBB5_20)
	JMP R15
.LBB5_11:                               ; %sw.bb13.i
	INT STR R1, R9, 8
	INT STR R1, R10, 4
	LDI R8, 4
	INT STR R1, R8, 0
	H LDI R15, %hi(.LBB5_20)
	SLT ADI R15, %lo(.LBB5_20)
	JMP R15
.LBB5_12:                               ; %sw.default.i
	LDI R8, 0
.LBB5_13:                               ; %tty_execute_request.exit
	INT STR R1, R8, 0
	H LDI R15, %hi(.LBB5_20)
	SLT ADI R15, %lo(.LBB5_20)
	JMP R15
.LBB5_15:                               ; %sw.bb5.i33
	INT LOD R2, R2, 12
	INT STR R1, R2, 12
	LDI R3, 2
	H LDI R15, %hi(.LBB5_18)
	SLT ADI R15, %lo(.LBB5_18)
	JMP R15
.LBB5_16:                               ; %sw.bb13.i30
	INT LOD R2, R3, 12
	INT STR R1, R3, 8
	INT LOD R2, R2, 0
	INT STR R1, R2, 4
	LDI R3, 4
	H LDI R15, %hi(.LBB5_18)
	SLT ADI R15, %lo(.LBB5_18)
	JMP R15
.LBB5_17:                               ; %sw.default.i39
	LDI R3, 0
.LBB5_18:                               ; %tty_execute_request.exit40
	INT STR R1, R3, 0
.LBB5_19:                               ; %if.end21
	INT LOD R14, R1, -4
	;APP
	CYR R1, SR8
	;NO_APP
.LBB5_20:                               ; %return
	INT LOD R14, R13, -28
	INT LOD R14, R12, -24
	INT LOD R14, R11, -20
	INT LOD R14, R10, -16
	INT LOD R14, R9, -12
	INT LOD R14, R8, -8
	SLT ADI R14, -32
	RET
.Lfunc_end5:
	.size	ttyWrite, .Lfunc_end5-ttyWrite
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
	.type	.LJTI5_0,@object
.LJTI5_0:
	.long	.LBB5_14
	.long	.LBB5_15
	.long	.LBB5_18
	.long	.LBB5_16
	.size	.LJTI5_0, 16
	.type	.LJTI5_1,@object
.LJTI5_1:
	.long	.LBB5_9
	.long	.LBB5_10
	.long	.LBB5_13
	.long	.LBB5_11
	.size	.LJTI5_1, 16
                                        ; -- End function
	.text
	.globl	initTty                         ; -- Begin function initTty
	.type	initTty,@function
initTty:                                ; @initTty
; %bb.0:                                ; %entry
	SLT ADI R14, 12
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	LDI R2, 0
	LDI R3, 0
	H LDI R3, display_queue+64
	SLT ADI R3, display_queue+64
	CHAR STR R3, R2, 0
	LDI R3, 0
	H LDI R3, display_queue+65
	SLT ADI R3, display_queue+65
	CHAR STR R3, R2, 0
	LDI R3, 0
	H LDI R3, display_queue+66
	SLT ADI R3, display_queue+66
	CHAR STR R3, R2, 0
	LDI R3, 0
	H LDI R3, hardware_busy
	SLT ADI R3, hardware_busy
	CHAR STR R3, R2, 0
	LDI R2, 3
	INT STR R1, R2, 4
	INT LOD R1, R2, 16
	LDI R3, 0
	H LDI R3, current_display+4
	SLT ADI R3, current_display+4
	INT STR R3, R2, 0
	INT LOD R1, R2, 36
	ADD R2, R1, R8
	LDI R1, 255
	INT LOD R8, R2, 0
	AND R2, R1, R1
	LDI R2, 5
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB6_2)
	SLT ADI R15, %lo(.LBB6_2)
	BRH NE, R15
; %bb.1:                                ; %if.then
	INT LOD R8, R9, 0
	LDI R1, 0
	H LDI R1, 65248
	SLT ADI R1, 44
	INT STR R8, R1, 4
	LDI R1, 127
	INT STR R8, R1, 8
	LDI R2, 0
	H LDI R2, tty_IRQHandler
	SLT ADI R2, tty_IRQHandler
	H LDI R15, %hi(registerIRQHandler)
	SLT ADI R15, %lo(registerIRQHandler)
	CAL R15
	LDI R1, 13
	RSH R9, R1, R1
	LDI R2, 112
	AND R1, R2, R1
	LDI R2, 1
	NOR R1, R2, R1
	NOR R1, R1, R1
	INT STR R8, R1, 0
.LBB6_2:                                ; %if.end
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -12
	RET
.Lfunc_end6:
	.size	initTty, .Lfunc_end6-initTty
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
.Lfunc_end7:
	.size	initGpu, .Lfunc_end7-initGpu
                                        ; -- End function
	.globl	gpuWrite                        ; -- Begin function gpuWrite
	.type	gpuWrite,@function
gpuWrite:                               ; @gpuWrite
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	SLT ADI R14, -4
	RET
.Lfunc_end8:
	.size	gpuWrite, .Lfunc_end8-gpuWrite
                                        ; -- End function
	.globl	displaySearch                   ; -- Begin function displaySearch
	.type	displaySearch,@function
displaySearch:                          ; @displaySearch
; %bb.0:                                ; %entry
	SLT ADI R14, 24
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	LDI R1, 0
	H LDI R1, 7
	SLT ADI R1, 0
	H LDI R15, %hi(search)
	SLT ADI R15, %lo(search)
	CAL R15
	LDI R2, 0
	SUB R1, R2, R0
	H LDI R15, %hi(.LBB9_4)
	SLT ADI R15, %lo(.LBB9_4)
	BRH N, R15
; %bb.1:                                ; %if.end
	LDI R3, 20
	MUL R1, R3, R4
	LDI R5, 0
	H LDI R5, mapa
	SLT ADI R5, mapa
	INT LOD R5, R5, 0
	ADD R5, R4, R4
	CHAR LOD R4, R5, 16
	CHAR LOD R4, R6, 17
	CHAR LOD R4, R4, 18
	LDI R7, 0
	H LDI R7, display_queue+64
	SLT ADI R7, display_queue+64
	CHAR STR R7, R2, 0
	LDI R7, 0
	H LDI R7, display_queue+65
	SLT ADI R7, display_queue+65
	CHAR STR R7, R2, 0
	LDI R7, 0
	H LDI R7, display_queue+66
	SLT ADI R7, display_queue+66
	CHAR STR R7, R2, 0
	LDI R7, 0
	H LDI R7, hardware_busy
	SLT ADI R7, hardware_busy
	CHAR STR R7, R2, 0
	LSH R5, R3, R2
	LDI R3, 15
	LSH R6, R3, R3
	NOR R3, R2, R2
	LDI R3, 12
	LSH R4, R3, R3
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
	H LDI R4, current_display+4
	SLT ADI R4, current_display+4
	INT STR R4, R3, 0
	LDI R3, 0
	H LDI R3, 57344
	SLT ADI R3, 36
	NOR R2, R3, R3
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 0
	NOR R2, R4, R2
	NOR R2, R2, R8
	NOR R3, R3, R2
	INT LOD R2, R2, 0
	ADD R2, R8, R9
	LDI R2, 255
	INT LOD R9, R3, 0
	AND R3, R2, R2
	LDI R3, 5
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB9_3)
	SLT ADI R15, %lo(.LBB9_3)
	BRH NE, R15
; %bb.2:                                ; %if.then.i
	LDI R11, 1
	INT LOD R9, R12, 0
	LDI R2, 0
	H LDI R2, 65248
	SLT ADI R2, 44
	INT STR R9, R2, 4
	LDI R2, 127
	INT STR R9, R2, 8
	SLT ADD R1, R0, R10
	SLT ADD R2, R0, R1
	LDI R2, 0
	H LDI R2, tty_IRQHandler
	SLT ADI R2, tty_IRQHandler
	H LDI R15, %hi(registerIRQHandler)
	SLT ADI R15, %lo(registerIRQHandler)
	CAL R15
	SLT ADD R10, R0, R1
	LDI R2, 13
	RSH R12, R2, R2
	LDI R3, 112
	AND R2, R3, R2
	NOR R2, R11, R2
	NOR R2, R2, R2
	INT STR R9, R2, 0
.LBB9_3:                                ; %initTty.exit
	LDI R2, 0
	H LDI R2, ttyWrite
	SLT ADI R2, ttyWrite
	LDI R3, 0
	H LDI R3, current_display
	SLT ADI R3, current_display
	INT STR R3, R2, 0
	LDI R2, 0
	H LDI R2, current_display+8
	SLT ADI R2, current_display+8
	INT STR R2, R8, 0
	LDI R2, 1
.LBB9_4:                                ; %cleanup
	LDI R3, 0
	H LDI R3, DisplayDetected
	SLT ADI R3, DisplayDetected
	CHAR STR R3, R2, 0
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -1
	XOR R1, R2, R1
	LDI R2, 31
	RSH R1, R2, R1
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -24
	RET
.Lfunc_end9:
	.size	displaySearch, .Lfunc_end9-displaySearch
                                        ; -- End function
	.globl	strlen                          ; -- Begin function strlen
	.type	strlen,@function
strlen:                                 ; @strlen
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	SLT ADD R1, R0, R2
	ADI R2, -1
	LDI R3, 0
.LBB10_1:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	CHAR LOD R2, R4, 1
	ADI R2, 1
	SUB R4, R3, R0
	H LDI R15, %hi(.LBB10_1)
	SLT ADI R15, %lo(.LBB10_1)
	BRH NE, R15
; %bb.2:                                ; %while.end
	SUB R2, R1, R1
	SLT ADI R14, -4
	RET
.Lfunc_end10:
	.size	strlen, .Lfunc_end10-strlen
                                        ; -- End function
	.globl	biosWrite                       ; -- Begin function biosWrite
	.type	biosWrite,@function
biosWrite:                              ; @biosWrite
; %bb.0:                                ; %entry
	SLT ADI R14, 8
	INT STR R14, R8, -4
	SLT ADD R2, R0, R3
	CHAR LOD R1, R2, 0
	LDI R4, 8
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB11_5)
	SLT ADI R15, %lo(.LBB11_5)
	BRH NE, R15
; %bb.1:                                ; %land.lhs.true
	CHAR LOD R1, R2, 1
	LDI R4, 0
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB11_9)
	SLT ADI R15, %lo(.LBB11_9)
	BRH NE, R15
; %bb.2:                                ; %if.then
	LDI R2, 1
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB11_4)
	SLT ADI R15, %lo(.LBB11_4)
	BRH C, R15
; %bb.3:                                ; %if.then
	SLT ADD R2, R0, R3
.LBB11_4:                               ; %if.then
	LDI R2, 0
	H LDI R2, current_display
	SLT ADI R2, current_display
	INT LOD R2, R4, 0
	LDI R2, 2
	H LDI R15, %hi(.LBB11_13)
	SLT ADI R15, %lo(.LBB11_13)
	JMP R15
.LBB11_5:                               ; %if.else
	LDI R4, 0
	SUB R3, R4, R0
	H LDI R15, %hi(.LBB11_8)
	SLT ADI R15, %lo(.LBB11_8)
	BRH NE, R15
; %bb.6:                                ; %if.else
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB11_8)
	SLT ADI R15, %lo(.LBB11_8)
	BRH NE, R15
; %bb.7:                                ; %if.then16
	LDI R1, 0
	H LDI R1, current_display
	SLT ADI R1, current_display
	INT LOD R1, R4, 0
	LDI R2, 3
	LDI R3, 0
	LDI R1, 0
	H LDI R1, .L.str.3
	SLT ADI R1, .L.str.3
	H LDI R15, %hi(.LBB11_13)
	SLT ADI R15, %lo(.LBB11_13)
	JMP R15
.LBB11_8:                               ; %if.else17
	CHAR LOD R1, R2, 1
	SUB R2, R4, R0
	H LDI R15, %hi(.LBB11_10)
	SLT ADI R15, %lo(.LBB11_10)
	BRH EQ, R15
.LBB11_9:                               ; %while.cond.i.preheader
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
.LBB11_13:                              ; %if.end30
	CAL R4
	INT LOD R14, R8, -4
	SLT ADI R14, -8
	RET
.LBB11_10:                              ; %if.then22
	LDI R2, 1
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB11_12)
	SLT ADI R15, %lo(.LBB11_12)
	BRH C, R15
; %bb.11:                               ; %if.then22
	SLT ADD R2, R0, R3
.LBB11_12:                              ; %if.then22
	LDI R4, 0
	H LDI R4, current_display
	SLT ADI R4, current_display
	INT LOD R4, R4, 0
	H LDI R15, %hi(.LBB11_13)
	SLT ADI R15, %lo(.LBB11_13)
	JMP R15
.Lfunc_end11:
	.size	biosWrite, .Lfunc_end11-biosWrite
                                        ; -- End function
	.globl	intToAscii                      ; -- Begin function intToAscii
	.type	intToAscii,@function
intToAscii:                             ; @intToAscii
; %bb.0:                                ; %entry
	SLT ADI R14, 24
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	INT STR R14, R11, -16
	INT STR R14, R12, -20
	SLT ADD R1, R0, R8
	;APP
	CYE SR8, R9
	;NO_APP
	H LDI R15, %hi(irqOff)
	SLT ADI R15, %lo(irqOff)
	CAL R15
	LDI R1, 0
	H LDI R1, current_pool_index
	SLT ADI R1, current_pool_index
	INT LOD R1, R2, 0
	SLT ADD R2, R0, R3
	ADI R3, 1
	LDI R4, 7
	AND R3, R4, R3
	INT STR R1, R3, 0
	;APP
	CYR R9, SR8
	;NO_APP
	LDI R1, 5
	LSH R2, R1, R1
	LDI R2, 0
	H LDI R2, ascii_pool+31
	SLT ADI R2, ascii_pool+31
	ADD R1, R2, R3
	LDI R2, 0
	CHAR STR R3, R2, 0
	SUB R8, R2, R0
	H LDI R15, %hi(.LBB12_11)
	SLT ADI R15, %lo(.LBB12_11)
	BRH EQ, R15
; %bb.1:                                ; %while.body.preheader
	LDI R3, 31
	LDI R4, 1
	SLT ADD R8, R0, R5
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB12_3)
	SLT ADI R15, %lo(.LBB12_3)
	BRH EQ, R15
; %bb.2:                                ; %while.body.preheader
	RSH R8, R3, R5
	LSH R5, R4, R6
	SUB R5, R6, R5
.LBB12_3:                               ; %while.body.preheader
	XOR R8, R5, R6
	SUB R6, R5, R9
	LDI R5, 0
	H LDI R5, ascii_pool+30
	SLT ADI R5, ascii_pool+30
	ADD R1, R5, R1
	LDI R5, 0
	H LDI R5, 52429
	SLT ADI R5, -13107
	LDI R6, 3
	LDI R7, 246
	H LDI R15, %hi(.LBB12_4)
	SLT ADI R15, %lo(.LBB12_4)
	JMP R15
.LBB12_6:                               ; %while.body
                                        ;   in Loop: Header=BB12_4 Depth=1
	AND R10, R5, R10
	MUL R9, R5, R11
	GOF R12
	ADD R12, R10, R10
	ADD R10, R9, R10
	RSH R10, R6, R10
	MUL R10, R7, R11
	ADD R11, R9, R9
	ADI R9, 48
	CHAR STR R1, R9, 0
	ADI R1, -1
	SLT ADD R10, R0, R9
	SUB R10, R2, R0
	H LDI R15, %hi(.LBB12_7)
	SLT ADI R15, %lo(.LBB12_7)
	BRH EQ, R15
.LBB12_4:                               ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	SLT ADD R9, R0, R10
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB12_6)
	SLT ADI R15, %lo(.LBB12_6)
	BRH EQ, R15
; %bb.5:                                ; %while.body
                                        ;   in Loop: Header=BB12_4 Depth=1
	RSH R9, R3, R10
	LSH R10, R4, R11
	SUB R10, R11, R10
	H LDI R15, %hi(.LBB12_6)
	SLT ADI R15, %lo(.LBB12_6)
	JMP R15
.LBB12_7:                               ; %if.end15
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -1
	SUB R2, R8, R0
	H LDI R15, %hi(.LBB12_9)
	SLT ADI R15, %lo(.LBB12_9)
	BRH NN, R15
; %bb.8:
	ADI R1, 1
	H LDI R15, %hi(.LBB12_10)
	SLT ADI R15, %lo(.LBB12_10)
	JMP R15
.LBB12_11:                              ; %if.end15.thread
	LDI R2, 0
	H LDI R2, ascii_pool
	SLT ADI R2, ascii_pool
	ADD R1, R2, R1
	LDI R2, 48
	CHAR STR R1, R2, 30
	ADI R1, 30
	H LDI R15, %hi(.LBB12_10)
	SLT ADI R15, %lo(.LBB12_10)
	JMP R15
.LBB12_9:                               ; %if.then16
	LDI R2, 45
	CHAR STR R1, R2, 0
.LBB12_10:                              ; %if.end18
	INT LOD R14, R12, -20
	INT LOD R14, R11, -16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -24
	RET
.Lfunc_end12:
	.size	intToAscii, .Lfunc_end12-intToAscii
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
	H LDI R15, %hi(.LBB13_31)
	SLT ADI R15, %lo(.LBB13_31)
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
.LBB13_2:                               ; %for.cond2.preheader
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB13_3 Depth 2
	SLT ADD R9, R0, R13
	SLT ADD R9, R0, R1
.LBB13_3:                               ; %for.body5
                                        ;   Parent Loop BB13_2 Depth=1
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
	H LDI R15, %hi(.LBB13_4)
	SLT ADI R15, %lo(.LBB13_4)
	BRH EQ, R15
; %bb.9:                                ; %if.end16
                                        ;   in Loop: Header=BB13_3 Depth=2
	INT LOD R11, R1, 0
	LDI R2, 63
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB13_31)
	SLT ADI R15, %lo(.LBB13_31)
	BRH N, R15
; %bb.10:                               ; %if.end19
                                        ;   in Loop: Header=BB13_3 Depth=2
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
	H LDI R15, %hi(.LBB13_11)
	SLT ADI R15, %lo(.LBB13_11)
	BRH NE, R15
; %bb.32:                               ; %if.then79
                                        ;   in Loop: Header=BB13_3 Depth=2
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
	H LDI R15, %hi(.LBB13_34)
	SLT ADI R15, %lo(.LBB13_34)
	BRH NC, R15
; %bb.33:                               ; %if.then103
                                        ;   in Loop: Header=BB13_3 Depth=2
	LDI R3, 0
	H LDI R3, 1
	SLT ADI R3, -1
	ADD R2, R3, R2
	LDI R3, 0
	H LDI R3, 65535
	SLT ADI R3, 0
	AND R2, R3, R2
	INT STR R7, R2, 0
.LBB13_34:                              ; %if.end106
                                        ;   in Loop: Header=BB13_3 Depth=2
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
	H LDI R15, %hi(.LBB13_36)
	SLT ADI R15, %lo(.LBB13_36)
	BRH NC, R15
; %bb.35:                               ; %if.then130
                                        ;   in Loop: Header=BB13_3 Depth=2
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
.LBB13_36:                              ; %if.end139
                                        ;   in Loop: Header=BB13_3 Depth=2
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
	H LDI R15, %hi(.LBB13_38)
	SLT ADI R15, %lo(.LBB13_38)
	BRH N, R15
; %bb.37:                               ; %if.end139
                                        ;   in Loop: Header=BB13_3 Depth=2
	SLT ADD R9, R0, R1
.LBB13_38:                              ; %if.end139
                                        ;   in Loop: Header=BB13_3 Depth=2
	SLT ADD R4, R0, R2
	INT LOD R14, R5, -4
	LDI R8, 0
	H LDI R8, 49152
	SLT ADI R8, 0
	SUB R13, R9, R0
	H LDI R15, %hi(.LBB13_40)
	SLT ADI R15, %lo(.LBB13_40)
	BRH NE, R15
; %bb.39:                               ; %if.end139
                                        ;   in Loop: Header=BB13_3 Depth=2
	SLT ADD R9, R0, R2
.LBB13_40:                              ; %if.end139
                                        ;   in Loop: Header=BB13_3 Depth=2
	NOR R2, R1, R1
	NOR R1, R1, R1
	LDI R10, 0
	H LDI R10, mapa
	SLT ADI R10, mapa
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB13_42)
	SLT ADI R15, %lo(.LBB13_42)
	BRH NE, R15
; %bb.41:                               ; %if.end139
                                        ;   in Loop: Header=BB13_3 Depth=2
	ADI R13, 4096
	INT LOD R14, R3, -24
	SLT ADD R3, R0, R1
	ADI R1, 1
	LDI R2, 7
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB13_3)
	SLT ADI R15, %lo(.LBB13_3)
	BRH C, R15
	H LDI R15, %hi(.LBB13_42)
	SLT ADI R15, %lo(.LBB13_42)
	JMP R15
.LBB13_11:                              ; %if.end19
                                        ;   in Loop: Header=BB13_2 Depth=1
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
	H LDI R15, %hi(.LBB13_12)
	SLT ADI R15, %lo(.LBB13_12)
	BRH EQ, R15
	H LDI R15, %hi(.LBB13_42)
	SLT ADI R15, %lo(.LBB13_42)
	JMP R15
.LBB13_4:                               ; %if.then11
                                        ;   in Loop: Header=BB13_2 Depth=1
	SLT ADD R4, R0, R1
	SUB R5, R9, R0
	H LDI R15, %hi(.LBB13_6)
	SLT ADI R15, %lo(.LBB13_6)
	BRH NE, R15
; %bb.5:                                ; %if.then11
                                        ;   in Loop: Header=BB13_2 Depth=1
	SLT ADD R9, R0, R1
.LBB13_6:                               ; %if.then11
                                        ;   in Loop: Header=BB13_2 Depth=1
	SLT ADD R4, R0, R2
	INT LOD R14, R3, -12
	SUB R3, R9, R0
	H LDI R15, %hi(.LBB13_8)
	SLT ADI R15, %lo(.LBB13_8)
	BRH EQ, R15
; %bb.7:                                ; %if.then11
                                        ;   in Loop: Header=BB13_2 Depth=1
	SLT ADD R9, R0, R2
.LBB13_8:                               ; %if.then11
                                        ;   in Loop: Header=BB13_2 Depth=1
	AND R1, R2, R1
	AND R1, R4, R1
	SUB R1, R9, R0
	H LDI R15, %hi(.LBB13_31)
	SLT ADI R15, %lo(.LBB13_31)
	BRH NE, R15
.LBB13_42:                              ; %for.inc164
                                        ;   in Loop: Header=BB13_2 Depth=1
	INT LOD R14, R2, -12
	ADI R2, 1
	LDI R1, 32
	INT STR R14, R2, -12
	SUB R2, R1, R0
	H LDI R15, %hi(.LBB13_31)
	SLT ADI R15, %lo(.LBB13_31)
	BRH EQ, R15
; %bb.43:                               ; %for.cond2.preheader.backedge
                                        ;   in Loop: Header=BB13_2 Depth=1
	INT LOD R14, R1, -16
	LDI R2, 0
	H LDI R2, 1
	SLT ADI R2, -32768
	ADD R1, R2, R1
	INT STR R14, R1, -16
	H LDI R15, %hi(.LBB13_2)
	SLT ADI R15, %lo(.LBB13_2)
	JMP R15
.LBB13_12:                              ; %for.cond35.preheader
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
	H LDI R15, %hi(.LBB13_16)
	SLT ADI R15, %lo(.LBB13_16)
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
	H LDI R15, %hi(.LBB13_15)
	SLT ADI R15, %lo(.LBB13_15)
	BRH NC, R15
; %bb.14:
	ADI R4, 4095
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -4096
	AND R4, R5, R5
.LBB13_15:                              ; %if.end50
	INT LOD R14, R7, -8
	INT LOD R7, R4, 0
	ADD R4, R5, R4
	INT STR R7, R4, 0
	SLT ADD R12, R0, R8
.LBB13_16:                              ; %for.inc
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 20
	ADD R8, R4, R4
	INT STR R4, R3, 0
	INT LOD R4, R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB13_20)
	SLT ADI R15, %lo(.LBB13_20)
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
	H LDI R15, %hi(.LBB13_19)
	SLT ADI R15, %lo(.LBB13_19)
	BRH NC, R15
; %bb.18:
	ADI R3, 4095
	LDI R4, 0
	H LDI R4, 0
	SLT ADI R4, -4096
	AND R3, R4, R4
.LBB13_19:                              ; %if.end50.1
	INT LOD R7, R3, 0
	ADD R3, R4, R3
	INT STR R7, R3, 0
.LBB13_20:                              ; %for.inc.1
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
	H LDI R15, %hi(.LBB13_24)
	SLT ADI R15, %lo(.LBB13_24)
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
	H LDI R15, %hi(.LBB13_23)
	SLT ADI R15, %lo(.LBB13_23)
	BRH NC, R15
; %bb.22:
	ADI R4, 4095
	LDI R5, 0
	H LDI R5, 0
	SLT ADI R5, -4096
	AND R4, R5, R5
.LBB13_23:                              ; %if.end50.2
	INT LOD R14, R7, -8
	INT LOD R7, R4, 0
	ADD R4, R5, R4
	INT STR R7, R4, 0
.LBB13_24:                              ; %for.inc.2
	LDI R4, 0
	H LDI R4, 57344
	SLT ADI R4, 28
	ADD R8, R4, R4
	INT STR R4, R3, 0
	INT LOD R4, R3, 0
	SUB R3, R2, R0
	H LDI R15, %hi(.LBB13_25)
	SLT ADI R15, %lo(.LBB13_25)
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
	H LDI R15, %hi(.LBB13_27)
	SLT ADI R15, %lo(.LBB13_27)
	BRH NC, R15
; %bb.28:                               ; %if.then54.3
	INT LOD R7, R2, 0
	ADI R2, 4096
	H LDI R15, %hi(.LBB13_29)
	SLT ADI R15, %lo(.LBB13_29)
	JMP R15
.LBB13_25:                              ; %for.inc.2.for.inc.3_crit_edge
	INT LOD R7, R2, 0
	H LDI R15, %hi(.LBB13_30)
	SLT ADI R15, %lo(.LBB13_30)
	JMP R15
.LBB13_27:                              ; %if.else.3
	ADI R3, 4095
	LDI R2, 0
	H LDI R2, 0
	SLT ADI R2, -4096
	AND R3, R2, R2
	INT LOD R7, R3, 0
	ADD R3, R2, R2
.LBB13_29:                              ; %for.inc.3
	INT STR R7, R2, 0
.LBB13_30:                              ; %for.inc.3
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
.LBB13_31:                              ; %for.end168
	INT LOD R14, R13, -48
	INT LOD R14, R12, -44
	INT LOD R14, R11, -40
	INT LOD R14, R10, -36
	INT LOD R14, R9, -32
	INT LOD R14, R8, -28
	SLT ADI R14, -52
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
	SLT ADI R14, 16
	INT STR R14, R8, -4
	INT STR R14, R9, -8
	INT STR R14, R10, -12
	;APP
	CYE SR1, R3
	;NO_APP
	;APP
	CYE SR8, R8
	;NO_APP
	LDI R2, 8
	AND R8, R2, R5
	;APP
	CYE SR9, R10
	;NO_APP
	;APP
	CYE SR10, R9
	;NO_APP
	;APP
	CYE SR7, R4
	;NO_APP
	LDI R2, 0
	SUB R5, R2, R0
	H LDI R15, %hi(.LBB16_2)
	SLT ADI R15, %lo(.LBB16_2)
	BRH EQ, R15
; %bb.1:                                ; %if.then
	LDI R5, 4
	NOR R8, R5, R5
	NOR R5, R5, R5
	;APP
	CYR R5, SR8
	;NO_APP
.LBB16_2:                               ; %if.end
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB16_6)
	SLT ADI R15, %lo(.LBB16_6)
	BRH EQ, R15
; %bb.3:                                ; %if.then2
	LDI R1, 127
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB16_8)
	SLT ADI R15, %lo(.LBB16_8)
	BRH C, R15
; %bb.4:                                ; %land.lhs.true
	LDI R1, 2
	LSH R4, R1, R1
	LDI R4, 0
	H LDI R4, irq_table
	SLT ADI R4, irq_table
	ADD R1, R4, R1
	INT LOD R1, R4, 0
	SUB R4, R2, R0
	H LDI R15, %hi(.LBB16_8)
	SLT ADI R15, %lo(.LBB16_8)
	BRH EQ, R15
; %bb.5:                                ; %if.then5
	SLT ADD R8, R0, R1
	SLT ADD R3, R0, R2
	CAL R4
	H LDI R15, %hi(.LBB16_7)
	SLT ADI R15, %lo(.LBB16_7)
	JMP R15
.LBB16_6:                               ; %if.else
	SLT ADD R8, R0, R2
	H LDI R15, %hi(syscallsHandler)
	SLT ADI R15, %lo(syscallsHandler)
	CAL R15
.LBB16_7:                               ; %if.end9
	SLT ADD R1, R0, R3
.LBB16_8:                               ; %if.end9
	LDI R1, 0
	H LDI R1, 0
	SLT ADI R1, -5
	AND R8, R1, R1
	;APP
	CYR R1, SR8
	;NO_APP
	;APP
	CYR R3, SR1
	;NO_APP
	;APP
	CYR R10, SR9
	;NO_APP
	;APP
	CYR R9, SR10
	;NO_APP
	LDI R1, 0
	H LDI R1, Registros
	SLT ADI R1, Registros
	INT LOD R1, R1, 0
	LDI R2, 1
	INT STR R1, R2, 16
	INT LOD R14, R10, -12
	INT LOD R14, R9, -8
	INT LOD R14, R8, -4
	SLT ADI R14, -16
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
	.globl	initIRQs                        ; -- Begin function initIRQs
	.type	initIRQs,@function
initIRQs:                               ; @initIRQs
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	LDI R1, 0
	LDI R2, 0
	H LDI R2, irq_table
	SLT ADI R2, irq_table
	LDI R3, 0
	H LDI R3, defaultIRQHandler
	SLT ADI R3, defaultIRQHandler
	LDI R4, 512
.LBB18_1:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	ADD R1, R2, R5
	INT STR R5, R3, 0
	ADI R1, 4
	SUB R1, R4, R0
	H LDI R15, %hi(.LBB18_1)
	SLT ADI R15, %lo(.LBB18_1)
	BRH NE, R15
; %bb.2:                                ; %for.cond.cleanup
	SLT ADI R14, -4
	RET
.Lfunc_end18:
	.size	initIRQs, .Lfunc_end18-initIRQs
                                        ; -- End function
	.type	defaultIRQHandler,@function     ; -- Begin function defaultIRQHandler
defaultIRQHandler:                      ; @defaultIRQHandler
; %bb.0:                                ; %entry
	SLT ADI R14, 8
	INT STR R14, R8, -4
	SLT ADD R2, R0, R8
	H LDI R15, %hi(irqOff)
	SLT ADI R15, %lo(irqOff)
	CAL R15
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.6
	SLT ADI R1, .L.str.6
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
.Lfunc_end19:
	.size	defaultIRQHandler, .Lfunc_end19-defaultIRQHandler
                                        ; -- End function
	.globl	registerIRQHandler              ; -- Begin function registerIRQHandler
	.type	registerIRQHandler,@function
registerIRQHandler:                     ; @registerIRQHandler
; %bb.0:                                ; %entry
	SLT ADI R14, 4
	LDI R3, 127
	SUB R3, R1, R0
	H LDI R15, %hi(.LBB20_3)
	SLT ADI R15, %lo(.LBB20_3)
	BRH C, R15
; %bb.1:                                ; %entry
	LDI R3, 0
	SUB R2, R3, R0
	H LDI R15, %hi(.LBB20_3)
	SLT ADI R15, %lo(.LBB20_3)
	BRH EQ, R15
; %bb.2:                                ; %if.then
	LDI R3, 2
	LSH R1, R3, R1
	LDI R3, 0
	H LDI R3, irq_table
	SLT ADI R3, irq_table
	ADD R1, R3, R1
	INT STR R1, R2, 0
.LBB20_3:                               ; %if.end
	SLT ADI R14, -4
	RET
.Lfunc_end20:
	.size	registerIRQHandler, .Lfunc_end20-registerIRQHandler
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
	H LDI R15, %hi(irqOn)
	SLT ADI R15, %lo(irqOn)
	CAL R15
	SLT ADI R14, -4
	RET
.Lfunc_end21:
	.size	initLAPIC, .Lfunc_end21-initLAPIC
                                        ; -- End function
	.globl	irqOff                          ; -- Begin function irqOff
	.type	irqOff,@function
irqOff:                                 ; @irqOff
; %bb.0:                                ; %entry
	SLT ADI R14, 4
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
	SLT ADI R14, -4
	RET
.Lfunc_end22:
	.size	irqOff, .Lfunc_end22-irqOff
                                        ; -- End function
	.globl	irqOn                           ; -- Begin function irqOn
	.type	irqOn,@function
irqOn:                                  ; @irqOn
; %bb.0:                                ; %entry
	SLT ADI R14, 4
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
.Lfunc_end23:
	.size	irqOn, .Lfunc_end23-irqOn
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
	H LDI R1, .L.str.15
	SLT ADI R1, .L.str.15
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
	H LDI R1, .L.str.1.18
	SLT ADI R1, .L.str.1.18
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
	H LDI R1, .L.str.2.21
	SLT ADI R1, .L.str.2.21
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
	H LDI R1, .L.str.3.24
	SLT ADI R1, .L.str.3.24
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
.Lfunc_end28:
	.size	doubleFault, .Lfunc_end28-doubleFault
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
.Lfunc_end29:
	.size	syscallsHandler, .Lfunc_end29-syscallsHandler
                                        ; -- End function
	.globl	final                           ; -- Begin function final
	.type	final,@function
final:                                  ; @final
; %bb.0:                                ; %entry
	SLT ADI R14, 4
.LBB30_1:                               ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB30_1)
	SLT ADI R15, %lo(.LBB30_1)
	JMP R15
.Lfunc_end30:
	.size	final, .Lfunc_end30-final
                                        ; -- End function
	.globl	main                            ; -- Begin function main
	.type	main,@function
main:                                   ; @main
; %bb.0:                                ; %entry
	SLT ADI R14, 28
	INT STR R14, R8, -16
	INT STR R14, R9, -20
	INT STR R14, R10, -24
	H LDI R15, %hi(initIRQs)
	SLT ADI R15, %lo(initIRQs)
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
	H LDI R15, %hi(.LBB31_1)
	SLT ADI R15, %lo(.LBB31_1)
	BRH EQ, R15
; %bb.2:                                ; %if.end
	LDI R1, 0
	H LDI R1, .L.str.33
	SLT ADI R1, .L.str.33
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.1.34
	SLT ADI R1, .L.str.1.34
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, map_size
	SLT ADI R1, map_size
	INT LOD R1, R1, 0
	H LDI R15, %hi(intToAscii)
	SLT ADI R15, %lo(intToAscii)
	CAL R15
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.2.35
	SLT ADI R1, .L.str.2.35
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.3.36
	SLT ADI R1, .L.str.3.36
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(keyboardSearch)
	SLT ADI R15, %lo(keyboardSearch)
	CAL R15
	SUB R1, R8, R0
	H LDI R15, %hi(.LBB31_3)
	SLT ADI R15, %lo(.LBB31_3)
	BRH EQ, R15
; %bb.5:                                ; %if.end4
	LDI R8, 0
	ADD R14, R0, R9
	SLT ADI R9, -12
	LDI R10, 10
.LBB31_6:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	LDI R1, 0
	H LDI R1, .L.str.5
	SLT ADI R1, .L.str.5
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	SLT ADD R9, R0, R1
	SLT ADD R10, R0, R2
	H LDI R15, %hi(read)
	SLT ADI R15, %lo(read)
	CAL R15
	SLT ADD R9, R0, R1
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	LDI R1, 0
	H LDI R1, .L.str.6.38
	SLT ADI R1, .L.str.6.38
	SLT ADD R8, R0, R2
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
	H LDI R15, %hi(.LBB31_6)
	SLT ADI R15, %lo(.LBB31_6)
	JMP R15
.LBB31_1:                               ; %while.body.i
                                        ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB31_1)
	SLT ADI R15, %lo(.LBB31_1)
	JMP R15
.LBB31_3:                               ; %if.then3
	LDI R2, 0
	LDI R1, 0
	H LDI R1, .L.str.4.37
	SLT ADI R1, .L.str.4.37
	H LDI R15, %hi(biosWrite)
	SLT ADI R15, %lo(biosWrite)
	CAL R15
.LBB31_4:                               ; %while.body.i7
                                        ; =>This Inner Loop Header: Depth=1
	;APP
	HLT
	;NO_APP
	H LDI R15, %hi(.LBB31_4)
	SLT ADI R15, %lo(.LBB31_4)
	JMP R15
.Lfunc_end31:
	.size	main, .Lfunc_end31-main
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

	.type	line_buffer,@object             ; @line_buffer
	.globl	line_buffer
line_buffer:
	.zero	256
	.size	line_buffer, 256

	.type	.L.str,@object                  ; @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"\r\n"
	.size	.L.str, 3

	.type	.L.str.1,@object                ; @.str.1
.L.str.1:
	.asciz	"\b"
	.size	.L.str.1, 2

	.type	KeyboardDetected,@object        ; @KeyboardDetected
	.section	.bss,"aw",@nobits
	.globl	KeyboardDetected
KeyboardDetected:
	.byte	0                               ; 0x0
	.size	KeyboardDetected, 1

	.type	.L.str.2,@object                ; @.str.2
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.2:
	.asciz	"\nIRQs deshabilitadas. Imposible leer datos."
	.size	.L.str.2, 44

	.type	hardware_busy,@object           ; @hardware_busy
	.section	.bss,"aw",@nobits
	.globl	hardware_busy
hardware_busy:
	.byte	0                               ; 0x0
	.size	hardware_busy, 1

	.type	display_queue,@object           ; @display_queue
	.globl	display_queue
	.p2align	2, 0x0
display_queue:
	.zero	68
	.size	display_queue, 68

	.type	current_display,@object         ; @current_display
	.globl	current_display
	.p2align	2, 0x0
current_display:
	.zero	12
	.size	current_display, 12

	.type	DisplayDetected,@object         ; @DisplayDetected
	.globl	DisplayDetected
DisplayDetected:
	.byte	0                               ; 0x0
	.size	DisplayDetected, 1

	.type	.L.str.3,@object                ; @.str.3
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.3:
	.zero	1
	.size	.L.str.3, 1

	.type	ascii_pool,@object              ; @ascii_pool
	.local	ascii_pool
	.comm	ascii_pool,256,1
	.type	current_pool_index,@object      ; @current_pool_index
	.local	current_pool_index
	.comm	current_pool_index,4,4
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
	.type	.L.str.6,@object                ; @.str.6
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.6:
	.asciz	"Fatal Error: Unhandled IRQ"
	.size	.L.str.6, 27

	.type	system_panic,@object            ; @system_panic
	.section	.bss,"aw",@nobits
	.globl	system_panic
system_panic:
	.byte	0                               ; 0x0
	.size	system_panic, 1

	.type	.L.str.15,@object               ; @.str.15
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.15:
	.asciz	"\nFatal Error: Page Fault without MMU"
	.size	.L.str.15, 37

	.type	.L.str.1.18,@object             ; @.str.1.18
.L.str.1.18:
	.asciz	"\nFatal Error: Alignament Fault"
	.size	.L.str.1.18, 31

	.type	.L.str.2.21,@object             ; @.str.2.21
.L.str.2.21:
	.asciz	"\nFatal Error: General Protection Fault"
	.size	.L.str.2.21, 39

	.type	.L.str.3.24,@object             ; @.str.3.24
.L.str.3.24:
	.asciz	"\nFatal Error: Invalid OpCode"
	.size	.L.str.3.24, 29

	.type	.L.str.4,@object                ; @.str.4
.L.str.4:
	.asciz	"\nFatal Error: Double Fault"
	.size	.L.str.4, 27

	.type	mapa,@object                    ; @mapa
	.data
	.globl	mapa
	.p2align	2, 0x0
mapa:
	.long	134217728
	.size	mapa, 4

	.type	map_size,@object                ; @map_size
	.section	.bss,"aw",@nobits
	.globl	map_size
	.p2align	2, 0x0
map_size:
	.long	0                               ; 0x0
	.size	map_size, 4

	.type	.L.str.33,@object               ; @.str.33
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.33:
	.asciz	"Enumeracion de buses finalizada.\n"
	.size	.L.str.33, 34

	.type	.L.str.1.34,@object             ; @.str.1.34
.L.str.1.34:
	.asciz	"Hay "
	.size	.L.str.1.34, 5

	.type	.L.str.2.35,@object             ; @.str.2.35
.L.str.2.35:
	.asciz	" dispositivos conectados.\n\n"
	.size	.L.str.2.35, 28

	.type	.L.str.3.36,@object             ; @.str.3.36
.L.str.3.36:
	.asciz	"LAPIC e IRQs inicializadas.\n\n"
	.size	.L.str.3.36, 30

	.type	.L.str.4.37,@object             ; @.str.4.37
.L.str.4.37:
	.asciz	"No hay teclado conectado"
	.size	.L.str.4.37, 25

	.type	.L.str.5,@object                ; @.str.5
.L.str.5:
	.asciz	"Escriba "
	.size	.L.str.5, 9

	.type	.L.str.6.38,@object             ; @.str.6.38
.L.str.6.38:
	.asciz	"\n"
	.size	.L.str.6.38, 2

	.ident	"clang version 24.0.0git (https://github.com/Licha-M/llvm-project-ISA32-LM.git 0c5e6fd97de1a741b0b4c4168ebb7d55fa03ab17)"
	.section	".note.GNU-stack","",@progbits

; ════════════════════ .start auto-generado ════════════════════
; Inicio en palabra ROM 2208 (byte 0x002280)
; .start:
; ── Fase 1: Copiar 109 palabra(s) de .data  ROM → RAM ──────────────
;	H LDI R15, 0xFFF0		; Dir. ROM origen .data (palabra 2099, byte 0x0020CC)
;	SLT ADI R15, 0x20CC
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
; ── Fase 2: Zero-inicializar 284 palabra(s) de .bss en RAM ─────────────
;	H LDI R1, 0x0400		; Base .bss en RAM = 0x040001B4
;	SLT ADI R1, 0x01B4
;	INT STR R1, R0, 0		; RAM[0x040001B4] = 0  (.bss[0])
;	INT STR R1, R0, 4		; RAM[0x040001B8] = 0  (.bss[1])
;	INT STR R1, R0, 8		; RAM[0x040001BC] = 0  (.bss[2])
;	INT STR R1, R0, 12		; RAM[0x040001C0] = 0  (.bss[3])
;	INT STR R1, R0, 16		; RAM[0x040001C4] = 0  (.bss[4])
;	INT STR R1, R0, 20		; RAM[0x040001C8] = 0  (.bss[5])
;	INT STR R1, R0, 24		; RAM[0x040001CC] = 0  (.bss[6])
;	INT STR R1, R0, 28		; RAM[0x040001D0] = 0  (.bss[7])
;	INT STR R1, R0, 32		; RAM[0x040001D4] = 0  (.bss[8])
;	INT STR R1, R0, 36		; RAM[0x040001D8] = 0  (.bss[9])
;	INT STR R1, R0, 40		; RAM[0x040001DC] = 0  (.bss[10])
;	INT STR R1, R0, 44		; RAM[0x040001E0] = 0  (.bss[11])
;	INT STR R1, R0, 48		; RAM[0x040001E4] = 0  (.bss[12])
;	INT STR R1, R0, 52		; RAM[0x040001E8] = 0  (.bss[13])
;	INT STR R1, R0, 56		; RAM[0x040001EC] = 0  (.bss[14])
;	INT STR R1, R0, 60		; RAM[0x040001F0] = 0  (.bss[15])
;	INT STR R1, R0, 64		; RAM[0x040001F4] = 0  (.bss[16])
;	INT STR R1, R0, 68		; RAM[0x040001F8] = 0  (.bss[17])
;	INT STR R1, R0, 72		; RAM[0x040001FC] = 0  (.bss[18])
;	INT STR R1, R0, 76		; RAM[0x04000200] = 0  (.bss[19])
;	INT STR R1, R0, 80		; RAM[0x04000204] = 0  (.bss[20])
;	INT STR R1, R0, 84		; RAM[0x04000208] = 0  (.bss[21])
;	INT STR R1, R0, 88		; RAM[0x0400020C] = 0  (.bss[22])
;	INT STR R1, R0, 92		; RAM[0x04000210] = 0  (.bss[23])
;	INT STR R1, R0, 96		; RAM[0x04000214] = 0  (.bss[24])
;	INT STR R1, R0, 100		; RAM[0x04000218] = 0  (.bss[25])
;	INT STR R1, R0, 104		; RAM[0x0400021C] = 0  (.bss[26])
;	INT STR R1, R0, 108		; RAM[0x04000220] = 0  (.bss[27])
;	INT STR R1, R0, 112		; RAM[0x04000224] = 0  (.bss[28])
;	INT STR R1, R0, 116		; RAM[0x04000228] = 0  (.bss[29])
;	INT STR R1, R0, 120		; RAM[0x0400022C] = 0  (.bss[30])
;	INT STR R1, R0, 124		; RAM[0x04000230] = 0  (.bss[31])
;	INT STR R1, R0, 128		; RAM[0x04000234] = 0  (.bss[32])
;	INT STR R1, R0, 132		; RAM[0x04000238] = 0  (.bss[33])
;	INT STR R1, R0, 136		; RAM[0x0400023C] = 0  (.bss[34])
;	INT STR R1, R0, 140		; RAM[0x04000240] = 0  (.bss[35])
;	INT STR R1, R0, 144		; RAM[0x04000244] = 0  (.bss[36])
;	INT STR R1, R0, 148		; RAM[0x04000248] = 0  (.bss[37])
;	INT STR R1, R0, 152		; RAM[0x0400024C] = 0  (.bss[38])
;	INT STR R1, R0, 156		; RAM[0x04000250] = 0  (.bss[39])
;	INT STR R1, R0, 160		; RAM[0x04000254] = 0  (.bss[40])
;	INT STR R1, R0, 164		; RAM[0x04000258] = 0  (.bss[41])
;	INT STR R1, R0, 168		; RAM[0x0400025C] = 0  (.bss[42])
;	INT STR R1, R0, 172		; RAM[0x04000260] = 0  (.bss[43])
;	INT STR R1, R0, 176		; RAM[0x04000264] = 0  (.bss[44])
;	INT STR R1, R0, 180		; RAM[0x04000268] = 0  (.bss[45])
;	INT STR R1, R0, 184		; RAM[0x0400026C] = 0  (.bss[46])
;	INT STR R1, R0, 188		; RAM[0x04000270] = 0  (.bss[47])
;	INT STR R1, R0, 192		; RAM[0x04000274] = 0  (.bss[48])
;	INT STR R1, R0, 196		; RAM[0x04000278] = 0  (.bss[49])
;	INT STR R1, R0, 200		; RAM[0x0400027C] = 0  (.bss[50])
;	INT STR R1, R0, 204		; RAM[0x04000280] = 0  (.bss[51])
;	INT STR R1, R0, 208		; RAM[0x04000284] = 0  (.bss[52])
;	INT STR R1, R0, 212		; RAM[0x04000288] = 0  (.bss[53])
;	INT STR R1, R0, 216		; RAM[0x0400028C] = 0  (.bss[54])
;	INT STR R1, R0, 220		; RAM[0x04000290] = 0  (.bss[55])
;	INT STR R1, R0, 224		; RAM[0x04000294] = 0  (.bss[56])
;	INT STR R1, R0, 228		; RAM[0x04000298] = 0  (.bss[57])
;	INT STR R1, R0, 232		; RAM[0x0400029C] = 0  (.bss[58])
;	INT STR R1, R0, 236		; RAM[0x040002A0] = 0  (.bss[59])
;	INT STR R1, R0, 240		; RAM[0x040002A4] = 0  (.bss[60])
;	INT STR R1, R0, 244		; RAM[0x040002A8] = 0  (.bss[61])
;	INT STR R1, R0, 248		; RAM[0x040002AC] = 0  (.bss[62])
;	INT STR R1, R0, 252		; RAM[0x040002B0] = 0  (.bss[63])
;	INT STR R1, R0, 256		; RAM[0x040002B4] = 0  (.bss[64])
;	INT STR R1, R0, 260		; RAM[0x040002B8] = 0  (.bss[65])
;	INT STR R1, R0, 264		; RAM[0x040002BC] = 0  (.bss[66])
;	INT STR R1, R0, 268		; RAM[0x040002C0] = 0  (.bss[67])
;	INT STR R1, R0, 272		; RAM[0x040002C4] = 0  (.bss[68])
;	INT STR R1, R0, 276		; RAM[0x040002C8] = 0  (.bss[69])
;	INT STR R1, R0, 280		; RAM[0x040002CC] = 0  (.bss[70])
;	INT STR R1, R0, 284		; RAM[0x040002D0] = 0  (.bss[71])
;	INT STR R1, R0, 288		; RAM[0x040002D4] = 0  (.bss[72])
;	INT STR R1, R0, 292		; RAM[0x040002D8] = 0  (.bss[73])
;	INT STR R1, R0, 296		; RAM[0x040002DC] = 0  (.bss[74])
;	INT STR R1, R0, 300		; RAM[0x040002E0] = 0  (.bss[75])
;	INT STR R1, R0, 304		; RAM[0x040002E4] = 0  (.bss[76])
;	INT STR R1, R0, 308		; RAM[0x040002E8] = 0  (.bss[77])
;	INT STR R1, R0, 312		; RAM[0x040002EC] = 0  (.bss[78])
;	INT STR R1, R0, 316		; RAM[0x040002F0] = 0  (.bss[79])
;	INT STR R1, R0, 320		; RAM[0x040002F4] = 0  (.bss[80])
;	INT STR R1, R0, 324		; RAM[0x040002F8] = 0  (.bss[81])
;	INT STR R1, R0, 328		; RAM[0x040002FC] = 0  (.bss[82])
;	INT STR R1, R0, 332		; RAM[0x04000300] = 0  (.bss[83])
;	INT STR R1, R0, 336		; RAM[0x04000304] = 0  (.bss[84])
;	INT STR R1, R0, 340		; RAM[0x04000308] = 0  (.bss[85])
;	INT STR R1, R0, 344		; RAM[0x0400030C] = 0  (.bss[86])
;	INT STR R1, R0, 348		; RAM[0x04000310] = 0  (.bss[87])
;	INT STR R1, R0, 352		; RAM[0x04000314] = 0  (.bss[88])
;	INT STR R1, R0, 356		; RAM[0x04000318] = 0  (.bss[89])
;	INT STR R1, R0, 360		; RAM[0x0400031C] = 0  (.bss[90])
;	INT STR R1, R0, 364		; RAM[0x04000320] = 0  (.bss[91])
;	INT STR R1, R0, 368		; RAM[0x04000324] = 0  (.bss[92])
;	INT STR R1, R0, 372		; RAM[0x04000328] = 0  (.bss[93])
;	INT STR R1, R0, 376		; RAM[0x0400032C] = 0  (.bss[94])
;	INT STR R1, R0, 380		; RAM[0x04000330] = 0  (.bss[95])
;	INT STR R1, R0, 384		; RAM[0x04000334] = 0  (.bss[96])
;	INT STR R1, R0, 388		; RAM[0x04000338] = 0  (.bss[97])
;	INT STR R1, R0, 392		; RAM[0x0400033C] = 0  (.bss[98])
;	INT STR R1, R0, 396		; RAM[0x04000340] = 0  (.bss[99])
;	INT STR R1, R0, 400		; RAM[0x04000344] = 0  (.bss[100])
;	INT STR R1, R0, 404		; RAM[0x04000348] = 0  (.bss[101])
;	INT STR R1, R0, 408		; RAM[0x0400034C] = 0  (.bss[102])
;	INT STR R1, R0, 412		; RAM[0x04000350] = 0  (.bss[103])
;	INT STR R1, R0, 416		; RAM[0x04000354] = 0  (.bss[104])
;	INT STR R1, R0, 420		; RAM[0x04000358] = 0  (.bss[105])
;	INT STR R1, R0, 424		; RAM[0x0400035C] = 0  (.bss[106])
;	INT STR R1, R0, 428		; RAM[0x04000360] = 0  (.bss[107])
;	INT STR R1, R0, 432		; RAM[0x04000364] = 0  (.bss[108])
;	INT STR R1, R0, 436		; RAM[0x04000368] = 0  (.bss[109])
;	INT STR R1, R0, 440		; RAM[0x0400036C] = 0  (.bss[110])
;	INT STR R1, R0, 444		; RAM[0x04000370] = 0  (.bss[111])
;	INT STR R1, R0, 448		; RAM[0x04000374] = 0  (.bss[112])
;	INT STR R1, R0, 452		; RAM[0x04000378] = 0  (.bss[113])
;	INT STR R1, R0, 456		; RAM[0x0400037C] = 0  (.bss[114])
;	INT STR R1, R0, 460		; RAM[0x04000380] = 0  (.bss[115])
;	INT STR R1, R0, 464		; RAM[0x04000384] = 0  (.bss[116])
;	INT STR R1, R0, 468		; RAM[0x04000388] = 0  (.bss[117])
;	INT STR R1, R0, 472		; RAM[0x0400038C] = 0  (.bss[118])
;	INT STR R1, R0, 476		; RAM[0x04000390] = 0  (.bss[119])
;	INT STR R1, R0, 480		; RAM[0x04000394] = 0  (.bss[120])
;	INT STR R1, R0, 484		; RAM[0x04000398] = 0  (.bss[121])
;	INT STR R1, R0, 488		; RAM[0x0400039C] = 0  (.bss[122])
;	INT STR R1, R0, 492		; RAM[0x040003A0] = 0  (.bss[123])
;	INT STR R1, R0, 496		; RAM[0x040003A4] = 0  (.bss[124])
;	INT STR R1, R0, 500		; RAM[0x040003A8] = 0  (.bss[125])
;	INT STR R1, R0, 504		; RAM[0x040003AC] = 0  (.bss[126])
;	INT STR R1, R0, 508		; RAM[0x040003B0] = 0  (.bss[127])
;	INT STR R1, R0, 512		; RAM[0x040003B4] = 0  (.bss[128])
;	INT STR R1, R0, 516		; RAM[0x040003B8] = 0  (.bss[129])
;	INT STR R1, R0, 520		; RAM[0x040003BC] = 0  (.bss[130])
;	INT STR R1, R0, 524		; RAM[0x040003C0] = 0  (.bss[131])
;	INT STR R1, R0, 528		; RAM[0x040003C4] = 0  (.bss[132])
;	INT STR R1, R0, 532		; RAM[0x040003C8] = 0  (.bss[133])
;	INT STR R1, R0, 536		; RAM[0x040003CC] = 0  (.bss[134])
;	INT STR R1, R0, 540		; RAM[0x040003D0] = 0  (.bss[135])
;	INT STR R1, R0, 544		; RAM[0x040003D4] = 0  (.bss[136])
;	INT STR R1, R0, 548		; RAM[0x040003D8] = 0  (.bss[137])
;	INT STR R1, R0, 552		; RAM[0x040003DC] = 0  (.bss[138])
;	INT STR R1, R0, 556		; RAM[0x040003E0] = 0  (.bss[139])
;	INT STR R1, R0, 560		; RAM[0x040003E4] = 0  (.bss[140])
;	INT STR R1, R0, 564		; RAM[0x040003E8] = 0  (.bss[141])
;	INT STR R1, R0, 568		; RAM[0x040003EC] = 0  (.bss[142])
;	INT STR R1, R0, 572		; RAM[0x040003F0] = 0  (.bss[143])
;	INT STR R1, R0, 576		; RAM[0x040003F4] = 0  (.bss[144])
;	INT STR R1, R0, 580		; RAM[0x040003F8] = 0  (.bss[145])
;	INT STR R1, R0, 584		; RAM[0x040003FC] = 0  (.bss[146])
;	INT STR R1, R0, 588		; RAM[0x04000400] = 0  (.bss[147])
;	INT STR R1, R0, 592		; RAM[0x04000404] = 0  (.bss[148])
;	INT STR R1, R0, 596		; RAM[0x04000408] = 0  (.bss[149])
;	INT STR R1, R0, 600		; RAM[0x0400040C] = 0  (.bss[150])
;	INT STR R1, R0, 604		; RAM[0x04000410] = 0  (.bss[151])
;	INT STR R1, R0, 608		; RAM[0x04000414] = 0  (.bss[152])
;	INT STR R1, R0, 612		; RAM[0x04000418] = 0  (.bss[153])
;	INT STR R1, R0, 616		; RAM[0x0400041C] = 0  (.bss[154])
;	INT STR R1, R0, 620		; RAM[0x04000420] = 0  (.bss[155])
;	INT STR R1, R0, 624		; RAM[0x04000424] = 0  (.bss[156])
;	INT STR R1, R0, 628		; RAM[0x04000428] = 0  (.bss[157])
;	INT STR R1, R0, 632		; RAM[0x0400042C] = 0  (.bss[158])
;	INT STR R1, R0, 636		; RAM[0x04000430] = 0  (.bss[159])
;	INT STR R1, R0, 640		; RAM[0x04000434] = 0  (.bss[160])
;	INT STR R1, R0, 644		; RAM[0x04000438] = 0  (.bss[161])
;	INT STR R1, R0, 648		; RAM[0x0400043C] = 0  (.bss[162])
;	INT STR R1, R0, 652		; RAM[0x04000440] = 0  (.bss[163])
;	INT STR R1, R0, 656		; RAM[0x04000444] = 0  (.bss[164])
;	INT STR R1, R0, 660		; RAM[0x04000448] = 0  (.bss[165])
;	INT STR R1, R0, 664		; RAM[0x0400044C] = 0  (.bss[166])
;	INT STR R1, R0, 668		; RAM[0x04000450] = 0  (.bss[167])
;	INT STR R1, R0, 672		; RAM[0x04000454] = 0  (.bss[168])
;	INT STR R1, R0, 676		; RAM[0x04000458] = 0  (.bss[169])
;	INT STR R1, R0, 680		; RAM[0x0400045C] = 0  (.bss[170])
;	INT STR R1, R0, 684		; RAM[0x04000460] = 0  (.bss[171])
;	INT STR R1, R0, 688		; RAM[0x04000464] = 0  (.bss[172])
;	INT STR R1, R0, 692		; RAM[0x04000468] = 0  (.bss[173])
;	INT STR R1, R0, 696		; RAM[0x0400046C] = 0  (.bss[174])
;	INT STR R1, R0, 700		; RAM[0x04000470] = 0  (.bss[175])
;	INT STR R1, R0, 704		; RAM[0x04000474] = 0  (.bss[176])
;	INT STR R1, R0, 708		; RAM[0x04000478] = 0  (.bss[177])
;	INT STR R1, R0, 712		; RAM[0x0400047C] = 0  (.bss[178])
;	INT STR R1, R0, 716		; RAM[0x04000480] = 0  (.bss[179])
;	INT STR R1, R0, 720		; RAM[0x04000484] = 0  (.bss[180])
;	INT STR R1, R0, 724		; RAM[0x04000488] = 0  (.bss[181])
;	INT STR R1, R0, 728		; RAM[0x0400048C] = 0  (.bss[182])
;	INT STR R1, R0, 732		; RAM[0x04000490] = 0  (.bss[183])
;	INT STR R1, R0, 736		; RAM[0x04000494] = 0  (.bss[184])
;	INT STR R1, R0, 740		; RAM[0x04000498] = 0  (.bss[185])
;	INT STR R1, R0, 744		; RAM[0x0400049C] = 0  (.bss[186])
;	INT STR R1, R0, 748		; RAM[0x040004A0] = 0  (.bss[187])
;	INT STR R1, R0, 752		; RAM[0x040004A4] = 0  (.bss[188])
;	INT STR R1, R0, 756		; RAM[0x040004A8] = 0  (.bss[189])
;	INT STR R1, R0, 760		; RAM[0x040004AC] = 0  (.bss[190])
;	INT STR R1, R0, 764		; RAM[0x040004B0] = 0  (.bss[191])
;	INT STR R1, R0, 768		; RAM[0x040004B4] = 0  (.bss[192])
;	INT STR R1, R0, 772		; RAM[0x040004B8] = 0  (.bss[193])
;	INT STR R1, R0, 776		; RAM[0x040004BC] = 0  (.bss[194])
;	INT STR R1, R0, 780		; RAM[0x040004C0] = 0  (.bss[195])
;	INT STR R1, R0, 784		; RAM[0x040004C4] = 0  (.bss[196])
;	INT STR R1, R0, 788		; RAM[0x040004C8] = 0  (.bss[197])
;	INT STR R1, R0, 792		; RAM[0x040004CC] = 0  (.bss[198])
;	INT STR R1, R0, 796		; RAM[0x040004D0] = 0  (.bss[199])
;	INT STR R1, R0, 800		; RAM[0x040004D4] = 0  (.bss[200])
;	INT STR R1, R0, 804		; RAM[0x040004D8] = 0  (.bss[201])
;	INT STR R1, R0, 808		; RAM[0x040004DC] = 0  (.bss[202])
;	INT STR R1, R0, 812		; RAM[0x040004E0] = 0  (.bss[203])
;	INT STR R1, R0, 816		; RAM[0x040004E4] = 0  (.bss[204])
;	INT STR R1, R0, 820		; RAM[0x040004E8] = 0  (.bss[205])
;	INT STR R1, R0, 824		; RAM[0x040004EC] = 0  (.bss[206])
;	INT STR R1, R0, 828		; RAM[0x040004F0] = 0  (.bss[207])
;	INT STR R1, R0, 832		; RAM[0x040004F4] = 0  (.bss[208])
;	INT STR R1, R0, 836		; RAM[0x040004F8] = 0  (.bss[209])
;	INT STR R1, R0, 840		; RAM[0x040004FC] = 0  (.bss[210])
;	INT STR R1, R0, 844		; RAM[0x04000500] = 0  (.bss[211])
;	INT STR R1, R0, 848		; RAM[0x04000504] = 0  (.bss[212])
;	INT STR R1, R0, 852		; RAM[0x04000508] = 0  (.bss[213])
;	INT STR R1, R0, 856		; RAM[0x0400050C] = 0  (.bss[214])
;	INT STR R1, R0, 860		; RAM[0x04000510] = 0  (.bss[215])
;	INT STR R1, R0, 864		; RAM[0x04000514] = 0  (.bss[216])
;	INT STR R1, R0, 868		; RAM[0x04000518] = 0  (.bss[217])
;	INT STR R1, R0, 872		; RAM[0x0400051C] = 0  (.bss[218])
;	INT STR R1, R0, 876		; RAM[0x04000520] = 0  (.bss[219])
;	INT STR R1, R0, 880		; RAM[0x04000524] = 0  (.bss[220])
;	INT STR R1, R0, 884		; RAM[0x04000528] = 0  (.bss[221])
;	INT STR R1, R0, 888		; RAM[0x0400052C] = 0  (.bss[222])
;	INT STR R1, R0, 892		; RAM[0x04000530] = 0  (.bss[223])
;	INT STR R1, R0, 896		; RAM[0x04000534] = 0  (.bss[224])
;	INT STR R1, R0, 900		; RAM[0x04000538] = 0  (.bss[225])
;	INT STR R1, R0, 904		; RAM[0x0400053C] = 0  (.bss[226])
;	INT STR R1, R0, 908		; RAM[0x04000540] = 0  (.bss[227])
;	INT STR R1, R0, 912		; RAM[0x04000544] = 0  (.bss[228])
;	INT STR R1, R0, 916		; RAM[0x04000548] = 0  (.bss[229])
;	INT STR R1, R0, 920		; RAM[0x0400054C] = 0  (.bss[230])
;	INT STR R1, R0, 924		; RAM[0x04000550] = 0  (.bss[231])
;	INT STR R1, R0, 928		; RAM[0x04000554] = 0  (.bss[232])
;	INT STR R1, R0, 932		; RAM[0x04000558] = 0  (.bss[233])
;	INT STR R1, R0, 936		; RAM[0x0400055C] = 0  (.bss[234])
;	INT STR R1, R0, 940		; RAM[0x04000560] = 0  (.bss[235])
;	INT STR R1, R0, 944		; RAM[0x04000564] = 0  (.bss[236])
;	INT STR R1, R0, 948		; RAM[0x04000568] = 0  (.bss[237])
;	INT STR R1, R0, 952		; RAM[0x0400056C] = 0  (.bss[238])
;	INT STR R1, R0, 956		; RAM[0x04000570] = 0  (.bss[239])
;	INT STR R1, R0, 960		; RAM[0x04000574] = 0  (.bss[240])
;	INT STR R1, R0, 964		; RAM[0x04000578] = 0  (.bss[241])
;	INT STR R1, R0, 968		; RAM[0x0400057C] = 0  (.bss[242])
;	INT STR R1, R0, 972		; RAM[0x04000580] = 0  (.bss[243])
;	INT STR R1, R0, 976		; RAM[0x04000584] = 0  (.bss[244])
;	INT STR R1, R0, 980		; RAM[0x04000588] = 0  (.bss[245])
;	INT STR R1, R0, 984		; RAM[0x0400058C] = 0  (.bss[246])
;	INT STR R1, R0, 988		; RAM[0x04000590] = 0  (.bss[247])
;	INT STR R1, R0, 992		; RAM[0x04000594] = 0  (.bss[248])
;	INT STR R1, R0, 996		; RAM[0x04000598] = 0  (.bss[249])
;	INT STR R1, R0, 1000		; RAM[0x0400059C] = 0  (.bss[250])
;	INT STR R1, R0, 1004		; RAM[0x040005A0] = 0  (.bss[251])
;	INT STR R1, R0, 1008		; RAM[0x040005A4] = 0  (.bss[252])
;	INT STR R1, R0, 1012		; RAM[0x040005A8] = 0  (.bss[253])
;	INT STR R1, R0, 1016		; RAM[0x040005AC] = 0  (.bss[254])
;	INT STR R1, R0, 1020		; RAM[0x040005B0] = 0  (.bss[255])
;	INT STR R1, R0, 1024		; RAM[0x040005B4] = 0  (.bss[256])
;	INT STR R1, R0, 1028		; RAM[0x040005B8] = 0  (.bss[257])
;	INT STR R1, R0, 1032		; RAM[0x040005BC] = 0  (.bss[258])
;	INT STR R1, R0, 1036		; RAM[0x040005C0] = 0  (.bss[259])
;	INT STR R1, R0, 1040		; RAM[0x040005C4] = 0  (.bss[260])
;	INT STR R1, R0, 1044		; RAM[0x040005C8] = 0  (.bss[261])
;	INT STR R1, R0, 1048		; RAM[0x040005CC] = 0  (.bss[262])
;	INT STR R1, R0, 1052		; RAM[0x040005D0] = 0  (.bss[263])
;	INT STR R1, R0, 1056		; RAM[0x040005D4] = 0  (.bss[264])
;	INT STR R1, R0, 1060		; RAM[0x040005D8] = 0  (.bss[265])
;	INT STR R1, R0, 1064		; RAM[0x040005DC] = 0  (.bss[266])
;	INT STR R1, R0, 1068		; RAM[0x040005E0] = 0  (.bss[267])
;	INT STR R1, R0, 1072		; RAM[0x040005E4] = 0  (.bss[268])
;	INT STR R1, R0, 1076		; RAM[0x040005E8] = 0  (.bss[269])
;	INT STR R1, R0, 1080		; RAM[0x040005EC] = 0  (.bss[270])
;	INT STR R1, R0, 1084		; RAM[0x040005F0] = 0  (.bss[271])
;	INT STR R1, R0, 1088		; RAM[0x040005F4] = 0  (.bss[272])
;	INT STR R1, R0, 1092		; RAM[0x040005F8] = 0  (.bss[273])
;	INT STR R1, R0, 1096		; RAM[0x040005FC] = 0  (.bss[274])
;	INT STR R1, R0, 1100		; RAM[0x04000600] = 0  (.bss[275])
;	INT STR R1, R0, 1104		; RAM[0x04000604] = 0  (.bss[276])
;	INT STR R1, R0, 1108		; RAM[0x04000608] = 0  (.bss[277])
;	INT STR R1, R0, 1112		; RAM[0x0400060C] = 0  (.bss[278])
;	INT STR R1, R0, 1116		; RAM[0x04000610] = 0  (.bss[279])
;	INT STR R1, R0, 1120		; RAM[0x04000614] = 0  (.bss[280])
;	INT STR R1, R0, 1124		; RAM[0x04000618] = 0  (.bss[281])
;	INT STR R1, R0, 1128		; RAM[0x0400061C] = 0  (.bss[282])
;	INT STR R1, R0, 1132		; RAM[0x04000620] = 0  (.bss[283])
; ── Fase 3: Saltar a main ──────────────────────────────────────────────────
;	H LDI R15, %hi(main)		; Parte alta de la dirección de main
;	SLT ADI R15, %lo(main)	; Parte baja
;	JMP R15

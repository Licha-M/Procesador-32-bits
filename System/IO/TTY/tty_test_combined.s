	.file	"tty_test.c"
	.text
	.globl	main                            ; -- Begin function main
	.type	main,@function
main:                                   ; @main
; %bb.0:                                ; %entry
	ADI R14, 4
	LDI R1, 0
	H LDI R1, 49153
	SLT ADI R1, -16384
	LDI R2, 0
	H LDI R2, 57345
	SLT ADI R2, -32744
	INT STR R2, R1, 0
	LDI R1, 0
	H LDI R1, 1
	SLT ADI R1, 256
	LDI R2, 0
	H LDI R2, 57345
	SLT ADI R2, -32752
	INT STR R2, R1, 0
	LDI R1, 1
	LDI R2, 0
	H LDI R2, 57345
	SLT ADI R2, -32764
	INT STR R2, R1, 0
	LDI R2, 0
	H LDI R2, 49152
	SLT ADI R2, 0
	LDI R3, 0
	H LDI R3, 57360
	SLT ADI R3, 16
	INT STR R3, R2, 0
	LDI R3, 3
	LDI R4, 0
	H LDI R4, 57360
	SLT ADI R4, 4
	INT STR R4, R3, 0
	LDI R5, 72
	LDI R4, 0
	H LDI R4, 49152
	SLT ADI R4, 4
	INT STR R4, R5, 0
	LDI R5, 0
	H LDI R5, 49152
	SLT ADI R5, 12
	INT STR R5, R1, 0
	INT STR R2, R1, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	LDI R6, 111
	INT STR R4, R6, 0
	INT STR R5, R1, 0
	INT STR R2, R1, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	LDI R7, 108
	INT STR R4, R7, 0
	INT STR R5, R1, 0
	INT STR R2, R1, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	LDI R7, 97
	INT STR R4, R7, 0
	INT STR R5, R1, 0
	INT STR R2, R1, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	LDI R7, 32
	INT STR R4, R7, 0
	INT STR R5, R1, 0
	INT STR R2, R1, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	LDI R7, 77
	INT STR R4, R7, 0
	INT STR R5, R1, 0
	INT STR R2, R1, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	LDI R7, 117
	INT STR R4, R7, 0
	INT STR R5, R1, 0
	INT STR R2, R1, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	LDI R7, 110
	INT STR R4, R7, 0
	INT STR R5, R1, 0
	INT STR R2, R1, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	LDI R7, 100
	INT STR R4, R7, 0
	INT STR R5, R1, 0
	INT STR R2, R1, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	INT STR R4, R6, 0
	INT STR R5, R1, 0
	INT STR R2, R1, 0
	;APP
	NOP
	;NO_APP
	;APP
	NOP
	;NO_APP
	LDI R6, 33
	INT STR R4, R6, 0
	INT STR R5, R3, 0
	INT STR R2, R1, 0
	;APP
	HLT
	;NO_APP
	LDI R1, 0
	ADI R14, -4
	RET
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        ; -- End function
	.ident	"clang version 24.0.0git (https://github.com/Licha-M/llvm-project-ISA32-LM.git 123c4b4feffc5a7ed210b88c5c369ff30f37d4d4)"
	.section	".note.GNU-stack","",@progbits
